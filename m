Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C571D7905D4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 09:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbjIBHmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 03:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbjIBHmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 03:42:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB093B4;
        Sat,  2 Sep 2023 00:42:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F4D9611A9;
        Sat,  2 Sep 2023 07:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2C0C433C7;
        Sat,  2 Sep 2023 07:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693640540;
        bh=CRrBrlFYOYwIgYoCmwA9acsYxUNUh4+P7gKaOqAEi6c=;
        h=From:To:Cc:Subject:Date:From;
        b=afol60pJjXN4gjEHEmlyTUHPSx5UF0lBXu9UJHFSuWmRy10bxbbPdNGXdtylKGid1
         OzTNzhMnD1mIyczamZ01h0Hv0C+nMZKmRSUhtPupfSICQEODh4s8UFfNZmtiwZoXbx
         aBJsGndaaGJgKLfyq+Z7PV0O3huYUt+6PP68dhGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.5.1
Date:   Sat,  2 Sep 2023 09:42:15 +0200
Message-ID: <2023090213-appease-unmapped-e652@gregkh>
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

I'm announcing the release of the 6.5.1 kernel.

All users of the 6.5 kernel series must upgrade.

The updated 6.5.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.5.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt |    4 --
 Makefile                                        |    2 -
 arch/arm/kernel/module-plts.c                   |    2 -
 arch/arm64/kernel/module-plts.c                 |    2 -
 arch/x86/include/asm/sections.h                 |   18 ------------
 drivers/acpi/thermal.c                          |    6 ----
 include/linux/ipv6.h                            |   15 ++--------
 include/linux/moduleloader.h                    |    5 +++
 include/net/sock.h                              |    1 
 kernel/kallsyms.c                               |   17 ++++-------
 kernel/kallsyms_selftest.c                      |   23 ---------------
 kernel/locking/lockdep.c                        |   36 +++++++++---------------
 kernel/module/decompress.c                      |    4 +-
 kernel/module/main.c                            |    2 -
 net/dccp/ipv6.c                                 |    1 
 net/dccp/ipv6.h                                 |    4 --
 net/ipv6/af_inet6.c                             |    4 +-
 net/ipv6/ping.c                                 |    1 
 net/ipv6/raw.c                                  |    1 
 net/ipv6/tcp_ipv6.c                             |    1 
 net/ipv6/udp.c                                  |    1 
 net/ipv6/udplite.c                              |    1 
 net/l2tp/l2tp_ip6.c                             |    4 --
 net/mptcp/protocol.c                            |    1 
 net/sctp/socket.c                               |    1 
 25 files changed, 50 insertions(+), 107 deletions(-)

Andrea Righi (1):
      module/decompress: use vmalloc() for zstd decompression workspace

Eric Dumazet (1):
      ipv6: remove hard coded limitation on ipv6_pinfo

Greg Kroah-Hartman (1):
      Linux 6.5.1

Helge Deller (1):
      lockdep: fix static memory detection even more

James Morse (3):
      module: Expose module_init_layout_section()
      arm64: module: Use module_init_layout_section() to spot init sections
      ARM: module: Use module_init_layout_section() to spot init sections

Mario Limonciello (1):
      ACPI: thermal: Drop nocrt parameter

Yonghong Song (1):
      kallsyms: Fix kallsyms_selftest failure

