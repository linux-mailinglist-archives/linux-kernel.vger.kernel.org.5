Return-Path: <linux-kernel+bounces-37229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B50D383AD10
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EE68B2C620
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA6D7E56C;
	Wed, 24 Jan 2024 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="OoDnj98G"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8089F7C0B1;
	Wed, 24 Jan 2024 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109163; cv=none; b=Ov8hKe4VBgDhIuwvDLieRID4lr/jWnPIDgv+XIieh7oawEnqeba6EjIdRo6XpNPiWsiKDZGlPjBrsh+n9WXV66cS9hbZXFsMXWQAppjD0wmi4Xms3YFyvhkbwsJCyGvgocl9egmICIeHvbVRzRJ+UIHmO2yK/P3XtgwG/Dcn6Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109163; c=relaxed/simple;
	bh=hF3K/gUsFrwyAXguG8YMNRx6B6jS2KuTPFZt05WQXmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPIPrCTgF/f8/s5kwpndA/pJe+1S0S2i48CnPrAeAAQ4POGc8YXr5uxNmGqne/jHtU1hAiU2V9WPgqIAq/TO8kH+uiUJgMugufbQAYwRm588NosniGZ5F0h3scMM/pVUjSFI2OwJ05YDyzcWCbngwU2F/qMK8KFA9FE3F7SJy9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=OoDnj98G; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O7L4cw000450;
	Wed, 24 Jan 2024 09:12:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=wgj3eRfleW5Mz0nqH1lHLI3/P/b9w4Ck+OmjbqRx6q0=; b=
	OoDnj98G4FC8Xkhqm2eLfEeybaMnAaY6nAS7eWfVlzMTVg4AbRtIW3dtxw1L+2s9
	LaSMe5Ug77xMpsUer+ZAadpdj2SJ4CNpa9lRdCrRkXbVSM6HJc68CwQdnIzqFANm
	G9HIjB3G+Zo+nkxJXsvlvpGFdmgPSPxFw05k3lFdf/7ppDnjJ1iT3jYzVAukrdiK
	dY+mCs6vjhaCZYd44oIQ4txyIyQuwA7zLAZYr6mPewhExDeUDZhBNQdjnY8KEfdi
	3NQN4mVCTRD7W8HAZmWeIDig0Xw7/CK13M29kE7QziPe6+TN3H7aKarCKvPhgK82
	x2DKcRimslMOOGjaNxGaRw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmfhgxx7-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 09:12:26 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 15:12:22 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Wed, 24 Jan 2024 15:12:22 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 607A682024B;
	Wed, 24 Jan 2024 15:12:22 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>, <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH 6/6] spi: cs42l43: Tidy up header includes
Date: Wed, 24 Jan 2024 15:12:22 +0000
Message-ID: <20240124151222.1448570-6-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240124151222.1448570-1-ckeepax@opensource.cirrus.com>
References: <20240124151222.1448570-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: w6xx7tPtpA7FU_dWuxWMA2-30RFpi6DB
X-Proofpoint-GUID: w6xx7tPtpA7FU_dWuxWMA2-30RFpi6DB
X-Proofpoint-Spam-Reason: safe

Including some missing headers.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

The changes to the MFD headers necessitate the inclusion of of.h here to
keep things building, hence my including this SPI change in the this MFD
series. The rest of the SPI fixups will be sent separately, as they are
also not dependent on this change.

Thanks,
Charles

 drivers/spi/spi-cs42l43.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index d239fc5a49ccc..fb62807fc991c 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -11,7 +11,9 @@
 #include <linux/errno.h>
 #include <linux/mfd/cs42l43.h>
 #include <linux/mfd/cs42l43-regs.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
-- 
2.30.2


