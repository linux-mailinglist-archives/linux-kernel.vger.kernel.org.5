Return-Path: <linux-kernel+bounces-57336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2AE84D71D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B560B1F22ECF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9E114A98;
	Thu,  8 Feb 2024 00:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oZbNfEXH"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A142114007
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 00:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351759; cv=none; b=PDBi+Gh6FjQoQzzNP3scR75rqjlIRvFRmDgePArKdQ/aRHZp2/euj9QcNoI8qqMFOaifMoNLx730kZ4S5axzkoNjIWFNZAjC0QmjYyqf3PeosKPQLrlml1RiZqeJAOOawVcuW/O62cLlgu1MQCTiSDNgDsqWNHR+D7UixXRsQjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351759; c=relaxed/simple;
	bh=MuSXA3IP7TtphrcgIEB7qapu/iC3kKGtPwNePZdgXLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LywZjrnFaQ7Rd0oiSZLqG5jc/B1SgF/OR+KcFgXTTUIn45AxDnj2apw0StrxoASjSz1eeyg+4diYt/vVe0pN74/1EumT6N9vjo3scqY5Z/iO39ywokRgR8SE2H0sHai+5Bcc+BtpXP8AbOVqOwJ1rTsnHoV70SuLxiTN1d+FRtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oZbNfEXH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d9b2400910so2943405ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 16:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707351757; x=1707956557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M+acUHj6ADJR2FLGOXvU9lLPwI2AMA4iJ0ahnr2Pu34=;
        b=oZbNfEXHLt140I7H5REpaWJJKSJKIponSs/7A6/pBe0kjXeLW4fRii3aKsXP6GBvj7
         BQVoE1yIHqpv+/tgEkQtfpdN3xNXUYQa6XRmAvVP3Ok9NUk7bSnGd2o8bLXGg1+D9P8m
         ApinOLU4I+7K3A7hMNz1F16Kf92SWQvQRsiUTaYt3CuYVIhFjVK2EGeyvpZtucAhWG7V
         ewHA2gPpRUUkCbCWWbPXE/3sMr7PFd3w2vXIr342np88fNcmn34DE0UJ4XuTXQAu7LBc
         qwEr9HFsZq8B7RI+xaoDj7UHSBmkXcJARODq12CUpVrK+5JnXCucnT/zgwiYE64uQBvD
         dnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707351757; x=1707956557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+acUHj6ADJR2FLGOXvU9lLPwI2AMA4iJ0ahnr2Pu34=;
        b=dTwYOgoZUInmVFokB20drfRMcFhfAF962B7w1C9caTQuq+3JmMk9dKqRuOHssefUxm
         U24qmrojiOBA57nwpnSoa/+GQKtqF1EY3DZ9IQyiNJ042orDrW47yzI+fSqlGZEONvGY
         nPk3+0U1MlWX6HGJMKgPnPfbyfYjUT3lMCRXuHcHwJXWuweAq00kir78URiiXEY595x1
         RZCIaC+ZmS5ES1xtYwntt3Yqf1gsUJiyIXcY0ZRkYYGLwzLgi9RO3TiuCluBST6+KRpq
         MkikXpgIZxvHN34lZbULAU+hikjF80eJ8ZGgP2hJ+gZY4/PUEiRwE6GCrnRY02Q9fvov
         5TBg==
X-Gm-Message-State: AOJu0YyeA+9rxJEjzB2v8m5tlJ08r0LEKOO3YlmaFBEJuqH2FYfSHsjm
	mKKLex5t11aeJzauSy7ECCvTUNIapl3pvBlqw4jVB9SNn74hui7GjwqCJWQBEPITWWg1vMwxsAN
	CpDQ=
X-Google-Smtp-Source: AGHT+IHo3iHDohN7YvwbCTDgWquJwGeq8Q8VFxrAikNW476SH/xmS+a4lyxH3IQab14Q1ujz71LjVg==
X-Received: by 2002:a17:902:f54f:b0:1d9:2e9d:8cb6 with SMTP id h15-20020a170902f54f00b001d92e9d8cb6mr1448305plf.15.1707351756715;
        Wed, 07 Feb 2024 16:22:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVTm9kUkKlYZEVd5oIKlKU5K5UaSydC/qBFIlBZsKQ/7HWpaUrDE2FsC+ZoVL18y3ExisF45EhPftsr81v91Jls5OM5XldIXHC+qNxqOGqMIkr72gjyIbbP6RwnZfmRz8GqfaHn3WClavYQazGFzk2UdPx02VkB3ysiTjo=
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id y5-20020a170902ed4500b001d9df9589e5sm2092979plb.10.2024.02.07.16.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 16:22:36 -0800 (PST)
Date: Wed, 7 Feb 2024 16:22:34 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Message-ID: <ZcQeyigDWwvnc4Nu@ghost>
References: <20240130-fix_sparse_errors_checksum_tests-v5-0-4d8a0a337e5e@rivosinc.com>
 <20240130-fix_sparse_errors_checksum_tests-v5-2-4d8a0a337e5e@rivosinc.com>
 <ec44bf32-8b66-40c4-bc62-4deed3702f99@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec44bf32-8b66-40c4-bc62-4deed3702f99@roeck-us.net>

On Sun, Feb 04, 2024 at 09:41:56AM -0800, Guenter Roeck wrote:
> Hi,
> 
> On Tue, Jan 30, 2024 at 11:10:04AM -0800, Charlie Jenkins wrote:
> > The test cases for ip_fast_csum and csum_ipv6_magic were using arbitrary
> > alignment of data to iterate through random inputs. ip_fast_csum should
> > have the data aligned along (14 + NET_IP_ALIGN) bytes and
> > csum_ipv6_magic should have data aligned along 32-bit boundaries.
> > 
> > While this is being changed, fix up the awkward offset code in
> > test_csum_ipv6_magic and use a struct instead.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Tested-by: Guenter Roeck <linux@roeck-us.net>
> > Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
> 
> So this works on little endian systems. Unfortunately, I still get
> 
> [   18.447037]     # test_ip_fast_csum: ASSERTION FAILED at lib/checksum_kunit.c:463
> [   18.447037]     Expected ( u64)csum_result == ( u64)expected, but
> [   18.447037]         ( u64)csum_result == 33754 (0x83da)
> [   18.447037]         ( u64)expected == 55939 (0xda83)
> [   18.455565]     not ok 4 test_ip_fast_csum
> [   18.463570]     # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:487
> [   18.463570]     Expected ( u64)csum_result == ( u64)expected, but
> [   18.463570]         ( u64)csum_result == 12221 (0x2fbd)
> [   18.463570]         ( u64)expected == 37721 (0x9359)
> [   18.470679]     not ok 5 test_csum_ipv6_magic
> 
> when running the test on big endian systems such as hppa/parisc or sparc.

Hmm okay it was easy to get this to work on big endian for
test_ip_fast_csum but test_csum_ipv6_magic was trickier. I will send out
a new version with the changes.

- Charlie

> 
> Guenter

