Return-Path: <linux-kernel+bounces-8563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3301981B96F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC811C25B50
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FBF6D6FC;
	Thu, 21 Dec 2023 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7e3XXOp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6E26D6E4;
	Thu, 21 Dec 2023 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5542a7f1f3cso578243a12.2;
        Thu, 21 Dec 2023 06:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703168338; x=1703773138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZgRxVc3b/cXQXk1FRUsZmIntq3x5skTt1E+0eRMTOto=;
        b=F7e3XXOpj8ZahLLsO50OebukbsJhKU3jK+2ff31ea1AnV7FUHEOBwyelJk4CFVRPmM
         zqzvLC6VG9qKysX+DVIzmmxfb04zCAGPQz7AvbhzJeRwSqJVNXkPHzkpPsgOZSEyBCG5
         5bWRKAYeEhGaR2D95KnQy1ebxytOSLaCxx9hnptKfqBsgvd3DpoR+Bu+HjgyBogalYTe
         2Phq27gCnUfZzgaZZQcVvSLDuqv1x6O9Kk0dykXz1g6Ef+xpKymniQq2Z/sfPo7AJsiF
         CLdoaV3CK0/iJmBe6Fp8Kk4QrOd6BIeFOpdI7hrLU956muUhjnobbd82xdMIvqSoMCO1
         2V5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703168338; x=1703773138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgRxVc3b/cXQXk1FRUsZmIntq3x5skTt1E+0eRMTOto=;
        b=X1GBZS+RYdIlexLXtm3i2gI1rSioSP5temvy3eyGdBQiFLeNO09JlHcN0pqIIKsfK/
         Lr3buMAtCHuLD5nHEKprtt2vlnY28/2Bqn5G+YMJhNqDnNK8zMcqdluBXzg01vwWkv5e
         MJvtZoSCcvwD4WZbXL68DGmCnCrXGBdVQWi6IjLxxDU1DzqtRqHARM3ZUNWBns3CU741
         ULpnfy+s08YNaWqY05ZgN7CjsMJKCQIvnCAhedfeTRnitwCNdyM1pTbuvFHccdzhVAje
         mFqdE/LcV2q1d8r3NoWD9Zv1EWCdIhKWZTWAgD6lcJ18tTJzuM7tCptTiaSiG02qIekc
         NBsg==
X-Gm-Message-State: AOJu0YzuhA2Cw03Ft51oaBSKq3KM8OgY6M687vZGvUqDrEx/5QW12Ohf
	U7vAxCSNy8ytDS0B2W9cqw==
X-Google-Smtp-Source: AGHT+IGEcbQ20zL8VfJo7vaJHeSnFBDczuJI73eIk9D6ghdxribg8KJUIIU6DKKNnhyLuCnYwDPQYg==
X-Received: by 2002:a50:a45e:0:b0:553:354a:9a81 with SMTP id v30-20020a50a45e000000b00553354a9a81mr4529475edb.26.1703168338069;
        Thu, 21 Dec 2023 06:18:58 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:1c49:5d1e:f6f3:77a0? ([2a02:810b:f40:4300:1c49:5d1e:f6f3:77a0])
        by smtp.gmail.com with ESMTPSA id dj25-20020a05640231b900b00552743342c8sm1232410edb.59.2023.12.21.06.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 06:18:57 -0800 (PST)
Message-ID: <5095f695-6dad-45e2-9cff-1b79003355c9@gmail.com>
Date: Thu, 21 Dec 2023 15:18:56 +0100
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
To: Hugues FRUCHET <hugues.fruchet@foss.st.com>
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
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
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Adam Ford <aford173@gmail.com>
References: <20231221084723.2152034-1-hugues.fruchet@foss.st.com>
 <769a1510-f8d2-4095-9879-42f413141dee@gmail.com>
 <a240d2ac-db0e-481b-8d13-3ae76cfd2fe7@foss.st.com>
 <e5ba1e14-4bbf-43e3-933a-fee6d4b90641@gmail.com>
 <CAHCN7xJ3Ktn+TnoOYdnNvKTddGCfLp4OQ+gM0WonWj-aqnsGuA@mail.gmail.com>
 <b03a7ddc-65c5-44c3-a563-d52ee938148a@gmail.com>
 <6d26d307-eb7a-43ad-b4f3-57f8ac7ce8f0@foss.st.com>
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <6d26d307-eb7a-43ad-b4f3-57f8ac7ce8f0@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Hugues,

Am 21.12.23 um 14:55 schrieb Hugues FRUCHET:
> Hi Alex,
>
> On 12/21/23 14:46, Alex Bee wrote:
>>
>> Am 21.12.23 um 14:38 schrieb Adam Ford:
>>> On Thu, Dec 21, 2023 at 7:31 AM Alex Bee <knaerzche@gmail.com> wrote:
>>>> Hi Hugues,
>>>>
>>>> Am 21.12.23 um 14:08 schrieb Hugues FRUCHET:
>>>>> Hi Alex,
>>>>>
>>>>> This is because VDEC and VENC are two separated IPs with their own
>>>>> hardware resources and no links between both.
>>>>> On future SoCs, VDEC can ship on its own, same for VENC.
>>>>>
>>>> I think that's what the driver is/was designed for :)
>>>>
>>>> I don't  think there _has_ to be a link between variants in the 
>>>> same file.
>>>> For Rockchip we only had the issue that there _is_ a link (shared
>>>> resources) between encoder and decoder and they had (for that 
>>>> reason) to be
>>>> defined has a _single_ variant. And there is no reason you can ship 
>>>> decoder
>>>> and encoder seperated when you have two variants (with different
>>>> compatibles).
>>>> For Rockchip and iMX those files are even containing variants for 
>>>> completly
>>>> different generations / different SoCs. I had to cleanup this mess for
>>> The i.MX8M Mini and Plus have different power domains for encoder and
>>> decoders as well as different clocks.  Keeping them separate would
>>> almost be necessary.
>> I guess there is missunderstanding: I didn't say the two STM variants
>> should be merged in one variant, but the two variants should be 
>> within the
>> same _file_, like the other platforms are doing :)
>
> I have two separated hardware: VDEC and VENC, not a single block like 
> "VPU" for example. So what name should have this file ?
> Other platforms had a common file because there was a common block 
> embedding both decoder and encoder, sometimes with links/dependencies 
> between both.
> SAMA5D4 has only a decoder, only a single file called "_vdec_hw.c"...
> so it is quite logical for me to have one file per independent IP.
>
Maybe - but that's not way the driver is currently organzied.
rockchip_vpu_hw.c also holds variants which have only have a decoder and
also some which only have a encoder. So "vpu" is quite neutral, I guess. It
doesn't say anything if it belongs to encoder or decoder.
When I was adding the RK3066 variant a I was even asked to add a explicit
comment, why this integration can't be splitted in encoder and decoder
variant.

We were having a a lot of these split-ups in the early days of hantro
driver and it was no fun to clean them up.

Alex

>>> adam
>>>
>>>> Rockchip once - and it was no fun :) Anyways: It's up to the 
>>>> maintainers I
>>>> guess - I just wanted to ask if I missunderstand something here.
>>>>
>>>> Greetings,
>>>>
>>>> Alex
>>>>
>>>>> Hoping that this clarify.
>>>>>
>>>>> Best regards,
>>>>> Hugues.
>>>>>
>>>>> On 12/21/23 13:40, Alex Bee wrote:
>>>>>> Hi Hugues, Hi Nicolas,
>>>>>>
>>>>>> is there any specific reason I'm not understanding / seeing why this
>>>>>> is added in two seperate vdec* / venc* files and not a single vpu*
>>>>>> file? Is it only for the seperate clocks (-names) / irqs (-names) /
>>>>>> callbacks? Those are defined per variant and perfectly fit in a
>>>>>> single file holding one vdec and one venc variant.
>>>>>>
>>>>>> Alex
>>>>>>
>>>>>> Am 21.12.23 um 09:47 schrieb Hugues Fruchet:
>>>>>>> This patchset introduces support for VDEC video hardware decoder
>>>>>>> and VENC video hardware encoder of STMicroelectronics STM32MP25
>>>>>>> SoC series.
>>>>>>>
>>>>>>> This initial support implements H264 decoding, VP8 decoding and
>>>>>>> JPEG encoding.
>>>>>>>
>>>>>>> This has been tested on STM32MP257F-EV1 evaluation board.
>>>>>>>
>>>>>>> ===========
>>>>>>> = history =
>>>>>>> ===========
>>>>>>> version 5:
>>>>>>>      - Precise that video decoding as been successfully tested 
>>>>>>> up to
>>>>>>> full HD
>>>>>>>      - Add Nicolas Dufresne reviewed-by
>>>>>>>
>>>>>>> version 4:
>>>>>>>      - Fix comments from Nicolas about dropping encoder raw steps
>>>>>>>
>>>>>>> version 3:
>>>>>>>      - Fix remarks from Krzysztof Kozlowski:
>>>>>>>       - drop "items", we keep simple enum in such case
>>>>>>>       - drop second example - it is the same as the first
>>>>>>>      - Drop unused node labels as suggested by Conor Dooley
>>>>>>>      - Revisit min/max resolutions as suggested by Nicolas Dufresne
>>>>>>>
>>>>>>> version 2:
>>>>>>>      - Fix remarks from Krzysztof Kozlowski on v1:
>>>>>>>       - single video-codec binding for both VDEC/VENC
>>>>>>>       - get rid of "-names"
>>>>>>>       - use of generic node name "video-codec"
>>>>>>>
>>>>>>> version 1:
>>>>>>>     - Initial submission
>>>>>>>
>>>>>>> Hugues Fruchet (5):
>>>>>>>     dt-bindings: media: Document STM32MP25 VDEC & VENC video codecs
>>>>>>>     media: hantro: add support for STM32MP25 VDEC
>>>>>>>     media: hantro: add support for STM32MP25 VENC
>>>>>>>     arm64: dts: st: add video decoder support to stm32mp255
>>>>>>>     arm64: dts: st: add video encoder support to stm32mp255
>>>>>>>
>>>>>>>    .../media/st,stm32mp25-video-codec.yaml       |  50 ++++++++
>>>>>>>    arch/arm64/boot/dts/st/stm32mp251.dtsi        |  12 ++
>>>>>>>    arch/arm64/boot/dts/st/stm32mp255.dtsi        |  17 +++
>>>>>>>    drivers/media/platform/verisilicon/Kconfig    |  14 ++-
>>>>>>>    drivers/media/platform/verisilicon/Makefile   |   4 +
>>>>>>>    .../media/platform/verisilicon/hantro_drv.c   |   4 +
>>>>>>>    .../media/platform/verisilicon/hantro_hw.h    |   2 +
>>>>>>>    .../platform/verisilicon/stm32mp25_vdec_hw.c  |  92 
>>>>>>> ++++++++++++++
>>>>>>>    .../platform/verisilicon/stm32mp25_venc_hw.c  | 115
>>>>>>> ++++++++++++++++++
>>>>>>>    9 files changed, 307 insertions(+), 3 deletions(-)
>>>>>>>    create mode 100644
>>>>>>> Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml 
>>>>>>>
>>>>>>>    create mode 100644
>>>>>>> drivers/media/platform/verisilicon/stm32mp25_vdec_hw.c
>>>>>>>    create mode 100644
>>>>>>> drivers/media/platform/verisilicon/stm32mp25_venc_hw.c
>>>>>>>
>
> Best regards,
> Hugues.

