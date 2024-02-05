Return-Path: <linux-kernel+bounces-52418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2573F8497DB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A5B1C229AA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4C91759D;
	Mon,  5 Feb 2024 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HMRYX5pd"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0481798E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707129140; cv=none; b=kOpSG+eidnRyQPvA1fFy33A6a9j0LoEZuSsPpQmsiXkM5sObgTxZc1UiDxuA7TCyk1vsvFN/AFsy+q2kqdIgMbXZrlZy+f7gSaBsOPrvhfJrRy60PfXTzHIYTNXLJVqBYqIE7l4ZZ9Cbghtb5PkOF17QHuR6+FyBEtX4pzgQDfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707129140; c=relaxed/simple;
	bh=MFOE+nUaSwDTYdIw9JQlFvPuda2tfFqnXYWlhZRBQXc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=N9mPevaxKDIlPT0Q2q/6Hc3z+w/V+/Gldp41JPvMvb04GUxyeiZi725P3/YDwD1ML2GPfRHjnQYJuCHrWZiexqoAkj3ZUFXd7UOnE0vhpZIMK1nsInE7G13xr1pfZUhIZ210dfb8RyaW/3kRuWJoJ/ralFcCk2yWSTZl/pQXOCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HMRYX5pd; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240205103216epoutp023e3677d54ca02dfb53c80f95e117e0fc~w8Oebxzfb1458614586epoutp02K
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 10:32:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240205103216epoutp023e3677d54ca02dfb53c80f95e117e0fc~w8Oebxzfb1458614586epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707129136;
	bh=rTfeTZ1ggn+RSJzom8PUIzN6CDAju1vOdXUC/7MJkyo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=HMRYX5pdwH8IpHuy9SxI15wo75ZVsGXkYXTDa+vUksylHbMYGooYViChaxBmyvhZP
	 UMttth/AzIGoj9cUyrUN4ynrLbbmA864r6LHlY9v4gd8kxGdIWbBeXr6dFFEyxpyfk
	 eX5B3SAYN7ZO9UztYfBNeHRuqXkcDtHNLqdegtqw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240205103215epcas5p25b3cebc15ff98c8ef461994fdb5193aa~w8OeEttbK0949909499epcas5p25;
	Mon,  5 Feb 2024 10:32:15 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TT2kQ1cvxz4x9Px; Mon,  5 Feb
	2024 10:32:14 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2B.25.09634.E29B0C56; Mon,  5 Feb 2024 19:32:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240205082631epcas5p170b45d20431bfe0b9410caf470216e92~w6groBMcR1289912899epcas5p1X;
	Mon,  5 Feb 2024 08:26:31 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240205082631epsmtrp19edb53b67162d04dbd76a9e66613707b~w6grm3anV2306123061epsmtrp1U;
	Mon,  5 Feb 2024 08:26:31 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-b6-65c0b92e133c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	95.79.07368.7BB90C56; Mon,  5 Feb 2024 17:26:31 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240205082629epsmtip160ca2a4b599a9d600f44baffbcea11da~w6gqK6xcr2432124321epsmtip1S;
	Mon,  5 Feb 2024 08:26:29 +0000 (GMT)
From: Tamseel Shams <m.shams@samsung.com>
To: alim.akhtar@samsung.com, linux-fsd@tesla.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Tamseel Shams
	<m.shams@samsung.com>
Subject: [PATCH v2] arm64: dts: fsd: Add fifosize for UART in Device Tree
Date: Mon,  5 Feb 2024 13:56:25 +0530
Message-Id: <20240205082625.39259-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7bCmlq7ezgOpBk+2sFo8mLeNzWLN3nNM
	FvOPnGO16HvxkNli0+NrrBYPX4VbXN41h81ixvl9TBZ3WxezW7TuPcLuwOWxaVUnm8eda3vY
	PDYvqffo27KK0eNf01x2j8+b5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0t
	zJUU8hJzU22VXHwCdN0yc4AOU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBTo
	FSfmFpfmpevlpZZYGRoYGJkCFSZkZ5xfdpCtoJe9omnzLZYGxjusXYycHBICJhL7d+xg7mLk
	4hAS2M0o0XDsBRuE84lR4tqrlVCZb4wS577dZoRpOX+5gxUisZdR4tW/2ewgCSGBViaJBdOD
	uhg5ONgENCWOn+cGCYsI1En0bjkBNpVZYB2jxN+1C1hAEsICnhI/D30Bs1kEVCV29ixmB+nl
	FbCQmPlbBGKXvMTqDQfAjpAQOMUucWPaT6i7XSRWfFrJDmELS7w6vgXKlpJ42d8GZadLzH3Y
	ywRhF0gs2/UdKm4vceDKHBaQXcxAd67fpQ8RlpWYemodWDmzAJ9E7+8nUK28EjvmwdiKEv93
	90ONEZd4t2IK1DkeEtf/vmODBEOsxMIb21kmMMrOQtiwgJFxFaNkakFxbnpqsWmBYV5qOTye
	kvNzNzGCk5uW5w7Guw8+6B1iZOJgPMQowcGsJMJrtuNAqhBvSmJlVWpRfnxRaU5q8SFGU2CQ
	TWSWEk3OB6bXvJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamPI2
	rFF0P+sfl7xBf5Kd1e99s+efy1HhO3U+VpM/SOrCxKuVqUd7HMut/JmXXtm6quj820Pp7z9+
	VBNcn9LJyn7TLI7nT57kUo3nwW53L58zv9ndJ/3jc9DTrm+tMbXhd8yer+Qo6jgoEPntQpFc
	f3b9q6VuPHvm5s/+eblifWRv38KJs9dN27Zl7XHVIPV27/L4km92kxtN303fPXfvoSzxhsv6
	OuHWX5aUdtUlFvxe1n7Y41pGi43CDre+G/F+67VzZl5Yaxjo0RtlIaUnIXpSeukF283dRtlC
	3gUv1EUeyllf38e5IvPoBYUwqQUdDvP/vlj75sffRezSlzdfdz22++BLx1cLDex1ir8/llFi
	Kc5INNRiLipOBADV1hCF9wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprALMWRmVeSWpSXmKPExsWy7bCSnO722QdSDVq/8Vs8mLeNzWLN3nNM
	FvOPnGO16HvxkNli0+NrrBYPX4VbXN41h81ixvl9TBZ3WxezW7TuPcLuwOWxaVUnm8eda3vY
	PDYvqffo27KK0eNf01x2j8+b5ALYorhsUlJzMstSi/TtErgyzi87yFbQy17RtPkWSwPjHdYu
	Rk4OCQETifOXO4BsLg4hgd2MEqeOzWeCSIhLTPu1nxHCFpZY+e85O0RRM5PEvxWPmLsYOTjY
	BDQljp/nBomLCLQwSqy+fgKsmVlgE6PEg/1cILawgKfEz0NfWEBsFgFViZ09i9lBenkFLCRm
	/haBmC8vsXrDAeYJjDwLGBlWMUqmFhTnpucmGxYY5qWW6xUn5haX5qXrJefnbmIEB5qWxg7G
	e/P/6R1iZOJgPMQowcGsJMI7QXhvqhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFewxmzU4QE0hNL
	UrNTUwtSi2CyTBycUg1M4ozBsy9tNVx2esrm/qQ44VQl38122Y0+vcaPfZunTerz9QtzUxRQ
	/KasnhKYKR491elo2qVb9YuDlHk+pPSXTP3M73vrrNL0Q1anG83cp6xPyGeyzjl6zGPXoo0K
	kj/bJ1n7nKg1szc9zGn3viG634uhMXp50UyDM8WzfpVkv/66qvfMj9QQW+MwrosXP3kq/f6t
	tnD+yYSp7OeNVuguYvrD9CXy6IyNLlp25/8fk99YdzK8P2dv/J0JGY8+r+Pf1b+E5e6vx4KH
	BfOcevq6Oqv4c3e8ag81XLloEW+bsfPJM0sO33QI2SARVS52kfXj54y6ogmb/FSdlDI4t+ey
	1my/fG3b47zWM/s+y7EqsRRnJBpqMRcVJwIA8yP2u6MCAAA=
X-CMS-MailID: 20240205082631epcas5p170b45d20431bfe0b9410caf470216e92
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240205082631epcas5p170b45d20431bfe0b9410caf470216e92
References: <CGME20240205082631epcas5p170b45d20431bfe0b9410caf470216e92@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

UART in FSD SoC has fifosize of 64 bytes.
Set fifosize as 64 bytes for UART from Device Tree.

Signed-off-by: Tamseel Shams <m.shams@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index aaffb50b8b60..047a83cee603 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -601,6 +601,7 @@
 			clocks = <&clock_peric PERIC_PCLK_UART0>,
 				 <&clock_peric PERIC_SCLK_UART0>;
 			clock-names = "uart", "clk_uart_baud0";
+			samsung,uart-fifosize = <64>;
 			status = "disabled";
 		};
 
@@ -613,6 +614,7 @@
 			clocks = <&clock_peric PERIC_PCLK_UART1>,
 				 <&clock_peric PERIC_SCLK_UART1>;
 			clock-names = "uart", "clk_uart_baud0";
+			samsung,uart-fifosize = <64>;
 			status = "disabled";
 		};
 
-- 
2.17.1


