Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916307A3D86
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 22:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241015AbjIQUq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 16:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239733AbjIQUqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 16:46:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8097D1;
        Sun, 17 Sep 2023 13:46:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11E8C433C7;
        Sun, 17 Sep 2023 20:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694983564;
        bh=YCvyGKWa8Qgt16CSEhFJyax3ZrrbTrGLEGhc6BmNGTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qRj/CUSqEWtUkSZqwfOMO1mwnaXTbsuMuyqx/FwXZFVYAZmBcwn23uJ+WidIfcqeh
         64O7ArSWtUIWvNaMY+gMXKsS0XbGqBApffKGH7jpvyaOgxA8bApmjMNFTU5fU71bDT
         qD8q0g7j/SQ9Xvyh67FffGxh/IBoNBQCBfqAQeknHxoLy6wOG+F9/Yqg1pVbZSIx/v
         vtkaqS/ohimQEIufGY6oF8kDi4nT5ud+3mGM2JBxGkzcK/LOKUQNOvb+qTJ993TkKX
         QvemWGxZL1v2q5SCtosOCMK58dgJ9o3FihYuBy50KedMyyqrpEDZ47itYZ1YqyLCBb
         sc79KM+OK5fSA==
From:   SeongJae Park <sj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, damon@lists.linux.dev,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 5.15 000/511] 5.15.132-rc1 review
Date:   Sun, 17 Sep 2023 20:46:01 +0000
Message-Id: <20230917204601.104860-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, 17 Sep 2023 21:07:07 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 5.15.132 release.
> There are 511 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.132-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] a8d93816a2f2 ("Linux 5.15.132-rc1")

Thanks,
SJ

[...]

---

ok 13 selftests: damon-tests: build_i386_idle_flag.sh
# selftests: damon-tests: build_i386_highpte.sh
# .config:1341:warning: override: reassigning to symbol DAMON
ok 14 selftests: damon-tests: build_i386_highpte.sh
# selftests: damon-tests: build_nomemcg.sh
# .config:1342:warning: override: reassigning to symbol DAMON
# .config:1352:warning: override: reassigning to symbol CGROUPS
ok 15 selftests: damon-tests: build_nomemcg.sh
# kselftest dir '/home/sjpark/damon-tests-cont/linux/tools/testing/selftests/damon-tests' is in dirty state.
# the log is at '/home/sjpark/log'.
 [32m
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
ok 11 selftests: damon-tests: build_m68k.sh
ok 12 selftests: damon-tests: build_arm64.sh
ok 13 selftests: damon-tests: build_i386_idle_flag.sh
ok 14 selftests: damon-tests: build_i386_highpte.sh
ok 15 selftests: damon-tests: build_nomemcg.sh
 [33m
 [92mPASS [39m
_remote_run_corr.sh SUCCESS
