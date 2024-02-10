Return-Path: <linux-kernel+bounces-60431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2768504DC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF3EFB20EE4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527F05BAE0;
	Sat, 10 Feb 2024 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9SLJrnM"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82F654FB3;
	Sat, 10 Feb 2024 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707577964; cv=none; b=eqSvQ6DcZs1e1oegjx9L+avdW1Upi5Z9l/oGFLykFbHfCcMEB3rJCEaTuw5CERcVzxJn+KrGSEfQcGzBIrANs7HnVcBfjDnrCrWNR6cI+s+7zKKNUgWxhvKPASIdcaYbo72m6vFtLmLJSjYO8hmx9WySbQjkIEJpa31GtbefMVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707577964; c=relaxed/simple;
	bh=iTIO5bGoB4ZilWo6UjR4D1Rg7K9rc5sfkyk8gOgeG6k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gHLszU08lRpCH3HC6OKYVbDp4dKYNn6AttKeCqcYrevoUNxLb1fUkzflwExJFLghEcpixxckysGvvmERZ0o8wcCw/GDLZU/Uv09iDN+GBhzDQzAQ7gksMCxQDHM2OKpimdvvtsFEMKTkAu/24wLVFuK40WZ40TtVrRpUvR16K0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9SLJrnM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d7232dcb3eso16217165ad.2;
        Sat, 10 Feb 2024 07:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707577962; x=1708182762; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CAwb6SlMI0NW4wrBgE4BjEZeBVnJ7/pDceRjOIxEIxg=;
        b=g9SLJrnMS8EdX2mWp8OwsywMQb3ZJ6Mj3gT+O/1S1OzBNEgKSdaxhoe/nySFe96xPX
         9RVa1/h6+hDLtNqXnKuKioyy5PISxPGcXUMeTz0QlYDMbGjaCs5dyj++cZg6JWI03El3
         p+U91vZTLdls6SAXDr48vfz45t5BSXq4LhceK3rDepFhagW4d2K+7x2u9mRRlEX8+TNN
         T0Pb8YjrOxsXgA/cr7wbMxX9LrwIHzF6Ng4UeO7lcFtgNZAH2FfjNFW+cfiPQ9RfK/UO
         Nj8dD05C6j0VhKHZ3LZ9KaOnBWbhuTVYBGpraTO9KaKnRIZMhZCzPeasXI7gfmuXEPib
         t7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707577962; x=1708182762;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAwb6SlMI0NW4wrBgE4BjEZeBVnJ7/pDceRjOIxEIxg=;
        b=QFGVY6kYoYfaoCosUT+W3yHtIK4ysu81FDXnB2gUCRO6RhnxwWHi+eJ/bx5oTfwMhV
         +DR2nHesXC9Qg9YYT7S2We9FZoOmTGCalzs7A4Xl4C8EyKhyhRWzEcZImrQE1QHVbClh
         eQ0Vg0EbY7nKuVPjbGQDbv0TPrF89SS8TgaUt4WkSFB12kYbMzCSyPoUm5oNnH+oR4yC
         bUXwngDASOX7waQsgvS6NNdjMwj+E7Mzh51mf7DRfbbTAcPTIy/TLgarBdaMzRgwGUP6
         pXHC1gxZkVb8m6WmERv5/gfPJRE/9oxJbJl1tzBt1zdCQ472t6FX9OnNe9+ROOyO5dU9
         x7mA==
X-Gm-Message-State: AOJu0Yy3GMq1SrQv3bYBWQvmo4yLdbMwbeLLeA3XI5cci/NElarB35fe
	pLRXExRxXo882OBzJvBQXLfXA+Jer3IZP/OdJf7dd0rqbzmT8izAkx1hzuKQ
X-Google-Smtp-Source: AGHT+IFe8aIc+Flf04LZehzrsL9WPaNcHC3QmKqdfS3f6/ejzw1UW3om74cfRNnVYoZZHzV72qnIyw==
X-Received: by 2002:a17:903:40c4:b0:1d7:7347:d80e with SMTP id t4-20020a17090340c400b001d77347d80emr2521087pld.37.1707577961837;
        Sat, 10 Feb 2024 07:12:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZQoHCC4TSupUv2aTjaeCQ1SMY+I+EhSNgr/eUCHVOon1OLL5nYmHjsBzCQzlsUsR5nr1y9DDD3h7ogkui1Uuaoe1MbEMnkZEi4rWdJYGnuRgVjDnYtAah32xwzfDRDLc4bChbAUqRtBEg4jkS2bjvEwd09AAzv/RtjANquO1qutExdZ8=
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ja15-20020a170902efcf00b001d8d0487edbsm3155929plb.223.2024.02.10.07.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 07:12:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 10 Feb 2024 07:12:39 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Problems with csum_partial with misaligned buffers on sh4 platform
Message-ID: <65ed7c95-712c-410b-84f3-58496b0c9649@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

when running checksum unit tests on sh4 qemu emulations, I get the following
errors.

    KTAP version 1
    # Subtest: checksum
    # module: checksum_kunit
    1..5
    # test_csum_fixed_random_inputs: ASSERTION FAILED at lib/checksum_kunit.c:500
    Expected ( u64)result == ( u64)expec, but
        ( u64)result == 53378 (0xd082)
        ( u64)expec == 33488 (0x82d0)
    not ok 1 test_csum_fixed_random_inputs
    # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:525
    Expected ( u64)result == ( u64)expec, but
        ( u64)result == 65281 (0xff01)
        ( u64)expec == 65280 (0xff00)
    not ok 2 test_csum_all_carry_inputs
    # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:573
    Expected ( u64)result == ( u64)expec, but
        ( u64)result == 65535 (0xffff)
        ( u64)expec == 65534 (0xfffe)
    not ok 3 test_csum_no_carry_inputs
    ok 4 test_ip_fast_csum
    ok 5 test_csum_ipv6_magic
# checksum: pass:2 fail:3 skip:0 total:5

The above is with from a little endian system. On a big endian system,
the test result is as follows.

    KTAP version 1
    # Subtest: checksum
    # module: checksum_kunit
    1..5
    # test_csum_fixed_random_inputs: ASSERTION FAILED at lib/checksum_kunit.c:500
    Expected ( u64)result == ( u64)expec, but
        ( u64)result == 33488 (0x82d0)
        ( u64)expec == 53378 (0xd082)
    not ok 1 test_csum_fixed_random_inputs
    # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:525
    Expected ( u64)result == ( u64)expec, but
        ( u64)result == 65281 (0xff01)
        ( u64)expec == 255 (0xff)
    not ok 2 test_csum_all_carry_inputs
    # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:565
    Expected ( u64)result == ( u64)expec, but
        ( u64)result == 1020 (0x3fc)
        ( u64)expec == 0 (0x0)
    not ok 3 test_csum_no_carry_inputs
    # test_ip_fast_csum: ASSERTION FAILED at lib/checksum_kunit.c:589
    Expected ( u64)expected == ( u64)csum_result, but
        ( u64)expected == 55939 (0xda83)
        ( u64)csum_result == 33754 (0x83da)
    not ok 4 test_ip_fast_csum
    # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:617
    Expected ( u64)expected_csum_ipv6_magic[i] == ( u64)csum_ipv6_magic(saddr, daddr, len, proto, csum), but
        ( u64)expected_csum_ipv6_magic[i] == 6356 (0x18d4)
        ( u64)csum_ipv6_magic(saddr, daddr, len, proto, csum) == 43586 (0xaa42)
    not ok 5 test_csum_ipv6_magic
# checksum: pass:0 fail:5 skip:0 total:5

Note that test_ip_fast_csum and test_csum_ipv6_magic fail on all big endian
systems due to a bug in the test code, unrelated to this problem.

Analysis shows that the errors are seen only if the buffer is misaligned.
Looking into arch/sh/lib/checksum.S, I found commit cadc4e1a2b4d2 ("sh:
Handle calling csum_partial with misaligned data") which seemed to be
related. Reverting that commit fixes the problem.
This suggests that something may be wrong with that commit. Alternatively,
of course, it may be possible that something is wrong with the qemu
emulation, but that seems unlikely.

Thanks,
Guenter

