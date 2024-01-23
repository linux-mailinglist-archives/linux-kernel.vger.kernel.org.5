Return-Path: <linux-kernel+bounces-34698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0EE838643
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C04B21D99
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD021187A;
	Tue, 23 Jan 2024 04:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="aEqI77XQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QfHAgxVb"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705E61848;
	Tue, 23 Jan 2024 04:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705983048; cv=none; b=SCUb495OxRSl61ylaMw2nZiiu53+6ZRhNkPXf+YzRQ2YJBmDghuj7R7JIs8xvE8vfMasEGuqu+vbn2wis6sBjt6re7jCw4XLC6w/5b2GU+EzJtOU7nk0kTn0PtSRfZ49EAln+07PoK6BQA1Gc511iE4UaNjt0+jJaxvLvc1IEnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705983048; c=relaxed/simple;
	bh=e1iANXCHAFFGWI13ZwKAwHSge9np6yGnnnIPoEx3lBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZy/j0b/EqPtEibfg6YauNquEUkBCH4o9Pgi3pD3Od7N1FnzautFTftBNsQ+WBBcT5AShgpHE71gP+l3izRRZ1MXfykPSC7HOHiKhnRx8tj4UiBVRaf7vq1xUgmnskibAoeXD6GgRXMcDLnbjpKDePU8LlqYqv4xHTknXj9TB2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=aEqI77XQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QfHAgxVb; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 52A0E5C02FF;
	Mon, 22 Jan 2024 23:10:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 22 Jan 2024 23:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705983044; x=1706069444; bh=X1AxwnZE1mN7IbTs9hN/G30XDwpnHhRi
	KWHtMsjJUm0=; b=aEqI77XQJ4u07KvVtt6AD42ntSY7SPwR7QWMDRv/EFaSGfbd
	Dtk1PhZ+JxLzzsw809IdtRzqNM4BTLeZLaNxRDQGfS7SwMe5Pi2lTapAYet7P0SX
	DHYpMQbwe7kr7oosX+5hY5409EO+7Ue6W5jCxBFvOb3MJBt5NEGlt6neUKOcxfgb
	zYt8/ysAbh3mkirJ0acAZhpXgI/1M2DjJpXU1l/l5ktSyH8y3lI6xB4PDXSfuHbe
	ivzfyZsZyoSVukzOpLmXezsaaiBjmJTv7DZpnDR8TH6evmj06usThJDjaQh2IFqi
	yv1f49ILCXV6vsPjRWLU/4U+gxTtHDIfj1DZQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705983044; x=
	1706069444; bh=X1AxwnZE1mN7IbTs9hN/G30XDwpnHhRiKWHtMsjJUm0=; b=Q
	fHAgxVbCVfHB8lh5RXJqESKdEPFJzwdgtykuZLFvo2eSgc07a8tXMKYM25PBzvw9
	ksL1+MnLbNauyYa/E6pmv3hUIICLycJ8M7Uxfh1f5WM8OQuA6mGIspL4sD74upcJ
	D4adpI4r6/1iC7E4NUWB0BOCEGY+rj7L6WeZPa81NcK97JExSpP+7M94uPHKCuGL
	Hb1Tg9g07jEFmUbOU2o0VKWc+ZTdiSZtKXXMh32rLcCoE2M96gev3/I29LYnQG1x
	OtglSD2mZ6xoaIpQPIj2yovrY7TzbNIEC5Q/WEmU/84A5PVCgMP/TiuLEzdGLZZx
	XocCV4fr5OaqQN6Ktcotw==
X-ME-Sender: <xms:QzyvZY47fvbmwvwVakG6Y3PISRlTm1pSxFQpGmukHDv5aNJYa8UGdQ>
    <xme:QzyvZZ4LH7AUz3tEzWaDY5tS5DaofqSEXl8FLzAfGaf0CZTReddMgN5Xm0d4gu_OY
    CpaKLd2Dg>
X-ME-Received: <xmr:QzyvZXc-sJLEjVCubf5yYB0amMFwc96MK1008N-vn-3hPjh9hBIPC1xFGe64SgRJV-iEo7upeMlpjrKeldqiAolGJ966qCI6AlRRTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekjedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhm
    ucfnuhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueegfefgveeuiedtheffgfefveejkeetiefhhfdvjeevlefhueekudeuleeghfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimh
    esfhgvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:QzyvZdLuwNmW7gtVIa2fKi7ijGvsnYQ5oG7Jym2PmuV4agGah-dLXg>
    <xmx:QzyvZcIfko-yFUUatPPba4w-m3MtsRa1okumhLC-th_aLwMPe9_QgA>
    <xmx:QzyvZextfm3wQD7NLq3YFSAzM5eK0s_yW-kVgxJ5cQWPxoX5oK7fuw>
    <xmx:RDyvZazTe1eN29OyB8mkpFbtZBqGKAmMZtr_5wsC_x1VgoHIVEGQ0w>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 23:10:38 -0500 (EST)
Message-ID: <93d775df-af84-44ff-870e-f720a33ddf34@feathertop.org>
Date: Tue, 23 Jan 2024 15:10:35 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dt-bindings: rockchip: rk809: Document audio codec
 properties
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-rockchip@lists.infradead.org, conor.dooley@microchip.com,
 robh+dt@kernel.org, devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Chris Zhong <zyw@rock-chips.com>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, Zhang Qing <zhangqing@rock-chips.com>,
 linux-kernel@vger.kernel.org
References: <20240120135529.899403-1-tim@feathertop.org>
 <20240120135529.899403-3-tim@feathertop.org>
 <04ccf5f5-1f02-42f9-b1fc-b781c54d7ae9@linaro.org>
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <04ccf5f5-1f02-42f9-b1fc-b781c54d7ae9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/22/24 19:14, Krzysztof Kozlowski wrote:
> On 20/01/2024 14:55, Tim Lunn wrote:
>> Rockchip RK809 shares the same audio codec block as the rk817 mfd, and
>> is compatible with the existing rk817_codec driver.
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.
Ok I will check this.
>
>> This patch introduces to the binding the standard property #sound-dai-cells
>> and also an optional codec child node to hold codec specific properties.
>> Currently there is only one property in this node however the downstream
>> driver shows a number of other properties that are supported by the codec
>> hardware, that could be implemented in the future. This maintains the
>> existing driver ABI and keeps consistency with the rk817 bindings.
> So you are adding a new node? Just for one property? No, just put it
> into parent node.
The existing upstream codec driver parses the property from the "codec" 
sub-node, if I
move it to the parent node here, I will need to patch the codec driver 
to search in both locations,
so as to not break the rk817 bindings.  If that is preferred, I can do 
it that way.
>
> Downstream driver does not matter at all in that aspect.
>
The codec hardware supports additional properties but they are not 
implemented currently in
upstream driver.


>
> Best regards,
> Krzysztof
>

