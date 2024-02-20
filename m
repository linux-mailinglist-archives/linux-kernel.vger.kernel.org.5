Return-Path: <linux-kernel+bounces-73710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D225885C6B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881A628353C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F0C1534E8;
	Tue, 20 Feb 2024 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="UYrXmb2B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="D0VwGego"
Received: from fallback21.i.mail.ru (fallback21.i.mail.ru [79.137.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EAC152E07;
	Tue, 20 Feb 2024 21:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463037; cv=none; b=jrXbQcRW9xnaCtioaUlQFkzH9snUoTy8kkdPb+wHfUd4vBpFG0Z0ar7DzU89mDc3bQ7lUVSKQmG5NnrZeXJAgbCXnYcySqH3x3vEMqKbQXYD3SXIM2YMPAy+dcUfY8+h1gtRBMXJCPuLOkWu8LUb3XI4xmw1QPQygADuKuvfcEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463037; c=relaxed/simple;
	bh=0QRzh9AnEzF70xY1EmczCNxrxcbt5RdnxfuuERRRJNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekYXp4+N5QvYH8hX7AU9uPvj9IyYQboANisQAc1DSWknuGwJtSuQsXW2iRSbmjKY1TEoRvMRfXy5gzfr8YaaFQcBkVWd49dfhBmvN51zJ4C6boCXvurt8jYecEGe8U1MLBRT0PK8x3ZOCMsoOYC0ylSywIb2RAgT1RrB5KVrIng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=UYrXmb2B; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=D0VwGego; arc=none smtp.client-ip=79.137.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=9aGBD/l1cMyZUwEApiqhDY622Eb0NpB07i+KpmbzWxk=;
	t=1708463034;x=1708553034; 
	b=UYrXmb2B9/5mo5NjX3G+cpheHTOxCHXlyjv5HKQYuoK42eBJbovQDHOTJAjcWh25dh0ydr0e00Fa5uGWvCLOAiT7u4Y2A7tRGkvoZ70JJQMo5AAyFWgzJfbf3z2oD3wYBT3oUSKTKhoGd25I8QGFOVN1SmuILYaIMBXi+o+waYM=;
Received: from [10.12.4.26] (port=54464 helo=smtp50.i.mail.ru)
	by fallback21.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rcWcy-00GwTO-VR; Tue, 20 Feb 2024 23:22:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=9aGBD/l1cMyZUwEApiqhDY622Eb0NpB07i+KpmbzWxk=; t=1708460528; x=1708550528; 
	b=D0VwGegom1wH4/oWQu5c+pR8VW9g6FafeKdInaJPg3NWSqXX2+WKUOzR57QorN4rQQ4ewbuY/Wh
	w++x8PnFM9cRh1RIYHq28qFI6LuuSxHBgc8kVvn4qu/exe350Cgq7O9zAtceNzWH3n2BAO99fghYI
	2rEITB7n6z+ofneDa88=;
Received: by smtp50.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rcWck-0000000BzSN-015r; Tue, 20 Feb 2024 23:21:54 +0300
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
	Danila Tikhonov <danila@jiaxyga.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: usb: qcom,pmic-typec: Add support for the PM6150 PMIC
Date: Tue, 20 Feb 2024 23:21:46 +0300
Message-ID: <20240220202147.228911-2-danila@jiaxyga.com>
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
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9001F8F2F6BAD20211AF9977AC3F5306D85631166D2AADE8700894C459B0CD1B9ADB5984B2849E807FFB2F1BA4D151868F659700B1EC13CE96DC888E7B15EF0D496BFE15B8ADB4371
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7956F10FFCC7409BAEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063786F1F539FBE87B778638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D833A336716251539F69776ED762CC1B435DF33BC33DA2B81ECC7F00164DA146DAFE8445B8C89999728AA50765F790063793270F7220657A0A389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8A9FF340AA05FB58CF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CDA7BFA4571439BB29735652A29929C6C4AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C33BAFBCDF8379C95DBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFED8438A78DFE0A9E1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3A27B50A64E76B53235872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A538E90E89E935DBDC5002B1117B3ED6965CB42CDAF955AF9C6E5F408120975D33823CB91A9FED034534781492E4B8EEAD09F854029C6BD0DAC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF4AABCC7749A9F8FD1F2E4515DAF64F80BE98E7E5766312CB11CCE37119FF9AA4F2F1C324C53BDAF2F1AD97FD9824DBCD0AF7481B070A9AC0C74530A4B3B7F0BE9E638C6805F66579146D90F64BF3396102C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojiWfz0I2sVCmkbZGcwJ1Nrw==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981CD4E5312E4C90D18CC811723C208B4176F3C1432C0438891CDFC3B31870FC4A72C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4A77971E4CF73965D9E271BDE2CCB4C0C279666E6C2610F6A049FFFDB7839CE9E76E35804B2850F20AC8EDC598495F5BE5EEBC54611B9DCA03078BEBF709836AA
X-7FA49CB5: 0D63561A33F958A53B0807CA475A6BFBF9C5A895355FC37F551E0C1F6EA0E1338941B15DA834481FA18204E546F3947C36C7B98ACBF5D372F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063758A860CC8F9F2A6C389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C35CB5556AFF48B99435872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojiWfz0I2sVClUQm1wEyldCA==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

The PM6150 PMIC has the same Type-C register block as the PM8150B.
Define corresponding compatible string, having the qcom,pm8150b-vbus-reg
as a fallback.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/usb/qcom,pmic-typec.yaml      | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml b/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
index 6c0c6b337693..976d1732137b 100644
--- a/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
@@ -14,9 +14,14 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,pmi632-typec
-      - qcom,pm8150b-typec
+    oneOf:
+      - enum:
+          - qcom,pmi632-typec
+          - qcom,pm8150b-typec
+      - items:
+          - enum:
+              - qcom,pm6150-typec
+          - const: qcom,pm8150b-typec
 
   connector:
     type: object
-- 
2.43.2


