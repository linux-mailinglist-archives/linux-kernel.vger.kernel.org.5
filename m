Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4897905E7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 09:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351810AbjIBHpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 03:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351795AbjIBHo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 03:44:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E721709;
        Sat,  2 Sep 2023 00:44:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A558DB82768;
        Sat,  2 Sep 2023 07:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E55C433CA;
        Sat,  2 Sep 2023 07:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693640690;
        bh=/yRjotvbK1yGYxE5mOKSTCyD28MbfIEl/92XwQMlNDE=;
        h=From:To:Cc:Subject:Date:From;
        b=dLWyKVJi3shDGkTHRbmq+YKwlhwBZy8mPrVeNPmqPil9bQor57weWoYPanpaXWSXP
         jyGc/C1scSRetbjwjUqdW8bfR+O6i9SrVC3gbkZB4wti/NIUjvj5iLxAlbf2g9ouck
         PNsevkvDBPNVcQ+Q7FfJJcqTFAzEn2Lh+VbiNv+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.194
Date:   Sat,  2 Sep 2023 09:44:43 +0200
Message-ID: <2023090243-resend-fasting-cf36@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
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

I'm announcing the release of the 5.10.194 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                               |    2 -
 arch/arm/kernel/module-plts.c          |    2 -
 arch/arm64/kernel/module-plts.c        |    3 +-
 arch/mips/alchemy/common/dbdma.c       |   27 +++++++++++-------------
 drivers/bus/mhi/host/pci_generic.c     |    2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |    6 +----
 include/linux/moduleloader.h           |    5 ++++
 kernel/module.c                        |    2 -
 kernel/rcu/tasks.h                     |   36 +++++++++++++++++++++++----------
 kernel/rcu/tree_exp.h                  |    5 +++-
 10 files changed, 55 insertions(+), 35 deletions(-)

Arnd Bergmann (1):
      arm64: module-plts: inline linux/moduleloader.h

Greg Kroah-Hartman (3):
      Revert "drm/amdgpu: install stub fence into potential unused fence pointers"
      Revert "MIPS: Alchemy: fix dbdma2"
      Linux 5.10.194

James Morse (3):
      module: Expose module_init_layout_section()
      arm64: module: Use module_init_layout_section() to spot init sections
      ARM: module: Use module_init_layout_section() to spot init sections

Loic Poulain (1):
      mhi: pci_generic: Fix implicit conversion warning

Neeraj Upadhyay (1):
      rcu-tasks: Fix IPI failure handling in trc_wait_for_one_reader

Paul E. McKenney (3):
      rcu: Prevent expedited GP from enabling tick on offline CPU
      rcu-tasks: Wait for trc_read_check_handler() IPIs
      rcu-tasks: Add trc_inspect_reader() checks for exiting critical section

