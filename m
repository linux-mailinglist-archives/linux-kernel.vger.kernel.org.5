Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B1C7AD35F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjIYIbv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Sep 2023 04:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjIYIbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:31:50 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AF3D3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:31:43 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-579de633419so69876887b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695630702; x=1696235502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vB1LBu4o6bMIXucGS6mAqjqjGGW52MUcUdGXILWOzEw=;
        b=TDO22XGbJZ2kyw/zmsPVLviuE+2rZgacKrTseRf72lDThukfULhYw2Jc1jzlc1qIoi
         xq4Uz3NDYlSZUae0rTYtRP+G0IYVqgiRqLuOXdXdsnlX+EwCQIRPS/fGvm97U26N0udA
         Z5iNNl0axDSm23mqy9eUPGf85Nuq3PpyJlcPnZNKWeTo4IZTF9xU3qQSQ/n9yxIJepbP
         1EOJb8jQGBzxaxsK91scrQ5ccNwuDwj6bNfI1U76XPYt+ShtbZUUX5ie4OK3sngWB4fd
         5PO7AXxPmWRLYehBMeuEGmAaVN3ntLehTcF4EbW0NvLd6IO1uuxyuSEorDWzVN2J9svR
         VNFQ==
X-Gm-Message-State: AOJu0YyA2lNnEziqnmLxuk4yCUwm3b/Yd6/HOeEZdwj0LAZOan5QVXid
        ogbvGx5wygursYVBU4VulasH5vuO+bcQSA==
X-Google-Smtp-Source: AGHT+IGAp/qAkfAmxQC67N/+YoxR+i1QUvz9ugkYuvl+jq3o8Du68YZclDxzAEoqu4e+Ss2p8Vv7nQ==
X-Received: by 2002:a81:4e8a:0:b0:569:479f:6d7f with SMTP id c132-20020a814e8a000000b00569479f6d7fmr5445636ywb.43.1695630702183;
        Mon, 25 Sep 2023 01:31:42 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id c64-20020a0dc143000000b0059a34cfa2a5sm2260604ywd.67.2023.09.25.01.31.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 01:31:41 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-59bc956b029so69986677b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:31:41 -0700 (PDT)
X-Received: by 2002:a0d:c9c6:0:b0:586:e50:fb50 with SMTP id
 l189-20020a0dc9c6000000b005860e50fb50mr5106146ywd.28.1695630701614; Mon, 25
 Sep 2023 01:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230905021209.1412987-1-zhangshida@kylinos.cn>
 <20230920095248.GC13143@google.com> <CAMuHMdXVqLdWdbVKU+nj2=jVDyFh9gD6rvuTpjdQehjqTr56mw@mail.gmail.com>
 <20230925075620.GC9999@google.com>
In-Reply-To: <20230925075620.GC9999@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Sep 2023 10:31:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWnv4-qUjNCHOTNhJNkTT6mSWLQAJ9XSQ5RVesXK1W86w@mail.gmail.com>
Message-ID: <CAMuHMdWnv4-qUjNCHOTNhJNkTT6mSWLQAJ9XSQ5RVesXK1W86w@mail.gmail.com>
Subject: Re: [PATCH] mfd: cs42l43: fix defined but not used warnings
To:     Lee Jones <lee@kernel.org>
Cc:     zhangshida <starzhangzsd@gmail.com>, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn, k2ci <kernel-bot@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Mon, Sep 25, 2023 at 9:56 AM Lee Jones <lee@kernel.org> wrote:
> On Fri, 22 Sep 2023, Geert Uytterhoeven wrote:
> > On Wed, Sep 20, 2023 at 12:07 PM Lee Jones <lee@kernel.org> wrote:
> > > On Tue, 05 Sep 2023, zhangshida wrote:
> > > > From: Shida Zhang <zhangshida@kylinos.cn>
> > > >
> > > > Warnings were generated during compiling for functions like
> > > > cs42l43_*_{resume,suspend}:
> > > >
> > > > ../drivers/mfd/cs42l43.c:1138:12: error: ‘cs42l43_runtime_resume’ defined but not used [-Werror=unused-function]
> > > >  1138 | static int cs42l43_runtime_resume(struct device *dev)
> > > >       |            ^~~~~~~~~~~~~~~~~~~~~~
> > > > ../drivers/mfd/cs42l43.c:1124:12: error: ‘cs42l43_runtime_suspend’ defined but not used [-Werror=unused-function]
> > > >  1124 | static int cs42l43_runtime_suspend(struct device *dev)
> > > >       |            ^~~~~~~~~~~~~~~~~~~~~~~
> > > > ../drivers/mfd/cs42l43.c:1106:12: error: ‘cs42l43_resume’ defined but not used [-Werror=unused-function]
> > > >  1106 | static int cs42l43_resume(struct device *dev)
> > > >       |            ^~~~~~~~~~~~~~
> > > > ../drivers/mfd/cs42l43.c:1076:12: error: ‘cs42l43_suspend’ defined but not used [-Werror=unused-function]
> > > >  1076 | static int cs42l43_suspend(struct device *dev)
> > > >
> > > > Fix it by guarding it with CONFIG_PM/CONFIG_PM_SLEEP.
> > > >
> > > > Reported-by: k2ci <kernel-bot@kylinos.cn>
> > > > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > > > ---
> > > >  drivers/mfd/cs42l43.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
> > > > index 37b23e9bae82..e589a61c118d 100644
> > > > --- a/drivers/mfd/cs42l43.c
> > > > +++ b/drivers/mfd/cs42l43.c
> > > > @@ -1073,6 +1073,7 @@ void cs42l43_dev_remove(struct cs42l43 *cs42l43)
> > > >  }
> > > >  EXPORT_SYMBOL_NS_GPL(cs42l43_dev_remove, MFD_CS42L43);
> > > >
> > > > +#ifdef CONFIG_PM_SLEEP
> > > >  static int cs42l43_suspend(struct device *dev)
> > > >  {
> > > >       struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
> > > > @@ -1120,7 +1121,9 @@ static int cs42l43_resume(struct device *dev)
> > > >
> > > >       return 0;
> > > >  }
> > > > +#endif
> > > >
> > > > +#ifdef CONFIG_PM
> > > >  static int cs42l43_runtime_suspend(struct device *dev)
> > > >  {
> > > >       struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
> > > > @@ -1176,6 +1179,7 @@ static int cs42l43_runtime_resume(struct device *dev)
> > > >
> > > >       return ret;
> > > >  }
> > > > +#endif
> > > >
> > > >  EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) = {
> > > >       SET_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
> > >
> > > I see a bunch of drivers using PM helpers and not many of them are
> > > are being guarded by ugly #ifery.  Please find out what they're doing to
> > > solve the same issue and replicate that instead.
> > >
> > > Here's a really big hint:
> > >
> > >   `git log --oneline 02313a90095fb`
> >
> > And there's no need to create another fix, as a Good Old fix is
> > available (and still not upstream):
> > https://lore.kernel.org/all/20230822114914.340359-1-ckeepax@opensource.cirrus.com
>
> I beg to differ;
>
>   eb72d5207008d ("mfd: cs42l43: Use correct macro for new-style PM runtime ops")
>
> :)

Commit:     Linus Torvalds <torvalds@linux-foundation.org>
CommitDate: Sat Sep 23 11:10:23 2023 -0700

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
