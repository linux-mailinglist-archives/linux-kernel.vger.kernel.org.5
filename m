Return-Path: <linux-kernel+bounces-62565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A34C8522FE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13971F233C1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6501C13;
	Tue, 13 Feb 2024 00:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj5pG9ov"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11BA1381
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783294; cv=none; b=jam0YYaPb7jkTyDpJYRPze4J26psh/bdHApxXuUFiTdKbU8VLML0bJE4vTlOgMyPJzh5bh4p1xYeuAwaakl5ovp01gPF28Kn30oL8i6ijlBnc+EtbpHwXjOUX9ctaTy6b91TQ4RsYkPGuniXOlWkh3m3eYllWsOXfhBc2BrwqQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783294; c=relaxed/simple;
	bh=KrKxLGJZv/JSKNalvT30uESSN5GQ+TUIC4xqxAE4z7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMDg08SkpLaW6dhbNA9Gl5B2vHg3cS9vAY+bxVmUF7auC2pE0D9rbVvK9Xd9owW+iQoBsUySHTaqcYXKr1XGrgZRe/AFqUi9eaCm0wRVUPNXTOGySQbR8WNiSRnYipYdIPliX6qsQVXgNrqL54R9gvzfqZOEVSfVlil0jNXKO5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mj5pG9ov; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso3178635a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707783292; x=1708388092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=izym72fHPr9dmStOL5yOrChdfFqOfldT01rg+6ek71k=;
        b=mj5pG9ovm3VwGn3qDNHmE7ki2TAgwzMMMWlF71/FDUYghllBykrX1cVVbLOUh1px5b
         GIFJtvX6uVn0+dwT9wEV5VhEqO6AY80v8O8Nry+IvepqMv12DNcTprobOTDlTjU8wkGC
         ETn/zcaV6LttJS3L/8pk0j1pfy2dgbx49WRfxQvOYTUILSguD+TqTe7nUje0zLrUUaSW
         UoUrEKL9/4p7TyKnmt/u3+zpIdOyep3wXzM4tLQ05RHOQqjKX5u59iRLS4+rDA9TFGlY
         WAGoq8xz9EhPhHu7DEP+bjqD9cUZJoUSVsufsi8KK3psB0+D7kRE5efqKJj5O4PwbVk+
         MQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707783292; x=1708388092;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izym72fHPr9dmStOL5yOrChdfFqOfldT01rg+6ek71k=;
        b=Dg3hX+zV1d2gtBF00pbWJy4mklAHuCSMwbEleyGVCy3kSGuyRHUDD8/5hsJAMhAD44
         u7WHZLX078GyflORLsXyawMsSLCDmfaYg9IoznUYzldUseO79spz9L3hhStdVVeQ2qn/
         sM4o0fHDnbNf03qRqpCF7HHxKYbmV+TDFlrgdIn+Qfy7p6ErE4wsz/SapOWo43T2T1s9
         01Qh8BpGvTlvfw+hp2HCB0Fq2D7eIdK+wQ2Vx0SNeLklIpcJscRRIm+qtaXewqwmcJ5L
         orP4GoT//83HtCtQ/FNOB1D5AVVaFuFffLnwDFE9wwoNXnU8CX2hKXpeMSquEckdIwbW
         AvSg==
X-Gm-Message-State: AOJu0Yy0RmIJKPORJkF/s1BWw0AISHtklJshOp8rbshYBDcqGAgEkpL7
	P6gYG1OJ31MtFMnHlcqS1FPZpHkPR/0Fu5QdYXvxiGOAOShQF/gV
X-Google-Smtp-Source: AGHT+IGtZQVn/3s3rQ7XSxTWxDoJzOQ3OmnoSXsWJAAdfyS+KaZJvT2Eji+CPP5JJE/FjDAcesqz+g==
X-Received: by 2002:a05:6a20:49a7:b0:19e:5517:c345 with SMTP id fs39-20020a056a2049a700b0019e5517c345mr4613109pzb.44.1707783291866;
        Mon, 12 Feb 2024 16:14:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUv7sVyKm0dpd0ZRYMebrxlBu5e7Lpa4YpZwFg8uxqcySDLS/EDctk2ZKETzMCIEn5urwhjcSuo0OFiRx4kOzQyv4wFKJZUQEK7qqjkxJhhuLGa5cWD5wkP3Iw8QRNU38z2DiPiqk7HPF23X9+ADI0jG75FkRTihoGo1nT0Fqvu7Daf6YkjPyMU97OX4wWY1w==
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001d8cde39e8bsm884575pli.194.2024.02.12.16.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 16:14:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dc352315-0b7b-407a-8704-e424934a922d@roeck-us.net>
Date: Mon, 12 Feb 2024 16:14:49 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>,
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
References: <20240212-fix_sparse_errors_checksum_tests-v7-0-bbd3b8f64746@rivosinc.com>
 <20240212-fix_sparse_errors_checksum_tests-v7-2-bbd3b8f64746@rivosinc.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240212-fix_sparse_errors_checksum_tests-v7-2-bbd3b8f64746@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/24 12:33, Charlie Jenkins wrote:
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
> Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

This thing really wants to annoy me. Now I get:

      # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:494
      Expected ( u64)csum_result == ( u64)expected, but
          ( u64)csum_result == 46543 (0xb5cf)
          ( u64)expected == 46544 (0xb5d0)
      not ok 5 test_csum_ipv6_magic

with the parisc64 tests. All other architectures / platforms work fine
after applying the various pending fixes. It looks like a carry gets
lost somewhere, but I have not been able to figure out where exactly
that happens. This only happens with the 64-bit hppa assembler code.

Guenter


