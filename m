Return-Path: <linux-kernel+bounces-63443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D86D7852F69
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818B31F22992
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A27D3717D;
	Tue, 13 Feb 2024 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3kXMLLw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA80236AE3;
	Tue, 13 Feb 2024 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824059; cv=none; b=t5/5E+lhWHouLk/gQl7UXIen3GawiQ8dNTKWz8mbt1BrCk3Xjc4yIkinffWo03TTTxYd8mt3+npaaT45qZQqV2OQuHMUCte6Jchv6Aaqp6B+CZ022lP8X/SxDo6SF9NUImlNj9p+QBocK6Uhi56arX6a7+6on8tSCdccpdSHn8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824059; c=relaxed/simple;
	bh=D1yTR7Hkjf1Q/JBdRs5uAQEJoKM36Ugzbda+39ABM0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBNg63XHvdiXgBLFhRqJJaH1DZAJ6+n7ZlCkO7KU6eJ5ACnCpwTItKxrSUdb9Yq4N0XfzLL9MOqf/K+LZH3hMuTXmKwbOJJtXKEcviRf6eC9tR8/xt4wFRsiee+QB/AT+dGfpROk1qwZk6fbrIwLKysGvXQUavQtoLQyWwDYwGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3kXMLLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F87C433F1;
	Tue, 13 Feb 2024 11:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707824059;
	bh=D1yTR7Hkjf1Q/JBdRs5uAQEJoKM36Ugzbda+39ABM0A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J3kXMLLwZQcsVOJPIY46iG4E9cc8H+nNo5w3R3x4+9u7DCOZh2xN2fDPjBm9u7UB9
	 cmLBe/NueNC4Wk9+jnqkGucNGY96W4sZD2ZW5eQzIAxiuPABXiiFHUMXLQDfHQJE9s
	 0xE1zTxPMyCZlA0CTmmQppzbDAMQ9mflzdSLx45cPEceAOFV/cQ+fEDtamsJ6r2c17
	 lS2g32iH7WtGEXw7Sz1D/8JN2YqEMLGZ0LXl6d3CGhqBFi2GpqJdzY8Grv+K5b9qdE
	 DKTWkWmU4W22zMhjIO7R/qzFHudgCZNBgfA2+yNXHjVafo72SMUu7aIgLN0UdaiAaW
	 rxLPKBwBOL3Lg==
Message-ID: <4adb0a74-4789-4b9d-b970-1cd94602c27c@kernel.org>
Date: Tue, 13 Feb 2024 13:34:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62-main: disable usb lpm
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>,
 Sjoerd Simons <sjoerd@collabora.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Bin Liu [EP]" <b-liu@ti.com>,
 "Gunasekaran, Ravi" <r-gunasekaran@ti.com>
References: <20240209130213.38908-1-andrejs.cainikovs@gmail.com>
 <2629cd30-23aa-4f03-8452-ae13297fd6b6@kernel.org>
 <20240212125402.GA5043@francesco-nb>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240212125402.GA5043@francesco-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/02/2024 14:54, Francesco Dolcini wrote:
> Hello Roger,
> 
> On Mon, Feb 12, 2024 at 02:13:56PM +0200, Roger Quadros wrote:
>> On 09/02/2024 15:02, Andrejs Cainikovs wrote:
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>>> index 464b7565d085..c49fbce5cb70 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>>> @@ -663,6 +665,8 @@ usb1: usb@31100000 {
>>>  			interrupt-names = "host", "peripheral";
>>>  			maximum-speed = "high-speed";
>>>  			dr_mode = "otg";
>>> +			snps,usb2-gadget-lpm-disable;
>>> +			snps,usb2-lpm-disable;
>>
>> Instead of this could you please check if this series fixes the issue for you?
>> https://lore.kernel.org/all/20240205141221.56076-1-rogerq@kernel.org/
> 
> Isn't this change correct despite whatever the test results on that
> change are going to be? The manual is pretty adamant on LPM not being
> supported by the AM62 SoC.
> 

You are right. We should have this in regardless.

-- 
cheers,
-roger

