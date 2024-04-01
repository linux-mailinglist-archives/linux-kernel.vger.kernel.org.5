Return-Path: <linux-kernel+bounces-126943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD2F8944BC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00C01C21548
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F9551021;
	Mon,  1 Apr 2024 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="IqKeWSgv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="qkOvFeZg"
Received: from fallback21.i.mail.ru (fallback21.i.mail.ru [79.137.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6944EB24;
	Mon,  1 Apr 2024 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711995791; cv=none; b=hvv0V+rYJnq/hvCCiZMg2HEGs/MQrqaFa6rYhiNt+PwcMwwp2EUbtM6NwpX2dv1pE/n7fM+jU23qI0Ncqgw/JJ/0q3hpbSwtDXlinh8OEOQHlTuRiD0oAkan9Bh5GB17qLR9z29aqEF2IR33ld16aszF4zctDoVxChEHKuF/z/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711995791; c=relaxed/simple;
	bh=lGQOcKlaKYR2HYLSfRyA7NBUV+cD9TYc1z17jPP3r9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwMo7hPP60S8PZAGImb7jpnjm04I5hQsEHbyxlnvsz5P33B36jMjLC0rVOwF3JeeyWD16Gx+6zxOEvXYMqCqeUXUVawJ+sfjUyFbTW04ZqUd3ZuhcXnD8Vofl8DyxKHznxyygJK0L0mM700jT8JzqauVa5r+QriZDMqGSAli5U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=IqKeWSgv; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=qkOvFeZg; arc=none smtp.client-ip=79.137.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=DpY9JXPC44/eMZj2gSpT6otT+n2T9KhHqd19vlxiZfY=;
	t=1711995789;x=1712085789; 
	b=IqKeWSgv6PGXxysuxKnrJq8iOZSdPdrtETmBt0zBseqSzq1/kRNIq9SUGUUQmZ3NR4nyfDzHWDdMZyyH9Fx2IEvM8F11nxPEIrcfe18c0bLBTb7y9okGI2Uhe2KB8weEq0w3KGZw/GeT7jDTaPRdFnRCEQmUV7Vx+uHgUsixA0k=;
Received: from [10.12.4.7] (port=38382 helo=smtp33.i.mail.ru)
	by fallback21.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rrMJA-00Duyw-Kg; Mon, 01 Apr 2024 21:23:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=DpY9JXPC44/eMZj2gSpT6otT+n2T9KhHqd19vlxiZfY=; t=1711995780; x=1712085780; 
	b=qkOvFeZgdG4rN0gU/N/ltAyyI/gp4GLleP4LcXfvwxkzVxLSqcb2PkM85l/PTacUPe7r37cSxAe
	FJ1xWZnbyejEEBbNZ+GTDuTAv6+KkMKgorKkOiNKU+I1UAQXl/dAK3DlllyAVXjhbwAsr2akz3lB7
	qJloLKO5Ym0FR2j97C0=;
Received: by smtp33.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rrMIx-00000002IQ2-1hjU; Mon, 01 Apr 2024 21:22:47 +0300
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
Subject: [PATCH 2/2] arm64: dts: qcom: sc7180: Fix UFS PHY clocks
Date: Mon,  1 Apr 2024 21:22:40 +0300
Message-ID: <20240401182240.55282-3-danila@jiaxyga.com>
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
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9D135BF24EC7C3B84F4481F7E27D197A12AFDB31AE04A9497182A05F538085040425E929FF18E1F0EF378A8CA21F699D6ECF7839DC21535F8754E9BE2FEC5E1B8141B3585208100AE
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE75EB26DC3398F980CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006372D22CC9620B7D5068638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D83807F9C9B80303AF33E3BBA4BC0C4FFBCD457F6DC05D41FFCC7F00164DA146DAFE8445B8C89999728AA50765F79006370277CA7F994D7EF5389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC878444BBB7636F62AF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C89DDFE3E282F3DD1302FCEF25BFAB3454AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3B15E146EA45457A9BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF27ED053E960B195E1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C30A3B31C63366F72535872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A523916B9BD823608A5002B1117B3ED6969E4C888B65BB5CE092212597CCBD6D77823CB91A9FED034534781492E4B8EEAD09F854029C6BD0DAC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF5D3E05D67DC882B47ACA4BE2584ABFD6EC07BC5E6CB5CCE69E9010FF0ED266489C8755E3AEA661EF58CF1FE2B37DBE108947428205F5841666FC8896552336569A5213D35D638E29457F7985AD47CF5C02C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojZkLXUwYT7t+hS+PkUqVHSA==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498113902588151D385CBC5A20191D90C84FFF12582E31AF308F694A01E8F937DE022C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B469FED0CC4E03BFC3F7F23553880BB0CD5F1683EE65406E99049FFFDB7839CE9E676DC208F0F4A0572A6A4F42B62CFAB10A1C130516C316F998D74572C4192BCF
X-7FA49CB5: 0D63561A33F958A555E61FC64307F3699095D31F446F75AF60A3BB07E0CC0CB88941B15DA834481FA18204E546F3947C9EB6D914E8CED3EDCC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C9223F8577A6DFFEA7CF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE7668E9DCFC093FD7B731C566533BA786AA5CC5B56E945C8DA
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojZkLXUwYT7t9Emt9PUiT5Kg==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

QMP PHY used in SC7180 requires 3 clocks:

* ref - 19.2MHz reference clock from RPMh
* ref_aux - Auxiliary reference clock from GCC
* qref - QREF clock from GCC

While at it, let's move 'clocks' property before 'clock-names' to match
the style used commonly.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 2b481e20ae38..5c9ec8047f00 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1585,9 +1585,12 @@ ufs_mem_phy: phy@1d87000 {
 			compatible = "qcom,sc7180-qmp-ufs-phy",
 				     "qcom,sm7150-qmp-ufs-phy";
 			reg = <0 0x01d87000 0 0x1000>;
-			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
-				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
-			clock-names = "ref", "ref_aux";
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&gcc GCC_UFS_MEM_CLKREF_CLK>;
+			clock-names = "ref",
+				      "ref_aux",
+				      "qref";
 			power-domains = <&gcc UFS_PHY_GDSC>;
 			resets = <&ufs_mem_hc 0>;
 			reset-names = "ufsphy";
-- 
2.44.0


