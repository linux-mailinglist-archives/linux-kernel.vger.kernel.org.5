Return-Path: <linux-kernel+bounces-94348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04D5873DC1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67559B20A79
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDA913C9FB;
	Wed,  6 Mar 2024 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="dqn6goSP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="qVJlq9pw"
Received: from fallback21.i.mail.ru (fallback21.i.mail.ru [79.137.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA1C7FBAE;
	Wed,  6 Mar 2024 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747372; cv=none; b=OGrqXzJbPXPmfsIbUGwb0DGgcQ9pCflcZBAmnhDGML15px5tm8eMqAjA3sEaAF1ZIXI9FokdFJMdHK1hnW3iNO/zcQtXkhEb/ZNw4SxXAbxgnToQAi3ylDnCZu4oHmj6vWgF2CnrxaUFCP5xK/J8Tuuz+pj4YYHgy5TE5V6DRkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747372; c=relaxed/simple;
	bh=nfuv/qNlghjeWSk4MflAiPLs70gZ3Wj71I2bcATpPTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRhrTlXx9arNF8KLHaRL7Fdy7pttn5HHx30+I9PYzPZ+JD30fDIldysM9zU90qroYQOIWWahUZRkE80kjeSW+N2cU6u80WlSoQVcnLd+5fMzKg6JdGprqkSTYhn0v5FMXTaCbJIMk0k/n8FfnclUFClFMBAg1HIon26ksCIaAMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=dqn6goSP; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=qVJlq9pw; arc=none smtp.client-ip=79.137.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=sayOMG/a7cxTEcN/F+mJpbiKXDApnBZxhnQAjqETHYg=;
	t=1709747369;x=1709837369; 
	b=dqn6goSPV+36Z+6br0vt0isbE15q/GsrTY9TNH6uZGBsF+aQWY6sNdt7GnoMcL5/apBj7g906ABpLCczsFe0ohtgQgVJEp+y+kz4eWl0c2b8nkNkZdhgpqDqLIHQXVA2cYupBeYeVP8cCjF2JfvSZQHoOvXHbRX2Y3j5dMV1D+A=;
Received: from [10.12.4.36] (port=32876 helo=smtp59.i.mail.ru)
	by fallback21.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rhv3E-00EWkO-OB; Wed, 06 Mar 2024 20:27:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=sayOMG/a7cxTEcN/F+mJpbiKXDApnBZxhnQAjqETHYg=; t=1709746052; x=1709836052; 
	b=qVJlq9pwdd2beDyaRhh2TxuPzkL+GHMg7RPOghYa2SvUN6UcLFB7FEi0i1znFV2T3oGfpRhq28R
	zu/0He9NjLCUq/oe06YlDBgBLTDjsJIuDaDlAFSSUEBa3FAYMwx8rwq5D7rWi23BLgpob0etPILxM
	0jA77NwOPNhJT0EcHwI=;
Received: by smtp59.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rhv30-0000000F1Va-2RcR; Wed, 06 Mar 2024 20:27:19 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: pavel@ucw.cz,
	lee@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org
Cc: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 2/2] arm64: dts: qcom: pm6150l: add Light Pulse Generator device node
Date: Wed,  6 Mar 2024 20:27:10 +0300
Message-ID: <20240306172710.59780-3-danila@jiaxyga.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306172710.59780-1-danila@jiaxyga.com>
References: <20240306172710.59780-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD987C0EE6E7F0A597DF2E6F6001F0923FF54E1DF110EA51DBE182A05F538085040E9F556BD55C367DB411046492FDDF8064ABD3B6D7136F02B8FCBEF1FD3BB67B1390AAA442BE8083A
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE75210414551E8CD62EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006377E85B0EC44E8FD73EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B73AB1701401CD87157E3AD6515A1C3C110CEC9970578033BACE5DE51FC050994A471835C12D1D9774AD6D5ED66289B5278DA827A17800CE73AFA331E307B52169FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C3E97D2AE7161E217F117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CFDC43A4843798502DBA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B6CC57694C5FB0D60276E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249957A4DEDD2346B42E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B666D37212B2E9A769089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5BF8E783E94BD245D5002B1117B3ED6969485218F8EE43FEBBFF4097FFC9E796F823CB91A9FED034534781492E4B8EEAD6A17C1D737525568C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF99C035884670EE351B27250F58A98014BE4A057260BAC83169A130FCF8937442D753EA1A396000B0A2A143A52978B9DD6D3EEF26A1BDEB90C777010AFA8312B6FB53AEAA466CFC9A42BF32D1DA1046D202C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXhgskDnfdo7g8O5UHNuBNSp
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949810C5FAF77747E6D2EF6A6F50B1491C0352187E280D90D46DEB44C5CD3DD77950C2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B485448333635D8AFAF2FD4A3C9FF394F5F12B0793FCE63EAD049FFFDB7839CE9ED2C2511FF248D2A27B44701CBD463A8A5C1E53EC3AF7BC7D0F63E9A0504151D2
X-7FA49CB5: 0D63561A33F958A560416A7FD8E4649890419354EF96C38935C53782351F85508941B15DA834481FA18204E546F3947C2F20CBB68F4D2F81F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637F35A6E24A0A0A547389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3975373433331DEB835872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj9auBsoWJeY8O8DzWRTqOfg==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Add device node defining LPG/PWM block on PM6150L PMIC chip.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 arch/arm64/boot/dts/qcom/pm6150l.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm6150l.dtsi b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
index d13a1ab7c20b..0fce45276e5c 100644
--- a/arch/arm64/boot/dts/qcom/pm6150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
@@ -118,6 +118,16 @@ pm6150l_flash: led-controller@d300 {
 			status = "disabled";
 		};
 
+		pm6150l_lpg: pwm {
+			compatible = "qcom,pm6150l-lpg", "qcom,pm8150l-lpg";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#pwm-cells = <2>;
+
+			status = "disabled";
+		};
+
 		pm6150l_wled: leds@d800 {
 			compatible = "qcom,pm6150l-wled";
 			reg = <0xd800>, <0xd900>;
-- 
2.44.0


