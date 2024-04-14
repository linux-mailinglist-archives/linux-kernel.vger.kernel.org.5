Return-Path: <linux-kernel+bounces-144169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDD98A42B1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EF0BB210BE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 13:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2EF52F67;
	Sun, 14 Apr 2024 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="T17CLoiX"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28147446AF
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713103006; cv=none; b=rZ2xwsKNRQRzOGyJfQ5xNH+VxXTV1dobFwiNd9r+FC9dG92JEi9PEjRk7Fx9HSXN9Mz8cbPFbORA09d/cIe/Xw0b5BVOQQy7yFlbzvCgvqS31e1S77a7gUCG3MMHspNvK8qpH+HVHfNVEj3G8Jlxg8+VcqFAbwiJykXmf8aiurY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713103006; c=relaxed/simple;
	bh=JBfe12WxaI1tNcFR7a6iipsXn9teYku5EwD+c+L+1ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BV+98bkldc92aMAqxDXMubzWASQ/dNuq5jbdrX+ntbEBz3OBV+ulW9YZ13PS9zzATcY0SRIUfkLOc1YYCM4huvJhxp9gZiFbJj9Pi0NRGkDEo7C+QA2SfSwful8lY/VBz3a0vsOoNaF58zO/bd0Dm6Lj5Bix9c9jg5SUZ1Hj/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=T17CLoiX; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1713103002;
 bh=gx8P+suevGzV8uiQbOy19KfnvZ90tlKgcP/DYTpgTy4=;
 b=T17CLoiXr4IEKkFhQKxP4uikAXGe/O0wqk+qlgKv3tp4FtdE0gZP2BdJB6JA3UyVrliE5PvM7
 xPXa+VSiXYJhvVvsB1u5QRHDVBrwtwTJAZxMeA7UR8vTXqfaZhzXrW/dUhqRAv8/VqeoFhq2foO
 2Q9mFzsP4C+Q77Z9qZhXwxKcKCs2lzahnz+TDCZ+iC329h59Hf2xlL4Hr24aV4GAUEte/M/iNpI
 3820yXUAh1t3tRpFPg1yWY8nHa0JGHKCU0i76e5FB+c6Xs52DRRf9mprjMuA0HZYin0v+gZ1Eex
 egAO0J8G3vnCel14XZZ8y4oQTWVgbw2mC1OkEK0+rQEg==
Message-ID: <3abd2dfe-e4c9-42d0-89a4-4c340c08aea1@kwiboo.se>
Date: Sun, 14 Apr 2024 15:56:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add Radxa ZERO 3W/3E
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Heiko Stuebner
 <heiko@sntech.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240414131529.1730506-1-jonas@kwiboo.se>
 <20240414131529.1730506-3-jonas@kwiboo.se>
 <efd1eb32-afd6-4383-be45-89b0f71f118f@linaro.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <efd1eb32-afd6-4383-be45-89b0f71f118f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 661be0993b53c644336290d9

Hi Krzysztof,

On 2024-04-14 15:33, Krzysztof Kozlowski wrote:
> On 14/04/2024 15:15, Jonas Karlman wrote:
>> The Radxa ZERO 3W/3E is an ultra-small, high-performance single board
>> computer based on the Rockchip RK3566, with a compact form factor and
>> rich interfaces.
>>
>> The ZERO 3W and ZERO 3E are basically the same size and model, but
>> differ only in storage and network interfaces.
>>
>> - eMMC (3W)
>> - SD-card (both)
>> - Ethernet (3E)
>> - WiFi/BT (3W)
>>
>> This adds initial support for eMMC, SD-card, Ethernet, HDMI and USB.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  .../dts/rockchip/rk3566-radxa-zero-3e.dts     |  41 ++
>>  .../dts/rockchip/rk3566-radxa-zero-3w.dts     |  26 +
>>  .../boot/dts/rockchip/rk3566-radxa-zero3.dtsi | 443 ++++++++++++++++++
>>  3 files changed, 510 insertions(+)
> 
> How do you build your patches? That's rhetorical, because they cannot be
> built... Missing Makefile.

They where built using the generic .dtb-file make target, will include
in Makefile in v2, thanks.

> 
> Are you sure therefore that your dts pass dtbs_check? If this is not in
> Makefile, how did you run the command?

I built and tested dts files using the following make commands:

make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 defconfig
make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 CHECK_DTBS=y rockchip/rk3566-radxa-zero-3w.dtb
make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 CHECK_DTBS=y rockchip/rk3566-radxa-zero-3e.dtb

Regards,
Jonas

> 
> Best regards,
> Krzysztof
> 


