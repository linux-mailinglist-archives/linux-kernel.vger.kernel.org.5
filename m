Return-Path: <linux-kernel+bounces-103853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21A887C5C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2FF1C20F62
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9915FC12;
	Thu, 14 Mar 2024 23:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaRspTRv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD6DDDA;
	Thu, 14 Mar 2024 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710457743; cv=none; b=lHYbg8Wx9gpTSALcSdb4CI79HlE1O8XTBIESS3xXYI1lbSeiSkZ3E/1+JqXaB7UNkEpxyUFHDlhczeTbbd6jEUajkBaqns0II2wkcUhrWHOcEhKxFJOUTX2+QJzSapxLCzorsgDdoZCgBztCOlyKJOnS5yegMM53GWZ7dZjFPcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710457743; c=relaxed/simple;
	bh=OiOpNntc5X/cQdzuDesZAYEIgjBaLAD0lYBR53h3sss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mRBo5P7+67gIoYGXunrsz9LcY2QzYkHpaYTU2h99TJfzrSzN0P4ijwdR83/dLU0kq7nOC42v/NYQ0KqkqfOd16UeVAhM+lEjZWgnG3y1PkrYOVjIIRYnywLQu8LfZz/AqlxhpikJ4+6WiRvqgxBQhsEZYn9xeMJ9nFZF1D7cfpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaRspTRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825F7C433C7;
	Thu, 14 Mar 2024 23:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710457742;
	bh=OiOpNntc5X/cQdzuDesZAYEIgjBaLAD0lYBR53h3sss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jaRspTRvUDCYPL2NGspwivOqEe6EDE3yySo5QULOT8pKSq/TKaYojTiO4xE4SkrbN
	 tjUty0TdQp0oceogjpZTo5/EpTAMeRyRdYKFUGRCsgLYO3KtObPlJc6EhUyPIKSjyD
	 +UWHtpcknPAAawo24OkjP4ibYpd1puWx3cwojYtpXGtsfqYpn9swrf4QqubeoTENL8
	 yzmUZFJUzmor5/YfNDCD9D3W7uRmFcr+ghblqpA1upqRA9I0/t9j4QL+u1WcPtsm1z
	 jwL/TBEYu40rOU458bokyf3bKIrOYsU2uaMCUU1xu698PkH6UkmAoo8m6+SVZn6S6A
	 kDeVRbaB81FaA==
From: SeongJae Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 5.15 00/76] 5.15.152-rc1 review
Date: Thu, 14 Mar 2024 16:08:59 -0700
Message-Id: <20240314230859.76304-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Wed, 13 Mar 2024 12:41:07 -0400 Sasha Levin <sashal@kernel.org> wrote:

> 
> This is the start of the stable review cycle for the 5.15.152 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Mar 15 04:42:22 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.151
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] 3e68d7dfa7d6 ("Linux 5.15.152-rc1")

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

