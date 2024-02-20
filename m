Return-Path: <linux-kernel+bounces-73387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33A285C1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05474B22861
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921B777652;
	Tue, 20 Feb 2024 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="dDPdAbTm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="x/6V/dM6"
Received: from fallback18.i.mail.ru (fallback18.i.mail.ru [79.137.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB672768EA;
	Tue, 20 Feb 2024 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447990; cv=none; b=hn+FdrGf8yP65LPSOvzI0H3TY9VVdYS5gIaK2IGaQBcwv1Mtm8dhO0yBmrPHhDuzxC9L3cG6s0CNNxtRpuV7BV24rmTOVC1ntQlpgh7QmE6o7t2QtK5J3l3JoL7OzHHty/7algK00D5QrTrJTx0QYt9DQvoi6PDR19md17MUtBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447990; c=relaxed/simple;
	bh=cRi6f7NJ18MDSpaU2cqe0SmUy2WSW0VtD9UvpMNUdy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyGgejg7wHx2VqkrXNYjPpT5eGYtrZ4J/cuhR9ySQJwpU5sfc4T/IAISvzLLFUOFuHkuU0UgSk0Tra2pLS72WMllLIO64ZNd3dSQ5EYE0KfhTtLnwWR5dojxMyrEAzwTXJISlHqAYXSeHMarQq/Grkl3kJ+HySHmuJ2oMHQeT9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=dDPdAbTm; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=x/6V/dM6; arc=none smtp.client-ip=79.137.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=SUtd7yQQiIYZFMiOI/jtTmS3OCkH80m4WFTn0Jjt1pc=;
	t=1708447989;x=1708537989; 
	b=dDPdAbTmHfCw+i3jgg3N3s+m281TAlasvCAYv0A7N2RrqEdf80D/5K993HiM4ZkPMIkCjkTB8cYy8KrfrbEfywudxJ+20pTDUaVGi3K8JyoMJIZvxp55VJ3exnelqcC/Fi8sVhHW/w6+gTE8hO10QVKMAiXrcES/dSfZ2XMT+kE=;
Received: from [10.12.4.25] (port=59548 helo=smtp54.i.mail.ru)
	by fallback18.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rcTMa-005IVE-Tm; Tue, 20 Feb 2024 19:53:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=SUtd7yQQiIYZFMiOI/jtTmS3OCkH80m4WFTn0Jjt1pc=; t=1708447980; x=1708537980; 
	b=x/6V/dM6hDVv8gsMYdd/p8QGO93M3uhx5OOgFCP02S8QMspl3MSt3Hx1LYo/iQ/MpPVStTaBMke
	13XxcyQueeiHo8oSuzbL3rA1dwPVzPZ7+77uS1wePDAZg9IpmzeFv7zSYWm2aRsD/7tYq9UABVch/
	rsTyijRZf4fd8Dbd4Zc=;
Received: by smtp54.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rcTMM-0000000GhgU-1DGE; Tue, 20 Feb 2024 19:52:46 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	david@mainlining.org,
	adrian@travitia.xyz
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 1/8] dt-bindings: clock: qcom,sm7150-gcc: Add missing CX power domain
Date: Tue, 20 Feb 2024 19:52:33 +0300
Message-ID: <20240220165240.154716-2-danila@jiaxyga.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220165240.154716-1-danila@jiaxyga.com>
References: <20240220165240.154716-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD99B083F863FC6FF423C59A22CE28C5BFB8E95D8696033C0EA1313CFAB8367EF908E2BE116634AD74D533776C0A7B63C0E40A02D48E7B53F4AC55926A01DA5C472EAC3EACB7F7CF7DD6464624B37E45577
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F2393C4755A27B53EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006379E90269B204C5E5D8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D87F8CC65B425D105FCF466CB8E830073E5A74B63BAFECF990CC7F00164DA146DAFE8445B8C89999728AA50765F7900637C314DFB726039F08389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8BFD98ABA943BD70BF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C64A52DF3AE21010F6E0066C2D8992A164AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3DD38572C665B7C44BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFED8438A78DFE0A9E1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C33A60492226029A77089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5CA2111583162E8E25002B1117B3ED6964A38998CA4F8969FE772F934B9BCD185823CB91A9FED034534781492E4B8EEAD27E9584FBD6BDD31C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF4A1029D38DA9E0398AECA979368D5737788D9216B7FC61B6752A16118D0DB0ADB94BA8791A304480F1AD97FD9824DBCD8A51A6A4691F511BC96C255941595840148A56B3DDAC9E83146D90F64BF3396102C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojiWfz0I2sVClw9N7lMJUyXw==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498132FA18D1217A7BFE08AF9BFB128101EE5F1533DD991FEC037914F18C79D8A0792C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4A77971E4CF73965D9E271BDE2CCB4C0C1108A30EAE704D8D049FFFDB7839CE9E76E35804B2850F20250C15F1006859E67BDE44D9163063EA429E3B7D91FDE685
X-7FA49CB5: 0D63561A33F958A5973C95C0FF11898DC0292B45FEBEB56F95E05B2AB85D3C198941B15DA834481FA18204E546F3947C28849D2BFDBC1551F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637ADD8F2E7B13CAAAA389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C367B172B3F0F4CA5635872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojiWfz0I2sVCmJ4IMC63S32w==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

SM7150 GCC expected two power domains - CX and CX_AO. Currently only
one is supported, so add the missing CX.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 .../devicetree/bindings/clock/qcom,sm7150-gcc.yaml        | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
index 0eb76d9d51c4..1360e9d1d6ee 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
@@ -27,9 +27,15 @@ properties:
       - description: Board XO Active-Only source
       - description: Sleep clock source
 
+  power-domains:
+    maxItems: 1
+    description:
+      CX power domain.
+
 required:
   - compatible
   - clocks
+  - power-domains
 
 allOf:
   - $ref: qcom,gcc.yaml#
@@ -39,12 +45,14 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
     clock-controller@100000 {
       compatible = "qcom,sm7150-gcc";
       reg = <0x00100000 0x001f0000>;
       clocks = <&rpmhcc RPMH_CXO_CLK>,
                <&rpmhcc RPMH_CXO_CLK_A>,
                <&sleep_clk>;
+      power-domains = <&rpmhpd RPMHPD_CX>;
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
-- 
2.43.2


