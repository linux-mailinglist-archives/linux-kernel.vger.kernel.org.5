Return-Path: <linux-kernel+bounces-8379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C69681B66A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9201C23DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD00178E68;
	Thu, 21 Dec 2023 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nQiyCDRM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814FA7763A;
	Thu, 21 Dec 2023 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLCi60q025883;
	Thu, 21 Dec 2023 12:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=phPIN0ZwNDekcG7ylwP4lSj9ayz0wiCzx24MQJkmZl8=;
 b=nQiyCDRMBuTDl2riVMjrx18xKTTt4mBlBMC/xcP+xzZUTzod3zjyeIXb5B3iVBEnAbXJ
 bg1Dy0Io9gUIxMDnREgmNfAbl+U41BvBiS6epZVkIb09s3LRhfllYHSJz9W/L79Q4S8+
 0wSlrwBqEbqVOxAEIkoymrxm+r88Lgay8y08S5eZY2gmma3EAUvmdEICHUzgL1c4mJam
 RYHX3q4zsx3HryoQMBIC3Hcf33pqhp/htd6ajzU1raLuRSD+zam8bjKsPhBk4ekgpqOO
 esdCYJ3Lm9QNxparEWfBrmaPIqtf8FRHl1YzagU5GFiPJDVL+XGfsSJ5f32y9H8CqXbr 8Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v4b4891c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 12:48:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLBGxDo039756;
	Thu, 21 Dec 2023 12:48:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bb309r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 12:48:35 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BLCmSsU039413;
	Thu, 21 Dec 2023 12:48:34 GMT
Received: from t460-2.nl.oracle.com (dhcp-10-175-32-150.vpn.oracle.com [10.175.32.150])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3v12bb304w-3;
	Thu, 21 Dec 2023 12:48:34 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Jonathan Corbet <corbet@lwn.net>, Jaroslav Kysela <perex@perex.cz>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH 2/2] Documentation: move driver-api/dcdbas to userspace-api/
Date: Thu, 21 Dec 2023 13:48:16 +0100
Message-Id: <20231221124816.2978000-3-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221124816.2978000-1-vegard.nossum@oracle.com>
References: <20231221124816.2978000-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_06,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312210096
X-Proofpoint-GUID: SIQx0zabCKezwnC4I5jfO04y2dcGYa6A
X-Proofpoint-ORIG-GUID: SIQx0zabCKezwnC4I5jfO04y2dcGYa6A

This file documents a sysfs interface that is intended for systems
management software. It does NOT document any kind of kernel driver
API. It is also not meant to be used directly by system administrators
or users.

Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/driver-api/index.rst                     | 1 -
 Documentation/{driver-api => userspace-api}/dcdbas.rst | 0
 Documentation/userspace-api/index.rst                  | 1 +
 MAINTAINERS                                            | 2 +-
 drivers/platform/x86/dell/Kconfig                      | 2 +-
 drivers/platform/x86/dell/dcdbas.c                     | 2 +-
 6 files changed, 4 insertions(+), 4 deletions(-)
 rename Documentation/{driver-api => userspace-api}/dcdbas.rst (100%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index b1b82ac1063b..b38f81836118 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -78,7 +78,6 @@ available subsections can be seen below.
    backlight/lp855x-driver.rst
    connector
    console
-   dcdbas
    eisa
    isa
    io-mapping
diff --git a/Documentation/driver-api/dcdbas.rst b/Documentation/userspace-api/dcdbas.rst
similarity index 100%
rename from Documentation/driver-api/dcdbas.rst
rename to Documentation/userspace-api/dcdbas.rst
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 277b7a40ca91..74bc0716432e 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -32,6 +32,7 @@ place where this information is gathered.
    futex2
    tee
    isapnp
+   dcdbas
 
 .. only::  subproject and html
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 7b6d2dbe4f1d..aa9c4c7ebe71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5901,7 +5901,7 @@ DELL SYSTEMS MANAGEMENT BASE DRIVER (dcdbas)
 M:	Stuart Hayes <stuart.w.hayes@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	Documentation/driver-api/dcdbas.rst
+F:	Documentation/userspace-api/dcdbas.rst
 F:	drivers/platform/x86/dell/dcdbas.*
 
 DELL WMI DDV DRIVER
diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
index bdd78076b1d7..e712df67fa6b 100644
--- a/drivers/platform/x86/dell/Kconfig
+++ b/drivers/platform/x86/dell/Kconfig
@@ -37,7 +37,7 @@ config DCDBAS
 	  Interrupts (SMIs) and Host Control Actions (system power cycle or
 	  power off after OS shutdown) on certain Dell systems.
 
-	  See <file:Documentation/driver-api/dcdbas.rst> for more details on the driver
+	  See <file:Documentation/userspace-api/dcdbas.rst> for more details on the driver
 	  and the Dell systems on which Dell systems management software makes
 	  use of this driver.
 
diff --git a/drivers/platform/x86/dell/dcdbas.c b/drivers/platform/x86/dell/dcdbas.c
index 76787369d7fa..a60e35056387 100644
--- a/drivers/platform/x86/dell/dcdbas.c
+++ b/drivers/platform/x86/dell/dcdbas.c
@@ -7,7 +7,7 @@
  *  and Host Control Actions (power cycle or power off after OS shutdown) on
  *  Dell systems.
  *
- *  See Documentation/driver-api/dcdbas.rst for more information.
+ *  See Documentation/userspace-api/dcdbas.rst for more information.
  *
  *  Copyright (C) 1995-2006 Dell Inc.
  */
-- 
2.34.1


