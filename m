Return-Path: <linux-kernel+bounces-153054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A72D8AC870
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544691C208FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A807142620;
	Mon, 22 Apr 2024 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="mCk+zMdI";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="jHdEZZLg"
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900CA13BAD8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776736; cv=none; b=JS4G3D+DsGpYxCsDRvRD/HhV3qVVbjRDVy7zwCdDtZTO5ntZjLImOnHbcibgHEOj07L0UXctL2TusWNN6bL/1mcqN+KthpuOUvx7kA761kvC79vLjAzQ6zzUfQVXTivCQfM0//VTgmtuS/pu5zyrVPXicL+MQLXRxCKxdwHlt2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776736; c=relaxed/simple;
	bh=9KenQqv+kO2v4o7u59XGlbKR3pxTieI8phIko3F9f8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IVHn1Hs/n6zrUIb2GQGDO6Q38fzi87mj45EfUgVm0DrFUHF8EkwnkSJpWS7kxm3UDNhfYHY4rVNcYT9CfKWCuORy696F6hFv3ic+tZwuQ5CahGH2Wfsfh4Hfmmvrn/m1OlAqpu5fwu4QA0R2GPEz7cM3EeB+VXgHDpbj65PYW5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=mCk+zMdI; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=jHdEZZLg; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe;
	bh=epoZd4VyEro9D8FxheLPEmd8Umgh+ceKjCcGQ7KG1F4=; b=mCk+zMdIuJFtvO1HBJFbb/I5Uk
	byoZYY/oILXGDSlCORIWJYjkOXA5YeSv2tnF1sJcwJEFfsf/uv5oiK9SH/erk3iosXUfN5Lm4yjaW
	agasICcGm2vHGq03ejAJ1vggp3hMsXlrql5b92sNilC/KpHWjfz/mMCgR01P2l/cIFuA3x3BdM8jz
	IuF2L958GyNj0EUIvhfbZI50wag3Xb3b9wbijpH6og3C3fzDYmX/383LAhRxxz/vUhVohX9PQKrpr
	SQ1Cs40fBBwXdIdLxfEDEwGaY5VFzBQqQqbGjt+D+OX3LwtTATxgv62XJjhNb2ANGnDsd2PS4tMvZ
	nIV9du5Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1713776715; h=from : subject : to
 : message-id : date; bh=epoZd4VyEro9D8FxheLPEmd8Umgh+ceKjCcGQ7KG1F4=;
 b=jHdEZZLgtJmtp7u8xA7WDEE8fhquX/MM1xKRqHYa7baw6oD9i/TMSFmlOCQVmmJ4VmLAY
 zo3Cv30fvxbVfVgGkC/lkVHRJi08FxYhvG2VUJK+6Lp3tF1hYxV/GP3kLtpbS8UsJgoyy2p
 atL90uqi8tcPnOZlJi3qs9lQS7qpmNec0hKTJ0aMeHxp2OECNU5ZeY2LI4vbVuIEXw5zLd1
 92Gjmf7Cywc97yWWjTuUgMUkCkp+SK/epy4lRRZYsMymKDiKHIZU2yZ28qyfvY1AXmdkFED
 MXgXLStGy1VAneRKZpXpjloplYhvuwVrRRINUgzokbeiXgoNcqkl+13ndiNA==
Received: from [10.143.42.182] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1rypau-Y8PE26-Rt; Mon, 22 Apr 2024 09:04:12 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1rypau-FnQW0hPpvx6-g4B4;
 Mon, 22 Apr 2024 09:04:12 +0000
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
 linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>,
 Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 4/5] arm64: dts: qcom: sa8540p-ride: remove tx-sched-sp
 property
Date: Mon, 22 Apr 2024 11:04:01 +0200
Message-Id: <20240422090402.33397-5-f.suligoi@asem.it>
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
X-OriginalArrivalTime: 22 Apr 2024 09:04:08.0980 (UTC)
 FILETIME=[091CBD40:01DA9494]
X-Smtpcorp-Track: v1-wGt6RSAGh.G5L3fJAr95pK.npgb_AGP_op
Feedback-ID: 1174574m:1174574aXfMg4B:1174574sZgEaNysWw
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Strict priority for the tx scheduler is by default in Linux driver, so the
tx-sched-sp property was removed in commit aed6864035b1 ("net: stmmac:
platform: Delete a redundant condition branch").

So we can safely remove this property from this device-tree.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---

v3 - Added history, as well as in the cover-letter.
v2 - This patch is the 2nd version of a previous patch, where both the DTS
     and the yaml files were included toghether. Then I split this 1st patch
     series in two, as suggested by Krzysztof.
v1 - Original version of the patch where, in addition to this DTS patch,
     there was also the one related to the correspondent snps,dwmac.yaml
     dt_binding file.

 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index 177b9dad6ff7..11663cf81e45 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -225,7 +225,6 @@ queue3 {
 
 	ethernet0_mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <1>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
@@ -302,7 +301,6 @@ queue3 {
 
 	ethernet1_mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <1>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
-- 
2.34.1


