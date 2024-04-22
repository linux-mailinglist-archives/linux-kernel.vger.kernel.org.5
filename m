Return-Path: <linux-kernel+bounces-153051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD2E8AC86C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1A41F21070
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD59313CA90;
	Mon, 22 Apr 2024 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="f3EvZ2Rn";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="RGi0he5o"
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1FC13DB83
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776729; cv=none; b=e2PDoWmvru6RYxq42X7Wpvxv/OI7UtnaynWCGgphcSI2nGRPBLoWhLZChWmamfLNuISIuX1gog5CWxE9yicEv/zHQAkpB48Uj9gm6SCmT4F5Th3puV4f2Aebz2VCZIruBs4K6tIKnoQxfTCOOWcKCnORMxIqOmMo7Vn9TqtVIjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776729; c=relaxed/simple;
	bh=Pwq11WzAHtrQvtPi60VnmJqM0H3zSLr77uZezUo8xd0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P0j00bqMrDW0aJTiQ0asI/7ZfS8Z9sGCd9fNOmdPGQdLnPoAEJ5cyuIIX9AKtIE6zZwA07u7yI43SUyilkANRylj3bzYO7rkCs+VC3WH63+JZSyg8A7D/9Ba3m8OXix4oJCReWF5jHaNEEgf5dNuPZEEYonrwf6tnCogMSCGfuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=f3EvZ2Rn; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=RGi0he5o; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe;
	bh=DUgI6FiI10ay0TPqWNHINphhvGFSuWao6S97h7oSrow=; b=f3EvZ2RnIERT7493+4E6/utPfp
	Eodt37tHBBUTLUV9X/CVbvRa0vgF4k8vQmrcmBorgYlrL8EiJ//m988yWDBtYRYHfJw0ysoLiUBb1
	7E0OrLocF1M1Uny4HYXrzPoZPjaMD6RV/riJdu2UR1YrGeYyBfvqkrqmeYkr+WX8Gs0QTMzjnNFv9
	DbEkTg396oM6X2wSY+d3pURuuRo8fnCa+7Q4xyS31Ls6kaQGMTEQczIfuzAqqWpIPupRDM7wUGZhM
	+2j6h/6GCypykv9zoNmE3oHwQtHy6L1SSg7PuWk74AczfcMOKPEWhcRo0Hlj6OXEHGeCGMaRYAODG
	EQmWsBBA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1713776708; h=from : subject : to
 : message-id : date; bh=DUgI6FiI10ay0TPqWNHINphhvGFSuWao6S97h7oSrow=;
 b=RGi0he5o67UzavqiXPOkTktycYiQmrv1fXZOIFTjkpePQ0M8mOGFGeUgfXr1VAGmAq1sZ
 RfUDRvZlCTnP62M1m/dXSGpddNSEhpvtD9ihMVBNv0qG11lAFCWtHyxQUa95Ayx+1fDqLfN
 77b4bDREnLHf2/GafmVihV1PbxdTchq3akladwuoZlq6Cvmp9m8x51SYyWHK+V4wlrj+uQa
 fNIg6cOZ7EP1Dtn5Cfm4VVIDPNVQI+H+bXV9o/0jei4RyWTnVKON72s60hYcGj8QnaTHHb5
 zqM4oW+p9hRccZ4n7Hb+pihXZP3hdH+w9jJ1Q7YxCT1ZMmzSb9CD8ZLxAErA==
Received: from [10.143.42.182] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1rypas-Y8PDu4-Nh; Mon, 22 Apr 2024 09:04:10 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1rypar-FnQW0hPpvx6-jaYr;
 Mon, 22 Apr 2024 09:04:09 +0000
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
Subject: [PATCH v3 0/5] arm64: dts: remove tx-sched-sp property in snps,dwmac
Date: Mon, 22 Apr 2024 11:03:57 +0200
Message-Id: <20240422090402.33397-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Apr 2024 09:04:08.0714 (UTC)
 FILETIME=[08F426A0:01DA9494]
X-Smtpcorp-Track: js9P4QpV3-4F.deZ2hOMntGqk._NMrgQPMIII
Feedback-ID: 1174574m:1174574aXfMg4B:1174574sxe1HhfNLf
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

In the ethernet stmmac device driver:

- drivers/net/ethernet/stmicro/stmmac/

The "Strict priority" for the tx scheduler is by default in Linux driver,
so the tx-sched-sp property was removed in commit aed6864035b1 ("net:
stmmac: platform: Delete a redundant condition branch").

This patch series remove this property from the following device-tree
files:

- arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
- arch/arm64/boot/dts/freescale/imx8mp-evk.dts
- arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
- arch/arm64/boot/dts/qcom/sa8540p-ride.dts
- arch/arm64/boot/dts/qcom/sa8775p-ride.dts

There is no problem if that property is still used in these DTS,
since, as seen above, it is a default property of the driver.

The property is also removed, in a separate patch, from the corresponding
dt_bindings file:
- Documentation/devicetree/bindings/net/snps,dwmac.yaml

v3 - Removed the tag "Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>"
     in patches num. 1/5, 2/5, 3/5 and 5/5 (it was added by mistake).
     Added history in each of the patches, as well as in the cover-letter.
v2 - This patch is the 2nd version of a previous patch, where both the DTS
     and the yaml files were included toghether. Then I split this 1st
     patch series in two, as suggested by Krzysztof.
v1 - Original version of the patch where, in addition to these DTS patches,
     there was also the one related to the correspondent snps,dwmac.yaml
     dt_binding file.

Flavio Suligoi (5):
  arm64: dts: freescale: imx8mp-beacon: remove tx-sched-sp property
  arm64: dts: freescale: imx8mp-evk: remove tx-sched-sp property
  arm64: dts: freescale: imx8mp-verdin: remove tx-sched-sp property
  arm64: dts: qcom: sa8540p-ride: remove tx-sched-sp property
  arm64: dts: qcom: sa8775p-ride: remove tx-sched-sp property

 arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi | 1 -
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts         | 1 -
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi     | 1 -
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts            | 2 --
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts            | 2 --
 5 files changed, 7 deletions(-)

-- 
2.34.1


