Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89BD7828D0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjHUMSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjHUMSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:18:02 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECAFCD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:18:00 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-48d0dbf4ec5so335367e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692620280; x=1693225080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKkqJ2D+VYmFpqgXIvrMOHKS8idoVbV815zLuujvJZs=;
        b=YIqtFhVFWX+SbtXg0CB8V/ecOt3HTYUkL+zNlaUq4xauI4O5ombFF+UXPYh1xKAnwv
         hX5Hoi0c7nRk2vchMn9FY12TS4FQWDLbTOGSYhSfIBWOia/7C0vefYOp0MeOsvTC1FBE
         twXBWQMqAcVXPO/vH8p9AgDVV/1dx4BL76Hw1C3C5ahwMFrOvvDIpYT0C3azLL6cV2cD
         /ImBXm/iM7QOFvAFhzZSAozkd+FRNa4nTPSsYpFJGlaxkW2mQGe5k/e0NQuQt6yfwj7J
         s0Bp+q1gGnKh1Awvf3dogVd8jWadEjDAEbMN+iVH1mHcglBjv0kMnF/gE06YNcNLoJZR
         RfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692620280; x=1693225080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKkqJ2D+VYmFpqgXIvrMOHKS8idoVbV815zLuujvJZs=;
        b=Rvwis3DVxpn4h9RV3igDQkzjH4lOpcbldLvu45qAuwHpRK8HM2IIkcwvUjbczT/iV/
         F5EprnCXxh4L0klfgW2yh9YXbZwY0WRLkcELSUhF3iuK6vYeEUCOS4XDiWCeCO/QcBk6
         hR2GpeWYv20qZnmyt1iUN338okyW74DL2bSRFaV9DOJSatofEDQLsIKAhPiwFOHrqju0
         kPegJKtlM/Vp5dOj4k8uBiZ1oqzQrjmiZr+CO4nyE6hHj48EgP2v80ioWj4GoYZ1zMTB
         Qj1HwHc1z1fgI+fLpoTNRH0No79gz94aq4KEE3lsIrS751w5Cd+jhO4GMRDAQcS96pX1
         dENQ==
X-Gm-Message-State: AOJu0Yz1fCafdwJJp5p6M6LteVIudoTQgeAyTS+uk5OtBN3YhnVAd+hZ
        rLAzMlI8I6WNNb8pK2bufvbSMY1sUF/ZD4Tu7+C0/A==
X-Google-Smtp-Source: AGHT+IGcqJGwYRyNganLabVsKBovtI5E+Kj3jh5UkDOLGsB5Bm8B/LZ1IeAgNEscpo/ZIn2ODYoBy019wgMqpbrTk08=
X-Received: by 2002:a67:eb06:0:b0:44d:5298:5bfc with SMTP id
 a6-20020a67eb06000000b0044d52985bfcmr902841vso.17.1692620279900; Mon, 21 Aug
 2023 05:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230506085928.933737-1-haibo.chen@nxp.com> <DB7PR04MB40102AA686099ED666C93EF5901EA@DB7PR04MB4010.eurprd04.prod.outlook.com>
 <CACRpkdZ-2Lyk_c8EJfS=YHK81wt2RAWnZAg+vxvZZijYFwmDDA@mail.gmail.com>
 <12270129.O9o76ZdvQC@steina-w> <CACRpkdZc8H=bnTfLjUzMS3zEWGTZdHbSuBz0yf_wdfp9MkNnkQ@mail.gmail.com>
In-Reply-To: <CACRpkdZc8H=bnTfLjUzMS3zEWGTZdHbSuBz0yf_wdfp9MkNnkQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 21 Aug 2023 14:17:48 +0200
Message-ID: <CAMRc=MfBDBrd1C9tOUcu_+eocB-xXt26fBDLSUNFyos2d6E15w@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: mxc: switch to dynamic allocat GPIO base
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Bough Chen <haibo.chen@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 12:21=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> On Mon, Aug 21, 2023 at 9:44=E2=80=AFAM Alexander Stein
> <alexander.stein@ew.tq-group.com> wrote:
> > Am Montag, 21. August 2023, 09:25:54 CEST schrieb Linus Walleij:
> > > On Mon, Aug 21, 2023 at 4:47=E2=80=AFAM Bough Chen <haibo.chen@nxp.co=
m> wrote:> > Hi
> > Linus and Bartosz,
> > > >
> > > > For this patch, still not in the main trunk (Linux 6.5-rc7) and
> > > > linux-next(next-20230818). Can you help apply or any comment?
> > >
> > > As pointed out by Bartosz you cannot just mechanically switch the bas=
e
> > > to -1.
> > >
> > > You also need to convince us that this doesn't break any systems, and=
 if
> > > it does, fix them so they don't break before submitting this patch.
> >
> > I think it's hard to tell if something breaks, this driver is used in a=
 lot of
> > boards. AFAIR some people are relying on the assumption of fixed order.=
 Using
> > dynamic allocation this not ensured. A possible fix is to use aliases [=
1].
>
> Hm I might have been to grumpy!
>
> It looks like any boardfiles using gpio-mxc have been eliminated
> so this driver is now only used in device tree-boots? Right?
>
> Then I feel a lot better about it.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij

I will not be queueing it for v6.6 as merge window opens in a week, I
want to give it more time in next and see if anyone complains so it'll
make it for v6.7.

Bart
