Return-Path: <linux-kernel+bounces-121783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1F888EDA4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A104B1C326FF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5DF14EC70;
	Wed, 27 Mar 2024 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="Qw36u6Xn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="Q3SYWl7D"
Received: from fallback25.i.mail.ru (fallback25.i.mail.ru [79.137.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BDBF4E2;
	Wed, 27 Mar 2024 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562833; cv=none; b=XIuymXoAFCCWPm5NZg4GPHTxpClqf61rQiBwipl0cYOFcGZqBMrvj1dgpef2PKoTXXw5JeEgZcBsx0IUEHukkyi1nJalbRNKvlKIgv5Nhy0nFmmBcsGi8SxtbA0CdtCdMI3ZsjGZf8hD3QYyBZj465VGLLrDbAA14K9xBshQaDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562833; c=relaxed/simple;
	bh=+GrBOZQJoNVnHAdgR+DSnl+GSr3Vo+ucmLN4q6AmTlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pu7cf6jV1iYnTs+O/uq6Kid3NZyANGKalruSbJErQm459wBMvSYGUPxmfFKksgwSfhYHSpiSh7Sr48XItnIGbwpvpNz6bUssvCcTavEWJE6wJhRkzpfp7x4WJvRvaTMhXY07Lu/rPZN5oY2CX8Vdu938VJhZ/moogBT82e9TQBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=Qw36u6Xn; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=Q3SYWl7D; arc=none smtp.client-ip=79.137.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Ozbvpd50mMOhmROETRACJY+X584otF1sahtKcR6rIOE=;
	t=1711562830;x=1711652830; 
	b=Qw36u6XnbcQ3CWbkf0VcfHrxXgUCfGzWTiiBOCFqWlDeM+JwLdW/IN4RMdfNxJe7x1u0g0e1GY9jJxAnrRIXrQ1NOBZ/EP/QU6HI+iLSvDPcZeXIZgy9V+JLjMGaC8y07GfAllAurIqetNbug7h1wAfWougzQzQCt4CAAcNml5Q=;
Received: from [10.12.4.29] (port=36326 helo=smtp51.i.mail.ru)
	by fallback25.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rpXfx-000NGh-Cz; Wed, 27 Mar 2024 21:07:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=Ozbvpd50mMOhmROETRACJY+X584otF1sahtKcR6rIOE=; t=1711562821; x=1711652821; 
	b=Q3SYWl7DwjiDaGeo65xhfPya48VR7FBN8tBuw2oaeJEgdK91QvXk0V8H1fJN05O6mevRYswKHEx
	aZBJA1NahtxHIGnBKZ3WOIfbfatEHkgx3i73xsZc7p0cRdLtVnHtleirUsRKwt3v/u8ods/ZsGagN
	5/h4gjYnFpVjbrC08Us=;
Received: by smtp51.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rpXfj-0000000E2q5-0ADH; Wed, 27 Mar 2024 21:06:47 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 1/2] dt-bindings: phy: Add QMP UFS PHY comptible for SM8475
Date: Wed, 27 Mar 2024 21:06:41 +0300
Message-ID: <20240327180642.20146-2-danila@jiaxyga.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327180642.20146-1-danila@jiaxyga.com>
References: <20240327180642.20146-1-danila@jiaxyga.com>
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
X-77F55803: 4F1203BC0FB41BD9D135BF24EC7C3B84ED50F4FA0F0B672491A1E78CF0A7D1F0182A05F538085040EC60E88F3D52D51A03ED270C30F246C5B183B29E756A1548FEB17DC202E68E3028006A18B89A7667
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7548C33FFD72831AFEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006374D30FA0D294D462C8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8AB845910D741013387CFF83901193707A1D2B17E004D5259CC7F00164DA146DAFE8445B8C89999728AA50765F79006377C70927E34808485389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC80CABCCA60F52D7EBF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CCEBC872EF0A1BB65BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B603D88DA7F5FEDC253AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC2EE5AD8F952D28FBE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B5D9D64F11F3A190A75ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A5560F7045A31B99455002B1117B3ED696580D1C975CBBE2BCC638DF663A625AFA823CB91A9FED034534781492E4B8EEAD6A17C1D737525568C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF8CECF1AE73E676C4D314B93E46C301BF4BCFA6A81ACE138C13EB575B325410748FF2D56E53A08728F212F37558E724669036F1ADCD25B506E5E1C781D7312E8B39F18895F3C73CAA42BF32D1DA1046D202C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojRawEQSF5UttxZI0ZYcZ79A==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981DE6AB1E6944A41F40841F56765D88C402307561DCE953FAD86697F630E165A9D2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B469FED0CC4E03BFC3F7F23553880BB0CD3D6EB06D23122212049FFFDB7839CE9E088A9832E85284853E004031E9FF3912ADD27ADBD857039B0162CE7EF3E6A363
X-7FA49CB5: 0D63561A33F958A57EDBABF2EAF213580364B08098D4158BB5C525D3CB588EB88941B15DA834481FA18204E546F3947CA8E05A713DEDC342F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637B9C56DF03277676C389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3F65C0D82C631A427089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojRawEQSF5UtujJgOAMFub9A==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Document the QMP UFS PHY compatible for SM8475.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index 91a6cc38ff7f..1e8c3abb09a4 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -32,6 +32,7 @@ properties:
       - qcom,sm8250-qmp-ufs-phy
       - qcom,sm8350-qmp-ufs-phy
       - qcom,sm8450-qmp-ufs-phy
+      - qcom,sm8475-qmp-ufs-phy
       - qcom,sm8550-qmp-ufs-phy
       - qcom,sm8650-qmp-ufs-phy
 
@@ -98,6 +99,7 @@ allOf:
               - qcom,sm8250-qmp-ufs-phy
               - qcom,sm8350-qmp-ufs-phy
               - qcom,sm8450-qmp-ufs-phy
+              - qcom,sm8475-qmp-ufs-phy
               - qcom,sm8550-qmp-ufs-phy
               - qcom,sm8650-qmp-ufs-phy
     then:
-- 
2.44.0


