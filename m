Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860D67897D2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjHZPsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 11:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjHZPsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 11:48:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28611BCD;
        Sat, 26 Aug 2023 08:48:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B0AF628DB;
        Sat, 26 Aug 2023 15:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09285C433C8;
        Sat, 26 Aug 2023 15:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693064892;
        bh=vy6gTdPBWYFPn84J3jz0oTbAHvmlLVgTDMT3FDT9f4Y=;
        h=From:To:Cc:Subject:Date:From;
        b=U6cDjz7RtYD9cld2xmU4ar9GUT7h44u5FDTOLzqvWqSo2DiFJDwRYNtd0i7GslWQd
         fOR06ZkWHHyid5abLERx85o2qCMjO3rdpziv5/TT299Rq40t4uTz4eSH0XpjaL66jU
         ZtBKRDw8v/txU/wFzuhC8dDodqy/86HJS99g3yFc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.1 0/4] 6.1.49-rc1 review
Date:   Sat, 26 Aug 2023 17:47:56 +0200
Message-ID: <20230826154625.450325166@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.49-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.49-rc1
X-KernelTest-Deadline: 2023-08-28T15:46+00:00
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.1.49 release.
There are 4 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon, 28 Aug 2023 15:46:14 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.49-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.49-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "f2fs: fix to do sanity check on direct node in truncate_dnode()"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "f2fs: fix to set flush_merge opt and show noflush_merge"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "f2fs: don't reset unchangable mount option in f2fs_remount()"

Peter Zijlstra <peterz@infradead.org>
    objtool/x86: Fix SRSO mess


-------------

Diffstat:

 Makefile                             |  4 ++--
 fs/f2fs/f2fs.h                       |  1 +
 fs/f2fs/file.c                       |  5 +++++
 fs/f2fs/node.c                       | 14 ++----------
 fs/f2fs/super.c                      | 43 ++++++++++++------------------------
 include/linux/f2fs_fs.h              |  1 -
 tools/objtool/arch/x86/decode.c      | 11 +++++----
 tools/objtool/check.c                | 22 +++++++++++++++++-
 tools/objtool/include/objtool/arch.h |  1 +
 tools/objtool/include/objtool/elf.h  |  1 +
 10 files changed, 54 insertions(+), 49 deletions(-)


