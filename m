Return-Path: <linux-kernel+bounces-62345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BAC851EC2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247241C211E7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A641B43AA8;
	Mon, 12 Feb 2024 20:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="Ig689vtC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="z344P3b/"
Received: from fallback24.i.mail.ru (fallback24.i.mail.ru [79.137.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC5D4A9BF;
	Mon, 12 Feb 2024 20:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707770295; cv=none; b=CdpIYJgL9kHaA7k8TSxUNedpMOVeBzhhB55bHZK+wGhMwE69M3p/a2xBtcKoq6M3qsgzaveYYMcxHNDdHR7J7VbAz7V1qzli/bnJy75jiqJehSZm6PBzipdP1LPCNaiA0KLvrNYhAbXFKjEog3rwMnUF2Fi7+ar0NxS48Ebx5Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707770295; c=relaxed/simple;
	bh=BcDZSruJAfvwBG0bL69/Fuyhummh07u9jA4LTd6hM4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OE8b8LMoxC6GRZH163OY/QVxaXtWPMmaMMVkDWMOHWrsSDWbLzQOQk1wToWvhiHk1/N6m/M9Efyv9GlQae8zWhxZwZfh5nj9nwgfirgMN/wLfeAt7ugzmh1bPWdLdvaIr6daRe1489V4jvcLewqn/s8t715LA6tkpn2A+04H97c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=Ig689vtC; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=z344P3b/; arc=none smtp.client-ip=79.137.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=mc2B3OPfoDtIlWNmX2dSyb7NvFt/ohE9sa7XZ0oTJ5s=;
	t=1707770291;x=1707860291; 
	b=Ig689vtCaPVyTlzDFyyBVnYfuG4pKIPHutd7c/jrDnfoorUQARl4H2G0XvJxKi2zbHFsrPDCl9on85kWAEFAUAybFXfHOxaW1lOzeTJ2UE3tjJnySpwXVuR79PlVW9mYyRihBMWOv48p2/UTWIi+i/O+oCIDDQNjOE2wJZInt80=;
Received: from [10.12.4.23] (port=51240 helo=smtp49.i.mail.ru)
	by fallback24.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rZchR-0049eU-UM; Mon, 12 Feb 2024 23:14:46 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=mc2B3OPfoDtIlWNmX2dSyb7NvFt/ohE9sa7XZ0oTJ5s=; t=1707768885; x=1707858885; 
	b=z344P3b/BdqMDCLCDdT2/JMeUsmGd0eLgNdCrtfQMd/NkmNlXSFe95ZadqQs8IvAMKfWsivQPl/
	mLo3zLO/zsJp+xjwPSe+lS6uEPX73A4nXJeEQkjpaFELys5FQMQEht4tc2R+/6+CPdIJPt8a48dEh
	gYSvsm0z05ZW+tmdpQc=;
Received: by smtp49.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rZchD-00000009OKr-2R5J; Mon, 12 Feb 2024 23:14:32 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add IDs for SM8475 family
Date: Mon, 12 Feb 2024 23:14:27 +0300
Message-ID: <20240212201428.87151-2-danila@jiaxyga.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212201428.87151-1-danila@jiaxyga.com>
References: <20240212201428.87151-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD96201AD55A1C8F7DB57C85709A7F63CC6644329F858F008FD182A05F5380850400290EFDE7EEC88005D1BE6A8D71B10A518011BD1FADE9F96B994F2484CBC5EEE3EC79052E9E97693
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7353CFE866E745C13EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006377E3992E1815AFF058638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8914564BB2EB419C7EF2F179BCC4484015F7E41C323B3FD73CC7F00164DA146DAFE8445B8C89999728AA50765F790063773DCDF0198120BE8389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8ED96AA85C75E140D117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CFA811A62667D8EAE2BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B697A9A044E4F9EDBD76E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249D082881546D93491E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6BE256E393A9B2437089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A57FD4DECFD55C1F865002B1117B3ED69648C8527CCDD1D24772305013E4AE841E823CB91A9FED034534781492E4B8EEAD37F46C620FF2CAEEC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF035B55F25408A8A957A8BA2A84558567936FD0983431099F463394ECCC7CB81BAE7801A017AB3E4A233AFEF422F2DFF9C5B20E204C88FE0031CB3C20478AD93CB884D2B9398EBBB8034D55ECCE8C67C6913E6812662D5F2A78A556DA1408BD603BAB4BE5B351B77B77D7EADF59166DF0
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj1UUEhvrYbM0kDhYg65casQ==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949814C6C55408358ED2AF33F69C7E48EA1FBACB1721832C672ABBAEDF1B2B720B08E2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4A77971E4CF73965D9E271BDE2CCB4C0C74D4D0F5526761AD049FFFDB7839CE9E21836B46C57BA719E9FA2CC44333CFF99E8FE43EDEAD58B241B08CCE821396D7
X-7FA49CB5: 0D63561A33F958A5FC0A2D135DBE8A39E693A483B2C8940B537194F0ECACEBCC8941B15DA834481FA18204E546F3947CBA7556051D6825FBF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637889750A55773577B389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C38ECB62DBB60BCAAD35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj1UUEhvrYbM0tuos+OshPYQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Add Qualcomm SM8475/SM8475P/SM8475_2 (cape) SoC IDs.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 include/dt-bindings/arm/qcom,ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index dc7ba87b50d7..19ac7b36f608 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -252,8 +252,11 @@
 #define QCOM_ID_IPQ9510			521
 #define QCOM_ID_QRB4210			523
 #define QCOM_ID_QRB2210			524
+#define QCOM_ID_SM8475			530
+#define QCOM_ID_SM8475P			531
 #define QCOM_ID_SA8775P			534
 #define QCOM_ID_QRU1000			539
+#define QCOM_ID_SM8475_2		540
 #define QCOM_ID_QDU1000			545
 #define QCOM_ID_SM8650			557
 #define QCOM_ID_SM4450			568
-- 
2.43.0


