Return-Path: <linux-kernel+bounces-36019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA95839A39
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E174C293663
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F0485C56;
	Tue, 23 Jan 2024 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWSKoImh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5DA60EE4;
	Tue, 23 Jan 2024 20:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706041384; cv=none; b=IfSUVUIl5fxRfVfLjua7uadwQpWb9vxGjuiSAxxxDXfnKLSRS3BxZRZJk007SnROPAbt+hv9uTsq/5uhDdiY9SiD1cnHefXEl4o1v80UdL84s5vBrIJKEv440yIVW8ZJeZX7IT527gTz4QTcMWSt5nk5EwQzAPRYgYSAmF9f454=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706041384; c=relaxed/simple;
	bh=Uc3CPYoXa1xgdWm4ozcRAySO3PLJd1TMPVuIn2a8TfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IyBNMovvXuHYnwL2CAmRk+gcnGrSfT7NNqrBg4b0ne1mytBBy9vJpzl4/UTVMy5Y/uEk9gYBF1IZnbORH/Mn2YhJvSgzrBlyyaI8kN55PVcinwgT08e7IqtdtFv1LPAMjs7TpN5D84ydo0BAZa912pXxXYTiDuJb5pB3h+2B35o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWSKoImh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2B4C433C7;
	Tue, 23 Jan 2024 20:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706041383;
	bh=Uc3CPYoXa1xgdWm4ozcRAySO3PLJd1TMPVuIn2a8TfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cWSKoImhagqWR4Xw+vXw2oBHqg/U5p49xUmp7tmcVYDUw/HguPwZY+7zALZ3zk/8v
	 YInixZ1047inlSqJ9Iiy9DKQNpR2QRMo0IKjGet5vzY3zIgmPxXS6e70PChEDz4hvS
	 xebC+D34YiLv3nd2Tjuk+eYUBY1RvK1rieXbUh39ol/CZrrpxDeYxe1LwUaC6z2gnU
	 ehNPxK3JjySo9ILnjTiRZgVyyN9Jf3QeZT3Fy9eTjcqfqgz51dd8yo8hbNlKKPjsU4
	 TU06qCp2mVi7a5ZoZpueRbczCFIqilG6twoWscHhHotROSfEuVpiG0N86GnhSLMLWF
	 R1uMYc3gY/5+Q==
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
Subject: Re: [PATCH 6.7 000/638] 6.7.2-rc2 review
Date: Tue, 23 Jan 2024 12:23:01 -0800
Message-Id: <20240123202301.93566-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123174544.648088948@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Tue, 23 Jan 2024 09:47:30 -0800 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.7.2 release.
> There are 638 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jan 2024 17:44:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.2-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] 2320541f64ba ("Linux 6.7.2-rc2")

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
 [33m
 [92mPASS [39m

