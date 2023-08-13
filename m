Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D74177AAAF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 20:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjHMS6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 14:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHMS6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 14:58:43 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F080BBF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 11:58:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe0c566788so5597250e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 11:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1691953122; x=1692557922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbRMQLgn6q8vxhzEowCXC6DM0VIy22uIjp0J0FlZhHw=;
        b=mEZqOEzFE/NHDpIJnP+f47/xucTwmNrnya1FWJHPVprnNFpuerfe0PTM7FEVUY1eMw
         wfkq7myj4csEPiDqvJaRm1KHqZmGGATAB+0+jNoGlNI4qCPmJuRpO3tWgV3vNcUgm+Bf
         CuuJ5jGA+lAAw3IKAFw4npqGdwJbujzYEu4d6y6zYhYV+Iwdpr0HArrzYUpaJ8EkJDo0
         9JGxpKtO/W/ysympLiTnDg+sy87A7Kfoxgy6XhODa6oTCk+XqhxFkpoQr6p/sEHmB3lK
         wrJs5jPCUzjHntDOzh3meRkoCNPBtaOUwlrxdjstHx94D5a+W8LBnxSc5wyvgkUspT0G
         /6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691953122; x=1692557922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbRMQLgn6q8vxhzEowCXC6DM0VIy22uIjp0J0FlZhHw=;
        b=MjizyWzuxrNiLvMSjcvSFk32YS/YE+D1BbBVGSTAXYt6+j1Np57r6Gl2Zku1ht47Uz
         +0Xu921s6k/U3AUepFY4H+U0z12QDMm6eKNdRFlisvGSi4YIktkPIMzVd1fGd+bmW2xF
         0Ir7lNyLcUhKF1Olu3hyd0fn1cg9f+qX6qe1rll31vy5OzoZf1I5UWNqZdFzE/obD54W
         EH23Fhg+7iKD27OMp2fUJXvxRLFhhA3dLy/JhrXNEvrziudsBcZ5+OTpT4rPOQDGIXFc
         8C/YE85ZinECpAuwhpHI6kumgJiDAvDe5wxz/QR8CyTzpF+/Ddk0CWZMFPznqc9fHruL
         /9hw==
X-Gm-Message-State: AOJu0YxWS9O1413CVWkRD8xulkYjiSfKxkKwvE4M1+nXVWnRO8EvwV3e
        eSNIE1GeW+smVAyrlORyCffY6aEpsPiBmKEuxzz8fQ==
X-Google-Smtp-Source: AGHT+IEvpOk8ea7m2X3vZBrE0Ny9SDQyHNrazCNWd1S+UiFY+XEC89xad6T9d4vx8VCEZ/bYmPfek7fR6mdGzHzZntc=
X-Received: by 2002:a05:6512:a8d:b0:4fb:748f:604e with SMTP id
 m13-20020a0565120a8d00b004fb748f604emr6617146lfu.36.1691953122076; Sun, 13
 Aug 2023 11:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230811194032.4240-1-aboutphysycs@gmail.com> <4850013.31r3eYUQgx@jernej-laptop>
In-Reply-To: <4850013.31r3eYUQgx@jernej-laptop>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Sun, 13 Aug 2023 21:58:31 +0300
Message-ID: <CAH3L5QoVd45nR9HmAkSKJh7EnVXr1Jx6wqQ9j=x0AtNdqGjDaA@mail.gmail.com>
Subject: Re: [PATCH] thermal: sun8i_thermal: remove unneeded call to platform_set_drvdata()
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Andrei Coardos <aboutphysycs@gmail.com>, samuel@sholland.org,
        wens@csie.org, rui.zhang@intel.com, amitk@kernel.org,
        daniel.lezcano@linaro.org, rafael@kernel.org,
        tiny.windzz@gmail.com, anarsoul@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 6:32=E2=80=AFPM Jernej =C5=A0krabec <jernej.skrabec=
@gmail.com> wrote:
>
> Dne petek, 11. avgust 2023 ob 21:40:32 CEST je Andrei Coardos napisal(a):
> > This function call was found to be unnecessary as there is no equivalen=
t
> > platform_get_drvdata() call to access the private data of the driver. A=
lso,
> > the private data is defined in this driver, so there is no risk of it b=
eing
> > accessed outside of this driver file.
> >
> > Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
>

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>

> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>
> Best regards,
> Jernej
>
> > ---
> >  drivers/thermal/sun8i_thermal.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/thermal/sun8i_thermal.c
> > b/drivers/thermal/sun8i_thermal.c index 195f3c5d0b38..61a2f287ac90 1006=
44
> > --- a/drivers/thermal/sun8i_thermal.c
> > +++ b/drivers/thermal/sun8i_thermal.c
> > @@ -489,8 +489,6 @@ static int sun8i_ths_probe(struct platform_device *=
pdev)
> > if (!tmdev->chip)
> >               return -EINVAL;
> >
> > -     platform_set_drvdata(pdev, tmdev);
> > -
> >       ret =3D sun8i_ths_resource_init(tmdev);
> >       if (ret)
> >               return ret;
>
>
>
>
