Return-Path: <linux-kernel+bounces-27141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F9482EB19
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFCD2854F2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF8012B77;
	Tue, 16 Jan 2024 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="BGKAYR0G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QGM83qJq"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D220134AB;
	Tue, 16 Jan 2024 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 43AC53200AFB;
	Tue, 16 Jan 2024 03:47:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 16 Jan 2024 03:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1705394824; x=
	1705481224; bh=zTC4+rP7zPq87zT19hFSzcCUDOL+iUa2sCx7guwY050=; b=B
	GKAYR0GAy41IxWYnUGegfQpTZeNVJbSFfQ3ko0q2GWfg6+aQfurUIxmLduogVfQ+
	5wBHN5kO39dEYoqsIsZH/ncN0fLJT6haFK2FaxSku1f6GMdD8e41NSx/KCt3xRZM
	E2PmJTRFbFfZwgfyhdkEtkRZw6i5C5+TDxNZEX0curBVWnAwVnk43BAlbolqVooB
	rQhlDNVn68emfebV3MtLLjUfgX3/2Or0YkUfsfuwMWdgQfaB8quBstUVr7ySNuh4
	B5fMfiwwwoUUnxn561/wXzxhF8a2tz2ODbKefpGh7uGNQ617wlooAaq0akzv3U9W
	xAFdUPst3AvUXV51HPdpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705394824; x=
	1705481224; bh=zTC4+rP7zPq87zT19hFSzcCUDOL+iUa2sCx7guwY050=; b=Q
	GM83qJqt5O2zD8hG4Pt1djzhrzjKqhCzfLYZPt0rUTkSGlApXxNmB5KtXQ4mnV40
	Wii849W3dIVMVKWZpVknXogGMRFKwG7fuIMLXLjtFCPe4jP7Mm1bWYUZm/ce7Kpt
	SKTi4Mqdxl1Nn4WxUABXvPDuQvC7cB/Lr60xCySoqkNdmI6qYodCXI1I/ZmSRPUI
	2OHQCYGormjyxKAJmMrkWpSsKFkKmDem8PCsfiUbHzMXLILgRa8HkccQo/jgh9oM
	dO9qfh/i9v7A86WZSrzjlbJP4NyrIp0oCyRDaqUTz3bOZcsBnf0y91/XcvpcbcmB
	kWXfbt+eJTtXzYT9Mff4A==
X-ME-Sender: <xms:iEKmZdAmXnmaMi8_jrAqghbo86srtykqlY5LKN9n2LGsS105oVdA0g>
    <xme:iEKmZbiCq7OQR7R8qDCF3n1oYFmfR6RqCO_WGh83QIk6_G4F4Bj4-4ZtIkPT_V3_R
    4ENUERupQ>
X-ME-Received: <xmr:iEKmZYlQeKDQf-Q1mXsRrkL850qbon3zDPWSFO6IaHDC3ltskH1QvKLG1nCF6d-2YppyRMDr8Wr00C90IsiEg2E__CebaRvMW1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejvddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhm
    ucfnuhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvg
    hrnhepfeffuefhteegieekjeevgfdtfeethefgvdfhteefueffuefhhfefkefgkeegheei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimh
    esfhgvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:iEKmZXzMxLwFWz5IL7_OnvdsngAwrsY5TxB52d0XgOZ8587NhM8Xtg>
    <xmx:iEKmZSQ9Fnb7etvHE1G_chZQxIfIfW-qo2yla4Cj3q7QQtXL0dNLdA>
    <xmx:iEKmZab8fFis2d40Kp5rrNjniwCQh4HcQvXmjMI4EdvfC3aHuFMA7A>
    <xmx:iEKmZXJg1uzHP3whR3992-BxU7ogwXFFDuf04MGZzMIoiluL3FL_Hg>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jan 2024 03:46:59 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation); Tue, 16 Jan 2024 19:46:56 +1100
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
Subject: [PATCH 3/3] dt-bindings: rockchip: Update rk809 example with audio codec properties
Date: Tue, 16 Jan 2024 19:46:18 +1100
Message-Id: <20240116084618.3112410-4-tim@feathertop.org>
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

Update the example provided to include the properties for using
rk817 audio codec.

Signed-off-by: Tim Lunn <tim@feathertop.org>
---

 Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
index 3f31478932c2..c9c676d0922d 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
@@ -161,10 +161,13 @@ examples:
             clock-output-names = "xin32k", "rk808-clkout2";
             interrupt-parent = <&gpio3>;
             interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
+            clock-names = "mclk";
+            clocks = <&cru SCLK_I2S1_OUT>;
             pinctrl-names = "default";
             pinctrl-0 = <&pmic_int_l_pin>;
             rockchip,system-power-controller;
             wakeup-source;
+            #sound-dai-cells = <0>;
 
             vcc1-supply = <&vcc_sysin>;
             vcc2-supply = <&vcc_sysin>;
@@ -312,5 +315,8 @@ examples:
                     };
                 };
             };
+            rk817_codec: codec {
+                rockchip,mic-in-differential;
+            };
         };
     };
-- 
2.40.1


