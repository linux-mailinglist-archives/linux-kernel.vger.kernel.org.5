Return-Path: <linux-kernel+bounces-34609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 957C983840F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AFAFB2C248
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6EF5251;
	Tue, 23 Jan 2024 01:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8BHWW1i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C8E2B9C7;
	Tue, 23 Jan 2024 01:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974588; cv=none; b=qR63kwCws2weaGeevgNwDvqFeKtXt8Eswe/tffWiRkTwJj+vmbdM/skn2TLUEdAJe/zHO9FXQTDS1cmAfOI93Rj54Z0oCl15brLWsh7TjovO8PnBAr5Bx6LhZGf1dGBC7W20YmRcwQP/H2Lrs6mSL6Lcs3Fc9rJl7zVIFy2Ytds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974588; c=relaxed/simple;
	bh=sLWuNVpVOcAxllqOLHduNAyE/ya0tJXpWnsLROvwI34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FL34vhczvyJWGfI5LTSbduh7BKIfNYrbzXOUGDAnEmDqmyIgxEuc7ZpN1VtMOTdJMjIzy1YCKv26Mi/wA1XYrz4Rd5+u6HGkh2BXyP4169CuYZ1jbQ3sEB089AC4VPyYIaUXDdPzlzzHnOS1tSexrrRsxb89eAWOHwfqPVgEvjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8BHWW1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F27BC433C7;
	Tue, 23 Jan 2024 01:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705974587;
	bh=sLWuNVpVOcAxllqOLHduNAyE/ya0tJXpWnsLROvwI34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K8BHWW1iHfKDI4qTMxwXHEfZI/UTi2M9NhQAG2wywXMHhHcCwyLpEdbG9TItCGoRR
	 T4Jo8DAPCYytEZRApLN/egoBOkyqWsoH67E0CXWxICbL2f8ARKvcCdDgUv/CQyOei+
	 FCoWMdBHecKvDzGXIYjNQv2rkrzzJ1XMrOfXxfkH4tvxYjGCu4zvtmjhCQtfba6UYQ
	 lysYYZpO3Qrcgq4Z86bL8RAOtJ3zN9F3ukbW5Bi2sjVKHoYV1YFbNZE5LFzmuix0u3
	 up2+Ded96aw7VsxeEX6ZzSosmbLpSqg3OsDqa5a8/xARzLWluKBXCN4keCuPcScW2C
	 VUGmGA9AlLAVw==
From: SeongJae Park <sj@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
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
	damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 6.1 000/417] 6.1.75-rc1 review
Date: Mon, 22 Jan 2024 17:49:44 -0800
Message-Id: <20240123014944.85840-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Mon, 22 Jan 2024 15:52:48 -0800 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.1.75 release.
> There are 417 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.75-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] b74a57f4a549 ("Linux 6.1.75-rc1")

Thanks,
SJ

[...]

---

ok 1 selftests: damon: debugfs_attrs.sh
ok 2 selftests: damon: debugfs_schemes.sh
ok 3 selftests: damon: debugfs_target_ids.sh
ok 4 selftests: damon: debugfs_empty_targets.sh
ok 5 selftests: damon: debugfs_huge_count_read_write.sh
ok 6 selftests: damon: debugfs_duplicate_context_creation.sh
ok 7 selftests: damon: sysfs.sh
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

