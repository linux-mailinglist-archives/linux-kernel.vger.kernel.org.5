Return-Path: <linux-kernel+bounces-141440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7058A1E48
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC691C2473A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B73984DF8;
	Thu, 11 Apr 2024 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odcBHgiQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FD382494;
	Thu, 11 Apr 2024 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858579; cv=none; b=aM/HaKLPqyVMD1hxxuy85zPnK9mlb0/M9CQM6OQNZogdph9WOaT4Em9rDkOOxxvi1GKQesb7OxWdx5/UdFZFcxxg5BdM6yQZBWGLdUCaazf/Nv6svtNCJaMpfCN+bfIZGcGrdVmTMZ7wjXgZ2bze9El9Nubikf1wTSaGOm2JeYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858579; c=relaxed/simple;
	bh=oNfJHHQuAyI3Y7cKkJtv9m61hEuDs/q3erWlNt6Nz8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GmeZgn/ctpuS8YfO8nnQCFlRxQ2dXgRlxzSVW6J51BQE+yEA0v70s/BctQ0FUUakP5pOKHBzMP6ud/5/PzGYFvha7e4PAmdpAUB+QmbAIdyHgvC2lQ3id0zVvwU6DZToDYU5IAhVPauGdqEcxhyFXaoeoNY/ZXGTJ69zOXBTk4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odcBHgiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA512C072AA;
	Thu, 11 Apr 2024 18:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712858579;
	bh=oNfJHHQuAyI3Y7cKkJtv9m61hEuDs/q3erWlNt6Nz8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=odcBHgiQxwD5wqpO3ON4eK6kbCvwZYwVRLQ3+vq3FwiCLJz1BrUZH44j1kYmCHzlm
	 Hx2dE7zseHIKzsUyHcuvAfuF6JDNQwAuaNfuf6RlxzAwS7gTuqg0mRWbnY7Z6IKntt
	 cb/Ruw+vH9vJDSlk8kZqcq0UORwYgOZOYuhQhXzc+wDxY08qudQ++PdNVbfHkqLkb8
	 +WKsNIQipcplFZzfQRtfvTJb/WlATu2CsnHOJRFUyxKV0C4qJ+xYg9xlNoNkqp+KN6
	 a5LJgTE37pmwaYEbJEMAA6j8DG7eCa4IhMeSoLQw1wum9VL6uxEa31r2wJbLz1wK6j
	 AKACz6q4C2UKw==
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
Subject: Re: [PATCH 6.6 000/114] 6.6.27-rc1 review
Date: Thu, 11 Apr 2024 11:02:56 -0700
Message-Id: <20240411180256.93013-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240411095416.853744210@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Thu, 11 Apr 2024 11:55:27 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.6.27 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.27-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] 3126167a036c ("Linux 6.6.27-rc1")

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
ok 10 selftests: damon: reclaim.sh
ok 11 selftests: damon: lru_sort.sh
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

