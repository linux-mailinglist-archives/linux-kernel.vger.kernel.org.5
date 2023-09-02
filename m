Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1477905DC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 09:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351783AbjIBHmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 03:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351758AbjIBHms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 03:42:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECE01719;
        Sat,  2 Sep 2023 00:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DACA61776;
        Sat,  2 Sep 2023 07:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22855C433C8;
        Sat,  2 Sep 2023 07:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693640562;
        bh=PibSncufftCzamTsAcJwZAlD4xVyHUzymGj5RpyOx7w=;
        h=From:To:Cc:Subject:Date:From;
        b=RQW8Y5TdrObwKyRJqPJtI/7YOFUf123DRNcGdPsWWdtji6nssyuB9e6i1y1T4yfn4
         5rBKxCq5jXJ89R6FWktczGEWxXwA/SGcIb6Gut+07/OnxPrRrfA8pV8Cp7ek2mK7It
         cgIBVuYOqXe66AP6wpVMRuD62SirXI5xg2h2IAtQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.51
Date:   Sat,  2 Sep 2023 09:42:32 +0200
Message-ID: <2023090232-skilled-device-adb5@gregkh>
X-Mailer: git-send-email 2.42.0
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

I'm announcing the release of the 6.1.51 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt |    4 
 Makefile                                        |    2 
 arch/arm/kernel/module-plts.c                   |    2 
 arch/arm64/kernel/module-plts.c                 |    3 
 arch/parisc/kernel/sys_parisc.c                 |  169 +++++++++---------------
 arch/x86/include/asm/sections.h                 |   18 --
 drivers/acpi/thermal.c                          |    6 
 drivers/thunderbolt/tmu.c                       |    1 
 include/linux/moduleloader.h                    |    5 
 io_uring/io_uring.c                             |   46 ++++++
 kernel/kallsyms.c                               |   17 --
 kernel/locking/lockdep.c                        |   36 +----
 kernel/module/main.c                            |    2 
 13 files changed, 144 insertions(+), 167 deletions(-)

Arnd Bergmann (1):
      arm64: module-plts: inline linux/moduleloader.h

Greg Kroah-Hartman (1):
      Linux 6.1.51

Helge Deller (3):
      lockdep: fix static memory detection even more
      parisc: sys_parisc: parisc_personality() is called from asm code
      io_uring/parisc: Adjust pgoff in io_uring mmap() for parisc

James Morse (3):
      module: Expose module_init_layout_section()
      arm64: module: Use module_init_layout_section() to spot init sections
      ARM: module: Use module_init_layout_section() to spot init sections

John David Anglin (1):
      parisc: Cleanup mmap implementation regarding color alignment

Mario Limonciello (2):
      ACPI: thermal: Drop nocrt parameter
      thunderbolt: Fix a backport error for display flickering issue

Yonghong Song (1):
      kallsyms: Fix kallsyms_selftest failure

