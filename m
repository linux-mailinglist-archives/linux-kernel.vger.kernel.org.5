Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727127A9109
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjIUCrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIUCrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:47:35 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0831CCF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:47:28 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41517088479so7757321cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695264448; x=1695869248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0k9rI/DID17BfqmGl6gkqlhbGqs6PLjj06aCWcUcUCE=;
        b=d0pEkmb1Y6AGbg9kw6VOwRHV1Y4+RrZu5AFc3wX3MpBRyA039bOw9Sb8DXX0LA8ghd
         oib8BNmgtFOkNKiM16FnG3ragVlXnARz2QBxl51SyCRf1/plca/RSaIEH/kZjP6hgbdz
         7ahhgkCnR3TuiATiNUrZELWNSCTaVFkvCtJr+7DGmC1h/oa1MOAtBgQgoKofkkXKQG4v
         KKwSa4jebYxZan7neD0wmX+AevbpIcLxgJ466W2+4y58w7iF7tq790wrZ3yaldn0qat5
         /NyjB8aD9Cp3y7uHDzjFpzfX7J3NDpMYrXloauJYjy6RAzUvGyGMaQz4vEQ81Q8jz6cH
         EbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695264448; x=1695869248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0k9rI/DID17BfqmGl6gkqlhbGqs6PLjj06aCWcUcUCE=;
        b=TdPFu3kBPNsPIgv2HbxLxCkIfwr2lPCy/yTw5SZwUj72/D51ElA07xTwZbZHRdMyly
         3VQ6Oyo97GxpFUmt1qe3hbLMP9DSuu6zh2VEGOag0KKdLpWMr8M9j+JOk1Kqst3EJDI3
         +U5fJYjT6kIxlOsI0TCPNY4EUP3pPiKo/gbAwzbyaB0emIFQzpsw+NpinJOgiMvP0FWe
         YgtvwB83Geleq+BTFYBgnfF2O9MFwLhI85vhvFc6WHhF5RrK1XuVSVHk2HVoa9GqXL3/
         2Dh0eNxdFd9ycknRPDS1tml/CCZQ7f/k5WXKhWlNmhWO9etK1tsBSk/XiMkiRF2c4h59
         aNNA==
X-Gm-Message-State: AOJu0YxRQRyGWwLGFbPCKu3k/thxwjJYUHOw1SDQJb9g4PrwTgTM2XEy
        jSW72TC+XYccxsH8bIO0+UeaPfc5pbo7WCrW9pDZ5lDNJDYkXw==
X-Google-Smtp-Source: AGHT+IFEy+wKz1VAep+l4D59PHquuI5yXDMURmMmNSMl3qHfB869Oaik/T8JuVIuBjV021/OQKmcAWuS0/meT5PC3Jw=
X-Received: by 2002:ac8:4e8d:0:b0:412:2dac:acca with SMTP id
 13-20020ac84e8d000000b004122dacaccamr6250737qtp.4.1695264447894; Wed, 20 Sep
 2023 19:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230905021209.1412987-1-zhangshida@kylinos.cn> <20230920095248.GC13143@google.com>
In-Reply-To: <20230920095248.GC13143@google.com>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Thu, 21 Sep 2023 10:46:52 +0800
Message-ID: <CANubcdVuiBciEQu14hOUvgSYo2+1okQ4ed-tJJa5Xo_3jieGzg@mail.gmail.com>
Subject: Re: [PATCH] mfd: cs42l43: fix defined but not used warnings
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, zhangshida@kylinos.cn,
        k2ci <kernel-bot@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee@kernel.org> =E4=BA=8E2023=E5=B9=B49=E6=9C=8820=E6=97=A5=E5=
=91=A8=E4=B8=89 17:52=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 05 Sep 2023, zhangshida wrote:
>
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Warnings were generated during compiling for functions like
> > cs42l43_*_{resume,suspend}:
> >
> > ../drivers/mfd/cs42l43.c:1138:12: error: =E2=80=98cs42l43_runtime_resum=
e=E2=80=99 defined but not used [-Werror=3Dunused-function]
> >  1138 | static int cs42l43_runtime_resume(struct device *dev)
> >       |            ^~~~~~~~~~~~~~~~~~~~~~
> > ../drivers/mfd/cs42l43.c:1124:12: error: =E2=80=98cs42l43_runtime_suspe=
nd=E2=80=99 defined but not used [-Werror=3Dunused-function]
> >  1124 | static int cs42l43_runtime_suspend(struct device *dev)
> >       |            ^~~~~~~~~~~~~~~~~~~~~~~
> > ../drivers/mfd/cs42l43.c:1106:12: error: =E2=80=98cs42l43_resume=E2=80=
=99 defined but not used [-Werror=3Dunused-function]
> >  1106 | static int cs42l43_resume(struct device *dev)
> >       |            ^~~~~~~~~~~~~~
> > ../drivers/mfd/cs42l43.c:1076:12: error: =E2=80=98cs42l43_suspend=E2=80=
=99 defined but not used [-Werror=3Dunused-function]
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
> >       struct cs42l43 *cs42l43 =3D dev_get_drvdata(dev);
> > @@ -1120,7 +1121,9 @@ static int cs42l43_resume(struct device *dev)
> >
> >       return 0;
> >  }
> > +#endif
> >
> > +#ifdef CONFIG_PM
> >  static int cs42l43_runtime_suspend(struct device *dev)
> >  {
> >       struct cs42l43 *cs42l43 =3D dev_get_drvdata(dev);
> > @@ -1176,6 +1179,7 @@ static int cs42l43_runtime_resume(struct device *=
dev)
> >
> >       return ret;
> >  }
> > +#endif
> >
> >  EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) =3D {
> >       SET_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
>
> I see a bunch of drivers using PM helpers and not many of them are
> are being guarded by ugly #ifery.  Please find out what they're doing to
> solve the same issue and replicate that instead.
>
> Here's a really big hint:
>
>   `git log --oneline 02313a90095fb`
>

Thanks, I've learned something from the hint.

And I also checked the code:
-----
EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) =3D {
        SET_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
        SET_RUNTIME_PM_OPS(cs42l43_runtime_suspend,
cs42l43_runtime_resume, NULL)
};
----
#ifdef CONFIG_PM_SLEEP
#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
        SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
#else
#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
#endif
----
#define SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
        .suspend =3D pm_sleep_ptr(suspend_fn), \
        .resume =3D pm_sleep_ptr(resume_fn), \
        .freeze =3D pm_sleep_ptr(suspend_fn), \
        .thaw =3D pm_sleep_ptr(resume_fn), \
        .poweroff =3D pm_sleep_ptr(suspend_fn), \
        .restore =3D pm_sleep_ptr(resume_fn),
----
The technique has already been used by the marcos, but it still
reports the defined-but-not-used warning.
Maybe some compilers still choose to compile these functions in...
Anyway, I will just leave it alone since it is really not a big problem...

Thanks,
Shida


> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
