Return-Path: <linux-kernel+bounces-94375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 757E1873E14
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9D21F25AD7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0802E1448F3;
	Wed,  6 Mar 2024 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="lP3ymVse";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="lTobC2Kt"
Received: from fallback17.i.mail.ru (fallback17.i.mail.ru [79.137.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EFD1448E1;
	Wed,  6 Mar 2024 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709748383; cv=none; b=amplHkapjGRx4LqeRTtljHDxyaW1hwL5lwg+xcjyEKcjk+QoSlPqAK5qlXSOqzQrLG1OMAIfWTTCNdWbhKn67pbQ4xszsAJrFKMzgdf/K9NHZmGfL3BshD8/x5SDtruxRQI9cyXlKtmjbImS1ncyhayuzJsmAgqZyPRi7RmWPuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709748383; c=relaxed/simple;
	bh=+4nWjfCspJdinJgj70jJ8HI7zjPNCGO/S9eBz33EUB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcZ/yvTntfPrMmBUTiWm0w+S5iuM2paXV7sD99VDx1sHWx93fJexmsRJB1BiO6R6sF+3gHWkePunGILDQaE5jV+ufXNzpQk8S9QpImnKLvc5Kr6nwZ6cLijlZp0wDxC2mEC+b/YzHlBsNS3yrGcmMILVihCB4jD9FJsiV1JRkjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=lP3ymVse; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=lTobC2Kt; arc=none smtp.client-ip=79.137.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=0+NLwRTMKhcrafU+QpXr/st81vi0wdXyFWrxFLW/RQM=;
	t=1709748380;x=1709838380; 
	b=lP3ymVseq2sky4sC2oomuOEcGjxQZezqxeE9kbCreWdDn0N7VogleaxouzSn1hIpwARE2gRhNh6ZqUJbmPUgOye2aFoY52+QrcMpKt+CGNh32an9+wVWAUMFyGf3sv4YlD/SmdLXowstrSFBesUtMredDuNJ9jwbQgh919nDgzY=;
Received: from [10.12.4.36] (port=60626 helo=smtp59.i.mail.ru)
	by fallback17.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rhv3D-00EVIt-8p; Wed, 06 Mar 2024 20:27:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=0+NLwRTMKhcrafU+QpXr/st81vi0wdXyFWrxFLW/RQM=; t=1709746051; x=1709836051; 
	b=lTobC2Kt4IF0n1l/eOKPyloTscCWTq3BLZkTXvIPQuaKiZLS1mvc9c/0Rz2aCJDLGY/nKFRWrFr
	rhz9ChIzxy3kjAnINKe19NQvnauReUzC0lZHo7+4KdoNQA8JnbmIGCrIM6Rv5ragJTDWIGA6sfKZu
	85Grp/PaehsP164lEvg=;
Received: by smtp59.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rhv2x-0000000F1Va-3Pi5; Wed, 06 Mar 2024 20:27:16 +0300
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
Subject: [PATCH 1/2] dt-bindings: leds: qcom-lpg: Document PM6150L compatible
Date: Wed,  6 Mar 2024 20:27:09 +0300
Message-ID: <20240306172710.59780-2-danila@jiaxyga.com>
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
X-77F55803: 4F1203BC0FB41BD987C0EE6E7F0A597D173D0CE202DA28435F3B31DD656B8ACF182A05F5380850405D78088DE6C213CB411046492FDDF806CA58FC3FCD0956798FCBEF1FD3BB67B11310F8E5CB569241
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE716FAD50E497B9C14EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006370EBB47D88F71BB738638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8226FFF6E9758072FF5F3F533CCBC407A59742E5BDE38CBACCC7F00164DA146DAFE8445B8C89999728AA50765F790063735D2385A5E2B3AC3389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC85FF72824B19451C6F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CB2DECCBDF547A30576E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8B120C23C05AEC2B18EC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5278DA827A17800CE76631511D42670FFE2EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7AEA1580DED4E70E3731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A540B8A7E7BED5AA655002B1117B3ED6961D31791229A5A08FFB820E9FE7BD014C823CB91A9FED034534781492E4B8EEAD5B606B10FC07407CC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFFC102450E495308653253A64D9D077F4D81B3C12B5DCB65F393F4D47D2D0A30EF509D27A9878C191A2A143A52978B9DD4ECA63C7D1CB82E7C777010AFA8312B6BA7C55DE93E062EA42BF32D1DA1046D202C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXhgskDnfdo7g1HcIkyXn9qp
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949814E2244C9C55FE217BC5A20191D90C84FEA49953AA39D7944651BA650CCE5DC6B2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B485448333635D8AFAF2FD4A3C9FF394F5F15B183966BAD3FC049FFFDB7839CE9ED2C2511FF248D2A2E3882A0B98C05C02B3C18B99DD6EEFD57E4973E196C0C17E
X-7FA49CB5: 0D63561A33F958A582EFFAF7FDF7EC231781C1B5AFD2E6973D0C7675EF4652658941B15DA834481FA18204E546F3947CFBBF6D3A4198F0AFF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063748BA6E06FEBFA861389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3975373433331DEB835872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj9auBsoWJeY+WgIjHBVCeZg==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

The PM6150L LPG modules are compatible with the PM8150L LPG modules,
document the PM6150L LPG compatible as fallback for the PM8150L LPG.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
index 54a428d3d46f..7b9e0ad1ecaa 100644
--- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -30,6 +30,10 @@ properties:
           - qcom,pmi8994-lpg
           - qcom,pmi8998-lpg
           - qcom,pmk8550-pwm
+      - items:
+          - enum:
+              - qcom,pm6150l-lpg
+          - const: qcom,pm8150l-lpg
       - items:
           - enum:
               - qcom,pm8550-pwm
-- 
2.44.0


