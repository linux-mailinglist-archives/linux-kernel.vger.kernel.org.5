Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A69475FD9E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjGXR1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjGXR1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:27:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FA8171E;
        Mon, 24 Jul 2023 10:27:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFF65612BB;
        Mon, 24 Jul 2023 17:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCD2C433C7;
        Mon, 24 Jul 2023 17:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690219622;
        bh=++SXms1vEgkhw/IzoTil2GzcRHERnDX5V8AvE7kLwKE=;
        h=From:To:Cc:Subject:Date:From;
        b=OQ6eDPVbp7EEtc9Bi6yKjicfK+lZuPye7aa7gnNiMiizNzhf3lLfD1pbC6hqdPjzQ
         KyYnIR4TSvtstWfMAv346oFMoBArQn/EI9DYsWKjNeIYVhNiys0AXwnBqaRPxeB9gW
         cGuryXeV2xHZRV2F55QAgg8U/u+ll+1nMa2xi16s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.250
Date:   Mon, 24 Jul 2023 19:26:57 +0200
Message-ID: <2023072435-lens-sway-7bd4@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.4.250 kernel.

All AMD processor users of the 5.4 kernel series who have not updated
their microcode to the latest version, must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
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
      Linux 5.4.250

