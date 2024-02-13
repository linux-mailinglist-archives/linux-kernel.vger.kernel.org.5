Return-Path: <linux-kernel+bounces-62605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 517AD85238D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B4B1C211F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD05554649;
	Tue, 13 Feb 2024 00:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cm7UCYGk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53EB4C9F;
	Tue, 13 Feb 2024 00:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783572; cv=none; b=hvWrF04cFiHx1MqjzVGK+n8ycDWNPcettyhJA9YXvQ+XNA/5AGze8eZ81ELL/ZfzPPWC62ReF9aWl3Wffq2M0i54Rg+lqlXqkair30xeTR9Ya6ViB/HHneyWM4qS+R+HZ4UE/XrAc8DwDekw7NWx/lFx22LmvULCO5Ks3aT6L2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783572; c=relaxed/simple;
	bh=D5FmZorhaZefGTlqcT+FkW4aV8RoGBMwO9d0EJXg7IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4CQ97uC0NYjoZllsQ86CZTD6tPrNBXBop15NIPbr0PGMfoXgXIR1JsPzPiPsXlkvO8mZbMgYVhM1tlSMEVtAYzc6w5R9Lv1VeheWxO/TlMi+DtbdJzanbL2YKrJkXkiOLktQQXwF4CGVvsSUC3X4xia03bWhbmxgWduMQD5QR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cm7UCYGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D5CC43390;
	Tue, 13 Feb 2024 00:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783571;
	bh=D5FmZorhaZefGTlqcT+FkW4aV8RoGBMwO9d0EJXg7IA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cm7UCYGkK6gRtz5JFCyi1uB8gWbuTav75ULfRKc3di7xtymFtOydyVLR+Jsses1b7
	 mcklIyfkON8MhyiGpJ8Vz5WlQrV7kiueyyLoFrTlrFE0W33NfBRx8ifokNPMRCHGgA
	 pgPkEzg14Fp8ephnGErijD5GlCWRFIj1BK3KTYhD4pE6q9V4uJ/BnmMva7PXD3Dope
	 8xStmEX/jonfKqUg1rw44XGxP5oWh9B640TORM15pXWKoLpmuoRMc9HvNJWFPV7cYb
	 o+5IWE+AvTQSN16V4VJnzYm4xbURqbiIKx1WNMDsne6BjoGHlCRmaTI68Xsg50rEiN
	 KZwPCo8gFpFeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 36/58] scsi: lpfc: Use unsigned type for num_sge
Date: Mon, 12 Feb 2024 19:17:42 -0500
Message-ID: <20240213001837.668862-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit d6c1b19153f92e95e5e1801d540e98771053afae ]

LUNs going into "failed ready running" state observed on >1T and on even
numbers of size (2T, 4T, 6T, 8T and 10T). The issue occurs when DIF is
enabled at the host.

The kernel logs:

  Cannot setup S/G List for HBAIO segs 1/1 SGL 512 SCSI 256: 3 0

The host lpfc driver is failing to setup scatter/gather list (protection
data) for the I/Os.

The return type lpfc_bg_setup_sgl()/lpfc_bg_setup_sgl_prot() causes the
compiler to remove the most significant bit. Use an unsigned type instead.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[dwagner: added commit message]
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Link: https://lore.kernel.org/r/20231220162658.12392-1-dwagner@suse.de
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_scsi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index d26941b131fd..bf879d81846b 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -1918,7 +1918,7 @@ lpfc_bg_setup_bpl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
  *
  * Returns the number of SGEs added to the SGL.
  **/
-static int
+static uint32_t
 lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 		struct sli4_sge *sgl, int datasegcnt,
 		struct lpfc_io_buf *lpfc_cmd)
@@ -1926,8 +1926,8 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	struct scatterlist *sgde = NULL; /* s/g data entry */
 	struct sli4_sge_diseed *diseed = NULL;
 	dma_addr_t physaddr;
-	int i = 0, num_sge = 0, status;
-	uint32_t reftag;
+	int i = 0, status;
+	uint32_t reftag, num_sge = 0;
 	uint8_t txop, rxop;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	uint32_t rc;
@@ -2099,7 +2099,7 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
  *
  * Returns the number of SGEs added to the SGL.
  **/
-static int
+static uint32_t
 lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 		struct sli4_sge *sgl, int datacnt, int protcnt,
 		struct lpfc_io_buf *lpfc_cmd)
@@ -2123,8 +2123,8 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	uint32_t rc;
 #endif
 	uint32_t checking = 1;
-	uint32_t dma_offset = 0;
-	int num_sge = 0, j = 2;
+	uint32_t dma_offset = 0, num_sge = 0;
+	int j = 2;
 	struct sli4_hybrid_sgl *sgl_xtra = NULL;
 
 	sgpe = scsi_prot_sglist(sc);
-- 
2.43.0


