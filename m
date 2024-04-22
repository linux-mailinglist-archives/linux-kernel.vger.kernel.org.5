Return-Path: <linux-kernel+bounces-153052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 168598AC86D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6930280C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DC083CD0;
	Mon, 22 Apr 2024 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="S9wLSgzy";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="UWLXFcOU"
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC7D13DB96
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776733; cv=none; b=mplBDcylqtZI3HNV9gEOXg5sphUYfzv3Z3cRLkFVcfoHCwEwwIB2NwB1N5U0sAV/4bxO12Y6VKCyGLIQhrueah3ilJoAyh7oTtWsZ/LllcntEf/R80PerJMVJu9y+cVBMmY22BAt22MgluYM4ZQq9/EIvm/OgtJMDC7JAuPa90c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776733; c=relaxed/simple;
	bh=YhE8qxmtx9VsAQdA927K/LfjbzSzYqjoVBsHAjnTLis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SXgU5F8/h3I/1RX/u/5zHwa7sJBRemDS2oBXRULGZOfjnWM9IhaQYu5d84umCqBtvLRt/u0sQnwO+WdnctRWEFeXvjOTdcLb4BOPEFDXaVUOUZnDyungrwx2hUH+FGs5JVfIqasTUs14uu+fv9wtifgRtaG/KNv/zMauI3BahNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=S9wLSgzy; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=UWLXFcOU; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe;
	bh=6xxT4AnGOT/oiwLV/mUq6t1GblNvqgs6p8n35GukuSU=; b=S9wLSgzyedYkOBVmy+dkS9dvK+
	wH8hhPU2DK8ENvDLluFPTY+C7i996CUoi2WuR4pCwSX6iv5NNNvi5UVmaFc2m5LtYdU7PA2cyoP5p
	fcDiCcqVbE0TKzyfUTlh+SCwpBfU2MtQjOiEY9GUFsPpSRprKtHNZKFR039pMNRmAMosO/dPdSYsr
	PJD+27y7IXRk9sowX+tfQPjKLtjR0AgRcadgKG4p1KljAJIVSeCBiEA+0u974FoV7ovv9PzyUyMto
	FmDGYL0oWmrm1mgVZpY6ZquMJ6j/zfjCJSBCl864SpHrve/eQvuAOdQdPOe4IRlwvKc3A2ltTMpTn
	JiSZKX5Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1713776713; h=from : subject : to
 : message-id : date; bh=6xxT4AnGOT/oiwLV/mUq6t1GblNvqgs6p8n35GukuSU=;
 b=UWLXFcOUxo3/rRdk+XKaf5hdRtX/CdP8eMg+XeENKx0JvuODyETT1X8mOYrqnnvc6fAVT
 jKUOh8C4HTJJbNTSJhYZKL6OWnR451stwHvcINclBggLrhrLhwJqbjzRiYfnCsEzrCE2fT+
 LoJqMl9UGLpH6RBd5h4ZwmLCy1wo9RfDUe6SesO8nc4jMJkbNgWOQh/NgQemdRlmmuXHTvD
 RyCzfhUmkSwMpBDZatIq/E9Vl6WS/K5ozwAS+WDD/zIPX3XeRB0fidLbwPO4aMnamjPA51f
 qYJ8Mg5doetiutzCllzG8sbUkzecsn5yJY4Ywp1Kbl4McVFPCDnFKTfi8ifw==
Received: from [10.143.42.182] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1rypat-Y8PDvh-8B; Mon, 22 Apr 2024 09:04:11 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1rypas-FnQW0hPpvx6-he9B;
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
Subject: [PATCH v3 1/5] arm64: dts: freescale: imx8mp-beacon: remove
 tx-sched-sp property
Date: Mon, 22 Apr 2024 11:03:58 +0200
Message-Id: <20240422090402.33397-2-f.suligoi@asem.it>
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
X-OriginalArrivalTime: 22 Apr 2024 09:04:08.0808 (UTC)
 FILETIME=[09027E80:01DA9494]
X-Smtpcorp-Track: hOfvmEynGvdA.zVsjDXppmfDz.SeecCAIAa2T
Feedback-ID: 1174574m:1174574aXfMg4B:1174574seGOAHZBY8
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

 arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
index 8be251b69378..34339dc4a635 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
@@ -106,7 +106,6 @@ queue4 {
 
 	mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <5>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
-- 
2.34.1


