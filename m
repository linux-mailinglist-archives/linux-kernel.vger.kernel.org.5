Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CCB7D3C59
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjJWQZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjJWQY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:24:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37D1E4;
        Mon, 23 Oct 2023 09:24:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DA7C433C7;
        Mon, 23 Oct 2023 16:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698078296;
        bh=QafwhIyKRywPgzKy2niqWZ7a6petGIcryfRlf2IB1GE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uv8P4u2sNzRrofvbSUkXlHEHg1CkEkrW+GHfHKgKffBQ9qQwRmXq5HKaJalEmh9j0
         zDrxDYwbxL1nRSZQa8jnY0pgGaDcwTeyO6TcCGDifHN0M/qYsqMfgUqqwia2td2xXr
         WFchUyEswZzcxBpbCaJpmvvMTYw0OArQtzJSa9UyI5xBdixnX6miU+Nj0ofjasL17b
         NMS4gGWbEdMDD7uOi55PXK5G3Eg/bHIW+5cy4pE4WSVQb1EdDaoGhWj0vkSWuPq71C
         t3TJzBLcczrOSheZWWZpMu+61ji//cctcF8hvTTAqydcwFcN3XOmle7gTcoJyl1GHJ
         cXwlWTAwPI8EQ==
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
Subject: Re: [PATCH 6.1 000/196] 6.1.60-rc1 review
Date:   Mon, 23 Oct 2023 16:24:53 +0000
Message-Id: <20231023162453.188072-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
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

On Mon, 23 Oct 2023 12:54:25 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.1.60 release.
> There are 196 patches in this series, all will be posted as a response
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
[2] fa9447b759f6 ("Linux 6.1.60-rc1")
[3] https://github.com/awslabs/damon-tests/commit/6182d52940e83623376ceceb6c0b90e661abba3b

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
ok 7 selftests: damon: sysfs.sh
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
not ok 1 selftests: damon-tests: kunit.sh # exit=1

 [91mFAIL [39m
