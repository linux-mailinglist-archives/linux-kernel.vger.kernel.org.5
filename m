Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFED79F97B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 06:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbjINEQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 00:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbjINEQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 00:16:24 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A23E69
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 21:16:20 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-577fb90bbebso129172a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 21:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694664980; x=1695269780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8puwwYQ2UBHFNT37XGmqgv1DiqsgZEnUlgOGxcY1CkI=;
        b=bCQo4MqY3N6wirLvwaV3zBRX34IxCP2kdzfZAscz/IeqgqdHtWpnix5LYUzK7QNde6
         5YZRp6TTWLnZnZIE5CMHO8r7uqjtcdKi25t7FaEsM53s0xCPkEtieqa1XaOMWR9N/QVC
         98EW/sYGzJx1Foh7eOWqSYMPDMNWL1pBgnWA3xf9W6c9hu34yLcjX3+Z7dihG8P7x4xc
         MuFuFN9UXyaXHNwovK6gBEnV1QgaiujFShaWH7ADzBH0IW/3OItXaEcyzIC61BCF6Wpt
         LiAk8z+XeXov9+NVWEYJCe2CXhAoNCvU1yIcRYQm/Idv5tgn7gCFyNSqDpthZ25bxWB8
         2iQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694664980; x=1695269780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8puwwYQ2UBHFNT37XGmqgv1DiqsgZEnUlgOGxcY1CkI=;
        b=bYVmYP4E+/rdVJFScJYJfrr9FHaP0v3Bue1LJ06WYGeXuO2mJmK5IYy7w0bFom8m5G
         1JsHFCE2BE8gRem+J0WejCLwk2p25cy1GKBUBeHDEt/GBHU72ORxc/Us/H4YmlcNg0aJ
         FbgQKdAV40Yrrf6VU4O3JfLwa8Ng0TEB4yzUSxH1dPbj6qLuhmv/vzqiIDt3lOT+96hR
         +m4WK9DJpFJPIA/bIakGd8UHNUduJqsO7+jm/QoSsDwRC12S6ZQ2SzMog+vGV6vod9vG
         gF8NX8N+2LrSWH7XBjmLd4OIMkl7hiwrzop8KDXQVtHq6AGQSZQp3dFLeTK/badEbhni
         jHlw==
X-Gm-Message-State: AOJu0YxatVja/47G7yF+KlcRBcN9a5vungSCe7+F2teaEL5cx/Fklzij
        RM4Sdk5AcZ/Z99gYbNgmeMdF4mg71fT0gwXcv0U=
X-Google-Smtp-Source: AGHT+IG1H/excJAZALaS7Szk8UIlXc6WBaAkKS8RGfBe1uXqguojuCxZhqPLQuUcfrs4/2j7RKsHN6OjN5qPo+LU23U=
X-Received: by 2002:a05:6a21:4886:b0:13a:e955:d958 with SMTP id
 av6-20020a056a21488600b0013ae955d958mr4295356pzc.7.1694664979937; Wed, 13 Sep
 2023 21:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230913102656.2966757-1-chancel.liu@nxp.com>
In-Reply-To: <20230913102656.2966757-1-chancel.liu@nxp.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Thu, 14 Sep 2023 12:16:08 +0800
Message-ID: <CAA+D8ANDcxY_SZ0qNax7LvkJj_yaY5syzEc6RoOmxjYEut0NOw@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: imx-rpmsg: Set ignore_pmdown_time for dai_link
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

On Wed, Sep 13, 2023 at 6:27=E2=80=AFPM Chancel Liu <chancel.liu@nxp.com> w=
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

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Wang Shengjiu
> ---
>  sound/soc/fsl/imx-rpmsg.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/sound/soc/fsl/imx-rpmsg.c b/sound/soc/fsl/imx-rpmsg.c
> index 3c7b95db2eac..b578f9a32d7f 100644
> --- a/sound/soc/fsl/imx-rpmsg.c
> +++ b/sound/soc/fsl/imx-rpmsg.c
> @@ -89,6 +89,14 @@ static int imx_rpmsg_probe(struct platform_device *pde=
v)
>                             SND_SOC_DAIFMT_NB_NF |
>                             SND_SOC_DAIFMT_CBC_CFC;
>
> +       /*
> +        * i.MX rpmsg sound cards work on codec slave mode. MCLK will be
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
