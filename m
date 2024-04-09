Return-Path: <linux-kernel+bounces-136611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CCF89D627
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831031C2342F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E93D80620;
	Tue,  9 Apr 2024 10:00:09 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09397E774;
	Tue,  9 Apr 2024 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712656808; cv=none; b=Tj7Dgtlq/UGiRW9xRKmnsa3vMLk/z8jK5UwkoedVGaW5PrtM6+uOByhVa9zmkj9ibVCJG1+tPHRj6iryH2v5L1gyPmI/Db+cdM8/dPe+9WMyA9QsowuAUAS0zogXCmLU18mLcZK/phnccLy4xZnpaz/SEZEGBZYC1ZfV24enRNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712656808; c=relaxed/simple;
	bh=PWHWpU3HfxEIvM1NEYrjRyi00N8E+szL532KiAT9qu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbEXQFeFLPH78y+5ge6xzMdWZoYYcCFzww0Oex5ov5ukYmBVp4htF6W5/X10HVjyqtMVUdW/p55K18YhUAcR8QY9kUKieSjAO/gO24MGmfs8V7CimKiP4VCVUMXXTwvCQursXq0yZedN6UJMkL7Il4Q40bi90gwsQO0zIjOuaoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-01-661511a3ac4d
From: Honggyu Kim <honggyu.kim@sk.com>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH v3 0/7] DAMON based tiered memory management for CXL
Date: Tue,  9 Apr 2024 18:59:38 +0900
Message-ID: <20240409095958.3067-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240408134108.2970-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsXC9ZZnoe5iQdE0g6UT9Swm9hhYzFm/hs1i
	140Qi/sPXrNb/N97jNHiyf/frBYnbjayWTQ0PWKx6Py+lMXi8q45bBb31vxntTiy/iyLxeaz
	Z5gtFi9Xs9jX8YDJ4vDXN0wWky8tYLN4MeUMo8XJWZNZLGYfvcfuIOKx9PQbNo8NTUBi56y7
	7B4t+26xeyzYVOrRcuQtq8fiPS+ZPDat6mTz2PRpErvHiRm/WTx2PrT0eLF5JqPHxo//2T16
	m9+xeXzeJBfAH8Vlk5Kak1mWWqRvl8CVcejOTJaCe3wVS19eYWtgXM7dxcjJISFgIrHm4SV2
	GLv3VR8jiM0moCZx5eUkJhBbREBFYu3BKWxdjFwczALXWSRWT7gBlhAW8JGYMqcDqJmDg0VA
	VeLoNjmQMK+AmcSkJYuYIGZqSjze/hNsPqeAucT265vB5gsJ8Ei82rCfEaJeUOLkzCcsIDaz
	gLxE89bZzCC7JASusUv0zZnOBjFIUuLgihssExj5ZyHpmYWkZwEj0ypGocy8stzEzBwTvYzK
	vMwKveT83E2MwFhcVvsnegfjpwvBhxgFOBiVeHgtrgqnCbEmlhVX5h5ilOBgVhLhDTYVTBPi
	TUmsrEotyo8vKs1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUgtQgmy8TBKdXA6M/sueVy0H/5
	+y9maaefid82gePI9o0ceV9k/86e3bBiYahKuPJTg+OBHu1CE3bMzGBIdVne4b9P5u2THz5X
	I6VuN7MHFC0p+Mn/Qjxqf0vNFtafPK9v8PC9mfi/d13TxrjoaZHT76rqzzvhw/6ny3BST19C
	wnL5N36mzsFLXyV0/CsT2PWQW4mlOCPRUIu5qDgRAPb8mdPBAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsXCNUNLT3exoGiawYtDMhYTewws5qxfw2ax
	60aIxf0Hr9kt/u89xmjx5P9vVosTNxvZLBqaHrFYfH72mtmi88l3RovDc0+yWnR+X8picXnX
	HDaLe2v+s1ocWX+WxWLz2TPMFouXq1kcuvac1WJfxwMmi8Nf3zBZTL60gM3ixZQzjBYnZ01m
	sZh99B67g4TH0tNv2Dw2NAGJnbPusnu07LvF7rFgU6lHy5G3rB6L97xk8ti0qpPNY9OnSewe
	J2b8ZvHY+dDS48XmmYweGz/+Z/fobX7H5vHttofH4hcfmAIEo7hsUlJzMstSi/TtErgyDt2Z
	yVJwj69i6csrbA2My7m7GDk5JARMJHpf9TGC2GwCahJXXk5iArFFBFQk1h6cwtbFyMXBLHCd
	RWL1hBtgCWEBH4kpczrYuxg5OFgEVCWObpMDCfMKmElMWrKICWKmpsTj7T/ZQWxOAXOJ7dc3
	g80XEuCReLVhPyNEvaDEyZlPWEBsZgF5ieats5knMPLMQpKahSS1gJFpFaNIZl5ZbmJmjqle
	cXZGZV5mhV5yfu4mRmDcLav9M3EH45fL7ocYBTgYlXh4He4IpwmxJpYVV+YeYpTgYFYS4Q02
	FUwT4k1JrKxKLcqPLyrNSS0+xCjNwaIkzusVnpogJJCeWJKanZpakFoEk2Xi4JRqYIxWmBC2
	MSDafAX3Y9vnLOHHf5boPnvueKjxppyrz4kzro8NGue6cdZvvmG8uNpw5x7uWWsuc+41Un8f
	+ds67/GkDLWwB93z/tbMEb++0PJHv1vOLmO7a77Lr6cx3r5zjTsv8FLpnuqdja8Xt8gssWj4
	N7vrn9o0y3jhd5uLf3DYdPAICG+NclViKc5INNRiLipOBAAVrgmltwIAAA==
X-CFilter-Loop: Reflected

On Mon,  8 Apr 2024 22:41:04 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
[...]
> To explain this, I better share more test results.  In the section of
> "Evaluation Workload", the test sequence can be summarized as follows.
> 
>   *. "Turn on DAMON."
>   1. Allocate cold memory(mmap+memset) at DRAM node, then make the
>      process sleep.
>   2. Launch redis-server and load prebaked snapshot image, dump.rdb.
>      (85GB consumed: 52GB for anon and 33GB for file cache)
>   3. Run YCSB to make zipfian distribution of memory accesses to
>      redis-server, then measure execution time.
>   4. Repeat 4 over 50 times to measure the average execution time for
>      each run.

Sorry, "Repeat 4 over 50 times" is incorrect.  This should be "Repeat 3
over 50 times".

>   5. Increase the cold memory size then repeat goes to 2.
> 
> I didn't want to make the evaluation too long in the cover letter, but
> I have also evaluated another senario, which lazyly enabled DAMON just
> before YCSB run at step 4.  I will call this test as "DAMON lazy".  This
> is missing part from the cover letter.
> 
>   1. Allocate cold memory(mmap+memset) at DRAM node, then make the
>      process sleep.
>   2. Launch redis-server and load prebaked snapshot image, dump.rdb.
>      (85GB consumed: 52GB for anon and 33GB for file cache)
>   *. "Turn on DAMON."
>   4. Run YCSB to make zipfian distribution of memory accesses to
>      redis-server, then measure execution time.
>   5. Repeat 4 over 50 times to measure the average execution time for
>      each run.
>   6. Increase the cold memory size then repeat goes to 2.
> 
> In the "DAMON lazy" senario, DAMON started monitoring late so the
> initial redis-server placement is same as "default", but started to
> demote cold data and promote redis data just before YCSB run.
[...]

Thanks,
Honggyu

