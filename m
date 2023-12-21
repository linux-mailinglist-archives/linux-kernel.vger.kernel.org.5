Return-Path: <linux-kernel+bounces-8352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E60981B614
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5DD288408
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D92273167;
	Thu, 21 Dec 2023 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3wT1nIz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04671DDE3;
	Thu, 21 Dec 2023 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d13e4f7abso5696995e9.2;
        Thu, 21 Dec 2023 04:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703162445; x=1703767245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JWmqolZ/s9uaTTG3HahXfBKZE7l3nyr/50HE3h+LaaE=;
        b=U3wT1nIz5vl2m9aERtqReSZiASzHJRBRaeQzRukJ35aLDRRRCOHP8u7jrq+alk/GLx
         PDFQXeUMdLQZQuTzetzriyXnu1DptOe2ILVPQrDw2viCakIG+sA1Dy3EelscKDNWErDg
         stOs7b/lXw+1D7D896Ga93AN+NGReKIF2LHSVIbLDKfZjcSfzLdlmbdb+gfTqiHyS1f9
         gDeOCoLofRuZyiSoHogq+K+82IrGY49a6/hIPwAgdWYk6k1ctrcA8WHlgujxd/9hzxV+
         k/DTaF+UNwpS+9TlZvcDhmewpdHjWzEpGcINlps2VFNAmKGzXv82FojfmCVDA1kh87PX
         FnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703162445; x=1703767245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWmqolZ/s9uaTTG3HahXfBKZE7l3nyr/50HE3h+LaaE=;
        b=ojxA775DxfDvgbhqwLH6cj23ZsL4UVhQ/vj2MZPxQ+6OFoY4YZTA514izEsnLrLy2d
         bDyqHXiPmkBi8gynOyoQ44P1MGNy1iayP3dP3Uk9e+XXGh6aTP7JqbRoc3iKo0b77UyZ
         0jhdwfwUHrwAMXCHNAUrbJjbF0zl3AEpP1JuLskfgSyGFRhYx7pqvbmAcdRl/oMbNfOV
         XP2MmAuKtKk0lpm2HIzo4qTcqjzx/AhfkgAcO9u9dSw7jfhf7vblApq7xC2NDgwrlx/D
         qirMfwn0vStaymZaAe7gZo8gHcUBSuy2jqlRzTkE8/t9YO3/cOo4ouSfzrWh7Q5kAJ66
         nZzQ==
X-Gm-Message-State: AOJu0Yyy6wTnIST6tW7Zh+eJ8T7vALAhAUSMvzCVnYxiTyRGNk8Q177v
	n58/iyhHtdNvUq0B8fxdLw==
X-Google-Smtp-Source: AGHT+IGkuybcFimpIs0LvZEOZjwVVUVzLxK10DvFGWw0XP9p/eXP37eHJM8+GsP1AmV508zKWNQi3w==
X-Received: by 2002:a05:600c:4583:b0:40d:177b:c3ac with SMTP id r3-20020a05600c458300b0040d177bc3acmr818914wmo.85.1703162444642;
        Thu, 21 Dec 2023 04:40:44 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:1c49:5d1e:f6f3:77a0? ([2a02:810b:f40:4300:1c49:5d1e:f6f3:77a0])
        by smtp.gmail.com with ESMTPSA id k13-20020a05600c1c8d00b0040d3dc52665sm2204319wms.21.2023.12.21.04.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 04:40:44 -0800 (PST)
Message-ID: <769a1510-f8d2-4095-9879-42f413141dee@gmail.com>
Date: Thu, 21 Dec 2023 13:40:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] Add support for video hardware codec of
 STMicroelectronics STM32 SoC series
To: Hugues Fruchet <hugues.fruchet@foss.st.com>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Marco Felsch <m.felsch@pengutronix.de>, Adam Ford <aford173@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Hans Verkuil <hverkuil@xs4all.nl>,
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-media@vger.kernel.org, Alexandre Torgue
 <alexandre.torgue@foss.st.com>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
References: <20231221084723.2152034-1-hugues.fruchet@foss.st.com>
Content-Language: en-US, de-DE
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20231221084723.2152034-1-hugues.fruchet@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hugues, Hi Nicolas,

is there any specific reason I'm not understanding / seeing why this is 
added in two seperate vdec* / venc* files and not a single vpu* file? Is 
it only for the seperate clocks (-names) / irqs (-names) / callbacks? 
Those are defined per variant and perfectly fit in a single file holding 
one vdec and one venc variant.

Alex

Am 21.12.23 um 09:47 schrieb Hugues Fruchet:
> This patchset introduces support for VDEC video hardware decoder
> and VENC video hardware encoder of STMicroelectronics STM32MP25
> SoC series.
> 
> This initial support implements H264 decoding, VP8 decoding and
> JPEG encoding.
> 
> This has been tested on STM32MP257F-EV1 evaluation board.
> 
> ===========
> = history =
> ===========
> version 5:
>     - Precise that video decoding as been successfully tested up to full HD
>     - Add Nicolas Dufresne reviewed-by
> 
> version 4:
>     - Fix comments from Nicolas about dropping encoder raw steps
> 
> version 3:
>     - Fix remarks from Krzysztof Kozlowski:
>      - drop "items", we keep simple enum in such case
>      - drop second example - it is the same as the first
>     - Drop unused node labels as suggested by Conor Dooley
>     - Revisit min/max resolutions as suggested by Nicolas Dufresne
> 
> version 2:
>     - Fix remarks from Krzysztof Kozlowski on v1:
>      - single video-codec binding for both VDEC/VENC
>      - get rid of "-names"
>      - use of generic node name "video-codec"
> 
> version 1:
>    - Initial submission
> 
> Hugues Fruchet (5):
>    dt-bindings: media: Document STM32MP25 VDEC & VENC video codecs
>    media: hantro: add support for STM32MP25 VDEC
>    media: hantro: add support for STM32MP25 VENC
>    arm64: dts: st: add video decoder support to stm32mp255
>    arm64: dts: st: add video encoder support to stm32mp255
> 
>   .../media/st,stm32mp25-video-codec.yaml       |  50 ++++++++
>   arch/arm64/boot/dts/st/stm32mp251.dtsi        |  12 ++
>   arch/arm64/boot/dts/st/stm32mp255.dtsi        |  17 +++
>   drivers/media/platform/verisilicon/Kconfig    |  14 ++-
>   drivers/media/platform/verisilicon/Makefile   |   4 +
>   .../media/platform/verisilicon/hantro_drv.c   |   4 +
>   .../media/platform/verisilicon/hantro_hw.h    |   2 +
>   .../platform/verisilicon/stm32mp25_vdec_hw.c  |  92 ++++++++++++++
>   .../platform/verisilicon/stm32mp25_venc_hw.c  | 115 ++++++++++++++++++
>   9 files changed, 307 insertions(+), 3 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml
>   create mode 100644 drivers/media/platform/verisilicon/stm32mp25_vdec_hw.c
>   create mode 100644 drivers/media/platform/verisilicon/stm32mp25_venc_hw.c
> 


