Return-Path: <linux-kernel+bounces-117665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B2788AE31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0653276F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F4A5810D;
	Mon, 25 Mar 2024 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AntTmyDY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631DE10962;
	Mon, 25 Mar 2024 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389550; cv=none; b=PcdSUnoLWqDat5OUBLgpJLkjuo9Sk08UBl97e+SFw+4je3X3ge9G2cKRSWBKp8CXEd8V1Q9tOLSkkkFCvbnh+b+BLzh5DE2iRnzf7xqQcfjXVO1/NAIls/OdU2nEkyGS7ygRQYhMcykzi8qgq9P/W6SvgjlJr6SX6t9J0NR8uDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389550; c=relaxed/simple;
	bh=tpPbnqCYOEH7aNwcqwxFZjbOV42U8qkcoVvs1iaGbJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ns8vnzdT6h7US9OC4JdZir9pAuEMwdyiJr3TVND07K5mNe6AgtnzWiMvuVKsido26A+7wWulMOZ0TQg+j+gZmB97iqAOcvmjDEGAZoOhyilsWhvU8ME4CFkCjyYBOHEMvNbOcQnc43j5PlySHgzTUpC+MwDEM/04uzWYLK8bpyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AntTmyDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDFEC433C7;
	Mon, 25 Mar 2024 17:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711389549;
	bh=tpPbnqCYOEH7aNwcqwxFZjbOV42U8qkcoVvs1iaGbJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AntTmyDYQ6fBUZPUZ8SbmFzmBhP5JFfzbJXCPuUZ0ZfoAC0s2uF00opQgMqvsv1wW
	 LMj1kV7xYDAIZfVaON/XGqDCrVLUaFfUYyM/Gx+co+mFatQcAmXUk/ko08ihXzbGQb
	 nyC+e/m93XL8oeugCCrb0e6DNjdj4ci9WoglS7+cxdN5mogTqcnLNIY2+lawS8kOBk
	 9B8Ohe3u6K4t8cw7RkVvuvPiDZ2iG3n9RzUHX0FoJaDNT3j0ss48L8ew6lqZ2V7oAj
	 BdtNWVrC1mvFWiw0V8i27IoUEivnqIkXGo8TsC2SyGb+hnGcjTUh7ievzcn5Fardk0
	 1k/nUWbh3MeAA==
From: SeongJae Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	florian.fainelli@broadcom.com,
	pavel@denx.de,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.1 000/444] 6.1.83-rc2 review
Date: Mon, 25 Mar 2024 10:59:06 -0700
Message-Id: <20240325175906.233615-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325115939.1766258-1-sashal@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Mon, 25 Mar 2024 07:59:39 -0400 Sasha Levin <sashal@kernel.org> wrote:

> 
> This is the start of the stable review cycle for the 6.1.83 release.
> There are 444 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:59:37 AM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.1.y&id2=v6.1.82
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] cfc80383a3dc ("Linux 6.1.83-rc2")

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

