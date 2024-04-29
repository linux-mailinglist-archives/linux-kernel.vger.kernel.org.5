Return-Path: <linux-kernel+bounces-161987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A792A8B543E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4921C20D72
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23A829421;
	Mon, 29 Apr 2024 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="cQ139JZl";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="RIy0Cxgg"
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E227B22318
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382855; cv=none; b=VmnSGhh152TurIQcsI8NFcsKlADA8q9aXT21RHbbIAcS+erfgKoD81q562Uv+haa++h+AVDJg1yFiQZvWb32zaMkrxSSMP3317e596vK4gqMFRTd675DzvJmNXw6s62CxvO6XWaUlBLhljJN0PFqqDF1K7lBwmXk8F5m8P/LKyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382855; c=relaxed/simple;
	bh=30cqX5XdpQa8TGqXCdDPHM4UVl01LjROZCbP87EagOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pdWmgx/k80zqBUwAeL8SP0Cow/jl4hf9s62Cv+J8yPf4Z+KBPyhyNLgFr6tuBFaghHMSGkLxF2AvErh0QBsgcePeYPAbnLTk1X4vLal2gEmUhs2Xcf0k5GU1lilL/r3g/w/vzB4QbsqZffWk+vNu0T43jrXOGqxF0ZjJVCZORaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=cQ139JZl; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=RIy0Cxgg; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe;
	bh=nJrQkD6SYS7EZ39Pwcqy3OegRAr4vtSj0mwkDW3shfA=; b=cQ139JZll1YjT2F0xGZZ2Eaqt0
	uLa0ZeCO+DDWyJNBn0DkrwSo0HW7qaSnFHKIKofi2bg0+79le9KlyJm30VQ/h7iTtVhSCOA3AM957
	aURFbiw273PJs9HxJSCkbqxExyJDzs9Hw2C5o8H2yw0j8E2GQxZQWOh5lV6YpScGrbRvnG2ix9aqc
	KxOkmLUwfQsE6BgZyHC6bQJxunZM4t653YjM9U1R052ccOzk+gcqs5sIleYBk3W8avgQUNyPXKChR
	zglYR9CPC5ghwimrezU9AZTeSvs1sr/iDbFgc/Vj36ljirm8RmR7pL7QymaakyNClMG9sQQTkR/8M
	4IkbnpGQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1714382854; h=from : subject : to
 : message-id : date; bh=nJrQkD6SYS7EZ39Pwcqy3OegRAr4vtSj0mwkDW3shfA=;
 b=RIy0CxggibolWuJm+o/2rEN1HiS69UMECgF2WLK5nCltHHR3iAfIhlmSxautN1mM/0XtV
 jnD/DwjBzoO5xv3FACrIU1mDy9Er+l0Dpx1TsuLnYgZ9sJZaLYuwF25J7CqD/wJcknchGFP
 5XBBVA9yG/8Yc4NSGlQuQZaVtdf5/zc2M8/Voxt5TG8TNU562llnZn4fQ/lrjvp5fCubz5W
 tb7A8ZcHxYs72/ngiPV/0wdXPkGhfvntsnku4B0iNyOlXeQuxUx9wzFS8exjEC+uy4y5M0y
 v09KuRrUO9k7LPN8fHcueO1PVDV23/9jHXPiE1y4/JaEsFtOKVVJwix9TwEA==
Received: from [10.45.79.114] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1s1NIA-Y8PKoU-Br; Mon, 29 Apr 2024 09:27:22 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1s1NI8-FnQW0hPkfet-Om7l;
 Mon, 29 Apr 2024 09:27:20 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with
 Microsoft SMTPSVC(10.0.14393.4169); Mon, 29 Apr 2024 11:27:18 +0200
From: Flavio Suligoi <f.suligoi@asem.it>
To: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>, Adam Ford <aford173@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>,
 Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH net-next v3 1/1] dt-bindings: net: snps,
 dwmac: remove tx-sched-sp property
Date: Mon, 29 Apr 2024 11:26:54 +0200
Message-Id: <20240429092654.31390-2-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429092654.31390-1-f.suligoi@asem.it>
References: <20240429092654.31390-1-f.suligoi@asem.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 29 Apr 2024 09:27:18.0373 (UTC)
 FILETIME=[6E258950:01DA9A17]
X-Smtpcorp-Track: -hxUTecPyyFq.bz9aliRl8u2c.mFSb3AI5Rco
Feedback-ID: 1174574m:1174574aXfMg4B:1174574s5yIPG_of4
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Strict priority for the tx scheduler is by default in Linux driver, so the
tx-sched-sp property was removed in commit aed6864035b1 ("net: stmmac:
platform: Delete a redundant condition branch").

This property is still in use in the following DT (and it will be removed
in a separate patch series):

- arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
- arch/arm64/boot/dts/freescale/imx8mp-evk.dts
- arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
- arch/arm64/boot/dts/qcom/sa8540p-ride.dts
- arch/arm64/boot/dts/qcom/sa8775p-ride.dts

There is no problem if that property is still used in the DTs above,
since, as seen above, it is a default property of the driver.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Adam Ford <aford173@gmail.com>
---

v3 - Added history in the patch, as well as in the cover-letter.
   - Add "Acked-by: Adam Ford <aford173@gmail.com>".
v2 - This patch is the 2nd version of a previous patch series, where both
     the DTS and the yaml files were included toghether. Then I split this
     1st patch series in two, as suggested by Krzysztof.
   - Add "Acked-by: Krzysztof Kozlowski <krzk@kernel.org>"
v1 - Original version of the patch series, including, in addition to this
     patch, also other five DTS patches, in which the property
     "snps,tx-sched-sp" appeared.

 .../devicetree/bindings/net/snps,dwmac.yaml        | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 15073627c53a..21cc27e75f50 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -328,9 +328,6 @@ properties:
       snps,tx-sched-dwrr:
         type: boolean
         description: Deficit Weighted Round Robin
-      snps,tx-sched-sp:
-        type: boolean
-        description: Strict priority
     allOf:
       - if:
           required:
@@ -339,7 +336,6 @@ properties:
           properties:
             snps,tx-sched-wfq: false
             snps,tx-sched-dwrr: false
-            snps,tx-sched-sp: false
       - if:
           required:
             - snps,tx-sched-wfq
@@ -347,7 +343,6 @@ properties:
           properties:
             snps,tx-sched-wrr: false
             snps,tx-sched-dwrr: false
-            snps,tx-sched-sp: false
       - if:
           required:
             - snps,tx-sched-dwrr
@@ -355,15 +350,6 @@ properties:
           properties:
             snps,tx-sched-wrr: false
             snps,tx-sched-wfq: false
-            snps,tx-sched-sp: false
-      - if:
-          required:
-            - snps,tx-sched-sp
-        then:
-          properties:
-            snps,tx-sched-wrr: false
-            snps,tx-sched-wfq: false
-            snps,tx-sched-dwrr: false
     patternProperties:
       "^queue[0-9]$":
         description: Each subnode represents a queue.
-- 
2.34.1


