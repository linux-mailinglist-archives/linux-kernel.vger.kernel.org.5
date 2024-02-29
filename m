Return-Path: <linux-kernel+bounces-86577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7EA86C75B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7551F235D5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A387A728;
	Thu, 29 Feb 2024 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvy2HkJj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888E761665;
	Thu, 29 Feb 2024 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203934; cv=none; b=n77K+OItrJS9+s0J6yOla48X/1VU+gISc0IGSlV1CSES2lH2vCH6cPDeIHshG/12cBkjnQ7A1KyjEc7c8xP4A4KacXgWTy6qcg+/hhwFPyfkYWbT/2rL+2Mu9K03ZZW7JYjzI3Dkmz+d7FjMmpLABhCFyPBm9sCjrhHl8fb0dmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203934; c=relaxed/simple;
	bh=tFIRN6AD7OJmcls33kRXGPl2Q5cmwc4WEirIvdGkHzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYka7F0Khmp1FEqZBeMmjC9yXUK/6bEEcJQoMtdvicDz3exwhFfNQMX4Nq5gzmZccd1zQ9QBUQPqQLEAceIJbhMAJqUhaiG4e6VRwMEjJPjzqfvlapuQvrfVg+B2qe5PoAwrbmWZDdDSW5Ahru1MJBIaGBGaaEalLLKpR4d0PZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvy2HkJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C61C433C7;
	Thu, 29 Feb 2024 10:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709203934;
	bh=tFIRN6AD7OJmcls33kRXGPl2Q5cmwc4WEirIvdGkHzU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qvy2HkJjQRFvy49WbBPN6hh/2n2KJejdturTF3m9Zr0Zr6A9utMib5ESLThImKW0F
	 9aonzpE+JIwUkl2pEbtSDK2hoiWbWKMF3dReGzkeM1B2bFt+o/Xd1DzUwiJ2Dnpf+n
	 fobSTAdyYYl5i/4tCEzAH7ZDj8GMU3RpF7SkqDtKt08KKfzF5YD1rbQh0GFhYP5R4C
	 Fqug2EHJQydIhLS8hYUv57Zxx/iWIn6ALQNXrLAIw7vqy9G1NZ0TjiuzCq0sNE9i65
	 ZI4qoMYGEFm0tesRCAtTC4eMu3Xsxn7z7xR0y6MmKnZEjMdaKKRRa8956NqvhLveQN
	 yuD7qtUtBuZuA==
Message-ID: <0106ce78-c83f-4552-a234-1bf7a33f1ed1@kernel.org>
Date: Thu, 29 Feb 2024 12:52:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: Add priv-flag for
 Switch VLAN Aware mode
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Jiri Pirko <jiri@resnulli.us>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vladimir.oltean@nxp.com,
 hkallweit1@gmail.com, dan.carpenter@linaro.org, horms@kernel.org,
 yuehaibing@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Pekka Varis <p-varis@ti.com>
References: <20240227082815.2073826-1-s-vadapalli@ti.com>
 <Zd3YHQRMnv-ZvSWs@nanopsycho> <7d1496da-100a-4336-b744-33e843eba930@ti.com>
 <Zd7taFB2nEvtZh8E@nanopsycho> <49e531f7-9465-40ea-b604-22a3a7f13d62@ti.com>
 <10287788-614a-4eef-9c9c-a0ef4039b78f@lunn.ch>
 <0004e3d5-0f62-49dc-b51f-5a302006c303@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <0004e3d5-0f62-49dc-b51f-5a302006c303@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/02/2024 11:27, Siddharth Vadapalli wrote:
> On Wed, Feb 28, 2024 at 02:36:55PM +0100, Andrew Lunn wrote:
>>> What if there is no kernel behavior associated with it? How can it be mimicked
>>> then?
>>
>> Simple. Implement the feature in software in the kernel for
>> everybody. Then offload it to your hardware.
>>
>> Your hardware is an accelerator. You use it to accelerate what linux
>> can already do. If Linux does not have the feature your accelerator
>> has, that accelerator feature goes unused.
> 
> Is it acceptable to have a macro in the Ethernet Driver to conditionally
> disable/enable the feature (via setting the corresponding bit in the
> register)?
> 
> The current implementation is:
> 
> 	/* Control register */
> 	writel(AM65_CPSW_CTL_P0_ENABLE | AM65_CPSW_CTL_P0_TX_CRC_REMOVE |
> 	       AM65_CPSW_CTL_VLAN_AWARE | AM65_CPSW_CTL_P0_RX_PAD,
> 	       common->cpsw_base + AM65_CPSW_REG_CTL);
> 
> which sets the "AM65_CPSW_CTL_VLAN_AWARE" bit by default.
> 
> Could it be changed to:
> 
> #define TI_K3_CPSW_VLAN_AWARE 1
> 
> ....
> 
> 	/* Control register */
> 	val = AM65_CPSW_CTL_P0_ENABLE | AM65_CPSW_CTL_P0_TX_CRC_REMOVE |
> 	      AM65_CPSW_CTL_P0_RX_PAD;
> 
> #ifdef TI_K3_CPSW_VLAN_AWARE
> 	val |= AM65_CPSW_CTL_VLAN_AWARE;
> #endif
> 
> 	writel(val, common->cpsw_base + AM65_CPSW_REG_CTL);
> 
> Since no additional configuration is necessary to disable/enable the
> functionality except clearing/setting a bit in a register, I am unsure of
> the implementation for the offloading part being suggested. Please let me
> know if the above implementation is an acceptable alternative.

This doesn't really solve the problem as it leaves the question open as to
who will set TI_K3_CPSW_VLAN_AWARE. And the configuration is then fixed at build.

Can you please explain in which scenario the default case does not work for you?
Why would end user want to disable VLAN_AWARE mode?

TRM states
"Transmit packets are NOT modified during switch egress when the VLAN_AWARE bit in the
CPSW_CONTROL_REG register is cleared to 0h. This means that the switch is not in VLAN-aware mode."

The same problem would also apply to cpsw.c and cpsw_new.c correct?

A bit later the driver does this

        /* switch to vlan unaware mode */
        cpsw_ale_control_set(common->ale, HOST_PORT_NUM, ALE_VLAN_AWARE, 1);
        cpsw_ale_control_set(common->ale, HOST_PORT_NUM,
                             ALE_PORT_STATE, ALE_PORT_STATE_FORWARD);

The comment says vlan unaware but code is setting ALE_VLAN_AWARE to 1.
Is the comment wrong?

-- 
cheers,
-roger

