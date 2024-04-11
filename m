Return-Path: <linux-kernel+bounces-141467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA9B8A1E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB7D1C23B1A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6E529422;
	Thu, 11 Apr 2024 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRFedOO0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35291205E04;
	Thu, 11 Apr 2024 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859476; cv=none; b=WazWpMUel+b1dpisjHzoLKa/kqitq6CR+B71S+MER/zlOLxCiZKklsZzsKV5qXzlVtNln5URz/3TLyb1UHbpi2ChtHe5P8YXm2U8TR+QRXxpqWwwMSZJdSae49wlGOFYl6HN31BYZXESIAM2EL9QY/8tiOMaiODC84OpkYPBeDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859476; c=relaxed/simple;
	bh=A+pJ1luEAcYgs14sF6QlPY8p0w7CGPTnOOI0gKFXsBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r/sjcEXmAu23Ai9+ZQsA7uFtUdJeOkwSjre137B8LRvHa8cosbsO+eO8rKUFPT0QA64MFrElscA4+rY/udg70Vz16CIu7mFzB+lPHwlruMfmpTnsjZcGpz9a4mG3T5rsC2NtWeg1pPCcdDay6QiB+X+XgoJ5CZlHWbbkR5qucpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRFedOO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87433C072AA;
	Thu, 11 Apr 2024 18:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712859476;
	bh=A+pJ1luEAcYgs14sF6QlPY8p0w7CGPTnOOI0gKFXsBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DRFedOO0PKfcNsu5EC2d6n4K/lIHqQLW6BkoskVVwS1fr6G8i7BU/Jt9+7VeYSiyc
	 AuYJZZPw844PBGvygaQrTJstAwWMdnyWVXseaOfAFyoYZfzyQaYFFgGbKTi3Y2pKxO
	 Zv26h+Am8cbHKXZl/vwFoM/d7ly/Fe07EaWo/lmDGxUxJxN5rU4/ATkfyNrmZZbitm
	 JRax3fAJM/vUb1adY/Kf3BF3OmFfOFMGuhJgSJx5SvFFICAAn0b4zr0XURVMfyl8Yk
	 0lE5szbC991rNSgH8K6ZkwBNMAYYorPG893qcPdaGMOKO8h7dm8aBHhtlmAn+6gUoW
	 oDJyM2ymBuqNQ==
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
Subject: Re: [PATCH 6.8 000/143] 6.8.6-rc1 review
Date: Thu, 11 Apr 2024 11:17:52 -0700
Message-Id: <20240411181752.91571-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240411095420.903937140@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Thu, 11 Apr 2024 11:54:28 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.8.6 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] 1e41d76814ed ("Linux 6.8.6-rc1")

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

PASS

