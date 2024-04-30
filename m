Return-Path: <linux-kernel+bounces-164417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E63648B7D68
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225EF1C2343D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85560179675;
	Tue, 30 Apr 2024 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kK2b9tbb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF889DDBE;
	Tue, 30 Apr 2024 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495627; cv=none; b=JqjolFgo4tjj7C80Ue9Ooc0M014B39Nh3KvQz/FhKouTRbci5AlRPjeQ7vbnAIXA2PiTCu6dxwttt8VQew+d4SBpHMzFMC6/gQ5tbR5BEz0+iZMEj6oDG0GyjCKENpBTGwPQkl/fAJpU4x8XBqlEXn77uXfUEp/9XIjwxj03sYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495627; c=relaxed/simple;
	bh=Ep6cDDu/SerRR+kyfc1AOQSffwbLwETmOR0ksOogg9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pOM29Y9aTg7G80gISHQg1bZbEAFSazyVvP1QxAyrHwkkfB1m2fY/3Vs8H5yk7uwyZXnBzes/BQsMycS4m4v/PdFYGiVy2eXHpf8cAE9gtkA+l8uoJ7JzgL4WfqE1mekutQtB/tg5i7dEhXIjKxpsTr415wgUmAk7SqVT9UclmgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kK2b9tbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1905C2BBFC;
	Tue, 30 Apr 2024 16:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714495627;
	bh=Ep6cDDu/SerRR+kyfc1AOQSffwbLwETmOR0ksOogg9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kK2b9tbb3GIfI5yf/ovq0F7tG3hwFt0RWxMtdQYyxKTIbBbxNgJPnl2v9KRCCj/oV
	 jn6+EcqZsK0V1y1cfwvgQC4SwxiqxwzkLmWct1/wOXuQV/Rm5AK10qklVzehAeD1Cp
	 JStyZpUzM3xTA5/0CByuZYAvMx/fS2zv+DRN4WONdB08v4qRUiPRwOL2k0d03dHhRN
	 nbxmkn55kNBA57Z/dgYjqb96RJLKmYvORqiu2dulye6oq9i8baYdThpzQElb6jwawI
	 RnDJJ7+9bvvdBSzADQ3NrTlbXBNfYCbRVioHZSxWxjmq0h0GW6Tt+vbcPUzWncQIoY
	 aMF6skztqdhjQ==
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
Subject: Re: [PATCH 5.15 00/80] 5.15.158-rc1 review
Date: Tue, 30 Apr 2024 09:47:03 -0700
Message-Id: <20240430164704.75413-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240430103043.397234724@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Tue, 30 Apr 2024 12:39:32 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 5.15.158 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.158-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] d6b90d569cec ("Linux 5.15.158-rc1")

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

