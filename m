Return-Path: <linux-kernel+bounces-30987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EE9832723
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0093B24E61
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B2E3C473;
	Fri, 19 Jan 2024 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="X1jNMqVY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SR5BRVrL"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EB83C087;
	Fri, 19 Jan 2024 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705658293; cv=none; b=KCTZAsfjznwQ35zFdtVajqr9ri9saG2zBXKI5HQe86z3w3lAi3eeS41gqxxOiBmEXkiw8JUQyZ6GWtW04LplR5IjSllWOFt3+a/n9DTB2sMSiVagkhT8+koZO/2G1XQegHuakM0GHkhzPb+BWi+G6pXZ48fVZvcxva7pCxMKNEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705658293; c=relaxed/simple;
	bh=laGQpW42lgmBqwhwGuEYTUyeGm+KG2KnoNFzaeak+ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3tO85ukXMahziu1/BZPZ+6Am4FtD2IR45qhUZ92oLN10BHdPx+rL8nZitXHQzNfXLMIqpcGKizf2rIP2GwRte0ahWx77HzHiGXeE6DHkXRspLMuM/PMfqJp53acadITdEKiNC+vs+KB8cpAJqK6vs5hUPIpOAvlE+eKHBe1UQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=X1jNMqVY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SR5BRVrL; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id BA3915C0190;
	Fri, 19 Jan 2024 04:58:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 19 Jan 2024 04:58:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1705658290;
	 x=1705744690; bh=Y1aAdvlrmWl8c1Tb12LCfyP8q3aR+uk5/BpRCazyGSE=; b=
	X1jNMqVYz49sOP0C0Vc4PJW97jmxq6UQ2UC0rsJrpsTK00pW+PHYfIBl5zvqGQBw
	gP3ewePK26vvrxqU7wYnNEzAjXyaiShGt+xNTYxDSWsULztwN4fXUprw7Gl718h3
	R8EGaTDMgWBfetU8uKn0RRvXug7s1oIrnkZxkbZQX8xVAKrweaxy8Hrzvk6kQ03D
	1aiIZoXC2WatQgwDRPEo5I7M/JRVaf0nwMGqvij1LJGUxihvN/Dnd9MFOunx8SxE
	WndofkWplYMtbq2nkO9GPA+yB6pT6i4at1nF/kMRDD+T8dkD+rMjk+hut215HGmC
	Tlsqxoeo8KfTZs6RNGyibw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705658290; x=
	1705744690; bh=Y1aAdvlrmWl8c1Tb12LCfyP8q3aR+uk5/BpRCazyGSE=; b=S
	R5BRVrLaNBjRnwAypJDfgXVDEqfNCgQK7RChbBlfTqPAcU+Jtto41X7fUxnOwnEh
	laEk5HnCugNoN3Qb2UkKqNA6mn9OjqOpus6Wl/svwq1pK0gNG0I+wgI5QYJq46f4
	zk+IpymHsNcoaErf84YeXADgTFKerDXxH2lhAtiLq61+5oVa38I/jOzniw5iVvb2
	eMt8URBC6fajfnqzKM8qi6z6jlnBFOHfzpu2K4NSh0hh4f/EGhRqYtmBDCLBY3pm
	2yuUSrNw6WZZLMlfdaxni1OX2AW55CiuOZaZaec/Oj18O967bhdd2EgItqQ3/wcR
	ztFqrZMTCwDdNk8rE+SoQ==
X-ME-Sender: <xms:skeqZd1ZOwSVwqXKK1H3retPkKzKJ8ryrfB8EnnT1L0FlO7-62rgsQ>
    <xme:skeqZUHts-VF2y0YHMoIOCJ6HUUGBMWXyeCvYUsnU9vF9d0c1ibrK47wte6APrxUe
    LUdz1i4DK_toRWu0Lk>
X-ME-Received: <xmr:skeqZd7CEIJ5dvjkA9bdyp_aagYHvYGVJDJV0uXGr-py0HMrbqgPIWqw6nhqR2OeP7E3wLh8-tItQAObWBwxFSNsv68UyOS7lyqfz5k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdektddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepleeuffehheegleeuvdelgffhueekjeetueevuefhffdtgfeu
    hfeggfeukefffedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:skeqZa3Ywd0wWfQ52scga-_H_1nOBPDpGdWOWZzUaTXJtWyRhRGnqw>
    <xmx:skeqZQF09JVBR1zXR320p0bQD8tUnlDP7i00QiYSGY2VFrNTIU3e8w>
    <xmx:skeqZb_mIMmgS0izaxwfTNcCTNOGEiUImP7oqktlNmmay5Cdu_kP7g>
    <xmx:skeqZT8nSsAuJ15SpuM2zujvSGi6sukN62vI4pDV5ZOQP09SICFKBA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jan 2024 04:58:08 -0500 (EST)
Message-ID: <57c76891-afca-40e8-ad80-21dc7da9e663@flygoat.com>
Date: Fri, 19 Jan 2024 09:58:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/15] MIPS: traps: Give more explanations if ebase
 doesn't belong to KSEG0
Content-Language: en-US
To: Gregory CLEMENT <gregory.clement@bootlin.com>,
 Paul Burton <paulburton@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240118155252.397947-1-gregory.clement@bootlin.com>
 <20240118155252.397947-5-gregory.clement@bootlin.com>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Autocrypt: addr=jiaxun.yang@flygoat.com;
 keydata= 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
 HVO98ZmbMeg=
In-Reply-To: <20240118155252.397947-5-gregory.clement@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/1/18 15:52, Gregory CLEMENT 写道:
> With the expanded support for placing the kernel in XPHYS rather than
> just KSEG0, scenarios where ebase doesn't belong to KSEG0 are more
> likely to occur. In such cases, we currently experience a substantial
> and perplexing stack dump without any accompanying explanation. To
> rectify this, we aim to replace the uninformative stack dump with a
> warning that offers a clear explanation of the issue.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

> ---
>   arch/mips/kernel/traps.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 355d0f0709de8..911d2233d6d0b 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -2347,10 +2347,13 @@ void __init trap_init(void)
>   		 * EVA is special though as it allows segments to be rearranged
>   		 * and to become uncached during cache error handling.
>   		 */
> -		if (!IS_ENABLED(CONFIG_EVA) && !WARN_ON(ebase_pa >= 0x20000000))
> +		if (!IS_ENABLED(CONFIG_EVA) && ebase_pa < 0x20000000)
>   			ebase = CKSEG0ADDR(ebase_pa);
>   		else
>   			ebase = (unsigned long)phys_to_virt(ebase_pa);
> +		if (ebase_pa >= 0x20000000)
> +			pr_warn("ebase(%pa) should better be in KSeg0",
> +				&ebase_pa);
>   	}
>   
>   	if (cpu_has_mmips) {

-- 
---
Jiaxun Yang


