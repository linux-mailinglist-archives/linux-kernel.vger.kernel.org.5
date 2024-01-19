Return-Path: <linux-kernel+bounces-31313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 351AD832C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79A61F24E97
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F6D5475D;
	Fri, 19 Jan 2024 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rhfC2CVk"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427F52F6E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705677978; cv=none; b=HTmT6Cc1nt+UKV/z2x8RosKUBKSzSbM4Ow5i95sLPFxiC68LJvSzHqjK33GjVSZhFwh7PwVw5B2Gkv/CYmqHZjOMLN6glxGsRFlDHZ2zA0yIB39uA+WYe67qhEvCm2gTNSVZxrOUjOwGt27M7F40JZYBUbkAOolz8QLeQ83ikGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705677978; c=relaxed/simple;
	bh=vnCAqF3wp273Ythn6Y07dct14w+2qXNlpcj2GqGyGI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNeBzeDKgsDngUXIqAMPH8JEb1TIkCmijKsYXyKAzIQEfAcTimIq2kOyAiCo1ZpMTtEBs18JsB6e9TyKy6txN2JyqHyfblj44GzvNAsRAmha+GwypttR4zKUJFb8liqvEYKIulkksOaOhNarSzVemBbqg21cTgcieUIYQ7ZbGmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rhfC2CVk; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d5f252411aso6542955ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705677976; x=1706282776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9IPB3CDAI4O4q3kFlPflmMu5l2t6DgX8ZwG7ZRnOLNQ=;
        b=rhfC2CVkVIvUdwRBmZAMRL/WYcNcKYaiJUIOluRWFuvSL9aslZ2DZaMaCG8PVekTMI
         KNpyaeD2YFbJmJxr2dRNxRbEM+468xgo64L+9MGUTuKBThmq6R2oo1MU4j+TyQnkdS0V
         PwTplSqqHuJA9sCu1CvPbhuaDIaCsdYAmKM8QF7MkFZFr+ZH5ms9nFELF1/IcmXpanCd
         OOoW/cg9GA892gTEShQ6T7MgHbTqclMCK4bHi920fLiF4D0nBXbtjB762eP99BMo7OIb
         wMxP9LWHIs77JKNFqABb47DNFn+khrdP5PZttBWf7c2FZkd/k/1J2J6XU8N3lwDWs5tw
         XPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705677976; x=1706282776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IPB3CDAI4O4q3kFlPflmMu5l2t6DgX8ZwG7ZRnOLNQ=;
        b=ro9ZaFwuUGD5Rw35WbIToEOO0qBToBzCWJ5zv+LQn31CPQH3zrz/aMeCYd/8Q0RIAP
         YSIIuaqzwt5bE3o/rNezJoPYXeIx10a8IPtj2A06CRlsLqtWy0DuP4zLtrM7OYummE0F
         82KGoz+OIi1+6R9XtYWYlrWkdc6d9Vx+hDHh4siXun9RLmiphquQ9zgfNa+SxOe0YQmY
         jsn9SLZ7VH9ZjXR5FFQNLcUSe6FiGL6zk/SKDgwyVa++nFpvj1RMM5cvsU+kBME/3C3s
         7M7kcBA72MO26w48aj90Mib2HCWhQArA+xWkQHHqj+msqjR+psYCUll0yUMQvViuF4OD
         75eg==
X-Gm-Message-State: AOJu0YwH7WCSuGa/EmhMsD0rKDZ1PX2L+e8ZBbGgMMR6YUaSmWkRJf2/
	7dD4mr+san04NUdXyEoT9SKOZhV2rCG3mCToxzFrR72Qa7oPvBF5FoB55xwpuOE=
X-Google-Smtp-Source: AGHT+IE6XknxGCDek85l+r1/ACu/8y9deSnRDcKTk/jsTfxU+sy8RScaODUf2EFk4PIkXbSXqhqWWg==
X-Received: by 2002:a17:902:8685:b0:1d7:2930:ccfb with SMTP id g5-20020a170902868500b001d72930ccfbmr47171plo.66.1705677976685;
        Fri, 19 Jan 2024 07:26:16 -0800 (PST)
Received: from ghost (50-197-128-209-static.hfc.comcastbusiness.net. [50.197.128.209])
        by smtp.gmail.com with ESMTPSA id jh10-20020a170903328a00b001d6ea47ce68sm3180266plb.52.2024.01.19.07.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 07:26:16 -0800 (PST)
Date: Fri, 19 Jan 2024 07:26:12 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: davem@davemloft.net, goldstein.w.n@gmail.com,
	dave.hansen@linux.intel.com, christophe.leroy@csgroup.eu,
	nathan@kernel.org, ndesaulniers@google.com, lrh2000@pku.edu.cn,
	Arnd Bergmann <arnd@arndb.de>, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] lib: checksum: Fix build with CONFIG_NET=n
Message-ID: <ZaqUlBIovzAMaJ2p@ghost>
References: <20240119145600.3093-2-palmer@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119145600.3093-2-palmer@rivosinc.com>

On Fri, Jan 19, 2024 at 06:56:01AM -0800, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> The generic ipv6 checksums are only defined with CONFIG_NET=y, so gate
> the test as well.

Reviewed-By: Charlie Jenkins <charlie@rivosinc.com>

> 
> Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401192143.jLdjbIy3-lkp@intel.com/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> That Fixes tag is against a PR I just sent up to Linus [1], sorry for
> missing this but it came in right when I was sending out the PR.
> 
> 1: https://lore.kernel.org/linux-riscv/mhng-690cf774-fd28-4d25-be9f-69e19fb84d5c@palmer-ri-x1c9/T/#u
> ---
>  lib/checksum_kunit.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
> index af3e5ca4e170..225bb7701460 100644
> --- a/lib/checksum_kunit.c
> +++ b/lib/checksum_kunit.c
> @@ -593,6 +593,7 @@ static void test_ip_fast_csum(struct kunit *test)
>  
>  static void test_csum_ipv6_magic(struct kunit *test)
>  {
> +#if defined(CONFIG_NET)
>  	const struct in6_addr *saddr;
>  	const struct in6_addr *daddr;
>  	unsigned int len;
> @@ -616,6 +617,7 @@ static void test_csum_ipv6_magic(struct kunit *test)
>  		CHECK_EQ(expected_csum_ipv6_magic[i],
>  			 csum_ipv6_magic(saddr, daddr, len, proto, csum));
>  	}
> +#endif /* !CONFIG_NET */
>  }
>  
>  static struct kunit_case __refdata checksum_test_cases[] = {
> -- 
> 2.43.0
> 

