Return-Path: <linux-kernel+bounces-155984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3130E8AFC5D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4771F24747
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9B32E859;
	Tue, 23 Apr 2024 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADsHxsE8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFB41C6BE;
	Tue, 23 Apr 2024 23:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713913205; cv=none; b=HCALKylzOHNRowoSuoXqDRXBJLhQjKUPIXqHSQJSNYxpweyTcNoauhmf9tYeYiDKOlBsZES6TLUnFRTqR1xPEdMdwazi0Fit3nbQWzneWKtk6+DyxqMCWpyDz1jKmH9dYx8He3mWTVgQ1M7ETCHiY/zKM/IE6SkWcw8gJisuxqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713913205; c=relaxed/simple;
	bh=3mvO4GVsprVt1iFW3+idrrVMdXMu8WnVO3kCE4KvApQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JwQKLuYiAjkg5pRNVwDNo+WnzUSS/OHUD69NjtUoZO3ZVR+rnqOwDqb/D0icu/TC65UpTIowXWM8gBd144nKMABi241yfAXSaCvCkgbvypUmvTRxvX9lGs50/MPoC7MvLECc4GLxsyJMmhXLysFCqL7lNzP6KCyHEV5Po3N5ozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADsHxsE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5CAC116B1;
	Tue, 23 Apr 2024 23:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713913204;
	bh=3mvO4GVsprVt1iFW3+idrrVMdXMu8WnVO3kCE4KvApQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADsHxsE8+WcFvZ3Dl7VmoJOkqCxmMEANfRaC0doXxVqBiUDaAsKGTsGlcJ7P4yhy0
	 GfE+Cn8Ymn+2q5fLKZaL91QHvxmx1o3VEq3ZBrj/I3e1Iv3tDk0VNaW56H1NHpb2d7
	 HaTsade2bNmSgwKcciZ0t2TcwwYpuTqwjhIyaFe9u+dFh09GTDLRmuLrC1Hiw+gwct
	 KxTbakz7a4ZDqTQYDIO078LU7H8m/xdOi85xHRwhjQMtexfQs8LiOQOQ8QXd9ebHgA
	 4WNSVomgyaT3DPt3WdncoL0n5IZxYNGREzNhQ2RvwqoPW0/US4Un5dzt4EGxswTPVn
	 zrWuv1XOcmCuw==
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
Subject: Re: [PATCH 5.15 00/71] 5.15.157-rc1 review
Date: Tue, 23 Apr 2024 16:00:01 -0700
Message-Id: <20240423230001.346377-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240423213844.122920086@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Tue, 23 Apr 2024 14:39:13 -0700 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 5.15.157 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.157-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] 70f39a25a6b8 ("Linux 5.15.157-rc1")

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

