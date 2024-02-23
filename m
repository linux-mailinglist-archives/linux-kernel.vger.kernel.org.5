Return-Path: <linux-kernel+bounces-78529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1601F861488
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3F01C230C5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2308182C88;
	Fri, 23 Feb 2024 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ar+dIaK2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="NEdXQftG"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72F8288C;
	Fri, 23 Feb 2024 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699707; cv=none; b=XZYmdrCWI75aJ5L7cUrXpmcv+y5oehHoYb1IPij479l7JVKCixO7eCcA5hc2a0O/yd8twMwdu9Pz4yPV6C4pdYmy9GjMVqNE1xfMJ8Fz0oEiZaYJZ+5nHg5ivqhKJyPu6pZr53C6NDQJGc9V+jyuVFxNL11UW/DeW1PvZVFqRyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699707; c=relaxed/simple;
	bh=kbyGQGNLsmWMs4CGXQ7MZXIRNMdes7VvAexotyOLQn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WuHnvr1c0GFlBC7jR4+UOBUNciFcIYbctD/dLiye5+R9Cp9m0FcQ/x4y7k7awNi1EaNJAXXJZOKqmliNVlBJnV9KF6hO/eGgBsJatPQ8XV63wLOI7Bag2kNmpzjuaGuGy7+bwJIz0akiqVPZPB32xp07YvULBCpoHgnADE4lduQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ar+dIaK2; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=NEdXQftG reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708699705; x=1740235705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AcVLUcgUtxZpoSvfjiBj7CTKivXozKunT5EebkjBNAc=;
  b=ar+dIaK2FlhDEXIVY1z8nIpV+ih4dJf204OQHNvbEpTGVNKCyB/ve7nj
   rfwqHYyICuNCZktNcyZlpN93bCiDQsVSC+jNZmOlm3LGb4l7GHO0rZK/f
   xnO9AX9aWyERgQJofhB9c1A3vqD4aChSC15ci+H5hZt/97cFP7bXzQmhT
   49ZiNpcjFH0+pliKwkkd7dawPLSm4EJKo2N4CIImxLuJ3Rmagg2JwuPRu
   ua3ETkQ/pCNKQIjh3p6+gL/94qDcXUqa1tDkxFckq/GU6gE/ifyS310mQ
   c3SUlMDFq6HHRZVkDtdi4XZpD6oehs47jcmUb+vZ8zeNHwm8CAOf8nOD2
   w==;
X-IronPort-AV: E=Sophos;i="6.06,180,1705359600"; 
   d="scan'208";a="35570394"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Feb 2024 15:48:24 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1E961706F2;
	Fri, 23 Feb 2024 15:48:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1708699700; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=AcVLUcgUtxZpoSvfjiBj7CTKivXozKunT5EebkjBNAc=;
	b=NEdXQftGBzjR5g2s2t1+I7quhzbF1JsaVMruz7bCwXYg1W7Hdn674Zfmqzh+wu4dwVGUI0
	nNlp/d7juOUDCioZW4M/y6T+d//xPeadqk0pmwGN6KwidUordpeCcJb+4+xXbA45Iq+Iu8
	j5ByvuLqMicqaZfqj6nJ1XVUjMOFWY9z/6jC50weFl0VPWBacEbJ//fuLrpQH1IJr5HI4D
	+oscSKew/cG1RM4Da3Q0uQmA5qe4FK484mAMHVpyC+/c+xuEJ8cz/vwEpiqF5xYAZKi/a1
	ELatc06+4nC5JQLxFHgx2dNycHpn9zP73X7oIcLBQ0ok7ri5KnPrQqDXa3oBZA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Michael Riesch <michael.riesch@wolfvision.net>,
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
Subject: [PATCH v2 5/5] media: dt-bindings: sony,imx415: use absolute path to other schema
Date: Fri, 23 Feb 2024 15:47:45 +0100
Message-Id: <20240223144746.2583749-5-alexander.stein@ew.tq-group.com>
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

 Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
index 9a00dab2e8a3f..34962c5c70065 100644
--- a/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
@@ -18,7 +18,7 @@ description: |-
   available via CSI-2 serial data output (two or four lanes).
 
 allOf:
-  - $ref: ../video-interface-devices.yaml#
+  - $ref: /schemas/media/video-interface-devices.yaml#
 
 properties:
   compatible:
-- 
2.34.1


