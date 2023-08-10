Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A521B7773DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjHJJMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbjHJJMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:12:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BB32D41;
        Thu, 10 Aug 2023 02:11:51 -0700 (PDT)
Date:   Thu, 10 Aug 2023 09:11:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691658709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wbHqOPk2/yiSChbdPOzzvXoAC/GkjKH88GPUYa8JmZQ=;
        b=j0SC22lz7O+Mlv1yuTI5kWOudz93EIAKeuI1xYuR07wPcWu0t/Wakdhp8+i3YChNQ6qC4K
        cLHdL2rVWANRPhKJxCPagkUj93Q0dB5mXqOB36ik1SCA30WgJGQrfIeNySpd3yGUHE7JgR
        yklgEs1s2J3DVjOnP9Qsa5l82coHgq3yUUIrUwUy3dGDUc9HhpQ2bpdlJipP1xwfQT8gf8
        w+/CFCJqkOV6M/PRZoBDCLcMMuWpxrfsfyS6Y1jnkht2Z/wAirMwqEWrErdLOh9ZkBN48c
        wEa/pa9Nth3MWwOm5YT6F112Y1dnL7P9JhVD44qyI7I4YMQoWybExxp1FwfRSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691658709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wbHqOPk2/yiSChbdPOzzvXoAC/GkjKH88GPUYa8JmZQ=;
        b=sHNEOi3ABW7QnV7UsNi/l4Ru/LCRWDtkX8Eo+jDjaHGtInvV8Gg+Auy5Cpbaue+SpRiJrX
        H0lDO6mCIK2yuqDg==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] Documentation/srso: Document IBPB aspect and fix formatting
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230809102700.29449-4-bp@alien8.de>
References: <20230809102700.29449-4-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <169165870858.27769.6109573007133258930.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     09f9f37c324d90102e8574856ab168c34de1916d
Gitweb:        https://git.kernel.org/tip/09f9f37c324d90102e8574856ab168c34de1916d
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 02 Aug 2023 20:07:32 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 10 Aug 2023 11:03:12 +02:00

Documentation/srso: Document IBPB aspect and fix formatting

Add a note about the dependency of the User->User mitigation on the
previous Spectre v2 IBPB selection.

Make the layout moar pretty.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20230809102700.29449-4-bp@alien8.de
---
 Documentation/admin-guide/hw-vuln/srso.rst | 71 +++++++++++++--------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/srso.rst b/Documentation/admin-guide/hw-vuln/srso.rst
index 32eb5e6..af59a93 100644
--- a/Documentation/admin-guide/hw-vuln/srso.rst
+++ b/Documentation/admin-guide/hw-vuln/srso.rst
@@ -42,42 +42,59 @@ The sysfs file showing SRSO mitigation status is:
 
 The possible values in this file are:
 
- - 'Not affected'               The processor is not vulnerable
+ * 'Not affected':
 
- - 'Vulnerable: no microcode'   The processor is vulnerable, no
-                                microcode extending IBPB functionality
-                                to address the vulnerability has been
-                                applied.
+   The processor is not vulnerable
 
- - 'Mitigation: microcode'      Extended IBPB functionality microcode
-                                patch has been applied. It does not
-                                address User->Kernel and Guest->Host
-                                transitions protection but it does
-                                address User->User and VM->VM attack
-                                vectors.
+ * 'Vulnerable: no microcode':
 
-                                (spec_rstack_overflow=microcode)
+   The processor is vulnerable, no microcode extending IBPB
+   functionality to address the vulnerability has been applied.
 
- - 'Mitigation: safe RET'       Software-only mitigation. It complements
-                                the extended IBPB microcode patch
-                                functionality by addressing User->Kernel 
-                                and Guest->Host transitions protection.
+ * 'Mitigation: microcode':
 
-                                Selected by default or by
-                                spec_rstack_overflow=safe-ret
+   Extended IBPB functionality microcode patch has been applied. It does
+   not address User->Kernel and Guest->Host transitions protection but it
+   does address User->User and VM->VM attack vectors.
 
- - 'Mitigation: IBPB'           Similar protection as "safe RET" above
-                                but employs an IBPB barrier on privilege
-                                domain crossings (User->Kernel,
-                                Guest->Host).
+   Note that User->User mitigation is controlled by how the IBPB aspect in
+   the Spectre v2 mitigation is selected:
 
-                                (spec_rstack_overflow=ibpb)
+    * conditional IBPB:
+
+      where each process can select whether it needs an IBPB issued
+      around it PR_SPEC_DISABLE/_ENABLE etc, see :doc:`spectre`
+
+    * strict:
+
+      i.e., always on - by supplying spectre_v2_user=on on the kernel
+      command line
+
+   (spec_rstack_overflow=microcode)
+
+ * 'Mitigation: safe RET':
+
+   Software-only mitigation. It complements the extended IBPB microcode
+   patch functionality by addressing User->Kernel and Guest->Host
+   transitions protection.
+
+   Selected by default or by spec_rstack_overflow=safe-ret
+
+ * 'Mitigation: IBPB':
+
+   Similar protection as "safe RET" above but employs an IBPB barrier on
+   privilege domain crossings (User->Kernel, Guest->Host).
+
+  (spec_rstack_overflow=ibpb)
+
+ * 'Mitigation: IBPB on VMEXIT':
+
+   Mitigation addressing the cloud provider scenario - the Guest->Host
+   transitions only.
+
+   (spec_rstack_overflow=ibpb-vmexit)
 
- - 'Mitigation: IBPB on VMEXIT' Mitigation addressing the cloud provider
-                                scenario - the Guest->Host transitions
-                                only.
 
-                                (spec_rstack_overflow=ibpb-vmexit)
 
 In order to exploit vulnerability, an attacker needs to:
 
