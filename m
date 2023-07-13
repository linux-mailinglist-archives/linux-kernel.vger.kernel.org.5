Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEA275254C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjGMOhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjGMOhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:37:19 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204781991
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:37:18 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b743161832so11888251fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689259036; x=1691851036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPi8Rde664k4OWrsk/yjT4y4yqazwgh3DlNB+1+OPRk=;
        b=0AQf6ugszcZPVHY7DwMOiA13w29AGJT5OPOCp2OF+zN86xFPJowoWVjL2xiRvqqsF4
         iRhdMPVvNexvHD9CqLBb8eCGnaaKkW4wpq53MqDi5jxJozA0WNMu8hOWmnOYernj/2IY
         bA11DqM9IxQv+R+PEm3OGM0M+gif2kxsEXVDNCcMwueZMbQsM4olsXNKpoxlDar+VA32
         Ly+ry+Ijehrjp3+zB0RYGXAUltkLzxTBJWwLGm9GOtvyE3WEU77BnO1o0I7xV1DLS2Vb
         tOhAxVRH6x/drXN9EfOv+1gRTFAlCncCJw7GD9Fz2KAjLUSEsihFKlsjacvPKmTEWOBJ
         eKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689259036; x=1691851036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPi8Rde664k4OWrsk/yjT4y4yqazwgh3DlNB+1+OPRk=;
        b=VwkdJjTVX48AY6FRXDyok8wE9egkg6H4EcS42Iw6Z6zRJKxlK9Nf/KSwvac5teVAj4
         RCDR5bRkxEt+6+ry7bJabutQjRZPMpAuhGYeT18OF8AXa+VA7+kRxIGECw3wi4nsSipt
         oTTvtcOzRJcYTR3iTpEnPFX+ft7Xctomd4pYaa9tMH8J0Sj3zOZQMi+qsVncntZAj+Kt
         JPc1pZ48yrPEYxkATCUFAjzOKUo2lhM+olEIf/hj2H0VhXDxpMv+2pY0YNmEw5LOAaDJ
         A5EQv/6u7EHhup+9SrZl8KMSZ7vfqgy+/f3V143KPk21MqSeRjMwNXcm4vuO3+qtBMBZ
         8R4g==
X-Gm-Message-State: ABy/qLbgWzE1p+gQa65YmtDMFaHRXaCqFtfoCmKW5WrWpSyzgYWZmqVf
        ovzGN2mefJejLjb3dIDy7PaaPK2vCOfJT3zORZpLjg==
X-Google-Smtp-Source: APBJJlGb+Hl5Ue9NsHUBSVMKchaqyoYb8Q3XGAg4ZgImreaHHxSMI8h/aNdlV3mV0Si2/cGZyFd6CFDg1CxrvDIwX2w=
X-Received: by 2002:a2e:9dd0:0:b0:2b6:df15:f6ad with SMTP id
 x16-20020a2e9dd0000000b002b6df15f6admr1529183ljj.18.1689259036279; Thu, 13
 Jul 2023 07:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <8b57db8d-1d3a-883e-eb8f-ddf15f19d823@gmail.com>
In-Reply-To: <8b57db8d-1d3a-883e-eb8f-ddf15f19d823@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 13 Jul 2023 16:37:04 +0200
Message-ID: <CAMRc=MdDmsUUwZqKFt6vMaL9iuRT-44XvLJrEbr9vZTxOJR1Mg@mail.gmail.com>
Subject: Re: [PATCH] mmc: davinci: Make SDIO irq truly optional
To:     Julien Delbergue <j.delbergue.foss@gmail.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 11:31=E2=80=AFAM Julien Delbergue
<j.delbergue.foss@gmail.com> wrote:
>
> The following error is printed on Logic PD's DA850 EVM:
>   davinci_mmc 1c40000.mmc: error -ENXIO: IRQ index 1 not found
>
> Depending on the board, the SDIO interrupt may not be present, so use
> the correct function to reflect that and prevent logging an error.
>
> Signed-off-by: Julien Delbergue <j.delbergue.foss@gmail.com>
> ---
>  drivers/mmc/host/davinci_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mm=
c.c
> index 7138dfa065bf..fb686c0d171c 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1257,7 +1257,7 @@ static int davinci_mmcsd_probe(struct platform_devi=
ce *pdev)
>
>         host->use_dma =3D use_dma;
>         host->mmc_irq =3D irq;
> -       host->sdio_irq =3D platform_get_irq(pdev, 1);
> +       host->sdio_irq =3D platform_get_irq_optional(pdev, 1);
>
>         if (host->use_dma) {
>                 ret =3D davinci_acquire_dma_channels(host);
> --
> 2.34.1

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
