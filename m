Return-Path: <linux-kernel+bounces-62702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B8D85248B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B348D283BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D86A7F49C;
	Tue, 13 Feb 2024 00:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Izzq35d4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D1F7E763;
	Tue, 13 Feb 2024 00:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783780; cv=none; b=FKGEFlee1jHRNzq4l+1fD3/sm1jiXj0WhKqkdJJsCtOUC7aLxLbiM/zi8dXcfmbziCKvI+JRRjA3qFcAgarqQFwKzVWEoDKSVxLpFDj311A3h28FPHjvfnBsb1ii77EwB0tn1K/gcrfXlR5IBgqdrpT+iBfRkU+59iT9VmbpNMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783780; c=relaxed/simple;
	bh=qft1jvOHgIiVPTqcuMrH1qUIqIBtmwSU47C1zHP2jL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9D+WJBDrxK3Ccz0F+g4IBv5QIHvMaHj3ajZ0UJxCZMsKlAlBi/nMwVzMOMcsD6JjQm9eQvx14wgVpYTMduVzb0NO2Uq5W8DWzSQP1P59pZqPzka5EMgjrBGJJVOVQw6eFsOmvOSbGpvN9+xZx9VURexmAzq62sID/2lc2hp9pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Izzq35d4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7602C433C7;
	Tue, 13 Feb 2024 00:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783780;
	bh=qft1jvOHgIiVPTqcuMrH1qUIqIBtmwSU47C1zHP2jL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Izzq35d4vHs3mQXIbGAwXsh1yORDcxSNZiN6VDSNBAsZ3LRYijafvdoeEV2SLzr5e
	 q+LuAsJP+foG/b+XV8YjyL6YWXdPEESzIlsQ/PwIEVFMIViEZ/YDhgzwhwhn4PBiTa
	 ACDU7H3St25PSwED3oGOBz8zUas2qoQc5RrCCRmzB2prIAQIj4t9+qGWLxoNJJvHZA
	 jGY3LFA1h3zTQz2iH/oMDPxb6/wppV++A5TmdHf0KIaPmdRsFCDtkztm4DaPPQGN4a
	 tvrdTQxOTu8vuQ3/vrKdBK5bt8h7tfFX4a8+U78q44wQNPCkc+XGhIbMRcOqqfpACg
	 dfqCeSHvtr7ig==
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
Subject: [PATCH AUTOSEL 6.1 18/28] scsi: lpfc: Use unsigned type for num_sge
Date: Mon, 12 Feb 2024 19:22:16 -0500
Message-ID: <20240213002235.671934-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002235.671934-1-sashal@kernel.org>
References: <20240213002235.671934-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
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
index 7aac9fc71967..0bb7e164b525 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -1919,7 +1919,7 @@ lpfc_bg_setup_bpl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
  *
  * Returns the number of SGEs added to the SGL.
  **/
-static int
+static uint32_t
 lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 		struct sli4_sge *sgl, int datasegcnt,
 		struct lpfc_io_buf *lpfc_cmd)
@@ -1927,8 +1927,8 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
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
@@ -2100,7 +2100,7 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
  *
  * Returns the number of SGEs added to the SGL.
  **/
-static int
+static uint32_t
 lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 		struct sli4_sge *sgl, int datacnt, int protcnt,
 		struct lpfc_io_buf *lpfc_cmd)
@@ -2124,8 +2124,8 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
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


