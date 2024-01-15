Return-Path: <linux-kernel+bounces-26437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAAF82E09D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE08A1C21E65
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EB118C15;
	Mon, 15 Jan 2024 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pd37N/n1"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0677018B06;
	Mon, 15 Jan 2024 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=1D2O/oZLoFQC2/FAJ3H/MWMGvTVUWOLR5lPGQ9I/yas=; b=pd37N/n1SWyqd2aNIP5BnBBqY5
	6NqeEWSKWIZ5P257VpU1HJ67cKqa/Uo5ydzFVmJxfv6Yy2NVrNr86WtYmINFQuUnFqYkfWQiEYYE2
	gaYWDZFxjPUXMFetI2ept9LZieP7Z39bvj50BCSwu+cZYSwobvSDhEiQCNKN9qB9FcpfDtRQq3p4K
	8qzekRsS0FQ6oHeFwjuDbNvsEybHdyneiQ/p4p3eOBonbgeuWbxiL58gkDZkrpbX8k39mozr2qDs+
	7FKLvJVoJ9Oa7hjxi3xDD1nALDg2IgTbE0SNxAOX2ln6+m+Hl0NTQA1jAGWNWRLVUEapVTfL0z3v/
	Hk4HF8nA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPSZk-00A3QP-1K;
	Mon, 15 Jan 2024 19:24:48 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Thirupathaiah Annapureddy <thiruan@microsoft.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org
Subject: [PATCH] tpm/tpm_ftpm_tee: fix all kernel-doc warnings
Date: Mon, 15 Jan 2024 11:24:47 -0800
Message-ID: <20240115192447.26481-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change @pdev to @dev in 2 places to match the function parameters.
Correct one function name in kernel-doc comment to match the function
implementation.

This prevents these warnings:

tpm_ftpm_tee.c:217: warning: Function parameter or struct member 'dev' not described in 'ftpm_tee_probe'
tpm_ftpm_tee.c:217: warning: Excess function parameter 'pdev' description in 'ftpm_tee_probe'
tpm_ftpm_tee.c:313: warning: Function parameter or struct member 'dev' not described in 'ftpm_tee_remove'
tpm_ftpm_tee.c:313: warning: Excess function parameter 'pdev' description in 'ftpm_tee_remove'
tpm_ftpm_tee.c:348: warning: expecting prototype for ftpm_tee_shutdown(). Prototype was for ftpm_plat_tee_shutdown() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thirupathaiah Annapureddy <thiruan@microsoft.com>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org
---
 drivers/char/tpm/tpm_ftpm_tee.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -208,7 +208,7 @@ static int ftpm_tee_match(struct tee_ioc
 
 /**
  * ftpm_tee_probe() - initialize the fTPM
- * @pdev: the platform_device description.
+ * @dev: the device description.
  *
  * Return:
  *	On success, 0. On failure, -errno.
@@ -304,7 +304,7 @@ static int ftpm_plat_tee_probe(struct pl
 
 /**
  * ftpm_tee_remove() - remove the TPM device
- * @pdev: the platform_device description.
+ * @dev: the device description.
  *
  * Return:
  *	0 always.
@@ -341,7 +341,7 @@ static void ftpm_plat_tee_remove(struct
 }
 
 /**
- * ftpm_tee_shutdown() - shutdown the TPM device
+ * ftpm_plat_tee_shutdown() - shutdown the TPM device
  * @pdev: the platform_device description.
  */
 static void ftpm_plat_tee_shutdown(struct platform_device *pdev)

