Return-Path: <linux-kernel+bounces-144218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0929E8A4346
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B342A1F211FC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14FD13473B;
	Sun, 14 Apr 2024 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="PXAcft8C"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F991134730
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713107545; cv=none; b=Em5+zcUEyZP2mtddirxZdH17wi6t1suq0/1XNVg4Xj6vb/BLvjvZOdl3CPgFgxBx63te1w3mOER4KQsyHQmWVos1asQnTTZKCrteYFqpZY3R7t3HZlESzszEGe9zu26rJ9O/G/pow0C8vCndZH/0wIOdP/0ATW566qMHbCEyMDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713107545; c=relaxed/simple;
	bh=O03YYebbtXhMIdOMbi6XgtmeLQkPYfnnUfyAiFpd18Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erVK8ls9k+yAPvHKRQgALFV8+3KhBSSED5QDOB4qduo6Mt8HxVhJV1yznsC1hIki8dEZMFBQ+4oYQ7G8pLbn7F0QIO6QFx/40vdi4jDjGuCziI8slF7cvZcQyBjcKNgRIwJHTa184nHUqm7AwVVcoLus7Qzovua/x2w8k2G64vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=PXAcft8C; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713107519; bh=gGzIdCw12QXG2TxloTRvkWREcbVU89z7DbBLoR6ZGJA=;
 b=PXAcft8C5jzX1iBhgHoO3sH5Sh38isq/WaBouSiFCichcZtGpGTY/aQGbVj5ipft69r/pC/do
 5sGEqgLnKJ+0604bVB+v68DBqRi32QgGLrYrwuh3EjeCxxY1S7Ot66PjU2FY6NK5w4y75W1yAxd
 qf5kDWV7lkJ0G55VUXFpLB/ZYc10Dp1M+xZAw9WVT72kQDLYO16WVZTfefmGaPguXCwoHEvRGs7
 UUd1yfg4kkilAtT3VmoIaxVSuzzJ2lh7Vfb30MDi0g4Ak3Kv2dNQ6X9tMHHScMJJcsm9JhKqAhg
 lNqAJnlcORxKgv5+K8DqcFV1unePIxvkkAV6kFHSCRMA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Sandy Huang <hjc@rock-chips.com>, Andy Yan
 <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Mark Yao <markyao0591@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org
Subject: [PATCH v2 3/3] dt-bindings: display: rockchip,dw-hdmi: Fix sound-dai-cells warning
Date: Sun, 14 Apr 2024 15:11:29 +0000
Message-ID: <20240414151135.1774981-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240414151135.1774981-1-jonas@kwiboo.se>
References: <20240414151135.1774981-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 661bf23c99ce03c87699d74d

The rockchip,dw-hdmi node can be used as a sound dai codec, however,
dtbs_check may report the following issue:

  hdmi@fe0a0000: Unevaluated properties are not allowed ('#sound-dai-cells' was unexpected)
  from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#

Add a reference to dai-common.yaml and add the #sound-dai-cells prop to
resolve this warning.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch to fix #sound-dai-cells warning
---
 .../bindings/display/rockchip/rockchip,dw-hdmi.yaml           | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
index af638b6c0d21..3285fff54416 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
@@ -15,6 +15,7 @@ description: |
 
 allOf:
   - $ref: ../bridge/synopsys,dw-hdmi.yaml#
+  - $ref: /schemas/sound/dai-common.yaml#
 
 properties:
   compatible:
@@ -124,6 +125,9 @@ properties:
     description:
       phandle to the GRF to mux vopl/vopb.
 
+  "#sound-dai-cells":
+    const: 0
+
 required:
   - compatible
   - reg
-- 
2.43.2


