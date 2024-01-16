Return-Path: <linux-kernel+bounces-27230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0CA82EC77
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9238D1F2377C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C211B5B4;
	Tue, 16 Jan 2024 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B6r3wqC3"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512361774D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5ff4da9494cso6865197b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 01:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705399195; x=1706003995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n977xLZKtbxmqWIkeBAlyzycB8BQHRlez2+T0U3oZjg=;
        b=B6r3wqC3RvjP+dk5KX8xK/6FFIy0W5MmbozslMzz3QwG1bIkfQhnwmq4osDFHNyr+7
         jHa1lXfBNrI1JKZv0hQI6sRcohkiubozBT+FMy/hj32IIWyw1p4Ue5mJEwEa+zfElxwG
         o9QLOM+2bZ8r3H09NoSTgktJJy5iBulGbfyLkP8jLZPqQ5eZSvo/DE5scVf800G+bfnO
         cgjXl9UqMp2IczbJJ2pzj5lzNG5J1Agp6eOY4O9Sp2avYd+jkZiVyCdXGWPCt8ZRSyDk
         ftFMf68VyAG9dVs7m9s7CwmKlgz1m+jGpx2TrHnK+mT0ZZvLkKMnBJ33M7vrZbXTvx+T
         PehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705399195; x=1706003995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n977xLZKtbxmqWIkeBAlyzycB8BQHRlez2+T0U3oZjg=;
        b=AsC9ixRbd/Zz4w+g5Nesq9WjOvnQgg6TWJsrx0fYhK1AvMS2ezcs8eo/0sBI81eaxe
         JIaw8/qwlOPc2Yq39F/lyjn9FzaaWsKHbhVxllI71Xh81g29nfHU01kmo/aXU6+F8QoC
         S55DrdbBG6mWUU2g3oB2KVvj0k73X9U8ZpJi8JfHmlB45CjlmjC0hWBg/z8HY0u6CNda
         m9Rhb//pK9WeRW7tw4GrwXAwyz9yZTKn/0NQMOSaEb6I4bWR9yuW1TxBYZ5d2RclFUkI
         2FG56HN2PyKOyPwsn2Xv+SfRdQSdkuF2ZdhGZzDzGvYw6DEkf8xe/FIdN08oCKv2T6o2
         42Tw==
X-Gm-Message-State: AOJu0YyuUvoHsnf4qWQcAf0zkDfHObk+cuKlQTDU824h0hJ5yUy1QeiH
	r6oAmdfDqaudlQgcw+s6qKmTpe/JicJCWChRItP6kLnwfSMxHA==
X-Google-Smtp-Source: AGHT+IHTGKoEWWluMZDlCNLG9Lmvhz1txOmX0sES7QvTXTWHdQiwO7uEdOzPjmhAalPzyNROWI5FvO13Mrh41KGzZTA=
X-Received: by 2002:a81:4e42:0:b0:5ff:32a7:a31c with SMTP id
 c63-20020a814e42000000b005ff32a7a31cmr2405164ywb.89.1705399195341; Tue, 16
 Jan 2024 01:59:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116094935.9988-1-quic_riteshk@quicinc.com> <20240116094935.9988-2-quic_riteshk@quicinc.com>
In-Reply-To: <20240116094935.9988-2-quic_riteshk@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 16 Jan 2024 11:59:44 +0200
Message-ID: <CAA8EJpo3YS4EzfsLtovYKbLSGYX=RwUn9dpmCW=j257LnvPrgw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: defconfig: enable Novatek NT36672E DSI Panel driver
To: Ritesh Kumar <quic_riteshk@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, quic_bjorande@quicinc.com, 
	geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org, 
	nfraprado@collabora.com, m.szyprowski@samsung.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	quic_abhinavk@quicinc.com, quic_rajeevny@quicinc.com, 
	quic_vproddut@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jan 2024 at 11:49, Ritesh Kumar <quic_riteshk@quicinc.com> wrote:
>
> Build the Novatek NT36672E DSI Panel driver as module.

.. because it is used on ....

>
> Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 361c31b5d064..028d80be95f6 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -859,6 +859,7 @@ CONFIG_DRM_PANEL_LVDS=m
>  CONFIG_DRM_PANEL_SIMPLE=m
>  CONFIG_DRM_PANEL_EDP=m
>  CONFIG_DRM_PANEL_ILITEK_ILI9882T=m
> +CONFIG_DRM_PANEL_NOVATEK_NT36672E=m
>  CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
>  CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
>  CONFIG_DRM_PANEL_SITRONIX_ST7703=m
> --
> 2.17.1
>


-- 
With best wishes
Dmitry

