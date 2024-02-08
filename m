Return-Path: <linux-kernel+bounces-57459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 955F584D954
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB75286551
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3829C2D629;
	Thu,  8 Feb 2024 04:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4Pc700o"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0402C6B0
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 04:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707365748; cv=none; b=ILxyrpvYFeGvIhqoo4FqKYTH7XpsrP8kIyrhCQW2fkk1MWyeonqceneBgniMv23g5DeCpbC1jeOLPeHPwioWG5t6AobvFUMCNbvMun1NlDGpXMsgBApa4pTRlkmaa7uQphgS0yaSMn8yKsEtYjdIBW6NG/Pp+RVZt2Nb5NUq6qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707365748; c=relaxed/simple;
	bh=fXJ1U4znUAesFmq+SCaeRK3D4NwCokYqr0BJo/UwXqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcflLzjSTFLB7MmUf6yyXQSSPoqYOFCjLQ1rr077+KPQvWS5vaPbHZWuBMdDPU7GZz7N7UffeyFpHKQSv3d2y3k1kUzOHznF3Ex4BzEApa5HC3nFXlR0K27nr/J+D8Er7w1C7u7Yu0edXY9h32/YKYt+Bz50ezPtXRtEB8F37nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4Pc700o; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d71cb97937so14198545ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 20:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707365746; x=1707970546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntEdgcmlHw0HjM3ZhwHaoBbzKmjR4GIJzvlcv9x+2HY=;
        b=N4Pc700oKBcvaHg0IKnP3r3UCvQLEys4Q5dfY7B3C20O8zP/QjUuduQb2My+arBltH
         aKwLX+C3MjHifQ7PnEmhsNqP7MEMsZC3L/VJpHqhnLatPBwCN0n/foFkkVIoWGdvAfB7
         NHo4dzJC7wzKxXUl7jsV5qnF8F57M+6sR3a3jaDnrUKgg3MlKGZF7iW1ZRQig4DXNMpu
         Jg+BdvAqAFNTKWt0wu+NXi7yPvLYqp3r+aKH9wPRp/SARlOq5If6blyz5HOl15qSi+Dn
         WO3oZncLHdNq043HFePEvr/ysoUn9sugTdXaV8Cm12mS82ig6urXHGlS/k2OSBuYy+yV
         6BXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707365746; x=1707970546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntEdgcmlHw0HjM3ZhwHaoBbzKmjR4GIJzvlcv9x+2HY=;
        b=UzN0cxh86xqtGkaxjLb5tL8rpOv0HwCEGUF1mtBaCoiY+mZDDSSiTg21WGyLb5Fk/X
         1gYNC031BpTBWGIOs4B1NsfUupmkchdEJP+T2l8ymb9qT8aSb6sZFWstTkMEpN5sgTM1
         iINswcIihx8X2h4NjZZSJQwFs8J5yV3el7sB86vgdG2wOM7a4fXKhB5dZUjyuD+8+NC5
         stxaIXwDyYZSG/naXsX4bJ0uGz30uKU2a97Vbmu+HdE3mE4Sdcw9h1qJDAqrCi1khwTW
         TEJ8V9wNU2KV5T1OjFpwBwQQXpt8Ib+pSgxJDJNec96ijw51aqdm+8enAV9yM8iU9AWD
         17rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcSV4cc1uoUtsSVp5oOsbKfb/4uXAsg9kxE0EtN4Xtcyx6EHlFR3BeKVz48rjUkQ+9+vBZjDkM50BOWs+CtO2gqkFvgqAq4JKOyyh0
X-Gm-Message-State: AOJu0Yww2diKWcODFRT9EfjVL6xGxex5GNwzJSB3ucaVDYJE0xdHrzfv
	gPihbfk0Tg/iBAD7PuHr4rydECFNNT1licbN6ScErit35MZ9c3WiTObOjU2l
X-Google-Smtp-Source: AGHT+IHsvO+olhXAjGTIUu7MdW4r8uMQIcm05AXARx6zPFFufK9OK+HKwvLEMl4zSXaTF3CMwmcLMQ==
X-Received: by 2002:a17:902:e802:b0:1d9:24cb:3cdd with SMTP id u2-20020a170902e80200b001d924cb3cddmr8618147plg.46.1707365745807;
        Wed, 07 Feb 2024 20:15:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUA+ofJTOxb91SNGlg6guIYUOFvYsDS9GGn2EnjZRXiCqeGx3nVCMMW1C93OtJ+ZQuzxbAOQKpmH2fo5JJd0o8OKKg73SAlZbIwtXnxiiYTo3s9t1ZGqmQXFSryHQENNPu63y6ZcFvQBQWiuWY84z0gLSJL23bZve1sTLooFhKKifRboNQAojMPfzU=
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id la14-20020a170902fa0e00b001d083fed5f3sm2304977plb.60.2024.02.07.20.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 20:15:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 7 Feb 2024 20:15:43 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 0/2] lib: checksum: Fix issues with checksum tests
Message-ID: <9b004c45-45f8-4abb-a24e-bb47b369b1a5@roeck-us.net>
References: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>

On Wed, Feb 07, 2024 at 04:22:49PM -0800, Charlie Jenkins wrote:
> The ip_fast_csum and csum_ipv6_magic tests did not have the data
> types properly casted, and improperly misaligned data.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

I still get:

Failed unit tests:
	mips:malta:checksum
	mips64:malta:checksum
	mipsel:malta:checksum
	mipsel64:malta:checksum
	parisc:B160L:checksum
	parisc:C3700:checksum
	parisc64:C3700:checksum
	sh:rts7751r2dplus_defconfig:checksum

on parisc/parisc64:

    # test_ip_fast_csum: ASSERTION FAILED at lib/checksum_kunit.c:463
    Expected ( u64)csum_result == ( u64)expected, but
        ( u64)csum_result == 33754 (0x83da)
        ( u64)expected == 10946 (0x2ac2)
    not ok 4 test_ip_fast_csum
    ok 5 test_csum_ipv6_magic
# checksum: pass:4 fail:1 skip:0 total:5
# Totals: pass:4 fail:1 skip:0 total:5

mipsel/mipsel64 (little endian):

    # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:506
    Expected ( u64)csum_result == ( u64)expected, but
        ( u64)csum_result == 18588 (0x489c)
        ( u64)expected == 12357 (0x3045)
    not ok 5 test_csum_ipv6_magic
# checksum: pass:4 fail:1 skip:0 total:5
# Totals: pass:4 fail:1 skip:0 total:5

mips (big endian):

    # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:506
    Expected ( u64)csum_result == ( u64)expected, but
        ( u64)csum_result == 59728 (0xe950)
        ( u64)expected == 12357 (0x3045)
    not ok 5 test_csum_ipv6_magic
# checksum: pass:4 fail:1 skip:0 total:5
# Totals: pass:4 fail:1 skip:0 total:5

I noticed that csum_result varies across tests for some reason. On parisc/parisc64
the value is unexpected but always the same.

sh (little endian; ok, this isn't entirely fair, this test wasn't enabled before):

    KTAP version 1
    # Subtest: checksum
    # module: checksum_kunit
    1..5
    # test_csum_fixed_random_inputs: ASSERTION FAILED at lib/checksum_kunit.c:370
    Expected ( u64)result == ( u64)expec, but
        ( u64)result == 53378 (0xd082)
        ( u64)expec == 33488 (0x82d0)
    not ok 1 test_csum_fixed_random_inputs
    # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:395
    Expected ( u64)result == ( u64)expec, but
        ( u64)result == 65281 (0xff01)
        ( u64)expec == 65280 (0xff00)
    not ok 2 test_csum_all_carry_inputs
    # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:443
    Expected ( u64)result == ( u64)expec, but
        ( u64)result == 65535 (0xffff)
        ( u64)expec == 65534 (0xfffe)
    not ok 3 test_csum_no_carry_inputs
    ok 4 test_ip_fast_csum
    ok 5 test_csum_ipv6_magic
# checksum: pass:2 fail:3 skip:0 total:5
# Totals: pass:2 fail:3 skip:0 total:5

The result/expected values are always the same in the sh4 tests.
I'd take the test results for sh4 with a grain of salt; there is
at least some possibility that this is an emulation problem.

Guenter

