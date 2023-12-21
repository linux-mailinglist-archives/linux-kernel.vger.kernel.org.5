Return-Path: <linux-kernel+bounces-8493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B6281B89F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FBC628EB54
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C9E78E80;
	Thu, 21 Dec 2023 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2UWxB37"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8DD745D5;
	Thu, 21 Dec 2023 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a268dd99597so93666266b.3;
        Thu, 21 Dec 2023 05:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703165506; x=1703770306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4clTO1fofY2eNwbdO7CCLGOSVGvP1DX7gqJc9G4CyF8=;
        b=J2UWxB37xqVz3vLsADkWpqeaRkcKs3gPir/yLtYf8+iFc/HsAwfotoM8HEMIqIVtCh
         nXKi+aOQ9df12NwvgL+E8/DG00B9DnU/rGhg8NnP7AU46nUH1+priT7Eo0tTLSA07Pcw
         wr8axnsT23yz9n99+d1HBLp2/QLbNG9a8j24ddSkbMGxZn57G7ZrIVdswxxzhjE2eIHU
         flrPP69tYOlTEzwZjU/CMRDJBJXeoYm4fYeyoY5W7ZVyWzZOH08/q6NtwZspzv/lgo48
         te6UQ92+DzyVys1WlfK9T5DcnYlp+4V9kFAjbsVBfI6si7D9OEL4CQ0EqhOuXgECxmKo
         5jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703165506; x=1703770306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4clTO1fofY2eNwbdO7CCLGOSVGvP1DX7gqJc9G4CyF8=;
        b=GxHMoT9k3dPKMiZjPVEwPw0/V/LxWgGvJSoQGArqUWSDe47X9lgSCjgMFOCefHLvwL
         E9ZTFDwr/08i07WNDbZH8zQAf8MpUBOeUU9k9C3WOjmrflzIjiXmQK8lvCCSD8PhH93B
         9GLuEU9U/cVogqjgK/Dyimz+VoSN01ppmvtQrwKcYSf208pXOTx35TIpsVjxkOHUaWpD
         SQRWseIIcVS2p2Y4Anu1MTE7ooQwfLUnyCqiHNTtLiBw9XeKO7ymT3iBMsF0/JxoGhfd
         CVyh+EL3ierqX+UVjBEAYxmqoAcgUvBAmSDHZv7ujfELWx0mxBvbJ1orNCMPY/A0brAh
         JUiA==
X-Gm-Message-State: AOJu0YzuUNBQvmh5n2VHseuHNhMRqm69ImHSKkS13wHnZDF88kVSGAA+
	LyHmExOiVc+3efUcFQ4jhw==
X-Google-Smtp-Source: AGHT+IF2Flfwdw+9Ew7PdPcxSqRYmVIgFYsU4nOcYmBTEXLMsfQ7N0ayOXW8rHLLhgaxT1AapyUWvw==
X-Received: by 2002:a17:906:6d58:b0:a23:4532:f168 with SMTP id a24-20020a1709066d5800b00a234532f168mr1881887ejt.227.1703165505503;
        Thu, 21 Dec 2023 05:31:45 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:1c49:5d1e:f6f3:77a0? ([2a02:810b:f40:4300:1c49:5d1e:f6f3:77a0])
        by smtp.gmail.com with ESMTPSA id hj13-20020a170906874d00b00a233515c391sm953856ejb.158.2023.12.21.05.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 05:31:45 -0800 (PST)
Message-ID: <e5ba1e14-4bbf-43e3-933a-fee6d4b90641@gmail.com>
Date: Thu, 21 Dec 2023 14:31:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] Add support for video hardware codec of
 STMicroelectronics STM32 SoC series
Content-Language: en-US, de-DE
To: Hugues FRUCHET <hugues.fruchet@foss.st.com>,
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
 <769a1510-f8d2-4095-9879-42f413141dee@gmail.com>
 <a240d2ac-db0e-481b-8d13-3ae76cfd2fe7@foss.st.com>
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <a240d2ac-db0e-481b-8d13-3ae76cfd2fe7@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Hugues,

Am 21.12.23 um 14:08 schrieb Hugues FRUCHET:
> Hi Alex,
>
> This is because VDEC and VENC are two separated IPs with their own 
> hardware resources and no links between both.
> On future SoCs, VDEC can ship on its own, same for VENC.
>
I think that's what the driver is/was designed for :)

I don't  think there _has_ to be a link between variants in the same file.
For Rockchip we only had the issue that there _is_ a link (shared
resources) between encoder and decoder and they had (for that reason) to be
defined has a _single_ variant. And there is no reason you can ship decoder
and encoder seperated when you have two variants (with different
compatibles).
For Rockchip and iMX those files are even containing variants for completly
different generations / different SoCs. I had to cleanup this mess for
Rockchip once - and it was no fun :) Anyways: It's up to the maintainers I
guess - I just wanted to ask if I missunderstand something here.

Greetings,

Alex

> Hoping that this clarify.
>
> Best regards,
> Hugues.
>
> On 12/21/23 13:40, Alex Bee wrote:
>> Hi Hugues, Hi Nicolas,
>>
>> is there any specific reason I'm not understanding / seeing why this 
>> is added in two seperate vdec* / venc* files and not a single vpu* 
>> file? Is it only for the seperate clocks (-names) / irqs (-names) / 
>> callbacks? Those are defined per variant and perfectly fit in a 
>> single file holding one vdec and one venc variant.
>>
>> Alex
>>
>> Am 21.12.23 um 09:47 schrieb Hugues Fruchet:
>>> This patchset introduces support for VDEC video hardware decoder
>>> and VENC video hardware encoder of STMicroelectronics STM32MP25
>>> SoC series.
>>>
>>> This initial support implements H264 decoding, VP8 decoding and
>>> JPEG encoding.
>>>
>>> This has been tested on STM32MP257F-EV1 evaluation board.
>>>
>>> ===========
>>> = history =
>>> ===========
>>> version 5:
>>>     - Precise that video decoding as been successfully tested up to 
>>> full HD
>>>     - Add Nicolas Dufresne reviewed-by
>>>
>>> version 4:
>>>     - Fix comments from Nicolas about dropping encoder raw steps
>>>
>>> version 3:
>>>     - Fix remarks from Krzysztof Kozlowski:
>>>      - drop "items", we keep simple enum in such case
>>>      - drop second example - it is the same as the first
>>>     - Drop unused node labels as suggested by Conor Dooley
>>>     - Revisit min/max resolutions as suggested by Nicolas Dufresne
>>>
>>> version 2:
>>>     - Fix remarks from Krzysztof Kozlowski on v1:
>>>      - single video-codec binding for both VDEC/VENC
>>>      - get rid of "-names"
>>>      - use of generic node name "video-codec"
>>>
>>> version 1:
>>>    - Initial submission
>>>
>>> Hugues Fruchet (5):
>>>    dt-bindings: media: Document STM32MP25 VDEC & VENC video codecs
>>>    media: hantro: add support for STM32MP25 VDEC
>>>    media: hantro: add support for STM32MP25 VENC
>>>    arm64: dts: st: add video decoder support to stm32mp255
>>>    arm64: dts: st: add video encoder support to stm32mp255
>>>
>>>   .../media/st,stm32mp25-video-codec.yaml       |  50 ++++++++
>>>   arch/arm64/boot/dts/st/stm32mp251.dtsi        |  12 ++
>>>   arch/arm64/boot/dts/st/stm32mp255.dtsi        |  17 +++
>>>   drivers/media/platform/verisilicon/Kconfig    |  14 ++-
>>>   drivers/media/platform/verisilicon/Makefile   |   4 +
>>>   .../media/platform/verisilicon/hantro_drv.c   |   4 +
>>>   .../media/platform/verisilicon/hantro_hw.h    |   2 +
>>>   .../platform/verisilicon/stm32mp25_vdec_hw.c  |  92 ++++++++++++++
>>>   .../platform/verisilicon/stm32mp25_venc_hw.c  | 115 
>>> ++++++++++++++++++
>>>   9 files changed, 307 insertions(+), 3 deletions(-)
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml
>>>   create mode 100644 
>>> drivers/media/platform/verisilicon/stm32mp25_vdec_hw.c
>>>   create mode 100644 
>>> drivers/media/platform/verisilicon/stm32mp25_venc_hw.c
>>>
>>

