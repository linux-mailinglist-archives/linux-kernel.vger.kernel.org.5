Return-Path: <linux-kernel+bounces-117668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC84488AE43
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822131F3D4F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121AC129A89;
	Mon, 25 Mar 2024 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFHHkLtK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5258A8665D;
	Mon, 25 Mar 2024 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389600; cv=none; b=VIZy0XVE6Yw/GHnv4lDF+I37XGFLmFdvQoDmnUQj0dfxKwoijUU/P8L1hoccnaZx5zCh06vUQDKxSOJNoYdj9xt52k/oeQUoWvxPAP455IMqUf0LS1IvSpUQtt0lRzkV4pKe81pK9N8ZavL6M5QRn0ZR53h9bioR6QDUm6kO4r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389600; c=relaxed/simple;
	bh=b7IDzaWT6uTJU6g7eRyocNkJQUp3OphZOZR1xJLUO38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ub9ezzUoU/HBqKe5bDNiM2TmnsZJ5AgZWBPOnIg2XDRoYMFHpbJpOV6/DR86A+fXdN3AkMUf49vH5Y/JxtIdkJ7ZK/vgJPVs/b1g0+WyAN++FwwvRzowNjmNNADEEFKimGIj4jLKo8jGdnSQ6lnVK2bwr6Trkv9Oks03aP5tE00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFHHkLtK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FECBC43390;
	Mon, 25 Mar 2024 17:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711389600;
	bh=b7IDzaWT6uTJU6g7eRyocNkJQUp3OphZOZR1xJLUO38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CFHHkLtK0iqzTrNEuYBrrPTak21KVQUboVe3FJY6KPE5A4jjRIUG9LZSJ+xM3IEVH
	 x//eB9RmYyniy5zHYIrLU1NmVqE9BG0a7qXhjOxxnq9J4MZDLKkhU8a69K41H+krDG
	 QTwed3DQGN7ETpmW+JSNywKrK+q8XScD1pbVoRliqDbDPnCPkmleN7rpNRKoFjqCLF
	 Iu/ZYoJxEgb4xRGOhXETGRFSi5NOhZlSSdoSsP+WFM6BIuiCwI8gqml/dwTi2Rbxh9
	 6p8UDU72yrDsFLEBIquZZhZ1a9Hfre4BnquVXD+1G3PFB0CZ1H9byEnUc7IldwFQsi
	 WxaF+1CQi02TA==
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
Subject: Re: [PATCH 5.15 000/309] 5.15.153-rc2 review
Date: Mon, 25 Mar 2024 10:59:57 -0700
Message-Id: <20240325175957.233640-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325115928.1765766-1-sashal@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Mon, 25 Mar 2024 07:59:28 -0400 Sasha Levin <sashal@kernel.org> wrote:

> 
> This is the start of the stable review cycle for the 5.15.153 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:59:27 AM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.152
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] d978081b2581 ("Linux 5.15.153-rc2")

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

