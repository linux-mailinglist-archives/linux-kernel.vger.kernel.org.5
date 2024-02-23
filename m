Return-Path: <linux-kernel+bounces-78323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D27158611E6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D5A1F21A17
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C417D401;
	Fri, 23 Feb 2024 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="k4XEASfc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Q3xpTjy9"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9347363104;
	Fri, 23 Feb 2024 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692486; cv=none; b=r1Iw4YD81qMpf3F34Kqyx+UYArN9mbA5e+7JYbynbRQT3Jc4tVXI5NdylA/AndlT1WBc23PcPxT2XDpKK9IF41c+RsBsq06oqj13jWWj0D4eNi1RW5QN6XiqaPMaj3Iiv823LScxf4MHwgvUAjZqzTQvBTPYEIOw9AthMURfL6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692486; c=relaxed/simple;
	bh=YeNq88cn8AskaOyzEMN8jpKCKDALj2OsTrYHvjryzao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qCoJl3HQkzmBnVCCN+o1Gd0PpQ+Bo5Jx2g4C3m1UgFsfvN62En97+qz3oIjfULFJOZmhkud8YOELtGw51AUfn4ZNYqyM5MtlxOGKp3MlhTIObsadudSVBwy0kiicIvGok0BRIecSAm6SKAuR6rBk8Pq14gVqn5d8Gys9BoWLYOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=k4XEASfc; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Q3xpTjy9 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708692482; x=1740228482;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iDYNy6oIeCR6d3Vo/NOlyZSkpMTmvkzg41nasM8MjEw=;
  b=k4XEASfcfgbeQ+dQxlK6S/MLrXEbMNBCFfuuGSublg9WrmDFfBXnrAd5
   c+TR/ezi8wleH285j1HhBgw2vieiEN9i95EgCArkPW7pu2Crfh05m7Oxe
   GSAJdz6xvzOnKO9tmnyukMPYeeMsyQEQ41l9CM3Vuc24y+AzXJ/XY/2Ml
   GFasWHRbOsSuYau0urqgrJq+Oo+H81uWtcEE27VXX4d4bYT7jtzrmassq
   WXHiLZPRqtyz7GQ12uSyMkLvltndhMaJ/ggaNfvHkDun2kUHrpE++F8sk
   cYcJhWyi176iojeWcwB98iQ2zo+JeKZsRnxaOoWCXdhw4qmddO9NMULcP
   A==;
X-IronPort-AV: E=Sophos;i="6.06,180,1705359600"; 
   d="scan'208";a="35568077"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Feb 2024 13:47:59 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D84C16EC42;
	Fri, 23 Feb 2024 13:47:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1708692474; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=iDYNy6oIeCR6d3Vo/NOlyZSkpMTmvkzg41nasM8MjEw=;
	b=Q3xpTjy9DDiy50EI9hZpfsKCpAwDXe72pxB0/LxIoM+Lpmlslk1ghFRHCZeJDI7PEq4qBg
	nlJMJNQQQVLlx5Qq2oLkTTRQCcCdylKW6e9RYr/Di6RCaZ9WnTpTGr4MVReGk3KrYuj3H+
	DCuKe6/vLYBO7jouVwwH1/jN5UzgoNVS0jx2nJu60FU91sxomTIFEBW9ww5rN9st3ni7c7
	TceMBb2LtTMXve0hU/VggJ460+aMz6hlRVodrQ36B54v4uSyEyJRFGy3b/Ije1oaytrnWq
	nvdCPUwCv7YNE1EWvsa3ZbsFKJ/e2xdTKUS1Kc9USYhUID4cxoQZNYA5V/FKLA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] media: dt-bindings: sony,imx290: Allow props from video-interface-devices
Date: Fri, 23 Feb 2024 13:47:43 +0100
Message-Id: <20240223124744.545955-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Allow properties from video-interface-devices. This aligns the bindings
to sony,imx415.yaml. Changes inspired by commit e2e73ed46c395 ("media:
dt-bindings: sony,imx415: Allow props from video-interface-devices")

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml
index a531badc16c98..e957b5dd4284d 100644
--- a/Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml
@@ -23,6 +23,9 @@ description: |-
   is treated the same as this as it was the original compatible string.
   imx290llr is the mono version of the sensor.
 
+allOf:
+  - $ref: ../video-interface-devices.yaml#
+
 properties:
   compatible:
     oneOf:
@@ -101,7 +104,7 @@ required:
   - vdddo-supply
   - port
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1


