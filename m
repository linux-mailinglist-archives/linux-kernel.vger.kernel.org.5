Return-Path: <linux-kernel+bounces-80620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34570866A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92CF3B21595
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64E61BDD0;
	Mon, 26 Feb 2024 07:11:38 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8892F1B94C;
	Mon, 26 Feb 2024 07:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708931498; cv=none; b=Eub084S+gSqgmy8zLG7CYm1b1ERFCgQcIH+jTfvdJF6woT9ntlJcr/EZQgz1idTD97VYg7FirNh9Pppfn7H2DZWuMeFJ2TL776DFAF4Bi3qssdea8O3TGHjxJR1nvMixriBbWbjYwFQHXYTXhM0jovS6R9bI7F0gVp3pPFQafcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708931498; c=relaxed/simple;
	bh=drRX/2kTOl588wz6Fp7lOgNAf6QltdwsErCkiF4/8Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=tW5QeOIgW5v9TBH2DoUPZ6GFmIeykMuOv1L/tYkPrMB9YMaKx2aOfLp6G8ICNiOSxEzZ46Mlw9O2mrdWJtw1P7jJEqhNOnazMBvIcNdABj9euB65oFExFMqzanpWJp0B5rxR8aXdYbZxsULQobqk7MUbkGghOACv0i8GDsAvsnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (ip5f5af3a7.dynamic.kabel-deutschland.de [95.90.243.167])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 73C9E61E5FE04;
	Mon, 26 Feb 2024 08:10:25 +0100 (CET)
Message-ID: <74cd8a61-3d9f-437e-8e3a-22139e23bda5@molgen.mpg.de>
Date: Mon, 26 Feb 2024 08:10:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ARM:dts:aspeed: Initial device tree for AMD Onyx
 Platform
Content-Language: en-US
To: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
References: <20240110033543.799919-1-supreeth.venkatesh@amd.com>
 <572d53516dee6db5af7089090056185abb4e78c7.camel@codeconstruct.com.au>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, joel@jms.id.au,
 andrew@aj.id.au, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, robh+dt@kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <572d53516dee6db5af7089090056185abb4e78c7.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Supreeth,


Thank you for your patch. Should you resent three more nits.

Am 26.02.24 um 07:55 schrieb Andrew Jeffery:
> On Tue, 2024-01-09 at 21:35 -0600, Supreeth Venkatesh wrote:
>> This patch adds initial device tree and makefile updates for
>> AMD Onyx platform.
>>
>> AMD Onyx platform is an AMD customer reference board with an Aspeed
>> ast2600 BMC manufactured by AMD.
>> It describes I2c devices, Fans, Kcs devices, Uarts, Mac, LEDs, etc.
>> present on AMD Onyx platform.

I’d capitalize I2Cs, UARTs, and MAC, but would write fans.

Also, could you please make the summary a statement by adding a verb in 
imperative mood. Maybe:

Add initial device tree for AMD Onyx Platform

I’d also add spaces after the colons in the commit message summary.

[…]


Kind regards,

Paul

