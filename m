Return-Path: <linux-kernel+bounces-24230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0EF82B979
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6D41F248F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524C24A27;
	Fri, 12 Jan 2024 02:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="X7Ula3Au"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7594A14
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 02:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4641:eb14:ad94:2806:1c1a] ([IPv6:2601:646:8002:4641:eb14:ad94:2806:1c1a])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40C2NFj0041670
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 11 Jan 2024 18:23:16 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40C2NFj0041670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023121201; t=1705026198;
	bh=gEL02qJ+kf4rmTWjTkIkdSy7bQtlOufhbVEFlnTcpyw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X7Ula3AuasMk3h8B+YBe3xqBoqgSzW2ZArYwMqHmPfAT4pVyO+LxLybF/itpYt6Pc
	 AFKoH8feZ5PV8DY/SsbfpcEydX/sluG85FSXmqiPB1WvVhXkBMAOd0PqgEjA4WahIU
	 nbWsNMufkrEJBM7rCH6E2jhajBrGA3dirrzCUtJGVh0xM8V+H+aPGkd5Q/vTaVPSlK
	 xDrOiJDXFRavQ7QlhLd2T5M9Cr3nBkcEbtIfqTgFv54nXssEpsj8qImuh4Rh/gvpBH
	 UMDYDjNIe5hVqtfhI841Rn6yaceEWGShFMmnMk7KadVbc+zURUGluEfwd18PZWWzIO
	 R5nWUEmEMfuqA==
Message-ID: <e5949a27-999d-4b6e-8c49-3dbed32a00bc@zytor.com>
Date: Thu, 11 Jan 2024 18:23:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Content-Language: en-US
To: "Theodore Ts'o" <tytso@mit.edu>, Neal Gompa <neal@gompa.dev>
Cc: Jason Gunthorpe <jgg@nvidia.com>, jirislaby@kernel.org,
        dhowells@redhat.com, linux-kernel@vger.kernel.org, pinskia@gmail.com,
        kent.overstreet@linux.dev
References: <938ebce3-74c5-4fcf-9de3-849271d3581d@kernel.org>
 <20240110130456.142763-1-neal@gompa.dev> <20240110155233.GA623732@nvidia.com>
 <CAEg-Je_P6-3PWNxM4HCzcgM=H4Y1vmywaM3gbwK0gAe0UVoZGw@mail.gmail.com>
 <20240110175755.GC1006537@mit.edu>
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20240110175755.GC1006537@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/10/24 09:57, Theodore Ts'o wrote:
> On Wed, Jan 10, 2024 at 11:25:29AM -0500, Neal Gompa wrote:
>>
>> For what it's worth, I'm totally in favor of C++20 as well. I've
>> mostly written C++17 as of late and it is really nice to me, but I'm
>> genuinely excited about C++20 and newer revisions.
>>
>> I also think that Linux adopting C++ and intentionally adopting safety
>> features that exist and are being added to C++ over time would also
>> further encourage the ecosystem to use them as well as make the Linux
>> codebase much easier to work with.
> 
> Can someone speak to whether the C++ standards committee and C++
> compiler implementations are more or less unreasonable compared to
> their C counterparts regarding compilers being able to arbitrary
> statement reordering, or other random futzing all in the name of
> better benchmarks, but which make life a living nightmware for honest
> kernel developers?
> 

I suspect that the gcc and clang developers are more motivated these 
days about such issues since they are now using C++ as their own 
implementation language.

I had a member of the C++ standards committee reach out to me already, 
and I'm going to have a discussion with him next week.

I have a lot more to say in response to all the (excellent!) comments, 
but I'm about to leave for a long birthday weekend, so my apologies if I 
don't get back to things until next week.

	-hpa


