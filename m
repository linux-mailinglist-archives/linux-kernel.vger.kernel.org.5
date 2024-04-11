Return-Path: <linux-kernel+bounces-141388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BACDA8A1D95
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B152891F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2761E792B;
	Thu, 11 Apr 2024 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM+Pb4/8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA0E1E6F55;
	Thu, 11 Apr 2024 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855621; cv=none; b=ncO5JEUVbP4oy/dexeeZsw77qyMoUcyVQyE9kwjTn9zkF2bkUzVMwnqadXld6iBsU1+Y+xTJQukePDrl8pt6Xb6bORIUNKWT/m2lR47zfQM8lsWtBab7OjW+EKdl5kbB6wwbc2vy2QGD1kfBmxERlBcLSpX5BVYJwnGquaT2Apc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855621; c=relaxed/simple;
	bh=ZZHSdo7EN4Sd9TZhTFFRWk3WKpCacpkIDs0yW9HXE5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ETAPVWGLex3OsCel5Uec1ym2HY3meDxdOxo1It20M7VWyZ8PnwE67Ya6nDHiYI+uTTT/bcCB5iWZf3Srrcuph36Rw9YupmGFl9aSCuw4c2Z+NTTYUAMQKmQjwaEavG59VBtw4+ED13LvlFuNbRCIdS36YoLS1LuVlV83DOvWXqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM+Pb4/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEBFC113CD;
	Thu, 11 Apr 2024 17:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712855621;
	bh=ZZHSdo7EN4Sd9TZhTFFRWk3WKpCacpkIDs0yW9HXE5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DM+Pb4/8oeARzwllgMN9nAL/Ok8gWOcMqtgOrUXJJ9+AJHXzk1Ax3bV17CX9xCNqs
	 nTSCkhNR5pLWsfH6NgYo+81CBipicWiyErb4AE0V3Pa2ohkFUPaljOt7YPdTozLbeb
	 mQbXgvcugIVSZWtHA+XzQvJ/dzmWfgiPv1tph5RMtnZrXk/ep3BXeulknRvKyvN3Ud
	 wpnbEV5D+4W7rmijgacT5B0Ml5QPWWSnbF7PaMyivPKphwj/WEW0ZdHqrBlqk1aiNH
	 gngLttqjCMz847cHrsNW5Mn6559rNjJRARDvT+uroPYPUceD3CBNaGu+g0dDXHWrfJ
	 kWRmkTHpwaieA==
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
Subject: Re: [PATCH 6.1 00/83] 6.1.86-rc1 review
Date: Thu, 11 Apr 2024 10:13:37 -0700
Message-Id: <20240411171337.156444-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240411095412.671665933@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Thu, 11 Apr 2024 11:56:32 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.1.86 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.86-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] 2cacd493e299 ("Linux 6.1.86-rc1")

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

