Return-Path: <linux-kernel+bounces-69970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25038590F9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589721F21C46
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD7B7D3FA;
	Sat, 17 Feb 2024 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="PhCBeUud"
Received: from smtp53.i.mail.ru (smtp53.i.mail.ru [95.163.41.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE79F2D78A;
	Sat, 17 Feb 2024 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708187538; cv=none; b=ouT4/w6ylkE+gPJVllbrGc0Y5cWFwJrPL2gWMDyyjmNI6emlXAzxPEh+Dt+wRkdUTo7PdkCMEvnzuTtSnFsEYSU8qS4QBdBn6toqeXK2merL6dhGHv7MJxI0uT4UnUkyDLWv70YgjLq40kGU9QhwPgPP2U9XxE+UN4OcW0bwRDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708187538; c=relaxed/simple;
	bh=NpzWXTcS3jEtpjE8EmWMrc4bUN9vllwa+PpzMYwrV4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyq97S1LuCA4tlFiY0e3dKt0ktTXlmqAC9uKmWnLynt6dNeRkeFyduZVTKHVNiN3vSro+wUkb1T3x06E8lW55DdgWUJ2ozEa3rlxkLolZy2fZUwwrH0xID5hkkwl2yelhikAudpe5+f1JAipJT1JnzVC83rZaXO1Ea4yyF7VbO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=PhCBeUud; arc=none smtp.client-ip=95.163.41.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=NY9B+4+cpsLoLT1jzbvWL05VBzs1bDxK9GdCmEiPiUw=; t=1708187534; x=1708277534; 
	b=PhCBeUud4W7SvmyTgo8E/ImrRW4u9opLHNlIrGOpiFOLjJQFIkiL80nWW5RB1H5ITSrzJY8FNKK
	zxCA/tSxSzsF4u2MbJl/ku6Y+r4OjIhGYSc2Iy95ZiusOKkB+dQSxDs/ZFKuWQz48Wcf1ZjGKk0qo
	twiN4c4MYACDC/i+XMc=;
Received: by smtp53.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rbNbh-00000008KBa-2RSl; Sat, 17 Feb 2024 19:32:06 +0300
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
Subject: [PATCH 1/3] dt-bindings: regulator: qcom,usb-vbus-regulator: Add PM6150 compatible
Date: Sat, 17 Feb 2024 19:31:59 +0300
Message-ID: <20240217163201.32989-2-danila@jiaxyga.com>
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
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9001F8F2F6BAD2021F4B2298ADA324AF845E72D0936C1870D00894C459B0CD1B99498832C46A3B563DCA9057F3E010A39D4F491CE2C246BAD74EE5BCF6350D8DFF8D9167951636918
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE712EB008F780777E9EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637575FD8E213AF258FEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B73AB1701401CD87112BB0459AB265946D8FB8B71F2D854CF976FF846DCE0F064A471835C12D1D9774AD6D5ED66289B5278DA827A17800CE75A31C54DA8CF07A79FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C31E02C13459908652117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CFA5E65DE02FE18DC9BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B610E0EE4CC70ADCD076E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C22494854413538E1713FE827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B69D08779BC02C26AD089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5022C2493086D79C25002B1117B3ED696BD744D3CFCDF283DD57BAD45EC4C5DE1823CB91A9FED034534781492E4B8EEAD21D4E6D365FE45D1C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF66175219C00CC020F649BF59DD420E7E38D2D284EB22FBD4E7148776B77D84C5760962882471415B34E84B500378195F067A5F499AA30BBB0B037B6FA0204BA50E9D16A2321A347A457F7985AD47CF5C02C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojWUnWVIzXWr6jHO7sqTFYew==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498170F032DA97786BD2E693A2F4CD4B100058B063E2F751C6A6BC3FD4D0B4F8691A2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

The VBUS register block on the PM6150 PMIC shares the design with the
PM8150B one. Define corresponding compatible string, having the
qcom,pm8150b-vbus-reg as a fallback.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 .../bindings/regulator/qcom,usb-vbus-regulator.yaml      | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
index 534f87e98716..bf6336850be6 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
@@ -19,8 +19,13 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - qcom,pm8150b-vbus-reg
+    oneOf:
+      - enum:
+          - qcom,pm8150b-vbus-reg
+      - items:
+          - enum:
+              - qcom,pm6150-vbus-reg
+          - const: qcom,pm8150b-vbus-reg
 
   reg:
     maxItems: 1
-- 
2.43.2


