Return-Path: <linux-kernel+bounces-34608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD928382CC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD39284DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC6C53A1;
	Tue, 23 Jan 2024 01:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDcLw5bD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9435251;
	Tue, 23 Jan 2024 01:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974541; cv=none; b=PQ8HeWdMrmOfIgPLG4UKPGvjkJt/OJVy1oLuybbFBKagTQesSR/3uRMTNN98rfB6iyy8pPpPj5XBKRYqbLNWey/GiKTsC8LwvjUk1DBRuE8r0FkZfMAhyCMCgo8KH1w391CHgFPVnjlUAYBy8bmTkVseP/JV6FxdBgEG3zGLsvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974541; c=relaxed/simple;
	bh=sTtD1ZLcUap9Qupl1UpXWxMXp6FKjjRtC3E3L5/bdyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B9pScSQ4LfM5p+dm9aN/R5PN/gRguL5hMS5PLO8h5ZVOWt9KvEkbres+PFWejLrFrALdWhjrUl+ziILYgwYIgZFMpd/iEAdIocS4qKyDyyvE7xahl49wbsER2DpF6KaiSY5lLnw47aMbLi/+B7JSuc3dLegoUt06pqHxGUKAVvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDcLw5bD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C148BC433C7;
	Tue, 23 Jan 2024 01:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705974541;
	bh=sTtD1ZLcUap9Qupl1UpXWxMXp6FKjjRtC3E3L5/bdyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HDcLw5bDby5RiXcUbIh+7OvEuosokttsU7ZF1y6Xp5RsTc6g2dl/Bvv0HwjHrsZUy
	 tXGfll6fwN5hi1FxDe8hHMv+CflpbwlCCS5sQwKu/RAbQFMWwqOf5USNGIPFBmmRaY
	 ShpZw7dr1e/i53Lusn+7UsCWtkrvQ9y+Tir0rZJhCE83ZPoVJ8cMeNyS/cqpJCdp2P
	 52IrpDeKbBfeFLEMbPzkPY1q63/V59tTBmKTn+xl8U02I9AEzwzV56ME3QlFWqktvZ
	 hYWWo1IsHke65H7wrbtmPzoarNamQG+O0BRd2u0UZwULhPGzFdW48YI55eEbdkex1H
	 Xue8QNCcjQXsQ==
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
Subject: Re: [PATCH 5.15 000/374] 5.15.148-rc1 review
Date: Mon, 22 Jan 2024 17:48:58 -0800
Message-Id: <20240123014858.85820-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Mon, 22 Jan 2024 15:54:16 -0800 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 5.15.148 release.
> There are 374 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.148-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] 59db9667b9d1 ("Linux 5.15.148-rc1")

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

