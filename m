Return-Path: <linux-kernel+bounces-83932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9BE86A03A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2BBA1C285CB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE8A524CF;
	Tue, 27 Feb 2024 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGw4P102"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6979C51C47;
	Tue, 27 Feb 2024 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062266; cv=none; b=lAfQxp2eXoVz0SsG1bz0KCby0FjE+CHyfL5AKvvgicm3ZUUoQumy+DpT0Q5Veu9z5Lm7Uu0n3927FM4TEH/0UvyvjuWqf9w42pPiFTB8DIvuJDoLR3fafQu/8wmgNbOUzfQ66UXgw2lxeD0n002rnpw49Cui1s5o+0qi2/t/PVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062266; c=relaxed/simple;
	bh=jRt2ErvqSzfBRw4qU7ZkjZB4KBrabD4zHUYZOHAS1Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmAmev1f8RY4zQ8fGf/zdQlMPVuov2DWu3r2dxmF+vB6/KhtuWYe2i50mARtcRozE+dENMOa1kT1NSHCuyV/eX/10gIqjYzNd2da8gwUr3JgYk1nWZ3gmy8DO9PVtDPRFqkuB9U8cShgCQxVWEotkCdz2t7wbukI2Bkbpv9HDtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGw4P102; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29a6dcfdd30so3290372a91.0;
        Tue, 27 Feb 2024 11:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709062264; x=1709667064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SOzRQZDqFOKE0709SryCfXzGSfSwCPxusfHN66yeJh0=;
        b=NGw4P102KSPLUUNsT/W6ilNiZWOgzWL2Zts/QHN1ZFwaeO8wiE05oLMCtA9D0yecq3
         l//9KGAh0tov664LKO1E3FPYqfAool3ev/7PkDK6qyjHikNR4PGVf85ie8EiO+vBaxn6
         YTFfvPDqk51jGvlNF44ASATG5eATjdEH5pGqHx8UDwnAYGWJLmU6tsE3kVZl7vDDNhhW
         gHjhDCdWdG0ueiYJOucJ2k7U5CwkBnWkV+R2unxmDa1IjvRPPhjf9Sk6j6KGZnVHXcug
         1mEi4i0ldRZYaAER8HYm4DOg4z9nJFjT+Zca44rjsLz+y331YaqHN5UvYm04Qb5LeTOp
         aqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709062264; x=1709667064;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOzRQZDqFOKE0709SryCfXzGSfSwCPxusfHN66yeJh0=;
        b=s7/ygYvj/DcdeaSJrrl9sM41gaJq+FSV3J8dXDY2SyjtD14RyOfMwdnbOftysrms4D
         IdXnyVRBhIsT7pAEPaFSTchRFuw7YsGrdDThDr/0fbCch/Vn71F0eu163oriYdZ892aV
         2KiL/lpqakjh3B5CF1SlffzACEKVKFujTINKWq25ESOz77ybl2/hppzdxVa5o53+tOXC
         AVF5TznICPRZn0g7SQ9q+eQobJVBtaFCGhYKT7sJRcAzNZOitMgpNNxMVCGksZaDE2Ks
         vCvy5ZQENhaVmnuW83yjhQgIkfN+prQJYAkT6AMH4q1Hr3iH9zX89DthrIWxZd8hfe+z
         XHng==
X-Forwarded-Encrypted: i=1; AJvYcCXy1UTiJavnXI5y49awsp4VPr0Ot9daAGs57PF6ES1reooYgJ96xMX9Cudm+b3/h6zTTM+GU7LHBzdkTN+4A+ZJy8qyAggHjpbkCo44nxQqYI1iKHE5Y6iL9JQkqqM2h2y3Zmc1hDa1F/q9
X-Gm-Message-State: AOJu0YwoRTON45vgInggWy55N4eYH9l7KeJwlr2w/YBExm7hNmTvwrUw
	NLG+d49KNyC+j66bjh0MsBGeCGXEUUIKGMBORX2tq9vmznYC3/ol
X-Google-Smtp-Source: AGHT+IHXc41QF3pfortbftHo1Fg1AxzNn+X3btZslW63Fmd7QwatNdjj2HSja71TrfiICLVNsbnnNQ==
X-Received: by 2002:a17:90a:4a8f:b0:299:14c6:4fc7 with SMTP id f15-20020a17090a4a8f00b0029914c64fc7mr8802820pjh.13.1709062263598;
        Tue, 27 Feb 2024 11:31:03 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ge5-20020a17090b0e0500b0029a4bacfb13sm736047pjb.0.2024.02.27.11.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 11:31:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4d5ce145-22be-4683-b3a9-4de77da87b76@roeck-us.net>
Date: Tue, 27 Feb 2024 11:31:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
 <ZdzPgSCTntY7JD5i@shell.armlinux.org.uk> <ZdzZ5tk459bgUrgz@ghost>
 <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
 <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com> <Zd0b8SDT8hrG/0yW@ghost>
 <cdd09f7a-83b2-41ba-a32c-9886dd79c43e@roeck-us.net>
 <9b4ce664-3ddb-4789-9d5d-8824f9089c48@csgroup.eu>
 <Zd25XWTkDPuIjpF8@shell.armlinux.org.uk>
 <c8ddcc98-acb0-4d2d-828a-8dd12e771b5f@csgroup.eu> <Zd4h6ZhvLSWfWJG/@ghost>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Zd4h6ZhvLSWfWJG/@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 09:54, Charlie Jenkins wrote:

>> It's been suggested during the discussion that alignment tests should be
>> added later in a follow-up patch. So for the time being I'm trying to
>> find a compromise and get the existing tests working on all platforms
>> but with a smaller alignment than the 16-bytes alignment brought by
>> Charlie's v10 patch. And a 4 bytes alignment seemed to me to be a good
>> compromise for this fix. The idea is also to make the fix as minimal as
>> possible, unlike Charlie's patch that is churning up the tests quite
>> heavily.
> 
> Do you have a list of platforms this is failing on? I haven't seen any
> reports that haven't been fixed.
> 

This is what I carry locally on top of v6.8-rc6:

097b149e4acb parisc: More csum_ipv6_magic fixes
15bf67a115eb kunit: Fix again checksum tests on big endian CPUs
bebe776d36ea parisc: Fix csum_ipv6_magic on 64-bit systems
523208f03063 parisc: Fix csum_ipv6_magic on 32-bit systems
a9dda1971c72 parisc: Fix ip_fast_csum
2ad0a6850b64 Revert "sh: Handle calling csum_partial with misaligned data"
7113cc414860 lib: checksum: Use aligned accesses for ip_fast_csum and csum_ipv6_magic tests

I also have
0dd01a364cb7 lib: checksum: Add some corner cases to IPv6 checksum tests
e767cce6598b lib: checksum: Add tests for unaligned IPv6 addresses

which I may submit or not depending on the outcome of this discussion.

In other words, parisc and sh4 are currently known to be broken in the
upstream kernel, with fixes pending. On top of that, arm:mps2-an385
(probably all arm:nommu systems) crashes hard if csum_ipv6_magic()
is called with an unaligned address.

This is the "known" list of failures. I don't currently run kunit tests
on nios2 or riscv32, for example, nor on any architectures with no qemu
support.

On a side note, most architectures don't handle "len + proto" overflows.
While 'len' is a 32-bit parameter, IPv6 only allows for a 16-bit length
field. Many implementations of csum_ipv6_magic() specifically do
not handle such overflows because that would be pointless and require
extra code for no good reason. The current test code doesn't generate
such overflows, but its 'len' parameter is almost always larger than
16 bit and thus not realistic. Maybe it would make sense to limit
the range of 'len' to 16 bit when calling csum_ipv6_magic().

Thanks,
Guenter


