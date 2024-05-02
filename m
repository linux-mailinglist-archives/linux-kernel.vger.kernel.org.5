Return-Path: <linux-kernel+bounces-166336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 048A28B992F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345891C21BEE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C49A75813;
	Thu,  2 May 2024 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="UikdJYio"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862176341B;
	Thu,  2 May 2024 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646421; cv=none; b=lohvp/M1IJBMFDlyMKMArGEiuE2LcBcnJ9LsZ6z4vkkEgRUJiVyCoMA2ZLq6nix8qU44929FCW7oCnZORM1vZtAacGCscueyBD/adjtGlNA4TPZzoik07tlIZY7mzOWe2riD37pow6HlrxmISbhFoaCKvmJ3/5IPb3WF8973Qsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646421; c=relaxed/simple;
	bh=bdyAkeRgqSrFufI3kQJoEmI1WCv8IK5atLvcmX85qw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gAydHUq9Wh+NboEQRD/nG0YjC+E5F+NKP6VZXGLL55fixPavNep/JaItFpVQ7VDJv+Cjnws2gzcU0OI4XMRdLOnEPe3PH8CrRk4h/kJHUyWFkBYuTnLXmldHg+3KU6AfVC14CE3ly25+5nS9GW3V5ZGzAMuiROtR3Abh0q5o2+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=UikdJYio; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1714646412; x=1715251212; i=j.neuschaefer@gmx.net;
	bh=z1H4srJHNcb5BIAMp3q2n7Fh/jbh0k/UyMAjnW8Y9nc=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UikdJYioSQF8uPPg53dS8rTEKkmNuE1LibEAWBDnpFb0IMJEZn020rprsjCQ4OAe
	 xGuX96nDaIrPBAzxo4fS/4+WUITs7sYRVHqO85mJeczjJsgOzYDf8LlIly/22jh6b
	 iNaADUyUS47rYvpp0kSoEaRky3cftgCfcdHQatLK6PxWJs2gGJLQe1ShhgMaASQVQ
	 CTUjV+vnlibAt9AmpDkYF3hF7Y8UgivasVjwV8Ta5M281Ofm+rb2rPdmBoDPnpmZ6
	 5jOLhvTofMxsAhzZ3iZTq+qbFF78k4XCr9WfX7Xbsb3FMwU1RkrxwZWN+ORlCY7qM
	 5FZT9mJ0oG7Do4nnHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.1.59.78]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJqD-1sNm870YD5-00ncTL; Thu, 02
 May 2024 12:40:12 +0200
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date: Thu, 02 May 2024 12:40:04 +0200
Subject: [PATCH v12 5/6] ARM: dts: wpcm450: Remove clock-output-names from
 reference clock node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20240502-wpcm-clk-v12-5-1d065d58df07@gmx.net>
References: <20240502-wpcm-clk-v12-0-1d065d58df07@gmx.net>
In-Reply-To: <20240502-wpcm-clk-v12-0-1d065d58df07@gmx.net>
To: openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714646407; l=1382;
 i=j.neuschaefer@gmx.net; s=20240329; h=from:subject:message-id;
 bh=gdIaqrhURYiTo/eMHHjfcL4TfUOiwQNCqwm1DTjUKA4=;
 b=OP6jhR/C4oActZcDuSaLndojZtPMU9nA9yO2ZP246uduoCxMjJs+i/3eD11t3zb4gc0vzZn7N
 Y0jx39i0l5aAIuFbcqwB4uD2ouhSsYpLd/Zac913joFMyEYhStCl5ix
X-Developer-Key: i=j.neuschaefer@gmx.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Provags-ID: V03:K1:omJQWa2Zw/JDFvnJS03bMn41/4c06GZlk1ALxo7nu80AxMaIIxU
 E7mQs5VQjbnR7yJBxJNDTcBC3VMmXgzexq5Ora5rS9qHLkyVsRolJxLHYBcjjZ+Vu7EzECI
 7KSus8nHHJJppPwSanQF/SstH08zXy8FE2u90TBdkOND6SwxaPwhTY/nkUUTTGYQKDGdiJr
 PgHXNDJLwEJDcW3AjPC7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lznP2l3Hivk=;93JLoiaSYioywxUVJEbcH+Pg5Mm
 oT8Ff2Z1eiKx5hKpTr5so5sSBVkv7tNhku1GqOd/mjVGRvGdFvLz77B4uiRTODGyWCYbNVQeu
 hqs9ArUZofqWQqPlYlJjTi6KQqAFJt1rg1B01Q7jCHCJTVORYMRK8YljxE+zobt/4hRvYuQNK
 XAhaLoOQrUWdgUPtx4TsK9F7UfNYA8Pj64b5Axf27VNmwIun6K/Pzzvj/KzHSgJYevvC1sHle
 Ola8/l55l1WDFMAPZJKhQXm21wSF5StT1fnn15VmCaSrlhE95jc+aDVsD5tMrnqxST3AKlzE8
 tM4MURbv2xdE1WIDu85P5aiyK4apatTgcNzd9iLZMQ+wJmv3joTsL38Oyr0hAxyIa2CkyQRes
 7KgatOLCc0AgsQ6SHXL5dxgIpTmiKu3T8fPXQZPWf064le93MbJgHNn9fnYGomWQhueopLQGs
 cSOiFATSCSt3ZGyInuSRZdvWSdEXGv98C6WFuF5h59mKNGqmhn8sXBMXuJNmXHkbvP12ex3/r
 pjb5ig5PRpNPfKQ8u8q7XI9GR+XCE8KcnCWlSdLfHQKG1kdx0sIR7i/ShT9d5WnGQf1+TCKV+
 BVqTmJRgTc1sLqZ1UImyR/HsBRMYME2UPQnDlGIwQW5EIDxduiWydhurmV3dC/1vnzpcQBgnn
 n+6gNX8YPacdV+lAIF2dXo/T+6n8AySITA+SEVuFxCryId4aRx+xsx4HUBm8gz/zqGnpT4I6T
 zQ6Q4D+k6KApbSoxUgI0J1hA2WT/oUAS4S9pvfgRcH0nWRp6M1JUSKNAG0Ag6Q70nLlJcuHSO
 QAGOFCRW+dOvEe27Le1dh4WTZuvVn3bTZFPvpV2PsmVbk=

A previous version of the as-yet unmerged clk-wpcm450 driver[1] used the
output name, but in the current iteration it doesn't rely on it anymore.
Thus it can be removed from the devicetree.

Preserve the "reference" naming aspect in the node name instead.

[1]: Added in "clk: wpcm450: Add Nuvoton WPCM450 clock/reset controller dr=
iver"

Fixes: 362e8be2ec04a6 ("ARM: dts: wpcm450: Add clock controller node")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v12:
- rename node to clock-ref, because it isn't necessarily 48MHz, just by
  board design recommendation

v11:
- Specify since when clock-output-names is unnecessary

v10:
- no changes

v9:
- New patch
=2D--
 arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi b/arch/arm/boo=
t/dts/nuvoton/nuvoton-wpcm450.dtsi
index 6e1f0f164cb4f5..ff153858801ccf 100644
=2D-- a/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi
@@ -37,10 +37,9 @@ clk24m: clock-24mhz {
 		#clock-cells =3D <0>;
 	};

-	refclk: clock-48mhz {
+	refclk: clock-ref {
 		/* 48 MHz reference oscillator */
 		compatible =3D "fixed-clock";
-		clock-output-names =3D "ref";
 		clock-frequency =3D <48000000>;
 		#clock-cells =3D <0>;
 	};

=2D-
2.43.0


