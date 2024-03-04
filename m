Return-Path: <linux-kernel+bounces-91379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E1987105F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1E0286219
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507227C082;
	Mon,  4 Mar 2024 22:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fc6TCrKg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED233C28;
	Mon,  4 Mar 2024 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592599; cv=none; b=OJ/l2kIErZtPyxrvwLJ4Yh8M80OCpAhUvflFEf+MXTUjUbkNbUgdCyePvhH8oNXbBgwcXMZRter2K1F0hTSbNF2RZyGE0DBHO/0D3hlg11tWl4sOVevfEdIjVejSBziwbRS8lXSMdCgQyZBF6qB5LI5xfX9a7gR1iAxskh2ADLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592599; c=relaxed/simple;
	bh=fyD2ZFLldeT3Wmlx0r/gNWAv0VuDCuzRCUYlvo6tVRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=otg30THnZxSGUkN5CfZh1fc6jAs6q59/YfKWjNZvXKsCfYI5Zl7FHLl1IAKdJL00qNiS/Z80CpE2MQ1ORc2eRE69v7SanrfDkkWq7YCPinTIuDgZ22bbJAIHvJIm8z05BKVCmQNvur55LspMUcPqGUXnvY8/9YtQHMdY5nAMT3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fc6TCrKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA29C433C7;
	Mon,  4 Mar 2024 22:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709592599;
	bh=fyD2ZFLldeT3Wmlx0r/gNWAv0VuDCuzRCUYlvo6tVRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fc6TCrKgGrDN72aZxjQ1q1FK1KNNVroQqsfqLMbdiisVrD1yn5lnDXgx2SkNiqy9O
	 YRGo3vfR37uXRmd56eOjNw5EmSlMnOEPLFxhyuKEMurbh3D6ctQ6oyTNUhaWnXylSy
	 KBYQh/Rve4jb3kHy13JL4Tsls1gJphqBzE8W6M4HjvvPjPqBU/oWx2Z8EFVRblRMlX
	 Er2pAwvlZ2xhoNoea0XJFM/d01LlwWJQxRqa4f8QJvwBWG7eKN8WBqZcIwKA1iml/a
	 Je5cJHvlJp+vZvKkeSFHmfKu6RqYNx1IX/42cnsCBz/k/jcCeZvvVNOzPAHB85Ujn+
	 AYv/6tezlXYew==
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
Subject: Re: [PATCH 6.1 000/215] 6.1.81-rc1 review
Date: Mon,  4 Mar 2024 14:49:56 -0800
Message-Id: <20240304224956.73421-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Mon,  4 Mar 2024 21:21:03 +0000 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.1.81 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.81-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] cf578ac947cb ("Linux 6.1.81-rc1")

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

