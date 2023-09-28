Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42317B15D7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjI1IQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI1IQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:16:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44B198;
        Thu, 28 Sep 2023 01:16:45 -0700 (PDT)
Date:   Thu, 28 Sep 2023 08:16:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695889004;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C0StuuUvChvgWlQD+lOagXYdDLAMj9WWMQTI2JI1PDU=;
        b=k7aCSQ0kZYZwseKsFYAPIrCEqhKdcNc8rW8/JgL/b3rPwoWkE3U8/LFEO3D/So2qyYlpMp
        DxvnBYV5gsxG+1P2JDrdmrDF6br+Sdcnvr03fDs1MS8zZSiI1ka9YPBFcqRMfdSAV50B9g
        Q9U6O5qLSdsbemXXQ3poKFg0Qeb+P/9twyd4LfvTw+iYjyo4MUmaP3TAXdQBPBgGjfF6cy
        1tleD2T/QM+R0FoRF8us4W/fLs8uKw6A6Jd3aLR7/C8X/yQHQOYa55rn8QLQI+5Tbtuu4w
        drt0u8W7RIox0KogKkXFPex1EZsWiSSvLngVJZ7OK2LBVIUJe2WSxtUxYIxS3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695889004;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C0StuuUvChvgWlQD+lOagXYdDLAMj9WWMQTI2JI1PDU=;
        b=aQEFGGI1rVM3Aey3RhTzUeQxdWuoF0t/ZU347KwSwkC9yMCdL3xfCL7Upo0U4P3VQSCtfr
        ZV9j1PSCXzDMfVBA==
From:   "tip-bot2 for Alexey Dobriyan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Compile boot code with -std=gnu11 too
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <2058761e-12a4-4b2f-9690-3c3c1c9902a5@p183>
References: <2058761e-12a4-4b2f-9690-3c3c1c9902a5@p183>
MIME-Version: 1.0
Message-ID: <169588900363.27769.15241050401538537889.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     b3bee1e7c3f2b1b77182302c7b2131c804175870
Gitweb:        https://git.kernel.org/tip/b3bee1e7c3f2b1b77182302c7b2131c804175870
Author:        Alexey Dobriyan <adobriyan@gmail.com>
AuthorDate:    Wed, 27 Sep 2023 18:42:11 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 Sep 2023 10:11:27 +02:00

x86/boot: Compile boot code with -std=gnu11 too

Use -std=gnu11 for consistency with main kernel code.

It doesn't seem to change anything in vmlinux.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Link: https://lore.kernel.org/r/2058761e-12a4-4b2f-9690-3c3c1c9902a5@p183
---
 arch/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5bfe5ca..776331f 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -43,7 +43,7 @@ endif
 
 # How to compile the 16-bit code.  Note we always compile for -march=i386;
 # that way we can complain to the user if the CPU is insufficient.
-REALMODE_CFLAGS	:= -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
+REALMODE_CFLAGS	:= -std=gnu11 -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
 		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=none)
