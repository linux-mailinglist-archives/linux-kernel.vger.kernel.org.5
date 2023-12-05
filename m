Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6476805C1D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345321AbjLERim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjLERJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:09:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426F01BE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:09:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D457C433C7;
        Tue,  5 Dec 2023 17:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701796149;
        bh=mfCTwBrNlsw0BmDAWHPnDlrs+5S5RWznuV7vJPLzxgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KS2ogpMRXC3TwEhvv2sOp44ckuGKoJNmyx0vWTA79M/mc2e5zN6UYdaRcIkFjid0v
         pijsvfVgpB1AFy5wPUFepFY5Mu3deGInx9Eusq9+fgAfqwDfxzpKy9cScACbqXs4ub
         sA2Sinn3za3pqoi7SHJ45CahiHGJqs5vVNMd6DkAQ4tigGv/yj+Bdrxla71nK/SVEn
         mIhlVwa0v+bu3n/2UK/BRG2uQIIwHpz9/zi6si0a+dLY+N2uTXNyL8x2m0i7a14C77
         Qv+GQ7LlfJKNrwX2Oxkpzi9k7abELYoKnbIXfEJeHPkjxPdVlHAq8x1htiYHDDT2ne
         o4min16tsyhaQ==
From:   SeongJae Park <sj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com, damon@lists.linux.dev,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 5.15 00/67] 5.15.142-rc1 review
Date:   Tue,  5 Dec 2023 17:09:06 +0000
Message-Id: <20231205170907.2126-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205031519.853779502@linuxfoundation.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023-12-05T12:16:45+09:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 5.15.142 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] bff845be423f ("Linux 5.15.142-rc1")

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
ok 12 selftests: damon-tests: build_i386_idle_flag.sh
ok 13 selftests: damon-tests: build_i386_highpte.sh
ok 14 selftests: damon-tests: build_nomemcg.sh
 [33m
 [92mPASS [39m
