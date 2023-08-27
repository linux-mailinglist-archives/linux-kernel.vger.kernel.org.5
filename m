Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9770778A126
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 21:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjH0T05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 15:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjH0T0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 15:26:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A86C11C;
        Sun, 27 Aug 2023 12:26:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 945E8611E1;
        Sun, 27 Aug 2023 19:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A631C433C7;
        Sun, 27 Aug 2023 19:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693164406;
        bh=MbeLPuFocdUcHzP4M3CVtCHRjrPeO7aYvrSSD54hW20=;
        h=From:To:Cc:Subject:Date:From;
        b=lJ04moVF4IoxhVfltmflQ61rgFL9iNYf6n5sQMXFokvT/bNr4VMxLX9neBi7r4u+h
         D2qP5ljO/3d29qaAgTwmmkSvovPjoHl/d2Ga0XrI3Iv6u8uDTjZdF3n41sMHUj1X3D
         dN8g0wBj/H8vaJMLigYjE38V626nZoCGNHEmZsRI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.49
Date:   Sun, 27 Aug 2023 21:26:40 +0200
Message-ID: <2023082706-region-directly-f70e@gregkh>
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

I'm announcing the release of the 6.1.49 kernel.

This upgrade is only for all users of the 6.1 series that use the x86
platform OR the F2FS file system.  If that's not you, feel free to
ignore this release.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                             |    2 -
 fs/f2fs/f2fs.h                       |    1 
 fs/f2fs/file.c                       |    5 ++++
 fs/f2fs/node.c                       |   14 +----------
 fs/f2fs/super.c                      |   43 +++++++++++------------------------
 include/linux/f2fs_fs.h              |    1 
 tools/objtool/arch/x86/decode.c      |   11 +++++---
 tools/objtool/check.c                |   22 +++++++++++++++++
 tools/objtool/include/objtool/arch.h |    1 
 tools/objtool/include/objtool/elf.h  |    1 
 10 files changed, 53 insertions(+), 48 deletions(-)

Greg Kroah-Hartman (4):
      Revert "f2fs: don't reset unchangable mount option in f2fs_remount()"
      Revert "f2fs: fix to set flush_merge opt and show noflush_merge"
      Revert "f2fs: fix to do sanity check on direct node in truncate_dnode()"
      Linux 6.1.49

Peter Zijlstra (1):
      objtool/x86: Fix SRSO mess

