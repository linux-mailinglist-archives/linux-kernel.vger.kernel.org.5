Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC88E75D5C1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGUU35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGUU3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:29:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B410E0;
        Fri, 21 Jul 2023 13:29:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03B8561D9E;
        Fri, 21 Jul 2023 20:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2434FC433C9;
        Fri, 21 Jul 2023 20:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689971393;
        bh=XYmhbJIe+hh0dz93/kek9xodyfiBcV/T+AblsXSkuHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HXmEvQOXkkWnlKqGWST0aiMRT/r2Mrji8/dMY+vde/2Fzb12jB6gJMjNg/ywo8oTI
         IR98+jQjyxN9Q2HvDSRhjzzFXCT9kzuQZypaZjOyoTfZ8+ZztSBM9Q2KOyRbokqSJB
         ZdxI+B9HUnfGfIfN1QXlfrxDjnEWoRiKvTcstQKpolw2vQdlLqzbKtflVEYRaq8Qca
         4573Thk7IwWdGNCqunXVkpo/e+8sH9Jh68pZdFLE1FAHNmanRHFlhJ7aLWAjXNckMs
         aA/jaWaFdu6hK8guat+evkU12tb4fmKz8FoNgIJsXo2SyPJ0yXbOcZ2LmxxWGMxsJO
         nPOxgOJudDTTA==
From:   SeongJae Park <sj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 6.1 000/223] 6.1.40-rc1 review
Date:   Fri, 21 Jul 2023 20:29:50 +0000
Message-Id: <20230721202950.61910-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 21 Jul 2023 18:04:13 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.1.40 release.
> There are 223 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 23 Jul 2023 16:04:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.40-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.

I confirmed that this rc kernel passes DAMON functionality test[1] on my test
machine.  Attaching the test results summary below.

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr


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

PASS
