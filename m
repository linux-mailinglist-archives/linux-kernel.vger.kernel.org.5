Return-Path: <linux-kernel+bounces-156035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C45C8AFCF8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDE21C22956
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DB8524A5;
	Tue, 23 Apr 2024 23:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfiMBpSh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE138DC0;
	Tue, 23 Apr 2024 23:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713916699; cv=none; b=lhwCXVstUW9QUiGKvu2KquZG2p53+1wD/hLXr4qVaC+pwb7StLD2u1lYhWuDqUade9YWsl1ntVQcvDtRK7Og5HxEna6qfaUzlqL7oRPyOFdkkmrJRUULY7boBT7rWoxA+A+Qu+zZRXVETSUOslaF5P/ZmKhRbkYEBOixrFQ6mzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713916699; c=relaxed/simple;
	bh=0VsxHeuItHVZwvyMzPuXTVw/feEB6Ahxq8LQQRsIzJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mh3pVrpkpRYIZVKDGQM8L98n8QBc37M9frHnvbLg4s3U+MgXAnYQ2nmCVmTsrMeYDzY9F4CN1z35ClhqlS9cORRjsx9AZ521zi67o5oYlo4cqgr8me7O45C3E/f852j0bz+oMqNKrNpMHtbfFQlfZ0Paw7f+c+RV05/FE4wZD0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfiMBpSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735C7C116B1;
	Tue, 23 Apr 2024 23:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713916699;
	bh=0VsxHeuItHVZwvyMzPuXTVw/feEB6Ahxq8LQQRsIzJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TfiMBpShLbj6EDbMaJ98jABOgIGD0CVYyCFvUaA2yTTAFa8i1gO09JQ+TvYlHg8AL
	 2MLp7FwzHtkbjNM6qNR0TjLkrTsN3aagWOQdRVQlRJjuBS46y2e67qwlYdofG5tkx4
	 ZlLlteX6IdnQY8tcf9ZOoyHxLOp5X5jxZLkH+JanJJbvNQ7NHR492mLEnovxfyWyFU
	 CalHilkeq8XPAcJAANx6N4yKippElXcSEFlsc8cRLfUl3vGImxmA1n9xrIfUmDTyZJ
	 ZYi3p3HTG1do0kmR6bqNglekXwomnvGPeGaM9pTYHA27T3Sx3qMwRwTD69wpEHWUh8
	 LbKHj6PaNpOLw==
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
Subject: Re: [PATCH 6.8 000/158] 6.8.8-rc1 review
Date: Tue, 23 Apr 2024 16:58:15 -0700
Message-Id: <20240423235815.1118-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Tue, 23 Apr 2024 14:37:02 -0700 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.8.8 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] 9919cd9ab988 ("Linux 6.8.8-rc1")

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

