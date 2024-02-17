Return-Path: <linux-kernel+bounces-69971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7D38590FA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9828328235E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482D47D40C;
	Sat, 17 Feb 2024 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="rAP3YkAu"
Received: from smtp53.i.mail.ru (smtp53.i.mail.ru [95.163.41.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED47E1D53D;
	Sat, 17 Feb 2024 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708187538; cv=none; b=Bfa+vbiIGQMQpQ8kM5tVx65stosw3WUpzU7I5RrV4EVRNySW57nJgRKhT2lpEZzUws9LiCXCGRmFrh+a/gkKF+J0KESRMfyeAEJMh2TunMC2pL2u0iaG6MMqcqJJ+IrpCmqj50bcMKNEdfoWeCFgThhSIaIsWoUPOx4abPDhbWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708187538; c=relaxed/simple;
	bh=vEBxIcf7xUwXXur5mggF4gqFkRiDDu06JT4CcJXClYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tz4nhjEQxMqlLmK0RP+Tmsnubv5astTvi5fi64laVKenmSwxU3w+P5r0uk0JeTbfGEHppOdDUT+dQ1WVAQj1Xl/CjZSLm2ypWBiHOy7twNuB0Fg2UY+tkEnu7KYn/IDTiG4WyHGc0j2l4FqEhRsTd6CgVxNvpYqm5g7WEkCZxVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=rAP3YkAu; arc=none smtp.client-ip=95.163.41.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=nDx3SpJfsiIguCKSxxz3mWmr9r9GCUhVTfKVzZ9Dwrk=; t=1708187536; x=1708277536; 
	b=rAP3YkAutYGeRBK0+P/53uB5hTjsmp9xDLBiOZCXo2QNpsHgYcJAZNCTXeO0uvWqCJcZ5sIa7mh
	g0rErFefm8acPUF/mc4zuAf3bQ6cC/rNchZrpLB7il+f31HFL0p7nGWPKUaHLQWOUrzWHUFdcoHwg
	AeQdkxR7Zho7Zsls/bE=;
Received: by smtp53.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rbNbj-00000008KBa-0l4f; Sat, 17 Feb 2024 19:32:07 +0300
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
Subject: [PATCH 2/3] dt-bindings: usb: qcom,pmic-typec: Add support for the PM6150 PMIC
Date: Sat, 17 Feb 2024 19:32:00 +0300
Message-ID: <20240217163201.32989-3-danila@jiaxyga.com>
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
X-77F55803: 4F1203BC0FB41BD9001F8F2F6BAD20218FDFC93A65F85DDC59E3B8317EBE436000894C459B0CD1B973BF2300A0D812EDDCA9057F3E010A39B313FB2AF2AB8E6F74EE5BCF6350D8DFDAEE934B56E2D9F8
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE782A779A89F7D69B2C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE7AD2F2D6F6013FF7F8F08D7030A58E5AD1A62830130A00468AEEEE3FBA3A834EE7353EFBB553375664F31EC67F06AD94B668D35D0C74DD1C61174BF4B95B34F5CD7368C965F98AF0A389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C05A64D9A1E9CA65708941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B6F459A8243F1D1D44CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C2249848167DB830E844E76E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8B4832C55778F5295E3AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC2EE5AD8F952D28FBE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8BECD345639C7F4A9E75ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A53EFB8B489AC9A3835002B1117B3ED696DB8DB3085ADC9B003D2BBC1EF78EDEBE823CB91A9FED034534781492E4B8EEAD6A17C1D737525568C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFE10E35683C5C6DB78364DF7450C330C72D6CF0C89678C7910D6BECCD048F55BEA7825560E8A5912C34E84B500378195F4C4044144AF9B7D80B037B6FA0204BA582A6895AEA8E85A8457F7985AD47CF5C02C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojWUnWVIzXWr6HuxolXXPrHg==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498170F032DA97786BD20841F56765D88C40798D5EDBF53A187DDD698D295942BEFF2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

The PM6150 PMIC has the same Type-C register block as the PM8150B.
Define corresponding compatible string, having the qcom,pm8150b-vbus-reg
as a fallback.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 .../devicetree/bindings/usb/qcom,pmic-typec.yaml         | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml b/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
index 55df3129a0bc..9637d62719e7 100644
--- a/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
@@ -14,8 +14,13 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,pm8150b-typec
+    oneOf:
+      - enum:
+          - qcom,pm8150b-typec
+      - items:
+          - enum:
+              - qcom,pm6150-typec
+          - const: qcom,pm8150b-typec
 
   connector:
     type: object
-- 
2.43.2


