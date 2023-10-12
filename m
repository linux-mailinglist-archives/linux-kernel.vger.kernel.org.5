Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EE67C7591
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442013AbjJLSBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379686AbjJLSA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:00:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0E0F2;
        Thu, 12 Oct 2023 11:00:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D0EC433C7;
        Thu, 12 Oct 2023 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697133656;
        bh=Hf4hPbHZtAedhECJGdTegrWudOsOUUxkdQln8aGOmlw=;
        h=From:To:Cc:Subject:Date:From;
        b=OjWIYYJR/nj+e8nkpR+pEEoihcEuNDgX438Gbt2lcoum0JLnPs+f8mXMaCMP+91ug
         MMhhLOSSQMVJUaTDDBFZdqPNvrzAbxdaZ8KdUMrLlpHxQYf+L8R5peg9goJi4hj258
         wOyY8AecJ5URGvFIUfvGndQHnyCqmsJd7vTeOCXs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.1 0/6] 6.1.58-rc1 review
Date:   Thu, 12 Oct 2023 20:00:42 +0200
Message-ID: <20231012180030.112560642@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.58-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.58-rc1
X-KernelTest-Deadline: 2023-10-14T18:00+00:00
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.1.58 release.
There are 6 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat, 14 Oct 2023 18:00:23 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.58-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.58-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    lib/test_meminit: fix off-by-one error in test_pages()

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "NFS: Fix error handling for O_DIRECT write scheduling"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "NFS: Fix O_DIRECT locking issues"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "NFS: More O_DIRECT accounting fixes for error paths"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "NFS: Use the correct commit info in nfs_join_page_group()"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "NFS: More fixes for nfs_direct_write_reschedule_io()"


-------------

Diffstat:

 Makefile                 |   4 +-
 fs/nfs/direct.c          | 134 +++++++++++++++--------------------------------
 fs/nfs/write.c           |  23 ++++----
 include/linux/nfs_page.h |   4 +-
 lib/test_meminit.c       |   2 +-
 5 files changed, 56 insertions(+), 111 deletions(-)


