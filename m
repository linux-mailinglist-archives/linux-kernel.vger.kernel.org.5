Return-Path: <linux-kernel+bounces-153053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 257638AC86E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99E1BB22005
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D520535D9;
	Mon, 22 Apr 2024 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="J9e5/8Is";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="eaIQ/SX/"
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2979213BACB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776733; cv=none; b=LyEmcVyMfGSgjE6YWORzmdMDyZne/sMo3ct+dxdiJaehtmVxYuBTmyEFNYi29C5qAATJy8v2nBkS4dq86kvrtbDrkKWVCljLogyvGqKTmS4+gQ31Ax7OUWixCKjd4IWh1vjDCosSJMUalsMKDZ88BZHXMiBGA9P6sbloI9V5BYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776733; c=relaxed/simple;
	bh=t2eI8tvKI1hpvEgK+1gE/rmaW5rWqOU0VQ8ytyd3ng0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZEqN2yTXDw2kt4P+ZgRch1ncdsrCxLbjmKtSDbso1/PKCv17ilFQ3BPKPzDHAsWjSg4jInBQeUKKWWuaPXq80GjCwer4TfeWJablvJk0D+KblFNImMEhXAH8zJbrYNMBmLqatBXOKEWcLeeJUVNqL1sZa5Q7LGYjB/fY0NGgpPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=J9e5/8Is; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=eaIQ/SX/; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe;
	bh=TH2B+Yui+mmCtAONXy6DE87yiqCx8QnMvncW24XxHS8=; b=J9e5/8IsAEZaNgS5hq6F8CieYp
	zDP5xN80XywbtnqVzw5B5lLGW1WxbYl6yUmvZ7tHU3O87C3WKAwqEzM5EQbHTyFQ8byc3/IhclN10
	BTzmKLiiLPjbyuKOIzGKvPIvzI16XZGeCAPrQp9EYdvaB82OSY4jG1RsgNXmBWuZg1auOTuFU9bAa
	I9swgPWJVdI58EhzxAPjGayxCdlX+PNAHiRuNumqMHsm1gXYGiO6wYJmv3Q5K90rq1lm54Kz1Fw6W
	9kt+anZ3FhsdsAlm+wXbrTVmoxk/XucXlgKDkn5WkvTblcdheuVGhlDs0d3z48pMJ8Q/3G9Kc149Z
	UTLsEHvg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1713776714; h=from : subject : to
 : message-id : date; bh=TH2B+Yui+mmCtAONXy6DE87yiqCx8QnMvncW24XxHS8=;
 b=eaIQ/SX/B0o6+NZT09gFGh9Eseq9eT10BUghJChRFKySmar0Mb4uEQJIe62+RF7ST5CxE
 4o8Y7MTxi8dTuWFxctCWS4fV9xRKo6tAg0yAGd6a9OJuHctpslk19N+p879uYeRScECSDMK
 Nd9qoIAuuUtUqIDwkAevDtm9FTKkKzD7RW68CHXBgi3ciCbKhkmuvsBUZzJJFpOhy74Jjf+
 Lz90nBJk/4nFx72zmeyAwhhD/bYlH2A8o2a83h6OSumpBX7j+qvY9D9yZasMqWFQdvX8vED
 J6g3u09MyjIzKqmdULAXtxsxbKVClUZvB15v4LH1+mpXf/y3ifdUo5NzF8Wg==
Received: from [10.143.42.182] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1rypau-Y8PDzp-8e; Mon, 22 Apr 2024 09:04:12 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1rypat-FnQW0hPpvx6-i0lV;
 Mon, 22 Apr 2024 09:04:11 +0000
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
Subject: [PATCH v3 3/5] arm64: dts: freescale: imx8mp-verdin: remove
 tx-sched-sp property
Date: Mon, 22 Apr 2024 11:04:00 +0200
Message-Id: <20240422090402.33397-4-f.suligoi@asem.it>
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
X-OriginalArrivalTime: 22 Apr 2024 09:04:08.0964 (UTC)
 FILETIME=[091A4C40:01DA9494]
X-Smtpcorp-Track: iGWAynVELDh3.KwkGoJCLKT-b.uKJJ8wsnr_-
Feedback-ID: 1174574m:1174574aXfMg4B:1174574s9VjVG4CTv
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

 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index faa17cbbe2fd..21d4b6a9a1af 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -260,7 +260,6 @@ queue4 {
 
 	mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <5>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
-- 
2.34.1


