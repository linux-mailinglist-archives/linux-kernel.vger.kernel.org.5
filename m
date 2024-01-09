Return-Path: <linux-kernel+bounces-20660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4016828319
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A8828136F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE2B33CD3;
	Tue,  9 Jan 2024 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="HEoFePXh"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70370364A2;
	Tue,  9 Jan 2024 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409343xj004773;
	Tue, 9 Jan 2024 10:24:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=PffPX8XtKNmALdkQMwhnZW6kAZxJu3D/e4DIkZpdRa8=; b=HE
	oFePXh9x/Is1DayLz5t6fFdexw5taCHMsc66nTDH5QCGhikN2ugKcFwl2BCRLRqp
	EzaFzJifLh5CNOMsQ8ESIO7KzhyUJsr157FTFZvxJoOTSiSm3E9WTOyRumsF8uPm
	FoZV9rpbrV1XwmKjfFmHp+KQy4NOdHdnyoM0/h3QXeSyKC3vJnlZai23pvV8qts4
	14wY0ZxtYMjBDx6+i28GprV8OjWTAV0ESA2ixrr2qY0bhTwyvad2wwi2HIJ2zRYi
	3IDtNYO88G48cz4C8TK184BSXXIvSPwx13OLSPt0SNrAex3VhN2wVSZ4c3LLzQSD
	UqWOqSzR8oMHSJd8EUWg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vey30jx0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 10:24:46 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3262810002A;
	Tue,  9 Jan 2024 10:24:45 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 11AB12122E9;
	Tue,  9 Jan 2024 10:24:45 +0100 (CET)
Received: from [10.201.20.120] (10.201.20.120) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 9 Jan
 2024 10:24:43 +0100
Message-ID: <1c76d85c-6f20-4971-a6df-61e4c534b351@foss.st.com>
Date: Tue, 9 Jan 2024 10:24:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] Add support for video hardware codec of
 STMicroelectronics STM32 SoC series
To: Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne
	<nicolas.dufresne@collabora.com>
CC: Marco Felsch <m.felsch@pengutronix.de>, Adam Ford <aford173@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrzej Pietrasiewicz
	<andrzej.p@collabora.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Laurent Pinchart
	<laurent.pinchart+renesas@ideasonboard.com>,
        Benjamin Mugnier
	<benjamin.mugnier@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Daniel Almeida
	<daniel.almeida@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>, Hans
 Verkuil <hverkuil@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-media@vger.kernel.org>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Ezequiel Garcia
	<ezequiel@vanguardiasur.com.ar>
References: <20231221084723.2152034-1-hugues.fruchet@foss.st.com>
 <769a1510-f8d2-4095-9879-42f413141dee@gmail.com>
 <a240d2ac-db0e-481b-8d13-3ae76cfd2fe7@foss.st.com>
 <e5ba1e14-4bbf-43e3-933a-fee6d4b90641@gmail.com>
Content-Language: en-US
From: Hugues FRUCHET <hugues.fruchet@foss.st.com>
In-Reply-To: <e5ba1e14-4bbf-43e3-933a-fee6d4b90641@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02

Hi Alex,

v6 sent with all the variants in a single file.

Best regards,
Hugues.

On 12/21/23 14:31, Alex Bee wrote:
> Hi Hugues,
> 
> Am 21.12.23 um 14:08 schrieb Hugues FRUCHET:
>> Hi Alex,
>>
>> This is because VDEC and VENC are two separated IPs with their own 
>> hardware resources and no links between both.
>> On future SoCs, VDEC can ship on its own, same for VENC.
>>
> I think that's what the driver is/was designed for :)
> 
> I don't  think there _has_ to be a link between variants in the same file.
> For Rockchip we only had the issue that there _is_ a link (shared
> resources) between encoder and decoder and they had (for that reason) to be
> defined has a _single_ variant. And there is no reason you can ship decoder
> and encoder seperated when you have two variants (with different
> compatibles).
> For Rockchip and iMX those files are even containing variants for completly
> different generations / different SoCs. I had to cleanup this mess for
> Rockchip once - and it was no fun :) Anyways: It's up to the maintainers I
> guess - I just wanted to ask if I missunderstand something here.
> 
> Greetings,
> 
> Alex
> 
>> Hoping that this clarify.
>>
>> Best regards,
>> Hugues.
>>
>> On 12/21/23 13:40, Alex Bee wrote:
>>> Hi Hugues, Hi Nicolas,
>>>
>>> is there any specific reason I'm not understanding / seeing why this 
>>> is added in two seperate vdec* / venc* files and not a single vpu* 
>>> file? Is it only for the seperate clocks (-names) / irqs (-names) / 
>>> callbacks? Those are defined per variant and perfectly fit in a 
>>> single file holding one vdec and one venc variant.
>>>
>>> Alex
>>>
>>> Am 21.12.23 um 09:47 schrieb Hugues Fruchet:
>>>> This patchset introduces support for VDEC video hardware decoder
>>>> and VENC video hardware encoder of STMicroelectronics STM32MP25
>>>> SoC series.
>>>>
>>>> This initial support implements H264 decoding, VP8 decoding and
>>>> JPEG encoding.
>>>>
>>>> This has been tested on STM32MP257F-EV1 evaluation board.
>>>>
>>>> ===========
>>>> = history =
>>>> ===========
>>>> version 5:
>>>>     - Precise that video decoding as been successfully tested up to 
>>>> full HD
>>>>     - Add Nicolas Dufresne reviewed-by
>>>>
>>>> version 4:
>>>>     - Fix comments from Nicolas about dropping encoder raw steps
>>>>
>>>> version 3:
>>>>     - Fix remarks from Krzysztof Kozlowski:
>>>>      - drop "items", we keep simple enum in such case
>>>>      - drop second example - it is the same as the first
>>>>     - Drop unused node labels as suggested by Conor Dooley
>>>>     - Revisit min/max resolutions as suggested by Nicolas Dufresne
>>>>
>>>> version 2:
>>>>     - Fix remarks from Krzysztof Kozlowski on v1:
>>>>      - single video-codec binding for both VDEC/VENC
>>>>      - get rid of "-names"
>>>>      - use of generic node name "video-codec"
>>>>
>>>> version 1:
>>>>    - Initial submission
>>>>
>>>> Hugues Fruchet (5):
>>>>    dt-bindings: media: Document STM32MP25 VDEC & VENC video codecs
>>>>    media: hantro: add support for STM32MP25 VDEC
>>>>    media: hantro: add support for STM32MP25 VENC
>>>>    arm64: dts: st: add video decoder support to stm32mp255
>>>>    arm64: dts: st: add video encoder support to stm32mp255
>>>>
>>>>   .../media/st,stm32mp25-video-codec.yaml       |  50 ++++++++
>>>>   arch/arm64/boot/dts/st/stm32mp251.dtsi        |  12 ++
>>>>   arch/arm64/boot/dts/st/stm32mp255.dtsi        |  17 +++
>>>>   drivers/media/platform/verisilicon/Kconfig    |  14 ++-
>>>>   drivers/media/platform/verisilicon/Makefile   |   4 +
>>>>   .../media/platform/verisilicon/hantro_drv.c   |   4 +
>>>>   .../media/platform/verisilicon/hantro_hw.h    |   2 +
>>>>   .../platform/verisilicon/stm32mp25_vdec_hw.c  |  92 ++++++++++++++
>>>>   .../platform/verisilicon/stm32mp25_venc_hw.c  | 115 
>>>> ++++++++++++++++++
>>>>   9 files changed, 307 insertions(+), 3 deletions(-)
>>>>   create mode 100644 
>>>> Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml
>>>>   create mode 100644 
>>>> drivers/media/platform/verisilicon/stm32mp25_vdec_hw.c
>>>>   create mode 100644 
>>>> drivers/media/platform/verisilicon/stm32mp25_venc_hw.c
>>>>
>>>

