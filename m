Return-Path: <linux-kernel+bounces-31810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC598334E7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 14:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C86F2821F1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 13:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4192FFC0A;
	Sat, 20 Jan 2024 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="ADznj0gl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JhZmH4kZ"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D855C1094E;
	Sat, 20 Jan 2024 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705758977; cv=none; b=aqdwXg8U7fL3QuoReDM63fR7klo3J97P3YA/aiFR1lvI0GCNLRqqUdFeww1ehnyWE/6p2Cs3dT1AQ/GkMgBd5dSgzPTmnVPRoFuCw4NoZPvtm9KmdIWcGXH9ckjwA30zkAN+NE0uTyaN4r0OCaojrCPM6Poux/OqMYzHaXoGA0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705758977; c=relaxed/simple;
	bh=G1BajSfR2TDS+zWxcpFImQCmFzmvtbzvPyYBnFF1ITU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tyIYoAoW5i5mtb6iEIJ5XQBC0SzLXXeOiNorN8451f8tkvzcMBLd4BZhICkZSifJJUSsV7PTAIKJfmtH1ZGqWnLKffu1Ys1GHbR83qFwF+0APOUQKcc4LLipi5zaXS1TrPAbpuW/Hkgb9YQmq19dV/Tyq48LOL1xcLNFFEjkX0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=ADznj0gl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JhZmH4kZ; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id D613C5C0110;
	Sat, 20 Jan 2024 08:56:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 20 Jan 2024 08:56:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1705758974; x=
	1705845374; bh=tyVLqYgWirTx9KCAu+OuFKeKwsREXEGBOgBztayJRGQ=; b=A
	Dznj0glwb950CRBoGhKJlZKLZcHFthp5aBCt/90elos34umI7QBTIOc8fYAB1tFp
	kDf5D+Rg0ibcciGFW6eCmB+PEnpfOPb/vfD0AtwK0u4jJn+LYN6tEg+i2nzi4Kpg
	m5FSFtAvmXBMGz6svZjx11B3P0aMiPjlnrhtw72Gv63kpx9Uv1nmsJ35/JxyhtH7
	JryWrMlMyHnL74lytv0KG0dHsUF0yvxz/gDpLUDEd21zPl0sTvgdloZxPYF4EkWb
	ltthWWQuUJVdsg9ewI12z5kJUJOy0xnb2NPedumwaxj7hYWfmnHFxQAmVao+CKPU
	sqb8jsbnFWFUlYnN1QYog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705758974; x=
	1705845374; bh=tyVLqYgWirTx9KCAu+OuFKeKwsREXEGBOgBztayJRGQ=; b=J
	hZmH4kZXC5IJJKIlmJLpfWOWlgNr1DHHYKGdk8a3QPsYCSSP+T3FBwAR8jsanb6G
	EOiJgjt8yEsjdl4By1vD7rEgncdLmDmbf3cCTFCV10V+PKmNCf3YgwnUXvWhGNcA
	pft7rNx+FHjG8tyqSxr3hjOH4yBtS1j2xuA+uW07Mqc4stD0Rb68gmKS7Mi3SKBo
	g2WdvO124ttKzGuSINLllPLj8FqTJvboyhOmMPIKVpgGH/LMdtqHP5OV8ZxUVMYL
	IDY98FI6rSFgMbvocSAAeXdcmEbbgqMF2hDVDHt8zuSdV5zoblDKEH1hccTxd1/u
	vA7dx2YprwlBCqEG7ZEUg==
X-ME-Sender: <xms:_tCrZUAD0WjiGyVoJO9iL9US9ZNE6SNztXKQ3SliDpRYxNMPN7uP5Q>
    <xme:_tCrZWj-3zDa_KnkcJUKXs_N9ZMj3ERI2rofCha6S6H6vdC0QhCyPnqo9j3SCHEEC
    HhJwBwxTQ>
X-ME-Received: <xmr:_tCrZXkaMb0rWkY1kwB13x-vvG4wB9z-ZmYSUzYacM-22n_1cgsVjXlrno3fMyK-N8PdTlGw4mEjRtwZO3rTRbj9rrl3Dhg4--k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekvddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhimhcu
    nfhunhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrh
    hnpeefffeuhfetgeeikeejvefgtdefteehgfdvhfetfeeuffeuhffhfeekgfekgeehieen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmse
    hfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:_tCrZaxnIEZ7GdC1bMi7qW8CsMs2AP1fvI3Z4i7iAh66UMSSe60TKg>
    <xmx:_tCrZZRwxO-8BIsLlyTm-iJwbX92SEbL4eN5aFVUAyf9oRlLGNKChQ>
    <xmx:_tCrZVaDHzW345i3EpuY8kovC1HXGxfDNEKtfCEOG9Njo12Z-ycR4w>
    <xmx:_tCrZYJSvmacN2IYg0GPImVzMjd--9xe_Q0dDRkruHMEphld1qjgeQ>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Jan 2024 08:56:08 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation); Sun, 21 Jan 2024 00:56:05 +1100
From: Tim Lunn <tim@feathertop.org>
To: linux-rockchip@lists.infradead.org,
	conor.dooley@microchip.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski@linaro.org,
	devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Tim Lunn <tim@feathertop.org>,
	Chris Zhong <zyw@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Zhang Qing <zhangqing@rock-chips.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] dt-bindings: rockchip: rk809: Document audio codec clock
Date: Sun, 21 Jan 2024 00:55:29 +1100
Message-Id: <20240120135529.899403-4-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240120135529.899403-1-tim@feathertop.org>
References: <20240120135529.899403-1-tim@feathertop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip RK809 shares the same audio codec block as the rk817 mfd, and
is compatible with the existing rk817_codec driver. This patch
introduces the clock required for the audio codec.

This clock provides the I2S master clock for the audio data. The codec
driver finds the clock by the name "mclk" and will fail to register if
this is missing. Clock-names is kept here to keep  compatibility with the
exisitng driver ABI and also to be consistent with the rk817 binding.

This series fixes the following warning from dtb check:

pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks',
'clock-names', 'clocks', 'codec' do not match any of the regexes:
'pinctrl-[0-9]+'
Signed-off-by: Tim Lunn <tim@feathertop.org>

---

Changes in v3:
- split out clocks into separate patch and group example properties
  where properties are introduced.
- Address review comments
- drop clock descriptions that arent required
- set maxitems on clocks

Changes in v2:
- Fix missing include and pinctrl for codec example

 .../devicetree/bindings/mfd/rockchip,rk809.yaml      | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
index be0616201f52..0174261449ab 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
@@ -93,6 +93,13 @@ properties:
         unevaluatedProperties: false
     unevaluatedProperties: false
 
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: mclk
+
   '#sound-dai-cells':
     const: 0
 
@@ -135,6 +142,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/px30-cru.h>
     #include <dt-bindings/pinctrl/rockchip.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/gpio/gpio.h>
@@ -149,8 +157,10 @@ examples:
             clock-output-names = "xin32k", "rk808-clkout2";
             interrupt-parent = <&gpio3>;
             interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
+            clock-names = "mclk";
+            clocks = <&cru SCLK_I2S1_OUT>;
             pinctrl-names = "default";
-            pinctrl-0 = <&pmic_int_l_pin>;
+            pinctrl-0 = <&pmic_int_l_pin>, <&i2s1_2ch_mclk>;
             rockchip,system-power-controller;
             wakeup-source;
             #sound-dai-cells = <0>;
-- 
2.40.1


