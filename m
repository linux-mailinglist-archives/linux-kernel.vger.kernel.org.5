Return-Path: <linux-kernel+bounces-14521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40A9821E3D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46661C2211D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C5714F68;
	Tue,  2 Jan 2024 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="baemNkk6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6038214A8A;
	Tue,  2 Jan 2024 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4029fW3a029874;
	Tue, 2 Jan 2024 08:57:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=FQcaaKgZ25950Vl7J8BFcyjXBXxpMI4LcMtWcp/LUQ4=; b=
	baemNkk63Npkm5ASJaDPZarieURaYMUb5EBWaDSsCbDd3iau6iUY+OkICL625Hae
	0LoLd/oqqhYfR8m0QsFI+eZ/nFX/Y1pR7244KgWa7nuDPam8g0XvRmB6CUP3BN0G
	rM5crt41MxvLBjlzObzAKvm3xqr8Z/Bfa4f60TqJ1h8Gu0iRrGKQ6bAMjjublj2+
	xEU7Q0r6W8GM346NmPzU8T2h+L+OdkTpNrVj3c05xcaF1txR/TfjCkfjGJJ2gSLZ
	6TSFr8fMCJt2aPfMez1dweQXJrOUQXqObdyS7GdAT2/7c0MNLb+lLvaIakmG/XNV
	AVx3cw/ShN5FzVwr/SpRfA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vahg2b9t3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 08:57:36 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 2 Jan
 2024 14:57:35 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Tue, 2 Jan 2024 14:57:35 +0000
Received: from aus-sw-rshr002.ad.cirrus.com (aus-sw-rshr002.ad.cirrus.com [141.131.145.53])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0A3E446B;
	Tue,  2 Jan 2024 14:57:33 +0000 (UTC)
From: James Ogletree <jogletre@opensource.cirrus.com>
To: 
CC: James Ogletree <jogletre@opensource.cirrus.com>,
        Dmitry Torokhov
	<dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open
 list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
	<linux-input@vger.kernel.org>,
        "open list:DOCUMENTATION"
	<linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND 2/2] Documentation: Input: support pre-stored effects
Date: Tue, 2 Jan 2024 14:56:13 +0000
Message-ID: <20240102145614.127736-2-jogletre@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240102145614.127736-1-jogletre@opensource.cirrus.com>
References: <20240102145614.127736-1-jogletre@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: DtDe0HGe9jeXqCMREGTBRcJANEU_UcDL
X-Proofpoint-ORIG-GUID: DtDe0HGe9jeXqCMREGTBRcJANEU_UcDL
X-Proofpoint-Spam-Reason: safe

Document FF_PRESTORED.

Signed-off-by: James Ogletree <jogletre@opensource.cirrus.com>
---
 Documentation/input/ff.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/input/ff.rst b/Documentation/input/ff.rst
index 5a1da42c33b3..1e0d00a42f25 100644
--- a/Documentation/input/ff.rst
+++ b/Documentation/input/ff.rst
@@ -85,6 +85,7 @@ following bits:
 - FF_FRICTION	can simulate friction
 - FF_DAMPER	can simulate damper effects
 - FF_RUMBLE	rumble effects
+- FF_PRESTORED  pre-stored effects
 - FF_INERTIA    can simulate inertia
 - FF_GAIN	gain is adjustable
 - FF_AUTOCENTER	autocenter is adjustable
-- 
2.25.1


