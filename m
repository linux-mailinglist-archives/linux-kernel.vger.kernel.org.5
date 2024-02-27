Return-Path: <linux-kernel+bounces-83765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E69869E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F082913AE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E814EB34;
	Tue, 27 Feb 2024 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFOmSE/X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCE04B5C1;
	Tue, 27 Feb 2024 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056052; cv=none; b=ee7C/hZV7YjtWfVsc4Zz+nZFZF157QnEpX4bC+nBgKPLseugZTquVDbJTB0sv0QdbhsiZSG7N1gBqekKOpSzVgqB8CW33ZiNk1OzVp91lmJSDWsXBRzGLqvUoR51Z0ix4Wn855a02BhNaGE5jLGhjJi0dniPSAWEfPxG9JhcUII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056052; c=relaxed/simple;
	bh=e7kqUQr4tj/Qy+nmYI3vJWjopc2YK80lk9rqzMOgJ7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eEUD36RnWLemYUnrJ07HdJEt9/DvtzrwJ+5lXf4etVXPCzbWtxuhJz5Kc9scicLfKAlRvjnL8fxqF5c2WL2nmTB5UjAyXKrwrRu9ASebgUBADf49tvGWlx+UCUiny/2cwcNPKL3535M4y5nfGkbUK/MnkjBFdHKj0pWyPfSADzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFOmSE/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9A5C433C7;
	Tue, 27 Feb 2024 17:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709056051;
	bh=e7kqUQr4tj/Qy+nmYI3vJWjopc2YK80lk9rqzMOgJ7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IFOmSE/XMvz3OTHUq2Kc5FG6NdvNKCLHL+qUNnxlEYdIfXVTQKG4/sFKQmZUvp8tQ
	 Dugbg/gbsckHKvcg0skGsodbYjZB0XSWCIPRZt8mOhvOnPFZrStDbWrrT4EiLulOwk
	 aS/RxJioiKSUC7H2BH2dtIpETwxrrFxuf3YqVmXKK1qx3fcmcZatajIyjgeT8ptcHx
	 mWOVNvKF3QDupqHSlxJG5QJ+gdzsX1iYjSCNCcTXnh9qSaovh7dEHS1w/PTk9sHVEd
	 GLrye7hAiMxQA9HdIhnjyxwFUTAI7RgrGAp26kowhsUKyC76ViSnMnRfXmfVx2kkxG
	 oH/gFMz71bALQ==
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
Subject: Re: [PATCH 5.15 000/245] 5.15.150-rc1 review
Date: Tue, 27 Feb 2024 09:47:29 -0800
Message-Id: <20240227174729.170220-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Tue, 27 Feb 2024 14:23:08 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 5.15.150 release.
> There are 245 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.150-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] 3ab4d9c9e190 ("Linux 5.15.150-rc1")

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

