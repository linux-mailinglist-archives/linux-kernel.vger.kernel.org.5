Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FB87E2AE9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjKFRZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFRZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:25:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB83F3;
        Mon,  6 Nov 2023 09:25:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FD0C433C7;
        Mon,  6 Nov 2023 17:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699291502;
        bh=50bfv3E+DAa5JA5qWNDyUr1UCe1TdTDR2NsC4bcugjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EfaCtFTBlnel6n0g103ocv0lvTpRmL1NmkPq+OH/MbIosIV7zlhzgVCFP7Y2Dc/Er
         21e8xtbbyvxzqwj/DlWb/y8Xznuh+AoFTITa7IlF0EOwVI5l1yxxjPoiTv28ScsgAz
         l28rsUAxwNCNt64BNjS3sn8zDouChEtgjPCmhpRmSV9ZwzbUf6fzsXYaTxngcm7mvT
         A/ZQCDVxZYFaXrKiQYn+HW4kQzgHIHvIQnY0oCOkbaoYJLWJaBLiHkMjQOLaJMMszs
         8i4WP3WaTLR6XrqSGF9zxfMBk2WlXcUaVhAXnfzA81nNkTtfJ9E0Z9jFbGdIv2EkAB
         DwruKSBbEiq1Q==
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
Subject: Re: [PATCH 6.5 00/88] 6.5.11-rc1 review
Date:   Mon,  6 Nov 2023 17:24:59 +0000
Message-Id: <20231106172459.48351-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
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

On Mon, 6 Nov 2023 14:02:54 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.5.11 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] 73d52afec3ab ("Linux 6.5.11-rc1")

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
ok 12 selftests: damon-tests: build_i386_idle_flag.sh
ok 13 selftests: damon-tests: build_i386_highpte.sh
ok 14 selftests: damon-tests: build_nomemcg.sh
 [33m
 [92mPASS [39m
