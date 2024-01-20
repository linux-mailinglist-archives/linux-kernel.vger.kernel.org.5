Return-Path: <linux-kernel+bounces-31808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A898334E3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 14:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C640283281
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 13:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B213FBEB;
	Sat, 20 Jan 2024 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="Y1TNoElf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gC7Mc/MX"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFA7DF78;
	Sat, 20 Jan 2024 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705758960; cv=none; b=dHt7vloqysinIaQrfYSDfLtlxbaRC5bwWdE5cW/bGxz6A83QwzHivL2ow3aHTrvj2lDc6ozdKcpLf8J7tiuWta+/VBr+yDpToD5gjM5o+G5m+hlXP497Vk/SBmkqyk8TYvo5kbwUtsUAMJRBvWPWC2BiDfDAvRv9kR6ctO22UJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705758960; c=relaxed/simple;
	bh=XF1rzcXaPzvVRbMj4jDvYxIkaTS+viUNUKoifgHJfKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bDT1OFt7+W5R9+KgaNG8qrfLsj+sjAPRq3HhPN+1JsPlzNUk1A8e68duMs/m125vtGq2/WsMItZ7lFSjrQXRCi5PGhxqhFtYYwPqZdix2ayCXQ5quG1JLgIDGQJ1a8M8g+GQjQNJEIC6Fqh4DQdQ0BKNfMHtRtLyHYq92cnod1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=Y1TNoElf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gC7Mc/MX; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 6C7F65C0111;
	Sat, 20 Jan 2024 08:55:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sat, 20 Jan 2024 08:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1705758954; x=
	1705845354; bh=82nmu2DyJPwmac1Y1zUdWc9LMCywxycb33mNUkKF/Pk=; b=Y
	1TNoElf7L0Tiz7cvPKzRTJ/Z65vkfcg728xZm32T9V+qHzy4y/ITJYn14uNV1l8n
	5/8QzBEfbVvvHJpIo+heI3z/LL7euL1ra5wRh9dHiOCm1vgpHtk9PVimuu3mkqEf
	fpbl1Y+BApk8OQpWbaq6jJengkutKE999WyLmDc9n3NgstoxD7p1SzeIHwQ+OFjR
	bTpRstCZ5n23Q27IPS17000yhVYfzcPyQJVb7cN3NeVQ0Fxyo8oHp4ewI04kU0/+
	LJCA+PKbehOYSunreYefwciBTv+j3z6wa/YtOaUFZXvEBohN83hFxbPHNvKK0LCG
	RkBG7OKmiMk2/XkYPd4Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705758954; x=
	1705845354; bh=82nmu2DyJPwmac1Y1zUdWc9LMCywxycb33mNUkKF/Pk=; b=g
	C7Mc/MXYwOt4TvOfksJ5XlcmEfxsVzsQUFg4DHMJGu0a/IvWr86c2ucFjjRjobsn
	OemaIBL4/3dZp4/X7SnJo/kCaA/fCPb3aDC8us92KF+u9R1piPXNqfEQXknnMPnW
	8UdCBTZh706eNyxLs13bptIPjECnBk5KWkuXlA0BWmdMM/JwD4JZ5hQkaGDmHI0G
	NLpRjGVpApWsuzRbpFwGa+dGYt9vyLK8uzVyDn55l/tGMu5WnLr3n2gdE3V8pIOA
	tBdsmaJxIo1TuIxzBAJLsFr5OnVVMFwJcE4tsweNtRLS8F1yYmvuMqv6FtobMDl8
	3ZOosW0dk0zmydYQItKtg==
X-ME-Sender: <xms:6tCrZTXANXbbU1IQ5RwmaLYKmJJ18C4wl0jiVTGj3W96E6iM5iKS5Q>
    <xme:6tCrZbmQZA5EH1LyRnxeH0V7eVJcFBrVR41jVXlyx8I0vDfxydH8rdQBvef1KwBAz
    e-SuiX_NQ>
X-ME-Received: <xmr:6tCrZfYsxEpw-WtiI9AWyu-TEPAdcTJ9WriCbNkOXtesKtW8rhzPXek2Sx2JyyL178E-XcMg8F5-87LSOx_iZ6rKp-2R8mpv4E8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekvddgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhimhcu
    nfhunhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrh
    hnpeefffeuhfetgeeikeejvefgtdefteehgfdvhfetfeeuffeuhffhfeekgfekgeehieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmse
    hfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:6tCrZeWUlyG62ZYA4RfzOrTHMgSmQh_3Pk4oz6DfCrKKCkPz7hqy9Q>
    <xmx:6tCrZdnnr5JA5Y-jfD1SzwvyYCsfAOb1ceXO-2WuaM3x3liViJos5g>
    <xmx:6tCrZbdJJerpGTJZNi9a-BmrUosP-uyJUdeZaPMLHipwajjWlCeHww>
    <xmx:6tCrZfkUz8c2IT2EWWvvYenmdNPcSI-4w5caPsgJikFdt8Srsh5oOA>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Jan 2024 08:55:47 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation); Sun, 21 Jan 2024 00:55:43 +1100
From: Tim Lunn <tim@feathertop.org>
To: linux-rockchip@lists.infradead.org,
	conor.dooley@microchip.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski@linaro.org,
	devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Tim Lunn <tim@feathertop.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Chris Zhong <zyw@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Zhang Qing <zhangqing@rock-chips.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: rockchip: rk809 fix existing example
Date: Sun, 21 Jan 2024 00:55:27 +1100
Message-Id: <20240120135529.899403-2-tim@feathertop.org>
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

The example for rk809 picked up the wrong compatible string when the
binding was converted to yaml. As a result it also specified too many
vccX-supply properties.

Fix typo in the example specifying wrong compatible string for rk809.
Remove additional vccX-supply properties that dont exist on rk809 so
that binding checks pass again.

Signed-off-by: Tim Lunn <tim@feathertop.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Fixes: 6c38ca03406e ("dt-bindings: mfd: rk808: Convert bindings to yaml")

---

Changes in v3:
- Drop label from rk809 node

Changes in v2:
- Fix vcc-supply warning detected by dt_binding bot

 Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
index 839c0521f1e5..eb057607dc54 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
@@ -126,8 +126,8 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        rk808: pmic@1b {
-            compatible = "rockchip,rk808";
+        pmic@1b {
+            compatible = "rockchip,rk809";
             reg = <0x1b>;
             #clock-cells = <1>;
             clock-output-names = "xin32k", "rk808-clkout2";
@@ -146,9 +146,6 @@ examples:
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


