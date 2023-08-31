Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FD478EBA3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244444AbjHaLMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343768AbjHaLMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:12:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7028210EF;
        Thu, 31 Aug 2023 04:11:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B91E163BB6;
        Thu, 31 Aug 2023 11:11:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04ADC433C8;
        Thu, 31 Aug 2023 11:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693480299;
        bh=Nb7ZxB99xT+gFAqqhdJ9croBOXAq4axqdZodrVzX+ao=;
        h=From:To:Cc:Subject:Date:From;
        b=Asl83XKEV8ZFX/u3y2hDnvhluHBJkqtNGbRJQEBF/wgICLpMDLuNjWVDE6YS19PHw
         zhbjQXlsbYD8LdsD4V5ijbgaTb8Z4FiKqDYSWxOlQK8gUyI75hkvBORe+ZkmoBi7C4
         DG50m+Vlz9O4FzUM6CSQUxGb92xqDxiqAa7jMfIE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.5 0/8] 6.5.1-rc1 review
Date:   Thu, 31 Aug 2023 13:10:27 +0200
Message-ID: <20230831110830.817738361@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.1-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.5.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.5.1-rc1
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

This is the start of the stable review cycle for the 6.5.1 release.
There are 8 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.1-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.5.1-rc1

Yonghong Song <yonghong.song@linux.dev>
    kallsyms: Fix kallsyms_selftest failure

Helge Deller <deller@gmx.de>
    lockdep: fix static memory detection even more

Eric Dumazet <edumazet@google.com>
    ipv6: remove hard coded limitation on ipv6_pinfo

Andrea Righi <andrea.righi@canonical.com>
    module/decompress: use vmalloc() for zstd decompression workspace

James Morse <james.morse@arm.com>
    ARM: module: Use module_init_layout_section() to spot init sections

James Morse <james.morse@arm.com>
    arm64: module: Use module_init_layout_section() to spot init sections

James Morse <james.morse@arm.com>
    module: Expose module_init_layout_section()

Mario Limonciello <mario.limonciello@amd.com>
    ACPI: thermal: Drop nocrt parameter


-------------

Diffstat:

 Documentation/admin-guide/kernel-parameters.txt |  4 ---
 Makefile                                        |  4 +--
 arch/arm/kernel/module-plts.c                   |  2 +-
 arch/arm64/kernel/module-plts.c                 |  2 +-
 arch/x86/include/asm/sections.h                 | 18 -------------
 drivers/acpi/thermal.c                          |  6 +----
 include/linux/ipv6.h                            | 15 +++--------
 include/linux/moduleloader.h                    |  5 ++++
 include/net/sock.h                              |  1 +
 kernel/kallsyms.c                               | 17 +++++-------
 kernel/kallsyms_selftest.c                      | 23 +---------------
 kernel/locking/lockdep.c                        | 36 ++++++++++---------------
 kernel/module/decompress.c                      |  4 +--
 kernel/module/main.c                            |  2 +-
 net/dccp/ipv6.c                                 |  1 +
 net/dccp/ipv6.h                                 |  4 ---
 net/ipv6/af_inet6.c                             |  4 +--
 net/ipv6/ping.c                                 |  1 +
 net/ipv6/raw.c                                  |  1 +
 net/ipv6/tcp_ipv6.c                             |  1 +
 net/ipv6/udp.c                                  |  1 +
 net/ipv6/udplite.c                              |  1 +
 net/l2tp/l2tp_ip6.c                             |  4 +--
 net/mptcp/protocol.c                            |  1 +
 net/sctp/socket.c                               |  1 +
 25 files changed, 51 insertions(+), 108 deletions(-)


