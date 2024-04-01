Return-Path: <linux-kernel+bounces-126942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FEA8944BB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 603B9B21B72
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94FB50A6C;
	Mon,  1 Apr 2024 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="chjcGrNN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="tWMOS40d"
Received: from fallback1.i.mail.ru (fallback1.i.mail.ru [79.137.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B174E1C4;
	Mon,  1 Apr 2024 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711995790; cv=none; b=nFahNC406Cg8v3NOt+0ZY1pyY6okH0rifLHYnPOV4bZgaOk8Rt3L4FZ4sJOPil4odZqI7bm5RBPRlqiNmYCPVgSq3aeltc807RyLP/Et0zDxLV7mVYP2QBMu/MxwRmxJytUZ/M0vPuFnuWxa1T9NRo3srDV7wU24w4GXMsOtzLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711995790; c=relaxed/simple;
	bh=DnHT0+CfidalQy4t61oWqPIm3p/JAGOy3I+AYeIyLk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Chcx4ayMC3i6NPb5BFo+7Vo8JPkjrxMPAhkbVesa7t333I4vU4T9JuAKd//OnnDrW5P4SwgR/yjGy3tLILK0b9QdCd6DuxBkiyxXeJr+cWpcHkflb1B4tb6jX9/+YaUiekrZUFgZDhQd/Emtr4Fkj2jSXrnkGhV1FHhb8KrxO40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=chjcGrNN; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=tWMOS40d; arc=none smtp.client-ip=79.137.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=rE/6Hns67LwFbftBAGx/n6w1EgL0y4oR42klBNVcfE4=;
	t=1711995789;x=1712085789; 
	b=chjcGrNNhPUV3BjmqfFptXoxmhJeRJ6vPigbC46/AZeM8aCX7n4NyOlO7bSGBoVHwXitxiqy8yQGbORiKizOLPkx70rtllenp/hNmeQPyZVHh8aPn1MlnfybxS/4Ztd9i4CMXE9yg+X6Vq0sIAoxQ7j9BvuXaOMKGmuugojYy4k=;
Received: from [10.12.4.7] (port=46358 helo=smtp33.i.mail.ru)
	by fallback1.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rrMJA-00HUAA-KZ; Mon, 01 Apr 2024 21:23:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=rE/6Hns67LwFbftBAGx/n6w1EgL0y4oR42klBNVcfE4=; t=1711995780; x=1712085780; 
	b=tWMOS40dQaoVuJ5O+NyAcWKVEMdp5Y2ugjA3Sv7RJeg5HC+Ewx/k2swsAt5wRjZXv/5t0715OAS
	DZZxP2/Wef4QKua81PayP0E1+OAks7+bqwvcXLOJ6a3nZ3HH7KxYKK9nIbnNm/lprp49Fz0bXP6v3
	/E64jUuri9hbmlhpQ2E=;
Received: by smtp33.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rrMIv-00000002IQ2-2M9x; Mon, 01 Apr 2024 21:22:46 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	cros-qcom-dts-watchers@chromium.org,
	manivannan.sadhasivam@linaro.org,
	davidwronek@gmail.com
Cc: linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 1/2] dt-bindings: phy: qmp-ufs: Fix PHY clocks for SC7180
Date: Mon,  1 Apr 2024 21:22:39 +0300
Message-ID: <20240401182240.55282-2-danila@jiaxyga.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401182240.55282-1-danila@jiaxyga.com>
References: <20240401182240.55282-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9D135BF24EC7C3B84F734B6BC09D5E079BF5B6D56DAADA3F2182A05F5380850406731DDB76E620E6AF378A8CA21F699D68523B832B01838B1754E9BE2FEC5E1B88D7482F2B228143A
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7A3589DC202DD7369EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006372A285F85D463FE138638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8DC515EE24A67353733E3BBA4BC0C4FFBEB2110AFCC493DBBCC7F00164DA146DAFE8445B8C89999728AA50765F7900637028599BB38096F4F389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC82D01283D1ACF37BAF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CCF7CD7A0D5AA5F252D242C3BD2E3F4C64AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C30FAB88D2ED79F87BBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFE478A468B35FE7671DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3517C622C16A6DF10089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A51B88334D4AE022285002B1117B3ED696ED234DCE671C431B4A0A47EBA01A636A823CB91A9FED034534781492E4B8EEADB0A1B66E9F5C9ED4C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFCD5D558F9C967CC083FBE42CFA4A07C2047F88C0B17DFC0171851BA5130748D98657CCA151A12AF558CF1FE2B37DBE106B7FC1128A10B13666FC889655233656E7A952FDE299D4F4457F7985AD47CF5C02C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojZkLXUwYT7t8Kz0i/FuZbOw==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498113902588151D385C6750B362712FA5BDAFD5AE59D9C1826CA69BB6E52D2D94BF2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B469FED0CC4E03BFC3F7F23553880BB0CDA6200A985C446411049FFFDB7839CE9E676DC208F0F4A057C05F8CAE50BDA64EA609143FAB486D10BB6E6947E5671CE8
X-7FA49CB5: 0D63561A33F958A555E61FC64307F369ABA6C33857A4551457408AA269C6553D8941B15DA834481FA18204E546F3947CA8E05A713DEDC342F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637B9C56DF03277676C389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C34B556A7116F344E835872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojZkLXUwYT7t9WAg5NSQkMoQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

QMP UFS PHY used in SC7180 requires 3 clocks:

* ref - 19.2MHz reference clock from RPMh
* ref_aux - Auxiliary reference clock from GCC
* qref - QREF clock from GCC

This change obviously breaks the ABI, but it is inevitable since the
clock topology needs to be accurately described in the binding.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index 91a6cc38ff7f..a79fde9a8cdf 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -86,6 +86,7 @@ allOf:
             enum:
               - qcom,msm8998-qmp-ufs-phy
               - qcom,sa8775p-qmp-ufs-phy
+              - qcom,sc7180-qmp-ufs-phy
               - qcom,sc7280-qmp-ufs-phy
               - qcom,sc8180x-qmp-ufs-phy
               - qcom,sc8280xp-qmp-ufs-phy
-- 
2.44.0


