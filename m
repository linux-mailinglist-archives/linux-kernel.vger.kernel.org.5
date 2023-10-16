Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A097CB29A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjJPSfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjJPSfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:35:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E81A2;
        Mon, 16 Oct 2023 11:35:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF54C433C9;
        Mon, 16 Oct 2023 18:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697481337;
        bh=0sZNyYJufZfEnzv5I8B+QAwaoh5lUuIQWXv/vgtfVqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jt0TIgG7sFtxR8y20e/lHFFOYUCy5BC1u7iodPkgoarrO5mX/b9r9clGMqx7Q+M57
         CZB8r77MMhdWTxvCL7FgvX2Vq27T5ufruy63fiTyrYt3Q+Wgw+/rbGUVIdQPjeJCyj
         dT3yppsjxWgOhJ8E7W8dEDqrOy9wzdpuAVCXPYxnMLg5iAfZIxKrE37fHiQEmCHbS6
         dBkcluZPTt6xmDzm4aLQJ7TFlmJSnnhY2US8EZXE6Rdp9e/6MSQ9RV8n7VvJG+6jP3
         R163ctoPTUC0MDkJT4mxPZZZbw2U6V62j8yVRpTXobdq2d458BhyIAYvqPT7rFLT6Y
         zzJUU/UL4WAvg==
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
Subject: Re: [PATCH 5.15 000/102] 5.15.136-rc1 review
Date:   Mon, 16 Oct 2023 18:35:33 +0000
Message-Id: <20231016183534.98630-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
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

On Mon, 16 Oct 2023 10:39:59 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 5.15.136 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Oct 2023 08:39:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.136-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] f11fc66f963f ("Linux 5.15.136-rc1")

Thanks,
SJ

[...]

---

ok 1 selftests: damon: debugfs_attrs.sh
ok 1 selftests: damon-tests: huge_count_read_write.sh
ok 2 selftests: damon-tests: buffer_overflow.sh
ok 3 selftests: damon-tests: rm_contexts.sh
ok 4 selftests: damon-tests: record_null_deref.sh
ok 5 selftests: damon-tests: dbgfs_target_ids_read_before_terminate_race.sh
ok 6 selftests: damon-tests: dbgfs_target_ids_pid_leak.sh
ok 7 selftests: damon-tests: damo_tests.sh
ok 8 selftests: damon-tests: masim-record.sh
ok 9 selftests: damon-tests: build_i386.sh
ok 10 selftests: damon-tests: build_arm64.sh
ok 11 selftests: damon-tests: build_i386_idle_flag.sh
ok 12 selftests: damon-tests: build_i386_highpte.sh
ok 13 selftests: damon-tests: build_nomemcg.sh

PASS
