Return-Path: <linux-kernel+bounces-144028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 420738A4109
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7A11C20906
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 07:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1E2224F2;
	Sun, 14 Apr 2024 07:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=michael.haener@siemens.com header.b="bU6q3mAg"
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D296D208CB
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713080838; cv=none; b=CboINpdQhpbTYyYJnqlg76/CrQrlHFpWqbot5o0Vo5B485y9x++Opr5dFUCRUwa/W/sNHzPs8NWlesvLQZPbFI2fEGihKVFmmRDF5R7VqwK1juzBxCVRfs2Nwz7ZTZOp8YDTigIWePXULy60KPLbJasvxDcpCypsyd7ues1Wpjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713080838; c=relaxed/simple;
	bh=wQea2tyYBTO3Rm5iZ2ymgFo1OjYsWUCinvHPbWVk9PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kv5YrAIEsjL5xGIPihr9gIiEfSfwvZG/k1h2GNs721NhfWebcbjMOZChxVRXQ8PFTB/BnzjWSfH8xG38CWa9wGwPZMEHFdmMyMFCrwFKHI9UFV6HKHm5JwnKdFf1kQKynieCHf/ITGTWHa85EqQtHO/i2CStC6HkoMrWhNjdaAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=michael.haener@siemens.com header.b=bU6q3mAg; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2024041407470896313c07bf89804fb3
        for <linux-kernel@vger.kernel.org>;
        Sun, 14 Apr 2024 09:47:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=zOpcPhWSOCFP5rXAAol0thmH6IFMyBi/W3sh1X5FAvc=;
 b=bU6q3mAgWLtXe/TzDLRXmXqH5Qzq2LiOcGD11xgfjrE+5OsWZ6XoWti3iCnyFWM/KpI7at
 RArSFvn/I35rHUUkrrRji+wdXJeV8If9pJIARTiyRL+/u7pqyeTKa1XGyuM5RNE3JIaDORwt
 pjqpHIRmh43CVnxHRCUWpfzRahVsk=;
From: Michael Haener <michael.haener@siemens.com>
To: linux-integrity@vger.kernel.org
Cc: Michael Haener <michael.haener@siemens.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH v2 1/1] dt-bindings: tpm: Add st,st33ktpm2xi2c
Date: Sun, 14 Apr 2024 09:44:34 +0200
Message-ID: <20240414074440.23831-2-michael.haener@siemens.com>
In-Reply-To: <20240414074440.23831-1-michael.haener@siemens.com>
References: <20240414074440.23831-1-michael.haener@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer

Add the ST chip st33ktpm2xi2c to the supported compatible strings of the
TPM TIS I2C schema. The Chip is compliant with the TCG PC Client TPM
Profile specification.

For reference, a datasheet is available at:
https://www.st.com/resource/en/data_brief/st33ktpm2xi2c.pdf

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
 Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
index 3ab4434b7352..af7720dc4a12 100644
--- a/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
+++ b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
@@ -32,6 +32,7 @@ properties:
           - enum:
               - infineon,slb9673
               - nuvoton,npct75x
+              - st,st33ktpm2xi2c
           - const: tcg,tpm-tis-i2c
 
       - description: TPM 1.2 and 2.0 chips with vendor-specific I²C interface
-- 
2.44.0


