Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546FD78F68E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 03:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348014AbjIABFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 21:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjIABFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 21:05:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C5A10DE;
        Thu, 31 Aug 2023 18:04:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 536B361DF0;
        Fri,  1 Sep 2023 01:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64525C433C7;
        Fri,  1 Sep 2023 01:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693530290;
        bh=fvTxfLUhfAuU7bfbtfdaYACrGVKGUe+QNGoHK+K2ylo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gDe/hH1m7pkRXSZQRAm0VU7IQn0tgHn5KB2wON37b5hOrw62LK/u54jC7dF92TwX0
         qQ5CcOverLysYLfRVpIHiK0SkyjxLjIDUVyCkaD+2JMgz0qfTiOWlquOFiyzw7MaCg
         +gWkbNFQSfsjVgJUiLbk54HD0WkAgIg5lWnYwBugTfgs+MkfcsyB3S10IugnL69WYJ
         kSrWdVjKHubWlFYmRvR+86zMWHersGdyydz+g1wgbCZ1js3n9A9G46UTOU5fK2R+J7
         xqY8L5X3/StoUUfZ7f9REe2XV8Enq0KTvoyu++FsWilM5XRbIvwAjzogSWLRllUN6f
         wx65epoHrmLBg==
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
Subject: Re: [PATCH 6.4 0/9] 6.4.14-rc1 review
Date:   Fri,  1 Sep 2023 01:04:47 +0000
Message-Id: <20230901010447.49402-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831111127.667900990@linuxfoundation.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, 31 Aug 2023 13:11:27 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.4.14 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:11:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] 499afdc4a899 ("Linux 6.4.14-rc1")

Thanks,
SJ

[...]

---

 [32m
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
ok 11 selftests: damon-tests: build_m68k.sh
ok 12 selftests: damon-tests: build_arm64.sh
ok 13 selftests: damon-tests: build_i386_idle_flag.sh
ok 14 selftests: damon-tests: build_i386_highpte.sh
ok 15 selftests: damon-tests: build_nomemcg.sh
 [33m
 [92mPASS [39m
_remote_run_corr.sh SUCCESS
