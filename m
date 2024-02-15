Return-Path: <linux-kernel+bounces-66227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D61D8558C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19B41F22B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ED817E9;
	Thu, 15 Feb 2024 01:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsJ4FpBR"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3546D10F2;
	Thu, 15 Feb 2024 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707960256; cv=none; b=XmJBWS7pdyhsB+1zViuXYeoYF0Zlv857PeLSQXu4snMLBE1Pu/Il73OPFlT7dkMQ7ePPCwssOGwZGqPaLoRGcBBgH2r1r1BV3cOKXEOsiB1OrRrGobI/Kjv0vcyiRHW7XeKAVRz9ZkH6RtzuV0DnYRihZ8LCggtHNqwIVg250vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707960256; c=relaxed/simple;
	bh=PgXSHMP1jNw+Xh52N9SCK2KPIf7b2fiKcPI3A90/8aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lb+BrvEsnqrzUXvd6PGwRKOZOEc9QwOqgqMdewxaOSmRNY4SOT/SIo8IQgps3FKDEjn2IF3VHYyJAtY8Ml6/RfZqPw9BjxfY58P+D270Li1muX9nj8V1ToMFRKrbdH3W6u2V4FFnkbCwXQUm1htswSrrY3dy6OQXrTMIXKeihSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsJ4FpBR; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e104196e6eso456452b3a.0;
        Wed, 14 Feb 2024 17:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707960254; x=1708565054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gedE0L9Ouy/oIx8vXboFUteCNYZmLOHoNTlwQC5vaB4=;
        b=BsJ4FpBRvJovcYn2/RQnfntX0k8oSjHz8uUdvG6qvO0XQATqNcG0nlH5UuY0E9b1Lg
         V5/GjAfJlrj6tPanKUMrsXXfcJEg9GZVaz7RwuvTIWwxzwdukJ8eRbM29AluR/YF2GHo
         4IknZUkcy7nkfq90KVCp7TcG6RqqPCBaq/El2R/lcQeq86ltSNfVMQTt+yft1KyDUd2J
         CmiL6iTR5rJFVGTp6jz0YEWoNtaBUc4Cho1KMOFI12NMbBx3EpbWV1hhvP6y4Lm5XIIv
         ioDUa0hGPPQpzLedO1pVY+VT/nEWk5UjJbqS0r9m55CysX5hEp0SE27ORnFx9yorMI4p
         jGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707960254; x=1708565054;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gedE0L9Ouy/oIx8vXboFUteCNYZmLOHoNTlwQC5vaB4=;
        b=CypMZli75dC4HWBOkhsraoUAcjv4p+VfcpYQKF3I2PES92kSQc/eXJklSshCJIq81/
         MIPLzhxR0PviH5WPwbwRQpvunMoGVFbkqBtrVm57gF6w1FXDqfZ0uVXlq/TeO0ggilcP
         UdX4gjGwgf/casbOeWXqEl7u05VN4zKKzh8YaQM7KpVrAcyyAjJLVuwbiOQnpPDFSgJU
         Dumy2Z2gky5rdigyVFCkIbE/uz8gzURRzD2SwHavETMwmPk99NoLTYQCuzO0JOO8YImC
         Dsho00Yn6L9PnkhyWEEvYxZe/7/ubUur0MAMecKgYl0kSzhfp0RsgsoVGhadkdpNjZEW
         krvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdqdP0FD/TL+Lk4iZxJz/oBOY895cjY+InmRfbaLHoIn9bUzwxf1DsKNs2e1MoJMo1pJD4VNfqCai8SfWIkrIN8LfH6kNEwc4oJ615
X-Gm-Message-State: AOJu0Yz1ZS77mvNF3l0mjBykQUpvGMJErkMiDSDmIRdFjUBu66BQyjfH
	VytTOiO2sLsfr14OpIGuCF9jlWf3bg0BdD8hjjeDPTdieE3LPd/9
X-Google-Smtp-Source: AGHT+IEn49lwYt768Aluu90Nocb2R1YsoTNL8qRJtToIE2r9kTeYeZAHhmtz6zkH3MqGi0YPR3IDtg==
X-Received: by 2002:a05:6a00:1995:b0:6e0:e618:7eb0 with SMTP id d21-20020a056a00199500b006e0e6187eb0mr651601pfl.8.1707960254432;
        Wed, 14 Feb 2024 17:24:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o16-20020a056a00215000b006e0938f7c57sm86145pfk.121.2024.02.14.17.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 17:24:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <285cd809-d5e0-4688-ace1-630aa8c30aae@roeck-us.net>
Date: Wed, 14 Feb 2024 17:24:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>,
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/24 13:41, Charlie Jenkins wrote:
> The test cases for ip_fast_csum and csum_ipv6_magic were failing on a
> variety of architectures that are big endian or do not support
> misalgined accesses. Both of these test cases are changed to support big
> and little endian architectures.
> 
> The test for ip_fast_csum is changed to align the data along (14 +
> NET_IP_ALIGN) bytes which is the alignment of an IP header. The test for
> csum_ipv6_magic aligns the data using a struct. An extra padding field
> is added to the struct to ensure that the size of the struct is the same
> on all architectures (44 bytes).
> 
> The test for csum_ipv6_magic somewhat arbitrarily aligned saddr and
> daddr. This would fail on parisc64 due to the following code snippet in
> arch/parisc/include/asm/checksum.h:
> 
> add		%4, %0, %0\n"
> ldd,ma		8(%1), %6\n"
> ldd,ma		8(%2), %7\n"
> add,dc		%5, %0, %0\n"
> 
> The second add is expecting carry flags from the first add. Normally,
> a double word load (ldd) does not modify the carry flags. However,
> because saddr and daddr may be misaligned, ldd triggers a misalignment
> trap that gets handled in arch/parisc/kernel/unaligned.c. This causes
> many additional instructions to be executed between the two adds. This
> can be easily solved by adding the carry into %0 before executing the
> ldd.
> 
> However, that is not necessary since ipv6 headers should always be
> aligned on a 16-byte boundary on parisc since NET_IP_ALIGN is set to 2
> and the ethernet header size is 14.
> 
> Architectures that set NET_IP_ALIGN to 0 must support misaligned saddr
> and daddr, but that is not tested here.
> 
> Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-and-Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter



