Return-Path: <linux-kernel+bounces-9395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E549C81C4FB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A531F25BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122B8B666;
	Fri, 22 Dec 2023 06:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BAvMC7go"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CDA9471;
	Fri, 22 Dec 2023 06:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=aFz6qdyIiGrIGX0NaG1dtVnBcc9Bi+e41I0J7Qpd3jM=; b=BAvMC7goP5Qnu9QHmcq4C6q1op
	EsvaziioMphl2W207S1/iCsD3YKtgcjPqTRUXOWjwxKtkkSeyQuv3tGVTXN+TWL4mnoaeUSfPyJWS
	mcgIpmCzH/cAdiIuF8AHmvRXZQT6p5919JFBl41YzRarnSSDgwCd6hasnkn7fDd022reZwkiSQlLY
	YSbFNFHO6gXA9BoEbT4dA0k2ypfY9VBDV8Y2rw4Flf/XNJ8ouLK5jW5G7x6qB8BmP986ZSvv4eNrY
	tOKRjFhmJlkynO8Gmx6vBa948NrVor2hoWr4ek4P4Ue3ZmPVBrr0qs2GfihWYEoho2tF+dpEstKWo
	Izk1SlFg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGYsO-0053dS-2z;
	Fri, 22 Dec 2023 06:19:16 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org
Subject: [PATCH] tpm: cr50: fix kernel-doc warning and spelling
Date: Thu, 21 Dec 2023 22:19:16 -0800
Message-ID: <20231222061916.9552-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc notation to prevent a warning:
tpm_tis_i2c_cr50.c:681: warning: Excess function parameter 'id' description in 'tpm_cr50_i2c_probe'

and fix a spelling error reported by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org
---
 drivers/char/tpm/tpm_tis_i2c_cr50.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -- a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -235,7 +235,7 @@ out:
  * @len:	Number of bytes to write.
  *
  * The provided address is prepended to the data in 'buffer', the
- * cobined address+data is sent to the TPM, then wait for TPM to
+ * combined address+data is sent to the TPM, then wait for TPM to
  * indicate it is done writing.
  *
  * Return:
@@ -671,7 +671,6 @@ MODULE_DEVICE_TABLE(of, of_cr50_i2c_matc
 /**
  * tpm_cr50_i2c_probe() - Driver probe function.
  * @client:	I2C client information.
- * @id:		I2C device id.
  *
  * Return:
  * - 0:		Success.

