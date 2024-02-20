Return-Path: <linux-kernel+bounces-73667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D636485C5B3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B4B1F2191B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9364414C5B1;
	Tue, 20 Feb 2024 20:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="LDGe2mzH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="xba3j3kZ"
Received: from fallback22.i.mail.ru (fallback22.i.mail.ru [79.137.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C8514AD2C;
	Tue, 20 Feb 2024 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460541; cv=none; b=X3tuk2T0zp8b/qp/8EgiwmxqXBrK9OjHTDNtpA9LLlQpA4pp4x2nxiyM/kLopbgjtx+sx15IPecxOX5aHNLIjJ4nAZJz/GEhjTwXcw59d+LkAoeTtIzA9DgbRxvg1Ob8GfyR+W/yfBe9hw7JfcHFniBbRmWG+kkb4+w6vlQbFj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460541; c=relaxed/simple;
	bh=aSPiY/IEcbk+EOqg6YBJ/pwLC3ReUtuMP1mBMxYPEuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEgW/ShpTQkHDdL1ZzKg3Kb7z3KZ17UhY/t+ulX8ZF1R15j2y5wCDHcLJKmb0D4sI8cQr6GUmZDhwsJGt1IF1TYM/QUkT3cz6p9YddybIcgI0relUvn0h/i7Z+TaQkfgxrFLtUDWTAdGh8wGF+2BVnOUINeyHdd5r6jk17gH1Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=LDGe2mzH; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=xba3j3kZ; arc=none smtp.client-ip=79.137.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=WKh4yzVaf70i53yKA7eNv5RkfzDHagk0bf0H8k8se8c=;
	t=1708460538;x=1708550538; 
	b=LDGe2mzH5qYvg6lm34pFkgI6jgSq+A8WjFBMWpz9+uobptnaofsI1ji1TDlWNwAdcdfw5QLQtJ1Q/GHzNgZjI8toQ15FXBIJp6eFqgKv/pDCRZEgDeGquHZ/GOnr7V5Etq9pATfayrU3jhoWpHsc6wxxXfb7vosdUjeOVrYS/Tc=;
Received: from [10.12.4.26] (port=44012 helo=smtp50.i.mail.ru)
	by fallback22.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rcWcz-00EnpE-Up; Tue, 20 Feb 2024 23:22:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=WKh4yzVaf70i53yKA7eNv5RkfzDHagk0bf0H8k8se8c=; t=1708460529; x=1708550529; 
	b=xba3j3kZPai/xbKQTS04rummmsVrYRXE9QpWty//9eBcRXwrCNOABoiCI2Wk6IKT73p1pOWFvUB
	1FeYiHHMdbcaXxTBfl0pwPk/8BFoSroe2p3eyqiNQ/dUa/cPnSCtoyJ/O938/Gwn/I5aPLoalXWAV
	xJqk57trvDnXIuo2pXc=;
Received: by smtp50.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rcWcm-0000000BzSN-2QaA; Tue, 20 Feb 2024 23:21:57 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: bryan.odonoghue@linaro.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	dmitry.baryshkov@linaro.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH v2 2/2] arm64: dts: qcom: pm6150: define USB-C related blocks
Date: Tue, 20 Feb 2024 23:21:47 +0300
Message-ID: <20240220202147.228911-3-danila@jiaxyga.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220202147.228911-1-danila@jiaxyga.com>
References: <20240220202147.228911-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9001F8F2F6BAD20216FAE178C97F62E8BCB89B89319DA15CC00894C459B0CD1B9B82ACDA63DA5F563FFB2F1BA4D151868DB177717CD0750746DC888E7B15EF0D4E14C30E3D2487BCD
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7C2204D4F9A221771EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637CD1DFD3ABA64F6568638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D86D5CE13271C621C069776ED762CC1B435EAC4143E3E09363CC7F00164DA146DAFE8445B8C89999728AA50765F790063770DAEE4257ABEBB3389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8E753FA5741D1AD02F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C2D01283D1ACF37BA302FCEF25BFAB3454AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C31DD302B0B79430F8BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFED8438A78DFE0A9E1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3A27B50A64E76B53235872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A519F4C831E1EC73E05002B1117B3ED6967DF48347B8913934B48B7A7F94616420823CB91A9FED034534781492E4B8EEAD69BF13FED57427F1C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF4FDD6E7794BC984E0F47D26ABFF31DFF11EFB71298A0BF387C5268B6B9873F20C52D74DAEBEB4292F1AD97FD9824DBCDFF1C62E6A9F809DFC74530A4B3B7F0BE357C13C3573DBC5EE4FDFA4A036B0C3902C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojiWfz0I2sVCnWQbWmBW6SaQ==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981CD4E5312E4C90D184825860F061DF214A5D9A3F5AFABB1DCAF264E46D245A5E42C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4A77971E4CF73965D9E271BDE2CCB4C0C498EF283BD449B07049FFFDB7839CE9E76E35804B2850F20AB2B037A879186C0B6B66EFCDF5BAE16ACF7744086034597
X-7FA49CB5: 0D63561A33F958A570D4122A949DBA2BD545DA4CD1DA8319C806A4783FB430BF8941B15DA834481FA18204E546F3947C63B13348E4A204A0F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637F43B6139C7615A18389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C35CB5556AFF48B99435872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojiWfz0I2sVClk7YVVXccsdg==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Define VBUS regulator and the Type-C handling block as present on the
Qualcomm PM6150 PMIC.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm6150.dtsi | 46 ++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
index ddbaf7280b03..11158c2bd524 100644
--- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
@@ -63,6 +63,52 @@ pm6150_resin: resin {
 			};
 		};
 
+		pm6150_vbus: usb-vbus-regulator@1100 {
+			compatible = "qcom,pm6150-vbus-reg,
+				      qcom,pm8150b-vbus-reg";
+			reg = <0x1100>;
+			status = "disabled";
+		};
+
+		pm6150_typec: typec@1500 {
+			compatible = "qcom,pm6150-typec,
+				      qcom,pm8150b-typec";
+			reg = <0x1500>, <0x1700>;
+			interrupts = <0x0 0x15 0x00 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x15 0x01 IRQ_TYPE_EDGE_BOTH>,
+				     <0x0 0x15 0x02 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x15 0x03 IRQ_TYPE_EDGE_BOTH>,
+				     <0x0 0x15 0x04 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x15 0x05 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x15 0x06 IRQ_TYPE_EDGE_BOTH>,
+				     <0x0 0x15 0x07 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x17 0x00 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x17 0x01 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x17 0x02 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x17 0x03 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x17 0x04 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x17 0x05 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x17 0x06 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x17 0x07 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "or-rid-detect-change",
+					  "vpd-detect",
+					  "cc-state-change",
+					  "vconn-oc",
+					  "vbus-change",
+					  "attach-detach",
+					  "legacy-cable-detect",
+					  "try-snk-src-detect",
+					  "sig-tx",
+					  "sig-rx",
+					  "msg-tx",
+					  "msg-rx",
+					  "msg-tx-failed",
+					  "msg-tx-discarded",
+					  "msg-rx-discarded",
+					  "fr-swap";
+			status = "disabled";
+		};
+
 		pm6150_temp: temp-alarm@2400 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0x2400>;
-- 
2.43.2


