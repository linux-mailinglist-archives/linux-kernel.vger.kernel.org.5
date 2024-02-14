Return-Path: <linux-kernel+bounces-65577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0C9854EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977B01C27CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00094604AF;
	Wed, 14 Feb 2024 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fea1ZRi8"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034606026E;
	Wed, 14 Feb 2024 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929053; cv=none; b=OdsU8wy43nhqyp/XHNtWwZLWAfs6kP2iHfFsX7imX3WNe3F3+8aYBYvED+/1/Dh8SWtE7MRBfKx0/XtG0CRzslSk32zLBxGIVEkyckpFIYCHxiUQH1Hizq6sqrBOwg4ldqfhKbszQhut3VjPBnWEr46ewevsxmCiVbToMfOayFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929053; c=relaxed/simple;
	bh=nqsntL8OGHD2qtCfZTn1431gs4VNIpoR+ijDeZ97qlQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r3EnVymHbU0/WZNLmB2BKqku9KOZPiqel5PYbPxTB4ljt4M0ht1hpYCFxliKnPz/wFM7/iAHMgv3ZdCyiXWOeFo/30rvo0Dul5XRKFWf7Ur9fMyInWW6I7HEJj02vtv6TxjVHfbMMNvfXDewZYWnWVjWbhw30VWHVTe+jspafHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fea1ZRi8; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C450C000D;
	Wed, 14 Feb 2024 16:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707929043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/qbkJMJFukEG/I4dxjINRwHsnuJeklavDUuJR50Nx4k=;
	b=Fea1ZRi8P9BY5bF14o1N6xpuTMBz1n4pZTXlAGi3IvM0euqN2Elj3viNttVpzh5Vjj1xLp
	BRLYaLs3llColIVM7wAiqLa1yLezDocO3dt6sbXR9cOnOn4TlKujbgCi+Hc0ccBs6cYt7j
	Q4xOtPAZEyMihDM/Mu0UrcS1STLb4W/896sdTrhnCF7Pz0+6TceKIyLk1kkSW8kvx5qNKj
	oFTXkIo2hKoGBKE3waD35pONi12EBJQiJcKLdGro46g1ddgAy5R01W+wZK8s0eqpUxE4nQ
	W79oknBn59JWuNngOCw0QgMVBmVzDNpuqMnic9iEY9O2sugjEZskjBNf/yWE0g==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>, linux-mips@vger.kernel.org, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir
 Kondratiev <vladimir.kondratiev@mobileye.com>, Tawfik Bayouk
 <tawfik.bayouk@mobileye.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, =?utf-8?Q?Th=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 01/14] MIPS: spaces: Define a couple of handy macros
In-Reply-To: <ZcTFmUtV/mzeIBTx@alpha.franken.de>
References: <20240205153503.574468-1-gregory.clement@bootlin.com>
 <20240205153503.574468-2-gregory.clement@bootlin.com>
 <ZcTFmUtV/mzeIBTx@alpha.franken.de>
Date: Wed, 14 Feb 2024 17:44:02 +0100
Message-ID: <87sf1vj8rx.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Thomas Bogendoerfer <tsbogend@alpha.franken.de> writes:

> On Mon, Feb 05, 2024 at 04:34:47PM +0100, Gregory CLEMENT wrote:
>> Define KSEGX_SIZE to represent the size of each KSEG segment.
>> 
>> Introduce CKSEG0ADDR_OR_64BIT and CKSEG1ADDR_OR_64BIT to get an XPHYS
>> address in 64bits and CKSEG[01]ADDR() in 32 bits mode.
>> 
>> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>  arch/mips/include/asm/addrspace.h           | 5 +++++
>>  arch/mips/include/asm/mach-generic/spaces.h | 4 ++++
>>  2 files changed, 9 insertions(+)
>> 
>> diff --git a/arch/mips/include/asm/addrspace.h b/arch/mips/include/asm/addrspace.h
>> index 59a48c60a065c..03a5e2c8b5dc9 100644
>> --- a/arch/mips/include/asm/addrspace.h
>> +++ b/arch/mips/include/asm/addrspace.h
>> @@ -47,6 +47,11 @@
>>   */
>>  #define KSEGX(a)		((_ACAST32_(a)) & _ACAST32_(0xe0000000))
>>  
>> +/*
>> + * Gives the size of each kernel segment
>> + */
>> +#define KSEGX_SIZE		0x20000000
>
> well this is the KSEG size for 32bit and defined in a common section,
> so better use CSEGX_SIZE

Done in the next series.

Thanks,

Gregory


>
> Thomas.
>
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

