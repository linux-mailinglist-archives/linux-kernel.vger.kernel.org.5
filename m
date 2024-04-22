Return-Path: <linux-kernel+bounces-153056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4D98AC872
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25A7CB22BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50DC143C67;
	Mon, 22 Apr 2024 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="dFXZ0H3q";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="Vd0YycUL"
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E426C13E3F6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776739; cv=none; b=sglFa+kPWgPD87fDywITJpsXY+QtsuWEphCoS8EzM7u/pWH4f0OGz7SDfSBDvcLrU2ew0qknH8TrWqA8V/6m9Ek5bvzSHfoHNa5YtN/imYy2iWr+ECXSCWvQVEuovWPtza6OMK8wLAJ8IwCmQuS0XgIvLCB1NyuItLSoHQCi7OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776739; c=relaxed/simple;
	bh=yEN9o/dhRM9JPC0+w8OoIobXDP5lmxii4wx761ziq+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jhjg3Km+HiW28AdfJrRnaX4ZVDIyG3CITBU3Xev9eFBjKgMzkYAwBQSyqJGoCo+jJBLPVf8YlU+BgvWnToYrPeCeJfCSyLRxup3lfCQ45CSQnX76KOTs71rMp+HOWNX6gD0/xFo9G7QeA90WbCkQKjyw9zw9RgWe2vYVukoms7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=dFXZ0H3q; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=Vd0YycUL; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe;
	bh=YWMd160O8ByyLHKMWQQdEggOFTYKMJzdQptOX9jRM8k=; b=dFXZ0H3qpgVXvhN/EEnqoC99Hv
	U8CWdJWJajb1DjPImRlcLVrS95Yd+BgBMVInl8j25JAIOdV8c1nWQLxX/uXbRwqzYsYXmAiLyAfT2
	bl5vZslPCm7GmB0RzRhIaV2SxsbYzHHpwXSTGIJysSYDO99f1ok0cSKNjCW+DampEuMTfcmowEEFl
	b5eiGyL8aNiI/0u4LEi6/t/tFW/tFaVM44zRFARYG0lgBc04Bn3mVC1x88Jm6GlmwzwRubz3yZ236
	8bhtg5geN4JjxyiRYfH9ThbSnpY8FaxzUJNRvNlQzTJAr0Kzetq20WWQW51FLRsfUCJVfCaN1zw/p
	rJDst2Gg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1713776718; h=from : subject : to
 : message-id : date; bh=YWMd160O8ByyLHKMWQQdEggOFTYKMJzdQptOX9jRM8k=;
 b=Vd0YycULrLiGKd/a1pAEQAUwqZWEEPsoTnQcDPPakkWoDtdZXyi3hQ38gkVSCWPNiUB9U
 H2PVUGfJTsbpdkNz0hHK9nEv6ZXH/16pdbmeDWKTX+lThYDl166YFiErswknHPhtJLnuP+N
 snLLKw3GC5C3AoJjMaQWX/XOX8E1rK9qSgwv+HEr1CfHVhGB4sEmFJGGyaXCWldQ7mGhPS3
 RBRjXDnzu9jIrBKJKJnzDQ4N193ExqB9QDeOLjjXQ6oTqQWNE7X+0yUMLnEeWMWl8lCgWLs
 xTAaGO2iV9Yn9wX1o9iywz2Q9S3/rRihLbRG5l6JZV1AeGJsxraIdWlBw06A==
Received: from [10.143.42.182] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1rypat-Y8PDxt-PB; Mon, 22 Apr 2024 09:04:11 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1rypas-FnQW0hPpvx6-jxCo;
 Mon, 22 Apr 2024 09:04:10 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with
 Microsoft SMTPSVC(10.0.14393.4169); Mon, 22 Apr 2024 11:04:08 +0200
From: Flavio Suligoi <f.suligoi@asem.it>
To: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v3 2/5] arm64: dts: freescale: imx8mp-evk: remove tx-sched-sp
 property
Date: Mon, 22 Apr 2024 11:03:59 +0200
Message-Id: <20240422090402.33397-3-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422090402.33397-1-f.suligoi@asem.it>
References: <20240422090402.33397-1-f.suligoi@asem.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Apr 2024 09:04:08.0886 (UTC)
 FILETIME=[090E6560:01DA9494]
X-Smtpcorp-Track: G6KSG1EiCClW.OUHIggZV39E7.gLtwPAfJZxf
Feedback-ID: 1174574m:1174574aXfMg4B:1174574sgu0iI10_u
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Strict priority for the tx scheduler is by default in Linux driver, so the
tx-sched-sp property was removed in commit aed6864035b1 ("net: stmmac:
platform: Delete a redundant condition branch").

So we can safely remove this property from this device-tree.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---

v3 - Removed the tag "Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>"
     (it was added by mistake).
     Added history, as well as in the cover-letter.
v2 - This patch is the 2nd version of a previous patch, where both the DTS
     and the yaml files were included toghether. Then I split this 1st patch
     series in two, as suggested by Krzysztof.
v1 - Original version of the patch where, in addition to this DTS patch,
     there was also the one related to the correspondent snps,dwmac.yaml
     dt_binding file.

 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 9beba8d6a0df..8747c86689cc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -226,7 +226,6 @@ ethphy0: ethernet-phy@1 {
 
 	mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <5>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
-- 
2.34.1


