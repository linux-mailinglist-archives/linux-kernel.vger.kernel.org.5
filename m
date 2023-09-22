Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B1D7AAA35
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjIVH1E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 22 Sep 2023 03:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjIVH07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:26:59 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14B3180
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:26:52 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50336768615so3173237e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695367609; x=1695972409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXsd1b2HRQxm3wtxgsmQVAMbBcD1igw/pC47NjUT4mc=;
        b=uyRyhNu1rwll2fj/pvdCy1iusAlglrGq84TlV6GPHKmtOgYlCS8GIoHoip12oPxaRl
         opa3Calf6iwkQ1h2MhEdq312Ustp3uGu+HTKsNNSF0vPovhdijU1gY3QaMjlsqiviwbr
         6VEoT4l55O6WAjVEEkK9TGts1Qgn767DCeTNjvowWJcSoRRsnJ3u5mG6y7ZqjndJtIlp
         oLiruneQPmBCEqB9DNQpXGbar1PGtlqac+vK+rZNmlLTebJH/yp0lWAxfG1XoQAxCxXS
         fvBQlqQvbnWv9c6WRBdIO4f9AVOfTrzxQNjn+QxH6Vmwyg2NbZbrmT3T3mrl+7JcPHu5
         gJhg==
X-Gm-Message-State: AOJu0Yy6CE9SJ/P4PIBRKqqF+mBgJM1Q5J0kSv9Xwt8H26HDu3O4EcpJ
        VEi5M+uNuAUEApzKxxpdiDqLBAYb/KbOrz4u
X-Google-Smtp-Source: AGHT+IGdAqGwPHe5zO6caUMy23XYhRVY51R3Q0ET3uRKLJoRuWjjpWcjmcn/BG9qAFtC0KNB8FiS6g==
X-Received: by 2002:a05:6512:783:b0:503:31dc:7d64 with SMTP id x3-20020a056512078300b0050331dc7d64mr6952224lfr.21.1695367608568;
        Fri, 22 Sep 2023 00:26:48 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id e2-20020ac25462000000b005032eaf1781sm619653lfn.203.2023.09.22.00.26.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 00:26:48 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2c038a1e2e6so28066911fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:26:48 -0700 (PDT)
X-Received: by 2002:a2e:2e15:0:b0:2bd:1f81:fc47 with SMTP id
 u21-20020a2e2e15000000b002bd1f81fc47mr7929173lju.22.1695367608089; Fri, 22
 Sep 2023 00:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230905021209.1412987-1-zhangshida@kylinos.cn> <20230920095248.GC13143@google.com>
In-Reply-To: <20230920095248.GC13143@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Sep 2023 09:26:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXVqLdWdbVKU+nj2=jVDyFh9gD6rvuTpjdQehjqTr56mw@mail.gmail.com>
Message-ID: <CAMuHMdXVqLdWdbVKU+nj2=jVDyFh9gD6rvuTpjdQehjqTr56mw@mail.gmail.com>
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

On Wed, Sep 20, 2023 at 12:07 PM Lee Jones <lee@kernel.org> wrote:
> On Tue, 05 Sep 2023, zhangshida wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Warnings were generated during compiling for functions like
> > cs42l43_*_{resume,suspend}:
> >
> > ../drivers/mfd/cs42l43.c:1138:12: error: ‘cs42l43_runtime_resume’ defined but not used [-Werror=unused-function]
> >  1138 | static int cs42l43_runtime_resume(struct device *dev)
> >       |            ^~~~~~~~~~~~~~~~~~~~~~
> > ../drivers/mfd/cs42l43.c:1124:12: error: ‘cs42l43_runtime_suspend’ defined but not used [-Werror=unused-function]
> >  1124 | static int cs42l43_runtime_suspend(struct device *dev)
> >       |            ^~~~~~~~~~~~~~~~~~~~~~~
> > ../drivers/mfd/cs42l43.c:1106:12: error: ‘cs42l43_resume’ defined but not used [-Werror=unused-function]
> >  1106 | static int cs42l43_resume(struct device *dev)
> >       |            ^~~~~~~~~~~~~~
> > ../drivers/mfd/cs42l43.c:1076:12: error: ‘cs42l43_suspend’ defined but not used [-Werror=unused-function]
> >  1076 | static int cs42l43_suspend(struct device *dev)
> >
> > Fix it by guarding it with CONFIG_PM/CONFIG_PM_SLEEP.
> >
> > Reported-by: k2ci <kernel-bot@kylinos.cn>
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> >  drivers/mfd/cs42l43.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
> > index 37b23e9bae82..e589a61c118d 100644
> > --- a/drivers/mfd/cs42l43.c
> > +++ b/drivers/mfd/cs42l43.c
> > @@ -1073,6 +1073,7 @@ void cs42l43_dev_remove(struct cs42l43 *cs42l43)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cs42l43_dev_remove, MFD_CS42L43);
> >
> > +#ifdef CONFIG_PM_SLEEP
> >  static int cs42l43_suspend(struct device *dev)
> >  {
> >       struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
> > @@ -1120,7 +1121,9 @@ static int cs42l43_resume(struct device *dev)
> >
> >       return 0;
> >  }
> > +#endif
> >
> > +#ifdef CONFIG_PM
> >  static int cs42l43_runtime_suspend(struct device *dev)
> >  {
> >       struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
> > @@ -1176,6 +1179,7 @@ static int cs42l43_runtime_resume(struct device *dev)
> >
> >       return ret;
> >  }
> > +#endif
> >
> >  EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) = {
> >       SET_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
>
> I see a bunch of drivers using PM helpers and not many of them are
> are being guarded by ugly #ifery.  Please find out what they're doing to
> solve the same issue and replicate that instead.
>
> Here's a really big hint:
>
>   `git log --oneline 02313a90095fb`

And there's no need to create another fix, as a Good Old fix is
available (and still not upstream):
https://lore.kernel.org/all/20230822114914.340359-1-ckeepax@opensource.cirrus.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
