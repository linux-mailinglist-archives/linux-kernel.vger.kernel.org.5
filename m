Return-Path: <linux-kernel+bounces-69973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35119859100
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59E131C2110B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BB57E113;
	Sat, 17 Feb 2024 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="rxxZvOtr"
Received: from smtp53.i.mail.ru (smtp53.i.mail.ru [95.163.41.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24E47CF12;
	Sat, 17 Feb 2024 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708187539; cv=none; b=qElG0PSXzf4ItCpygfqhjnpqYStqJB+U+0dhfppn95JtJ0UIWrdUUQARjjtQLpE+AMvsh/MLtUVuqJkM3uhnC0hcPfme1kEWfERpuBMUzrlbG2s7Jc2DDAW91h8fPdx8I45qRuDB52phFTojP5CdNkGE2JQMJluiDyQlcmzUObk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708187539; c=relaxed/simple;
	bh=lBHThpVRyKugUNxaoBVxjzLa67JAOwwPHcEFy/Fmmwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6zl2n0NBNwbk3aPrtQsFCPftJVQ9U4auV8X4fX0L2LBwkzK8M5R1O1IZ9UcX7zCQQWOhw93mkUzzKji6R2koyqxeLbCqnpUFteh+MU1mM3fc/CJtPk8SK7ns5xWNdVKp22/Wt1dPbqRG3IZOH4Cdpl2cz1NdmYodU3+VnuPlxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=rxxZvOtr; arc=none smtp.client-ip=95.163.41.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=uPMA+z4fQquc0esePNb3o/9GGq2EtJdAMkJlUCi7ZpI=; t=1708187537; x=1708277537; 
	b=rxxZvOtrwse0mV5q5THoeRBhotz+nLWve8CcSs5Dy0QNfYC6D0LuRACEUUHDZF6wOOFVLrv3T7m
	G8rNphBDJafAOOAITgNIx+uFN3d02SWyWfmPzCIM46d9dNeNi5nrqUdO4BHIKJkWMJHDs3n44VdaH
	nJeYGkU+rH/o9xY4D7w=;
Received: by smtp53.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rbNbl-00000008KBa-2MFD; Sat, 17 Feb 2024 19:32:09 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	bryan.odonoghue@linaro.org,
	gregkh@linuxfoundation.org,
	quic_wcheng@quicinc.com
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 3/3] arm64: dts: qcom: pm6150: define USB-C related blocks
Date: Sat, 17 Feb 2024 19:32:01 +0300
Message-ID: <20240217163201.32989-4-danila@jiaxyga.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240217163201.32989-1-danila@jiaxyga.com>
References: <20240217163201.32989-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp53.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9001F8F2F6BAD2021A4088691FB60B4B8D975C14E9881615F00894C459B0CD1B91A17C5990E3E481FDCA9057F3E010A3912F87B51CF1CAC1074EE5BCF6350D8DF3555984C5E13135E
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7DB84ED444C624799EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637C1CDCB5E4A85220F8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D87DCB2C4D8C7A56902CF864E62A0E4A14DC162EA146BBCC2ACC7F00164DA146DAFE8445B8C89999728AA50765F7900637D9CFB327BC390E24389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC85B63D382EEF4D896F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C86A7C529F68B8E5C9735652A29929C6C4AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3519BB56F7AF3758BBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFED8438A78DFE0A9E1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3DB8B71E42BA00C4F35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A54D945519303D26C25002B1117B3ED69699F1D661FF3EEFBA3E67C18142C611B7823CB91A9FED034534781492E4B8EEAD2739D626790C8313C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF9A6B8294760CB1B71F711BE1FAE977247A737684BA2356BC0FF2196C214462279EC5AF04A575AA6C34E84B500378195F16E2170B074DE7CD0B037B6FA0204BA550F1615C31904DCA457F7985AD47CF5C02C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojWUnWVIzXWr7eXYxTiCfLtw==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498170F032DA97786BD2CFE9FA76EDA5B4B7D9B56B041E14AB996565E2ECDC8A58C72C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

Define VBUS regulator and the Type-C handling block as present on the
Quacomm PM6150 PMIC.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 arch/arm64/boot/dts/qcom/pm6150.dtsi | 46 ++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
index ddbaf7280b03..bef5f28ba7cc 100644
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
+				     <0x0 0x15 0x01 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x15 0x02 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x15 0x03 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x15 0x04 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x15 0x05 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x15 0x06 IRQ_TYPE_EDGE_RISING>,
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


