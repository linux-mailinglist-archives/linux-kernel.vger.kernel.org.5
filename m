Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E0875FDA5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjGXR1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjGXR1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:27:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D42E98;
        Mon, 24 Jul 2023 10:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE833612BB;
        Mon, 24 Jul 2023 17:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5126C433C8;
        Mon, 24 Jul 2023 17:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690219652;
        bh=rg27LVnmGo/evEgmP5AkHKj2mxyL8PsqrWC54jZubLg=;
        h=From:To:Cc:Subject:Date:From;
        b=ETGZwJLke84Ga/NWaLL5+BRPomUksl5TPUltNO63Afi9RCyH3QqvwFLHsG3rBJBmW
         aII41B3dyLvWSZ/OZfXIxW5Ee7CTQUwbxULdnLJGrR6A3F25K029DHkKXU4AopYifr
         A0iXVJ0SaxjK8Jo1t5A/mp2VXFDqm8R7ZW0Ht/ls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.289
Date:   Mon, 24 Jul 2023 19:27:27 +0200
Message-ID: <2023072408-hunchback-maximize-5cde@gregkh>
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

I'm announcing the release of the 4.19.289 kernel.

All AMD processor users of the 4.19 kernel series who have not updated
their microcode to the latest version, must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
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
      Linux 4.19.289

