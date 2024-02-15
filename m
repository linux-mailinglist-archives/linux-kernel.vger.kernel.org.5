Return-Path: <linux-kernel+bounces-66488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AD1855D67
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5486B1C209D6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6455C182DB;
	Thu, 15 Feb 2024 09:05:27 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3591F1BDCE;
	Thu, 15 Feb 2024 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987927; cv=none; b=L+M1svmpIcc6na7RvlGeECkxacdz0Ia+av7aVZZ9LaR5mLhYb9f3Ky8dL7rx0sGiYCxBiwylmwmxmKiVLs1WzkkqQEksCQtKKsuPl/yovhEJUgzERuuK3v323vVeKJjOs5KyCz+UVEmChkJqjpOvLirFdn7Efic4Y7b/KxqfB3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987927; c=relaxed/simple;
	bh=ni7i9p6FhBuB+4RQY0gV4ps5YNzcgFJ8gd9v8c6Fzgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q+lFy0BCAO+DIR0zS97iyHxhS4HlZNfsIdWDgynkdA3XCTsx5fPRVV63mayCGDLBkOurUOfSBjRdZPn4SyCtgxcg70FRs4GZkEDET29YvVHZbOBWsCpnb0iRpqhoC+kEjTy6KUqgWkVqONwBOp1BK/euwYwsmUyaI9qS5Eo3kRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1raXgE-0002M4-96; Thu, 15 Feb 2024 10:05:18 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: neil.armstrong@linaro.org
Cc: quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@theobroma-systems.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 2/3] dt-bindings: display: ltk500hd1829: add variant compatible for ltk101b4029w
Date: Thu, 15 Feb 2024 10:05:14 +0100
Message-Id: <20240215090515.3513817-3-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215090515.3513817-1-heiko@sntech.de>
References: <20240215090515.3513817-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Add the compatible for the ltk101b4029w panel, that is really similar
to the ltk500hd1829.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 .../bindings/display/panel/leadtek,ltk500hd1829.yaml          | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml b/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
index c5944b4d636c5..d589f16772145 100644
--- a/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
+++ b/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: leadtek,ltk500hd1829
+    enum:
+      - leadtek,ltk101b4029w
+      - leadtek,ltk500hd1829
   reg: true
   backlight: true
   reset-gpios: true
-- 
2.39.2


