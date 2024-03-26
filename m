Return-Path: <linux-kernel+bounces-119806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CCC88CD2E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B9AB2280E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C0613D244;
	Tue, 26 Mar 2024 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Miw8WXY/"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4BD13CAA0;
	Tue, 26 Mar 2024 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711481261; cv=none; b=tcIvdjWIM0PE16dImfY9gvQuDThmItkoDAhfCAT6iQUftLFdt8AVAPnrqcl13N9ah0OGK3591KI1ql8ApddT7FTywjlqskZVhwXjAtGk1TIVFADFvz2ls1q0zUn2lW+vcOQERg8D+CiiaFcPeacMACU4XPb5DB6H+s13XxdMpd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711481261; c=relaxed/simple;
	bh=J3Cb4quAeleMzCXbZCqtDGBBj9mxmmUw5l05OAG8eEA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nEZONm4ehNt9VczPIv5aI5dATzjr55wxPAeGS7pb3tiF//GvetPvcJRcoyS5uBT6hnDvJIb/f5FosZQ6MZRE0h/J+x17yvcsnK0gPxO1AtPYy/5RqTp9FvWnRXhwg+GM19+QrC5JCYdLlz51DytB9cWhaBHzsbLSJwPSHIK62sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Miw8WXY/; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711481249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRfn67uuUy3m2b7tbUxgtfNJ5qaXNBwO1gHJs31ZlpQ=;
	b=Miw8WXY/QkEWb0N8TybloxXcFTXnGju0WBqcaYBGnwNloBil+GABYU49LGx83oep2QXAcG
	Eu/CXEt5zwWf9xzXktAF8+tBuB/W1CZZDbZi2tuR3oHdeTGrMCbbuYfl2ewKyY4T9D8jew
	HPIhwLMkUpQmbpMRlCfoA3QoFSFfc2CEw3yBwouwygXICFRMz2YE3ob5lN4UmrNOHRqF0H
	dmarNJbIgNDOwKMIG6bt8NiefneSGAfpcnnjqKiuzlDFgx6vOXjwE6sKr6tqFOI6hjCrz3
	dvryb2FltYOw3lhwAJX9wF5W1eAOAs4Q04n4tqwmFg7/3FWJZeEZ9wdAXQqArQ==
Date: Tue, 26 Mar 2024 20:27:29 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Rob Herring <robh@kernel.org>
Cc: conor+dt@kernel.org, kernel@collabora.com, devicetree@vger.kernel.org,
 sebastian.reichel@collabora.com, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, boris.brezillon@collabora.com,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH] arm64: dts: rockchip: quartzpro64: Enable the GPU
In-Reply-To: <171148006524.3222394.1157008244152468379.robh@kernel.org>
References: <0f3759ee390f245dac447bbee038445ddfecbec0.1711383286.git.dsimic@manjaro.org>
 <171148006524.3222394.1157008244152468379.robh@kernel.org>
Message-ID: <13ed1665e2e3ef4107cb96fcbcd0c3c7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-26 20:11, Rob Herring wrote:
> On Mon, 25 Mar 2024 17:19:04 +0100, Dragan Simic wrote:
>> Following the approach used to enable the Mali GPU on the rk3588-evb1, 
>> [1]
>> do the same for the Pine64 QuartzPro64, which uses nearly identical 
>> hardware
>> design as the RK3588 EVB1.
>> 
>> The slight disadvantage is that the regulator coupling logic requires 
>> the
>> regulators to be always on, which is also noted in the comments.  This 
>> is
>> obviously something to be improved at some point in the future, but 
>> should
>> be fine for now, especially because the QuartzPro64 isn't a 
>> battery-powered
>> board, so low power consumption isn't paramount.
>> 
>> [1] 
>> https://lore.kernel.org/linux-rockchip/20240325153850.189128-5-sebastian.reichel@collabora.com/
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts | 14 
>> ++++++++++++++
>>  1 file changed, 14 insertions(+)
> 
> My bot found new DTB warnings on the .dts files added or changed in 
> this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the 
> warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to 
> reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y
> rockchip/rk3588-quartzpro64.dtb' for
> 0f3759ee390f245dac447bbee038445ddfecbec0.1711383286.git.dsimic@manjaro.org:
> 
> Error: arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts:288.1-5
> Label or path gpu not found
> FATAL ERROR: Syntax error parsing input tree
> make[3]: *** [scripts/Makefile.lib:427:
> arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:485: arch/arm64/boot/dts/rockchip] 
> Error 2
> make[2]: Target 'arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dtb'
> not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1387:
> rockchip/rk3588-quartzpro64.dtb] Error 2
> make: *** [Makefile:240: __sub-make] Error 2
> make: Target 'rockchip/rk3588-quartzpro64.dtb' not remade because of 
> errors.

This error can be safely ignored, because this patch is supposed
to be applied together with a recent patch series, [1] or in more
detail, after one of the patches in that series [2] that adds the
missing "gpu" node.

[1] 
https://lore.kernel.org/linux-rockchip/20240326165232.73585-1-sebastian.reichel@collabora.com/T/#u
[2] 
https://lore.kernel.org/linux-rockchip/20240326165232.73585-3-sebastian.reichel@collabora.com/

