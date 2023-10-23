Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736D87D3C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbjJWQXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjJWQXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:23:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321FBD7A;
        Mon, 23 Oct 2023 09:23:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A59C433C8;
        Mon, 23 Oct 2023 16:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698078183;
        bh=hw1RXDOvJQbEcCc6aiMGkaMdzvxKkAGo1xlXgtElMxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i9wc8Y4R1kVemCS/QZfjYyTWUDmRl7qcQCpvf1SbcSBE5hudWJaTMM2gO69nAAo+9
         WWhDq1VsbpTwTQBwIGWMwva4KN70cCasRr3++3M1SFmu5jp4LptXVofrdS0tDID851
         zqSOfePJQwv5cw4/ZogStkc85gRJeugmXW/dLsu/fLcNLOLZAfTpWBOt3oqHKWKeuo
         LaUAo+mAf7/fxwOvLoH8EWaJCxMpjLw+EEeDmc2nqijSJ8ALrVXHccKPPQXSZ56VYz
         0HlzYiG5ax7GZ8VT427PLaoRXrK5UEgM10veBu9oxzpqHbweTINDWBEf1FsFVky6NW
         jAQzlgU96YVvA==
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
Subject: Re: [PATCH 5.15 000/137] 5.15.137-rc1 review
Date:   Mon, 23 Oct 2023 16:23:00 +0000
Message-Id: <20231023162300.188047-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, 23 Oct 2023 12:55:57 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 5.15.137 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Also, please note that the automated run of the test was failed kunit test due
to a buggy commit.  Attaching test results summary is that of the failed one.
I made a fix and pushed[3].  With the fix, I manually confirmed this rc kernel
passes the kunit test with the fix.

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] c7721f02ed5c ("Linux 5.15.137-rc1")
[3] https://github.com/awslabs/damon-tests/commit/6182d52940e83623376ceceb6c0b90e661abba3b

Thanks,
SJ

[...]

---

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
not ok 1 selftests: damon-tests: kunit.sh # exit=1

 [91mFAIL [39m
_remote_run_corr.sh failed (5 times)
Connection to localhost closed by remote host.
