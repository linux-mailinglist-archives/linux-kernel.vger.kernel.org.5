Return-Path: <linux-kernel+bounces-142443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1638A2BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4EB31F23899
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D171E53393;
	Fri, 12 Apr 2024 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="dWlwzDgG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="bohHk0Wu"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE68D502B7;
	Fri, 12 Apr 2024 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915791; cv=none; b=bx97Jj7LiXbEaLgPVR237TA1Sip8Gexpfvt5LZb0NxgRaeWZY2gSoxqx5biBNGsXASFADmOirzVVja+So9kNxBMl05PtcsFBgUZoE5HMkkoGVfjcfPrebVp9Tz2D7OoHY2BagH8Nzf3KJZ7qxmmV+W5sOImKl1ZuLaKTAU0o8G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915791; c=relaxed/simple;
	bh=nVDeBJgXF8/396g7hWPSfArKtGa7CLD9Gs8Qr38eayQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bzDpHdHJ8pJ0iMNyYQ19RQyhInSvOGfO/j8TKB3TzMvnrSclCYpLc7m9uryv+xFq0e+ntPLpB+CGxe11WMPR1Ei9D20bgKTDR6AmZo50xuyBCpx1RaN9wsJBbJO89pa1o+JmpDSY/Tv1pTEE89M3/jt5EfraQ0YiHjpR2DIGFPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=dWlwzDgG; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=bohHk0Wu reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1712915788; x=1744451788;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/soWe7XqyBX4honSYKsLPMJeYrFbcBwBQe363188zkE=;
  b=dWlwzDgGmeobhQlpvCv0rErmH6gAH5u2qlIATgQEksltvTRogyfzc2Pw
   smVepZyD4Xcsz99pdIfocM/Bn5td6bx69354z3RM+jxwHG7YCoAd1AHBa
   1JDX4PFG2gxpE/Zin71X0cnZuRvCi71cn0IfNbTVG53JZM3XB5NPLk+xy
   9IXGH9SBlMNdhgNazVdyYOM+id8x4XFkA9jbmTIaP/gE0oF7LQMHJCFT/
   SyQ9FDTwZynqN9kRgFtAIPW9d1yk5mCr/uwQ525iz5c/0OaAc4WeSW5Jo
   OsHlaFyjUianifmJeoECFNd2CxztEODt3MOQgN9A8M/vtaY6GPus+ph5w
   w==;
X-IronPort-AV: E=Sophos;i="6.07,195,1708383600"; 
   d="scan'208";a="36387351"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Apr 2024 11:56:25 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 575C716F476;
	Fri, 12 Apr 2024 11:56:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1712915781; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=/soWe7XqyBX4honSYKsLPMJeYrFbcBwBQe363188zkE=;
	b=bohHk0WumJlGVD/6n0G6U40nRLW8D+expwA4KGgXhJK7HfzhsTIUCR4lG793CZWSHzemL0
	paU3CeRhrJBE+yQ9ytGUczd817z0+AW/usVlWonsghftEiV3L+7fR0Da2T4aWBmvKWDAUH
	T9y3TwHQi0DygjhDobwgTTnwguL2sS5RuDhOakeESyhI+xjauWu/0w0+rb0g3K3nsD9gEo
	kEg51vp4Nlh57zlN5tcTdRfX0NOt+TwLriqeTENnzjy1+S/DaKVI4qEHKIKBeW7pF3M/B7
	zSyXL/so4aVPWHgF3hqUoEjNBkQ5ksOYgJCZSgHzl9J+akybSU7liqIpJWARlQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] media: dt-bindings: nxp,imx8-isi: Refuse port@1 for single pipeline models
Date: Fri, 12 Apr 2024 11:55:49 +0200
Message-Id: <20240412095549.258870-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

In case the hardware only supports just one pipeline, explicitly refuse
port@1 in ports node.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
This is v2 to patch series [1]. With 2 patches dropped, only this one
is left, hence no cover letter.

Changes in v2:
* Dropped v1 patches 2 & 3
* Collected Krzysztof's A-b

[1] https://lore.kernel.org/all/20240223140445.1885083-1-alexander.stein@ew.tq-group.com/

 Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml b/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml
index e4665469a86c..4d5348d456a1 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml
@@ -84,6 +84,7 @@ allOf:
           properties:
             port@0:
               description: MIPI CSI-2 RX
+            port@1: false
           required:
             - port@0
 
-- 
2.34.1


