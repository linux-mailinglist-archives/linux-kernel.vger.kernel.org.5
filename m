Return-Path: <linux-kernel+bounces-95367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E6B874CC6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AED22848AF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C55E1272A4;
	Thu,  7 Mar 2024 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gbcrLtK5"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F4F125DC;
	Thu,  7 Mar 2024 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808925; cv=none; b=SgJARsV6mEUXLRopfdUl3SfKXF/y9b9MqmWNELHWFx0mwhEO5crKyfvkKOvPrHtrB0nPWJoEFjYQ2fH/QsVECN+psC1ciuz2yTqUmi0JEhqtVY7h6WRuhIRNt0ia9c544LeliAdySgnFFNEvpHlWi0yIF2B+FwntkXpdZJTeGLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808925; c=relaxed/simple;
	bh=c2pfRKegllUwre/PwJmQYxRG47uR59AYi5sXveb40mc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cOxxlpSC2tv3IBaYMGKhze2Y1qvAZjAx/sAwDLAjw0FeYP/8gliGDMh1HxJj97bFOyhwVr/R9lSLvFl15Rq6QCZfcoNgQWSlDDHnzOyZRu9nQxvyO1mBgP6W3/GMYQN+BcyAs/tUbiacC68EKiAaBsPXKAkvGB2aIyhz37sPLn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=gbcrLtK5; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4276U3Nt025228;
	Thu, 7 Mar 2024 04:55:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=+
	6itJG20D909fOrrsxMInYc0fNTy/L9GVmmhKAtl9s4=; b=gbcrLtK5xt02wAlmo
	9AJp5VNInXpqgucouatAeBtSL7q/7F8dju+ct7ywGXL02bNnEKiTJk7JKJ2ZBXfW
	YXynqBiyzC6enVLXLkZvCyCho/USqAHGHGSWNbDhl6M2WqKWGWfayuN2IMYlvU9U
	IdU3fRas1XnpE4t2RbKm4hVblk3M2S6uyvnpOJvnPzaBlpUEY5gPMPZKb1GVg1TN
	N70wUuePaFvQuGM2SW/Pr1Hy1JsBya5KlfRLX7hNVA0iHI19Ak7wwl9F9gXzSRck
	1kbRAthDZEin81TTf6QL/eJaC0L0WFjzMgp+crmpDOBSNbDAUS0cdgJpkv2LFzEm
	x+9wg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wpn931gtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 04:55:18 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Mar 2024
 10:55:16 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Thu, 7 Mar 2024 10:55:16 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B63BF82024B;
	Thu,  7 Mar 2024 10:55:16 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH] firmware: cirrus: cs_dsp: Remove non-existent member from kerneldoc
Date: Thu, 7 Mar 2024 10:55:16 +0000
Message-ID: <20240307105516.40250-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6035ksXV5TBZiMrwZ5Q4wTBH6YWgkHpN
X-Proofpoint-ORIG-GUID: 6035ksXV5TBZiMrwZ5Q4wTBH6YWgkHpN
X-Proofpoint-Spam-Reason: safe

The kerneldoc for struct cs_dsp refers to a fw_file_name member but
there's no such member.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/linux/firmware/cirrus/cs_dsp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/firmware/cirrus/cs_dsp.h b/include/linux/firmware/cirrus/cs_dsp.h
index 29cd11d5a3cf..23384a54d575 100644
--- a/include/linux/firmware/cirrus/cs_dsp.h
+++ b/include/linux/firmware/cirrus/cs_dsp.h
@@ -123,7 +123,6 @@ struct cs_dsp_client_ops;
  * @sysclk_mask:	Mask of frequency bits within sysclk register (ADSP1 only)
  * @sysclk_shift:	Shift of frequency bits within sysclk register (ADSP1 only)
  * @alg_regions:	List of currently loaded algorithm regions
- * @fw_file_name:	Filename of the current firmware
  * @fw_name:		Name of the current firmware
  * @fw_id:		ID of the current firmware, obtained from the wmfw
  * @fw_id_version:	Version of the firmware, obtained from the wmfw
-- 
2.30.2


