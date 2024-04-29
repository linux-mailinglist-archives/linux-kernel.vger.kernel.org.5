Return-Path: <linux-kernel+bounces-161986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7C78B543C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09DBB282F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94FD28373;
	Mon, 29 Apr 2024 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="nJ8zBzxH";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="bZ5i57Ju"
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A51E224EA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382854; cv=none; b=cJnhx/JpSX6KS6RO7gWrawgZ8qkx4hJeJ28HS5cKQa1DNmGR3zqe+XbPR3L81TMu41ziNYYNr6UuuCWnIpz7RkDfeLhjmqPusGfXCb9ZEOPMysUErusWi08jnVvKy1wo/yKuk8Mnz4vFvmbx1fhzZcNv73ZLEK2h00/sAwL6ocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382854; c=relaxed/simple;
	bh=PeIo8633KxMCicFSGbU5eN9BSne6OhoxkH2gFHVl+WI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hAQO0hctTQA4WkVGJc6x5zM6hNyVxXQj6vHSU3e8Brc4uy0fsBQ/Xjk7NoSdDr5WBIksym8w5oJtmmwHi7Wk3jldeQu2K35tIsMRdnASuL0vm6V8mrH7Je2JdXMr5Fh/N0Hgnji3+fta0FztFoUYLERIH3yulk5Xg78WKHFRkqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=nJ8zBzxH; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=bZ5i57Ju; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe;
	bh=/jnzyymWoI0n+E9HMAHvZ+vi8662r/KZP+FVgSW63Ds=; b=nJ8zBzxHr4DSbIqcA8Awk7zv9p
	WZiUSKyQDm82JDLXrMdnibFcFtCEt7OCsk4kYI9KmsrMf64rpPhC/AFCPi9Phyf16tJUQGFGEtmVM
	rQYkBK+IC2eudqAl7sw7QbLrvaXqGmrIk2FLJdFIoPkSlOIXmtTkJUe/YfwSc/yONiMSNJGx0nuN8
	wcqDwDhlsZzHwiQ+jubEfEem8s2kBOmsQL0TyIB1AgHPQY4U6m7Z8h+mCkZP24W84LPQ+pAe05tfi
	C7I+POtEfQIHoaCJGYV2PN+Lm6QdTZjWHv5wt3XJqYzPMPvSrup5DxbidAF2jGMUVrqKG3RDlTm0v
	1fNIzAQA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1714382852; h=from : subject : to
 : message-id : date; bh=/jnzyymWoI0n+E9HMAHvZ+vi8662r/KZP+FVgSW63Ds=;
 b=bZ5i57JuA2tKHU12sYmJk9f8/SpubIC3eZRrDqBYDJ1ebhHU9s2y/luvY75C6urHBuwnR
 7sPWCdBIE8ez71IdS+peLWnxaQ2H6icrCwLe8rhdU6bWmkC0Dc4reEuIlpSi5KlQg38GQmm
 R1NZw6znu51eJXkF089dFA4BLjsw6PX0Ga4BEDs5krIQE6pQ2+TC4mDuaVH26SuGCBVDsCF
 P8Nj6vk70r2+HnVkDec0QgdQ7itQaIh9iY/T97TKHOzs+wsC658k3RurQtrSrvNOifBU7yC
 3byJtisMa+583s9A4PAifM60Z470jKmqd8Pgp2Tl7dBuHMR4UibCj65uhXKQ==
Received: from [10.45.79.114] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1s1NI9-Y8PKfn-Go; Mon, 29 Apr 2024 09:27:21 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1s1NI8-FnQW0hPkfet-LMc9;
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
 linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH net-next v3 0/1] dt-bindings: net: snps,
 dwmac: remove tx-sched-sp property
Date: Mon, 29 Apr 2024 11:26:53 +0200
Message-Id: <20240429092654.31390-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 29 Apr 2024 09:27:18.0342 (UTC)
 FILETIME=[6E20CE60:01DA9A17]
X-Smtpcorp-Track: nehcao7v1Y0w.F4sYl_gXSkuF.PXW7mgkR__U
Feedback-ID: 1174574m:1174574aXfMg4B:1174574sSVfFvi59V
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

v3 - Added history in the patch, as well as in the cover-letter.
   - Add "Acked-by: Adam Ford <aford173@gmail.com>".
v2 - This patch is the 2nd version of a previous patch series, where both
     the DTS and the yaml files were included toghether. Then I split this
     1st patch series in two, as suggested by Krzysztof.
   - Add "Acked-by: Krzysztof Kozlowski <krzk@kernel.org>".
v1 - Original version of the patch series, including, in addition to this
     patch, also other five DTS patches, in which the property
     "snps,tx-sched-sp" appeared.

Flavio Suligoi (1):
  dt-bindings: net: snps,dwmac: remove tx-sched-sp property

 .../devicetree/bindings/net/snps,dwmac.yaml        | 14 --------------
 1 file changed, 14 deletions(-)

-- 
2.34.1


