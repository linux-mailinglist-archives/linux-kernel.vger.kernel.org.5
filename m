Return-Path: <linux-kernel+bounces-141384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC838A1D82
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C03285064
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFBA168AF0;
	Thu, 11 Apr 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ys5e+9B1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A1B15E7E4;
	Thu, 11 Apr 2024 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855550; cv=none; b=hIDoAfTXm5WLy8rnMXRX2gmRJ/JBEzi3dWbf71z86EdF7Fa3rC9iKaa2Wh9WkgGwSevhxfz2EOYC95uNODqPX89dykdjKaBckZkA2UiyH2x6oNINY2+PfWtMYTTk58K8O5dUsr9irXAob0E7MTII3qDv+Mv8woKcHymw0pebTEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855550; c=relaxed/simple;
	bh=nWIC2wi/d7G1FnSaSYJnrH6f8AXjkGPfN3MaeSlImoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MgRx1eL587acNkF3yCESsil5TyOvo1yBjygMMi5p/jIJe+vOqk4R1vZmDZdd4LveouH1Gne+ebaRsdLLdI2zpkuNXypEID5J/vTBzZki3V/aVMnmqO+G629kqVkvrxb2tXJsnpbpMaxpMgAZ+Ud3svsRhvRIY24L0anlK7OUq4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ys5e+9B1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1AAC2BBFC;
	Thu, 11 Apr 2024 17:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712855550;
	bh=nWIC2wi/d7G1FnSaSYJnrH6f8AXjkGPfN3MaeSlImoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ys5e+9B185oUwpdUtd+LklScSa352u/V+J8TEqGkCGID65NLEW2FnlpYztTd6CZK8
	 Vq/KiOZO7STsr7y4XBllcQk+hDhZKAs+rZ03PpZjV+xJf4xFX5e4rC3cdyefl9fBBc
	 y9ZQ2ml50fam4d8z8g96w77/XciJlJ6dglM/O7ynakEVDWYNgE6pbF5dQ7hKV6r8Ag
	 wwmwuiolva2whhzJb3y+VUn2pDLYCHIX06JDiN4+uoeoKe+KLwU1uoMpCkl3KT7DxW
	 hq3cNpppWireKlQ9f3GEMHU6e7onUjJKI/46UAFMCvkVX+AQoGiCGBFEQ2ZGbnxwFw
	 n3wb52pEynpFQ==
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
Subject: Re: [PATCH 5.15 00/57] 5.15.155-rc1 review
Date: Thu, 11 Apr 2024 10:12:26 -0700
Message-Id: <20240411171226.156386-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240411095407.982258070@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Thu, 11 Apr 2024 11:57:08 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 5.15.155 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.155-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] 857e7024b96f ("Linux 5.15.155-rc1")

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

