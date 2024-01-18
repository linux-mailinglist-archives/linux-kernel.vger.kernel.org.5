Return-Path: <linux-kernel+bounces-30238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA2A831BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D90B1C2348B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5A41E527;
	Thu, 18 Jan 2024 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="hjk1SxoK"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4AB219ED;
	Thu, 18 Jan 2024 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705590456; cv=none; b=QTuvDK9VPpF4fyhi99p/mZTEMxIJL3cqZkEmFeZ2GI+SHtsBaPqSmsKMQPLsuL4v1ec7YMCUF8L1utoskGlzxAekg363qF9uE2gXe2af30Q8SXf91rF12TnZwL+xZaI+LGMUOhg/kmUBxT+48ouT180ADDQKgQWDc9nhJdFwyzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705590456; c=relaxed/simple;
	bh=4tB02AMUBJK7rHcK/xsmatsNFewXliZ/lexSfh8yP5s=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-Proofpoint-Virus-Version; b=QnXIcnCA6eIxmuSOP76MOUoIxAaaUkk7GdIr4HlS+gBis+duksKdB8EWCWMNrBW3xnQccpF/bCf4DW1vW4i5TW3mCXbp+ZWCYsnVWUp6BXn6Mac+i0aIiLPVg+dLbaLo+iAPRRQQQDhJIXIGPqG069ecPB6wnlOz3/QnMIgJZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=hjk1SxoK; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40I9TAE3019271;
	Thu, 18 Jan 2024 16:07:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=vFS8aLbSD8UDCY9TOifRYsHJeeKAdBfSeHqJo15h+XE=; b=hj
	k1SxoKdho21gk5m3VLBVzAdy/FjHWE056pqHiLzLfWpZCEIISMzeVSPZhyJlXSiK
	T/iztAfeC+pDsEG+RaIJoWcktjKHTYxyAUA0EIhUtASSdY75fF9KpcHuIeyxptz5
	yNAuIju3xlnz9AcuobI8TDbHzwsgxoS7H98pUzvnLYg+zEI5Lf4Y/veWxCxK2uyF
	BX0C++Lc944BDb2KJlnE7hkQ3MVNb25g86Xp0z7hwlqvr/GL0PpwkGPp6J4CijY2
	5HRlyijy2SIXx04MfgCX56XRrNvT+tkVzqwOhvI92fdJrQU9ZuMKV5BF50/OhoFJ
	jGlD2Vu+KM3saGZbQ+aw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkmfyssw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 16:07:00 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E3CB110007D;
	Thu, 18 Jan 2024 16:06:57 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D222322FA3A;
	Thu, 18 Jan 2024 16:06:57 +0100 (CET)
Received: from [10.129.178.37] (10.129.178.37) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 18 Jan
 2024 16:06:57 +0100
Message-ID: <23be859d-e757-4b59-b4ca-acf9b4dd1f9e@foss.st.com>
Date: Thu, 18 Jan 2024 16:06:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: display: add dt-bindings for STM32
 LVDS device
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring
	<robh@kernel.org>
CC: Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240115132009.101718-1-raphael.gallais-pou@foss.st.com>
 <20240115132009.101718-2-raphael.gallais-pou@foss.st.com>
 <20240115154659.GA815331-robh@kernel.org>
 <3479c5d7-a9c3-40cf-a415-b8324f160ec7@foss.st.com>
 <e42818b2-8826-48f8-b9bd-35cbf464a08f@linaro.org>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <e42818b2-8826-48f8-b9bd-35cbf464a08f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02


On 1/16/24 08:42, Krzysztof Kozlowski wrote:
> On 15/01/2024 17:51, Raphael Gallais-Pou wrote:
>> On 1/15/24 16:46, Rob Herring wrote:
>>> On Mon, Jan 15, 2024 at 02:20:04PM +0100, Raphael Gallais-Pou wrote:
>>>> Add "st,stm32mp25-lvds" compatible.
>>>>
> A nit, subject: drop second/last, redundant "dt-bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
>
>>>> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
>>>> ---
>>>> Depends on: "dt-bindings: stm32: add clocks and reset binding for
>>>> 	    stm32mp25 platform" by Gabriel Fernandez
>>>>
>>>> Changes in v3:
>>>> 	- Clarify commit dependency
>>>> 	- Fix includes in the example
>>>> 	- Fix YAML
>>>> 	- Add "clock-cells" description
>>>> 	- s/regroups/is composed of/
>>>> 	- Changed compatible to show SoC specificity
>>>>
>>>> Changes in v2:
>>>> 	- Switch compatible and clock-cells related areas
>>>> 	- Remove faulty #include in the example.
>>>> 	- Add entry in MAINTAINERS
>>>> ---
>>>>  .../bindings/display/st,stm32-lvds.yaml       | 119 ++++++++++++++++++
>>> Filename matching compatible.
>> Hi Rob,
>>
>>
>> I was unsure about this.
>>
>> The driver will eventually support several SoCs with different compatibles,
>> wouldn't this be more confusing ?
> No. "Eventually" might never happen.
>
>> I also wanted to keep the similarity with the "st,stm32-<ip>.yaml" name for the
>> DRM STM drivers. Would that be possible ?
> But why? The consistency we want is the filename matching compatible,
> not matching other filenames. If you have here multiple devices,
> document them *now*.


Hi Krzysztof,

|There is no multiple devices, so I will stick to the "st,stm32mp25-lvds"
pattern for now.|

>
>>
>> Regards,
>>
>> Raphaël
> I hope you did not ignore rest of the comments... We expect some sort of
> "ack/ok/I'll fix/whatever" message and you wrote nothing further.

Although I did not acknowledged what has been said previously, I always take
into account every comment on my patches.  I understand that it can lead to some confusion.  So rest assured that I did not
ignore Rob's and Dmitry's review.


Regards,

Raphaël

>
> Best regards,
> Krzysztof
>

