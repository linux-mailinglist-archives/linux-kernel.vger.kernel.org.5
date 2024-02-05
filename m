Return-Path: <linux-kernel+bounces-52094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BB1849405
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 048CCB23074
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F384AC2D0;
	Mon,  5 Feb 2024 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lue6JSbc"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4A7C133;
	Mon,  5 Feb 2024 06:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707116031; cv=none; b=Ax5gXQkl5CpHL1i8b50TmxAJn5hyioxlDaRSDenZZzKEpTizxqIYdsTrPBLv8FZ6+6bb1UrHrk2opM1MLeM3JMk3QppCIlyvzBPAjuKb+JouId2DitJaPnZlkZbaSSUpLuc9JEstkWg7HwOgZeeLTu7HWqeI7nIAo5TaS3foWLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707116031; c=relaxed/simple;
	bh=YNsbjnax4FueQl8gllzJCWfzlO09WtiA6BKPHSKaop4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G9zfvgGwRQfOKvBWdfAZmy44bmg1i4jHsXKgmCOjqu/dunM4nnh2Dj9QyIJSy0L+JEQVNU59nAnyqq2nJf3vAHt3HKSsA016Dq5noUVx5/cPe346uihbQfLlkjnObgvkr/Mdg0OeOg3trqEl6fQYXOHv+MbstU5ZULCJhTX5XvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lue6JSbc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d99c5f6bfeso6215375ad.1;
        Sun, 04 Feb 2024 22:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707116029; x=1707720829; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BACST+Lz4LKGuPFXlT0sbTF1G34jn/nGIZ2rEUeJFTI=;
        b=Lue6JSbcdYOqzmeGyHglC6sN4Po7PorZTqv+rbBPrpL1LWDQCHXE58a520bDYtonWw
         slr5M6+QGkSNpQXZZjGXH/ZCDkt8lDaFbwvORP77edAWFnFCM9OBYvpn2KVzW8At9Hgu
         kCVnZ0vY//FMNx78iecCbLzCaCZqvR3/3rIYg56bhp2WMVQOCYy+PJ5FU/7eQ3zD4OP6
         7a3xokSPSZzBQv3CRl5Jictx5dfZL3iy1mnurYbFvTg5XknskjVFnj6r6mEk6Pjr5vQL
         XpaAD3jr3fy5Ng1rnLFuoAUSP65Pv2rKXj4aiP5i8392lZPX3OXAGHtuJ8oO+IFn4rlG
         kcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707116029; x=1707720829;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BACST+Lz4LKGuPFXlT0sbTF1G34jn/nGIZ2rEUeJFTI=;
        b=BjsymPzlAsGdXFFUo6UyoqIced3Ko8eO31OOGGnJ2kn7/RHUhPn43cVKl3beCKmPaL
         AljX6MdgseAEWMTdexteCrAVhk5U8Uhyx36T0ZignhPiTnlmCemeuyEd1CADkFonDL0m
         yuN1HqKj+BBAWZ3wnkabo5eC1lbSO0nVfvNPKPo/LVw8UgHZE5j1MtK+RqsA3KB4ROKJ
         Jy3foGajFKmqmRmNDyTw/wf9WTjvpD4K2GHmY92dHvEKI+8ftKIUcIJDGo5CDHANjvjV
         PgIHslODE+TT9rp8pj9gmhDfHPYDB16fH30kBBTDmiGbUvrZpeEp+7qDjgttR0uZV44j
         GS0A==
X-Gm-Message-State: AOJu0YznW6Jbq8KXjsG3Y+CMjJCeA03wDsrEF4FDhXeGVBqZT+AqNK+3
	WrfYz6VexvKrXUQeRWsqZZOcmFd/H2hJrItbxMPacuJp61s1zBk6
X-Google-Smtp-Source: AGHT+IHLPMVZtRNSPHafHo488128iwWewz6YFua+FZyYSUl1po29h4xK/zg8Whwu6C12KawKEHCxow==
X-Received: by 2002:a17:902:da89:b0:1d9:4106:b8b5 with SMTP id j9-20020a170902da8900b001d94106b8b5mr8430625plx.11.1707116028962;
        Sun, 04 Feb 2024 22:53:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVST6ii9ztpUxpcyZ6MV17/78+ojq/iBd9niGDcjP8fl76DQgUu8HZ5LKFY2xZj/9AiGbQinx4sre870CXz3ndEJCX/bMFPs/twS1oMvsSZwDqiH8BXLMnXjncBfXCIldgZAdsp6EdKa3vMOoWMgRPsraaYvY0jYvMn/CxlNkqklP8o22cRBKlk+/g/i1/5utXc2DOEJ9YgynfYDLlKUPtgLsjhVVK5RhVRDjh4FUj6dF7Hwnwm5w==
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id kh3-20020a170903064300b001d8cbdb2a9asm5592057plb.298.2024.02.04.22.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 22:53:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 4 Feb 2024 22:53:46 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Yury Norov <yury.norov@gmail.com>
Cc: James.Bottomley@hansenpartnership.com, Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: Kunit test failures with cpumask tests on parisc
Message-ID: <e6f0ab85-5bbe-41c1-8976-5ba00044998c@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

when running cpumask Kunit tests on parisc/parisc64 in qemu,
I get the following errors.

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

It appears that parisc sets __cpu_possible_mask to the number of online CPUs,
which is limited in qemu and doesn't match CONFIG_NR_CPUS. Is this a problem
with the unit test or with the parisc architecture, or does the unit test
simply not apply for parisc ?

Thanks,
Guenter

