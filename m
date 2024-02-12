Return-Path: <linux-kernel+bounces-61107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3175850D64
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 06:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259DC1F2429B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 05:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7FA6D39;
	Mon, 12 Feb 2024 05:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bY6vRmvf"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4C45684
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707715573; cv=none; b=KhBs+2Mwgsw3Yh+xFiP9jd/5wPpgkcNCDCDf+Ii1ZNlnhyLW877hIp4OWQrF0zXB5r1qKr6JiJcm6LUOKa0oR5M07bbrwhDbPtFFQ0g+ptorRJjx5oP48/jQG+PvlMBdtJeciP0ynpgqMtFDfNkau2y1b1Y8uTFJHZ7dKbySbjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707715573; c=relaxed/simple;
	bh=uglYmxDdnWtgOOiadu0D08+QrXu5wQHenc6xl6lNQ1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0tIebKuSRFMJLkFjQ3Vzj8x18SizgcU1n2AwzrOAX381muBj/bOHy1Cl/zh1cDYGKam2ZpAE72ESediQWeZ39Sxib5MXvmFowNv/pggoUKnODgAWq8mF6TsBFN3I/iHuKPFN3fs3JK02Ow7vE1+faOGqtNTkjGpq38joYUNLsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bY6vRmvf; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-604fa400f85so6997927b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 21:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707715570; x=1708320370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dMbsupWc0Prp4NO5Ois5fHNUpWH4RT+FSrVvblsfq8c=;
        b=bY6vRmvfozqMDGs8MR/0P81qqMhmWBVoh5HqrdUlkaQNU1XxsXCY1/r7aICaAhRHMD
         DDgN1uM8i9aRpNCUBRWjpjORohj1Crbxw4DO3ig+DchIIa/V5x9VR0oYf+6jYL8/8je/
         bnEKSLBIQ/aF/OFi0OOYn2IlvxgiMck04dGlU5ERFsrmLKQp7QSvUMewlvZ4S2Nzp3pF
         E166brvupTXkjDGPgdnRP52CrUuM6QsewQ8VJx+HRA4jy5a7mZ5nUtddHdGaGew+Tz6Q
         +fvBzukIxAoPwXxdQv5VMUjnYR4l/3OXu8zlh1N2KaaWPYHsJi34CzUNNJhuKNxYi6tB
         CI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707715570; x=1708320370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMbsupWc0Prp4NO5Ois5fHNUpWH4RT+FSrVvblsfq8c=;
        b=DOsvRe1CSGHcppqxFJwndvTPhkhugKGbVeZ2WAggtX2jc501x30PZ3gcVRtihx5f0X
         t7p8IliuIJgpvp/5HQ9qp2TrQ0tuC7gBCseeGcBzymaaF2c1CuzflD8KjMBeTh9hXwIv
         CdvMtbo/R3w9veCyPZJkNI48eh+uGVZFQFA3G5+du879QrXZtoFYVIpTZlQyWXTmpIMf
         IGFuVFSK3yqVACGbwOvyLwJPc2tD4aFX8IIu0rqqRKHr1uvjIgBc/5weSQe4CWtAqooh
         Q0kJ+gmX39EqLnPkmGcaRxJqzbfSMUVYywWJNIYSQ4FtkpvE3ynsLyI8KpRbQdNdSgkr
         pxxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmE8VxBHc28zVtY0uR0ma03DHXv47d2gYsQn/KDEuPmJw4T6hnFUrMEyOX7JX8dbcyew4K7VO05pAvi5Hn71fE7dn6W9WRNrpOTomM
X-Gm-Message-State: AOJu0YwZZE3X2bv3EWwgcF9PHkfOXTOkpel52a1w09s0sIUrZCenKmhm
	Ai+Kb+xrmq5J3TIXi9IM9eDd4O52PjN7pJv79dCE7PHdHTGU6QBNyBoNp650zyo=
X-Google-Smtp-Source: AGHT+IGxQjl70qUaWmk+AZN08NxS6zLOxv1kMhmZaZhxmpn66O0mZkClNn91sK4RUDSXqBJyZ+jD5g==
X-Received: by 2002:a81:520d:0:b0:602:ca0c:fea3 with SMTP id g13-20020a81520d000000b00602ca0cfea3mr4627970ywb.10.1707715570280;
        Sun, 11 Feb 2024 21:26:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV25Q8fc9z4UFWugs1Ng7+HQvzu0Id6ng90hsn1Va8Ku9HVUmD8gdrTlhOmSD7qylYvfoFoYt7BadVqumAJy2izc9lAvvTvXnVc+0kOLYvZMdXV+StyCx+4jhOX4Y+1/X+riGxKJlc7smuYs4Ly288jttpeHKYSnbaHJz3cz4Y7LBtw3v8dqK9MDL4=
Received: from ghost ([50.146.0.2])
        by smtp.gmail.com with ESMTPSA id u18-20020a0deb12000000b00604556b8cddsm1051372ywe.3.2024.02.11.21.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 21:26:09 -0800 (PST)
Date: Mon, 12 Feb 2024 00:26:08 -0500
From: Charlie Jenkins <charlie@rivosinc.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 0/2] lib: checksum: Fix issues with checksum tests
Message-ID: <Zcmr8C1dTuaPvXqJ@ghost>
References: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
 <8dedf370-47e1-405d-85cf-53f3acfa16a0@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dedf370-47e1-405d-85cf-53f3acfa16a0@roeck-us.net>

On Sun, Feb 11, 2024 at 11:18:36AM -0800, Guenter Roeck wrote:
> Hi,
> 
> On 2/7/24 16:22, Charlie Jenkins wrote:
> > The ip_fast_csum and csum_ipv6_magic tests did not have the data
> > types properly casted, and improperly misaligned data.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> I sorted out most of the problems with this version, but I still get:
> 
>     # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:513
>     Expected ( u64)csum_result == ( u64)expected, but
>         ( u64)csum_result == 16630 (0x40f6)
>         ( u64)expected == 65535 (0xffff)
>     not ok 5 test_csum_ipv6_magic
> 
> on m68k:q800. This is suspicious because there is no 0xffff in
> expected_csum_ipv6_magic[]. With some debugging information:
> 
> ####### num_tests=86 i=84 expect array size=84
> ####### MAX_LEN=512 WORD_ALIGNMENT=4 magic data size=42
> 
> That means the loop
> 
> 	for (int i = 0; i < num_tests; i++) {
> 		...
> 		expected = (__force __sum16)expected_csum_ipv6_magic[i];
> 		...
> 	}
> 
> will access data beyond the end of the expected_csum_ipv6_magic[] array,
> possibly because m68k doesn't pad struct csum_ipv6_magic_data to 44 bytes.

Okay I will check that out.

> 
> In this context, is the comment about proto having to be 0 really true ?
> It seems to me that the calculated checksum must be identical on both
> little and big endian systems. After all, they need to be able to talk
> to each other.

I agree, but I couldn't find a solution other than setting it to zero.
Maybe I am missing something simple...

- Charlie

> 
> Thanks,
> Guenter
> 

