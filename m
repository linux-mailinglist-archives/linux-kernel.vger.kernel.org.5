Return-Path: <linux-kernel+bounces-63835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E04853527
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8DF1F2220F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764EE5F844;
	Tue, 13 Feb 2024 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuQpxVsc"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6EA5F540
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839506; cv=none; b=I/TFZNv7e85PWqM0lzrxQV+drmt1JgD1kCsH97Iuc+uWjxctPwBgz/BHh5M87jX4Eq1iToRqWcyYVvg4sVld+88xIeAlu7FIMhU9GwW5sKt7OqBNSH9ilpIYdn+aujvAglfuOQ3UYJ83C9jT/3KX43bw4vNKpFjFqvpjt6R6vhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839506; c=relaxed/simple;
	bh=q/kL3NK0Oh6JKbtt5pAiHpip2kdsHCnqNt0VYwL9wDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEn4a2+FEaQX7q75ikIaeqG1aHsEZ/fkIkpgjXLALci5JNhNsxUOHFKW5besNqdXb1Eie8T31V98qE4fGGYu1K12DiKHKGWMCor1kG05Xzw6evNaM6ROZEoJmhhjw1nAuJ6osjB2t4GUiWtQbGLPYnwoF/A1HFSjTqfY1+HfCNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuQpxVsc; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-296dcd75be7so2664227a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707839504; x=1708444304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+3BpPKMjD1J2fSsUJskQB1Fc9DT84H9Okdrmy51Z0A=;
        b=BuQpxVscxxm+0bvzGjRWZuvq74k6Aowheg8enkdI71QW2YCEAYK8ZSA6GryZM+s26x
         iie0oF5TJqAja6l5KGuDUNsyjoA6QtV96Xty4EFPFdIV2WSSvteWqg2WCzLr/VFVeYOC
         VcohjKL5Xd5msqNYsaHDng6+QjeTCLKNDiuPK7oEM3qSHSNOLWlk07i9fZ1uJwby/4K0
         x4Y3rUpFqXnpPZWxL+UmTNgkqj1A9UtcUgssMLbN8sT5ImF1inhC1WopJu5YJEFQOE7R
         Xr4geD37RHN17mRUlGZaEEojYVyTX0KAW0D6/pQUKOQA1joB90eM2pvJ43y2vS/IswTa
         7Qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839504; x=1708444304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+3BpPKMjD1J2fSsUJskQB1Fc9DT84H9Okdrmy51Z0A=;
        b=SSVGz4u+v+nngi8tIoAyKpd/bCQqV7i/8Sjb8MdxqM2rfwHUxwZSYrm/DJr+uU+YIu
         du4kUsE8irjHWGblsd/mJ2YqWKQSFkWnHkcdZKOSjARK5WM6qcYvz+ckLibPhcxULH4d
         NlJ880+TDPmSXE7y5X7tqtaHpDIEChz2KyY4KFk/UXM+Varszc5cssTfqujdHEThCpsD
         Ek/TKEkKDBtGaKRSaXN9rXrAQJFjQ7Rvy/yqdabdmmWxjazCBOIaVPBn9tAIozGYSLcW
         06gnN/Ql1eUw/k37S7rURfwyRJrOeLN5WV72VJaDAwU7c3dVCF3t/ZPipIa5jp2NWOGh
         inCg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ9sCnslooKTloy/Joros2OcnbUYV9eccRmu2rbzFlfsg3KGhqyCYt9KOMqZcofsJhgPvlGcjfxVRMBVakLcpK3PRKG1LfUfq9Bl1j
X-Gm-Message-State: AOJu0YyBmK+1N3XkJazk0PmGCsTvaMUvry+TkhQppumAWVcdp9ulFDJu
	c/s1iQiGm/8gFEsepAIpovRdFk/PZEgJ6adBcEmKSRpZl9WLZypE
X-Google-Smtp-Source: AGHT+IEsWGou5BrI7jXGE1ykKK02+8USi2XqLCH6FQpNxnaibgiTay5HcsTkmDJYtjv1MNlJ8su42g==
X-Received: by 2002:a17:90a:1fc8:b0:296:cc9e:89a0 with SMTP id z8-20020a17090a1fc800b00296cc9e89a0mr7558147pjz.38.1707839504373;
        Tue, 13 Feb 2024 07:51:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXYBK900j0AubnvtqZw87qgFis1cRZ6WxbcAPNAGuJKjeJ4ViPt/NqCBpnELJCDORoNdyCE22Dpk0yqEQVhire0XwCyCmHScK0f78jpwNYxYu0bZM1Tp+oisga+nxLBKG0o+i+lwGkBnQX8NX6rZnoRAjI7hJY8XLHdCeiHyju/Rcg28+3jaq6r88MYqj52EF25eT65
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id rr16-20020a17090b2b5000b00296a23e407csm2690654pjb.7.2024.02.13.07.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:51:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 13 Feb 2024 07:51:42 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Message-ID: <3e73b623-07c5-49fc-b76f-4fb3d29dd203@roeck-us.net>
References: <20240212-fix_sparse_errors_checksum_tests-v7-0-bbd3b8f64746@rivosinc.com>
 <20240212-fix_sparse_errors_checksum_tests-v7-2-bbd3b8f64746@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212-fix_sparse_errors_checksum_tests-v7-2-bbd3b8f64746@rivosinc.com>

On Mon, Feb 12, 2024 at 12:33:05PM -0800, Charlie Jenkins wrote:
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

I don't think holding this up for the sake of parisc64 (where the test
fails on qemu if the addresses are not 8-byte aligned) make sense, so
I would suggest to move forward with this patch series and address any
remaining problems separately.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

