Return-Path: <linux-kernel+bounces-51837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC32848FD7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7E52820AC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C19249E4;
	Sun,  4 Feb 2024 18:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emqSVTcY"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3F3249E8
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707070097; cv=none; b=RSUkOMDBDYBwSZJQ/GRH4pp8AHztOpZURK6UjTbUJbdFOYmwfcU1KX4JhGIrjiSkciZnQXt/WtbVC47RuDfoEtYbl/be5zT6q8x0FFp+iWQHKKghhwT3xhBO6kKAqCMPUHU8DIIoLBFG8pYaHxwtDUMEwofhVbOzxjKbFLCRgXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707070097; c=relaxed/simple;
	bh=LsC40AMF4FxgkVNPN1VbVyiRUgnKT2nk33fPhpC4e5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1fQIoemaYodbp/zWgAb8x74DFiM06pvAga3hKsBhqN/QUkZ8Ut+96w2BdxXd1KcwuRh4zO/MLaaEf7EazaIyoXQPynhAIsSV34dN+sDS0T6HD47FY4beFh7mMdJgJsiBolhqyroVIH/gEkIhb8HLKkS6Q6mJywMcKGLJy8k+a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emqSVTcY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d7431e702dso30352015ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 10:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707070095; x=1707674895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frULKy1z/RPKJ4KixO4JHsDRBiZlI6+kKVJ70iqS4Rw=;
        b=emqSVTcY8WMGa/QVB85J9i4f2BcmufGUW5CuyEUAwr1yIoyvI3VCvMJ9P6XgWB4PSZ
         c0N7UHU3Py8XUVkSeZLaUkLKe94nT/eHNxubS7chqdXpxUK+ojcretICnnLYTRa1PLr+
         /cZFQSstycjIx1fDIW/BL0u2c0Go1AoXp5z0i/u+/kMcs4kIU8qPlkRPY06AC/cjkHjs
         Z9GZTvZ/Zf2lrkpCmfgOVykfysisDfx2HC7ALeZFKmCzOxETyJTc/GqsCBOMstTxrDtF
         WzdJ3LKFcGNZYLFRyXAf8NBXSKhNHSVqqDmcQG2JwV+gGRhd716mGTe1dV+BJ+5jXMKf
         aqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707070095; x=1707674895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frULKy1z/RPKJ4KixO4JHsDRBiZlI6+kKVJ70iqS4Rw=;
        b=Rc6pKOhXUMl8OFUH3yFrvlK69h2gV/SsVwvdIjtOEY/wVvx+wT/ZuiFU/70vhj404j
         tkk1jX/GOIdO0BZePyy16XtEf43NniCft5hLBB2aywUuSS0VinARRm+HHlxplUT5II+e
         EJ+82tQ3/YdSiKUGVMi3OaSViQnBFJfKr810+4E1zLuXlOm3wqa8caR7U0YmmO6VAlJH
         sRqnINuwgKw/OTjqJ8AZhNKgKbjW6J6PrsHfXNhXaqA5952VZXCKn3LHhk/QQweCrzUl
         GCSjLwAw2pRKWx8JCkKdiomaHBXOS6myFiIb+kkuFH0O/GsVSRYRbkLMbQ5prp7ioVBO
         waIQ==
X-Gm-Message-State: AOJu0YydT45geyu9Rn+z8Ccrxy70TZB8T8zzvsVzfOTICH3rj4frCE83
	FFpAt3/byYAfZgUgQgdwn9/1HHFsy5QGUiY90+4blTrJ5FKKAewGkuHpuaOh
X-Google-Smtp-Source: AGHT+IHaDvEYmxWLIEZkibC9kk1tXDW3w5DPACn3ROMJG7oFek8ehmhwDSgHYG5FUP8CBbU8ypHD0w==
X-Received: by 2002:a17:902:b688:b0:1d7:78df:b1d4 with SMTP id c8-20020a170902b68800b001d778dfb1d4mr12284681pls.39.1707070094651;
        Sun, 04 Feb 2024 10:08:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id kh3-20020a170903064300b001d956e84582sm4878957plb.91.2024.02.04.10.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 10:08:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 4 Feb 2024 10:08:12 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.8-rc3
Message-ID: <82dc5ae4-690e-4f61-a6a2-41793ef651c4@roeck-us.net>
References: <CAHk-=wisik=He=zySDRHq7fe6k_cOXZeZiCkR41TmbzK2KNZtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wisik=He=zySDRHq7fe6k_cOXZeZiCkR41TmbzK2KNZtg@mail.gmail.com>

On Sun, Feb 04, 2024 at 12:39:17PM +0000, Linus Torvalds wrote:
> Hmm. A slightly larger rc3 that I'd have hoped for, although at this
> stage in the release process it's not something that really worries me
> yet.
> 
> Aside from the usual driver fixes (with sound, gpu and nvme standing
> out), we've got mainly filesystem fixes (tracefs and ext4) and a big
> chunk of tooling updates (perf and selftests).
> 
> The rest is mostly a random collection of fixes all over. Fairly quiet
> on the arch side, with mainly just some parisc fixes.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 549 pass: 548 fail: 1
Unit test results:
	pass: 127073 fail: 891
	(some of those are duplicates, still working on the script)

an385:mps2_defconfig:mps2-an385:initrd still crashes due to the problems
with the test_ip_fast_csum unit test. A fix is pending, but it does not
address the unit test failures reported below.

Notable warning backtraces:

- BUG: sleeping function called from invalid context at drivers/gpio/gpiolib.c:3749

  As mentioned last week, due to mmc code calling gpiod_get_value_cansleep()
  with interrupts disabled.

Unit test failures:

- test_ip_fast_csum and test_csum_ipv6_magic fail on big endian machines.

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

  Reported to maintainer.

- Handshake API tests fails with

  # req_destroy works: EXPECTATION FAILED at net/handshake/handshake-test.c:477
  Expected handshake_req_destroy_test == req, but
      handshake_req_destroy_test == 00000000
      req == c4aef640
  not ok 11 req_destroy works

  This is not a new problem, likely seen since the test was introduced.
  Reported to maintainer.

- regmap unit tests fail randomly in raw_noinc_write with errors such as

  # raw_noinc_write: ASSERTION FAILED at drivers/base/regmap/regmap-kunit.c:1243
  Expected val_test == val, but
      val_test == 65581 (0x1002d)
      val == 45 (0x2d)
      not ok 8 maple-big
  # raw_noinc_write: pass:7 fail:1 skip:0 total:8

  or

  # raw_noinc_write: ASSERTION FAILED at drivers/base/regmap/regmap-kunit.c:1243
  Expected val_test == val, but
      val_test == 65556 (0x10014)
      val == 20 (0x14)
      not ok 5 rbtree-little
      ok 6 rbtree-big
      ok 7 maple-little
      ok 8 maple-big
  # raw_noinc_write: pass:7 fail:1 skip:0 total:8

  This is a spurious problem, seen on both little and big endian machines.
  Newly discovered, not yet reported. Likely not a new problem.

- cpumask unit tests on parisc/parisc64 fail with

      KTAP version 1
      # Subtest: cpumask
      # module: cpumask_kunit
      1..6
      # test_cpumask_weight: EXPECTATION FAILED at lib/cpumask_kunit.c:68
      Expected nr_cpu_ids == cpumask_weight(((const struct cpumask *)&__cpu_possible_mask)), but
          nr_cpu_ids == 16 (0x10)
          cpumask_weight(((const struct cpumask *)&__cpu_possible_mask)) == 1 (0x1)
  cpu_possible_mask contains CPUs 0
      not ok 1 test_cpumask_weight
      # test_cpumask_first: EXPECTATION FAILED at lib/cpumask_kunit.c:79
      Expected nr_cpu_ids <= cpumask_first_zero(((const struct cpumask *)&__cpu_possible_mask)), but
          nr_cpu_ids == 16 (0x10)
          cpumask_first_zero(((const struct cpumask *)&__cpu_possible_mask)) == 1 (0x1)
  cpu_possible_mask contains CPUs 0
      not ok 2 test_cpumask_first
      # test_cpumask_last: EXPECTATION FAILED at lib/cpumask_kunit.c:87
      Expected nr_cpu_ids - 1 == cpumask_last(((const struct cpumask *)&__cpu_possible_mask)), but
          nr_cpu_ids - 1 == 15 (0xf)
          cpumask_last(((const struct cpumask *)&__cpu_possible_mask)) == 0 (0x0)
  cpu_possible_mask contains CPUs 0
      not ok 3 test_cpumask_last
      # test_cpumask_next: EXPECTATION FAILED at lib/cpumask_kunit.c:94
      Expected nr_cpu_ids <= cpumask_next_zero(-1, ((const struct cpumask *)&__cpu_possible_mask)), but
          nr_cpu_ids == 16 (0x10)
          cpumask_next_zero(-1, ((const struct cpumask *)&__cpu_possible_mask)) == 1 (0x1)
  cpu_possible_mask contains CPUs 0
      not ok 4 test_cpumask_next
      ok 5 test_cpumask_iterators
      ok 6 test_cpumask_iterators_builtin
  # cpumask: pass:2 fail:4 skip:0 total:6
  # Totals: pass:2 fail:4 skip:0 total:6
  not ok 5 cpumask

  Probably not a new problem. Just discovered, not yet reported.

