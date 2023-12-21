Return-Path: <linux-kernel+bounces-7861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2957381AE66
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96E9286E36
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A56B671;
	Thu, 21 Dec 2023 05:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nAwN43VP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4E4B641;
	Thu, 21 Dec 2023 05:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=75JO6X/i95NW3ovT3L7Gh3dXza7a+3wXyZ9aCajAIGI=; b=nAwN43VP3EEarggAdn3LPVcO9h
	AjPq9q5BHgqZnpC/NDIzhjPMbsr2qLn1y36CXuxg4OTj7XK+dOvYAYyqwTVlfZ2n1H8wev+qtRCz2
	+/b6jzdfy0jAs31RGlRv4SNYzzaeLmI67tfs/J3UtPx5E1a60dpMLN/nJ5QJg2+PyAKJDcP5i5Plv
	7curl6BPVTNl25OPqcj9qZ3RU8DavnpHT32JNFnvMnuep9ky4Zr/nHUnN7rkHHL2Xh4DVWaE8dudq
	Di1TCdBpXrOvvFUEcakhe5fmTT2kfdbnH4bGuh/R4xeZfZrTyp7ychsRD7AMYLr8h08KT1PCHhO7g
	B33whBVQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGBeM-001kOC-2I;
	Thu, 21 Dec 2023 05:31:14 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: mpi3mr: fix mpi3mr_fw.c kernel-doc warnings
Date: Wed, 20 Dec 2023 21:31:13 -0800
Message-ID: <20231221053113.32191-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use correct format for function return values.
Delete blank lines that are reported as "bad line:".

mpi3mr_fw.c:482: warning: No description found for return value of 'mpi3mr_get_reply_desc'
mpi3mr_fw.c:1066: warning: bad line: 
mpi3mr_fw.c:1109: warning: bad line: 
mpi3mr_fw.c:1249: warning: No description found for return value of 'mpi3mr_revalidate_factsdata'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: mpi3mr-linuxdrv.pdl@broadcom.com
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff -- a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -475,7 +475,7 @@ int mpi3mr_process_admin_reply_q(struct
  * @op_reply_q: op_reply_qinfo object
  * @reply_ci: operational reply descriptor's queue consumer index
  *
- * Returns reply descriptor frame address
+ * Returns: reply descriptor frame address
  */
 static inline struct mpi3_default_reply_descriptor *
 mpi3mr_get_reply_desc(struct op_reply_qinfo *op_reply_q, u32 reply_ci)
@@ -1063,7 +1063,6 @@ enum mpi3mr_iocstate mpi3mr_get_iocstate
  * @mrioc: Adapter instance reference
  *
  * Free the DMA memory allocated for IOCTL handling purpose.
-
  *
  * Return: None
  */
@@ -1106,7 +1105,6 @@ static void mpi3mr_free_ioctl_dma_memory
 /**
  * mpi3mr_alloc_ioctl_dma_memory - Alloc memory for ioctl dma
  * @mrioc: Adapter instance reference
-
  *
  * This function allocates dmaable memory required to handle the
  * application issued MPI3 IOCTL requests.
@@ -1241,7 +1239,7 @@ static int mpi3mr_issue_and_process_mur(
  * during reset/resume
  * @mrioc: Adapter instance reference
  *
- * Return zero if the new IOCFacts parameters value is compatible with
+ * Return: zero if the new IOCFacts parameters value is compatible with
  * older values else return -EPERM
  */
 static int

