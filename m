Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DB77CE51D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjJRRnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjJRRmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:42:44 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC517D56;
        Wed, 18 Oct 2023 10:42:08 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bd96cfb99cso3032440b3a.2;
        Wed, 18 Oct 2023 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697650928; x=1698255728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKaWOPnAN5si+yKYBlPOMxbvgqGw6FhfRCUPuhXRLW4=;
        b=DJ2Flso8Fhadvkiy9PtnH9bJCHhUqGXXhJZQR3Wp4lnxs78jHryj6CaczQkQucQJws
         8PeAkB7ushmkG6WMxnPBo6xX5NA8iarpJmQUneL3PxIlaMtG+Fu0u8doIgbOWEjt39hw
         d89td4OuQjaWZdgevRP3Eji4L0NNqF2sXwGG5Oj/r1tTPyULiL0G4/Cl2KH+JbXPATOb
         p8WIcgeEYqU1+GFu4Lz6cWxVoSuObaFKpkGPqOqJTPZwPfObSTmpPkKw6PsU6pUKQQQN
         fB76JWOsaQHRI+3rIQPZx7d8WBNuNx2YXt8OJdIdGmrJdCmnha5Hz9FQpt4l5sFj31T0
         /yrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697650928; x=1698255728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKaWOPnAN5si+yKYBlPOMxbvgqGw6FhfRCUPuhXRLW4=;
        b=RZ9OT9IeY64ArMVSrfwryDdzgfcTa8fC2Ymri3yDYccV1yYzsC4Lq7BWxy0NonvZgp
         i+11OLsw+7kqLAd9FdcU6ZGi5shKD0m9Sqlngx+298OJIqw/2lPqCI1KwIFJv8gnsEok
         C2uw5VLU0khsLdKI5oRxulksmMUfSPs9S3nyIR0va3YoMpCV+h7QIclAq9uHSJAa362P
         NEjI9wlsweas0SLgSSX3C6OGh+XGit7wBbi/THiPt44DdNEEQmgcgKfjmNMqSqDY3C/t
         Nv2xj/foFQGe9Hgvi41Q/7W2/lqHrc6gqdaPKwhzmRF/G/Amnt2nBREm+3mBXzciTymz
         B3pw==
X-Gm-Message-State: AOJu0YwRcEOAEAXZ2xDYe68aNkZeb5ki4fjiPG9KJwb6Y9YKoZQBqNdU
        dSVCFC4sYnltlgxycCKBdIzjJabkB17bFW5RSJyfKYjs
X-Google-Smtp-Source: AGHT+IEjXdG0uazktIdJ2eY6IhbN0NzOFSm9EJCpnpHhp0AWWgfdJLWXmtsXSGCki65me2aNbLPA8vfrpKQqWto4VAA=
X-Received: by 2002:a05:6a21:7906:b0:16b:d137:de5a with SMTP id
 bg6-20020a056a21790600b0016bd137de5amr5314040pzc.28.1697650928075; Wed, 18
 Oct 2023 10:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com> <20221118093931.1284465-5-paul.elder@ideasonboard.com>
In-Reply-To: <20221118093931.1284465-5-paul.elder@ideasonboard.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 18 Oct 2023 12:41:56 -0500
Message-ID: <CAHCN7xJcKw5RRS0siyYEwJws049YFkh-zkyRQJsb8dgiLVoh3A@mail.gmail.com>
Subject: Re: [PATCH v3 04/14] media: rkisp1: Add match data for i.MX8MP ISP
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 3:44=E2=80=AFAM Paul Elder <paul.elder@ideasonboard=
.com> wrote:
>
> Add match data to the rkisp1 driver to match the i.MX8MP ISP.
>
> Although the new version number isn't very precise, it ought to be fine
> as the other version numbers aren't precise either, and we have separate
> feature flags for important version-specific features. Despite this
> version number being seemingly unimportant, it is added to distinguish
> it from the ISP versions integrated in rockchip SoCs.
>
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
>

Paul,

It's been nearly a year since this commit was sent.  I noticed it
hasn't been applied, and I was curious to know if there is any
movement here?  I'm happy to test on my 8MP if necessary.

Thanks!

adam

> ---
> Changes in v3:
> - Remove todo for improving the version number
> - Expand the commit message to address the version number
> ---
>  .../platform/rockchip/rkisp1/rkisp1-dev.c     | 22 +++++++++++++++++++
>  include/uapi/linux/rkisp1-config.h            |  2 ++
>  2 files changed, 24 insertions(+)
>
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/driver=
s/media/platform/rockchip/rkisp1/rkisp1-dev.c
> index e348d8c86861..69464ce91d59 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -496,6 +496,24 @@ static const struct rkisp1_info rk3399_isp_info =3D =
{
>         .features =3D RKISP1_FEATURE_MIPI_CSI2,
>  };
>
> +static const char * const imx8mp_isp_clks[] =3D {
> +       "isp",
> +       "hclk",
> +       "aclk",
> +};
> +
> +static const struct rkisp1_isr_data imx8mp_isp_isrs[] =3D {
> +       { NULL, rkisp1_isr },
> +};
> +
> +static const struct rkisp1_info imx8mp_isp_info =3D {
> +       .clks =3D imx8mp_isp_clks,
> +       .clk_size =3D ARRAY_SIZE(imx8mp_isp_clks),
> +       .isrs =3D imx8mp_isp_isrs,
> +       .isr_size =3D ARRAY_SIZE(imx8mp_isp_isrs),
> +       .isp_ver =3D IMX8MP_V10,
> +};
> +
>  static const struct of_device_id rkisp1_of_match[] =3D {
>         {
>                 .compatible =3D "rockchip,px30-cif-isp",
> @@ -505,6 +523,10 @@ static const struct of_device_id rkisp1_of_match[] =
=3D {
>                 .compatible =3D "rockchip,rk3399-cif-isp",
>                 .data =3D &rk3399_isp_info,
>         },
> +       {
> +               .compatible =3D "fsl,imx8mp-isp",
> +               .data =3D &imx8mp_isp_info,
> +       },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, rkisp1_of_match);
> diff --git a/include/uapi/linux/rkisp1-config.h b/include/uapi/linux/rkis=
p1-config.h
> index 730673ecc63d..f602442c2018 100644
> --- a/include/uapi/linux/rkisp1-config.h
> +++ b/include/uapi/linux/rkisp1-config.h
> @@ -179,12 +179,14 @@
>   * @RKISP1_V11: declared in the original vendor code, but not used
>   * @RKISP1_V12: used at least in rk3326 and px30
>   * @RKISP1_V13: used at least in rk1808
> + * @IMX8MP_V10: used in at least imx8mp
>   */
>  enum rkisp1_cif_isp_version {
>         RKISP1_V10 =3D 10,
>         RKISP1_V11,
>         RKISP1_V12,
>         RKISP1_V13,
> +       IMX8MP_V10,
>  };
>
>  enum rkisp1_cif_isp_histogram_mode {
> --
> 2.35.1
>
