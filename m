Return-Path: <linux-kernel+bounces-36350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F2E839F8E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0281C22DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B24EBE74;
	Wed, 24 Jan 2024 02:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqO3Gn8N"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144A2D289
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 02:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706064249; cv=none; b=u9hdsQ/zxmMiwJLWd/xIX/gY79zZtY8m85bgbUveUjMgvyrDQIXOLpzDTBA0M0MURjlRXUc57kn5qbDN6H8xRgvwai9Xf1GqsSPx4+8XZHADLqiYRemuRlQtuDcL7G5316JqHzC7c/s7x40QpWMHje2D72ENJ9uiO2GyP90Cocs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706064249; c=relaxed/simple;
	bh=1M19izk0fO2z8k3v+sWRZxGcBHZzNCyzBKJVaIxDXyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cohu4B/GdqjQAvDwAdH7DyEXEfb1yZ3S7b12P1cbK3YzYjEx49lP1DRZEjVq045XyeMGVt1j+KJ3IoO4D8gvixiYuYFr1sHqhxHRjSoqVHIdLY1qe7R0hItbsbieqGDp37zGtInsiRo50WqhVs5xMoUivOke+xIoaE6R8n/t2Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqO3Gn8N; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2906bcae4feso1640589a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706064247; x=1706669047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1E0RgqIXMFrRS5VixzjCUkSm3DZs+CRuuk6GudJfKY=;
        b=dqO3Gn8NEyBntnpDSq9ohndF7NorafceAuIJVaSg97/QfegivAA2slVYdE+t7t6rJC
         +SgVxZQCSKKU/Nrgx4LbftOiu5dIj7vB7tsUbkYN0rVXEfKThdALhNJEpNoNaEx81Fbx
         AVbrhrb/zWfHhuVqPgKFn7o8b7gI3F420pmDd24UlpHYHxoaZcsozIgD9pF0QYcame+4
         CZuSvo/Att37SC6YFUZz5R3KAtVFUKLE/914W+UZgowC7u0Mblv5kqc5RjMwbj9/icoO
         DZJhDIA5cM7tldtUXUo2RKg8u0FQ3yvhCWYHzJVR9w9SlAaLp+qgdZPTytoCQ9qRSnWB
         9lyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706064247; x=1706669047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1E0RgqIXMFrRS5VixzjCUkSm3DZs+CRuuk6GudJfKY=;
        b=ntgocJ5kqCaNgJyOaJfIRVe43uXf99zp8xghmGWvj+vG0WOW3PTd3h+mKSebzn3Nfg
         9M++o48aS0vx2ffZeXDW+CjaGBb7HBp6kyMKbq7UwzE6z/21lhMFexHe1jhugr0GmQzd
         4Kfpt3P/Ah3HWx1BA6vZR6Tdybq9XItHVxJsV6aD6gDMKbA5GJE2gqwLo0V8uoEViMKw
         Oa9XgDyueBrGx7ZBQrfaU+qJKqk633cileKRdHnV2Eao4Y7jmt1ZzrT5GfAYQ8XqrF6U
         Xj+94m8LY9IOHY8JKKVIi79H7BIl8EejxmUoUokJU6Qc3SxyQiOstB+oLz8fDZW6s3Yh
         DvHQ==
X-Gm-Message-State: AOJu0YzN7unyEX20x7epTOeo+7RnBeYrADnr12eAD7JnicOQFy+9pAzn
	4eYm0OL0HQUBHZOYIcvvxWYRjDoDf2X0qrPiqgUNmi4gJxJOG3PR
X-Google-Smtp-Source: AGHT+IFkdjWJC+X0rzevtTLgmh4TNojjVGJ8m4ZhEH7amBEdT/RkKMRIMyFSUgbOZEbj0hWupkhDGA==
X-Received: by 2002:a17:90b:4f83:b0:290:4398:661d with SMTP id qe3-20020a17090b4f8300b002904398661dmr3310216pjb.89.1706064247267;
        Tue, 23 Jan 2024 18:44:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id sl7-20020a17090b2e0700b0028b6759d8c1sm12643745pjb.29.2024.01.23.18.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 18:44:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 23 Jan 2024 18:44:05 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/2] lib: checksum: Fix type casting in checksum kunits
Message-ID: <352ad622-ee0b-43b6-b244-3e38c05db196@roeck-us.net>
References: <20240123-fix_sparse_errors_checksum_tests-v3-0-efecc7f94297@rivosinc.com>
 <20240123-fix_sparse_errors_checksum_tests-v3-1-efecc7f94297@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-fix_sparse_errors_checksum_tests-v3-1-efecc7f94297@rivosinc.com>

On Tue, Jan 23, 2024 at 04:38:42PM -0800, Charlie Jenkins wrote:
> The checksum functions use the types __wsum and __sum16. These need to
> be explicitly casted to.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401200106.PMTn6g56-lkp@intel.com/

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

