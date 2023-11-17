Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989C37EEC23
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 07:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjKQGMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 01:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQGMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 01:12:06 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AE3196
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 22:12:01 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507b9408c61so2277067e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 22:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700201519; x=1700806319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzkIKBP1RSNSjcHa3ooQec7vnsT1BIreWgj3m6bqwkw=;
        b=E40KVoy+wl8VWruMa6ogYnW6/ltu2bikfls4hZO0b9hNul0P8uSvJ4kDttdJPVym81
         Iu5K6FGC4FaI9a6YlE0TqwOTvX19ChANf1+zIFLgWzPn5gWZwggqJttZJ5nqmmC+RFT7
         N7l5B8VmrhpEyJc+6BjeCbtquE7smsbi+zEiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700201519; x=1700806319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzkIKBP1RSNSjcHa3ooQec7vnsT1BIreWgj3m6bqwkw=;
        b=QXxMiYlfquPgyb9bqO3iYWIH+7Jp7VPWEz9P7tKG5aXgiQf5HReoHaqBUB8WliEq7i
         bgJO5xYivM4WUqZc1abuirp38rHXoYN+BU5dHaAh6t2IUJHfQbkvKcN+MEW2XMIiuPGw
         nes99mgK+5/bnxDMnbT1NN2ax9qCTw4qmqj5knQcVkZ45Ck5ko0wt202RSPPyB1+qGPY
         8YIkAe+kq0rvQmXcvJR8lWGd/aRtPem3jy75O9FxDZuRZvDXtIasVX/Afg1CsIl3xtwv
         7EYSkDVGNozeFXAyjvyBrW9caRhQFyNmbzG6PknRNw25nvyn/G+ws7j5CefTW0Y6YJ5W
         1wug==
X-Gm-Message-State: AOJu0YwTLdE+Tbw7ASaTLKoPuN90z8AcQhhIb6dkVoNOQHgsrbL+97HD
        JsSD6wFMes0SDhggR7BYThSI2QkYmtkCG+hwegSj0g==
X-Google-Smtp-Source: AGHT+IFbPm0GAk/S8jZWFqJiaxpI9RRydHhWmQXXbn39qHE7VNrw5ZxXw95aX6hOEaZc2PyZQeXNgpYfKQi/QvJmefo=
X-Received: by 2002:a05:6512:39c9:b0:50a:7640:6a7f with SMTP id
 k9-20020a05651239c900b0050a76406a7fmr15645335lfu.12.1700201519373; Thu, 16
 Nov 2023 22:11:59 -0800 (PST)
MIME-Version: 1.0
References: <20231116154816.70959-1-andrzej.p@collabora.com> <20231116154816.70959-4-andrzej.p@collabora.com>
In-Reply-To: <20231116154816.70959-4-andrzej.p@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Nov 2023 14:11:48 +0800
Message-ID: <CAGXv+5GhaF94ZRwrZ_CWg3j6bVYyEqZru9LM7ABDB29-cPhqSQ@mail.gmail.com>
Subject: Re: [RFC 3/6] media: verisilicon: Improve constant's name
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 11:48=E2=80=AFPM Andrzej Pietrasiewicz
<andrzej.p@collabora.com> wrote:
>
> For VP8 BIT(18) of this register is for enabling the boolean encoder.

Yes, but for H.264 it selects the entropy coding mode, 0 for CAVLC
and 1 for CABAC. You even add it back in the last patch. I'd do it
here, so you disambiguate the definition within one patch.

ChenYu


> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> ---
>  drivers/media/platform/verisilicon/hantro_h1_regs.h    | 2 +-
>  drivers/media/platform/verisilicon/hantro_h1_vp8_enc.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/verisilicon/hantro_h1_regs.h b/driver=
s/media/platform/verisilicon/hantro_h1_regs.h
> index 7752d1291c0e..c1c66c934a24 100644
> --- a/drivers/media/platform/verisilicon/hantro_h1_regs.h
> +++ b/drivers/media/platform/verisilicon/hantro_h1_regs.h
> @@ -70,7 +70,7 @@
>  #define    H1_REG_ENC_CTRL2_DISABLE_QUARTER_PIXMV      BIT(22)
>  #define    H1_REG_ENC_CTRL2_TRANS8X8_MODE_EN           BIT(21)
>  #define    H1_REG_ENC_CTRL2_CABAC_INIT_IDC(x)          ((x) << 19)
> -#define    H1_REG_ENC_CTRL2_ENTROPY_CODING_MODE                BIT(18)
> +#define    H1_REG_ENC_CTRL2_VP8_BOOLENC_ENABLE         BIT(18)
>  #define    H1_REG_ENC_CTRL2_H264_INTER4X4_MODE         BIT(17)
>  #define    H1_REG_ENC_CTRL2_H264_STREAM_MODE           BIT(16)
>  #define    H1_REG_ENC_CTRL2_INTRA16X16_MODE(x)         ((x))
> diff --git a/drivers/media/platform/verisilicon/hantro_h1_vp8_enc.c b/dri=
vers/media/platform/verisilicon/hantro_h1_vp8_enc.c
> index 05aa0dd9c09c..08c5079fbfd0 100644
> --- a/drivers/media/platform/verisilicon/hantro_h1_vp8_enc.c
> +++ b/drivers/media/platform/verisilicon/hantro_h1_vp8_enc.c
> @@ -1226,7 +1226,7 @@ static void hantro_h1_vp8_enc_set_params(struct han=
tro_dev *vpu, struct hantro_c
>         reg =3D 0;
>         if (mb_width * mb_height > MAX_MB_COUNT_TO_DISABLE_QUARTER_PIXEL_=
MV)
>                 reg =3D H1_REG_ENC_CTRL2_DISABLE_QUARTER_PIXMV;
> -       reg |=3D H1_REG_ENC_CTRL2_ENTROPY_CODING_MODE;
> +       reg |=3D H1_REG_ENC_CTRL2_VP8_BOOLENC_ENABLE;
>
>         inter_favor =3D 128 - ctx->vp8_enc.prob_intra;
>         if (inter_favor >=3D 0)
> --
> 2.25.1
>
>
