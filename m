Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1687F2CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbjKUMTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjKUMS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:18:59 -0500
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D88183
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 04:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1700569135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gw3SJ//CYccv+LfEcReK3mjikYD+hKyjOkLSU+xz4JM=;
  b=RDPvXq0i3nNF4Pmw1IKlDunV1rU43IBjJ9yl9xtkGXc4WMtj+peZUzsf
   XrVR0gfvB6NiOTWUSqdSd4NpZTEPKluPiGrDAJ3lTokHrGuzxJ1MbvCc3
   v+vvU61IWn0mifj1FsEt5raFo5jdpfbau1kirBu2IQXj5vH6h7l5zy1lg
   Q=;
X-CSE-ConnectionGUID: FmN2m58OQJ6Gedl0bVHtOw==
X-CSE-MsgGUID: 1prvCd9oQ162SCnUiibNeA==
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 131026723
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.159.70
X-Policy: $RELAYED
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:47AA8aghrZVL9B4zjtlgabxkX161uBAKZh0ujC45NGQN5FlHY01je
 htvUW/QOK2CNjekL94gYdnk8h8C6pLSnNNhGgA+/ilgE3kb9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOhTraCYmYoHVMMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMRqu1iUc3lg8sspvkzsx+qyu0N8klgZmP6sS5QWHzyB94K83fsldEVOpGuG4IcbiL
 wrz5OnR1n/U+R4rFuSknt7TGqHdauePVeQmoiM+t5mK2nCulARrukoIHKN0hXNsoyeIh7hMJ
 OBl7vRcf+uL0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tQ2LRZXa03ToNuUnp22Ru00jPoDMO70adZ3VnFIlVk1DN4jSJHHBa7L+cVZzHE7gcUm8fT2P
 pRDL2A1NVKZPkwJZQ9/5JEWxY9EglHWdTFCpU3Tjq0w+2XJlyR60aT3McqTcduPLSlQth/D/
 zqcoTujWXn2MvTG0SCb2X79gdaWw3nAc4QvFbyy0PND1Qj7Kms7V0RNCArTTeOCoky5QdV3e
 0YF5ic1668o+ySDVcTnVgO1rTifowIcWtlNF/Uz7gCR4qPR70CSAW1sZiFAbNgOt8IsQzEuk
 FiTkLvBHztlsbvTTG+H7reFhTqoPG4eKmpqTSMbSBRfy9jlrps6gh/GQpBkCqHdptf8HjXth
 TSXhCw/gagDy88Ny6i/u1vAhlqEp5/MSxMd4gTMQnnj6gJ/eZ7ja4G2gXDf7PBdPMOaQ0OHs
 XwshceT9qYNAIuLmSjLR/8CdJm5t6itLjLRmxhsEoMn+jDr/GSsFb28+xkneh0vaJxdP2a0M
 QmM4Wu9+aO/IlOEaIktZt/hLP0Ik4ftGdC9XM70cv1RN80ZmBC8wM1+WaKB9zmyyBBwwP9lY
 MnzTCq6MZoN5U1aINuKqwQ1i+ZDKtgWnz+7eHwC503PPUCiTHCUU6wZF1CFc/o06qiJyC2Mr
 I4HapPXkUkGCbKgCsUyzWL1BQpSRZTcLcquw/G7i8bZelY2cI3fI6O5LUwdl3xNwP0Oy7agE
 oCVUU5E0lvv7UAr2i3TAk2PnIjHBM4lxVpiZHxEALpd8yR7CWpZxPtFJsRfkHhO3LAL8MOYu
 NFfIp/cXa0fEm+ek9nfBLGkxLFfmN2QrVrmF0KYjPIXJvaMmyShFgfYQzbS
IronPort-HdrOrdr: A9a23:CCsZV68zPzvxS5+Ly1puk+DcI+orL9Y04lQ7vn2ZHyYlFvBw9v
 rPoB1173TJYVoqMk3I+urgBEDjexzhHMVOkOws1N6ZNWHbUQ2TQb2KhrGN/9SPIUHDHkE279
 YGT0DTYueAbmSTLKzBkWuFL+o=
X-Talos-CUID: 9a23:j9e0G28UUi1SBL7nK+mVv2ARPJogLy369VWODEK0DT5jdp2JbkDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AGaz4nQyLmsX8fjhD+VjXWO7UnN+aqP22El4mncQ?=
 =?us-ascii?q?BgpDabxdbPQqcjT6RT6Zyfw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.04,215,1695700800"; 
   d="scan'208";a="131026723"
From:   Andrew Cooper <andrew.cooper3@citrix.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        <x86@vger.kernel.org>
Subject: x86/apic: Further apic::delivery_mode cleanup
Date:   Tue, 21 Nov 2023 12:18:49 +0000
Message-ID: <20231121121849.1441264-1-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231121120411.GDZVycu2OPzz8Jqq4Z@fat_crate.local>
References: <20231121120411.GDZVycu2OPzz8Jqq4Z@fat_crate.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
CC: x86@vger.kernel.org

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
