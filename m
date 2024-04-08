Return-Path: <linux-kernel+bounces-135652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69B689C945
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E87061C24824
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CE71422B5;
	Mon,  8 Apr 2024 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOwMbddT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0841411C9;
	Mon,  8 Apr 2024 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592167; cv=none; b=Iasyhu1BnXLE+i5blJuozROSvFRa3y9wAKMmY62DHh8x0L3FmV0Zd6DXf7U+sANhs/5ZLVV6oYy3HwlwOKFvgBP4lut4+mQa/2faQJY5FqS1Ma5t8k6v4nByFTVaBc2TuIjmSQ2AjHr73HfHRJKSSttvFQipcwdv3mA96BPXQQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592167; c=relaxed/simple;
	bh=IGUP8fRxe93CuPxPQzFDE6p+WO9RjoNbxLQP8u63MLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gEbp+A/jFLm86JO06rqaNqTHkfekGwvPuxslyowOJ2MLEq2QcJ4mkGkevL57W53Boy5o+Xebp9yIPJ0LGmQJa/KIl3PXrYgjiXNSIZTGZhcPko0QnfRvqVvmL4p3RE08Y9nwilg84KMGDzsSy4YhpUAH/o0CJKhS9xmVfzK+/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOwMbddT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9C2C433C7;
	Mon,  8 Apr 2024 16:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712592167;
	bh=IGUP8fRxe93CuPxPQzFDE6p+WO9RjoNbxLQP8u63MLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OOwMbddTzKif00X3yumc2NAIMorgiGNvh3Or2Z6F4SUfGW5yM6QFfuVcSWkdGFsKt
	 20rwOzSrmTRSvdcCTBc1gPzhloMgtDUFl/87WEg+SeRcZx6FSY94AEZ0L3YOvtIlIS
	 XglyPP2zquIX7z0CeW2DRkVzOem1Jkx0bLLpmLKjWrbsC2QsEAx28KhRuQU8nrqoWR
	 Nq1Nxvr1a3eH/CYe9zQwBGAHneBiPn8oUAiC303i7cCOHKFwF6uC/w8aeE5zDQ53o/
	 GlJKULC8vWRTuyUkWhua+m6Y4krkQl9TapPP/nLejevKZq1JqiAGw2hoVwln7EnD6t
	 qPuPmTzXg356w==
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
Subject: Re: [PATCH 5.15 000/690] 5.15.154-rc1 review
Date: Mon,  8 Apr 2024 09:02:43 -0700
Message-Id: <20240408160243.90693-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Mon,  8 Apr 2024 14:47:46 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 5.15.154 release.
> There are 690 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.154-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] bfeab055fa43 ("Linux 5.15.154-rc1")

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
[92mPASS[39m

