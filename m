Return-Path: <linux-kernel+bounces-27140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F38782EB17
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1D5285506
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AE112E4A;
	Tue, 16 Jan 2024 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="gOappuYc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fkO3RDEh"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C1112B9D;
	Tue, 16 Jan 2024 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 80EBA3200035;
	Tue, 16 Jan 2024 03:46:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 16 Jan 2024 03:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1705394814; x=
	1705481214; bh=w1YMVooaDUNQBk1O+CtoMJUHFZppLvEDdMn6ledxCLI=; b=g
	OappuYc+T/Ab5VSbVosyZk0ljpLGV1ZTWXhRU2wsCGJlHCj3o+9buMrPwVUoT5Sx
	op83I2pFHsiIh7OPdJWwzzLHTnCfM20AqMwQRGgAh1JwltxE7CMAJjXKpkQ6iltU
	k2hMoP4TCApk4vSVpBn+s5S/A1G0OCWnRcUsPQn1MEW3IlVvcHJS43cbjX1u9PRa
	ND9M0P6AV5Vp+0xvU2uiNnYfzcpIzZ2PgLtUmkxGCWNzmaH+v1XjNxADh2LkXdx4
	TSuHSmrdkzqlTYrpDVJ+UE5xHFtbqfoNwsbI8fnNIAVd5+k9E0qVjM3+pMXifUPu
	0sw11IrmExeVADyJC+5kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705394814; x=
	1705481214; bh=w1YMVooaDUNQBk1O+CtoMJUHFZppLvEDdMn6ledxCLI=; b=f
	kO3RDEhM+8fs2kJ3J8jvNyylu6NQJbpO7DrR3TUH1vP3CzNgv7rfpqQSz8gZLehj
	1NdJRGQwDvdMRnneDcnneCWmy4u/yyOBhBOFuSX9H1V2rZkWBMWhJiZc6UmiNuMP
	/PN30NX9yFeoylHZBTsVZjP7iEJsa/GWpRcMETh5QTieCmKUeABRe7J0Ir8h/3Pg
	EVODsCOmlUQvTkCODXsOJknRUu7pS0ejVujQz/1lzxoq9PdsXguK2tvp88+JVtJv
	7s8pSSYYLfh0rJyUGtH7bXRj9yNBCnpCBv2Ypu2XVPWn4+jlEHDu5/PPTSDdEq/G
	xWg5bttp7h3s3o14xH5lg==
X-ME-Sender: <xms:fUKmZbGKaS8hxLCn4wyWdsrKl0ElnZDWD8gFFAWBPiYfNZiEf5t5GQ>
    <xme:fUKmZYUvraPLWSPcsMQ9UIpBE2q6o7Yj0BXGu27V4vTfm8dqey42HHt2DmDZqPBIU
    qw2PpluYw>
X-ME-Received: <xmr:fUKmZdIRa2UFgNwS8jjMduPTjtuR1LLTJrmtgOaJwEEu1MCLQPe-9lXowIJ-q6tQ994p3vJ55W84aQKxX_SIz2QXCw3cyHGb0HU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejvddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhm
    ucfnuhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvg
    hrnhepfeffuefhteegieekjeevgfdtfeethefgvdfhteefueffuefhhfefkefgkeegheei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimh
    esfhgvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:fUKmZZGuFC-nknTn2gVAH0AdqG-D33UwTEZ6bBC87xXm7YMYu5Zr1A>
    <xmx:fUKmZRVelIjjMcvtZ5Dfxm3VmpSFuoQh3Q7Y-YRmTnfzRZXd0IO0ow>
    <xmx:fUKmZUOJ9eXtZgFJCjWVdDUrEagk0ttoRnzo-vWKUrNGB0JZsIuv_Q>
    <xmx:fkKmZaOfUugaIrdeEYlZY0j2CMvt5EgKv35OlKPIXdKOam2a9W-8AA>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jan 2024 03:46:48 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation); Tue, 16 Jan 2024 19:46:45 +1100
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
Subject: [PATCH 2/3] dt-bindings: rockchip: rk809 fix compatible string in examples
Date: Tue, 16 Jan 2024 19:46:17 +1100
Message-Id: <20240116084618.3112410-3-tim@feathertop.org>
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

Fix typo in the example specifying wrong compatible string

Signed-off-by: Tim Lunn <tim@feathertop.org>
---

 Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
index bac2e751e2f2..3f31478932c2 100644
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
-- 
2.40.1


