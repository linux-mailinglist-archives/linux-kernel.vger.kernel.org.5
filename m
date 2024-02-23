Return-Path: <linux-kernel+bounces-77856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0183860B13
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C071F25664
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F99134B7;
	Fri, 23 Feb 2024 07:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="x8FM8GgM"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F31710A3C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708671653; cv=none; b=VzNu8DsPZ3SyQAecRA1tsB6UWYA/Eds389v/gYdxnd1eBaLOkxKXUicBZHXntnBhROwzgugR8ZBd1t38dvYGpeDC/OIv1NbS+9YHXwuQWDIqklNJ6T6fiVtbggp/pGW0MMI7rekLir+hZPMow70XQCaKNUzbbcV55KwR6ThCGhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708671653; c=relaxed/simple;
	bh=KDdmo3kiqMOHOH2UGQGaftMwmLeXhnLYIooote8eqME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDtq0co3Ozou2eH7NCxgXklLHhFr7nmecKT4AealAn3XsOaDSWqa/PQ2CU+hiTlo1qUdq04RjyOFKIXTLxvQED2b6efl9rIboQqSFeY0HNTXV5PrKxVTbyx546BXJ+W0y3qSNCY61lq0IGbBWb3k46Dm10H6mh0LVgEN1MRk1kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=x8FM8GgM; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-299e4b352cdso451713a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 23:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708671650; x=1709276450; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4GCWRgSIGMo/1Rh1pYhbGvrkqDe2+bZmSg4IK0oi67Y=;
        b=x8FM8GgMK9clSy61E8cQOf+SaBwF/DVhUw++RYmmpPXjMoxRXed6bXawYtvFNYKbBt
         wjU3vhkbCbTwnQxZVdxWMW2Ld/xlCD84kJt8wSjHbbu3H8vtg74bsbmk5psQ7kRtGrQD
         wEMJWKziqVYQs4qGjzfwnvxbr5NahQlFMV0mXyF5vTNEnfXzYdbjpAMrw/bkR0xq19dT
         MeIKov2nf7vaQaUeOSXCnQ4Dm0KjC049iDnhk0iXFXNuSBetfwdkR4mgW5Y+mlt72qvt
         6cUzAATc7bnsqxcw9L1XrqzFN2SnBtVld8qBEGyLchCvcMbzC1c8H2meYE8LYdp3hctj
         gMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708671650; x=1709276450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4GCWRgSIGMo/1Rh1pYhbGvrkqDe2+bZmSg4IK0oi67Y=;
        b=iK4Afr1HoLvstUdOWWhvIezoeVIVWJOLA7xWUYyWTIg2nEK4V1ZihHsFIbV8HUE+4a
         PHuKpRt384r3+xTL5cU0ULQhsy5ktQFhskIYYtmNBdUX+mopgw1hFDg+HQKLN/c7vG9I
         qUVmDUqsn57pF/xSXDG7wcTiMfzaSCu5Y/gzdRPoLwF7Dsy5mwJeD5wDBAP7jKHMBLY6
         jvC13KaNZPPcBIfG8bEfuVrsRVCZoepx4w/pkORKbXEm2d3nPmHkz6Yu/N2xFRAy6w+5
         YFgQVtdmqibUSRQcwFSzuPODF8/9kcCY1VYXnfFEj26Q+jBVwrrIQQwR876lkUVcpCF6
         IYfg==
X-Forwarded-Encrypted: i=1; AJvYcCWyyHczJus9gYQKYJTXp9jHcfksOiyCdZ6Jzlb/UvxXD5Ij1UjP2T2PXDQvDu9eW+tnYj1mqDO8dDJbdqjj2HErIvQedvcCdfaUR77q
X-Gm-Message-State: AOJu0YxxRuHbu8U//u3yiQImC0vd8i/ddLO1MdtIc0HDPVZu7/+oSb55
	HzrtW13Tt1DR+hjJatMfhtasKGpie1F14craEuAFETgqgJT/hhXdL4QYpYFRTHY=
X-Google-Smtp-Source: AGHT+IE6xRkUNPoFSK1CMYVf6aFspHl1Y9GsmePQYoy8WjyDYLgF3VNtTwE9HjVn1d98SR896TG/JQ==
X-Received: by 2002:a17:90a:f190:b0:299:3c25:4248 with SMTP id bv16-20020a17090af19000b002993c254248mr910609pjb.38.1708671650519;
        Thu, 22 Feb 2024 23:00:50 -0800 (PST)
Received: from ghost ([2601:647:5700:6860:45bd:34a3:d1ef:a1f3])
        by smtp.gmail.com with ESMTPSA id ck7-20020a17090afe0700b0029933f5b45dsm644162pjb.13.2024.02.22.23.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 23:00:50 -0800 (PST)
Date: Thu, 22 Feb 2024 23:00:46 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Erhard Furtner <erhard_f@mailbox.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: "test_ip_fast_csum: ASSERTION FAILED at
 lib/checksum_kunit.c:589" at boot with CONFIG_CHECKSUM_KUNIT=y enabled on a
 Talos II, kernel 6.8-rc5
Message-ID: <ZdhCnoRu3i1Cnwks@ghost>
References: <20240223022654.625bef62@yea>
 <528c6abf-e5ef-42cd-a5d7-6ede3254523d@csgroup.eu>
 <Zdg3X4A1eJsJ+ACh@ghost>
 <6c37ffa2-8642-46c0-89ba-1f1e29b094d9@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c37ffa2-8642-46c0-89ba-1f1e29b094d9@csgroup.eu>

On Fri, Feb 23, 2024 at 06:58:14AM +0000, Christophe Leroy wrote:
> 
> 
> Le 23/02/2024 à 07:12, Charlie Jenkins a écrit :
> > On Fri, Feb 23, 2024 at 05:59:07AM +0000, Christophe Leroy wrote:
> >> Hi Erhard, hi Charlie,
> >>
> >> Le 23/02/2024 à 02:26, Erhard Furtner a écrit :
> >>> Greetings!
> >>>
> >>> Looks like my Talos II (running a BE kernel+system) fails some of the kernels internal unit tests. One of the failing tests is checksum_kunit, enabled via CONFIG_CHECKSUM_KUNIT=y:
> >>>
> >>> [...]
> >>>      KTAP version 1
> >>>       # Subtest: checksum
> >>>       # module: checksum_kunit
> >>>       1..5
> >>> entry-flush: disabled on command line.
> >>>       ok 1 test_csum_fixed_random_inputs
> >>>       ok 2 test_csum_all_carry_inputs
> >>>       ok 3 test_csum_no_carry_inputs
> >>>       # test_ip_fast_csum: ASSERTION FAILED at lib/checksum_kunit.c:589
> >>>       Expected ( u64)expected == ( u64)csum_result, but
> >>>           ( u64)expected == 55939 (0xda83)
> >>>           ( u64)csum_result == 33754 (0x83da)
> >>>       not ok 4 test_ip_fast_csum
> >>>       # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:617
> >>>       Expected ( u64)expected_csum_ipv6_magic[i] == ( u64)csum_ipv6_magic(saddr, daddr, len, proto, csum), but
> >>>           ( u64)expected_csum_ipv6_magic[i] == 6356 (0x18d4)
> >>>           ( u64)csum_ipv6_magic(saddr, daddr, len, proto, csum) == 43586 (0xaa42)
> >>>       not ok 5 test_csum_ipv6_magic
> >>> # checksum: pass:3 fail:2 skip:0 total:5
> >>> # Totals: pass:3 fail:2 skip:0 total:5
> >>> not ok 4 checksum
> >>> [...]
> >>>
> >>> Full dmesg + kernel .config attached.
> >>
> >> Looks like the same problem as the one I fixed with commit b38460bc463c
> >> ("kunit: Fix checksum tests on big endian CPUs")
> >>
> >> The new tests implemented through commit 6f4c45cbcb00 ("kunit: Add tests
> >> for csum_ipv6_magic and ip_fast_csum") create a lot of type issues as
> >> reported by sparse when built with C=2 (see below).
> >>
> >> Once those issues are fixed, it should work.
> >>
> >> Charlie, can you provide a fix ?
> >>
> >> Thanks,
> >> Christophe
> > 
> > The "lib: checksum: Fix issues with checksum tests" patch should fix all of these issues [1].
> > 
> > [1] https://lore.kernel.org/all/20240221-fix_sparse_errors_checksum_tests-v9-1-bff4d73ab9d1@rivosinc.com/T/#m189783a9b2a7d12e3c34c4a412e65408658db2c9
> 
> It doesn't fix the issues, I still get the following with your patch 1/2 
> applied:
> 
> [    6.893141] KTAP version 1
> [    6.896118] 1..1
> [    6.897764]     KTAP version 1
> [    6.900800]     # Subtest: checksum
> [    6.904518]     # module: checksum_kunit
> [    6.904601]     1..5
> [    7.139784]     ok 1 test_csum_fixed_random_inputs
> [    7.590056]     ok 2 test_csum_all_carry_inputs
> [    8.064415]     ok 3 test_csum_no_carry_inputs
> [    8.070065]     # test_ip_fast_csum: ASSERTION FAILED at 
> lib/checksum_kunit.c:589
> [    8.070065]     Expected ( u64)expected == ( u64)csum_result, but
> [    8.070065]         ( u64)expected == 55939 (0xda83)
> [    8.070065]         ( u64)csum_result == 33754 (0x83da)
> [    8.075836]     not ok 4 test_ip_fast_csum
> [    8.101039]     # test_csum_ipv6_magic: ASSERTION FAILED at 
> lib/checksum_kunit.c:617
> [    8.101039]     Expected ( u64)( __sum16)expected_csum_ipv6_magic[i] 
> == ( u64)csum_ipv6_magic(saddr, daddr, len, proto, ( __wsum)csum), but
> [    8.101039]         ( u64)( __sum16)expected_csum_ipv6_magic[i] == 
> 6356 (0x18d4)
> [    8.101039]         ( u64)csum_ipv6_magic(saddr, daddr, len, proto, ( 
> __wsum)csum) == 43586 (0xaa42)
> [    8.106446]     not ok 5 test_csum_ipv6_magic
> [    8.143829] # checksum: pass:3 fail:2 skip:0 total:5
> [    8.148334] # Totals: pass:3 fail:2 skip:0 total:5
> [    8.153173] not ok 1 checksum
> 
> All your patch does is to hide the sparse warnings. But forcing a cast 
> doesn't fix byte orders.
> 
> Please have a look at commit b38460bc463c ("kunit: Fix checksum tests on 
> big endian CPUs"), there are helpers to put checksums in the correct 
> byte order.
> 
> Christophe

Well that's what the second patch is for. Is it failing with the second
patch applied?

- Charlie


