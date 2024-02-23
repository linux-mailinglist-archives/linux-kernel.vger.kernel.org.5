Return-Path: <linux-kernel+bounces-78527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87E0861482
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B105C1C22FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB54823B7;
	Fri, 23 Feb 2024 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="fbPLG6p4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="KiF/g1SY"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9CE81ACE;
	Fri, 23 Feb 2024 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699697; cv=none; b=JssqqNt+zq0ZkagerYvPhhwd0J/obS2nNMYEo4IbZaZf8juoTmLXkZvZze3y21zfitJ7lIe+23daJREijNB6BmXy6EugfG0KhJsY6123BT+IGsVBWXyyK3Pc4j7NQC8kb0G8CdAB3nocmqp5NihCEROeJjOLn0cPkhdSynLcoUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699697; c=relaxed/simple;
	bh=TcKRiqD1avqj5d4UM1YCOl9XANifRE2wGCbfKlJvb2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UbUV3QX2kEsqPc0vgqL7m1IkmmX6/GNkZifzw0AIumSgKJFMdmLdVs1DjkOYZk8C6W+Hov8diU5z/PQr3W9Im0RV0ScBgjaAeHYZZMZf+tD5nrs3k2YR2YYm87GktI4VHandYKro246lYI7L1fi/STpqzs/qZeXHJv1hgNyxnDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=fbPLG6p4; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=KiF/g1SY reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708699695; x=1740235695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dyYg3RanWPoFpMG4uxCkFXrJ4e1P2Kg1t/VKgWAvNU4=;
  b=fbPLG6p4pqienueRHNcxp2xM1GUwDmiqvSq+1Q3pDkmFxxEn0yDgnYas
   vXnjo0ZUAn2KQvSHdkK6qJHdFMaipy0P0l2tOLLZgnTj+HZFgermKdkO/
   Vhx3mf1twioxNib3NmosI82DLHe7YWauwuNtTeorFXMJtITqu9UXO4a6c
   EDFzhpRPNUmwVtRNYs8lISVTY93HzxwvsVhWz+1E63IsYc0rl9ncLSz+3
   3le8LcmEKtvlxu0yxkFMV/csLWRyQPmvPK1NN1pXQtAH63MNbfvN3ZqTQ
   Mz0S/MsuU700aJXXktJMHgvVyN6vTSGR/mTpd/IIJHTLCXiPIJaRdIOG5
   A==;
X-IronPort-AV: E=Sophos;i="6.06,180,1705359600"; 
   d="scan'208";a="35570390"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Feb 2024 15:48:13 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 75CC01706D7;
	Fri, 23 Feb 2024 15:48:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1708699689; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=dyYg3RanWPoFpMG4uxCkFXrJ4e1P2Kg1t/VKgWAvNU4=;
	b=KiF/g1SYFy63V8Qe7HLbfVD9piYSplvLDtLGFOwxGnmQW4CLEGEGK0tX0KJwnAOrz8P4Kf
	CZxtx/Y86CH2O36B0aOU45bmFbGvbskBVOOrmsOV5fQkASqNS6pKUgvPTI2dMD5WU0aS2A
	trQae3E5Dr2T1Ex/tAeOXEiN41RBq0Be54p51wbiZlkLqGHA2SpMMBeJ1FALUHwIpG2Zdn
	upbO+3C/bes36H0SwTXZuxBzoVOO1+druY1976B0HzUq+OuoEZpNqf+Vz5Ry17ZdMjNDv0
	qkERSk1kBAt3UjwfATOI8Sq4LfHEGLG6qT3m4CFAoQ8LSUVsDh9VZ2YNIYIlcA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Alain Volmat <alain.volmat@foss.st.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] media: dt-bindings: gc2145: use absolute path to other schema
Date: Fri, 23 Feb 2024 15:47:43 +0100
Message-Id: <20240223144746.2583749-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223144746.2583749-1-alexander.stein@ew.tq-group.com>
References: <20240223144746.2583749-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Absolute path to other DT schema is preferred over relative one.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Added new patch

 .../devicetree/bindings/media/i2c/galaxycore,gc2145.yaml        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
index 1726ecca4c77e..9eac588de0bc2 100644
--- a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
@@ -19,7 +19,7 @@ description:
   either through a parallel interface or through MIPI CSI-2.
 
 allOf:
-  - $ref: ../video-interface-devices.yaml#
+  - $ref: /schemas/media/video-interface-devices.yaml#
 
 properties:
   compatible:
-- 
2.34.1


