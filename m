Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897DF7905E2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 09:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351789AbjIBHov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 03:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbjIBHot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 03:44:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D311706;
        Sat,  2 Sep 2023 00:44:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 978D461772;
        Sat,  2 Sep 2023 07:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA462C433C7;
        Sat,  2 Sep 2023 07:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693640684;
        bh=e+6AAVJBTB6gE62nOKNiEGWZOXlaTCbaiQKEJGO7pOc=;
        h=From:To:Cc:Subject:Date:From;
        b=f8HkLb98x1LvSrm45FXTkxrrcZhkvOF81l6q6lGPBkqRY2izbdFRSRAcMg9dksjw9
         JG2ureu9sAXZruAdzXfn7UivhKDS01oDUnZVuIPq1TMXVfR+x50kdnMwEaDYebBVXC
         n0joaa/ct3SNFYQDEyAutqfkQlFCxp57f3UpGVGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.130
Date:   Sat,  2 Sep 2023 09:44:36 +0200
Message-ID: <2023090235-bobble-pound-ae28@gregkh>
X-Mailer: git-send-email 2.42.0
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

I'm announcing the release of the 5.15.130 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt |    4 --
 Makefile                                        |    2 -
 arch/arm/kernel/module-plts.c                   |    2 -
 arch/arm64/kernel/module-plts.c                 |    3 +-
 drivers/acpi/thermal.c                          |    6 ----
 include/linux/moduleloader.h                    |    5 +++
 kernel/module.c                                 |    2 -
 kernel/rcu/tasks.h                              |   36 +++++++++++++++++-------
 kernel/rcu/tree_exp.h                           |    5 ++-
 9 files changed, 41 insertions(+), 24 deletions(-)

Arnd Bergmann (1):
      arm64: module-plts: inline linux/moduleloader.h

Greg Kroah-Hartman (1):
      Linux 5.15.130

James Morse (3):
      module: Expose module_init_layout_section()
      arm64: module: Use module_init_layout_section() to spot init sections
      ARM: module: Use module_init_layout_section() to spot init sections

Mario Limonciello (1):
      ACPI: thermal: Drop nocrt parameter

Neeraj Upadhyay (1):
      rcu-tasks: Fix IPI failure handling in trc_wait_for_one_reader

Paul E. McKenney (3):
      rcu: Prevent expedited GP from enabling tick on offline CPU
      rcu-tasks: Wait for trc_read_check_handler() IPIs
      rcu-tasks: Add trc_inspect_reader() checks for exiting critical section

