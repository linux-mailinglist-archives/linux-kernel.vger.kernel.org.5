Return-Path: <linux-kernel+bounces-65485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A470B854DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72901C28AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3BC5FB90;
	Wed, 14 Feb 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="vEnP7+eA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KpKSvEUN"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFEC5F865;
	Wed, 14 Feb 2024 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926814; cv=none; b=FTK00fIjGhHlvXlXe/VsqcKwuEXzGkVTCb/o213J0uDfvGzE9SQ8BpVTNIU9nC8qURDmAzDh6NOH+SOtFqNGBIBPzxoBtU35/7zjX6/IIGk1eU/Y5nqX/jBzYgP9H5JVzJ07O9oaDO75TZ4DRosNI3zOIqCaeVayk5kehd6vQHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926814; c=relaxed/simple;
	bh=laNZL1qkr6vvHLZ55G/iXz2T7t7aplhdDjaSRRekAhk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=WAf+FiFcOujOzbuFCwEzKdmCVAcYCLQJlazZa40gHOxBD5WPj7N3B+p4+7gEbfBw6iv2qzYsuN+XMby/ajW3vN/mbTJyoonYDOtT8LxPa4hD3eTIDLPDELift2SjeyVLWGHkrS77WOwzuQZN7TbUzGp5XIJiaMeC1IfVTOC7hq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=vEnP7+eA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KpKSvEUN; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4305D18000F7;
	Wed, 14 Feb 2024 11:06:51 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 14 Feb 2024 11:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707926810; x=1708013210; bh=deSom4GjuR
	klhwqg007ZgFkO+lEEC7ONrawL97ILwOQ=; b=vEnP7+eADkhKOnCPeDLox5/IMC
	nb0fu+Li12ouTj865pq6esKkpuOO9UQ/7HahJEvAhC3kMh885juyINjg4RiHuS9N
	tl/re3nT1PpA8Sgf5/h7fnJ68aBKFoWHaylxphth07ALzlFP/NgrxW6u9oksU4ii
	jIgNgAev62dW31T0RGPGMSxPpsDZKWINKapOsq/JtP2L9LHBUTkJUZRSkI4+p5Oo
	TVlcEV3SSuLsdpl03T1g3EHCDs+B6hVHCEcGRO5yXxSrVwMy2rQBME/C2lKFSeMK
	hif1IAETobwM7uZ6xBdhEL7KjfZsdX9iUFEa2OY6KHsItdGgF89hGlmLMofA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707926810; x=1708013210; bh=deSom4GjuRklhwqg007ZgFkO+lEE
	C7ONrawL97ILwOQ=; b=KpKSvEUNINZk4o4OUI82TxqluNWpmkoyyrBtl+QRI9a8
	K84NeOGNwuBiR6hn8J+BBKaRd2UV2Phd98cK4oMmyj3c+a7eIDS8a8DiIAuR/8cJ
	vdIOuZ+/LMipAvGNu+Vp2MWifn1BH8oqAWqtrd1IvtaBMzPgMJMzS+ARuBbNA/o2
	AllUID/iRXrToShz+zyTcmpPP0BMbvjQxcDODYcgaKJRuSpoJY43RILRwYn4n1KX
	hCaqtvB5wM4oV4vuf/YdU4zXqkw3+l/mhG8wV/jYNXhw3ksWSFfWuQAO5tj5lwkX
	0yg9oYCjz5KIPMioZLCJvCHzxWRklb9cHNxC1MSy0Q==
X-ME-Sender: <xms:GeXMZad6vEzx9l6MOHVMmIG2Zs_UA9-G1qowd8O8ZzP-XsbEvcXIfQ>
    <xme:GeXMZUNfXC5_3FxzZNJArnLHx9yPZK1FbjoH5EEChnSZyfJNq3wz5ZxLG3Vlv1GmR
    ugGT3SOCeVbR-fe3H4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:GuXMZbgZD57qyDNDopse154lgj_bstb6PI9rWR-y2QAURa01u4wl6g>
    <xmx:GuXMZX-vDGh35pQlAWAwb88hH3m79Sud1hwC6R4WhEG75TYmgo0TPQ>
    <xmx:GuXMZWuXatqYasoqXnwDeAVXGEJgSnDc8M6Fwyf2SJh9QQ0-cF_BFw>
    <xmx:GuXMZT9A-LpEBg3xhL3rRRA71p7GJYGRXFD37JXY5CL3VMsS5mlgF_vhmiQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DF83BB6008D; Wed, 14 Feb 2024 11:06:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c6e55baf-4f0c-4342-971a-713ed55f5a51@app.fastmail.com>
In-Reply-To: <867cj75q52.wl-maz@kernel.org>
References: <20240213225619.11726-1-rdunlap@infradead.org>
 <867cj75q52.wl-maz@kernel.org>
Date: Wed, 14 Feb 2024 17:06:06 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Marc Zyngier" <maz@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Rob Herring" <robh@kernel.org>, "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Peter Rosin" <peda@axentia.se>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] of: OF_IRQ: select IRQ_DOMAIN instead of depending on it
Content-Type: text/plain

On Wed, Feb 14, 2024, at 10:52, Marc Zyngier wrote:
> On Tue, 13 Feb 2024 22:56:19 +0000, Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> diff -- a/drivers/of/Kconfig b/drivers/of/Kconfig
>> --- a/drivers/of/Kconfig
>> +++ b/drivers/of/Kconfig
>> @@ -80,7 +80,8 @@ config OF_ADDRESS
>>  
>>  config OF_IRQ
>>  	def_bool y
>> -	depends on !SPARC && IRQ_DOMAIN
>> +	depends on !SPARC
>> +	select IRQ_DOMAIN
> 
>
> This seems to be moving is the right direction.

Can we move the 'select IRQ_DOMAIN' under CONFIG_IRQCHIP
then and remove the individual selects from the irqchip
drivers? It looks like CONFIG_OF (other than sparc) now
unconditionally enables OF_IRQ and IRQCHIP anyway.

     Arnd

