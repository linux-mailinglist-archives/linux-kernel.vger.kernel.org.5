Return-Path: <linux-kernel+bounces-86445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFAA86C576
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20FD61F26EDF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5670660872;
	Thu, 29 Feb 2024 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="TgwHBu2L"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF47C5788F;
	Thu, 29 Feb 2024 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199389; cv=none; b=PqtztJk5RZdy91ZsDR1I7kQTqnKO06XpnPPZzRmGxIUDhTcKuW+74rziL8rRWDQs8r1PwB2raJFtR2y0YrUihpSyfMVHnkkhr2t8+7KeHApt+dXk0kjttV447V0FKug65OEN0FmW4fV99EeYLrdL+Ksjx+baEQ2OSp9Hz7mQu+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199389; c=relaxed/simple;
	bh=6sGHyawCeXKyw6Rtv98rsGHjfxpOvkfBT9TY5+S/eY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ARQgkMT7VCBgKFAmiKMoN4zHHRtRvIWuBHMqxAgdlrUNwfZ1yHYZRMzHRouzDAVUDkjG0lU+vlMCehGjt85hIgJXi3bhg8PAehYY6YRFkRL2CQ1aIDsaZi+CD1xM3LHIIUk96UroRcOg575KPHVHsBiH7KqTjrEPLCJuv1K9Bc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=TgwHBu2L; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41T4luWM014622;
	Thu, 29 Feb 2024 10:36:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=bS+bJvkfy7DuArCxhI/IT1mvSmqqENxhxsxmJTMZJRQ=; b=Tg
	wHBu2Loq6q5dhbzWFi5EeEalO3CkcFrv5sSmh4VPs2VbmXNoNioUTb+J6g80EJbO
	Jvkgq3THuNAU7F3cGLediPm29FvGHkso4E6a/Onj1JoYbVlTvRW5pTlI3IzV92+Z
	d7VG7ykF8o0+S00YPOkXEPboISgdZUHQqdjZzF47NNGQVd6jaUk+iZ9CbfNPSGMd
	rSjeVV1oNwgd2/2fKlOnooEZg/ymE7lTXVG7lk7Dgkskgw8f+XWGoSJouQCcSLQ+
	eih0a92P+mn8aIQUdcGUaBCepXyyzDsrkLqUhkjH2nvDLz+I4oPG9y1U7/o3ePgq
	t9UlYnaikBfc1528lfsw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3whf4bhg83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 10:36:06 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9600D40047;
	Thu, 29 Feb 2024 10:35:47 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 01AF52504E1;
	Thu, 29 Feb 2024 10:34:55 +0100 (CET)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 29 Feb
 2024 10:34:53 +0100
Message-ID: <48590723-4495-47ca-89b8-1a858e55fa09@foss.st.com>
Date: Thu, 29 Feb 2024 10:34:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v6 0/5] Add support for video hardware codec of
 STMicroelectronics STM32 SoC series
Content-Language: en-US
To: Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Ezequiel Garcia
	<ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Nicolas Dufresne
	<nicolas.dufresne@collabora.com>,
        Sakari Ailus
	<sakari.ailus@linux.intel.com>,
        Benjamin Gaignard
	<benjamin.gaignard@collabora.com>,
        Laurent Pinchart
	<laurent.pinchart+renesas@ideasonboard.com>,
        Daniel Almeida
	<daniel.almeida@collabora.com>,
        Benjamin Mugnier
	<benjamin.mugnier@foss.st.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mauro
 Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, <linux-media@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>
CC: Marco Felsch <m.felsch@pengutronix.de>, Adam Ford <aford173@gmail.com>
References: <20240110104642.532011-1-hugues.fruchet@foss.st.com>
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240110104642.532011-1-hugues.fruchet@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-27_01,2023-05-22_02

Hi

On 1/10/24 11:46, Hugues Fruchet wrote:
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
> version 6:
>     - Use a single file for VDEC and VENC variants as suggested by Alex Bee
>     - Fix some typos raised by Sebastian Fricke
>     - Add Krzysztof Kozlowski Reviewed-by
> 
> version 5:
>     - Precise that video decoding as been successfully tested up to full HD
>     - Add Nicolas Dufresne Reviewed-by
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

DT patches ([4]&[5]) applied on stm32-next. I assume that dt-bindings 
patch will go through the media tree.

Thanks
Alex


>   .../media/st,stm32mp25-video-codec.yaml       |  49 +++++
>   arch/arm64/boot/dts/st/stm32mp251.dtsi        |  12 ++
>   arch/arm64/boot/dts/st/stm32mp255.dtsi        |  17 ++
>   drivers/media/platform/verisilicon/Kconfig    |  14 +-
>   drivers/media/platform/verisilicon/Makefile   |   3 +
>   .../media/platform/verisilicon/hantro_drv.c   |   4 +
>   .../media/platform/verisilicon/hantro_hw.h    |   2 +
>   .../platform/verisilicon/stm32mp25_vpu_hw.c   | 186 ++++++++++++++++++
>   8 files changed, 284 insertions(+), 3 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml
>   create mode 100644 drivers/media/platform/verisilicon/stm32mp25_vpu_hw.c
> 

