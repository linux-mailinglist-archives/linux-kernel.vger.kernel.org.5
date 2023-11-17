Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779897EEC69
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 07:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjKQG4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 01:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQG4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 01:56:53 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76AE194
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 22:56:49 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5079f6efd64so2196223e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 22:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700204208; x=1700809008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T66xySD/6BWFxQMYfuVxdprtl5AUvCVORapS2X/UsjA=;
        b=E3SUpy7LUOCgDeGfqhGxUPiOdZRAtZP9FGwnozOGjKX5seNcFfKNwfK55tMwKjxebw
         iSXslerlw+gjznEzMA7Lf4QBIB8djAkAg+kMd1k+Zl0M5oJNxxjH93sp2pm0cG8bjukM
         mqyoheNlVrXGLACwEaCcdMX8tP/REQxWebTWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700204208; x=1700809008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T66xySD/6BWFxQMYfuVxdprtl5AUvCVORapS2X/UsjA=;
        b=D/7S7HjtVkGJ3WEaPm8JbOxYYR7Uu0LOje61/d/iW/0J0RMri7zCg0oW+9PK0pgz7f
         ONOnwM34X0Aa+8rbGAh74wm8QSaQnFwhNjRz0LMzTbNVaZe3Rcr7TNQg0K9+ajaK86sk
         epkFJcZtLmNWINXm3zwdUVBoFlvuJTK/L3IzZTSpIbIu9y2qmGG2BxzG8fu2+g0MIgu1
         0Fu5keOf3zZQtQt8XgnElj/igHuYql1dksE6zItVFG3TUhyFXdWaeOywM63BsEY4SvF/
         67mNwR1iLpS/9GeGrbPCNWouhGH002RDm7bPWZfhSQQKTeF+z35GIOF7vc/+oJ5bG8HV
         DWCA==
X-Gm-Message-State: AOJu0YxvD9UKUBntA06cEGbNP/XSxye1m+1ZCjFuqA9d4uLcJf75aFO0
        aE3FAvPyzBuCjs6edm7S6BDg16RxMvsw5peTY3vH2A==
X-Google-Smtp-Source: AGHT+IFglSCUhlR+oyIk3/8hEw9b1yf+H4f0nrHpnUuSq77qWRvZSkqp2vLBmJbn9Hw3jSSmXioHPYnOaZeT3dSXuhg=
X-Received: by 2002:ac2:4e0f:0:b0:50a:26b:6ddf with SMTP id
 e15-20020ac24e0f000000b0050a026b6ddfmr16092967lfr.63.1700204207777; Thu, 16
 Nov 2023 22:56:47 -0800 (PST)
MIME-Version: 1.0
References: <20231116154816.70959-1-andrzej.p@collabora.com> <20231116154816.70959-5-andrzej.p@collabora.com>
In-Reply-To: <20231116154816.70959-5-andrzej.p@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Nov 2023 14:56:36 +0800
Message-ID: <CAGXv+5Hag=-JqYAKOgNUyFSjuwBu6ij1Rsv1cp==duGjY8w42A@mail.gmail.com>
Subject: Re: [RFC 4/6] media: verisilicon: Update H1 register definitions
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 11:48=E2=80=AFPM Andrzej Pietrasiewicz
<andrzej.p@collabora.com> wrote:
>
> Add definition of register at offset 0x00c.
>
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> ---
>  drivers/media/platform/verisilicon/hantro_h1_regs.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/media/platform/verisilicon/hantro_h1_regs.h b/driver=
s/media/platform/verisilicon/hantro_h1_regs.h
> index c1c66c934a24..efb46da23eab 100644
> --- a/drivers/media/platform/verisilicon/hantro_h1_regs.h
> +++ b/drivers/media/platform/verisilicon/hantro_h1_regs.h
> @@ -23,6 +23,15 @@
>  #define     H1_REG_AXI_CTRL_INPUT_SWAP32               BIT(2)
>  #define     H1_REG_AXI_CTRL_OUTPUT_SWAP8               BIT(1)
>  #define     H1_REG_AXI_CTRL_INPUT_SWAP8                        BIT(0)
> +#define H1_REG_DEVICE_CTRL                             0x00c
> +#define     H1_REG_DEVICE_CTRL_SCALE_OUTPUT_SWAP8      BIT(27)
> +#define     H1_REG_DEVICE_CTRL_SCALE_OUTPUT_SWAP16     BIT(26)
> +#define     H1_REG_DEVICE_CTRL_SCALE_OUTPUT_SWAP32     BIT(25)
> +#define     H1_REG_DEVICE_CTRL_MV_OUTPUT_SWAP8         BIT(24)
> +#define     H1_REG_DEVICE_CTRL_MV_OUTPUT_SWAP16                BIT(23)
> +#define     H1_REG_DEVICE_CTRL_MV_OUTPUT_SWAP32                BIT(22)
> +#define     H1_REG_DEVICE_CTRL_INPUT_READ_1MB          BIT(21)
> +#define     H1_REG_DEVICE_CTRL_AXI_DUAL_CHANNEL                BIT(20)

According to the i.MX8M Mini reference manual, this bit is a "disable"
control, i.e. setting this bit disables dual channel AXI. I think the
macro should explicitly state this in the naming, so something like
H1_REG_DEVICE_CTRL_DISABLE_AXI_DUAL_CH(ANNEL).

Other bits matches the reference manual.

>  #define H1_REG_ADDR_OUTPUT_STREAM                      0x014
>  #define H1_REG_ADDR_OUTPUT_CTRL                                0x018
>  #define H1_REG_ADDR_REF_LUMA                           0x01c
> --
> 2.25.1
>
>
