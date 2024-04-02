Return-Path: <linux-kernel+bounces-127719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 477F0894FED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029FD28153C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E515B5D6;
	Tue,  2 Apr 2024 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gYFdwsU1"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FBC5C5EE;
	Tue,  2 Apr 2024 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053204; cv=none; b=fW9F9/QbOLAKgM/DEjFG3OHPxLvQCZqruCesFNTDQ47VYfbpQ2J05EWqXsoIy41wIwwbkAbr91FEj3nSTeo19iFIaajcE44ZHT26w/YQ7dPTqH4YIkz/hlL7mGI99R+rrWcP83NlKY6xd1PkNEA59ZZcLncqJqOELZmmGyy6rHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053204; c=relaxed/simple;
	bh=JnuuGoMMtIIi7hH3yi+PltAgEyrlYvhCs44kUq4udcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NTTWF7Ki0Ec0+tRaic/Fl5Y7dy7W4tpCQ176ygqyIH78pM7FJOOh5LdQD0VfEvEU60avzR4PknxTUHzu7YQsubsdqI6vMnrHZ1tg1sKB4UG/UqXdXerdk8uhTXDBF4zQJskHcsrYJPHyTubVSrwr4SswoTtfeOlbECBy1anMgPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gYFdwsU1; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712053202; x=1743589202;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JnuuGoMMtIIi7hH3yi+PltAgEyrlYvhCs44kUq4udcc=;
  b=gYFdwsU13V+9qQsSLCo1TWfBpdIBHA3ELbQUjL14f0nd56j7rlvkG9fr
   YylmT/tDEZZwkV5cHQTBEDzYqcq/KUwfQHpshcLLDUeWpYN7MQRxrJyTI
   qtI1UYFg3lIUUhpWrL4fltQXTHEUg92nyaVw3u8wCjFoxBJb6sWt5EA66
   EE0TiGrx/agdYAVFFSTIB5VTI3wCmYqrtI+7czRysiauno7HZgknjuoqP
   tnysUd2gok34sy7RFjavnHK8LJM41Q0n0mQ8ZqDp6cP35wfHCqa54h1R1
   kmVRgI7i61a00KJagllk9YeZAdnA3Gt4kj/Adhjl7nHNLShxyCOidduNu
   g==;
X-CSE-ConnectionGUID: wL/4QxNJQfSLbor2JonfjA==
X-CSE-MsgGUID: traVBd95RxOfGbqb+vnx6Q==
X-IronPort-AV: E=Sophos;i="6.07,174,1708412400"; 
   d="scan'208";a="21032486"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Apr 2024 03:20:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 03:19:28 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 2 Apr 2024 03:19:26 -0700
Message-ID: <0026b0ab-cf0a-48bb-a783-95caa39ffd80@microchip.com>
Date: Tue, 2 Apr 2024 12:18:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix the regulator-state-standby definition
Content-Language: en-US, fr-FR
To: Andrei Simion <andrei.simion@microchip.com>, <robh@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<mihai.sain@microchip.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
References: <20240402091228.110362-1-andrei.simion@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240402091228.110362-1-andrei.simion@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 02/04/2024 at 11:12, Andrei Simion wrote:
> make dtbs_check DT_SCHEMA_FILES=microchip,mcp16502.yaml
> 
> at91-sama7g5ek.dtb: mcp16502@5b: regulators:VDD_(CORE|OTHER)|LDO[1-2]:
> regulator-state-standby 'regulator-suspend-voltage' does not match any of
> the regexes 'pinctrl-[0-9]+' from schema
> $id: http://devicetree.org/schemas/regulator/microchip,mcp16502.yaml#
> 
> at91-sama7g54_curiosity.dtb: pmic@5b: regulators:VDD_(CORE|OTHER)|LDO[1-2]:
> regulator-state-standby 'regulator-suspend-voltage' does not match any of
> the regexes 'pinctrl-[0-9]+' from schema
> $id: http://devicetree.org/schemas/regulator/microchip,mcp16502.yaml#
> 
> This patch series proposes to correct the typo that was entered by mistake
> into devicetree definition regulator-state-standby by replacing
> regulator-suspend-voltage with regulator-suspend-microvolt.

Sure: as there is no regression for this property never used (because of 
the typo, precisely):

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

For the whole series.

Thanks Andrei, best regards,
   Nicolas

> 
> Andrei Simion (2):
>    ARM: boot: dts: microchip: at91-sama7g5ek: Replace
>      regulator-suspend-voltage with the valid property
>    ARM: boot: dts: microchip: at91-sama7g54_curiosity: Replace
>      regulator-suspend-voltage with the valid property
> 
>   arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts | 8 ++++----
>   arch/arm/boot/dts/microchip/at91-sama7g5ek.dts          | 8 ++++----
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 


