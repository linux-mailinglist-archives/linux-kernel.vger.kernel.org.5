Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FA076B700
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjHAOPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjHAOPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:15:31 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AB0BF;
        Tue,  1 Aug 2023 07:15:25 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so14413178a12.0;
        Tue, 01 Aug 2023 07:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690899324; x=1691504124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5wcObMxzRxgJ/VGkUZYGz4Wsi7oqPu6vEBYDrbZUZY=;
        b=q9RCquidQw67B2U7NV0lUR3RLSgvUdXx4mxan8WfH2/O9eZwsXL0bb1PGVAvYsxwnp
         06M0pK1KK8u8zta9fnO88ZYgHMAO7KGAxVIrcdaHAEVSyWv0qiywWjMKoBH6w3jOCIEr
         WK2NVGFvFF5rQGSPakaNAHtu60j0MPF4TbUvVPOwTPZ4cQMeYni54zHK6GKbWETrEuAm
         i+FGO/azI+j2M6O6eyNx2KH8lZblsHQWg7zAyqy8Q/Df7OR9+9+IDohM3w2ml6RMZsyD
         liKDKUJgQQoTkbo/+tDmoAhDISUOswqX96AemW3CV8vny1Le1XQT2CdNRhzzYtaawU06
         AmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690899324; x=1691504124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5wcObMxzRxgJ/VGkUZYGz4Wsi7oqPu6vEBYDrbZUZY=;
        b=Wabint4bv31inXRJEnAZzso5/5OeiuyCiIQBBiOfyKGlPUw41uZhSna6H1k1QrDmQI
         3dxMHtw9kDDVnoPACEvL02gC9kGypjrMfNY1lkmqJJYIdzclQlfXRHdDmWc1bhAKOs/B
         8f2LtP/zwMIOOVaVfs+XZdX4DS+g1mgsuZOVjU1O5i++JQWig9AzeWDs0yM+2WmhV9ZO
         jRC3O2Ffqa6jwB6ruiVdsA+8ZQaeT+0t94iMQT9ybQEdLsvCwRkZd98tmt473WwvNTWE
         2wyhNjZETtSc/fq3P0x+t2504X2reuGlmqmlC+34Mr1n35l2JS779bRracM5rCitNhoB
         egjA==
X-Gm-Message-State: ABy/qLZ0LZmKpfpHyL4pnHGwn6pmODa994ov25pc6CbftcKHwPBM1WpO
        WRlnpZ32ror4jj5s9Z0L1HvJUlfkOS4Uz+yK2rw=
X-Google-Smtp-Source: APBJJlEiW7hEWKS0AOx5RN387hGF4qaTWWByX/+/lv6OzQgkUgUaVOdvPTiZdaS48r4jh/JdMc5HjLdpR7IqvxcQCu8=
X-Received: by 2002:a05:6402:517a:b0:522:582c:f427 with SMTP id
 d26-20020a056402517a00b00522582cf427mr3659632ede.14.1690899324010; Tue, 01
 Aug 2023 07:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com> <1690265540-25999-6-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1690265540-25999-6-git-send-email-shengjiu.wang@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 1 Aug 2023 17:15:12 +0300
Message-ID: <CAEnQRZBAde4t5V2HCvCQfVwVYaQPhzJ-t3hzePjueyTONEim=w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/7] media: imx: fsl_asrc: Add memory to memory driver
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 10:31=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp.c=
om> wrote:
>
> Implement the ASRC memory to memory function using
> the v4l2 framework, user can use this function with
> v4l2 ioctl interface.
>
> User send the output and capture buffer to driver and
> driver store the converted data to the capture buffer.
>
> This feature can be shared by ASRC and EASRC drivers
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/media/platform/nxp/Kconfig        |  12 +
>  drivers/media/platform/nxp/Makefile       |   1 +
>  drivers/media/platform/nxp/fsl_asrc_m2m.c | 962 ++++++++++++++++++++++
>  include/sound/fsl_asrc_common.h           |   9 +
>  4 files changed, 984 insertions(+)
>  create mode 100644 drivers/media/platform/nxp/fsl_asrc_m2m.c
>
> diff --git a/drivers/media/platform/nxp/Kconfig b/drivers/media/platform/=
nxp/Kconfig
> index a0ca6b297fb8..359f11fe2a80 100644
> --- a/drivers/media/platform/nxp/Kconfig
> +++ b/drivers/media/platform/nxp/Kconfig
> @@ -56,3 +56,15 @@ config VIDEO_MX2_EMMAPRP
>
>  source "drivers/media/platform/nxp/dw100/Kconfig"
>  source "drivers/media/platform/nxp/imx-jpeg/Kconfig"
> +
> +config VIDEO_FSL_ASRC_M2M
> +       tristate "MXP i.MX ASRC M2M support"

s/MXP/NXP


> +       depends on V4L_MEM2MEM_DRIVERS
> +       depends on MEDIA_SUPPORT
> +       select VIDEOBUF2_DMA_CONTIG
> +       select V4L2_MEM2MEM_DEV
> +       help
> +           Say Y if you want to add ASRC M2M support for NXP CPUs.
> +           It is a completement for ASRC M2P and ASRC P2M features.

Complement for?
