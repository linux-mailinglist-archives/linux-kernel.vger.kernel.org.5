Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587307B99AA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244380AbjJEBbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244383AbjJEBbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:31:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62F0D8;
        Wed,  4 Oct 2023 18:31:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48E9C433C8;
        Thu,  5 Oct 2023 01:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696469479;
        bh=RPXMkPaRiJJTjGke9RnQjGYLrhA86ZyX5HHuIGl4m9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=igzgq1ZILzGaIe4kMS/kL4hSeCU15QuWh+Ww6T0foMLOaWThmeOZbvHsGZVFjbdpB
         eNDBG46YSNkJ462/wKADnUiQjPhVDrPDGtFPPAGPOt7zyoSqF5afJZJvNAMYPmKF6K
         hgEh3MI5gfhBIHt6J8lYWYAORgqdhuHW8g3l3Sg2JSm0Eb9jR5HvmuEaPUnPsDUJFD
         r0KaLaHWIQaHjUx+NJSGCwI6O5ABHMvB7hFWKone2Rd7hzdb6e0jEWcJ0MCSNFjkX9
         clOOJMBkPldU+xUiZmThlOVa85ktZ8sjLWATCsjEWC3xDfb5HOwfHpBTrQ1lrjgzxg
         W5EdiDj4nHzfQ==
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
Subject: Re: [PATCH 5.15 000/183] 5.15.134-rc1 review
Date:   Thu,  5 Oct 2023 01:31:15 +0000
Message-Id: <20231005013116.6451-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 4 Oct 2023 19:53:51 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 5.15.134 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.134-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] 6f28ecf24aef ("Linux 5.15.134-rc1")

Thanks,
SJ

[...]

---

# .config:1347:warning: override: reassigning to symbol DAMON
ok 12 selftests: damon-tests: build_i386_idle_flag.sh
# selftests: damon-tests: build_i386_highpte.sh
# .config:1347:warning: override: reassigning to symbol DAMON
ok 13 selftests: damon-tests: build_i386_highpte.sh
# selftests: damon-tests: build_nomemcg.sh
# .config:1348:warning: override: reassigning to symbol DAMON
# .config:1358:warning: override: reassigning to symbol CGROUPS
ok 14 selftests: damon-tests: build_nomemcg.sh
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
ok 11 selftests: damon-tests: build_arm64.sh
ok 12 selftests: damon-tests: build_i386_idle_flag.sh
ok 13 selftests: damon-tests: build_i386_highpte.sh
ok 14 selftests: damon-tests: build_nomemcg.sh
 [33m
 [92mPASS [39m
_remote_run_corr.sh SUCCESS
