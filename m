Return-Path: <linux-kernel+bounces-143613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3B88A3B6D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF791C212C1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 07:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC67F20DD3;
	Sat, 13 Apr 2024 07:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=michael.haener@siemens.com header.b="noGgncqN"
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2513A1802B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712992611; cv=none; b=GfexaIgZ46fBRd7ib8cHne+WshWTQuWTDd4nVh42z/pCAXFq5QhEjQTtubTToaOcbWRcFieVHEcVsbTwGotkDopMIHNfdp2xB6YVjxB1rN/0Jl7ESdq7RkiM3RqQqSIR6kOlwp+FZ7eswzTh2aB4DUQPS8V7qxF608NfX+OzhFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712992611; c=relaxed/simple;
	bh=VYCAoTa/V/nFhj2VwkHIfOAHACMhnfVxJTdBdmtICIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoC8bVEfcJ0bIYv4WGFdk35G1Vog2C4bjXJ4qbhwDIKI+TMsTb7hMELdTb6ZRmKFC9LvTg57INY/ISgkbG3ha36Ra5dJfzRrhbW6Xp1oBcIb9+iJA5zJ3sj+iTztOJvrAPpnJB7lNFIB3sMk8FVzEEkGZpfysbEAfyoYceZ9AOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=michael.haener@siemens.com header.b=noGgncqN; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2024041307164199bd038270c0ede9ea
        for <linux-kernel@vger.kernel.org>;
        Sat, 13 Apr 2024 09:16:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xsKJ0SsOx0zGh02X8aXwuRhZZ+HQQlUaqaI2dbR4X/I=;
 b=noGgncqNdEsXeWDcacL14GwgaeyD+T1mxWVXmnyzB4xmZLjcth+8P5P77Y6h+MpKcPXB0b
 L+4e1VGW8osEPc9bpI3KNtr9vuX/GuMc9oOQtkBjPHn7ZczoFtOfmmVL1U2Tv/CNEpLePqcr
 QxsuDpsZxov3LaTr5xlxj7DSxESUQ=;
From: "M. Haener" <michael.haener@siemens.com>
To: linux-integrity@vger.kernel.org
Cc: Michael Haener <michael.haener@siemens.com>,
	linux-kernel@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH 1/2] tpm: tis_i2c: Add compatible string st,st33ktpm2xi2c
Date: Sat, 13 Apr 2024 09:15:06 +0200
Message-ID: <20240413071621.12509-2-michael.haener@siemens.com>
In-Reply-To: <20240413071621.12509-1-michael.haener@siemens.com>
References: <20240413071621.12509-1-michael.haener@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer

From: Michael Haener <michael.haener@siemens.com>

Add "st,st33ktpm2xi2c" to the TPM TIS I2C driver. The Chip is compliant
with the TCG PC Client TPM Profile specification.

For reference, a datasheet is available at:
https://www.st.com/resource/en/data_brief/st33ktpm2xi2c.pdf

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
 drivers/char/tpm/tpm_tis_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index 9511c0d50185..1f277c34e6da 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -384,6 +384,7 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
 static const struct of_device_id of_tis_i2c_match[] = {
 	{ .compatible = "infineon,slb9673", },
 	{ .compatible = "nuvoton,npct75x", },
+	{ .compatible = "st,st33ktpm2xi2c", },
 	{ .compatible = "tcg,tpm-tis-i2c", },
 	{}
 };
-- 
2.44.0


