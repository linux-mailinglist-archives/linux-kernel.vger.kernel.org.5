Return-Path: <linux-kernel+bounces-46875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EA18445B1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D4D1F25204
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E5812CD9F;
	Wed, 31 Jan 2024 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="CgWvmZnK"
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2615C12CD9D;
	Wed, 31 Jan 2024 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720930; cv=pass; b=g7DC5INDyzMqCo1Klyq6iUIuoY+Ce2f0Qcee0FH2qgnu9CB9Bj9uxQ1xY0hFM4yj7FqFsHtSrWGDFoq2BBoG7BRoLb6K9bNWClfrTCXafx482Mfi7gaFiBqgbkfmZW9/DULhJhOk07Z4Wb6K/Dy/MY1aFfr9jjo2oxAHRTubvq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720930; c=relaxed/simple;
	bh=foLZdtJaf3dwkHAyBp3JvO1GPfScZqHAa5oye1tQXu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lcj7BpDCPD0R3I6PdGd9dBOZZ+TEbVEeVgTjkFrRb3ASMvwAQCoa1JXE29S5ohfniC2y6AupQ0Qa0z0LiaQTr/k2wLPIbDtQLI4Zew29YPj1JR6X81C2cVxdz20Ycw5K4j0mrKcUqhBaGWqwwsgQCptZVFDmvS/EnUb6ht8T9Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=CgWvmZnK; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
Delivered-To: dpsmith@apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1706720916; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h18WEIigS5Svh8PKqKBkI/fMkUus+VVqRtPy0fZRM0GygiMi1inZCi1oGqL49CxmlSrZhgTvEcCu4y4weqMF/H9aiv0deG2fup9NvtX9IZ2zRT7r7f8oxcQNxp6XFpw1Z+kvp3IBdvMP2fxocK9ulcF6LwsiMiriQ/nJNlAtwIg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1706720916; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=h0m6s7A7yWn0LEIvIuinrWRz0FAsqDfPRmBpoyWc61s=; 
	b=m+9tviKLGIkfA9ubEdl4HDPGh5s2dxg1rhlDOVVSHaDoJ2+fpSKrKO+F41qb8Ma2w0t5wED7muFfIIf4ADPVzxs0TxsMU48aWFXA5CKTPU6eTzwCrOmzUbUhrPQhCtcuDhqb+tVd0uN8fv9mHHV6x3srfDOgQ5Rk2BIMLBG9xzY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1706720916;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=h0m6s7A7yWn0LEIvIuinrWRz0FAsqDfPRmBpoyWc61s=;
	b=CgWvmZnK9T9Kq0viwHU4mO8eRu6GRaCej1TuRPoV9EU3hi6p/eM9CsDVpLhWUH4Y
	JPJUvieK+sV2q8xhwEP54z5GVWgLQKfdl5IGSG0OzVyTDoZDy00dKzV/gkHd1b2r521
	qsChDDlY/uxB3zUU1sSd5k4Mah6ysVcdKwP9vG/I=
Received: from sisyou.hme. (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1706720915107755.6194080525407; Wed, 31 Jan 2024 09:08:35 -0800 (PST)
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Daniel P. Smith" <dpsmith@apertussolutions.com>,
	Ross Philipson <ross.philipson@oracle.com>,
	Kanth Ghatraju <kanth.ghatraju@oracle.com>,
	Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH 1/3] tpm: protect against locality counter underflow
Date: Wed, 31 Jan 2024 12:08:21 -0500
Message-Id: <20240131170824.6183-2-dpsmith@apertussolutions.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240131170824.6183-1-dpsmith@apertussolutions.com>
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Commit 933bfc5ad213 introduced the use of a locality counter to control when a
locality request is allowed to be sent to the TPM. In the commit, the counter
is indiscriminately decremented. Thus creating a situation for an integer
underflow of the counter.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Reported-by: Kanth Ghatraju <kanth.ghatraju@oracle.com>
Fixes: 933bfc5ad213 ("tpm, tpm: Implement usage counter for locality")
---
 drivers/char/tpm/tpm_tis_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 1b350412d8a6..4176d3bd1f04 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -180,7 +180,8 @@ static int tpm_tis_relinquish_locality(struct tpm_chip *chip, int l)
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
 	mutex_lock(&priv->locality_count_mutex);
-	priv->locality_count--;
+	if (priv->locality_count > 0)
+		priv->locality_count--;
 	if (priv->locality_count == 0)
 		__tpm_tis_relinquish_locality(priv, l);
 	mutex_unlock(&priv->locality_count_mutex);
-- 
2.30.2


