Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121C87D9EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 19:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjJ0R3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 13:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJ0R3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 13:29:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D231A7;
        Fri, 27 Oct 2023 10:29:41 -0700 (PDT)
Date:   Fri, 27 Oct 2023 17:29:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698427780;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wQJqYXMW2moOS45RHVT2qsmb5awF4V+QT9kX/RK5zSk=;
        b=Rv6SaXUdodc0STIxE9UiLpy5P05dY12vb7mbRhKRj6YTff73BXQ0K4MU9W9AG2zRcWGuDq
        okXAvPc7v9F77nvthuJi6GIfLHgRFHBKTUuPSRYRwlRge2Z+7jNuF7T9N3H2nxRjjFbKhO
        8VeCXnZsbs8tsirrOq5gRENBENHwwI6jKBS00E2lrBUbMGj2EutIkDTUG2lVbFh0gnGLal
        XmAO4KRNfvBzkmwEWrY9zGpxMw9C56olcTdecbgs6rjibuJSbuGdCB7buajXYB1bzVRQPG
        /O7ZEpMisT2jWbkVaB7BMOWfhDqYh5NnxQEHGyvUQtjmxhGexP0eUxlSZe444A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698427780;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wQJqYXMW2moOS45RHVT2qsmb5awF4V+QT9kX/RK5zSk=;
        b=U1Sh4cO9+zWCEjrSIfpj94gZOHOJgFxe0GdhLseVNePAHZU4u/OZSUxjQusT6E3tKHoTv3
        PORBBqf5wA1QWPDg==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Add model number for Intel Arrow Lake
 mobile processor
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169842777946.3135.756599551051775625.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b99d70c0d1380f1368fd4a82271280c4fd28558b
Gitweb:        https://git.kernel.org/tip/b99d70c0d1380f1368fd4a82271280c4fd28558b
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 25 Oct 2023 13:25:13 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 27 Oct 2023 10:19:26 -07:00

x86/cpu: Add model number for Intel Arrow Lake mobile processor

For "reasons" Intel has code-named this CPU with a "_H" suffix.

[ dhansen: As usual, apply this and send it upstream quickly to
	   make it easier for anyone who is doing work that
	   consumes this. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20231025202513.12358-1-tony.luck%40intel.com
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 5fcd85f..1973161 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -27,6 +27,7 @@
  *		_X	- regular server parts
  *		_D	- micro server parts
  *		_N,_P	- other mobile parts
+ *		_H	- premium mobile parts
  *		_S	- other client parts
  *
  *		Historical OPTDIFFs:
@@ -124,6 +125,7 @@
 #define INTEL_FAM6_METEORLAKE		0xAC
 #define INTEL_FAM6_METEORLAKE_L		0xAA
 
+#define INTEL_FAM6_ARROWLAKE_H		0xC5
 #define INTEL_FAM6_ARROWLAKE		0xC6
 
 #define INTEL_FAM6_LUNARLAKE_M		0xBD
