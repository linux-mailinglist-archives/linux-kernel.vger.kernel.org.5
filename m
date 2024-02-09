Return-Path: <linux-kernel+bounces-60113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E42B850012
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DBE8B2CD1E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F71A39AF9;
	Fri,  9 Feb 2024 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="XEtpvBpf";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="AerX8605"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C04539AD1;
	Fri,  9 Feb 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517852; cv=none; b=Ev5AbhJrXXlEz/HQhBr9RdapKgS9FJtYaMUfYnLCxpTnU1mHGGSOFPGTx1Ounm/xysviKLh/rBzN11PyJmbcbAgw3THJPdo+5X9R9JSDoXeNeWThUMYjtkJuxfrvQQCAMQ2rc4bheQWS7fA8Uxvtnlqg/xv89cxYz55hHde2+2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517852; c=relaxed/simple;
	bh=WfrDfJeZPwMlSR2dpbJWm5p2rTmdITk0It1fj0d3Urg=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=uXwlryZYVIUZJqkInniJ6aeXotaoWjZtW8OKq1ukSA6KWHE6KNaBeXFbahr6wkOtWFze4hyLthrf+MD2qiCyYMgnxfLnIsURb8Rw0waJ2CCZ4os7Ciadbcf0ZbbffeS2KiQJjU9VlRHMg3US9eka77/n615Q6Ve+a5ZBlOBma3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=XEtpvBpf; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=AerX8605; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707517849;
	bh=WfrDfJeZPwMlSR2dpbJWm5p2rTmdITk0It1fj0d3Urg=;
	h=Message-ID:Subject:From:To:Date:From;
	b=XEtpvBpfGPaoKFNnIq+ysOBrp9e/Ff/7ww0vCRd2nHG+toYTuMYu3oQDcMVIqOKWf
	 49+NfKnnvREKjqERO6x7IB3x4VecfrU/FkvkXEk4YsZ++fNgJPAYc3fPjuXmxkm58Q
	 BMhr/iUunYCHgB0RR9XTCNCKNdwu3WPln5K7Kl00=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 06E611286810;
	Fri,  9 Feb 2024 17:30:49 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id LrY6INkDyhof; Fri,  9 Feb 2024 17:30:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707517848;
	bh=WfrDfJeZPwMlSR2dpbJWm5p2rTmdITk0It1fj0d3Urg=;
	h=Message-ID:Subject:From:To:Date:From;
	b=AerX8605vZmjHkSHN0qW+4kMCv1YEyA1szkhMLmWqgR0lTcs+fVo5rit2+QNkzzi4
	 vvUNLAfpmXaSYFv1pQzLPhvoSzjmBQ/t0lmGruyWv0FY02U0fEz4tV47UFheKmSVCj
	 OnLhGVlE7kbSzIJm4JCQeNXk368JUkcw/pKYLPrc=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 44AE51281625;
	Fri,  9 Feb 2024 17:30:48 -0500 (EST)
Message-ID: <df8e539e6f1e708d1a1b0025632ae3b42bb7ff84.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.8-rc3
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel
	 <linux-kernel@vger.kernel.org>
Date: Fri, 09 Feb 2024 17:30:46 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

4 small fixes, 3 in drivers with the remaining core fix being a fixup
to the one in the last pull request which didn't entirely move checking
of scsi_host_busy() out from under the host lock.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Alice Chao (1):
      scsi: ufs: core: Fix shift issue in ufshcd_clear_cmd()

Hannes Reinecke (1):
      scsi: lpfc: Use unsigned type for num_sge

Ming Lei (1):
      scsi: core: Move scsi_host_busy() out of host lock if it is for per-command

SEO HOYOUNG (1):
      scsi: ufs: core: Remove the ufshcd_release() in ufshcd_err_handling_prepare()

And the diffstat:

 drivers/scsi/lpfc/lpfc_scsi.c | 12 ++++++------
 drivers/scsi/scsi_error.c     |  3 ++-
 drivers/scsi/scsi_lib.c       |  4 +++-
 drivers/ufs/core/ufshcd.c     |  5 +++--
 4 files changed, 14 insertions(+), 10 deletions(-)

With full diff below.

James

---

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
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 4f455884fdc4..612489afe8d2 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -282,11 +282,12 @@ static void scsi_eh_inc_host_failed(struct rcu_head *head)
 {
 	struct scsi_cmnd *scmd = container_of(head, typeof(*scmd), rcu);
 	struct Scsi_Host *shost = scmd->device->host;
+	unsigned int busy = scsi_host_busy(shost);
 	unsigned long flags;
 
 	spin_lock_irqsave(shost->host_lock, flags);
 	shost->host_failed++;
-	scsi_eh_wakeup(shost, scsi_host_busy(shost));
+	scsi_eh_wakeup(shost, busy);
 	spin_unlock_irqrestore(shost->host_lock, flags);
 }
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 1fb80eae9a63..df5ac03d5d6c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -278,9 +278,11 @@ static void scsi_dec_host_busy(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 	rcu_read_lock();
 	__clear_bit(SCMD_STATE_INFLIGHT, &cmd->state);
 	if (unlikely(scsi_host_in_recovery(shost))) {
+		unsigned int busy = scsi_host_busy(shost);
+
 		spin_lock_irqsave(shost->host_lock, flags);
 		if (shost->host_failed || shost->host_eh_scheduled)
-			scsi_eh_wakeup(shost, scsi_host_busy(shost));
+			scsi_eh_wakeup(shost, busy);
 		spin_unlock_irqrestore(shost->host_lock, flags);
 	}
 	rcu_read_unlock();
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 029d017fc1b6..d77b25b79ae3 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3057,7 +3057,7 @@ bool ufshcd_cmd_inflight(struct scsi_cmnd *cmd)
  */
 static int ufshcd_clear_cmd(struct ufs_hba *hba, u32 task_tag)
 {
-	u32 mask = 1U << task_tag;
+	u32 mask;
 	unsigned long flags;
 	int err;
 
@@ -3075,6 +3075,8 @@ static int ufshcd_clear_cmd(struct ufs_hba *hba, u32 task_tag)
 		return 0;
 	}
 
+	mask = 1U << task_tag;
+
 	/* clear outstanding transaction before retry */
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	ufshcd_utrl_clear(hba, mask);
@@ -6352,7 +6354,6 @@ static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
 		ufshcd_hold(hba);
 		if (!ufshcd_is_clkgating_allowed(hba))
 			ufshcd_setup_clocks(hba, true);
-		ufshcd_release(hba);
 		pm_op = hba->is_sys_suspended ? UFS_SYSTEM_PM : UFS_RUNTIME_PM;
 		ufshcd_vops_resume(hba, pm_op);
 	} else {


