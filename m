Return-Path: <linux-kernel+bounces-91380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2E2871061
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC301C21120
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB0D7C082;
	Mon,  4 Mar 2024 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPFmCG6l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDBC3C28;
	Mon,  4 Mar 2024 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592640; cv=none; b=XRc5APut4SwH9aB+ztzhcRuMlGYp1WeCtFwnDfL1HiyJT80Zi3bB9+qlyp5bevZO1GxCPNFwofoQhAWuQDK4jJp0iSs35hXrtlVCutEAmq7JgcKR9Qj9auLOlcYclIqQe1Lp7GBFjmqeVdx6haE4NvF+fRSlB44/+t+L+EZq5dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592640; c=relaxed/simple;
	bh=361ibQBqWrjfYKegewR6WEI8l8rP3fYphcoApA6COJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PwMYKm94eNCDsHW6aYAe/+vJ357NyFwF9yjio/ZpopsYfHz8St5gRGxc6v3AnTIXg9eqwzubkD2uXsRwk08rkVB3wZ7XORBhXa9SPkVloCrxP1L34o+0H3ffZFteVUFISoK/QmqQfI2LhO9hl10c/6K9F9cqHwCx3ixGhPv1r6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPFmCG6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9604C433F1;
	Mon,  4 Mar 2024 22:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709592640;
	bh=361ibQBqWrjfYKegewR6WEI8l8rP3fYphcoApA6COJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPFmCG6le8nUWhiDtEeJGShxLKdZ8aOjtyQ7AOWSClt5ZwS6r1JcSV++UgLE91zdO
	 +SvVnkZtNHrqMR4ry7+823xYO0hII7DEc11q5uuX26lLBId2Xx3N2VQOENvA66zY09
	 v4fueGzK1NVaf8U4TvWHY5gdFTN+gJ94Y3eKXZ24xZKHlE0IL0EnYzyF24sDYksBXu
	 0TVL7QbeHHWrqnzPY+4oN90RwhQNW3+OWFZcCSC9XfpZE0TgruJ40RZBx7KjmBS5Kj
	 chKJwrfHgPxqioMm0b2gZCXEBI18bkbYPpiIo0vNAhETIoplzhSDX40oUpqaKikayZ
	 9QsuO6d8xAe8A==
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
Subject: Re: [PATCH 5.15 00/84] 5.15.151-rc1 review
Date: Mon,  4 Mar 2024 14:50:37 -0800
Message-Id: <20240304225037.73441-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304211542.332206551@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Mon,  4 Mar 2024 21:23:33 +0000 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 5.15.151 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.151-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] e7cbbec10c6e ("Linux 5.15.151-rc1")

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

