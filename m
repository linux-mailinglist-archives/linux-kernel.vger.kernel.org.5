Return-Path: <linux-kernel+bounces-165900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2D68B9321
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B15D5B215A2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EEA134D1;
	Thu,  2 May 2024 01:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="AL6BY7bA"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC5F125C0;
	Thu,  2 May 2024 01:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714613881; cv=none; b=Rld10tcJQJpNGkiItJgQxeq2/i04GOAO7EsZy5sRn+FCkVpHlojsWhIHERhqR+deI6I4jJQwsfERjFaS100XmMOq9VRTZltOEWSuLSaMEAhqVtnnZBG6fvyKvIub5Yd8mjSjG6GfxtslvxAY67IeMoEcsriT5KB6sEV+ZVi+hKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714613881; c=relaxed/simple;
	bh=KQJpn9Kws2+yaPwY8/riULmXzVcDBpW9sq3IBcoL45I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GMS9laVDjQiB/0ayqjyAWNHAz/NExGTDg/7IPdGikrKD6gq3Ad7JjG+C66xyr61JkJiRF+G2Wu10FCujiSus6FTtfWHJD3Ji1zCR/BWttNTvcW0FSRd+NxETUibDE7J2CDhy9K5wkX+XmYHoULyVrsxJDLlAVxHK1FhcO02EgN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=AL6BY7bA; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714613322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVCWMANqUJGySV0avp2OJDbEbFh/XAZgzAZxpawRdKA=;
	b=AL6BY7bAhPHkOUh/+ThY+7AZ5Jy5l+EvAzMP9wr0i+3216C2W4rpKxBVinnuSxVtDqsChK
	sMvXNdslzPHl7YUbKXn+LVadBR+hDI8OgN/OdQb3H0YduRIAbcqKf0PgQZWOOQiBEB19uH
	UfScHmX5ia5a2cTj+qv1+ZhO9NAkQnp1cPA8ih4gykdcV2zU/FO2QLLBrk5TAFuQJ3fYcz
	ya2nPd6YI5/DI0Glo+4Pa3w91d1SIX+wOS+Bf/DRaoFoAoimH93Mw/bOlWTfJ31mg3JW+z
	0Kt3d3tix75+sZLQeLohycCaGMh2spEzpj4vODhAUB8wPNk8Ex/KiOBxfot84A==
Date: Thu, 02 May 2024 03:28:39 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Folker Schwesinger <dev@folker-schwesinger.de>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>, Conor
 Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob
 Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add Radxa ROCK 3C
In-Reply-To: <D0X7UJELGST3.2IL1AFDJ89N07@folker-schwesinger.de>
References: <20240428123618.72170-1-amadeus@jmu.edu.cn>
 <20240428123618.72170-3-amadeus@jmu.edu.cn>
 <D0X7UJELGST3.2IL1AFDJ89N07@folker-schwesinger.de>
Message-ID: <ded928414323ef4be51f2575d00ba7d1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Folker,

On 2024-04-30 07:42, Folker Schwesinger wrote:
> On Sun Apr 28, 2024 at 2:36 PM CEST, Chukun Pan wrote:
>> [...]
>> +&sdhci {
>> +	bus-width = <8>;
>> +	max-frequency = <200000000>;
>> +	mmc-hs200-1_8v;
> 
> Out of curiosity, does this board also support HS400? From a very brief
> look this board seems quite similar to Rock 4 series boards, that do
> support HS400.

In a word, no, unfortunately.  In more detail, the Rockchip RK3566
and RK3568 SoCs support the eMMC modes up to and including HS200, but
not the HS400 mode.

>> +	non-removable;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
>> +	vmmc-supply = <&vcc_3v3>;
>> +	vqmmc-supply = <&vcc_1v8>;
>> +	status = "okay";
>> +};
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

