Return-Path: <linux-kernel+bounces-16321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EE1823CC7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FBE628707C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AB1200A6;
	Thu,  4 Jan 2024 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="siffy2q7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18050200A0;
	Thu,  4 Jan 2024 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4047Xdm3063000;
	Thu, 4 Jan 2024 01:33:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704353619;
	bh=1YL4NazULIndzcTvOUJLeOSh+6JCTKDvgwntK+e06L8=;
	h=From:To:CC:Subject:Date;
	b=siffy2q77BbTdXaUwKd9xiGfAyS0v0FF1SmYGbIzpdwDrvAUFF20QFgoTsgyHzGVL
	 jcRZX/NKUJ78N1BaW9DQTdzJ+3gPSClr/dXDaegC7W3ZlfqiPj8hmUJljwmx/dU/FN
	 BjZIWpjvVnXIbxA+pfP093qpjcsucFf5/kDcrBe4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4047XdaZ082970
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jan 2024 01:33:39 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jan 2024 01:33:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jan 2024 01:33:38 -0600
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4047Xatc060915;
	Thu, 4 Jan 2024 01:33:37 -0600
From: Dhruva Gole <d-gole@ti.com>
To: Jonathan Corbet <corbet@lwn.net>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dhruva Gole
	<d-gole@ti.com>
Subject: [PATCH] Documentation: index: Minor re-arrangement and improvements
Date: Thu, 4 Jan 2024 13:03:17 +0530
Message-ID: <20240104073317.19709-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

* It seems odd that a develper is forced to look at the licensing rules
  even before they get to the doc or coding guide.
  This belongs under the "Working with the development community" / "All
  development docs" page where it does reside even today.
* Rearrange the section for Internal API manuals to go lower because
  generally one would want to look at the tools and processes and admin
  guide pages first and then move onto something deeper like the API
  manuals.
* Reword the Dev tools section and title to something a bit more suitable.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 Documentation/index.rst | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 36e61783437c..409eba0b9601 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -28,30 +28,14 @@ community and getting your work upstream.
    maintainer/index
    All development-process docs <process/index>
 
-
-Internal API manuals
-====================
-
-Manuals for use by developers working to interface with the rest of the
-kernel.
-
-.. toctree::
-   :maxdepth: 1
-
-   core-api/index
-   driver-api/index
-   subsystem-apis
-   Locking in the kernel <locking/index>
-
-Development tools and processes
+Development tools and resources
 ===============================
 
-Various other manuals with useful information for all kernel developers.
+Various tools and manuals with useful information for all kernel developers.
 
 .. toctree::
    :maxdepth: 1
 
-   process/license-rules
    doc-guide/index
    dev-tools/index
    dev-tools/testing-overview
@@ -81,6 +65,20 @@ developers seeking information on the kernel's user-space APIs.
 See also: the `Linux man pages <https://www.kernel.org/doc/man-pages/>`_,
 which are kept separately from the kernel's own documentation.
 
+Internal API manuals
+====================
+
+Manuals for use by developers working to interface with the rest of the
+kernel.
+
+.. toctree::
+   :maxdepth: 1
+
+   core-api/index
+   driver-api/index
+   subsystem-apis
+   Locking in the kernel <locking/index>
+
 Firmware-related documentation
 ==============================
 The following holds information on the kernel's expectations regarding the

base-commit: d0b3c8aa5e37775cd7c3ac07b256218df0fd6678
-- 
2.34.1


