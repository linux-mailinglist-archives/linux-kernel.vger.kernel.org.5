Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD8D75FD99
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjGXR0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjGXR0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:26:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DA198;
        Mon, 24 Jul 2023 10:26:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AF6A612BB;
        Mon, 24 Jul 2023 17:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49D2C433C8;
        Mon, 24 Jul 2023 17:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690219587;
        bh=PHqlLSMx5hmoD4BAcjTPzGb1tP28aLrw2FaGUs1nLmU=;
        h=From:To:Cc:Subject:Date:From;
        b=yrgpUOrZOimQSYnzRc2HIaTlnY56NKo5eEDvg1hl36jafa9Fif6Oiny/0Qk2hF1R4
         2ynmBogfw+S0tZFgkRkv1MoLmO3USj4Vvww16d81ZtLTFPzMXxHe5SW6mhBJBTPREn
         oPfCtF5wpe3UgA0/evkXsADzow05FaiHAyQU3AY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.187
Date:   Mon, 24 Jul 2023 19:26:22 +0200
Message-ID: <2023072403-tacking-esophagus-3b00@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.10.187 kernel.

All AMD processor users of the 5.10 kernel series who have not updated
their microcode to the latest version, must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                             |    2 
 arch/x86/include/asm/microcode.h     |    1 
 arch/x86/include/asm/microcode_amd.h |    2 
 arch/x86/include/asm/msr-index.h     |    1 
 arch/x86/kernel/cpu/amd.c            |  199 ++++++++++++++++++++++-------------
 arch/x86/kernel/cpu/common.c         |    2 
 arch/x86/kernel/cpu/microcode/amd.c  |    2 
 7 files changed, 135 insertions(+), 74 deletions(-)

Borislav Petkov (AMD) (3):
      x86/microcode/AMD: Load late on both threads too
      x86/cpu/amd: Move the errata checking functionality up
      x86/cpu/amd: Add a Zenbleed fix

Greg Kroah-Hartman (1):
      Linux 5.10.187

