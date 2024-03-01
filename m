Return-Path: <linux-kernel+bounces-88695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D516586E579
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27291C20A00
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25C474E39;
	Fri,  1 Mar 2024 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlfnzZWQ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACBC74C18;
	Fri,  1 Mar 2024 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310295; cv=none; b=FUWPeJZYRTrmnPazFUi3/SM+fmRzCLhDfGfIaYGq23zT4yuAwkDPEd/8XKPLgLkM8krMiZDAvj+qc+/B84+9EWdMfpeIXth8yHnfxBP3KdsKYr5aY0OXg0B2CHpYm3wGuY/kqiQYCuk6EctzkUEzpTAVNyHeLnRcSgFqaaO+Les=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310295; c=relaxed/simple;
	bh=JNMyuOyMbvo8crkZCDj11Llh3f+IFU9O3EXmQc+Bxrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pt61gYAKi7sAqwBLgvWveVXyQyYBx7m0wpc6xPTWhJcOXMwy4Xt43BIxS1BNyf2rrGKGmI+UIYkEnJ8aK8aXl241Hj5PIijhcmA5J9X5AzmwmadPcIX38w2MGSzGmzY1eQq9D+vV3bRUjvX4Nsn0KJ1nE4aE5S7Fz8/Bpl9QOOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlfnzZWQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc1ff58fe4so19981975ad.1;
        Fri, 01 Mar 2024 08:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709310293; x=1709915093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9ft/7aZJnfi34P8oyxtsx/Z0QHfs8Z+D/NEyzVub78w=;
        b=TlfnzZWQkQK/ikwkxzumsjULrsN3+l75Ultx5HhGLGTlGl2ux72gia2zLbSmEV+Bx+
         YA9exMUTHVvqzylMhie/2EyGENK8UIUYmPEqh6VqUuwHTR/yw3OevNTlCeS9v7LPgSWa
         X9CoOqIX8FB3Eha1FjOWi379HxGP1u9aPccwgPgNsc+CiAJRODY2utXDj7Xwa8YUhzoS
         tKMCxecqE+OQjBlJvqKMd7hDvArsIyi2kjzoG7HaENlL1FI0eeBHCQ4doEiikFYxjdGM
         +S/DkjdvELTaCK4TO1PMhc3z7pbttLqtd+pnUaD+SEw2GV+vXGtkiSIqe63mJclIfBF7
         KOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709310293; x=1709915093;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ft/7aZJnfi34P8oyxtsx/Z0QHfs8Z+D/NEyzVub78w=;
        b=eK3Yp994ozNg/TQ2u4iiUnXLVynaxoT7IItGLZw5eMW7JnJJOrBu0v92NDZVulkpxS
         QoMKhhqAVhrwTjiGDmnK9GUrKBsLyqEuiy2w0Apm/3L4XCEjSgPB/NKIdQr+iulu+Wsg
         o7ChuxLL2XqymTSgnOHcoLlWXiTjwmrTI2ipAtNc8+V5f7O0+GxBt+psRB+HDYIA8s9K
         84ICAJcxFhqimrLLh0xCqjII3jpQOVcEj4iBHXVpf69kupccmat2/OrClShLudTO4LTg
         dQ+9DQrB+H/mESq1G5CaIEupuTHgHQzG0TaAAjjwcJOkqUef7P36LyB8qLzjdqv1kzLT
         3NzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpl8mIWsRpmPRsr3BWDTIMRzenHSVbn4S9LD3oeEvuQ6NKv8qCBtsJyixksuCXpGhrSIj+EZkrN/BZi0piHYv9P1VznB3yhp0XxrI0
X-Gm-Message-State: AOJu0Yx5OxtUf1+GIuF/gE8Xsxl1Yb5U3/iQvT2Wf2NJijnKp1vffHUn
	CBy0m7rEEhPHppaEGH7ekHD5bRBbMWZRcfkAcorkbnjUzyjuvifg
X-Google-Smtp-Source: AGHT+IGO9u1WRYchnrjQ6DcDK2G+kC6tPGG7VbYdiLovygjrgvPTFRuyFWhS2Yv0XA/tNTiM00oZhg==
X-Received: by 2002:a17:902:ea04:b0:1dc:d642:aaf0 with SMTP id s4-20020a170902ea0400b001dcd642aaf0mr2674018plg.6.1709310293003;
        Fri, 01 Mar 2024 08:24:53 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u17-20020a170902e21100b001db6a228c3esm3642568plb.307.2024.03.01.08.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 08:24:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0b4a7a9c-dd94-47bd-b9df-4da58be11342@roeck-us.net>
Date: Fri, 1 Mar 2024 08:24:50 -0800
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
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Charlie Jenkins <charlie@rivosinc.com>,
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Russell King <linux@armlinux.org.uk>
References: <20240223-fix_sparse_errors_checksum_tests-v10-1-b6a45914b7d8@rivosinc.com>
 <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
 <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
 <0bd79258-b8c4-45f9-9201-4d7ddf02dfea@csgroup.eu>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <0bd79258-b8c4-45f9-9201-4d7ddf02dfea@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/29/24 22:46, Christophe Leroy wrote:
> 
> 
> Le 26/02/2024 à 17:44, Guenter Roeck a écrit :
>> On 2/26/24 03:34, Christophe Leroy wrote:
>>>
>>>
>>> Le 23/02/2024 à 23:11, Charlie Jenkins a écrit :
>>>> The test cases for ip_fast_csum and csum_ipv6_magic were not properly
>>>> aligning the IP header, which were causing failures on architectures
>>>> that do not support misaligned accesses like some ARM platforms. To
>>>> solve this, align the data along (14 + NET_IP_ALIGN) bytes which is the
>>>> standard alignment of an IP header and must be supported by the
>>>> architecture.
>>>
>>> I'm still wondering what we are really trying to fix here.
>>>
>>> All other tests are explicitely testing that it works with any alignment.
>>>
>>> Shouldn't ip_fast_csum() and csum_ipv6_magic() work for any alignment as
>>> well ? I would expect it, I see no comment in arm code which explicits
>>> that assumption around those functions.
>>>
>>> Isn't the problem only the following line, because csum_offset is
>>> unaligned ?
>>>
>>> csum = *(__wsum *)(random_buf + i + csum_offset);
>>>
>>> Otherwise, if there really is an alignment issue for the IPv6 source or
>>> destination address, isn't it enough to perform a 32 bits alignment ?
>>>
>>
>> It isn't just arm.
>>
>> Question should be what alignments the functions are supposed to be able
>> to handle, not what they are optimized for. If byte and/or half word
>> alignments
>> are expected to be supported, there is still architecture code which would
>> have to be fixed. Unaligned accesses are known to fail on hppa64/parisc64
>> and on sh4, for example. If unaligned accesses are expected to be handled,
>> it would probably make sense to add a separate test case, though, to
>> clarify
>> that the test fails due to alignment issues, not due to input parameters.
>>
> 
> When you say "Unaligned accesses are known to fail on hppa64/parisc64
> and on sh4", do you mean unaligned accesses in general or do you mean
> ip_fast_csum() with unaligned ip header and csum_ipv6_magic() with
> unaligned source and dest addresses ?
> 
> Because later in this thread it is said that only ARM and NIOS2
> potentially have an issue.
> 
> And when you say "unaligned", to what level is that ? Is it 4-bytes
> alignment or more or less ?
> 

This e-mail chain is getting too long. Here is an attempt of a quick summary.

- Someone else suggested that unaligned accesses with nios2 should fail.
   I since then tested and found that they pass at least for the checksum tests,
   while dumping "unaligned access" messages into the kernel log. Other tests
   (specifically gso) cause crashes, but that is unrelated.

- checksum tests on sh4 fail for unaligned data because of a bug introduced
   to the architecture's checksum core with commit cadc4e1a2b4d ("sh: Handle
   calling csum_partial with misaligned data"). The tests pass after reverting
   that patch. I reported this, but that revert (or a fix of the problem it
   introduced) has not been applied to linux-next.

- Checksum tests on unaligned data fail on parisc in mainline due to a number
   of bugs in checksum assembler code (and with upstream qemu due to a bug in
   qemu's hppa64 emulation). All those issues should by now be fixed in linux-next.
   For reference, the following patches (SHAs from next-20240301) are needed to fix
   the known problems:
     0568b6f0d863 parisc: Strip upper 32 bit of sum in csum_ipv6_magic for 64-bit builds
     4b75b12d7050 parisc: Fix csum_ipv6_magic on 64-bit systems
     4408ba75e4ba parisc: Fix csum_ipv6_magic on 32-bit systems
     a2abae8f0b63 parisc: Fix ip_fast_csum
   qemu (v8.2 and later) needs
	https://lore.kernel.org/all/20240217015811.1975411-1-linux@roeck-us.net/T/
   for the hppa64/parisc64 tests to work with qemu.

- Checksum tests on unaligned data cause a crash on arm systems with "thumb"
   instruction set enabled (such as mps2_defconfig and an385). I didn't bother
   checking if the crash is with 1-byte or 2-byte alignment.

- There used to be a crash with checksum tests on m68k because of word alignment
   which the implementation of the unit tests for csum_ipv6_magic() did not take
   into account (this is fixed by the padding in struct csum_ipv6_magic_data).
   I don't know if this patch is needed to fix that problem or if it was since
   fixed differently.

I hope that covers everything. As I said above, the chain is getting long
and I may have missed something.

I am currently re-testing on all platforms/architectures available in qemu
with the known bugs outside lib/checksum_kunit.c fixed and with the sh4 patch
reverted, but without this patch. I'll send an update in response to the v11
patch as soon as I have the results.

Guenter


