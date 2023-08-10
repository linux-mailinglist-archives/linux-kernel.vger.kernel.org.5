Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E8877788C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbjHJMfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjHJMfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:35:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4397213F;
        Thu, 10 Aug 2023 05:35:08 -0700 (PDT)
Date:   Thu, 10 Aug 2023 12:35:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691670907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mN7Z+flaS0yAXVVR8ATHPLhCN6Pf3GQ3UZ3YZUXZQ68=;
        b=GuiQtS1saG8HdcwTOecl8j8zPzc5EGUxCKIqPpeeCAG22iD+2iERXRlYqrEZartGZn6Las
        qyK1KGWohyZG/DaObB/o5KtgtvHto8KbORQGRZw/qd6aJofTWBvEczcUtxI6vWgrS9DRhi
        BhRqmohNXigZtgtc2De140bRLjlnZ8A+UHXeFNJU86Jzv9IGRsu+0pWYgeCboo+1lDDrn0
        qgEsF+2cZ2uejY3sSCvfETzch6yAOv+tD3q3n7A0d79FgT9VqOZbWxN8MI+A8JzNO6pWOJ
        3G4dWAiJ3MO+qLrc5ssTGoTFsJegomq0HN96/a9HHGxSIho79uJKXc+gphflbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691670907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mN7Z+flaS0yAXVVR8ATHPLhCN6Pf3GQ3UZ3YZUXZQ68=;
        b=aVKLjAV62nAnIaop8bTB6Ax/TmHpYlBjKlz1WmwL9GWpB0Q0ULwWAZlR9Jugeuxv0hCDit
        cNxOBABKjZp0pvCw==
From:   "tip-bot2 for Avadhut Naik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/amd_nb: Add PCI IDs for AMD Family 1Ah-based models
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Avadhut Naik <Avadhut.Naik@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230809035244.2722455-2-avadhut.naik@amd.com>
References: <20230809035244.2722455-2-avadhut.naik@amd.com>
MIME-Version: 1.0
Message-ID: <169167090661.27769.2299802216757803629.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     c64016609b6f66b753b5f37929a191477fa584c0
Gitweb:        https://git.kernel.org/tip/c64016609b6f66b753b5f37929a191477fa584c0
Author:        Avadhut Naik <Avadhut.Naik@amd.com>
AuthorDate:    Tue, 08 Aug 2023 22:52:42 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 10 Aug 2023 14:12:48 +02:00

x86/amd_nb: Add PCI IDs for AMD Family 1Ah-based models

Add new PCI Device IDs required to support AMD's new Family 1Ah-based
models 00h-1Fh, 20h and 40h-4Fh.

  [ bp: Zap a useless sentence. ]

Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230809035244.2722455-2-avadhut.naik@amd.com
---
 arch/x86/kernel/amd_nb.c | 8 ++++++++
 include/linux/pci_ids.h  | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 035a3db..356de95 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -24,6 +24,8 @@
 #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT		0x14b5
 #define PCI_DEVICE_ID_AMD_19H_M60H_ROOT		0x14d8
 #define PCI_DEVICE_ID_AMD_19H_M70H_ROOT		0x14e8
+#define PCI_DEVICE_ID_AMD_1AH_M00H_ROOT		0x153a
+#define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT		0x1507
 #define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
 
 #define PCI_DEVICE_ID_AMD_17H_DF_F4		0x1464
@@ -39,6 +41,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4	0x14e4
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4	0x14f4
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4	0x12fc
+#define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4	0x12c4
 #define PCI_DEVICE_ID_AMD_MI200_DF_F4		0x14d4
 
 /* Protect the PCI config register pairs used for SMN. */
@@ -56,6 +59,8 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
 	{}
 };
@@ -85,6 +90,8 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
 	{}
 };
@@ -106,6 +113,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
 	{}
 };
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 2dc75df..8f9a459 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -576,6 +576,8 @@
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 0x14e3
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
+#define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
+#define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
 #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
