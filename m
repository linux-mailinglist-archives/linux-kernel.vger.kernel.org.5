Return-Path: <linux-kernel+bounces-57401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9528A84D7F5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B851C22216
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5A21D522;
	Thu,  8 Feb 2024 02:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAP8lmLa"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4C11BC40
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 02:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707360342; cv=none; b=Gip6mT3NkqH56DaMxrc5Iu0MbpYglt9mBXA/aArqGUzdcjJlAnsvDAnCIU3L015T18ZRVtMesEO3TvgbCYWpRHFXn2o18l/tp57ERO3NZPMnWumrM4nQKukoS4A5EjrGnpyoJyckVYOMfuOnpd28bUF1iwTxP9YGus/hsZbQ0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707360342; c=relaxed/simple;
	bh=qSLYw4JhirC1aPR9oCFExmXuGYTZurk4zLdFEegFvpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ybya/2NZhlz1tf3f6Wcjvvle1I+Wgg2QKf82NPe6WQdW09eQStre9QDmGUKiHWXcb45wIUODROwJOeF5y4SLq6SeKyBe4a2wqJrTDNE3Vb8R8zPRyjApF6Li4aHNF/m3xb/7ywwZXVo/rOWZ7bqZ6Bl1bs2ht1wytAD1csbUbaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAP8lmLa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d93b525959so3626645ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 18:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707360340; x=1707965140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dv2A54ChASbhp35ugcdtKllGijRoSqhOKQN8wmhQdxU=;
        b=eAP8lmLaqLRseDisQf/Un9nT3q0RwB0bKdzrrxpBmlWX2lSI+OwoVBDsGjYFywatVn
         rYboyblEbHLW9iVEyG0C8V03jGv/cc5ZcO75USvE6btcM2XJOnr3mk82lH7HuGhxe5XE
         oQFW2U9QTjpHc6ZkOxSK/l9nNoMbSJRNllHQfF4+n5t3YB6uqusrAjb/BFHZGX1AZGhw
         4iEtpG0Y2gUixz7wbCj+DjFpyFpG/ViQh83G+1mbkPnifzreXMbkt2rbARZlUbXsCsOX
         6zy28RVhYbCC1EcVncW6SpKdMKE9F1lTnKHtYJLJrUTT2qBzDx6ji2M02Hq8vHQxmS0T
         Wg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707360340; x=1707965140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dv2A54ChASbhp35ugcdtKllGijRoSqhOKQN8wmhQdxU=;
        b=CViR8XGHiMuXhfKWE1izGxhQ13JCbqpmrNjpe8pNvmzl6YGOq5XyhWKYwMT+p1op0C
         TrDowyfd1helvrTuz5sKwm6RMTMSbahTvReCSM32Ifg+h9t0BFgDraVkiU1AJsznpAO2
         eC5R2GPVGEsX8L7rk53NOv18VoojbFh0JlqFnPvA9nyDcgwzSb8hFHygdxJ3qNzJ3Hfb
         0BCJEQnyq4hjq9h6MlS7cRQ2HnD3ME00/ek6zB+tFyQFYlBC5tTkU5mZTtrFoiRW9Lc/
         LLj6KExcKD5lr3rc1jeqq5QAfJR05NeasCQjfo1xa5mTw9DB1wcww2ofeXEJBaQX0U3Y
         r73w==
X-Gm-Message-State: AOJu0Ywix0DK0vurViHqCb4m1p7aF9B0Ne5H+5X5CQbaDnSIMxHYCT77
	xgfF17JgD/Pb8rzJkN1j+NmC423GCHH+ExmznI7KHG2TNOiX00fJ
X-Google-Smtp-Source: AGHT+IGdVQxUmchOPeo7AdKxNZTFty/35XNKnCkEOCLJdRVxNs1P50GEaF59+7duo8Uca8X661hWiA==
X-Received: by 2002:a17:902:ce86:b0:1d9:6fce:54f7 with SMTP id f6-20020a170902ce8600b001d96fce54f7mr2055581plg.9.1707360339807;
        Wed, 07 Feb 2024 18:45:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWJucahofdSZIDwToPUKSbHqSCjdUCAw3xpoghVWow19UJa1xmQdvS0Y6L8Nrj9UNK6zh3jT5s8bmXHCQUmnJ6TiiJpsc022DKwC1Na/Q5KzAfsn/n1sclXa/83RkTtE6WVTc5EBN8A5EJBKK1QSzMQtzoUQE34c8KF2K4=
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id kr14-20020a170903080e00b001d9537cf238sm2207754plb.295.2024.02.07.18.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 18:45:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 7 Feb 2024 18:45:38 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Message-ID: <c90c3677-a776-4938-8ad6-c6dd17a56683@roeck-us.net>
References: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
 <20240207-fix_sparse_errors_checksum_tests-v6-2-4caa9629705b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207-fix_sparse_errors_checksum_tests-v6-2-4caa9629705b@rivosinc.com>

On Wed, Feb 07, 2024 at 04:22:51PM -0800, Charlie Jenkins wrote:
> The test cases for ip_fast_csum and csum_ipv6_magic were using arbitrary
> alignment of data to iterate through random inputs. ip_fast_csum should
> have the data aligned along (14 + NET_IP_ALIGN) bytes and
> csum_ipv6_magic should have data aligned along 32-bit boundaries.
> 
> While this is being changed, fix up the awkward offset code in
> test_csum_ipv6_magic and use a struct instead.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
> ---
[ ... ]
> @@ -639,3 +526,4 @@ kunit_test_suites(&checksum_test_suite);
>  
>  MODULE_AUTHOR("Noah Goldstein <goldstein.w.n@gmail.com>");
>  MODULE_LICENSE("GPL");
> +

git doesn't like the new extra empty line at the end.

Guenter

