Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E621B79DE06
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbjIMB6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjIMB6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:58:53 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D121710EB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 18:58:49 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-570a432468bso352932a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 18:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694570329; x=1695175129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWYBlc9fX+NrYYXcR1aoALLzzFrwI8piW2a3vusS9vc=;
        b=IcTR2+R4Y7hLGmLMteX9HfAOLb15Lzzx8LmCDsH6epQsyfvdb/68WT/Oquxk2cSywa
         3i+OLMJN3g3r47zr2VRp91EFi8KlCX1/4SSEz4BrDDjl6IeHDYNr9XRMwKVPeOxE45Ni
         +I4NpSPLXN9lI5WQC3N1VDcOkugqvMZwBEnbvAII/nDDj5DOlP9LyqZy7nL58Kg9Q5Ey
         w0hgaIBkq5NTVJtdeiWgmQu30+dSvudV1JY5TPEh6nQdYbXW4wqSD3tvw9jad/7q8b/p
         Gjny962LQCmjG1FmSIcs5ZEl46hOk/Ct2iqMnbGxQEfyKYJUwJ0t5m+/AxZnMQKZdVUV
         fsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694570329; x=1695175129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWYBlc9fX+NrYYXcR1aoALLzzFrwI8piW2a3vusS9vc=;
        b=FKp/FHXocmYG/fkI10mB2RGw119fQ0ASAITNWGr58K1aWp9FOqNe1z0jMxNJqiMXXT
         4PiA67V4X7VY3t3PNzpsS+U8rCHOCRTpQl0AV//b5D8NBB1SB+O6bShaXgP1M+IfTWI5
         t6mHWDMK3VahBR66xf9Ny3/fWDD79K0EVpHJEUG5XxdW9DJhkIBLDz8nZXCQRKrnwDLg
         jDb36pS5nlGyvsDWMt2NfWPHWTroeLuNuG1WhlV+Jj8mXhlQL7TsaXb78WRc13Hdaw5a
         bwfEMhKN1qrJ3XUuW5UJdwYaptaIOV7ImBtsWo4L/9Xd4+yAJ4WNJoZNbpmG9f5MjAdg
         8ArQ==
X-Gm-Message-State: AOJu0YxgbzGJcoyQrTOHUzhPDqD9DEBrYavkmu9OhyNqCvUT1uNAMo85
        eSVo8Gfcl0YkASrkwg8qn2M2QqZeB5Hru/OAAhU=
X-Google-Smtp-Source: AGHT+IHsPeAEi+Pt7uDHC/LSLO186AhqFY1MS7mJupHG/wYqca31PB6IIXjOpC7ed6FIDlsT7m27Br4CeepGA1g4R9g=
X-Received: by 2002:a17:90a:b790:b0:26b:36a4:feeb with SMTP id
 m16-20020a17090ab79000b0026b36a4feebmr5652532pjr.8.1694570329218; Tue, 12 Sep
 2023 18:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230912063329.2260360-1-chancel.liu@nxp.com>
In-Reply-To: <20230912063329.2260360-1-chancel.liu@nxp.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 13 Sep 2023 09:58:37 +0800
Message-ID: <CAA+D8APddGVWXEH7kmAeuwOyd9S-CcbOQcpo8NjeB4YRtU0+gg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: imx-rpmsg: Set ignore_pmdown_time for dai_link
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 2:34=E2=80=AFPM Chancel Liu <chancel.liu@nxp.com> w=
rote:
>
> i.MX rpmsg sound cards work on codec slave mode. MCLK will be disabled
> by CPU DAI driver in hw_free(). Some codec requires MCLK present at
> power up/down sequence. So need to set ignore_pmdown_time to power down
> codec immediately before MCLK is turned off.
>
> Take WM8962 as an example, if MCLK is disabled before DAPM power down
> playback stream, FIFO error will arise in WM8962 which will have bad
> impact on playback next.
>
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>  sound/soc/fsl/imx-rpmsg.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/sound/soc/fsl/imx-rpmsg.c b/sound/soc/fsl/imx-rpmsg.c
> index 3c7b95db2eac..d2ecd5e821b1 100644
> --- a/sound/soc/fsl/imx-rpmsg.c
> +++ b/sound/soc/fsl/imx-rpmsg.c
> @@ -89,6 +89,13 @@ static int imx_rpmsg_probe(struct platform_device *pde=
v)
>                             SND_SOC_DAIFMT_NB_NF |
>                             SND_SOC_DAIFMT_CBC_CFC;
>
> +       /* i.MX rpmsg sound cards work on codec slave mode. MCLK will be

Comments for multi line start from empty line with "/* "

Best regards
wang Shengjiu
> +        * disabled by CPU DAI driver in hw_free(). Some codec requires M=
CLK
> +        * present at power up/down sequence. So need to set ignore_pmdow=
n_time
> +        * to power down codec immediately before MCLK is turned off.
> +        */
> +       data->dai.ignore_pmdown_time =3D 1;
> +
>         /* Optional codec node */
>         ret =3D of_parse_phandle_with_fixed_args(np, "audio-codec", 0, 0,=
 &args);
>         if (ret) {
> --
> 2.25.1
>
