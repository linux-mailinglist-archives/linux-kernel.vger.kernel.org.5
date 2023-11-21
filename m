Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4885C7F2D35
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbjKUMar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjKUMap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:30:45 -0500
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D20110
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 04:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1700569841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OfoVueAJlT4dRW0E9lJhs8DFNbsX126SwsKVxUZs1vM=;
  b=Hw+QBC64h14vVso/YFbot4/5HQqugvyceaaSdd79WsIsk8IPdXQ6yQi/
   TzuXKJeZ/2jPG2uHrM5JtM7NR04PbgMUH2EQtYdXAiZPto+s3iT7YyzPB
   bgCLHmoyqyfJGfoJozvQqaWZlFu4FweXPgKbGG7kc+Sz2/Tl49hFugN9F
   Q=;
X-CSE-ConnectionGUID: cz63FxWPTwKsGv/+JsD3aw==
X-CSE-MsgGUID: AlsNrc4xQm26dA3J7Mc9YQ==
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 126809421
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.159.70
X-Policy: $RELAYED
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:5Apvj6zl1a/4qeD0xe96t+fIxirEfRIJ4+MujC+fZmUNrF6WrkUGy
 GIfDGqCbvyNamPyf9AlOtni804C6pKDytdlTgQ/+CAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjPzOHvykTrecZkidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw/zF8E8HUMja4mtC5QVnP6kT5TcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KWpcq
 6c2OA81Ug+gnM2oh/GZUcU3j9t2eaEHPKtH0p1h5TTQDPJgSpHfWaTao9Rf2V/chOgXQ6yYP
 ZBAL2MyPVKfO3WjOX9OYH46tM6uimPybHtzr1WNqLBsy2PS0BZwwP7mN9+9ltmiHJ8Lzh7J+
 jifl4j/KjgeL/qFwmaVy3f22OPmxgGkfYlDJYTto5aGh3XMnzdOWXX6T2CTpfi/l177WN9FL
 UEQ0jQhoLJ090GxSNT5GRqirxasvBkGXPIAGfwm5RrLzbDbiy6CG3INUDNMLsc7qM83RiEuz
 laPns/BDDlj9raSTBq17LCerDX0PDUPNW8TTSYeSE0O5NyLiI0siw2VZtdlHrS8gtD8FXf32
 T/ihCI3gLEOy8oW/6G6+03XxTOqupXNCAUy423/X2Wg6x5RYI++e5fu7Vnd8OYGIIuHJnGev
 XwAs8uT9uYDCdeKjiPlaPVdQpmq6uyDPTmahkRgd7Er7xyk/3+ue9AW7DwWDFtmNtYsfT7vf
 VPJvgVQ9NlfMROXgbRfOtzrTZ5wlO65SIWjCai8gsdyjoZZfx3Zpw9+WnaswEP2v1Zr0oMkF
 cySbpP5ZZoFMpiL3AZaVs9EjudzmnFgnzqNLa0X2ShLxlZ3WZJ0dVvmGAHXBgzBxPnYyDg5C
 v4GXydw9z1RUfflfg7c+pMJIFYBIBATXM+u85EPK7Tfe1M5RgnN7sM9J5t7I+SJeIwPzo/1E
 oyVABcEmDITe1WbQel1VpyTQOy2BssuxZ7KFSctIUypyxAejXWHtc8im28MVeB/roRLlKckJ
 8Tpju3cWpyjvByboWVCBXQ8xaQ+HCmWafWmZXP/PGdmL8Y7HmQkOLbMJ2PSycXHNQLv3eNWn
 lFq/lqzrUYrL+i6MPvrVQ==
IronPort-HdrOrdr: A9a23:piF0vatRZjd5HolJTVmXdofB7skDTtV00zEX/kB9WHVpmszxra
 6TdZMgpHnJYVcqKQkdcL+7WJVoLUmxyXcx2/h1AV7AZniAhILLFvAA0WKK+VSJcEeSygce79
 YFT0EXMqyIMbEQt6fHCWeDfOrIuOP3kpyVuQ==
X-Talos-CUID: 9a23:I71WkG400JmlZUQbNdss/1xKQe41TUXh01TLDFH/SkRyZOacVgrF
X-Talos-MUID: =?us-ascii?q?9a23=3A6t1vTwzSTP0z8QrzsxJjyRO3wdmaqI2qE2YXmsk?=
 =?us-ascii?q?WgszeayBZYBXCqT/mc7Zyfw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.04,215,1695700800"; 
   d="scan'208";a="126809421"
From:   Andrew Cooper <andrew.cooper3@citrix.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH RESEND] x86/apic: Further apic::delivery_mode cleanup
Date:   Tue, 21 Nov 2023 12:30:34 +0000
Message-ID: <20231121123034.1442059-1-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231121120411.GDZVycu2OPzz8Jqq4Z@fat_crate.local>
References: <20231121120411.GDZVycu2OPzz8Jqq4Z@fat_crate.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fold the APIC_DELIVERY_MODE_FIXED constant in more cases now that the apic
field has disappeared.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
CC: Joerg Roedel <joro@8bytes.org>
CC: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>
CC: David Woodhouse <dwmw2@infradead.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>
CC: iommu@lists.linux.dev
CC: linux-kernel@vger.kernel.org
CC: x86@kernel.org
CC: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>

RESEND, this time with working x86 maintainer emails.

Does this want a fixes tag?  If so,

Fixes: b5148dfe66f5 ("x86/apic: Drop apic::delivery_mode")

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 95bd7c25ba6f..542b823f9827 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3311,7 +3311,7 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 
 	data->irq_2_irte.devid = devid;
 	data->irq_2_irte.index = index + sub_handle;
-	iommu->irte_ops->prepare(data->entry, apic->delivery_mode,
+	iommu->irte_ops->prepare(data->entry, APIC_DELIVERY_MODE_FIXED,
 				 apic->dest_mode_logical, irq_cfg->vector,
 				 irq_cfg->dest_apicid, devid);
 
@@ -3588,7 +3588,7 @@ int amd_iommu_deactivate_guest_mode(void *data)
 
 	entry->lo.fields_remap.valid       = valid;
 	entry->lo.fields_remap.dm          = apic->dest_mode_logical;
-	entry->lo.fields_remap.int_type    = apic->delivery_mode;
+	entry->lo.fields_remap.int_type    = APIC_DELIVERY_MODE_FIXED;
 	entry->hi.fields.vector            = cfg->vector;
 	entry->lo.fields_remap.destination =
 				APICID_TO_IRTE_DEST_LO(cfg->dest_apicid);
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 29b9e55dcf26..566297bc87dd 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1112,7 +1112,7 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	 * irq migration in the presence of interrupt-remapping.
 	*/
 	irte->trigger_mode = 0;
-	irte->dlvry_mode = apic->delivery_mode;
+	irte->dlvry_mode = APIC_DELIVERY_MODE_FIXED;
 	irte->vector = vector;
 	irte->dest_id = IRTE_DEST(dest);
 	irte->redir_hint = 1;
