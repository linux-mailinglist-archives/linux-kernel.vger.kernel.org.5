Return-Path: <linux-kernel+bounces-27413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF0082EFA2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A9E1F23AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F33B1BC56;
	Tue, 16 Jan 2024 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="iTh0ElMk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t6Wv8Omv"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D10212B7A;
	Tue, 16 Jan 2024 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 63EC05C01A8;
	Tue, 16 Jan 2024 08:21:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 16 Jan 2024 08:21:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1705411285; x=
	1705497685; bh=6q14v6w6o6wZVd1QBVP7W/zvz1NT2QlFXxst+m+13ow=; b=i
	Th0ElMkuQQKGDG/jWWfE4GIwsFpxwFr5kNHYJ1fj0HHbJnsuS5gwFLd6l0+7rCNs
	5AXniQs6z/5b2nOVY04pbxGHconsVmuXDk38BNHVwvmzDHL5bjUnVBce6MR7LP/d
	tlfdnAkV9xvfMbQFqvTTlKQEwo1qxITSr6Jnc3GdaNA6QzioKJclSuovgtu1eMsU
	SjB+uXsgTcLr+CgAPU5oQp6bgFeo4/KkO7PK6elqyQK0euhLvOnukZXRCNfwgq+B
	jL3hbL2AUvQZp307Ir5HHhCFijmHshq4rJs2ue98Z8/aCk2oYsFEiZsPIiDGSqNZ
	x+u9jCAdyKlgRLp5VMKgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705411285; x=
	1705497685; bh=6q14v6w6o6wZVd1QBVP7W/zvz1NT2QlFXxst+m+13ow=; b=t
	6Wv8OmvX3R1/E8QXDDNzC/EIl1wE5RyHI26wfxF3S8C2U64uecJDDDDyXJnJ5ihj
	JNjPOy2YC1J9Nj5cztAWFlmhh9vw0JfoDG3oNoBXq3ZrpbafsuC6FLwF/02lUvNV
	by0J+qkIzmlrEnrPsfBxJw9sIuj/5eudzcVyGeBXMtY/RLR4iLMmOrF3aTsXDHft
	qLQT4Bp2TK8m26KHRzfAkioo8yktE8v8t5I7RlYGffbDe4OgFsuDgTJhhMwCXcgJ
	k8gmHqej6MZnr29l3uaH9seE6bywLw+dcB5kYIq35wrNzQHjDTQIRF74tBe8T/mU
	Gn7f2+4+FPlMdvu0EdRNg==
X-ME-Sender: <xms:1IKmZYfGubW1rhmi9oswGsX2M1sGU_jwdW1MomBkxUYpr6WvHfTVAA>
    <xme:1IKmZaPt4KY1AC2jT7NBqkmojTj4uMG1UUvXAcb3Trga_zUFchkt79m7CTxSkYI7Y
    qyPI52yMA>
X-ME-Received: <xmr:1IKmZZj46YaT2OF4TVcMUv4RgDA7RnL3m7JeWBaQM54RaGXBMWFyL0YkT8JcBjF8HjoQZVlUnP2tsck_pmAAW-eOd98CBFOVsLc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejfedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhimhcu
    nfhunhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrh
    hnpeefffeuhfetgeeikeejvefgtdefteehgfdvhfetfeeuffeuhffhfeekgfekgeehieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmse
    hfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:1IKmZd_U-ueqxw5kUdfcgaldn4fAqxSA1YthLe3VadgFAS0pmd8q4A>
    <xmx:1IKmZUvB5Pz1AoPrSfSSJ6AXorRv3m9zc1eVJkTxpq4ny8nsPs8jgw>
    <xmx:1IKmZUFLGu-QDgYzDPeWUFJ8a_RYp76fqmhnKl8mpXrZFEsUj3rA1A>
    <xmx:1YKmZVk8-kXcUn6oy1L_D6pvqDQCoXIRK6Nk5LgS9K3AoX9r_wwWTw>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jan 2024 08:21:19 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation); Wed, 17 Jan 2024 00:21:16 +1100
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
Subject: [PATCH v2 1/3] dt-bindings: rockchip: Document rk809 support for rk817 audio codec
Date: Wed, 17 Jan 2024 00:21:00 +1100
Message-Id: <20240116132102.3272682-2-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240116132102.3272682-1-tim@feathertop.org>
References: <20240116132102.3272682-1-tim@feathertop.org>
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

(no changes since v1)

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


