Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125C778EB9D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344792AbjHaLL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244932AbjHaLLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:11:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88639E4A;
        Thu, 31 Aug 2023 04:11:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC6B0B82257;
        Thu, 31 Aug 2023 11:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F22CC433C7;
        Thu, 31 Aug 2023 11:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693480279;
        bh=FERMvax9TbLfvFclhnBYRSGWpvFgfEWgj/sYRijBi0k=;
        h=From:To:Cc:Subject:Date:From;
        b=xTAT8UgxzSyvsVsA3taxnEF94DM0NERzXa2ixn8JuaZPvY88VEUXTceN1VHNnDo/G
         ikwoX1DaG5oV2+eV3iSOzyjXLi3nCtCoCLGMgVrAhm6ahWlaVPp8t/DUqPBeZxjGyt
         JKif57EwHKTkO8GxXJhGCoazR7WD0jLhFOZDRO7I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.15 0/9] 5.15.130-rc1 review
Date:   Thu, 31 Aug 2023 13:10:08 +0200
Message-ID: <20230831110830.039135096@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.130-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.130-rc1
X-KernelTest-Deadline: 2023-09-02T11:08+00:00
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.15.130 release.
There are 9 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.130-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.130-rc1

Paul E. McKenney <paulmck@kernel.org>
    rcu-tasks: Add trc_inspect_reader() checks for exiting critical section

Paul E. McKenney <paulmck@kernel.org>
    rcu-tasks: Wait for trc_read_check_handler() IPIs

Neeraj Upadhyay <neeraju@codeaurora.org>
    rcu-tasks: Fix IPI failure handling in trc_wait_for_one_reader

Paul E. McKenney <paulmck@kernel.org>
    rcu: Prevent expedited GP from enabling tick on offline CPU

James Morse <james.morse@arm.com>
    ARM: module: Use module_init_layout_section() to spot init sections

James Morse <james.morse@arm.com>
    arm64: module: Use module_init_layout_section() to spot init sections

Arnd Bergmann <arnd@arndb.de>
    arm64: module-plts: inline linux/moduleloader.h

James Morse <james.morse@arm.com>
    module: Expose module_init_layout_section()

Mario Limonciello <mario.limonciello@amd.com>
    ACPI: thermal: Drop nocrt parameter


-------------

Diffstat:

 Documentation/admin-guide/kernel-parameters.txt |  4 ---
 Makefile                                        |  4 +--
 arch/arm/kernel/module-plts.c                   |  2 +-
 arch/arm64/kernel/module-plts.c                 |  3 ++-
 drivers/acpi/thermal.c                          |  6 +----
 include/linux/moduleloader.h                    |  5 ++++
 kernel/module.c                                 |  2 +-
 kernel/rcu/tasks.h                              | 36 ++++++++++++++++++-------
 kernel/rcu/tree_exp.h                           |  5 +++-
 9 files changed, 42 insertions(+), 25 deletions(-)


