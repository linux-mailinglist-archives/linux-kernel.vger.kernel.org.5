Return-Path: <linux-kernel+bounces-66188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3C885584E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AACDC1C2292B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D02818;
	Thu, 15 Feb 2024 00:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="T9uBwEIR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k0eOyf14"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22E938D;
	Thu, 15 Feb 2024 00:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707956925; cv=none; b=jl1asVJhOre+/eMPG9SN+2oeq+P/R0yeUIk+egAakdr2ZA2FW3+6xX1Qv8iUZvK+RNlz6SenL3KR//MbwZXgY/0B40C8zFu6+5PM4qPEPSAjNcLGy95zxpZGH2kCfPA7NiokfpVettZtJpGfVDtxvYc94N+xI3vTiNnm0AOXud0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707956925; c=relaxed/simple;
	bh=mnIym/CvETLOTPyXJQIqqtBsy3Hph17S2YXXegKfVT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PI85Cy5i5AMjSY11kiR3Nl8Do96wUXdg9vdtvkA6z01jdJaVPDZ8c+ApwTYl+9BZNnpsm4RS2Ad/7x2XRC1sBt88i3Krlm1G4qLE+od7M5JbJz3INdrzp0xKX4RXcJk6B7QPsB9NkM1T7jZD8TEJE6q2raT+lUIKZjni9+XN9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=T9uBwEIR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k0eOyf14; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id A3C2313800A3;
	Wed, 14 Feb 2024 19:28:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 14 Feb 2024 19:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707956922; x=1708043322; bh=mnIym/CvETLOTPyXJQIqqtBsy3Hph17S
	2YXXegKfVT0=; b=T9uBwEIRpCCPLnuqGur47QNWQp22qKmF7bigQW8TrImzB7kz
	8XvLxXghbj85lO/gggHdU2iuD9L7KWcjMOnwRIFhtz/SxGr9+/gPUv+qVKu4J714
	NR+5CE9eMZvUuczfhCP8GigWd0xFVTQsXWh/xMYhEAaisq59LT1ztKrk6w19kWXw
	o1ljVMuFDXkrzK3ni17WP6ABZd6S7pdeH0VULYUoiejEkToQ/E2KRY+7VJN6QgrM
	2ka8CXYvqqKlcK6E1hNd1cjGhcUS3/N3e9sA07kswdZIJkd3jJmEV/IxwesD1QKG
	c4HV+DZFWRqzhqK96y4UIa0BBFR56vKe7/7P4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707956922; x=
	1708043322; bh=mnIym/CvETLOTPyXJQIqqtBsy3Hph17S2YXXegKfVT0=; b=k
	0eOyf14s1VkTUhnE4JZrLCn6jcgQ2UjC4BEiTcw1o4YlfULLq8f5dW50yhAyiwSb
	PCFfWzjs9WsSGZfJv2XWNRNx9kEPr6fGZgwlpMRpCpiYbhQdwus8UvDKNi+Y6Fu2
	gnI/AkSW+2NOf2XBp1a5mPLxO/5aEtsbrIy4oYIWLLD7UcQ49ZbL8RTQ5gt0iI5Y
	XC1A676wP7LfKtcUCg2cOFSbVLZT3ofYShSWCcgkswx16casuM3Hf2IPZypYB/cW
	oLhnQjJ5QIeq9LfHYImzpeGwXJdrZgENtR2Y59BtXVWGYIqSaAosowgPy1GF/HJf
	r4YmV1iWdNUCGbXBzuqCA==
X-ME-Sender: <xms:uVrNZUik4wJFIUWAdR7NMOTANcxr-SgdoOYj6wSyLp_vquvv7RVd1A>
    <xme:uVrNZdC-2-q5QUGzn7UGSUrlMT1Yc1GdSwRBSr1IznilWbA2ieWf1a07n2-sS0UKM
    622z-C8Tw>
X-ME-Received: <xmr:uVrNZcF2H6yu5_o_KUXXZD5OCFvacycjmDqoOS_exLheZW6p2BZUOxpKNe5oSve-3nw50QwtzQTfvbWS_kmGTGeGJ1FcH_4oTSGZEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhimhcu
    nfhunhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrh
    hnpeeugeefgfevueeitdehfffgfeevjeekteeihffhvdejveelhfeukeduueelgefhkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmse
    hfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:uVrNZVRi5qofvFQsTfePnTivvlscI_JpYarxNNgTevx5Sp1vCWIkVA>
    <xmx:uVrNZRwaI3qDuG_YFWK-g11VX-KlNUoLhj_Uxrw1VpF-ZZOKfoolDw>
    <xmx:uVrNZT7iHWVJdifyR-aj_ahVirr7lXs8aArQf7lGHSSoctFykU19uA>
    <xmx:ulrNZSqgj0AVOyZPelzaEV3Bv4dYS3VVc3JhpHuXm9cEzG1_SM_p-g>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Feb 2024 19:28:35 -0500 (EST)
Message-ID: <cd648b49-b954-45e5-aba7-dee85c0785e5@feathertop.org>
Date: Thu, 15 Feb 2024 11:28:33 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Fix vendor strings on Rockchip boards
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org,
 Andy Yan <andyshrk@163.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chris Morgan <macromorgan@hotmail.com>, Conor Dooley <conor+dt@kernel.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 David Heidelberg <david@ixit.cz>, Heiko Stuebner <heiko@sntech.de>,
 Jagan Teki <jagan@edgeble.ai>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Ondrej Jirman <megi@xff.cz>, Rob Herring <robh+dt@kernel.org>,
 Tianling Shen <cnsztl@gmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240214040731.3069111-1-tim@feathertop.org>
 <c03220db663279c9e83bab81f3d829e7@manjaro.org>
 <e952d127-b12d-4b5a-838b-807a876db707@feathertop.org>
 <20240214-moocher-womanless-21201b67b76d@spud>
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <20240214-moocher-womanless-21201b67b76d@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Conor,

On 2/15/24 05:12, Conor Dooley wrote:
> On Wed, Feb 14, 2024 at 03:27:08PM +1100, Tim Lunn wrote:
>> Hi Dragan,
>>
>> On 2/14/24 15:14, Dragan Simic wrote:
>>> Hello Tim,
>>>
>>> On 2024-02-14 05:07, Tim Lunn wrote:
>>>> A couple of rockchip boards incorrectly list their vendor as Rockchip
>>>> when they are in fact not manufactured by Rockchip.
>>>>
>>>> Fix the vendor strings to correctly list the manufacturer
>>> Just checking, have you verified that the old, incorrect "compatible"
>>> strings from the board dts files aren't used anywhere in the kernel code,
>>> such as in some drivers?
>>>
>> Yes I checked that, there are no remaining references to the old/incorrect
>> compatible strings in kernel code
> What about other code? Like a BSD or a bootloader? If nothing is using
> them
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> Fixes tags I think wouldn't go amiss, but I'm not expecting a resend
> with them.
I've added the fixes tags to the email thread.

Regards
   Tim
>
> Cheers,
> Conor.

