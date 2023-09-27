Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4587AFD8A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjI0IEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjI0IEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:04:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300F5BF;
        Wed, 27 Sep 2023 01:04:28 -0700 (PDT)
Date:   Wed, 27 Sep 2023 08:04:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695801867;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6y4/x56gepc6BHyqsAM4Ueox9yfbDdfnwV5Rb7kalmc=;
        b=ed1X0SRmdE5ubj1DS54klTu122q/zgYbeX1W55si6TaDBwdI/rvds6+UO3UsuslblxlIRU
        18SnbTLBbsT0if4pxP9NJNNJF3N9FLjvjDo/T41Mv8amwLf4EUivSOQEoGIFx3dmSIuwot
        a1O469gVVXjNHZfBzQZZ8f6qsooX0KLV9qcbzbJRBgtK60tS+CFUsAl8fBd18JOUZPoKol
        irCkWkSY89aeHD8Z0HDuDBBKTTmMtNtae6gfzC6eYmSwPcwUDe/cR2mr/jFO5hEwmPEeyH
        bqi4aGGVcPageakXg13v6OM1WIoCpNhh9sv7neFrLzKj8hww5TgZhd6ww3J9XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695801867;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6y4/x56gepc6BHyqsAM4Ueox9yfbDdfnwV5Rb7kalmc=;
        b=1ASpo4EyjBRB36zgcBSEfxUNjzEW24Npry1n3o38gHzKClv53g9MIb990wTgZdDd327zIN
        DI9+p8skCQpF9gCg==
From:   "tip-bot2 for Muralidhara M K" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/amd_nb: Add AMD Family MI300 PCI IDs
Cc:     Muralidhara M K <muralidhara.mk@amd.com>,
        Suma Hegde <suma.hegde@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230926051932.193239-1-suma.hegde@amd.com>
References: <20230926051932.193239-1-suma.hegde@amd.com>
MIME-Version: 1.0
Message-ID: <169580186617.27769.8445368377007522193.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     24775700eaa93ff83b2a0f1e005879cdf186cdd9
Gitweb:        https://git.kernel.org/tip/24775700eaa93ff83b2a0f1e005879cdf186cdd9
Author:        Muralidhara M K <muralidhara.mk@amd.com>
AuthorDate:    Tue, 26 Sep 2023 05:19:32 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 27 Sep 2023 09:53:23 +02:00

x86/amd_nb: Add AMD Family MI300 PCI IDs

Add new Root, Device 18h Function 3, and Function 4 PCI IDS
for AMD F19h Model 90h-9fh (MI300A).

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Suma Hegde <suma.hegde@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20230926051932.193239-1-suma.hegde@amd.com
---
 arch/x86/kernel/amd_nb.c | 5 +++++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 356de95..10c2a3c 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -27,6 +27,7 @@
 #define PCI_DEVICE_ID_AMD_1AH_M00H_ROOT		0x153a
 #define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT		0x1507
 #define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
+#define PCI_DEVICE_ID_AMD_MI300_ROOT		0x14f8
 
 #define PCI_DEVICE_ID_AMD_17H_DF_F4		0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4	0x15ec
@@ -43,6 +44,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4	0x12fc
 #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4	0x12c4
 #define PCI_DEVICE_ID_AMD_MI200_DF_F4		0x14d4
+#define PCI_DEVICE_ID_AMD_MI300_DF_F4		0x152c
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
@@ -62,6 +64,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_ROOT) },
 	{}
 };
 
@@ -93,6 +96,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F3) },
 	{}
 };
 
@@ -115,6 +119,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F4) },
 	{}
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 5fb3d4c..91b457d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -579,6 +579,7 @@
 #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
 #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
 #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
+#define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
