Return-Path: <linux-kernel+bounces-153055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCEC8AC871
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54492823E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B101420A5;
	Mon, 22 Apr 2024 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="Ho8cIDzb";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="BOIh4lX8"
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5419413CF9B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776737; cv=none; b=dPNCCoSaCVS0zWBon6ElWd1VBH1ziaLRY+ybcnC5PsIWaNRlJ4uNIXJ9fRPVst37BDF8G1SWNC4mH7dYIoZWlRlBT++/CImiIMF8BDzbZfN1A1yN1IQ0H08uhZtgfutU4KlTQWe9KnQ3519O/FE4DcJcYY/5hFo3wwr+IpNPJ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776737; c=relaxed/simple;
	bh=vr3mP70Ml+CTsiCqXFkvm+bmpkhuQn6pWYBnGDF4u1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SyiFMmBhdOW6VSFAN0we51+wCJ2VEzK0uNuPxld7YWFh47GQYYjdMgtYJUjFf/CCMfRwWhHq3arS8izRlgpdVsDBnOCUki5sKv9BRwosc20h+phHxqG1KvV2UcVOwLjFr5V4ci8cAXaZwXDfVAlolQ7XsizBgbjP1s/6gYnGSBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=Ho8cIDzb; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=BOIh4lX8; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe;
	bh=QgmQ2Gqg/9Dc9h8gAthGPlmhLJ1iqOTv73ICctSoMIU=; b=Ho8cIDzb8OszcSOg9gMAzZbSDr
	SHUSpxGe3hUHZcnTVT0REm6931OJZDm+h+oBflDXoHGF8kbRjspcdGxqsY8fUoneh7562T1indx6h
	aXiQR4SbaRLR19sMc6cqMiC24feTXta8fRkEl7iTRZVxeFY7iiv6snH3dkfMXHZWnHmV7aYVmESZL
	p3liDlgG7Fbhr9AdZxjBXJ0BKUHO/EzdmGQiB9Ycgu5eMpDE8VXAtdbYOzC3j0oQlSIdqbIZD9c1I
	KYZV77zG0FTMfw6yfxEVYgyi9w1FVxwrYRh32tZ9Kde8Th6w/fDTF9FnWK/uLAulM3IRSS9Stt6YQ
	mgfeywvw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1713776716; h=from : subject : to
 : message-id : date; bh=QgmQ2Gqg/9Dc9h8gAthGPlmhLJ1iqOTv73ICctSoMIU=;
 b=BOIh4lX8dYYiSJe/XpYlwKQl3DNtckCC1zIdBUVSgWpbIUK4+6OZFDr2v6ZSihknDZHrQ
 wlDeGaWeZbsuoy7+yR1yWSzQoC+Bps0Tp7UtaKqgnHY0ISAclqg0eB5X7jL/IE3qaPHGYg8
 cl8spSLlLkcFpWR7rUNuB97V5MvW9JLgB/fGCFfSVS51e2BCXgj+nj+2iNEVoqZwv32Vs69
 9ZtOn4KN5KqCdUzaeoo85VcBhxoD57mVdFm3RUS5OTBgFRzxy9UXIE5Xu0JENeYwb8YNngM
 a0n4ztzyJj96NiQNc0eSZD4JE7QQXwkjcRbOKYe4MpyjdyPESTQglVwVwU0A==
Received: from [10.143.42.182] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1rypav-Y8PE4i-Cc; Mon, 22 Apr 2024 09:04:13 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1rypau-FnQW0hPpvx6-iJmZ;
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
 linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v3 5/5] arm64: dts: qcom: sa8775p-ride: remove tx-sched-sp
 property
Date: Mon, 22 Apr 2024 11:04:02 +0200
Message-Id: <20240422090402.33397-6-f.suligoi@asem.it>
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
X-OriginalArrivalTime: 22 Apr 2024 09:04:08.0995 (UTC)
 FILETIME=[091F0730:01DA9494]
X-Smtpcorp-Track: yskbd7rrqjXp.1TSEsxBI5PpW.cAM-0AxuICR
Feedback-ID: 1174574m:1174574aXfMg4B:1174574sM5RhJVoQE
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

 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 26ad05bd3b3f..2e1770e07f45 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -334,7 +334,6 @@ queue3 {
 
 	mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <4>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
@@ -404,7 +403,6 @@ queue3 {
 
 	mtl_tx_setup1: tx-queues-config {
 		snps,tx-queues-to-use = <4>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
-- 
2.34.1


