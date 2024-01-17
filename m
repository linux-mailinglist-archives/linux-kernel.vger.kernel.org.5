Return-Path: <linux-kernel+bounces-28884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF511830432
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5922E282012
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220561DA53;
	Wed, 17 Jan 2024 11:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="RWK94BK9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T+Sxt6yr"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47341D526;
	Wed, 17 Jan 2024 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489721; cv=none; b=gXqvMLYpmKvJ2MXy1DoJB9P6PCPwGp6ZwN+m89jspj95iwt4NSLQE1+C32vHol8QrYBaRT47jR1lkOZu7akhY9WQWNnIMvmTLS1RRl55j6JPjbt1njmAFdk5t+TU6OUwQ8meJWdVNDkBjQ40xwgOVvXhphiIZD1D9XMs9o9e87I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489721; c=relaxed/simple;
	bh=5to/SEBhpG45PyLin/NYVNs5jXUMbCWKGAK4oerrh7M=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=dfxGNhkFjd5ofgu3Hc1n2++BeGeb1mTA46b+1b4ZCsI9chN+KdX7LHilOLIJ+u8N0x6yIvHx1MuySeoNftVps4/MKENDhKjwelDUQCTv1gN8fJabY/uB8BAK9JSdp9HwEEkNH2EtPjPio4q4b6C91Rz5UxHcL6gzLoit3St1ktQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=RWK94BK9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T+Sxt6yr; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 957035C00EA;
	Wed, 17 Jan 2024 06:08:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 17 Jan 2024 06:08:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705489718; x=1705576118; bh=311pCe0emuMTLSq5aSul2+ArtVgHggN/
	QoQwzWAyx/w=; b=RWK94BK9Up75d0z4T3fH8SbezeR9kkCVyQa1mdBFfRPyPysT
	/f13KthU/jbDM7CbGXwetakeogGkdnxidca24QhZavTNNvRuKHaZBiQIDoVRsV8M
	42xqgB8Ui/VBJtZqe36WwGE+reWFj30YDC4Rc/m9cRXoe8otdB/OG5HnskTuVSi6
	HCMVnbH9imsXuZNNU6GJAm6zA/7bEyNmJyHmwCN624svDedohfTfJ8rXdTyhYGs+
	0Qd9VqC41Pd0qu6CL/Gb2i8BmoLQXGRA+yVYMtnxPSsOvY0VdNB9oEIEW3gff1yb
	ztJWZ9TrH1GqU3c8uZ74Ya5W6QMJbIGZOvm8ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705489718; x=
	1705576118; bh=311pCe0emuMTLSq5aSul2+ArtVgHggN/QoQwzWAyx/w=; b=T
	+Sxt6yrMf2wx3FuG3P5iLABde/mbHKsHJjzXwJYUgc7POcKui8b2x+KdntrjCA70
	f5tF4HynfNKEox8BbFBDpnmfo1FvT+DOIV7W+b71FknoYoYNERVDXeHZ4b0XIuDC
	SDJAtXA+vv6B2pS6NXYCHCwdHAXfNLjcwIwJ0UfNO6G+ouL99FLLCRy9UVsVWr0W
	NpzDYL1AP/vsRRN7D2Qx27VWyshTb5bRziOMWdXyQ+ZiqLX5xeObhCLtQ8177qDS
	DJOnT5jYi3PeBNM59hio1nbQzk6vT+yVjyZPs/t10Kd+7uflhUtHHwxKS/yWZHAO
	CRTz9iGg6YLsmRsrHxtYg==
X-ME-Sender: <xms:NbWnZc9z2ebyYqYuUaWAUAbIvlf7uMcGLFRLoPWs03aJ5tyMzmQeTA>
    <xme:NbWnZUtlbDX4CKLnht2nXBSR03r2DxEJOO3BBbqC3nz93Y3uvQhQ629miTz2YaijO
    BglhDwCjA>
X-ME-Received: <xmr:NbWnZSDbrIS0aQUYpXNl2evE6ZZ_8OM8qOPYjWYRPYaQ09Hk6GA2hRiPJEfVEzNxfT9FveUDBc2Iw6amNuD8cZLmJYCWMc59jZNNVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejhedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefvihhm
    ucfnuhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvg
    hrnhepheehgfelhfffgeefkefgjeelkeduleefvefhgfekgfetfeetvdeigeekjedvffeh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimh
    esfhgvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:NrWnZcd429D98SVxN9IeffEiZOk8Fezp7Gyh9W7o6W00dxyjYrq-xA>
    <xmx:NrWnZRP7rEEHxgTvb-j-WI4NubWItTuDyj0xMe5m38vIwUHd3s3jOQ>
    <xmx:NrWnZWmVpNBRIQyNPyWgZiNSmKJcOTT1bHKo0ljga-5tH826TqCz9g>
    <xmx:NrWnZSF45HuA1sNvOXZDYClx-WLZwk2e0f0wHLnnvperGJo0eyy-zg>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jan 2024 06:08:33 -0500 (EST)
Message-ID: <66a63c5f-d26e-400a-910a-3d4ebb11f286@feathertop.org>
Date: Wed, 17 Jan 2024 22:08:31 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: rockchip: Add rk809 support for rk817
 audio codec
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Chris Zhong <zyw@rock-chips.com>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, Zhang Qing <zhangqing@rock-chips.com>,
 linux-kernel@vger.kernel.org
References: <20240116084618.3112410-1-tim@feathertop.org>
 <20240116084618.3112410-2-tim@feathertop.org>
 <20240116193701.GA286794-robh@kernel.org>
 <64bce36c-468a-43b6-9d8d-0c20fbd53939@feathertop.org>
 <71413ca3-1a14-4eda-ad29-dc5fcbe5afb3@linaro.org>
 <6d828e2d-a25b-4784-9905-4a264b7d78fe@feathertop.org>
 <d3a764d1-c8bb-4ad6-be0d-40d37efaad69@linaro.org>
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <d3a764d1-c8bb-4ad6-be0d-40d37efaad69@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/17/24 21:57, Krzysztof Kozlowski wrote:
> On 17/01/2024 11:38, Tim Lunn wrote:
>> On 1/17/24 21:12, Krzysztof Kozlowski wrote:
>>> On 17/01/2024 10:37, Tim Lunn wrote:
>>>>> You can drop the description.
>>>> Yes just 1 clock, i will fix this.
>>>>>> +
>>>>>> +  clock-names:
>>>>>> +    description:
>>>>>> +      The clock name for the codec clock.
>>>>> Drop.
>>>> Just drop the description? I dont think can drop the clock names as the
>>>> driver use the name to lookup clock:
>>> Description. But anyway the problem is that adding clocks should be
>>> separate patch with its own explanation.
>>>
>> Right, but I am not actually adding any clocks, just documenting what is
>> already there.
> You are. Binding did not have any clocks, now it has.
Ok, I will split the clocks into a separate patch.
>
>> There are already boards using this codec with rk809 in dts files and is
>> working fine from driver side.
>
>
> Best regards,
> Krzysztof
>

