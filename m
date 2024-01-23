Return-Path: <linux-kernel+bounces-36015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A60839A30
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB23D1F2AB04
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6D385C59;
	Tue, 23 Jan 2024 20:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+XdfQsF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F560EE4;
	Tue, 23 Jan 2024 20:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706041247; cv=none; b=EMu1CxRZrB9Zdp59CuMCAPsewLIvoYXe6wt+As/9oghnSfrWCjMMbVt5PdLL4omx8H0s4wCbjKlj331rola0QT6fgXzm9SGuGUpEEgZNqBhubjgQsApoRbrHkPiZnhcJpW4Mp8VFudjBYqf7bTlA8MriTpuRELRQFpHaEcUmLZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706041247; c=relaxed/simple;
	bh=FinUUbHbCb8oxWgQ1QrIcDDUh69rx937rn4LhPwffMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rlmOtF4EZ6CC9qD37mqxZU72yZL/5CJkmwWB6PLNtKmozOpkliVmaSbHQL0ny9g68j3XVwKN9sWcT4EeZGU7dotSCjqP5px4By+10HRIqyB/M3zx+QXMASC6Yq2dKmW1kiP9ZrpeTAxGviGnyPmcqcdL9W/x506Ixijy89vPFis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+XdfQsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB50FC433F1;
	Tue, 23 Jan 2024 20:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706041246;
	bh=FinUUbHbCb8oxWgQ1QrIcDDUh69rx937rn4LhPwffMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a+XdfQsFht8tk9sSkP7uN9JwkPuF/Sk3dqDgOPtO+gGQEYT7gPfKKnH2I9TotPXcC
	 VhqE4fQYeUcz40ToUb0tdOx3Rj6tH/mwMFZWE3J7zuxpmMNY2IKJlUtTMhLDXEHJ0/
	 9wCZHafqGfcCYQVB+xs0EnqQtDtvGgchL96Px4T0ZL6T1bQpTOoXTKoX5IvPBq4Ydz
	 zVQ3hs4L0vp2U/bB+uAW5oYr3emKt37L6DKRq10LF9eIw4kn95vwkkj8xl56MRQQV5
	 bK4B7NxmuiNcBF6y2qA/UtkzvtcSk0aj2fRZo6kUgTqJ10V9ipD/j0iZVm471dY66M
	 u7YIat68wBzjg==
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
Subject: Re: [PATCH 5.15 000/371] 5.15.148-rc2 review
Date: Tue, 23 Jan 2024 12:20:43 -0800
Message-Id: <20240123202043.93494-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123174500.819179356@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Tue, 23 Jan 2024 09:46:45 -0800 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 5.15.148 release.
> There are 371 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jan 2024 17:44:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.148-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] 6de5fbff4f2e ("Linux 5.15.148-rc2")

Thanks,
SJ

[...]

---

ok 1 selftests: damon: debugfs_attrs.sh
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

