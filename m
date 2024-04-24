Return-Path: <linux-kernel+bounces-156253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583EB8B004D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCA41F244BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA2513E031;
	Wed, 24 Apr 2024 04:03:53 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1800.securemx.jp [210.130.202.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A007B2E62F;
	Wed, 24 Apr 2024 04:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713931433; cv=none; b=hqz7o4KBHAzD4dsoj1XvYt5i/9aVZxSCy8ke12LBBaggseOFVHsGJ2K7kDUM9BwrcNWnPnwD8jXGsZKds9zvy/CN28DLMqd6KljFMAm69PdqSlyskKNKyE1/Xkp0tg4GmNoPLFhnZllGCO7870pTzXNoH4+lbztDYNOCrx/8Etg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713931433; c=relaxed/simple;
	bh=B+h7Jp/6EvvI1Jk4SY22xj4TXHpSNWzg+I/jNd1g5rA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qy/IFTZN6OhYVPOKQZ6qWtA28vTKyUYCZmYypRsqF+R+yWCB2F9iOGvREqhT1tEvpeS8WfeC07lqawSo5vDPyhok9Wodi/JS71+KFlHPnGvhJuKj2eem++sEqrC/vN00HXdJA9NO4kxmfxmDXTz9sPdmDaaKfk/xddmKnAgVpOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; arc=none smtp.client-ip=210.130.202.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1800) id 43O2mE6n1268714; Wed, 24 Apr 2024 11:48:14 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 43O2lj242370929; Wed, 24 Apr 2024 11:47:45 +0900
X-Iguazu-Qid: 2yAbrn6vF8CAnmg93Q
X-Iguazu-QSIG: v=2; s=0; t=1713926864; q=2yAbrn6vF8CAnmg93Q; m=iex2HuYsQnWVyYTk4Z4OYAj4t75rip2eB59cUQhQG/g=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 43O2lgGh1789569
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 24 Apr 2024 11:47:42 +0900
X-SA-MID: 21956149
From: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To: Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 6/6] MAINTAINERS: Add entries for Toshiba Visconti Video Input Interface
Date: Wed, 24 Apr 2024 11:42:15 +0900
X-TSB-HOP2: ON
Message-Id: <20240424024215.1624299-7-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424024215.1624299-1-yuji2.ishikawa@toshiba.co.jp>
References: <20240424024215.1624299-1-yuji2.ishikawa@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added entries for visconti Video Input Interface driver, including;
* device tree bindings
* source files
* documentation files

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
Changelog v2:
- no change

Changelog v3:
- added entry for driver API documentation

Changelog v4:
- added entry for header file

Changelog v5:
- no change

Changelog v6:
- update path to VIIF driver source files

Changelog v7:
- no change

Changelog v8:
- rename bindings description file

Changelog v9:
- no change

Changelog v10:
- add a separate entry of VIIF driver

 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c23fda1aa1..411e708d06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22408,6 +22408,17 @@ F:	Documentation/devicetree/bindings/media/i2c/tc358743.txt
 F:	drivers/media/i2c/tc358743*
 F:	include/media/i2c/tc358743.h
 
+TOSHIBA VISCONTI VIIF DRIVER
+M:	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+M:	Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	Documentation/admin-guide/media/visconti-viif.*
+F:	Documentation/devicetree/bindings/media/toshiba,visconti5-viif.yaml
+F:	Documentation/userspace-api/media/v4l/metafmt-visconti-viif.rst
+F:	drivers/media/platform/toshiba/visconti/
+F:	include/uapi/linux/visconti_viif.h
+
 TOSHIBA WMI HOTKEYS DRIVER
 M:	Azael Avalos <coproscefalo@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.25.1



