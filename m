Return-Path: <linux-kernel+bounces-27414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D2282EFA4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82A6285C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132BD1BDCF;
	Tue, 16 Jan 2024 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="Q4A9nCDO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M9OJFDYO"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DA61BDC5;
	Tue, 16 Jan 2024 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id BBA785C01A4;
	Tue, 16 Jan 2024 08:21:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 16 Jan 2024 08:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1705411294; x=
	1705497694; bh=mqRapvDpAQ7FPAyJBmNhOYsAn7gqgD2a+gSOVpqzeBY=; b=Q
	4A9nCDOj2O4z55kRsqrOU8cyRblkqsxjY9aWZ1RLm9c4SoYaP8KtpepdoZlyNh8C
	bkGNaRMKNC4eQyvjVp0uLbiI5vcxAWwKUr5YVHrYgBdLPx7WZZscA2Zjm/ld4k8U
	rXilvmaz/g9U1o8GL9ApgmSj7rMF4NTpvlK2oP82t9gcQb2K5c9TUlRGaifWrIeC
	3mO90zFZERnpdTu/A0DFjHuSIQy+DJMvXlNOcMYB1/6hD+i24VN9Nxey4VoSogfz
	oM2aCNlLAFqPiBmhUZcTJ7mAIUfBho4x3d9GukAXpVllQb2I/CSK6eGi6yws2BCj
	j1SBGtstEtO1azJFl9XJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705411294; x=
	1705497694; bh=mqRapvDpAQ7FPAyJBmNhOYsAn7gqgD2a+gSOVpqzeBY=; b=M
	9OJFDYOppzJqOKls4EBmRmOpQCIGzkuYDHaUQNoKh5IsaT0sWibeExfkEy21TcrS
	bSyyVA8sz6fg96LEQWZ1eCJYdmj5OpM5WoFjUe8GOLjgo4hl0JTQSPayuGYWX+SC
	ljVdFPXxVcWxstZgqMlzSVQVnMpYpRdoRHnYmdYbHMfdlmp9Jhw3VuBHEPZGSsOT
	QoIg6SAU1NA4Fnff7IJRD8zcTKeKqFM1+1o1mRgyDlkBmkBVi/SmP0wweMMcgnV+
	Oq6VsLp7dn8TTTqLEbzcYA3Th5IqNl6z3xoDDNCnBJ2yqu+9IcBzasWVH6E8Ok5/
	PhTjPbh0ON+5iRC9dBUSg==
X-ME-Sender: <xms:3oKmZQbgdsRPcFhdn7gOy8f8Ow5rM83PE9u_yMVodmxdYlDZuGaDKA>
    <xme:3oKmZbbiYHXMrZcSQoX8sU5N77X837UjNRP6Krj1ox6aGi24XMKQuol7sd1Q3Url3
    cGrXYY3Sw>
X-ME-Received: <xmr:3oKmZa9jGNGLa_GPGIou-mh7xFJy_hwdDGtGG-mcVrungtA1RM2YxHu7tZ_vqN87SrCtALaWdyNbZ1rvwcOXEV5eYqQJ0E7Vrg4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejfedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhimhcu
    nfhunhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrh
    hnpeefffeuhfetgeeikeejvefgtdefteehgfdvhfetfeeuffeuhffhfeekgfekgeehieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmse
    hfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:3oKmZaoXKd13msD3jvmp4HMEzjZGUIIL_Ln5c2w2Bp-_zuYJdddr8w>
    <xmx:3oKmZbqTvY5GD7lKf2mzsUe0K7Mhj_AJFfshq8ykXAQEwiOfWMu2TQ>
    <xmx:3oKmZYSezxW6pMFf-xtTu2tr3DEwC2N4JEAqknyXj5y_pmBLE3gUSg>
    <xmx:3oKmZYiI-PkTF6a_6QOGS6DHSEfa9rBZ74RXCA8TLRoEFklJh7t1IQ>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jan 2024 08:21:28 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation); Wed, 17 Jan 2024 00:21:26 +1100
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
Subject: [PATCH v2 2/3] dt-bindings: rockchip: rk809 fix existing example
Date: Wed, 17 Jan 2024 00:21:01 +1100
Message-Id: <20240116132102.3272682-3-tim@feathertop.org>
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

Fix typo in the example specifying wrong compatible string for rk809.
Remove additional vccX-supply properties that dont exist on rk809.

Signed-off-by: Tim Lunn <tim@feathertop.org>

---

Changes in v2:
- Fix vcc-supply warning detected by dt_binding bot

 Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
index bac2e751e2f2..9b9d670708ce 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
@@ -154,8 +154,8 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        rk808: pmic@1b {
-            compatible = "rockchip,rk808";
+        rk809: pmic@1b {
+            compatible = "rockchip,rk809";
             reg = <0x1b>;
             #clock-cells = <1>;
             clock-output-names = "xin32k", "rk808-clkout2";
@@ -174,9 +174,6 @@ examples:
             vcc7-supply = <&vcc_sysin>;
             vcc8-supply = <&vcc3v3_sys>;
             vcc9-supply = <&vcc_sysin>;
-            vcc10-supply = <&vcc_sysin>;
-            vcc11-supply = <&vcc_sysin>;
-            vcc12-supply = <&vcc3v3_sys>;
 
             regulators {
                 vdd_center: DCDC_REG1 {
-- 
2.40.1


