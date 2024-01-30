Return-Path: <linux-kernel+bounces-45251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0D1842D98
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8991C233A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE8871B35;
	Tue, 30 Jan 2024 20:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+W9xHNX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72A569E1E;
	Tue, 30 Jan 2024 20:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645969; cv=none; b=hUuw9ODs6CbJ16zrFiGvaKNs0XXfAdD+RwqRbh2FnSUVnztDgYW1DlveVrl67icVdSStsd+dyrUXYpb8XSM0QbqygOXVKgJpCRfH5jCRWy4B2q0oyduI8eqRGdhDaYug1MpPhVlaplAsDgSCmO6iIQL6T+cP+5+KiwRx6RdbbGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645969; c=relaxed/simple;
	bh=nu45nRqzigmHcqbdARLL2KtDJB21XLNBDYQYq4LnuvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oDgbMRD4s9IN3ayJ9B3DTXqOpECs2Bi6lgforbhBwHyRX0/E/x8/Q3DFWy/L4136WJP2sgfLBPCpg1/7Sb+bBCyrr+tNSd8Z6IR4wh/bbz5NEmV4A89c9FlCZiuO4xV++1eK5M81JdGX3gTFIt3vSPN3DnMQEbVPM+6k8+83ob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+W9xHNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65B0C433C7;
	Tue, 30 Jan 2024 20:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706645968;
	bh=nu45nRqzigmHcqbdARLL2KtDJB21XLNBDYQYq4LnuvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+W9xHNXk3uukHMUq4Us9fIyCX/gCmOgkLZnjq/VWz85CVyNHJ6NmzJ9+UgaR+ZFU
	 PggCQ/DZOZXIXeK3sV+/31DcHabZCws6P+aMwJEbyLp/iO3qOisZZ6zcyrZP7CZKjR
	 0ZGEryHpI5NXbS34kDQt8TGgoUf4rsdvdMVLm5EIn45KXw2/HwXZJkQHNIFoyfqHAc
	 KlXE6Q0MSEq+vn3XZgmQX+LRL9lt5km5bTr+ex4zXqsVVRYqio6xQy1cQADRVjTuHZ
	 WbvUGc28DEEz8Jgjvy5wCeLgqgipSUXYM5NewKVHJkr3uhukuniDg7MJna+RhTB75X
	 h9yW9W/infDoQ==
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
Subject: Re: [PATCH 6.1 000/186] 6.1.76-rc2 review
Date: Tue, 30 Jan 2024 12:19:25 -0800
Message-Id: <20240130201925.109728-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130183318.454044155@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Tue, 30 Jan 2024 10:47:38 -0800 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.1.76 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 Feb 2024 18:32:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.76-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] ce3f6cd9e4cd ("Linux 6.1.76-rc2")

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

