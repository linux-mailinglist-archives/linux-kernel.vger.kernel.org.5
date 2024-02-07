Return-Path: <linux-kernel+bounces-56037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7A184C534
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8525E1F27173
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8FD1F944;
	Wed,  7 Feb 2024 06:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MFygSAaW"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86C41CF83;
	Wed,  7 Feb 2024 06:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707288772; cv=none; b=eK1ycVyBNBdpgTMt75wvHvo37KYnzH+hBwSrdYqHvPAJhp5apJLPLbSiSYxHrvrzDMW2WMTOrNTX5yeIwN4+FIaUXkLGVtxSWMbKC7AEGtqi10Rg9nx5VvEM/uPjhK+0m3h52uaS+O8Qr43mMHEC6pBht/m4m4CnRWnvsOhTe2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707288772; c=relaxed/simple;
	bh=Yvi5i+DggrMOtMot1KD8tskX0RhjqDBvK9HivwFt15w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTi7NLaKp5y9JyFCNMFoDrHCp6Z9Mdh3kGVggs4nE8orR5+7Z4RSLdii3AcdS1O0ARu4gjsCZ+5P+CKoV2rdH1unWJt8wV02AdA2+WZ2i/6I6emBobzcofIfkqugvPo6y4DCMJqJFasjxLFeHqUP8gNS6Eh9gEBuuAiy9ADydqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MFygSAaW; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4170d23P007453;
	Tue, 6 Feb 2024 22:52:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=7OJhclbYCFLl12r4IFVzadotlffPUu8jCvd8HD91nFA=; b=MFy
	gSAaW4UPnuZz6r2wdVGidiYZ9ez+OwNTdVwsj9keT2YWaz1A2hkB5BKQ7B2ji5+x
	TxDqJrbMdnyu0YChh9hfpSbRlP0Ec9ixIEOunYrsnJj8Y8/8iofyCsJlWptpYl5D
	kCbWIWyLJ/laP9D8NJQfWo47Cc+ojSwWoWugzxKmfSxLJ4k8VwGzQPQayz7pZJdK
	F9zdYLc0V55+uXlYdIalTe/mJXQM1gKuPZUKelmcx06V/qI4mz8J7jpFuuU8kGlQ
	fBwPZmCNuZMLfmqgw5kyYeRhQLowqXSnj3KVzMnL2Uydg5V5QBtJ7A2c0jY26jWj
	mfdXpmaark/hLmiof5A==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3w38u85xx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 22:52:38 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 6 Feb
 2024 22:52:36 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 6 Feb 2024 22:52:36 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 197D63F7082;
	Tue,  6 Feb 2024 22:52:36 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <sedara@marvell.com>,
        <srasheed@marvell.com>, <egallen@redhat.com>, <mschmidt@redhat.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <horms@kernel.org>,
        <wizhao@redhat.com>, <kheib@redhat.com>, <konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda Burla
	<sburla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>
Subject: [PATCH net-next v6 2/8] octeon_ep_vf: add hardware configuration APIs
Date: Tue, 6 Feb 2024 22:52:01 -0800
Message-ID: <20240207065207.3092004-3-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240207065207.3092004-1-srasheed@marvell.com>
References: <20240207065207.3092004-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KUGy_MoYXEMV9TE5CftSMwTdwuiBxgBc
X-Proofpoint-GUID: KUGy_MoYXEMV9TE5CftSMwTdwuiBxgBc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_16,2024-01-31_01,2023-05-22_02

Implement hardware resource init and shutdown helper APIs, like
hardware Tx/Rx queue init/enable/disable/reset.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V6:
  - Removed return statements in void functions

V5: https://lore.kernel.org/all/20240129050254.3047778-3-srasheed@marvell.com/
  - Changed unchecked int return type of functions to void and removed
    unnecessary initializations.

V4: https://lore.kernel.org/all/20240108124213.2966536-3-srasheed@marvell.com/
  - No changes

V3: https://lore.kernel.org/all/20240105203823.2953604-3-srasheed@marvell.com/
  - Replaced masks and ULL declarations with GENMASK_ULL(), ULL() and
    other linux/bits.h macros
  - Corrected declarations to conform to xmas tree format

V2: https://lore.kernel.org/all/20231223134000.2906144-3-srasheed@marvell.com/
  - No changes

V1: https://lore.kernel.org/all/20231221092844.2885872-3-srasheed@marvell.com/

 .../marvell/octeon_ep_vf/octep_vf_cn9k.c      | 335 ++++++++++++++++-
 .../marvell/octeon_ep_vf/octep_vf_cnxk.c      | 345 +++++++++++++++++-
 2 files changed, 678 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
index c24ef2265205..8048ac7a8715 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
@@ -13,9 +13,124 @@
 #include "octep_vf_main.h"
 #include "octep_vf_regs_cn9k.h"
 
+/* Dump useful hardware IQ/OQ CSRs for debug purpose */
+static void cn93_vf_dump_q_regs(struct octep_vf_device *oct, int qno)
+{
+	struct device *dev = &oct->pdev->dev;
+
+	dev_info(dev, "IQ-%d register dump\n", qno);
+	dev_info(dev, "R[%d]_IN_INSTR_DBELL[0x%llx]: 0x%016llx\n",
+		 qno, CN93_VF_SDP_R_IN_INSTR_DBELL(qno),
+		 octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_INSTR_DBELL(qno)));
+	dev_info(dev, "R[%d]_IN_CONTROL[0x%llx]: 0x%016llx\n",
+		 qno, CN93_VF_SDP_R_IN_CONTROL(qno),
+		 octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_CONTROL(qno)));
+	dev_info(dev, "R[%d]_IN_ENABLE[0x%llx]: 0x%016llx\n",
+		 qno, CN93_VF_SDP_R_IN_ENABLE(qno),
+		 octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_ENABLE(qno)));
+	dev_info(dev, "R[%d]_IN_INSTR_BADDR[0x%llx]: 0x%016llx\n",
+		 qno, CN93_VF_SDP_R_IN_INSTR_BADDR(qno),
+		 octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_INSTR_BADDR(qno)));
+	dev_info(dev, "R[%d]_IN_INSTR_RSIZE[0x%llx]: 0x%016llx\n",
+		 qno, CN93_VF_SDP_R_IN_INSTR_RSIZE(qno),
+		 octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_INSTR_RSIZE(qno)));
+	dev_info(dev, "R[%d]_IN_CNTS[0x%llx]: 0x%016llx\n",
+		 qno, CN93_VF_SDP_R_IN_CNTS(qno),
+		 octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_CNTS(qno)));
+	dev_info(dev, "R[%d]_IN_INT_LEVELS[0x%llx]: 0x%016llx\n",
+		 qno, CN93_VF_SDP_R_IN_INT_LEVELS(qno),
+		 octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_INT_LEVELS(qno)));
+	dev_info(dev, "R[%d]_IN_PKT_CNT[0x%llx]: 0x%016llx\n",
+		 qno, CN93_VF_SDP_R_IN_PKT_CNT(qno),
+		 octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_PKT_CNT(qno)));
+	dev_info(dev, "R[%d]_IN_BYTE_CNT[0x%llx]: 0x%016llx\n",
+		 qno, CN93_VF_SDP_R_IN_BYTE_CNT(qno),
+		 octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_BYTE_CNT(qno)));
+
+	dev_info(dev, "OQ-%d register dump\n", qno);
+	dev_info(dev, "R[%d]_OUT_SLIST_DBELL[0x%llx]: 0x%016llx\n",
+		 qno, CN93_VF_SDP_R_OUT_SLIST_DBELL(qno),
+		 octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_SLIST_DBELL(qno)));
+	dev_info(dev, "R[%d]_OUT_CONTROL[0x%llx]: 0x%016llx\n",
+		 qno, CN93_VF_SDP_R_OUT_CONTROL(qno),
+		 octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_CONTROL(qno)));
+	dev_info(dev, "R[%d]_OUT_ENABLE[0x%llx]: 0x%016llx\n",
+		 qno, CN93_VF_SDP_R_OUT_ENABLE(qno),
+		 octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_ENABLE(qno)));
+	dev_info(dev, "R[%d]_OUT_SLIST_BADDR[0x%llx]: 0x%016llx\n",
+		 qno, CN93_VF_SDP_R_OUT_SLIST_BADDR(qno),
+		 octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_SLIST_BADDR(qno)));
+	dev_info(dev, "R[%d]_OUT_SLIST_RSIZE[0x%llx]: 0x%016llx\n",
+		 qno, CN93_VF_SDP_R_OUT_SLIST_RSIZE(qno),
+		 octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_SLIST_RSIZE(qno)));
+	dev_info(dev, "R[%d]_OUT_CNTS[0x%llx]: 0x%016llx\n",
+		 qno, CN93_VF_SDP_R_OUT_CNTS(qno),
+		 octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_CNTS(qno)));
+	dev_info(dev, "R[%d]_OUT_INT_LEVELS[0x%llx]: 0x%016llx\n",
+		 qno, CN93_VF_SDP_R_OUT_INT_LEVELS(qno),
+		 octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_INT_LEVELS(qno)));
+	dev_info(dev, "R[%d]_OUT_PKT_CNT[0x%llx]: 0x%016llx\n",
+		 qno, CN93_VF_SDP_R_OUT_PKT_CNT(qno),
+		 octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_PKT_CNT(qno)));
+	dev_info(dev, "R[%d]_OUT_BYTE_CNT[0x%llx]: 0x%016llx\n",
+		 qno, CN93_VF_SDP_R_OUT_BYTE_CNT(qno),
+		 octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_BYTE_CNT(qno)));
+}
+
+/* Reset Hardware Tx queue */
+static void cn93_vf_reset_iq(struct octep_vf_device *oct, int q_no)
+{
+	u64 val = ULL(0);
+
+	dev_dbg(&oct->pdev->dev, "Reset VF IQ-%d\n", q_no);
+
+	/* Disable the Tx/Instruction Ring */
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_ENABLE(q_no), val);
+
+	/* clear the Instruction Ring packet/byte counts and doorbell CSRs */
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INT_LEVELS(q_no), val);
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_PKT_CNT(q_no), val);
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_BYTE_CNT(q_no), val);
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INSTR_BADDR(q_no), val);
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INSTR_RSIZE(q_no), val);
+
+	val = GENMASK_ULL(31, 0);
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INSTR_DBELL(q_no), val);
+
+	val = octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_CNTS(q_no));
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_CNTS(q_no),
+			     val & GENMASK_ULL(31, 0));
+
+}
+
+/* Reset Hardware Rx queue */
+static void cn93_vf_reset_oq(struct octep_vf_device *oct, int q_no)
+{
+	u64 val = ULL(0);
+
+	/* Disable Output (Rx) Ring */
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_ENABLE(q_no), val);
+
+	/* Clear count CSRs */
+	val = octep_vf_read_csr(oct, CN93_VF_SDP_R_OUT_CNTS(q_no));
+	octep_vf_write_csr(oct, CN93_VF_SDP_R_OUT_CNTS(q_no), val);
+
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_PKT_CNT(q_no), GENMASK_ULL(35, 0));
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_SLIST_DBELL(q_no), GENMASK_ULL(31, 0));
+}
+
 /* Reset all hardware Tx/Rx queues */
 static void octep_vf_reset_io_queues_cn93(struct octep_vf_device *oct)
 {
+	struct pci_dev *pdev = oct->pdev;
+	int q;
+
+	dev_dbg(&pdev->dev, "Reset OCTEP_CN93 VF IO Queues\n");
+
+	for (q = 0; q < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); q++) {
+		cn93_vf_reset_iq(oct, q);
+		cn93_vf_reset_oq(oct, q);
+	}
 }
 
 /* Initialize configuration limits and initial active config */
@@ -46,78 +161,296 @@ static void octep_vf_init_config_cn93_vf(struct octep_vf_device *oct)
 /* Setup registers for a hardware Tx Queue  */
 static void octep_vf_setup_iq_regs_cn93(struct octep_vf_device *oct, int iq_no)
 {
+	struct octep_vf_iq *iq = oct->iq[iq_no];
+	u32 reset_instr_cnt;
+	u64 reg_val;
+
+	reg_val = octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_CONTROL(iq_no));
+
+	/* wait for IDLE to set to 1 */
+	if (!(reg_val & CN93_VF_R_IN_CTL_IDLE)) {
+		do {
+			reg_val = octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_CONTROL(iq_no));
+		} while (!(reg_val & CN93_VF_R_IN_CTL_IDLE));
+	}
+	reg_val |= CN93_VF_R_IN_CTL_RDSIZE;
+	reg_val |= CN93_VF_R_IN_CTL_IS_64B;
+	reg_val |= CN93_VF_R_IN_CTL_ESR;
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_CONTROL(iq_no), reg_val);
+
+	/* Write the start of the input queue's ring and its size  */
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INSTR_BADDR(iq_no), iq->desc_ring_dma);
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INSTR_RSIZE(iq_no), iq->max_count);
+
+	/* Remember the doorbell & instruction count register addr for this queue */
+	iq->doorbell_reg = oct->mmio.hw_addr + CN93_VF_SDP_R_IN_INSTR_DBELL(iq_no);
+	iq->inst_cnt_reg = oct->mmio.hw_addr + CN93_VF_SDP_R_IN_CNTS(iq_no);
+	iq->intr_lvl_reg = oct->mmio.hw_addr + CN93_VF_SDP_R_IN_INT_LEVELS(iq_no);
+
+	/* Store the current instruction counter (used in flush_iq calculation) */
+	reset_instr_cnt = readl(iq->inst_cnt_reg);
+	writel(reset_instr_cnt, iq->inst_cnt_reg);
+
+	/* INTR_THRESHOLD is set to max(FFFFFFFF) to disable the INTR */
+	reg_val = CFG_GET_IQ_INTR_THRESHOLD(oct->conf) & GENMASK_ULL(31, 0);
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INT_LEVELS(iq_no), reg_val);
 }
 
 /* Setup registers for a hardware Rx Queue  */
 static void octep_vf_setup_oq_regs_cn93(struct octep_vf_device *oct, int oq_no)
 {
+	struct octep_vf_oq *oq = oct->oq[oq_no];
+	u32 time_threshold = 0;
+	u64 oq_ctl = ULL(0);
+	u64 reg_val;
+
+	reg_val = octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_CONTROL(oq_no));
+
+	/* wait for IDLE to set to 1 */
+	if (!(reg_val & CN93_VF_R_OUT_CTL_IDLE)) {
+		do {
+			reg_val = octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_CONTROL(oq_no));
+		} while (!(reg_val & CN93_VF_R_OUT_CTL_IDLE));
+	}
+
+	reg_val &= ~(CN93_VF_R_OUT_CTL_IMODE);
+	reg_val &= ~(CN93_VF_R_OUT_CTL_ROR_P);
+	reg_val &= ~(CN93_VF_R_OUT_CTL_NSR_P);
+	reg_val &= ~(CN93_VF_R_OUT_CTL_ROR_I);
+	reg_val &= ~(CN93_VF_R_OUT_CTL_NSR_I);
+	reg_val &= ~(CN93_VF_R_OUT_CTL_ES_I);
+	reg_val &= ~(CN93_VF_R_OUT_CTL_ROR_D);
+	reg_val &= ~(CN93_VF_R_OUT_CTL_NSR_D);
+	reg_val &= ~(CN93_VF_R_OUT_CTL_ES_D);
+	reg_val |= (CN93_VF_R_OUT_CTL_ES_P);
+
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_CONTROL(oq_no), reg_val);
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_SLIST_BADDR(oq_no), oq->desc_ring_dma);
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_SLIST_RSIZE(oq_no), oq->max_count);
+
+	oq_ctl = octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_CONTROL(oq_no));
+	oq_ctl &= ~GENMASK_ULL(22, 0);	//clear the ISIZE and BSIZE (22-0)
+	oq_ctl |= (oq->buffer_size & GENMASK_ULL(15, 0));	//populate the BSIZE (15-0)
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_CONTROL(oq_no), oq_ctl);
+
+	/* Get the mapped address of the pkt_sent and pkts_credit regs */
+	oq->pkts_sent_reg = oct->mmio.hw_addr + CN93_VF_SDP_R_OUT_CNTS(oq_no);
+	oq->pkts_credit_reg = oct->mmio.hw_addr + CN93_VF_SDP_R_OUT_SLIST_DBELL(oq_no);
+
+	time_threshold = CFG_GET_OQ_INTR_TIME(oct->conf);
+	reg_val = ((u64)time_threshold << 32) | CFG_GET_OQ_INTR_PKT(oct->conf);
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_INT_LEVELS(oq_no), reg_val);
 }
 
 /* Setup registers for a VF mailbox */
 static void octep_vf_setup_mbox_regs_cn93(struct octep_vf_device *oct, int q_no)
 {
+	struct octep_vf_mbox *mbox = oct->mbox;
+
+	/* PF to VF DATA reg. VF reads from this reg */
+	mbox->mbox_read_reg = oct->mmio.hw_addr + CN93_VF_SDP_R_MBOX_PF_VF_DATA(q_no);
+
+	/* VF mbox interrupt reg */
+	mbox->mbox_int_reg = oct->mmio.hw_addr + CN93_VF_SDP_R_MBOX_PF_VF_INT(q_no);
+
+	/* VF to PF DATA reg. VF writes into this reg */
+	mbox->mbox_write_reg = oct->mmio.hw_addr + CN93_VF_SDP_R_MBOX_VF_PF_DATA(q_no);
+}
+
+/* Mailbox Interrupt handler */
+static void cn93_handle_vf_mbox_intr(struct octep_vf_device *oct)
+{
+	if (oct->mbox)
+		schedule_work(&oct->mbox->wk.work);
+	else
+		dev_err(&oct->pdev->dev, "cannot schedule work on invalid mbox\n");
 }
 
 /* Tx/Rx queue interrupt handler */
 static irqreturn_t octep_vf_ioq_intr_handler_cn93(void *data)
 {
+	struct octep_vf_ioq_vector *vector = data;
+	struct octep_vf_device *oct;
+	struct octep_vf_oq *oq;
+	u64 reg_val;
+
+	oct = vector->octep_vf_dev;
+	oq = vector->oq;
+	/* Mailbox interrupt arrives along with interrupt of tx/rx ring pair 0 */
+	if (oq->q_no == 0) {
+		reg_val = octep_vf_read_csr64(oct, CN93_VF_SDP_R_MBOX_PF_VF_INT(0));
+		if (reg_val & CN93_VF_SDP_R_MBOX_PF_VF_INT_STATUS) {
+			cn93_handle_vf_mbox_intr(oct);
+			octep_vf_write_csr64(oct, CN93_VF_SDP_R_MBOX_PF_VF_INT(0), reg_val);
+		}
+	}
+	napi_schedule_irqoff(oq->napi);
 	return IRQ_HANDLED;
 }
 
 /* Re-initialize Octeon hardware registers */
 static void octep_vf_reinit_regs_cn93(struct octep_vf_device *oct)
 {
+	u32 i;
+
+	for (i = 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++)
+		oct->hw_ops.setup_iq_regs(oct, i);
+
+	for (i = 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++)
+		oct->hw_ops.setup_oq_regs(oct, i);
+
+	oct->hw_ops.enable_interrupts(oct);
+	oct->hw_ops.enable_io_queues(oct);
+
+	for (i = 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++)
+		writel(oct->oq[i]->max_count, oct->oq[i]->pkts_credit_reg);
 }
 
 /* Enable all interrupts */
 static void octep_vf_enable_interrupts_cn93(struct octep_vf_device *oct)
 {
+	int num_rings, q;
+	u64 reg_val;
+
+	num_rings = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
+	for (q = 0; q < num_rings; q++) {
+		reg_val = octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_INT_LEVELS(q));
+		reg_val |= BIT_ULL_MASK(62);
+		octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INT_LEVELS(q), reg_val);
+
+		reg_val = octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_INT_LEVELS(q));
+		reg_val |= BIT_ULL_MASK(62);
+		octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_INT_LEVELS(q), reg_val);
+	}
+	/* Enable PF to VF mbox interrupt by setting 2nd bit*/
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_MBOX_PF_VF_INT(0),
+			     CN93_VF_SDP_R_MBOX_PF_VF_INT_ENAB);
 }
 
 /* Disable all interrupts */
 static void octep_vf_disable_interrupts_cn93(struct octep_vf_device *oct)
 {
+	int num_rings, q;
+	u64 reg_val;
+
+	/* Disable PF to VF mbox interrupt by setting 2nd bit*/
+	if (oct->mbox)
+		octep_vf_write_csr64(oct, CN93_VF_SDP_R_MBOX_PF_VF_INT(0), 0x0);
+
+	num_rings = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
+	for (q = 0; q < num_rings; q++) {
+		reg_val = octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_INT_LEVELS(q));
+		reg_val &= ~BIT_ULL_MASK(62);
+		octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INT_LEVELS(q), reg_val);
+
+		reg_val = octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_INT_LEVELS(q));
+		reg_val &= ~BIT_ULL_MASK(62);
+		octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_INT_LEVELS(q), reg_val);
+	}
 }
 
 /* Get new Octeon Read Index: index of descriptor that Octeon reads next. */
 static u32 octep_vf_update_iq_read_index_cn93(struct octep_vf_iq *iq)
 {
-	return 0;
+	u32 pkt_in_done = readl(iq->inst_cnt_reg);
+	u32 last_done, new_idx;
+
+	last_done = pkt_in_done - iq->pkt_in_done;
+	iq->pkt_in_done = pkt_in_done;
+
+	new_idx = (iq->octep_vf_read_index + last_done) % iq->max_count;
+
+	return new_idx;
 }
 
 /* Enable a hardware Tx Queue */
 static void octep_vf_enable_iq_cn93(struct octep_vf_device *oct, int iq_no)
 {
+	u64 loop = HZ;
+	u64 reg_val;
+
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INSTR_DBELL(iq_no), GENMASK_ULL(31, 0));
+
+	while (octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_INSTR_DBELL(iq_no)) &&
+	       loop--) {
+		schedule_timeout_interruptible(1);
+	}
+
+	reg_val = octep_vf_read_csr64(oct,  CN93_VF_SDP_R_IN_INT_LEVELS(iq_no));
+	reg_val |= BIT_ULL_MASK(62);
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_INT_LEVELS(iq_no), reg_val);
+
+	reg_val = octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_ENABLE(iq_no));
+	reg_val |= ULL(1);
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_ENABLE(iq_no), reg_val);
 }
 
 /* Enable a hardware Rx Queue */
 static void octep_vf_enable_oq_cn93(struct octep_vf_device *oct, int oq_no)
 {
+	u64 reg_val;
+
+	reg_val = octep_vf_read_csr64(oct,  CN93_VF_SDP_R_OUT_INT_LEVELS(oq_no));
+	reg_val |= BIT_ULL_MASK(62);
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_INT_LEVELS(oq_no), reg_val);
+
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_SLIST_DBELL(oq_no), GENMASK_ULL(31, 0));
+
+	reg_val = octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_ENABLE(oq_no));
+	reg_val |= ULL(1);
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_ENABLE(oq_no), reg_val);
 }
 
 /* Enable all hardware Tx/Rx Queues assigned to VF */
 static void octep_vf_enable_io_queues_cn93(struct octep_vf_device *oct)
 {
+	u8 q;
+
+	for (q = 0; q < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); q++) {
+		octep_vf_enable_iq_cn93(oct, q);
+		octep_vf_enable_oq_cn93(oct, q);
+	}
 }
 
 /* Disable a hardware Tx Queue assigned to VF */
 static void octep_vf_disable_iq_cn93(struct octep_vf_device *oct, int iq_no)
 {
+	u64 reg_val;
+
+	reg_val = octep_vf_read_csr64(oct, CN93_VF_SDP_R_IN_ENABLE(iq_no));
+	reg_val &= ~ULL(1);
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_IN_ENABLE(iq_no), reg_val);
 }
 
 /* Disable a hardware Rx Queue assigned to VF */
 static void octep_vf_disable_oq_cn93(struct octep_vf_device *oct, int oq_no)
 {
+	u64 reg_val;
+
+	reg_val = octep_vf_read_csr64(oct, CN93_VF_SDP_R_OUT_ENABLE(oq_no));
+	reg_val &= ~ULL(1);
+	octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_ENABLE(oq_no), reg_val);
 }
 
 /* Disable all hardware Tx/Rx Queues assigned to VF */
 static void octep_vf_disable_io_queues_cn93(struct octep_vf_device *oct)
 {
+	int q;
+
+	for (q = 0; q < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); q++) {
+		octep_vf_disable_iq_cn93(oct, q);
+		octep_vf_disable_oq_cn93(oct, q);
+	}
 }
 
 /* Dump hardware registers (including Tx/Rx queues) for debugging. */
 static void octep_vf_dump_registers_cn93(struct octep_vf_device *oct)
 {
+	u8 num_rings, q;
+
+	num_rings = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
+	for (q = 0; q < num_rings; q++)
+		cn93_vf_dump_q_regs(oct, q);
 }
 
 /**
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
index af07a4a6edc5..3e43d07ab77d 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
@@ -13,9 +13,126 @@
 #include "octep_vf_main.h"
 #include "octep_vf_regs_cnxk.h"
 
+/* Dump useful hardware IQ/OQ CSRs for debug purpose */
+static void cnxk_vf_dump_q_regs(struct octep_vf_device *oct, int qno)
+{
+	struct device *dev = &oct->pdev->dev;
+
+	dev_info(dev, "IQ-%d register dump\n", qno);
+	dev_info(dev, "R[%d]_IN_INSTR_DBELL[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_VF_SDP_R_IN_INSTR_DBELL(qno),
+		 octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_INSTR_DBELL(qno)));
+	dev_info(dev, "R[%d]_IN_CONTROL[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_VF_SDP_R_IN_CONTROL(qno),
+		 octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_CONTROL(qno)));
+	dev_info(dev, "R[%d]_IN_ENABLE[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_VF_SDP_R_IN_ENABLE(qno),
+		 octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_ENABLE(qno)));
+	dev_info(dev, "R[%d]_IN_INSTR_BADDR[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_VF_SDP_R_IN_INSTR_BADDR(qno),
+		 octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_INSTR_BADDR(qno)));
+	dev_info(dev, "R[%d]_IN_INSTR_RSIZE[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_VF_SDP_R_IN_INSTR_RSIZE(qno),
+		 octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_INSTR_RSIZE(qno)));
+	dev_info(dev, "R[%d]_IN_CNTS[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_VF_SDP_R_IN_CNTS(qno),
+		 octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_CNTS(qno)));
+	dev_info(dev, "R[%d]_IN_INT_LEVELS[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_VF_SDP_R_IN_INT_LEVELS(qno),
+		 octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_INT_LEVELS(qno)));
+	dev_info(dev, "R[%d]_IN_PKT_CNT[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_VF_SDP_R_IN_PKT_CNT(qno),
+		 octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_PKT_CNT(qno)));
+	dev_info(dev, "R[%d]_IN_BYTE_CNT[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_VF_SDP_R_IN_BYTE_CNT(qno),
+		 octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_BYTE_CNT(qno)));
+
+	dev_info(dev, "OQ-%d register dump\n", qno);
+	dev_info(dev, "R[%d]_OUT_SLIST_DBELL[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_VF_SDP_R_OUT_SLIST_DBELL(qno),
+		 octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_DBELL(qno)));
+	dev_info(dev, "R[%d]_OUT_CONTROL[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_VF_SDP_R_OUT_CONTROL(qno),
+		 octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(qno)));
+	dev_info(dev, "R[%d]_OUT_ENABLE[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_VF_SDP_R_OUT_ENABLE(qno),
+		 octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_ENABLE(qno)));
+	dev_info(dev, "R[%d]_OUT_SLIST_BADDR[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_VF_SDP_R_OUT_SLIST_BADDR(qno),
+		 octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_BADDR(qno)));
+	dev_info(dev, "R[%d]_OUT_SLIST_RSIZE[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_VF_SDP_R_OUT_SLIST_RSIZE(qno),
+		 octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_RSIZE(qno)));
+	dev_info(dev, "R[%d]_OUT_CNTS[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_VF_SDP_R_OUT_CNTS(qno),
+		 octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_CNTS(qno)));
+	dev_info(dev, "R[%d]_OUT_INT_LEVELS[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_VF_SDP_R_OUT_INT_LEVELS(qno),
+		 octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_INT_LEVELS(qno)));
+	dev_info(dev, "R[%d]_OUT_PKT_CNT[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_VF_SDP_R_OUT_PKT_CNT(qno),
+		 octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_PKT_CNT(qno)));
+	dev_info(dev, "R[%d]_OUT_BYTE_CNT[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_VF_SDP_R_OUT_BYTE_CNT(qno),
+		 octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_BYTE_CNT(qno)));
+	dev_info(dev, "R[%d]_ERR_TYPE[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_VF_SDP_R_ERR_TYPE(qno),
+		 octep_vf_read_csr64(oct, CNXK_VF_SDP_R_ERR_TYPE(qno)));
+}
+
+/* Reset Hardware Tx queue */
+static void cnxk_vf_reset_iq(struct octep_vf_device *oct, int q_no)
+{
+	u64 val = ULL(0);
+
+	dev_dbg(&oct->pdev->dev, "Reset VF IQ-%d\n", q_no);
+
+	/* Disable the Tx/Instruction Ring */
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_ENABLE(q_no), val);
+
+	/* clear the Instruction Ring packet/byte counts and doorbell CSRs */
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INT_LEVELS(q_no), val);
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_PKT_CNT(q_no), val);
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_BYTE_CNT(q_no), val);
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INSTR_BADDR(q_no), val);
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INSTR_RSIZE(q_no), val);
+
+	val = GENMASK_ULL(31, 0);
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INSTR_DBELL(q_no), val);
+
+	val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_CNTS(q_no));
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_CNTS(q_no), val & GENMASK_ULL(31, 0));
+
+}
+
+/* Reset Hardware Rx queue */
+static void cnxk_vf_reset_oq(struct octep_vf_device *oct, int q_no)
+{
+	u64 val = ULL(0);
+
+	/* Disable Output (Rx) Ring */
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_ENABLE(q_no), val);
+
+	/* Clear count CSRs */
+	val = octep_vf_read_csr(oct, CNXK_VF_SDP_R_OUT_CNTS(q_no));
+	octep_vf_write_csr(oct, CNXK_VF_SDP_R_OUT_CNTS(q_no), val);
+
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_PKT_CNT(q_no), GENMASK_ULL(35, 0));
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_DBELL(q_no), GENMASK_ULL(31, 0));
+}
+
 /* Reset all hardware Tx/Rx queues */
 static void octep_vf_reset_io_queues_cnxk(struct octep_vf_device *oct)
 {
+	struct pci_dev *pdev = oct->pdev;
+	int q;
+
+	dev_dbg(&pdev->dev, "Reset OCTEP_CNXK VF IO Queues\n");
+
+	for (q = 0; q < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); q++) {
+		cnxk_vf_reset_iq(oct, q);
+		cnxk_vf_reset_oq(oct, q);
+	}
 }
 
 /* Initialize configuration limits and initial active config */
@@ -47,78 +164,304 @@ static void octep_vf_init_config_cnxk_vf(struct octep_vf_device *oct)
 /* Setup registers for a hardware Tx Queue  */
 static void octep_vf_setup_iq_regs_cnxk(struct octep_vf_device *oct, int iq_no)
 {
+	struct octep_vf_iq *iq = oct->iq[iq_no];
+	u32 reset_instr_cnt;
+	u64 reg_val;
+
+	reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_CONTROL(iq_no));
+
+	/* wait for IDLE to set to 1 */
+	if (!(reg_val & CNXK_VF_R_IN_CTL_IDLE)) {
+		do {
+			reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_CONTROL(iq_no));
+		} while (!(reg_val & CNXK_VF_R_IN_CTL_IDLE));
+	}
+	reg_val |= CNXK_VF_R_IN_CTL_RDSIZE;
+	reg_val |= CNXK_VF_R_IN_CTL_IS_64B;
+	reg_val |= CNXK_VF_R_IN_CTL_ESR;
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_CONTROL(iq_no), reg_val);
+
+	/* Write the start of the input queue's ring and its size  */
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INSTR_BADDR(iq_no), iq->desc_ring_dma);
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INSTR_RSIZE(iq_no), iq->max_count);
+
+	/* Remember the doorbell & instruction count register addr for this queue */
+	iq->doorbell_reg = oct->mmio.hw_addr + CNXK_VF_SDP_R_IN_INSTR_DBELL(iq_no);
+	iq->inst_cnt_reg = oct->mmio.hw_addr + CNXK_VF_SDP_R_IN_CNTS(iq_no);
+	iq->intr_lvl_reg = oct->mmio.hw_addr + CNXK_VF_SDP_R_IN_INT_LEVELS(iq_no);
+
+	/* Store the current instruction counter (used in flush_iq calculation) */
+	reset_instr_cnt = readl(iq->inst_cnt_reg);
+	writel(reset_instr_cnt, iq->inst_cnt_reg);
+
+	/* INTR_THRESHOLD is set to max(FFFFFFFF) to disable the INTR */
+	reg_val = CFG_GET_IQ_INTR_THRESHOLD(oct->conf) & GENMASK_ULL(31, 0);
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INT_LEVELS(iq_no), reg_val);
 }
 
 /* Setup registers for a hardware Rx Queue  */
 static void octep_vf_setup_oq_regs_cnxk(struct octep_vf_device *oct, int oq_no)
 {
+	struct octep_vf_oq *oq = oct->oq[oq_no];
+	u32 time_threshold = 0;
+	u64 oq_ctl = ULL(0);
+	u64 reg_val;
+
+	reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(oq_no));
+
+	/* wait for IDLE to set to 1 */
+	if (!(reg_val & CNXK_VF_R_OUT_CTL_IDLE)) {
+		do {
+			reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(oq_no));
+		} while (!(reg_val & CNXK_VF_R_OUT_CTL_IDLE));
+	}
+
+	reg_val &= ~(CNXK_VF_R_OUT_CTL_IMODE);
+	reg_val &= ~(CNXK_VF_R_OUT_CTL_ROR_P);
+	reg_val &= ~(CNXK_VF_R_OUT_CTL_NSR_P);
+	reg_val &= ~(CNXK_VF_R_OUT_CTL_ROR_I);
+	reg_val &= ~(CNXK_VF_R_OUT_CTL_NSR_I);
+	reg_val &= ~(CNXK_VF_R_OUT_CTL_ES_I);
+	reg_val &= ~(CNXK_VF_R_OUT_CTL_ROR_D);
+	reg_val &= ~(CNXK_VF_R_OUT_CTL_NSR_D);
+	reg_val &= ~(CNXK_VF_R_OUT_CTL_ES_D);
+	reg_val |= (CNXK_VF_R_OUT_CTL_ES_P);
+
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(oq_no), reg_val);
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_BADDR(oq_no), oq->desc_ring_dma);
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_RSIZE(oq_no), oq->max_count);
+
+	oq_ctl = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(oq_no));
+	/* Clear the ISIZE and BSIZE (22-0) */
+	oq_ctl &= ~GENMASK_ULL(22, 0);
+	/* Populate the BSIZE (15-0) */
+	oq_ctl |= (oq->buffer_size & GENMASK_ULL(15, 0));
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(oq_no), oq_ctl);
+
+	/* Get the mapped address of the pkt_sent and pkts_credit regs */
+	oq->pkts_sent_reg = oct->mmio.hw_addr + CNXK_VF_SDP_R_OUT_CNTS(oq_no);
+	oq->pkts_credit_reg = oct->mmio.hw_addr + CNXK_VF_SDP_R_OUT_SLIST_DBELL(oq_no);
+
+	time_threshold = CFG_GET_OQ_INTR_TIME(oct->conf);
+	reg_val = ((u64)time_threshold << 32) | CFG_GET_OQ_INTR_PKT(oct->conf);
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_INT_LEVELS(oq_no), reg_val);
+
+	/* set watermark for backpressure */
+	reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_WMARK(oq_no));
+	reg_val &= ~GENMASK_ULL(31, 0);
+	reg_val |= CFG_GET_OQ_WMARK(oct->conf);
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_WMARK(oq_no), reg_val);
 }
 
 /* Setup registers for a VF mailbox */
 static void octep_vf_setup_mbox_regs_cnxk(struct octep_vf_device *oct, int q_no)
 {
+	struct octep_vf_mbox *mbox = oct->mbox;
+
+	/* PF to VF DATA reg. VF reads from this reg */
+	mbox->mbox_read_reg = oct->mmio.hw_addr + CNXK_VF_SDP_R_MBOX_PF_VF_DATA(q_no);
+
+	/* VF mbox interrupt reg */
+	mbox->mbox_int_reg = oct->mmio.hw_addr + CNXK_VF_SDP_R_MBOX_PF_VF_INT(q_no);
+
+	/* VF to PF DATA reg. VF writes into this reg */
+	mbox->mbox_write_reg = oct->mmio.hw_addr + CNXK_VF_SDP_R_MBOX_VF_PF_DATA(q_no);
+}
+
+/* Mailbox Interrupt handler */
+static void cnxk_handle_vf_mbox_intr(struct octep_vf_device *oct)
+{
+	if (oct->mbox)
+		schedule_work(&oct->mbox->wk.work);
+	else
+		dev_err(&oct->pdev->dev, "cannot schedule work on invalid mbox\n");
 }
 
 /* Tx/Rx queue interrupt handler */
 static irqreturn_t octep_vf_ioq_intr_handler_cnxk(void *data)
 {
+	struct octep_vf_ioq_vector *vector = data;
+	struct octep_vf_device *oct;
+	struct octep_vf_oq *oq;
+	u64 reg_val;
+
+	oct = vector->octep_vf_dev;
+	oq = vector->oq;
+	/* Mailbox interrupt arrives along with interrupt of tx/rx ring pair 0 */
+	if (oq->q_no == 0) {
+		reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_MBOX_PF_VF_INT(0));
+		if (reg_val & CNXK_VF_SDP_R_MBOX_PF_VF_INT_STATUS) {
+			cnxk_handle_vf_mbox_intr(oct);
+			octep_vf_write_csr64(oct, CNXK_VF_SDP_R_MBOX_PF_VF_INT(0), reg_val);
+		}
+	}
+	napi_schedule_irqoff(oq->napi);
 	return IRQ_HANDLED;
 }
 
 /* Re-initialize Octeon hardware registers */
 static void octep_vf_reinit_regs_cnxk(struct octep_vf_device *oct)
 {
+	u32 i;
+
+	for (i = 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++)
+		oct->hw_ops.setup_iq_regs(oct, i);
+
+	for (i = 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++)
+		oct->hw_ops.setup_oq_regs(oct, i);
+
+	oct->hw_ops.enable_interrupts(oct);
+	oct->hw_ops.enable_io_queues(oct);
+
+	for (i = 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++)
+		writel(oct->oq[i]->max_count, oct->oq[i]->pkts_credit_reg);
 }
 
 /* Enable all interrupts */
 static void octep_vf_enable_interrupts_cnxk(struct octep_vf_device *oct)
 {
+	int num_rings, q;
+	u64 reg_val;
+
+	num_rings = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
+	for (q = 0; q < num_rings; q++) {
+		reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_INT_LEVELS(q));
+		reg_val |= BIT_ULL_MASK(62);
+		octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INT_LEVELS(q), reg_val);
+
+		reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_INT_LEVELS(q));
+		reg_val |= BIT_ULL_MASK(62);
+		octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_INT_LEVELS(q), reg_val);
+	}
+	/* Enable PF to VF mbox interrupt by setting 2nd bit*/
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_MBOX_PF_VF_INT(0),
+			     CNXK_VF_SDP_R_MBOX_PF_VF_INT_ENAB);
 }
 
 /* Disable all interrupts */
 static void octep_vf_disable_interrupts_cnxk(struct octep_vf_device *oct)
 {
+	int num_rings, q;
+	u64 reg_val;
+
+	/* Disable PF to VF mbox interrupt by setting 2nd bit*/
+	if (oct->mbox)
+		octep_vf_write_csr64(oct, CNXK_VF_SDP_R_MBOX_PF_VF_INT(0), 0x0);
+
+	num_rings = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
+	for (q = 0; q < num_rings; q++) {
+		reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_INT_LEVELS(q));
+		reg_val &= ~BIT_ULL_MASK(62);
+		octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INT_LEVELS(q), reg_val);
+
+		reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_INT_LEVELS(q));
+		reg_val &= ~BIT_ULL_MASK(62);
+		octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_INT_LEVELS(q), reg_val);
+	}
 }
 
 /* Get new Octeon Read Index: index of descriptor that Octeon reads next. */
 static u32 octep_vf_update_iq_read_index_cnxk(struct octep_vf_iq *iq)
 {
-	return 0;
+	u32 pkt_in_done = readl(iq->inst_cnt_reg);
+	u32 last_done, new_idx;
+
+	last_done = pkt_in_done - iq->pkt_in_done;
+	iq->pkt_in_done = pkt_in_done;
+
+	new_idx = (iq->octep_vf_read_index + last_done) % iq->max_count;
+
+	return new_idx;
 }
 
 /* Enable a hardware Tx Queue */
 static void octep_vf_enable_iq_cnxk(struct octep_vf_device *oct, int iq_no)
 {
+	u64 loop = HZ;
+	u64 reg_val;
+
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INSTR_DBELL(iq_no), GENMASK_ULL(31, 0));
+
+	while (octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_INSTR_DBELL(iq_no)) &&
+	       loop--) {
+		schedule_timeout_interruptible(1);
+	}
+
+	reg_val = octep_vf_read_csr64(oct,  CNXK_VF_SDP_R_IN_INT_LEVELS(iq_no));
+	reg_val |= BIT_ULL_MASK(62);
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_INT_LEVELS(iq_no), reg_val);
+
+	reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_ENABLE(iq_no));
+	reg_val |= ULL(1);
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_ENABLE(iq_no), reg_val);
 }
 
 /* Enable a hardware Rx Queue */
 static void octep_vf_enable_oq_cnxk(struct octep_vf_device *oct, int oq_no)
 {
+	u64 reg_val;
+
+	reg_val = octep_vf_read_csr64(oct,  CNXK_VF_SDP_R_OUT_INT_LEVELS(oq_no));
+	reg_val |= BIT_ULL_MASK(62);
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_INT_LEVELS(oq_no), reg_val);
+
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_DBELL(oq_no), GENMASK_ULL(31, 0));
+
+	reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_ENABLE(oq_no));
+	reg_val |= ULL(1);
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_ENABLE(oq_no), reg_val);
 }
 
 /* Enable all hardware Tx/Rx Queues assigned to VF */
 static void octep_vf_enable_io_queues_cnxk(struct octep_vf_device *oct)
 {
+	u8 q;
+
+	for (q = 0; q < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); q++) {
+		octep_vf_enable_iq_cnxk(oct, q);
+		octep_vf_enable_oq_cnxk(oct, q);
+	}
 }
 
 /* Disable a hardware Tx Queue assigned to VF */
 static void octep_vf_disable_iq_cnxk(struct octep_vf_device *oct, int iq_no)
 {
+	u64 reg_val;
+
+	reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_IN_ENABLE(iq_no));
+	reg_val &= ~ULL(1);
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_IN_ENABLE(iq_no), reg_val);
 }
 
 /* Disable a hardware Rx Queue assigned to VF */
 static void octep_vf_disable_oq_cnxk(struct octep_vf_device *oct, int oq_no)
 {
+	u64 reg_val;
+
+	reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_ENABLE(oq_no));
+	reg_val &= ~ULL(1);
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_ENABLE(oq_no), reg_val);
 }
 
 /* Disable all hardware Tx/Rx Queues assigned to VF */
 static void octep_vf_disable_io_queues_cnxk(struct octep_vf_device *oct)
 {
+	int q;
+
+	for (q = 0; q < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); q++) {
+		octep_vf_disable_iq_cnxk(oct, q);
+		octep_vf_disable_oq_cnxk(oct, q);
+	}
 }
 
 /* Dump hardware registers (including Tx/Rx queues) for debugging. */
 static void octep_vf_dump_registers_cnxk(struct octep_vf_device *oct)
 {
+	u8 num_rings, q;
+
+	num_rings = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
+	for (q = 0; q < num_rings; q++)
+		cnxk_vf_dump_q_regs(oct, q);
 }
 
 /**
-- 
2.25.1


