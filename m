Return-Path: <linux-kernel+bounces-155439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA178AEA89
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EE94B22998
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EA413CFA1;
	Tue, 23 Apr 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="dtxy0eXn"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D5B13C820;
	Tue, 23 Apr 2024 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885326; cv=none; b=Ik8tk37bouu3+l2KycCYUAf6PzEZWb6qs67qkW1v0CNKX6L/j3egvpVc7c96id2p7JKRfopHP4pYWWTW7NC31CPY8iGomJqKnPJn3N61G8Z3ViI1ROWh1teGBkgyNDyPgPL9JlTE/u4nuyMGNlN5Trdunm1C2JUkNcv5eO/AzuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885326; c=relaxed/simple;
	bh=q7ENVWv/WOYza7AlbmCT3YYazD2RqSKJONhFzZ6LGq8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nlbqtmXdpqO+4+5YDVt3oko75dhxFdUHACpzd7e/eoQ49RfFg3zE0aRjiWJ2YE86X3/Mjqyne9HXlbdmZ7K+xHeXsKY9RAYQc1JOfQyiiQs73sH2WpaOjA44yFUtjaxKCAcCHwaqNx0Zn7OG1CfVGym7L6dyGBduwWhCfsO/Bfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=dtxy0eXn; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NCrG0r001313;
	Tue, 23 Apr 2024 17:15:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=selector1; bh=YrbfGC6FcWfI6XlLnm5j
	VHxXRTNO566YwlBwIxSBUcA=; b=dtxy0eXnxyrssG7R9zVW/dMuhjE2MX3r5G0Y
	3C5XG2TlLust1+yyHPD/bmFYUuZo7MEgR8VqbaW2HLlMZIFu5MRy+cLVFSvRMLRc
	S121R+VYpxv3LHab3/iibgNAq9tecQ56Vuk8HFvXSIiUqIXoxddc2JdCDTkQQUlZ
	IkICZYvHqNUsLPD0GNposLX5ZvbcBcfJWgpXSyW21WPToWVPpwDrh++pVqMbEtht
	jcTpco/mbjTA0wARonGNapvgwXqWX3A7Re4mrVHAtLbeDd99bRGytiMkHklYF/Ls
	KVbqPZ7xeWeTONZYvRP6TRIwdcGvLlbB+DyeC7Bmhr4TRJXc5A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm51w4ar5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 17:15:00 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8541240045;
	Tue, 23 Apr 2024 17:14:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 68093223661;
	Tue, 23 Apr 2024 17:14:14 +0200 (CEST)
Received: from localhost (10.48.86.103) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 17:14:14 +0200
From: Maxime MERE <maxime.mere@foss.st.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller"
	<davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>
CC: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob
 Herring <robh@kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] crypto: stm32/cryp - Improve stm32-cryp driver
Date: Tue, 23 Apr 2024 17:14:06 +0200
Message-ID: <20240423151409.902490-1-maxime.mere@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_02,2023-05-22_02

From: Maxime Méré <maxime.mere@foss.st.com>

This series of patches mainly aims to improve the usage of DMA with the
CRYP peripheral of the STM32 MPU series. The other two patches are needed
to enhance the driver's visibility for ST platforms.

This v2 address the kernel robot warnings.

Maxime Méré (3):
  crypto: stm32/cryp - use dma when possible.
  crypto: stm32/cryp - increase priority
  crypto: stm32/cryp - add CRYPTO_ALG_KERN_DRIVER_ONLY flag

 drivers/crypto/stm32/stm32-cryp.c | 724 ++++++++++++++++++++++++++++--
 1 file changed, 680 insertions(+), 44 deletions(-)

-- 
2.25.1


