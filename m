Return-Path: <linux-kernel+bounces-117662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23AA88AE29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F434323DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F33C4D9EA;
	Mon, 25 Mar 2024 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnyqphND"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81DA3DAC17;
	Mon, 25 Mar 2024 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389431; cv=none; b=VZ+FaWizQBZlpBI4IF+vherKtL1k9x78KhfpORZMbv/Q4ShpuJIxkVFkhOsBOUdboGGdfPUGhd0hu9Y5ItAwMw/qusKOQid9ZAU/ydqlSuZpehrxCHjDP0ILJGzq2g6LQtfZ4uAip56vZVCmf/Fcr6UzssY+pZw9QflFJcwo7QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389431; c=relaxed/simple;
	bh=7eUqgvZWPkYkJLi/rhajdqR92toSJUhOgdlFGfJ4erE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z20JsPNk9o78A8KHDDenJh+1wGZ9YcYaY7A2qx8BJBr2IrCV8l6q5Ui9dCXGdWsv+nBuzf8E+dUiVfOu1cNlKhqOjYy/xMCT4mE5L7Uwgpz2ljCpVo4EFoIHCCwCoR9WTj9AtWY7d10n0MCegkLtBPOkQBbG0yWFgaizyhWDVeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnyqphND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37273C433F1;
	Mon, 25 Mar 2024 17:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711389431;
	bh=7eUqgvZWPkYkJLi/rhajdqR92toSJUhOgdlFGfJ4erE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nnyqphNDzXLXCbBPAONHc6qAGzBLbjTjchWzTxlfFqc6QbRH8/Vy86yBvS97aGqX/
	 Lx/RseRWHY3nJ0ZHs2bhj9+36wBB+BS36xAYgQXXt6GKbpyxY/OMmiS3i3EFlyHTL6
	 DXEolsCGiQuRFX0jfEhO1vHVdJcwGvv7Osp6zHgLIMhZHlDkE8li26t31VMb3Ngcq+
	 mzOSsRQi74e9OL6X0lQKVRpBOymH5YlliVSrpWVfpBksQ+8zPFvzhBBPJGqY0vX87A
	 4TD6mL4kYMMcO0xDKy3Xp4gzpZM0aVg7cjS0UqqC7rax37II+Bhja+zx+1RuT8P1OK
	 mKQcLj7RVh7nQ==
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
Subject: Re: [PATCH 6.7 000/707] 6.7.11-rc2 review
Date: Mon, 25 Mar 2024 10:57:08 -0700
Message-Id: <20240325175709.233563-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325120003.1767691-1-sashal@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Mon, 25 Mar 2024 08:00:03 -0400 Sasha Levin <sashal@kernel.org> wrote:

> 
> This is the start of the stable review cycle for the 6.7.11 release.
> There are 707 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 12:00:02 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.7.y&id2=v6.7.10
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] 506a04d850a4 ("Linux 6.7.11-rc2")

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

