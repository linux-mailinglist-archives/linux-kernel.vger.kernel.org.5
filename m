Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4EB78EBB5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344730AbjHaLMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243718AbjHaLMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:12:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9294E71;
        Thu, 31 Aug 2023 04:12:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3615963BED;
        Thu, 31 Aug 2023 11:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C47FC433C7;
        Thu, 31 Aug 2023 11:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693480341;
        bh=59NZeDVpDsDasqYOG+CfnySsSFCDI/hmWzDKgKdCdQU=;
        h=From:To:Cc:Subject:Date:From;
        b=BMeaR6oBiFYrHvSVhlqXc1f24uPAUorTwN1nbtRmGy4FLL4cuchhKN4oT6oaXqLpP
         Kkb+UEtG3aHQ+kiuOknn38f5+JhFWC8Wlz1ULhwLg4NdX95yxrpjcNG/uKCDTTRZ5a
         6tPOSJTPNquNmRRXbuN9mi6OQji9Hecb+jSMy3rY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.4 0/9] 6.4.14-rc1 review
Date:   Thu, 31 Aug 2023 13:11:27 +0200
Message-ID: <20230831111127.667900990@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.14-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.4.14-rc1
X-KernelTest-Deadline: 2023-09-02T11:11+00:00
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.4.14 release.
There are 9 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat, 02 Sep 2023 11:11:18 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.14-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.4.14-rc1

Yonghong Song <yonghong.song@linux.dev>
    kallsyms: Fix kallsyms_selftest failure

Helge Deller <deller@gmx.de>
    parisc: sys_parisc: parisc_personality() is called from asm code

Helge Deller <deller@gmx.de>
    lockdep: fix static memory detection even more

James Morse <james.morse@arm.com>
    ARM: module: Use module_init_layout_section() to spot init sections

James Morse <james.morse@arm.com>
    arm64: module: Use module_init_layout_section() to spot init sections

Arnd Bergmann <arnd@arndb.de>
    arm64: module-plts: inline linux/moduleloader.h

James Morse <james.morse@arm.com>
    module: Expose module_init_layout_section()

Andrea Righi <andrea.righi@canonical.com>
    module/decompress: use vmalloc() for zstd decompression workspace

Mario Limonciello <mario.limonciello@amd.com>
    ACPI: thermal: Drop nocrt parameter


-------------

Diffstat:

 Documentation/admin-guide/kernel-parameters.txt |  4 ---
 Makefile                                        |  4 +--
 arch/arm/kernel/module-plts.c                   |  2 +-
 arch/arm64/kernel/module-plts.c                 |  3 ++-
 arch/parisc/kernel/sys_parisc.c                 |  3 ++-
 arch/x86/include/asm/sections.h                 | 18 -------------
 drivers/acpi/thermal.c                          |  6 +----
 include/linux/moduleloader.h                    |  5 ++++
 kernel/kallsyms.c                               | 17 +++++-------
 kernel/kallsyms_selftest.c                      | 23 +---------------
 kernel/locking/lockdep.c                        | 36 ++++++++++---------------
 kernel/module/decompress.c                      |  4 +--
 kernel/module/main.c                            |  2 +-
 13 files changed, 38 insertions(+), 89 deletions(-)


