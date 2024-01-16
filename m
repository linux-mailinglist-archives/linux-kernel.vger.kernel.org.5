Return-Path: <linux-kernel+bounces-27138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE8D82EB12
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B41B285502
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9396612B61;
	Tue, 16 Jan 2024 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="TQ/+wzMA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J5nmHJbs"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231B5848A;
	Tue, 16 Jan 2024 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 717543200B22;
	Tue, 16 Jan 2024 03:46:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 16 Jan 2024 03:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1705394802; x=
	1705481202; bh=+17r0Un58EPuippchMhMs32wnnmhSQrNhZlHlh0KRMI=; b=T
	Q/+wzMAE6deHpwr6N169FX6P3XJHxAqjXlEmgFgTe6rJfrmaRPp0uhjpCEF0/xv6
	AaZ1xlfDI7APdj6Z2xlVOG2Gd7VruQAnrOfKvscdt1CyTo+DVPJzeoodxX0A6adB
	vwlnD6JMUcYgmaY54WVBMbCXzVaE5SnCcdg8ovUBF8gWb1skpb3IZEeiyGWDiP4r
	IvEpE4AYwxtMiZw4CiNTxsM9Cr/sQM2gOibUUIQfVyJviJasGY5uBiLqtLXCcLtn
	BGA916sA0aGU5ioeeLs45Uv387l/cmCKq/Ml/qpVQoLyjfkb74x+BlYg+HU7Vac9
	nL3R09tXW+FCkkZz1xTGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705394802; x=
	1705481202; bh=+17r0Un58EPuippchMhMs32wnnmhSQrNhZlHlh0KRMI=; b=J
	5nmHJbsF2iIGP+KbMUgcKV+w+hZh9y5UKVq8ZYBd5ALQmuDU8DIK37C248q/3oFE
	o1ygASbFK5AGdOojNzW84WloAiBHpRCbqSmGAPqIl84MIg6OITv+dfkI/9HifZEH
	j+AB3mI3EPg4HzI8Mw7Q31jB7aR4/gp0ZIbAfpIaXGXYOnugLytbYuLOZ5YwH1V1
	adoEpkK3JzyRmbBgTNkyvbmSHbgrdFfpbzdm1ol1xL8N/yF49rHdtl6eZFEQh0Vb
	jam9jFyzwTFiZMqfayDgXayCD2FaFYzS48T2IruaNzyp/tjT6k6ltW+WvPXx18lq
	s6xZWhd7eMJfBmVAfAIJw==
X-ME-Sender: <xms:ckKmZQ98PICkVvVpH9AKqifszg77niwjeCsI_KDjd3feJMP5IsbTog>
    <xme:ckKmZYtoAJkOfYWhOYClLuI0F2WeNnXEcwtX70t1nsOp8dQ9bj1Q2nzSFve6d81S6
    rztNH26CA>
X-ME-Received: <xmr:ckKmZWC9nWTCjRSe_nQQXxefKDJv0-8mB9fHrE7wo8I0dA3IW-BnBCTZhveWZOR74CA2XAQALgQzQlHEeZK1Lg82guisQ9u4eLo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejvddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhm
    ucfnuhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvg
    hrnhepfeffuefhteegieekjeevgfdtfeethefgvdfhteefueffuefhhfefkefgkeegheei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimh
    esfhgvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:ckKmZQdOsahFIN2U49wOszFZGJAHQPWYP09C_2npbg5e3EHzvBc02A>
    <xmx:ckKmZVNHUFzqcM2XZHlB4Dvn3QrOghuVf6NU9TwjQv0uSaccoCa5wA>
    <xmx:ckKmZamMranHb8-sdRn04sTLQ8C9qT9t1N98AwCZv4VCk-q8wDvPyg>
    <xmx:ckKmZWFU8xKx-NdZmeFzNiFUHUF1voFeqUcRUZj_j9d2rL_D6BFHEQ>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jan 2024 03:46:37 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation); Tue, 16 Jan 2024 19:46:34 +1100
From: Tim Lunn <tim@feathertop.org>
To: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Tim Lunn <tim@feathertop.org>,
	linux-arm-kernel@lists.infradead.org,
	Chris Zhong <zyw@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Zhang Qing <zhangqing@rock-chips.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: rockchip: Add rk809 support for rk817 audio codec
Date: Tue, 16 Jan 2024 19:46:16 +1100
Message-Id: <20240116084618.3112410-2-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240116084618.3112410-1-tim@feathertop.org>
References: <20240116084618.3112410-1-tim@feathertop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip RK809 shares the same audio codec as the rk817 mfd, it is also
using the same rk817_codec driver. However it is missing from the
bindings.

Update dt-binding documentation for rk809 to include the audio codec
properties. This fixes the following warning from dtb check:

pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks',
   'clock-names', 'clocks', 'codec' do not match any of the regexes:
   'pinctrl-[0-9]+'

Signed-off-by: Tim Lunn <tim@feathertop.org>
---

 .../bindings/mfd/rockchip,rk809.yaml          | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
index 839c0521f1e5..bac2e751e2f2 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
@@ -12,7 +12,7 @@ maintainers:
 
 description: |
   Rockchip RK809 series PMIC. This device consists of an i2c controlled MFD
-  that includes regulators, an RTC, and power button.
+  that includes regulators, an RTC, a power button, and an audio codec.
 
 properties:
   compatible:
@@ -93,6 +93,34 @@ properties:
         unevaluatedProperties: false
     unevaluatedProperties: false
 
+  clocks:
+    description:
+      The input clock for the audio codec.
+
+  clock-names:
+    description:
+      The clock name for the codec clock.
+    items:
+      - const: mclk
+
+  '#sound-dai-cells':
+    description:
+      Needed for the interpretation of sound dais.
+    const: 0
+
+  codec:
+    description: |
+      The child node for the codec to hold additional properties. If no
+      additional properties are required for the codec, this node can be
+      omitted.
+    type: object
+    additionalProperties: false
+    properties:
+      rockchip,mic-in-differential:
+        type: boolean
+        description:
+          Describes if the microphone uses differential mode.
+
 allOf:
   - if:
       properties:
-- 
2.40.1


