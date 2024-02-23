Return-Path: <linux-kernel+bounces-78934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F1D861AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C9E2897F9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E501419AC;
	Fri, 23 Feb 2024 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rQrI5Vaw"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE7614039E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711074; cv=none; b=Jw7oINKOnA4J18UNqM4l1738OdO/WaAaiKVgFdADDFxdkHrVkAxuttM4MyxjPwUkboJS9rRYA2KXodMn2KNYGhv+AwkNR41elqXCgA/rIbLuAgW+KPhqMbP6CFiPny00eIWBOzeFVXz3wnBTJXod82qzFgAsFkh52Tk5OkrkOwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711074; c=relaxed/simple;
	bh=b+yufhC34xQ35SDeLFqFIpmUWOKldYMLTKMcXV3g074=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKmOW4gpf9NbLN2mGMuFt8ed0Xcu7z0U/Vw7I8f9KuJcYJZ/ms0FJnNaukykszpkCOJ9peTmEnjmIboeBEdMGVWPKih0uUq7xtyKgtoNFXZTwc/Xd1rv1bRu0hlmvgdhaP4NhcUODsFuvBdfyZCzmSL6EUP9/1vOyFiH8CvaWmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rQrI5Vaw; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so547251a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708711072; x=1709315872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L2d7MqCCUNGyccXxnRLDxznuYvUmklbFpLMdiF5+0EI=;
        b=rQrI5VawVWHX7pxzDXs74PIRB0oTYzvdpX0JGnbklq2S3pfwmH7sNllxR5znmN/Dkv
         bWtd7AdWyD6HJXpGZBVBa/neqCXc4LtrcbSObMjdyK5ql3310v226UWGrNJGYANvkz1D
         Cd1XgQqmt6ZENsCNe1rrviC1dGjpmoaLtvMMV1LCTcHEnyqMkOxNXDb/nFHTxruoCLnX
         QwTbx3v4DwdliEPjVpBIyoNTsA67lVkVC85Xe6eKv5K22TBFwp7T2tdfcRCu2n6uF71y
         b2RVEtPo/hFoemb9zrL5dIyXBXk5697XuVgh0VPN7jzyA3bbF4y8zLEo0IjxCfD5NyNt
         FTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708711072; x=1709315872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2d7MqCCUNGyccXxnRLDxznuYvUmklbFpLMdiF5+0EI=;
        b=ugiW+ez6x0yUKLnv8LMN4OVfhW2juKgsI6rDj/zqPhbjMldsuPXB8iXVWwp5o+jmsA
         8iwcpIH71gd/Ivw/6hUXbjZujK5536MEZjHDMkihbitWk6RGcnWvjZP6rv6OaBA/M/rq
         9kH3BWum3LpsismSUXy/srC0UYPl2NGpEiHnPdihLre3GaJ6/hc9ZARNZ8ZEOwuE4n6f
         dkoEFPpPgHGny916KSKSPSQ/ZvO0bbzeWsEIvVxZmwlNYxO8QufMuLpS5le2Ts36fr3g
         GdX9qszlF97i33jIlLP03drKim5FP9N77de0tvi7j6a9KiH+ChhMjYWk+LUjw91pkNUo
         vGug==
X-Forwarded-Encrypted: i=1; AJvYcCXoOWzyBLG1r0m7ATVmD+o3UJ+NRSW+PwwrB0ejV1FioZPSkNtASoIBCq5jw7r4QPbPYRVMes8kFJFu80kNPuznpUdtf0IcYqBJstmz
X-Gm-Message-State: AOJu0Yzob7FVEXpgna0255e6mOIQLqLi32I1ntWXNmzF7a7GehsQgXGp
	iH0Mu/3ln11PD64ze4Jz1Nfvff4EBOd/FEoHHOPB5fxKmzq2yUYy75BJG3ndl18=
X-Google-Smtp-Source: AGHT+IF0+6Y4Pgd4go7sI4Z0IOF+LMyiDGTQM0YJE3ww/aECUoEVYO3T+NNUVzSVJcC2IvqzDwfZpw==
X-Received: by 2002:a05:6a20:2d29:b0:1a0:e4a3:582c with SMTP id g41-20020a056a202d2900b001a0e4a3582cmr844566pzl.2.1708711072543;
        Fri, 23 Feb 2024 09:57:52 -0800 (PST)
Received: from ghost ([2601:647:5700:6860:a351:1ab0:98d6:3d53])
        by smtp.gmail.com with ESMTPSA id mn3-20020a1709030a4300b001dc38eaa5d1sm4677690plb.181.2024.02.23.09.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:57:52 -0800 (PST)
Date: Fri, 23 Feb 2024 09:57:50 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Erhard Furtner <erhard_f@mailbox.org>
Subject: Re: [PATCH net] kunit: Fix again checksum tests on big endian CPUs
Message-ID: <Zdjcnp324nIRuyUI@ghost>
References: <73df3a9e95c2179119398ad1b4c84cdacbd8dfb6.1708684443.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73df3a9e95c2179119398ad1b4c84cdacbd8dfb6.1708684443.git.christophe.leroy@csgroup.eu>

On Fri, Feb 23, 2024 at 11:41:52AM +0100, Christophe Leroy wrote:
> Commit b38460bc463c ("kunit: Fix checksum tests on big endian CPUs")
> fixed endianness issues with kunit checksum tests, but then
> commit 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and
> ip_fast_csum") introduced new issues on big endian CPUs. Those issues
> are once again reflected by the warnings reported by sparse.
> 
> So, fix them with the same approach, perform proper conversion in
> order to support both little and big endian CPUs. Once the conversions
> are properly done and the right types used, the sparse warnings are
> cleared as well.
> 
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  lib/checksum_kunit.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
> index 225bb7701460..bf70850035c7 100644
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
> @@ -577,7 +577,8 @@ static void test_csum_no_carry_inputs(struct kunit *test)
>  
>  static void test_ip_fast_csum(struct kunit *test)
>  {
> -	__sum16 csum_result, expected;
> +	__sum16 csum_result;
> +	u16 expected;
>  
>  	for (int len = IPv4_MIN_WORDS; len < IPv4_MAX_WORDS; len++) {
>  		for (int index = 0; index < NUM_IP_FAST_CSUM_TESTS; index++) {
> @@ -586,7 +587,7 @@ static void test_ip_fast_csum(struct kunit *test)
>  				expected_fast_csum[(len - IPv4_MIN_WORDS) *
>  						   NUM_IP_FAST_CSUM_TESTS +
>  						   index];
> -			CHECK_EQ(expected, csum_result);
> +			CHECK_EQ(to_sum16(expected), csum_result);
>  		}
>  	}
>  }
> @@ -598,7 +599,7 @@ static void test_csum_ipv6_magic(struct kunit *test)
>  	const struct in6_addr *daddr;
>  	unsigned int len;
>  	unsigned char proto;
> -	unsigned int csum;
> +	__wsum csum;
>  
>  	const int daddr_offset = sizeof(struct in6_addr);
>  	const int len_offset = sizeof(struct in6_addr) + sizeof(struct in6_addr);
> @@ -611,10 +612,10 @@ static void test_csum_ipv6_magic(struct kunit *test)
>  		saddr = (const struct in6_addr *)(random_buf + i);
>  		daddr = (const struct in6_addr *)(random_buf + i +
>  						  daddr_offset);
> -		len = *(unsigned int *)(random_buf + i + len_offset);
> +		len = le32_to_cpu(*(__le32 *)(random_buf + i + len_offset));
>  		proto = *(random_buf + i + proto_offset);
> -		csum = *(unsigned int *)(random_buf + i + csum_offset);
> -		CHECK_EQ(expected_csum_ipv6_magic[i],
> +		csum = *(__wsum *)(random_buf + i + csum_offset);
> +		CHECK_EQ(to_sum16(expected_csum_ipv6_magic[i]),
>  			 csum_ipv6_magic(saddr, daddr, len, proto, csum));
>  	}
>  #endif /* !CONFIG_NET */
> -- 
> 2.43.0
> 

There is no need to duplicate efforts here. This has already been
resolved by
https://lore.kernel.org/lkml/20240221-fix_sparse_errors_checksum_tests-v9-2-bff4d73ab9d1@rivosinc.com/.

- Charlie


