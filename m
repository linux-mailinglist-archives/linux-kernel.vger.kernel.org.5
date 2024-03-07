Return-Path: <linux-kernel+bounces-95393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5C5874D22
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED601F2207C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F0D1292D6;
	Thu,  7 Mar 2024 11:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="lo2RdtTu"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64C786AC5;
	Thu,  7 Mar 2024 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809945; cv=none; b=Sl7kI4MWbA3yZf6vOcxbyT1H9G041+mO4MA6jsyI83YD9jVT3bz0nc7OEVw2F5pdVWEBh/Bu3y3ciFCuiwFctRFWrj3oSopUYfnHIdQLQ7qxPBTLyf7bSph35eKoAsZ867hvTRw78AF+9l5nAvKLigWSHhJvzy/RYTGSEJjvRHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809945; c=relaxed/simple;
	bh=3rWMw8R+NsnkFdzxFdqowjz8po9SnkV8ho17BYS6idY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ek6xh2Mzizz8/yIhrxmZX3S8ey7/QoM1JBFIPLmiV92exwlcg+dHXvB0M7TkMdtxyxlTps0lAFgDk4fsHDEryxJkGTITbCdu8LYOXOEdlOKKyVgqdMJO7OALw3k3Aav8WL3PsDMcU8Z/v7Cxyn+PSmAO4NreGHXgl5q1KXtOumI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=lo2RdtTu; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4278beip008605;
	Thu, 7 Mar 2024 05:12:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=FiXXVGoZ6B/v7js0WzJUH1DmMPvwXnS9aA/7lbdCnac=; b=
	lo2RdtTuwP162GMPOVP0PSg+54uZL6Pvkos432aC/zc7120PMo/errG2vt0U87QS
	5EDKIzGT6nhKxFrlEIXYjEFjYpKU6KZQ89VrIsMSSBU4hJIveAzwu2EFmhQqP49c
	hNqaP5iCs7sHjcFG8kEq5mgZD3ghgrG7hOLr6p+IzIGa5+Nm4+KHGA4ILS6xil+C
	sVWTL+XdpeEPfbTNiRX70nV0Qv50OcV4zaGanRNFkMIEhtOUBN3m7oPsSLBhImsA
	bOw0AZgfGJD75/gRZO7WQ7jhuR5kWo+eiddBQRF6R3k3dybzlZyl03HHxLb5T7N8
	vT50rBgXBk8LeZ0Sk1/bZw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wpn931ha8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 05:12:18 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Mar 2024
 11:12:17 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Thu, 7 Mar 2024 11:12:17 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id D746982024D;
	Thu,  7 Mar 2024 11:12:16 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 2/2] ALSA: hda: hda_component: Include sound/hda_codec.h
Date: Thu, 7 Mar 2024 11:12:16 +0000
Message-ID: <20240307111216.45053-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240307111216.45053-1-rf@opensource.cirrus.com>
References: <20240307111216.45053-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: MYpp-lhqeIV3bEWwZXEjznVqAX-5uGuo
X-Proofpoint-ORIG-GUID: MYpp-lhqeIV3bEWwZXEjznVqAX-5uGuo
X-Proofpoint-Spam-Reason: safe

hda_component.h uses hda_codec_dev from sound/hda_codec.h.
Include sound/hda_codec.h instead of assuming that it has already
been included by the parent .c file.

This isn't causing any problems with current code, so no need to
backport to older kernels.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/hda_component.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/hda_component.h b/sound/pci/hda/hda_component.h
index a0fcc723483d..c80a66691b5d 100644
--- a/sound/pci/hda/hda_component.h
+++ b/sound/pci/hda/hda_component.h
@@ -11,6 +11,7 @@
 
 #include <linux/acpi.h>
 #include <linux/component.h>
+#include <sound/hda_codec.h>
 
 #define HDA_MAX_COMPONENTS	4
 #define HDA_MAX_NAME_SIZE	50
-- 
2.30.2


