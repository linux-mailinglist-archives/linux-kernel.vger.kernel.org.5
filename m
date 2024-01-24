Return-Path: <linux-kernel+bounces-36218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54577839DA4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8773F1C21C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA61FA32;
	Wed, 24 Jan 2024 00:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="F/LfycYc"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEDB20E3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706055831; cv=none; b=eKWD6AeJMcdiCiPsGGlA4dGjRDH1oTx3QOogKOr3v5Mr6jYUElclXPB+CwM8NCHG4zhSgESNwu7PErnweB28POJmD5eOO37Xd4ZCE827KPjU3JkpfTDcFWPEzx+r7jQY02NOsUq11dY9lgL0uf3AcIfIRvs/+8UMWX0b7B75D6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706055831; c=relaxed/simple;
	bh=S0C+Wac4KFyW4JYJm7nEfR3dBS8iNFAgeH+6Ct9BuP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFeVF8l6/Fazl1jbeH9QaUo0B1igkhYMMwQUN9ENCNX/3MkLraz2eHGAgE004dUgNVWb9raAHhQorzNrrxaVu7VJWenOO73p60BXS729BovuS7r0V1I+KtuRQ7YvPXlj8DT5+kqJTaHWOm7zs0iErIuFvrkbQtVMOXDbawxF1V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=F/LfycYc; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6dddb927d02so2827420a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706055812; x=1706660612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BayaxpZN2tlMH54iqixRAV1n7gWqpd5wqr/M7uH1A4U=;
        b=F/LfycYcaJoFeDsfBLLZWxPd0OoFFXa7d7KN/JVpfbNbGlqviQCm8Kr0XAFimU4XMo
         V3U9nBR2X8u2QqzGuSfz5dqr8kI+Pw0rjH/4fZNIO/5EGTLLj8FdJUdcHmNNq9Acxj4G
         BVZNEM8TuvpBoMGDRyWjjrxfVCqK9DWOU2BvVVMFLSqIxZ4DTLcC7T6UGI2sny3/NIYq
         xZAjx4gkfxaB39GImNW/ix2OvstVItQl1279YiCL4YeAOU0sp4c3fr5WmiEhN857MpNq
         yjdS0dMKLycSjY6eG+XDNcS1Wg/0VG8hw+0h5HdyTS00HAyn6r67onqM26dtalXykAev
         kffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706055812; x=1706660612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BayaxpZN2tlMH54iqixRAV1n7gWqpd5wqr/M7uH1A4U=;
        b=I6L1tKkjqbpfrlF9YBRUARaM0HBYAY4Z+U6aFbVUs2+BAMJP7zvDqOfDBftzfwW0d7
         njRuQFTmtSrlMZAdRkO/qqEoKDVIduHvIm2znYegr4VpmDXNTYp+2tyuJQ56VNSytkXY
         QzIz64cyogoBAJeRdn5PiZZdkfym01OyvqyObnyXzQ+C+WEG/8ZLqJJrRCBNl4kI/88X
         QeYL3GDhvN+hwZXqJ3K3QZ6Ib0s1PAIgCY3tz2T1Yg6cxQW7QR4zpdNCqKRk6inJH9eA
         dKCfUGQkfj4Cg5+FqlarTdbB/sHTmRJLa0jHe1M78ZsnBx6BAFmFzbuQN7KUCAuGaLAw
         0HBQ==
X-Gm-Message-State: AOJu0YwBSzaFwYwG3nY267n2iYrGuNXplgA7pEPiVqz3uyLJRlAsY6LW
	bwd/gxbyk8SLkfRIg1Sg8k3Z9OAST1mn3klEsPi6AgRfGpJ6FDE/JhFuvHT9GVs92h0sIAKzDo2
	Qf6M=
X-Google-Smtp-Source: AGHT+IGSeVIQY9U/Msb7A2g+s1CCG0cRptz78W2D2nmwa7Prl8C1aAXRHt4wRjWFcOVjws47rbQvuA==
X-Received: by 2002:a9d:7d15:0:b0:6dd:dd86:ad81 with SMTP id v21-20020a9d7d15000000b006dddd86ad81mr820366otn.14.1706055812543;
        Tue, 23 Jan 2024 16:23:32 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00218300b006dbd341379dsm6166994pfi.68.2024.01.23.16.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 16:23:32 -0800 (PST)
Date: Tue, 23 Jan 2024 16:23:30 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 0/2] lib: checksum: Fix issues with checksum tests
Message-ID: <ZbBYgmBZ/1BRPi3S@ghost>
References: <20240123-fix_sparse_errors_checksum_tests-v2-0-b306b6ce7da5@rivosinc.com>
 <84790a56-1c7c-4ddb-a4da-17dc84c1f670@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84790a56-1c7c-4ddb-a4da-17dc84c1f670@roeck-us.net>

On Tue, Jan 23, 2024 at 03:22:30PM -0800, Guenter Roeck wrote:
> On 1/23/24 13:58, Charlie Jenkins wrote:
> > The ip_fast_csum and csum_ipv6_magic tests did not have the data
> > types properly casted, and improperly misaligned data.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> > Changes in v2:
> > - Add additional patch to fix alignment issues
> > - Link to v1: https://lore.kernel.org/r/20240119-fix_sparse_errors_checksum_tests-v1-1-2d3df86d8d78@rivosinc.com
> > 
> 
> I applied both patches but see the following.
> 
>     KTAP version 1
>     # Subtest: checksum
>     # module: checksum_kunit
>     1..5
>     ok 1 test_csum_fixed_random_inputs
>     ok 2 test_csum_all_carry_inputs
>     ok 3 test_csum_no_carry_inputs
>     # test_ip_fast_csum: ASSERTION FAILED at lib/checksum_kunit.c:541
>     Expected ( u64)csum_result == ( u64)expected, but
>         ( u64)csum_result == 27015 (0x6987)
>         ( u64)expected == 55912 (0xda68)
>     not ok 4 test_ip_fast_csum
>     # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:564
>     Expected ( u64)csum_result == ( u64)expected, but
>         ( u64)csum_result == 42151 (0xa4a7)
>         ( u64)expected == 5513 (0x1589)
>     not ok 5 test_csum_ipv6_magic
> # checksum: pass:3 fail:2 skip:0 total:5
> # Totals: pass:3 fail:2 skip:0 total:5
> not ok 17 checksum
> 
> Old result, before applying the patches (v6.8-rc1):
> 
>     KTAP version 1
>     # Subtest: checksum
>     # module: checksum_kunit
>     1..5
>     ok 1 test_csum_fixed_random_inputs
>     ok 2 test_csum_all_carry_inputs
>     ok 3 test_csum_no_carry_inputs
>     ok 4 test_ip_fast_csum
>     ok 5 test_csum_ipv6_magic
> # checksum: pass:5 fail:0 skip:0 total:5
> # Totals: pass:5 fail:0 skip:0 total:5
> ok 17 checksum
> 
> This is with the imx25-pdk emulation in qemu.
> 
> Guenter

Apologies for that, some garbage values snuck in. I'll send a new
version.

- Charlie

> 

