Return-Path: <linux-kernel+bounces-63830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7692585350D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4824E1C21EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57A55EE82;
	Tue, 13 Feb 2024 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDY9bv4D"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4A05EE6F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839275; cv=none; b=bgYnaT9jjqwIiFmO1evtSUY96m6aCjI+Dc0wt/4N24X3IlGrlRojQyhHd9OEP6wFrIRdBEosDwmY4bqOHRg/glNIsKqqoUSuS2q+2TDKYBsPCg4LO/D9dZiWFHhqVO9JfMNOK/BtbI3xg36S1ngb3PRJrsT4cAyz3tBq5RN0kis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839275; c=relaxed/simple;
	bh=2zjRMKPSdfd/85vyN/lVMBpgBqiI2yoxsnyvaxIFf+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8u7bJ60cvP77Zjxv0YR+PTJvx59jJk/dAgy2ZGHoFF6vCgbBDkExDkFqoq/JBVz9Q5jtSJfY6UKvvW3XOTIKt7rmPmFETRVhZSjF1Jbq4o8kxnMW34w5Gy2w0mLyUl87jsOjPb0+XLWpR0wwmHuLnb/qke2w4HpVzl1QG1nqAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDY9bv4D; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e09143c7bdso2349636b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707839273; x=1708444073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7HJwihhJfAIINfc3djcS7o66KkwDFXv+SWOU/6+/NE=;
        b=hDY9bv4D5V6+cwEOswHGusEpNEBqqM8z5EkkezhFIprEggi4sCRY1OdRbzy2B14jbD
         /1nGMR00GPbkoJGtvSjYywAcN/j/+Jz8mnwWvQmEH9dqmRaDvMrIed3uN37HgJE1S0Qq
         I/P4nMO4yhcK0asH41lJuEHhvhiY04XjUZaCuAPVKZLlae7TqdxDmr3mllS5f8p34TNX
         XGJlGmNtGEolrRLB0r6jYNcaRV91s5cUuJtq1qCpjwRSyiDV6vfz4zQ73N4cbPT9R0+a
         DEFYXNONsK8t3WQrEPOFdel3aNGKGHyF5QzqqIy+FEn4lYIq+XIncHqspPaXxLF1iH2v
         fM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839273; x=1708444073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7HJwihhJfAIINfc3djcS7o66KkwDFXv+SWOU/6+/NE=;
        b=IUlggkIxZUU5ZdzYu7pWeokPZu+mWH8cNwtLTzRYD2DJ1i8Sr8USMXfEQRn3g7I8Po
         x1TpNi/KgOBG0zZpbGr1H4lb0+BzdmlPE1qfCkOcy4Zo3w1c93cSgd5IhrxI+7ZdLs2f
         koFEDcjnIYN0H3Zovawh2XBm8M8OCRTexGeHmvWnApcS/LcXHL2ye7wZBulKhpyLlLnF
         MtIA7+ZgUypWuLJJgQv5dERAz+HP4Mu7/uF2+rLiBi486dZ8esimzOErNAzsnxcA8VPQ
         EcCPwqeif/9NWxbTQ0epy4RQpiPG8tcIvi7rGRMi+/eSkUDp2F2ZwAEPvlWVS7tjqKYg
         n35Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjEiL1q+1ztdjnmb3RJmdabbVW7jk1OQcFarY9Y9mZQsvePKhTHmgWdx2Or9cAHNJ1PoaglGwpwo1NcjOBJeG/EQCc2wTcHA4oUT1b
X-Gm-Message-State: AOJu0YxHhCkqq/SJv9yVC+fUI99bwOFFH45IAqpZUuCbLEAiUkArSwPB
	SsWcxlE9VdSq2M5e+bT/WBfWSOloi0k4AOgQ/XodkugU8F1jFUwX
X-Google-Smtp-Source: AGHT+IGh17gxe4gVkVQFi84dhk+LnffnQ++g4mJCqODwZJEjUBmehoU8HUs8Ql1bBJ/vLWp7CfyPXA==
X-Received: by 2002:a62:e405:0:b0:6e0:5254:c9f1 with SMTP id r5-20020a62e405000000b006e05254c9f1mr8473038pfh.18.1707839272649;
        Tue, 13 Feb 2024 07:47:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhs2CE5gHuD0YD7APZCbt0a4NLxP5b0djaAZIFEptg9aBC4y/ZXdN5+7BitIb7eFf2oCuzHFVRxf1Vs4PKjBF9HKpo4kL3fJavep5Y8ectcppp1Ram7LBiu3X9qjmku6LKf2payHxB1HQohmcNUAVYPv4EtQQNM0TrYK0y6f3+lpZcTmt7WELKKlmphcwzJWWaB4WMLxs/DcPx/DzJY3G2KLC2
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x7-20020a626307000000b006e0938f7c57sm7914189pfb.121.2024.02.13.07.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:47:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 13 Feb 2024 07:47:50 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7 1/2] lib: checksum: Fix type casting in checksum kunits
Message-ID: <ed05dcee-5a80-44b9-ad34-e5c208be2678@roeck-us.net>
References: <20240212-fix_sparse_errors_checksum_tests-v7-0-bbd3b8f64746@rivosinc.com>
 <20240212-fix_sparse_errors_checksum_tests-v7-1-bbd3b8f64746@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212-fix_sparse_errors_checksum_tests-v7-1-bbd3b8f64746@rivosinc.com>

On Mon, Feb 12, 2024 at 12:33:04PM -0800, Charlie Jenkins wrote:
> The checksum functions use the types __wsum and __sum16. These need to
> be explicitly casted to, because will cause sparse errors otherwise.
> 
> Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401200106.PMTn6g56-lkp@intel.com/
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  lib/checksum_kunit.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
> index 225bb7701460..776ad3d6d5a1 100644
> --- a/lib/checksum_kunit.c
> +++ b/lib/checksum_kunit.c
> @@ -215,7 +215,7 @@ static const u32 init_sums_no_overflow[] = {
>  	0xffff0000, 0xfffffffb,
>  };
>  
> -static const __sum16 expected_csum_ipv6_magic[] = {
> +static const u16 expected_csum_ipv6_magic[] = {
>  	0x18d4, 0x3085, 0x2e4b, 0xd9f4, 0xbdc8, 0x78f,	0x1034, 0x8422, 0x6fc0,
>  	0xd2f6, 0xbeb5, 0x9d3,	0x7e2a, 0x312e, 0x778e, 0xc1bb, 0x7cf2, 0x9d1e,
>  	0xca21, 0xf3ff, 0x7569, 0xb02e, 0xca86, 0x7e76, 0x4539, 0x45e3, 0xf28d,
> @@ -241,7 +241,7 @@ static const __sum16 expected_csum_ipv6_magic[] = {
>  	0x3845, 0x1014
>  };
>  
> -static const __sum16 expected_fast_csum[] = {
> +static const u16 expected_fast_csum[] = {
>  	0xda83, 0x45da, 0x4f46, 0x4e4f, 0x34e,	0xe902, 0xa5e9, 0x87a5, 0x7187,
>  	0x5671, 0xf556, 0x6df5, 0x816d, 0x8f81, 0xbb8f, 0xfbba, 0x5afb, 0xbe5a,
>  	0xedbe, 0xabee, 0x6aac, 0xe6b,	0xea0d, 0x67ea, 0x7e68, 0x8a7e, 0x6f8a,
> @@ -582,7 +582,7 @@ static void test_ip_fast_csum(struct kunit *test)
>  	for (int len = IPv4_MIN_WORDS; len < IPv4_MAX_WORDS; len++) {
>  		for (int index = 0; index < NUM_IP_FAST_CSUM_TESTS; index++) {
>  			csum_result = ip_fast_csum(random_buf + index, len);
> -			expected =
> +			expected = (__force __sum16)
>  				expected_fast_csum[(len - IPv4_MIN_WORDS) *
>  						   NUM_IP_FAST_CSUM_TESTS +
>  						   index];
> @@ -614,8 +614,9 @@ static void test_csum_ipv6_magic(struct kunit *test)
>  		len = *(unsigned int *)(random_buf + i + len_offset);
>  		proto = *(random_buf + i + proto_offset);
>  		csum = *(unsigned int *)(random_buf + i + csum_offset);
> -		CHECK_EQ(expected_csum_ipv6_magic[i],
> -			 csum_ipv6_magic(saddr, daddr, len, proto, csum));
> +		CHECK_EQ((__force __sum16)expected_csum_ipv6_magic[i],
> +			 csum_ipv6_magic(saddr, daddr, len, proto,
> +					 (__force __wsum)csum));
>  	}
>  #endif /* !CONFIG_NET */
>  }
> 
> -- 
> 2.43.0
> 

