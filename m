Return-Path: <linux-kernel+bounces-126954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE438944E9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E6E1F21B96
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E905024E;
	Mon,  1 Apr 2024 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCe3Wg5f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4AA4B5CD;
	Mon,  1 Apr 2024 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711996184; cv=none; b=sFODu36QX8e4IkFAP2cfx3IgPPfxFoIk3NqxEYIbHKKMIMCQKqAMllPPmPpzqLj2zN+vDH49fNQT31gRDv3MBH+BPdyD1F0nkAUg7s4KYjktUUuPsHNEnVup9xZhUJv+yQYqknMUzPG7vwTfdVdb719op1IF3oNVoKYj8hPzUrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711996184; c=relaxed/simple;
	bh=dJyu+rE31S9XlRxTHt0dAC62aJeG94nr3456AZKenlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Praf1mKfMdSKfwnsgTyvyb6XZs+p6R9+45pJkR5nqk98eCt7JxGttkK+N7wcl/z8Y7r2GPnl+wMlHxIzKp667GwJQEqKxutn1rudJxT029xKFg9xnmRWbremAx0KpBfxyf6xC1tAuqDtWVJm+j8i/5DR7bt9DdXqy9d62/1MLm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCe3Wg5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C61AC433C7;
	Mon,  1 Apr 2024 18:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711996183;
	bh=dJyu+rE31S9XlRxTHt0dAC62aJeG94nr3456AZKenlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fCe3Wg5fXgtMHUsO8oEjfE4uGGAoYMR5b/+D0aCb0dwxF2sNUlb6hu+Z8hke+lwUL
	 jrr/Ftz+fSwmofMMbm8ykNXrCsMJbQdBOwYPHv0LN3ucVjparNRqMI6XpGKouTUWYV
	 VGjx1d62sdx8Qi8De30wQcFzZtuALf1fK8oMYz91iWowPDgG9ELgmOVGJodr7N2YQM
	 1WptT3YY6bdFiYTL0aDCssM+RO5tPTEkOWrs87Fk1DkSblcK49ddU4j3Xvho3AjVsG
	 xFttjZRCvo2VwJN8Ib7RKeNiEc3FuOLiEHgjbl12kp8HIlGCA1lBOpEbgBymtDDr7I
	 0ZZVfd03T8bWQ==
From: SeongJae Park <sj@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com,
	broonie@kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.8 000/399] 6.8.3-rc1 review
Date: Mon,  1 Apr 2024 11:29:40 -0700
Message-Id: <20240401182941.249008-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Mon,  1 Apr 2024 17:39:26 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.8.3 release.
> There are 399 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] bffeaccf18b5 ("Linux 6.8.3-rc1")

Thanks,
SJ

[...]

---

ok 2 selftests: damon: debugfs_schemes.sh
ok 3 selftests: damon: debugfs_target_ids.sh
ok 4 selftests: damon: debugfs_empty_targets.sh
ok 5 selftests: damon: debugfs_huge_count_read_write.sh
ok 6 selftests: damon: debugfs_duplicate_context_creation.sh
ok 7 selftests: damon: debugfs_rm_non_contexts.sh
ok 8 selftests: damon: sysfs.sh
ok 9 selftests: damon: sysfs_update_removed_scheme_dir.sh
ok 10 selftests: damon: sysfs_update_schemes_tried_regions_hang.py
ok 11 selftests: damon: sysfs_update_schemes_tried_regions_wss_estimation.py
ok 12 selftests: damon: reclaim.sh
ok 13 selftests: damon: lru_sort.sh
ok 1 selftests: damon-tests: kunit.sh
ok 2 selftests: damon-tests: huge_count_read_write.sh
ok 3 selftests: damon-tests: buffer_overflow.sh
ok 4 selftests: damon-tests: rm_contexts.sh
ok 5 selftests: damon-tests: record_null_deref.sh
ok 6 selftests: damon-tests: dbgfs_target_ids_read_before_terminate_race.sh
ok 7 selftests: damon-tests: dbgfs_target_ids_pid_leak.sh
ok 8 selftests: damon-tests: damo_tests.sh
ok 9 selftests: damon-tests: masim-record.sh
ok 10 selftests: damon-tests: build_i386.sh
ok 11 selftests: damon-tests: build_arm64.sh
ok 12 selftests: damon-tests: build_m68k.sh
ok 13 selftests: damon-tests: build_i386_idle_flag.sh
ok 14 selftests: damon-tests: build_i386_highpte.sh
ok 15 selftests: damon-tests: build_nomemcg.sh
 [33m
 [92mPASS [39m

