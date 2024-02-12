Return-Path: <linux-kernel+bounces-62255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9933851D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DAC11F2163B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB42A4642A;
	Mon, 12 Feb 2024 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="QViBSjcW"
Received: from smtp47.i.mail.ru (smtp47.i.mail.ru [95.163.41.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B4241233;
	Mon, 12 Feb 2024 19:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707765062; cv=none; b=e49bAdpzH5Gm6tyTK3N7ScCmMEeEqeJBvET8X/XdWa3MYsk6sfZU1ots3fB++Z2/GTif5xVtLwRR8AMrUcWamM2xqw9agBU1zxxQ5642WLRyGG3ZMUUpg+eBOKr+JkWurS2bkgZE+7ejmC6RtDJGaSEjrzt8iVIwGbfKYvGwSsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707765062; c=relaxed/simple;
	bh=0yhCG8dhpATOF1IMFYS9jk9hzjLZB4lf+Rg7yCc8bQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6saDW19x6ZMnZrBMt4RjFiy1xsoj7tEFHKYgOW1AjtkDM6Xa11r6BQ68p57NZ2w0vIV4qlhDXWLWD1/eIe4aQQXla2Z2RQkFChwvI9pvbSqpwcEqoWCKNZWfF21bsNvqHNuBXC5ofxb256aJlG/w1FlTV2OmG4dio8sVYfp+zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=QViBSjcW; arc=none smtp.client-ip=95.163.41.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=be2FZjSBLdE52ZDvzuE6Y7LdDV7OjNfUF3Iag3/gLsY=; t=1707765059; x=1707855059; 
	b=QViBSjcWw8k+y4JrwzjHFBezj6d1GfrOlBojBWQ+lG3g6ow5l3AJEJ2QU1SmM8KMyFDNTaU0K+9
	uT4K58mAKBQL2PhZUVTllMzKDCFQ7Wajo5Kll0zb9HHf+wm1UTXSpGhLnXOFg7kWRgyUPTmd0K1rh
	V9F+XP9xH2ZVfXnScsQ=;
Received: by smtp47.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rZbha-00000006gZh-2rRl; Mon, 12 Feb 2024 22:10:51 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	linus.walleij@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	vkoul@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 1/2] dt-bindings: pinctrl: qcom,sm8450-tlmm: Add compatible for SM8475
Date: Mon, 12 Feb 2024 22:10:45 +0300
Message-ID: <20240212191046.77013-2-danila@jiaxyga.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212191046.77013-1-danila@jiaxyga.com>
References: <20240212191046.77013-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp47.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD96201AD55A1C8F7DBBE4586EF28675698F5F01DAAADAF1068182A05F5380850409D2489145FEC18542EB5D77EF37489D14A1AA2E7FAC71D20E51B3825F593DFF2C855A04F18BB56E3
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7CA8E915ACC910FBDEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006374DF0C582D42FCA168638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8F8ADA90683CD2DB66F91843850D5FF6A322F45CD8408C157CC7F00164DA146DAFE8445B8C89999728AA50765F790063798EAA0EED4DE4A60389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8D2A98E5A6551E3E5117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CF776FEBA3834A766EBA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B622310ACB61D7A70376E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249D082881546D93491E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6694CCBE1C0966AF9089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-87b9d050: 1
X-C1DE0DAB: 0D63561A33F958A559EFF6B5FCD277EE5002B1117B3ED696847FE81983125413D57BAD45EC4C5DE1823CB91A9FED034534781492E4B8EEADB71243024C627CEAC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF7FF25121C2BD51D8AC780F63A8418607627C1A678612397DBA10C0E146FC4F3A9EC5AF04A575AA6C233AFEF422F2DFF9CFDB2A09F3D044135D44EE695255846BDB20B368FAAAD0D042BF32D1DA1046D202C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj1UUEhvrYbM0rusnGgA4tgg==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981983862166B64222887A35C9C7BBE74BE6DD7FE894E1CCFBF34B96B647EEE94572C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

Add a dt-bindings compatible string for the SM8475 SoC that uses SM8450
tlmm.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 .../devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml      | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml
index 16fd2c5e2339..590de2d8a1c6 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml
@@ -17,7 +17,12 @@ allOf:
 
 properties:
   compatible:
-    const: qcom,sm8450-tlmm
+    oneOf:
+      - items:
+          - enum:
+              - qcom,sm8475-tlmm
+          - const: qcom,sm8450-tlmm
+      - const: qcom,sm8450-tlmm
 
   reg:
     maxItems: 1
-- 
2.43.0


