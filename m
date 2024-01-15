Return-Path: <linux-kernel+bounces-26279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A1182DDFA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D196282BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D453017C70;
	Mon, 15 Jan 2024 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="yWI9NouH"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26C317C6A;
	Mon, 15 Jan 2024 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40FDrZU1008279;
	Mon, 15 Jan 2024 17:51:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=v/GemSIloeASK3WLJ1Xew5INevRA7DxBKaKXrgp0BrI=; b=yW
	I9NouHDCyq43z3fEbedcH1DBWBHnlGwKnS2NFXi0ofmWWeaCMJLvOFimeL7TiLvv
	0Rm4EJ2vXjSkSoVbG93Q47Ib0LjVySE0FJVc83GQM3158cyKguQ0YwenISvU75T8
	f3odqvHeu7q26Ic++F5pOUt2H/vQUM917hoP0IiHBHWN/a6+h/dlmUX+NciD0XP5
	3DpK0ZkYCCBHWuncmuD7WFLnDxGiyliD3bzb0BuQIKszMEPo5/WG4xXrrN9R8/J1
	swRCMM6ZEKiw8y3RVrwDxe+boWapMNCRfB6KaVFEet/6LA3P/crX6rXDVcgJ3iQt
	H1hlwJ5mEXRw1hxKmdGw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkmddstng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 17:51:30 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1111910002A;
	Mon, 15 Jan 2024 17:51:29 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EE6662EAB7A;
	Mon, 15 Jan 2024 17:51:28 +0100 (CET)
Received: from [10.129.178.37] (10.129.178.37) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Jan
 2024 17:51:28 +0100
Message-ID: <3479c5d7-a9c3-40cf-a415-b8324f160ec7@foss.st.com>
Date: Mon, 15 Jan 2024 17:51:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: display: add dt-bindings for STM32
 LVDS device
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
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
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20240115154659.GA815331-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02


On 1/15/24 16:46, Rob Herring wrote:
> On Mon, Jan 15, 2024 at 02:20:04PM +0100, Raphael Gallais-Pou wrote:
>> Add "st,stm32mp25-lvds" compatible.
>>
>> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
>> ---
>> Depends on: "dt-bindings: stm32: add clocks and reset binding for
>> 	    stm32mp25 platform" by Gabriel Fernandez
>>
>> Changes in v3:
>> 	- Clarify commit dependency
>> 	- Fix includes in the example
>> 	- Fix YAML
>> 	- Add "clock-cells" description
>> 	- s/regroups/is composed of/
>> 	- Changed compatible to show SoC specificity
>>
>> Changes in v2:
>> 	- Switch compatible and clock-cells related areas
>> 	- Remove faulty #include in the example.
>> 	- Add entry in MAINTAINERS
>> ---
>>  .../bindings/display/st,stm32-lvds.yaml       | 119 ++++++++++++++++++
> Filename matching compatible.

Hi Rob,


I was unsure about this.

The driver will eventually support several SoCs with different compatibles,
wouldn't this be more confusing ?

I also wanted to keep the similarity with the "st,stm32-<ip>.yaml" name for the
DRM STM drivers. Would that be possible ?


Regards,

Raphaël



>
>> +properties:
>> +  compatible:
>> +    const: st,stm32mp25-lvds
>
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
>> +    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
>> +
>> +    lvds: lvds@48060000 {
>> +        compatible = "st,stm32-lvds";
> Wrong compatible.

