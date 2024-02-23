Return-Path: <linux-kernel+bounces-78526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F0286147F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD6AEB22062
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87240224F5;
	Fri, 23 Feb 2024 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="LErifN08";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ZAlNP9QN"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F265C902;
	Fri, 23 Feb 2024 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699692; cv=none; b=OhpW31r2u+Hm/UpvfDrBZWJ0DrduPsCx2hptBRWdQX+9MxxK+G0vOnFJOw+A152E5Btzw1zDaEsiHPEOP+7iYCaAo51iZeUzodehWJNosgy53PmA8tUAGycELpRUvEKu7gqvGxn0rzOWSX4+auSWkB4leqw8jeVnGn02Wx1cd3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699692; c=relaxed/simple;
	bh=e1MIuOTQ0uiYpv8JDB5H13vQgMZdIKU5NMu2WONNxrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nYk96NnSHceXUCt/kVf59fdffwXuKimkDCSLMor96qc9zyor+Hf1BVLJTDz6mpaS+u7YBrkGxaPE5IVmOdP5zdlWIJwmV9i5ITdxGHu26cwMerBTFy6aFecXsQG5zonmNKdageek4aBaRAX+V+lpPxyJ/W48tqWIkvitTTe0bTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=LErifN08; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ZAlNP9QN reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708699689; x=1740235689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l/1/pJZEsRtwPkxSQ8fdVqfXuMYj8FmsNQE1eHoK4KU=;
  b=LErifN08zD+ehnfqaEVHN+KXnHbQ5cSCCgrbvqSgVhXmpmHfKxSP6xUU
   qJ0cVZ4m8UbiLDaGlxvGBs1GcOo8w8bl4/lofNINusKMi4pfWnkJgsEZk
   pZKu9vllvUyWScGpMwZz7rY8N8l87v89aGaHfckYbUOtUv1ZHX7Se2Z14
   N8TVd6gV4ewOvJBqRGPznLTbmLc5PRzkSKKY4zB2u53+QF+fyiZefc9OA
   oFh3tWqUFsW4H+IN3XgOUEfPNUrYUfSKlQqODlfeX5mrj/1GWg6Z7rq8V
   ibxpdVMLFrbdLqqQf4D+dPANVlGYZedLungVempimrjeczNnGfWIhSNPC
   w==;
X-IronPort-AV: E=Sophos;i="6.06,180,1705359600"; 
   d="scan'208";a="35570388"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Feb 2024 15:48:08 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 35AFF1706D7;
	Fri, 23 Feb 2024 15:48:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1708699684; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=l/1/pJZEsRtwPkxSQ8fdVqfXuMYj8FmsNQE1eHoK4KU=;
	b=ZAlNP9QNVf25YReFHyAXh35lKZ2syP9LH0mdJOxnO8YHDaEjp+5Iguq/Kbm59pGRdjPv2Y
	YdSj3hNd2HQ4M1q2YQD3qlHCYnGGWBStqUgbqCAGP5jmaV2EAGU/iKN+40E0vYeu5zs8Hw
	7wgWT47UqiosiIFhYDRHeBrOpJVgPzPuFUhJpoIkr+LWBPVM14ru0lG4T89QqHwkpk2fGh
	Xpgz02sFgkIGV8NFRZA1OxCwSGowHeAyXAp5keW0hFapoumZtWPSD7MqsghDJjtEpi0r8S
	1yl/ugCb7i7YOnDWLpMc2VFMeg8F8rejPfIrl/ubWNGsG4IORX8oB8nZv3AJOw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Sebastian Reichel <sre@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] media: dt-bindings: gc0308: use absolute path to other schema
Date: Fri, 23 Feb 2024 15:47:42 +0100
Message-Id: <20240223144746.2583749-2-alexander.stein@ew.tq-group.com>
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

 .../devicetree/bindings/media/i2c/galaxycore,gc0308.yaml        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc0308.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc0308.yaml
index f81e7daed67b6..2bf1a81feaf47 100644
--- a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc0308.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc0308.yaml
@@ -15,7 +15,7 @@ description: |
   They include an ISP capable of auto exposure and auto white balance.
 
 allOf:
-  - $ref: ../video-interface-devices.yaml#
+  - $ref: /schemas/media/video-interface-devices.yaml#
 
 properties:
   compatible:
-- 
2.34.1


