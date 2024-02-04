Return-Path: <linux-kernel+bounces-51832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6128E848FCA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0DF61F23119
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C8B22EF4;
	Sun,  4 Feb 2024 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3k+XeLC"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B28522089
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707068520; cv=none; b=t4LPgKjONg+3fpjGhxun62l5sUbu/jT3kSUl25xmVHoQ4OP5iMCTwF/1aLsurBDp6vlGYHpu+3/+ZYA6O2bcQMGxNqQS0sHKf5dF8cMd/XWX50ffdVQosL8QY/z+TY6Eqowh+By2qHk95k1Me5bN9bX2LRok6Q3nvOHY2IxDmmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707068520; c=relaxed/simple;
	bh=O0aTQZD2F43voU1Yir7u1fDNS+HgXMZ/oThz3Vf0+xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxTcixmDVXDVTwW1hX+APv8aUSf+EAO3SiPo2va+gBSC3yADp/0A5eFhu6rC0LK/Ej99dVPn0XYH/zdUFlcvKvElCvUoS25RJvLiuBcjIWu17cI25IsS4fPnU8BEieFQfT4iBNQw+WIJCPPnKH1TiH97vLJ1fJFtH55tXDnejZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3k+XeLC; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so3017513a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 09:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707068519; x=1707673319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uILQb7xlvwcvMVBvKlI5TezeCPj8ieCfIVJIBkgd3HI=;
        b=d3k+XeLCcgC8rZjjxLY7+0x/lJYisQfGSxtdQzHXXEcHi5SPb/r35lazk0csDVILJr
         DSvk3MKWo+6ZdVH1kevnlf1cifkN0caYr2q6+ckWDT/uXou0pqWp+4P4bMJS7KaECDMO
         HwXVOScdI9lGev+rW8lVH1GMBf8NiUozRzy7GENRY0UN3bBN5BxGDBHLEajQ9JE34xRG
         50+cF2NqmeJY66OjQ9ob616lrMlyNNVCNVrMuAJv/rv3VYispyamUn2WKWPI+S5IgR1V
         2BEc1jd3yRyq+mMDInUtpEDOOFk3Y3kSk7TcqZYbBAXEj7gEXLnLm2P7LZRNZv6Mgq5G
         kTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707068519; x=1707673319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uILQb7xlvwcvMVBvKlI5TezeCPj8ieCfIVJIBkgd3HI=;
        b=OjZqVsWSpUbF1vZPVoRoAyOi0XdTDKDbL3AVNuRRwWFGVBrYaXQf0X6BJ9pfK+ZW8y
         r6srERbIVdxbHuC1a1+8xjYw68sMm7MXDnuycR4+RcIE19RF1sjDpj9mZrf8YnWmV4bp
         zzc3kPBjFDhcs2izrki1HBD7rYQOUfEM7Rbvmwgtao5/fcHRQE+wNhKe42Fsr8g/POAn
         7Mxo/h2UD9IPa5g8LvsaiU6PLURcTLCiAU25jsSj6xng/B9bR4BTbqO32zgZE4ls+pc1
         Si35de5JYG0u01Ei/nvuaZAwgwPpMN8t1zWAi6fq30yWqwJqbKaMCm1Oppu7K8F8GkYR
         O72g==
X-Gm-Message-State: AOJu0YzWIyMYtNHGuhnyytLzFcvkhbJrOQ7HXr827PIDTf0Xz+whkBm2
	ddjGkqUzgXX1xfVnqxo6Fp8G+frFQpSTlvd+HVb6U8RuNcIQk/nuWRAdsaJR
X-Google-Smtp-Source: AGHT+IEej8Ylssv51s41v5ybtoKQDVM0kx3ZhTp1jBEmAc1X73WEs/9sEY9hJ+KicQdGjwhAwyr7iA==
X-Received: by 2002:a05:6a21:9185:b0:19e:5514:42c2 with SMTP id tp5-20020a056a21918500b0019e551442c2mr5773461pzb.52.1707068518522;
        Sun, 04 Feb 2024 09:41:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWsKMJAURb+pbu7GgafcIY/I1o/l/1+osqehbQ/7LbPMFolgwKNCNffA6yGa5iQm4Uj0MAv/CrEVOTevyFi63/leU9qs2krr3B04vvnvsVlYOJfQDzD3JsDo6NkSanWp7BwKm3WIJkX52P7LXKr6A/eVr0yWtvz+NRu7IY=
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o2-20020a170902d4c200b001d8f3ba10b4sm2524661plg.236.2024.02.04.09.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 09:41:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 4 Feb 2024 09:41:56 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Message-ID: <ec44bf32-8b66-40c4-bc62-4deed3702f99@roeck-us.net>
References: <20240130-fix_sparse_errors_checksum_tests-v5-0-4d8a0a337e5e@rivosinc.com>
 <20240130-fix_sparse_errors_checksum_tests-v5-2-4d8a0a337e5e@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-fix_sparse_errors_checksum_tests-v5-2-4d8a0a337e5e@rivosinc.com>

Hi,

On Tue, Jan 30, 2024 at 11:10:04AM -0800, Charlie Jenkins wrote:
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

So this works on little endian systems. Unfortunately, I still get

[   18.447037]     # test_ip_fast_csum: ASSERTION FAILED at lib/checksum_kunit.c:463
[   18.447037]     Expected ( u64)csum_result == ( u64)expected, but
[   18.447037]         ( u64)csum_result == 33754 (0x83da)
[   18.447037]         ( u64)expected == 55939 (0xda83)
[   18.455565]     not ok 4 test_ip_fast_csum
[   18.463570]     # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:487
[   18.463570]     Expected ( u64)csum_result == ( u64)expected, but
[   18.463570]         ( u64)csum_result == 12221 (0x2fbd)
[   18.463570]         ( u64)expected == 37721 (0x9359)
[   18.470679]     not ok 5 test_csum_ipv6_magic

when running the test on big endian systems such as hppa/parisc or sparc.

Guenter

