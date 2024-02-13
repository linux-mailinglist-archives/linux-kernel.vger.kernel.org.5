Return-Path: <linux-kernel+bounces-62764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 975C1852569
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CB01F24F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB028827;
	Tue, 13 Feb 2024 00:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HiGWLyrv"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC8A111A6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707784339; cv=none; b=N206dwAyCZ56uav9qi+TNpmCG/J3t1TLSl8TU9v/5sZyx3m26b+hOThM6p9iVFoo8J7GU2AgAGD74SuRAoL5VlN3VEkjKIV26DfV783/l1hCPE7xBf/nTsvU+ecnHWbTgGZkggEI5EgfkaLGRNcr13yyp2/Je09zOfVswtnDyyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707784339; c=relaxed/simple;
	bh=pjSDymu5K+8xXQxE/9lump8Jd8SaRcQkICx1lFhQJks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOgfl5cDxR0oFNjQKYmQEPP2tS/ib9N/XcSzbe0f+xBxBl0vmiFsLnT/FFnYMZRrsiOoh6f7XC/T+IOaVobFl57nkRVZc6HlfO63PkWWNfhVZ31FO//LB2EZxQMgqrh0sE8x/nHF1BEEftDOu/E27gGx7OU32c45TnJdkaUy1Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HiGWLyrv; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-607815b5772so2404547b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707784336; x=1708389136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZ4fwhfm6Ayw4wyRYx2scdFCzTa2TYM0p4hdVX9g/H4=;
        b=HiGWLyrvB8mwWuzTZV0H4XT8Ytw0uMUbTJJ10Bzrjr4RizIK7bX1RcQI0DJsbShjdZ
         mHX7J2k5N5BNhMJS5aBf90SzP+1YcryrTpQFOD2ZwWhXB5kSGIfxjTnLSY/gbCZkkA7X
         pr0SbRrrocc+Sqx3jru8veg0SgVtqENaPzoJU0fHjEGjbgkVkXFUWwYkzJuRhV8lvpc5
         FLhTzCskIsjv/HcpEEw7GLrp3JkAEhTCXyeV0IP1gGxmXNfkUcQlbjArWXyuZe3m7Km0
         LritTSAgZvPyasUukw1NZYLCuozmVubPYuUxs9A2/SKbAxfKXTA5/tsIGjreuBFWYQo3
         V5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707784336; x=1708389136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZ4fwhfm6Ayw4wyRYx2scdFCzTa2TYM0p4hdVX9g/H4=;
        b=H9VjIqMaRmf5qtFwYmyOMyIdF1nZywuU9zf+z/ztsyhPlTdRn70cEvu8gMpLxn9xjX
         e/QAoCuKyxJLkPkHRjbYXKjDExLDFzSy83bNFsbJlf3sYna+NQNOduQxrimSUlYxQA4K
         fhhgBIUlcbRGBV/uG4z/D/8uN81OQPkabuv1Naja0aQZSKNIu9gsK6ERgrqOGTzSndrC
         ROX2n0uJX5XcYPaFAnf4CLIrqSxKxAOLEP/9mfrv3UL56V82/s5OAecmOAxHtouMPz43
         QdXU403i/C9fS34Bji5cj89SUWrpQxgwcQoKhVP7Ix22AtyB+hXjEstwbkTYWoYeCNbD
         r6FQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9LH7Ga4K9ME5ZwtS4kyHgOUwJ9WNmOlVdAPh2XEKb2d+L666LNonlLet3Bi1g8Tmm7CzVjT4euYXRA8NE7tPmAgeNgqQY4y5I88Fl
X-Gm-Message-State: AOJu0YxPOyhVs7j1Vprmoj65QPZ3FqZ4oxp9NMNd2Vh+GQ3yeE10gC3y
	9U2dUAXXVpHdPMXsIpjm3+oE+F0sQ21yFmR8FeC1weZ6zJfRTzquOEr7TH6g8onam3CA45rKQtk
	2e20=
X-Google-Smtp-Source: AGHT+IExEAYP5uIncN5jBuz4niE1/YifR/DAiVbwFSCYi19ETAYFSKTmKgH22y2nXLQvAyzTKZ/6eQ==
X-Received: by 2002:a05:690c:2c0b:b0:607:7bce:fe28 with SMTP id eo11-20020a05690c2c0b00b006077bcefe28mr741871ywb.13.1707784336320;
        Mon, 12 Feb 2024 16:32:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1gTH1Jf44lpMZibLYSwubdAsXgCBWGTvzB01EBJLBLpkM0VTaDk8kYeKQVaQhzabBqQC9N340vK8eezWtCGWZsUyuI+Yy9rAeeP27+7Yg5sTiQKsWgyEb5b6lBhb+0+qfsq7D1tqbkszkz4aOwO+l5TRT14XEj1hwF+9b6fknZemfAIH+lhqfJyS5p8vqfyW7LzFB
Received: from ghost ([50.146.0.2])
        by smtp.gmail.com with ESMTPSA id s203-20020a815ed4000000b0060410ee94a7sm1396031ywb.143.2024.02.12.16.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 16:32:15 -0800 (PST)
Date: Mon, 12 Feb 2024 19:32:14 -0500
From: Charlie Jenkins <charlie@rivosinc.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Message-ID: <Zcq4jj3vsVtqQIHr@ghost>
References: <20240212-fix_sparse_errors_checksum_tests-v7-0-bbd3b8f64746@rivosinc.com>
 <20240212-fix_sparse_errors_checksum_tests-v7-2-bbd3b8f64746@rivosinc.com>
 <dc352315-0b7b-407a-8704-e424934a922d@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc352315-0b7b-407a-8704-e424934a922d@roeck-us.net>

On Mon, Feb 12, 2024 at 04:14:49PM -0800, Guenter Roeck wrote:
> On 2/12/24 12:33, Charlie Jenkins wrote:
> > The test cases for ip_fast_csum and csum_ipv6_magic were failing on a
> > variety of architectures that are big endian or do not support
> > misalgined accesses. Both of these test cases are changed to support big
> > and little endian architectures.
> > 
> > The test for ip_fast_csum is changed to align the data along (14 +
> > NET_IP_ALIGN) bytes which is the alignment of an IP header. The test for
> > csum_ipv6_magic aligns the data using a struct. An extra padding field
> > is added to the struct to ensure that the size of the struct is the same
> > on all architectures (44 bytes).
> > 
> > Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> This thing really wants to annoy me. Now I get:
> 
>      # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:494
>      Expected ( u64)csum_result == ( u64)expected, but
>          ( u64)csum_result == 46543 (0xb5cf)
>          ( u64)expected == 46544 (0xb5d0)
>      not ok 5 test_csum_ipv6_magic
> 
> with the parisc64 tests. All other architectures / platforms work fine
> after applying the various pending fixes. It looks like a carry gets
> lost somewhere, but I have not been able to figure out where exactly
> that happens. This only happens with the 64-bit hppa assembler code.
> 
> Guenter
> 

How do you test parisc64? It's not in buildroot which I have been using
to test the other architectures.

- Charlie


