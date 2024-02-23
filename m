Return-Path: <linux-kernel+bounces-78528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F165861485
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403D71F243A1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7726A000;
	Fri, 23 Feb 2024 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="gP+x0dKG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="hDB0/chE"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46D9823DB;
	Fri, 23 Feb 2024 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699702; cv=none; b=Nid3hHPgV+2/CzOcnajM+0voChBAvWfNC6Q0RdHrpYxWBhFKl57D1sNRuYBzNH0Tl/KxhMCccMPhQ2ekM9ppQVLZTjfzMopukm5o1E1qWDUaU37HmrNsCf/u9V7IuEaUC7nLl2ogbgu8CRJV8F0ZcMfNui/eyeL7yA+O7clgYF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699702; c=relaxed/simple;
	bh=UcliE0LzDhCSgcywixlwl3dp7EKiym3+zi1BTGCrAww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VSpFdw4PZc+LFt4ieWEpq9QSSBAyYCyiQekxxzYj0yRtoRLsg5lOXniu2HS1mh71f/7Zq43myh0cJtDzROeMeLoJy3HPr2HcF/XRt8U2NeP5S/urHZAGlmuL00r0KBuxbw10ZJT2vm4SAIFNGSWKDFCLbgZ0gaW+LhFSpuJOOrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=gP+x0dKG; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=hDB0/chE reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708699700; x=1740235700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QhudgKuG0ya+4gppWpZrYwAYWsjwepgCr9RMCVa8f+I=;
  b=gP+x0dKGR+i4Ar5Kd7L3TXMpDixrZTyHlntmiV2qd/PAsox5tjVBUYhW
   ntPun2nMU1JXP3Dz+bcf7HpPe4FGxR7hk5PROJOk3HUHoRe23QMRLqRe2
   xqF3LehKPSJ5VsIrY+gE6PiHbTKDU8A4g1QSbFzRpC7qY7zEZqGdUjy90
   dWWUgdzijgXL92/puOtU0rq7vFGYV2Q94HfiQ4Rct8RHE7VU2i9KbD1WT
   TJb5qFSlzeTrrNweUy+PBvyOKM7wZgivAp9Un/L418pWTtls+7p+cTQC5
   H61j824Tws27B9Bjn/7oA6UxeO0UJMbVQoe2NsHpbolGUenjFKtwSVOxF
   g==;
X-IronPort-AV: E=Sophos;i="6.06,180,1705359600"; 
   d="scan'208";a="35570393"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Feb 2024 15:48:19 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5E7C31706D7;
	Fri, 23 Feb 2024 15:48:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1708699695; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=QhudgKuG0ya+4gppWpZrYwAYWsjwepgCr9RMCVa8f+I=;
	b=hDB0/chExCPzRC0v01DDzM12JNYPnx3cQVS/giW+bXtZE7uz3jLx6J+H+Oa/rvLe7GJmK7
	48cCap0uA9qrRUq9m8pWdCKNsb+gVd8gHwkXQB7tQqdNSKT5EgueEDsWl2/Tezq8lggh1c
	NWgSS+ekSWw+kmq20/ffhEhuSLfitRceYl6Tv67oiynH3j67S/v4k9Yynb3c7J0oxZb6Tp
	RA258C91WSIRcfgXrxvn3Z3YFE6jyooHtCo9Cb5j0xWii355nWpn8IntdklNYds/D6qOW9
	mliIWiSjRvWp7ziZYhyVISuTM0PeHc71YigyAfAi5TBMNg+Nq4usRlQfPdT9vA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Ricardo Ribalda <ribalda@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] media: dt-bindings: sony,imx214: use absolute path to other schema
Date: Fri, 23 Feb 2024 15:47:44 +0100
Message-Id: <20240223144746.2583749-4-alexander.stein@ew.tq-group.com>
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

 Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml
index 60903da84e1f3..0162eec8ca993 100644
--- a/Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml
@@ -16,7 +16,7 @@ description: |
   maximum throughput of 1.2Gbps/lane.
 
 allOf:
-  - $ref: ../video-interface-devices.yaml#
+  - $ref: /schemas/media/video-interface-devices.yaml#
 
 properties:
   compatible:
-- 
2.34.1


