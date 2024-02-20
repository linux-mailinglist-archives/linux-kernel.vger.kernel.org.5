Return-Path: <linux-kernel+bounces-73388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8359485C1D2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF15B1F24A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C28276C64;
	Tue, 20 Feb 2024 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="LNdR8F5y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="nPscroxR"
Received: from fallback16.i.mail.ru (fallback16.i.mail.ru [79.137.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9341A76900;
	Tue, 20 Feb 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447996; cv=none; b=cJaKx0LA5VM6S42d4b8U6pQfpFX1hv9XR8CubS487lp/7P2WMzHjH/Hywagma/7uHS4WGHL9poLqJKX7Cf4No02kf+2jn7SMorUz/FAZjdFN5lky1iURClw/DvCZTjFRKsMI7HN8S069LxdXdZCFzt1vP2w5X6d8CeWLBi52PIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447996; c=relaxed/simple;
	bh=plksIEenyWcXA3umoIzqNUwYHFjm4IS0RJHiTwkAXTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICeq7TI0kij+Xn1AdGx59m4D/vxKdLfPWi0a4wZ2+bnavnespUt0yKSDUbKLnNCsmtHJbefsx5s9ZobpeiRgESnQ3NSuES48MOLza8yNLAEtyhMGMCjXLUIK12QkNSTr10d7eWqH8ojaIvYp5P2NqVxxICM8rA5ySBKuRy8wlQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=LNdR8F5y; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=nPscroxR; arc=none smtp.client-ip=79.137.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=raQxCfVcCoumEG1lnkN1lKmjt2KX2LOhtzVUBcibRXg=;
	t=1708447992;x=1708537992; 
	b=LNdR8F5y3vm0Lp1vWcrrO1JjsfOzG/vsGiU4X5KRxdBjIiBmNnqcCM3OTOeD30Q8VS7Ij2gtkbzJy7tBDI9tF4ULC/dAI3SCpobPejXxXnu+KBLgqOcwE1BDgI2NdMa6czoIIao62SybBthLAO7+lhhXrGHMXNaUg2yuAA2LSew=;
Received: from [10.12.4.25] (port=60362 helo=smtp54.i.mail.ru)
	by fallback16.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rcTMe-003Lry-V2; Tue, 20 Feb 2024 19:53:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=raQxCfVcCoumEG1lnkN1lKmjt2KX2LOhtzVUBcibRXg=; t=1708447984; x=1708537984; 
	b=nPscroxRYTenXhaSwDiA37IIWqKAm14DcF6tD2TJkvAYyztJwzR8n2WNeU3U9947jTW749Spyh2
	Regi4y3fZCHU5ec9W2MNjPcYmLcsv25UnwWVnrrf60Db+Zp8xNYe4jQKZOb3aTBzEF2HgKhMZ72+M
	Fyeabi829z9QRWgI+RI=;
Received: by smtp54.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rcTMO-0000000GhgU-2J5t; Tue, 20 Feb 2024 19:52:49 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	david@mainlining.org,
	adrian@travitia.xyz
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 2/8] clk: qcom: gcc-sm7150: Make clk_init_data const and various fixes
Date: Tue, 20 Feb 2024 19:52:34 +0300
Message-ID: <20240220165240.154716-3-danila@jiaxyga.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220165240.154716-1-danila@jiaxyga.com>
References: <20240220165240.154716-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD99B083F863FC6FF42EC5F4F79E60DB7F058691BDE7945F3E11313CFAB8367EF908E2BE116634AD74D14840DF8519B30FA40A02D48E7B53F4A39F824D2792638E2EAC3EACB7F7CF7DDED199C4BD4F2E418
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE78720DE0E0AF9087AEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063781C16D85FDDEABDCEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B73AB1701401CD8712ECA5F73D93C39CDF15A960985AD688DCDEE3FF4EA07E266A471835C12D1D9774AD6D5ED66289B5278DA827A17800CE77E7E81EEA8A9722B8941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B6E232F00D8D26902CA471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FCC86867656F9336EC3AA81AA40904B5D9CF19DD082D7633A0C84D3B47A649675F3AA81AA40904B5D98AA50765F7900637857FCA069B0369ADD81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F7900637F1CEADB5F7626D0D6D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F7900637089291438AC96012731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5395307D4A7626EC05002B1117B3ED69617499264BD0CC2DF19AC5B239BAD4335823CB91A9FED034534781492E4B8EEAD7E5CCE1491825EBCC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF10B165B8060C4CE93F6DDD6F29DB0AA60B617991E167433BD9E467C754209A177E72D8710CBEBF0EF1AD97FD9824DBCDC040D96EA50E15E4C96C2559415958408A25664A6A198D6B146D90F64BF3396102C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojiWfz0I2sVCmb3T6u5D3Yzg==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498132FA18D1217A7BFE95D4C5B18C328FC0DBD266DAEFA09E737A3D1B25613E34C62C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4A77971E4CF73965D9E271BDE2CCB4C0C498EF283BD449B07049FFFDB7839CE9E76E35804B2850F20AF012E3ED27339306953F66C426A0E8FE3BAFE7308568E55
X-7FA49CB5: 0D63561A33F958A5E6E6E34387B2AD50A7117D33C7327DBFF3BA5D1BC7A74E5E8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8EDCF5861DED71B2F389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3BB73733C80CB3C5935872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojiWfz0I2sVCn9v4MiCcHAhQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

- The clk_init_data structures are never modified, make
them const.
- Add missing comma
- Add dependencies on "ARM64 or COMPILE_TEST"

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 drivers/clk/qcom/Kconfig      |   1 +
 drivers/clk/qcom/gcc-sm7150.c | 394 +++++++++++++++++-----------------
 2 files changed, 198 insertions(+), 197 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 8ab08e7b5b6c..966770187844 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -952,6 +952,7 @@ config SM_GCC_6375
 
 config SM_GCC_7150
 	tristate "SM7150 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SM7150 devices.
diff --git a/drivers/clk/qcom/gcc-sm7150.c b/drivers/clk/qcom/gcc-sm7150.c
index 44b49f7cd178..6d1bf335f0cf 100644
--- a/drivers/clk/qcom/gcc-sm7150.c
+++ b/drivers/clk/qcom/gcc-sm7150.c
@@ -26,7 +26,7 @@
 enum {
 	DT_BI_TCXO,
 	DT_BI_TCXO_AO,
-	DT_SLEEP_CLK
+	DT_SLEEP_CLK,
 };
 
 enum {
@@ -44,9 +44,9 @@ static struct clk_alpha_pll gpll0 = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gpll0",
-			.parent_data = &(const struct clk_parent_data){
+			.parent_data = &(const struct clk_parent_data) {
 				.index = DT_BI_TCXO,
 			},
 			.num_parents = 1,
@@ -70,9 +70,9 @@ static struct clk_alpha_pll_postdiv gpll0_out_even = {
 	.num_post_div = ARRAY_SIZE(post_div_table_fabia_even),
 	.width = 4,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gpll0_out_even",
-		.parent_hws = (const struct clk_hw*[]){
+		.parent_hws = (const struct clk_hw*[]) {
 			&gpll0.clkr.hw,
 		},
 		.num_parents = 1,
@@ -83,9 +83,9 @@ static struct clk_alpha_pll_postdiv gpll0_out_even = {
 static struct clk_fixed_factor gcc_pll0_main_div_cdiv = {
 	.mult = 1,
 	.div = 2,
-	.hw.init = &(struct clk_init_data){
+	.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_pll0_main_div_cdiv",
-		.parent_hws = (const struct clk_hw*[]){
+		.parent_hws = (const struct clk_hw*[]) {
 			&gpll0.clkr.hw,
 		},
 		.num_parents = 1,
@@ -99,9 +99,9 @@ static struct clk_alpha_pll gpll6 = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(6),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gpll6",
-			.parent_data = &(const struct clk_parent_data){
+			.parent_data = &(const struct clk_parent_data) {
 				.index = DT_BI_TCXO,
 			},
 			.num_parents = 1,
@@ -116,9 +116,9 @@ static struct clk_alpha_pll gpll7 = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(7),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gpll7",
-			.parent_data = &(const struct clk_parent_data){
+			.parent_data = &(const struct clk_parent_data) {
 				.index = DT_BI_TCXO,
 			},
 			.num_parents = 1,
@@ -252,7 +252,7 @@ static struct clk_rcg2 gcc_cpuss_ahb_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_0,
 	.freq_tbl = ftbl_gcc_cpuss_ahb_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_cpuss_ahb_clk_src",
 		.parent_data = gcc_parent_data_0_ao,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0_ao),
@@ -272,7 +272,7 @@ static struct clk_rcg2 gcc_cpuss_rbcpr_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_2,
 	.freq_tbl = ftbl_gcc_cpuss_rbcpr_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_cpuss_rbcpr_clk_src",
 		.parent_data = gcc_parent_data_2_ao,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_2_ao),
@@ -295,7 +295,7 @@ static struct clk_rcg2 gcc_gp1_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_gp1_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_gp1_clk_src",
 		.parent_data = gcc_parent_data_1,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
@@ -309,7 +309,7 @@ static struct clk_rcg2 gcc_gp2_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_gp1_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_gp2_clk_src",
 		.parent_data = gcc_parent_data_1,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
@@ -323,7 +323,7 @@ static struct clk_rcg2 gcc_gp3_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_gp1_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_gp3_clk_src",
 		.parent_data = gcc_parent_data_1,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
@@ -343,7 +343,7 @@ static struct clk_rcg2 gcc_pcie_0_aux_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_3,
 	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_pcie_0_aux_clk_src",
 		.parent_data = gcc_parent_data_3,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
@@ -363,7 +363,7 @@ static struct clk_rcg2 gcc_pcie_phy_refgen_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_0,
 	.freq_tbl = ftbl_gcc_pcie_phy_refgen_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_pcie_phy_refgen_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
@@ -383,7 +383,7 @@ static struct clk_rcg2 gcc_pdm2_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_0,
 	.freq_tbl = ftbl_gcc_pdm2_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_pdm2_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
@@ -687,7 +687,7 @@ static struct clk_rcg2 gcc_sdcc1_apps_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_5,
 	.freq_tbl = ftbl_gcc_sdcc1_apps_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_sdcc1_apps_clk_src",
 		.parent_data = gcc_parent_data_5,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_5),
@@ -709,7 +709,7 @@ static struct clk_rcg2 gcc_sdcc1_ice_core_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_0,
 	.freq_tbl = ftbl_gcc_sdcc1_ice_core_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_sdcc1_ice_core_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
@@ -734,7 +734,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_6,
 	.freq_tbl = ftbl_gcc_sdcc2_apps_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_6,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_6),
@@ -760,7 +760,7 @@ static struct clk_rcg2 gcc_sdcc4_apps_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_0,
 	.freq_tbl = ftbl_gcc_sdcc4_apps_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_sdcc4_apps_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
@@ -779,7 +779,7 @@ static struct clk_rcg2 gcc_tsif_ref_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_7,
 	.freq_tbl = ftbl_gcc_tsif_ref_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_tsif_ref_clk_src",
 		.parent_data = gcc_parent_data_7,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_7),
@@ -802,7 +802,7 @@ static struct clk_rcg2 gcc_ufs_phy_axi_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_0,
 	.freq_tbl = ftbl_gcc_ufs_phy_axi_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_ufs_phy_axi_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
@@ -824,7 +824,7 @@ static struct clk_rcg2 gcc_ufs_phy_ice_core_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_0,
 	.freq_tbl = ftbl_gcc_ufs_phy_ice_core_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_ufs_phy_ice_core_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
@@ -838,7 +838,7 @@ static struct clk_rcg2 gcc_ufs_phy_phy_aux_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_4,
 	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_ufs_phy_phy_aux_clk_src",
 		.parent_data = gcc_parent_data_4,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
@@ -859,7 +859,7 @@ static struct clk_rcg2 gcc_ufs_phy_unipro_core_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_0,
 	.freq_tbl = ftbl_gcc_ufs_phy_unipro_core_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_ufs_phy_unipro_core_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
@@ -881,7 +881,7 @@ static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_0,
 	.freq_tbl = ftbl_gcc_usb30_prim_master_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_usb30_prim_master_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
@@ -903,7 +903,7 @@ static struct clk_rcg2 gcc_usb30_prim_mock_utmi_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_0,
 	.freq_tbl = ftbl_gcc_usb30_prim_mock_utmi_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_usb30_prim_mock_utmi_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
@@ -922,7 +922,7 @@ static struct clk_rcg2 gcc_usb3_prim_phy_aux_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_3,
 	.freq_tbl = ftbl_gcc_usb3_prim_phy_aux_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_usb3_prim_phy_aux_clk_src",
 		.parent_data = gcc_parent_data_3,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
@@ -936,7 +936,7 @@ static struct clk_rcg2 gcc_vs_ctrl_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_2,
 	.freq_tbl = ftbl_gcc_usb3_prim_phy_aux_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_vs_ctrl_clk_src",
 		.parent_data = gcc_parent_data_2,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
@@ -957,7 +957,7 @@ static struct clk_rcg2 gcc_vsensor_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_8,
 	.freq_tbl = ftbl_gcc_vsensor_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_vsensor_clk_src",
 		.parent_data = gcc_parent_data_8,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_8),
@@ -971,7 +971,7 @@ static struct clk_branch gcc_aggre_noc_pcie_tbu_clk = {
 	.clkr = {
 		.enable_reg = 0x2800c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_aggre_noc_pcie_tbu_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -986,9 +986,9 @@ static struct clk_branch gcc_aggre_ufs_phy_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x82024,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_aggre_ufs_phy_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_ufs_phy_axi_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1006,9 +1006,9 @@ static struct clk_branch gcc_aggre_ufs_phy_axi_hw_ctl_clk = {
 	.clkr = {
 		.enable_reg = 0x82024,
 		.enable_mask = BIT(1),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_aggre_ufs_phy_axi_hw_ctl_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_aggre_ufs_phy_axi_clk.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1024,9 +1024,9 @@ static struct clk_branch gcc_aggre_usb3_prim_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x8201c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_aggre_usb3_prim_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_usb30_prim_master_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1042,9 +1042,9 @@ static struct clk_branch gcc_apc_vs_clk = {
 	.clkr = {
 		.enable_reg = 0x7a050,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_apc_vs_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_vsensor_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1062,7 +1062,7 @@ static struct clk_branch gcc_boot_rom_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(10),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_boot_rom_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1075,7 +1075,7 @@ static struct clk_branch gcc_camera_hf_axi_clk = {
 	.clkr = {
 		.enable_reg = 0xb020,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_camera_hf_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1088,7 +1088,7 @@ static struct clk_branch gcc_camera_sf_axi_clk = {
 	.clkr = {
 		.enable_reg = 0xb06c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_camera_sf_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1103,7 +1103,7 @@ static struct clk_branch gcc_ce1_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(3),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_ce1_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1116,7 +1116,7 @@ static struct clk_branch gcc_ce1_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(4),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_ce1_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1129,7 +1129,7 @@ static struct clk_branch gcc_ce1_clk = {
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(5),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_ce1_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1142,9 +1142,9 @@ static struct clk_branch gcc_cfg_noc_usb3_prim_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x502c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_cfg_noc_usb3_prim_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_usb30_prim_master_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1160,9 +1160,9 @@ static struct clk_branch gcc_cpuss_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(21),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_cpuss_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_cpuss_ahb_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1178,9 +1178,9 @@ static struct clk_branch gcc_cpuss_rbcpr_clk = {
 	.clkr = {
 		.enable_reg = 0x48008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_cpuss_rbcpr_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_cpuss_rbcpr_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1196,7 +1196,7 @@ static struct clk_branch gcc_ddrss_gpu_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x4452c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_ddrss_gpu_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1209,9 +1209,9 @@ static struct clk_branch gcc_disp_gpll0_clk_src = {
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(18),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_disp_gpll0_clk_src",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gpll0.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1225,9 +1225,9 @@ static struct clk_branch gcc_disp_gpll0_div_clk_src = {
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(19),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_disp_gpll0_div_clk_src",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_pll0_main_div_cdiv.hw,
 			},
 			.num_parents = 1,
@@ -1242,7 +1242,7 @@ static struct clk_branch gcc_disp_hf_axi_clk = {
 	.clkr = {
 		.enable_reg = 0xb024,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_disp_hf_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1255,7 +1255,7 @@ static struct clk_branch gcc_disp_sf_axi_clk = {
 	.clkr = {
 		.enable_reg = 0xb070,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_disp_sf_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1269,9 +1269,9 @@ static struct clk_branch gcc_gp1_clk = {
 	.clkr = {
 		.enable_reg = 0x64000,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_gp1_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_gp1_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1287,9 +1287,9 @@ static struct clk_branch gcc_gp2_clk = {
 	.clkr = {
 		.enable_reg = 0x65000,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_gp2_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_gp2_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1305,9 +1305,9 @@ static struct clk_branch gcc_gp3_clk = {
 	.clkr = {
 		.enable_reg = 0x66000,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_gp3_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_gp3_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1322,9 +1322,9 @@ static struct clk_branch gcc_gpu_gpll0_clk_src = {
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(15),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_gpu_gpll0_clk_src",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gpll0.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1338,9 +1338,9 @@ static struct clk_branch gcc_gpu_gpll0_div_clk_src = {
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(16),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_gpu_gpll0_div_clk_src",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_pll0_main_div_cdiv.hw,
 			},
 			.num_parents = 1,
@@ -1355,7 +1355,7 @@ static struct clk_branch gcc_gpu_memnoc_gfx_clk = {
 	.clkr = {
 		.enable_reg = 0x7100c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_gpu_memnoc_gfx_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1368,7 +1368,7 @@ static struct clk_branch gcc_gpu_snoc_dvm_gfx_clk = {
 	.clkr = {
 		.enable_reg = 0x71018,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_gpu_snoc_dvm_gfx_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1381,9 +1381,9 @@ static struct clk_branch gcc_gpu_vs_clk = {
 	.clkr = {
 		.enable_reg = 0x7a04c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_gpu_vs_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_vsensor_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1399,7 +1399,7 @@ static struct clk_branch gcc_npu_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x4d008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_npu_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1414,7 +1414,7 @@ static struct clk_branch gcc_npu_cfg_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x4d004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_npu_cfg_ahb_clk",
 			.flags = CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
@@ -1427,9 +1427,9 @@ static struct clk_branch gcc_npu_gpll0_clk_src = {
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(25),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_npu_gpll0_clk_src",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gpll0.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1443,9 +1443,9 @@ static struct clk_branch gcc_npu_gpll0_div_clk_src = {
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(26),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_npu_gpll0_div_clk_src",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_pll0_main_div_cdiv.hw,
 			},
 			.num_parents = 1,
@@ -1461,9 +1461,9 @@ static struct clk_branch gcc_pcie_0_aux_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(3),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_0_aux_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_pcie_0_aux_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1481,7 +1481,7 @@ static struct clk_branch gcc_pcie_0_cfg_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(2),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_0_cfg_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1494,7 +1494,7 @@ static struct clk_branch gcc_pcie_0_clkref_clk = {
 	.clkr = {
 		.enable_reg = 0x8c008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_0_clkref_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1507,7 +1507,7 @@ static struct clk_branch gcc_pcie_0_mstr_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(1),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_0_mstr_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1520,7 +1520,7 @@ static struct clk_branch gcc_pcie_0_pipe_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(4),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_0_pipe_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1535,7 +1535,7 @@ static struct clk_branch gcc_pcie_0_slv_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_0_slv_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1548,7 +1548,7 @@ static struct clk_branch gcc_pcie_0_slv_q2a_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(5),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_0_slv_q2a_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1561,9 +1561,9 @@ static struct clk_branch gcc_pcie_phy_aux_clk = {
 	.clkr = {
 		.enable_reg = 0x6f004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_phy_aux_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_pcie_0_aux_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1579,9 +1579,9 @@ static struct clk_branch gcc_pcie_phy_refgen_clk = {
 	.clkr = {
 		.enable_reg = 0x6f02c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_phy_refgen_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_pcie_phy_refgen_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1597,9 +1597,9 @@ static struct clk_branch gcc_pdm2_clk = {
 	.clkr = {
 		.enable_reg = 0x3300c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pdm2_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_pdm2_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1617,7 +1617,7 @@ static struct clk_branch gcc_pdm_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x33004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pdm_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1630,7 +1630,7 @@ static struct clk_branch gcc_pdm_xo4_clk = {
 	.clkr = {
 		.enable_reg = 0x33008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pdm_xo4_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1645,7 +1645,7 @@ static struct clk_branch gcc_prng_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(13),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_prng_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1658,7 +1658,7 @@ static struct clk_branch gcc_qupv3_wrap0_core_2x_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(9),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap0_core_2x_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1671,7 +1671,7 @@ static struct clk_branch gcc_qupv3_wrap0_core_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(8),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap0_core_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1684,9 +1684,9 @@ static struct clk_branch gcc_qupv3_wrap0_s0_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(10),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap0_s0_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_qupv3_wrap0_s0_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1702,9 +1702,9 @@ static struct clk_branch gcc_qupv3_wrap0_s1_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(11),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap0_s1_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_qupv3_wrap0_s1_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1720,9 +1720,9 @@ static struct clk_branch gcc_qupv3_wrap0_s2_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(12),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap0_s2_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_qupv3_wrap0_s2_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1738,9 +1738,9 @@ static struct clk_branch gcc_qupv3_wrap0_s3_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(13),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap0_s3_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_qupv3_wrap0_s3_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1756,9 +1756,9 @@ static struct clk_branch gcc_qupv3_wrap0_s4_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(14),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap0_s4_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_qupv3_wrap0_s4_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1774,9 +1774,9 @@ static struct clk_branch gcc_qupv3_wrap0_s5_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(15),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap0_s5_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_qupv3_wrap0_s5_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1792,9 +1792,9 @@ static struct clk_branch gcc_qupv3_wrap0_s6_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(16),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap0_s6_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_qupv3_wrap0_s6_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1810,9 +1810,9 @@ static struct clk_branch gcc_qupv3_wrap0_s7_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(17),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap0_s7_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_qupv3_wrap0_s7_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1828,7 +1828,7 @@ static struct clk_branch gcc_qupv3_wrap1_core_2x_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(18),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap1_core_2x_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1841,7 +1841,7 @@ static struct clk_branch gcc_qupv3_wrap1_core_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(19),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap1_core_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1854,9 +1854,9 @@ static struct clk_branch gcc_qupv3_wrap1_s0_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(22),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap1_s0_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_qupv3_wrap1_s0_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1872,9 +1872,9 @@ static struct clk_branch gcc_qupv3_wrap1_s1_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(23),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap1_s1_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_qupv3_wrap1_s1_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1890,9 +1890,9 @@ static struct clk_branch gcc_qupv3_wrap1_s2_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(24),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap1_s2_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_qupv3_wrap1_s2_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1908,9 +1908,9 @@ static struct clk_branch gcc_qupv3_wrap1_s3_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(25),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap1_s3_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_qupv3_wrap1_s3_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1926,9 +1926,9 @@ static struct clk_branch gcc_qupv3_wrap1_s4_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(26),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap1_s4_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_qupv3_wrap1_s4_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1944,9 +1944,9 @@ static struct clk_branch gcc_qupv3_wrap1_s5_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(27),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap1_s5_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_qupv3_wrap1_s5_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1962,9 +1962,9 @@ static struct clk_branch gcc_qupv3_wrap1_s6_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(28),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap1_s6_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_qupv3_wrap1_s6_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1980,9 +1980,9 @@ static struct clk_branch gcc_qupv3_wrap1_s7_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(29),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap1_s7_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_qupv3_wrap1_s7_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -1998,7 +1998,7 @@ static struct clk_branch gcc_qupv3_wrap_0_m_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(6),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap_0_m_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2013,7 +2013,7 @@ static struct clk_branch gcc_qupv3_wrap_0_s_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(7),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap_0_s_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2026,7 +2026,7 @@ static struct clk_branch gcc_qupv3_wrap_1_m_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(20),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap_1_m_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2041,7 +2041,7 @@ static struct clk_branch gcc_qupv3_wrap_1_s_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x5200c,
 		.enable_mask = BIT(21),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qupv3_wrap_1_s_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2054,7 +2054,7 @@ static struct clk_branch gcc_sdcc1_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x12008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_sdcc1_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2067,9 +2067,9 @@ static struct clk_branch gcc_sdcc1_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x1200c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_sdcc1_apps_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_sdcc1_apps_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -2085,9 +2085,9 @@ static struct clk_branch gcc_sdcc1_ice_core_clk = {
 	.clkr = {
 		.enable_reg = 0x12040,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_sdcc1_ice_core_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_sdcc1_ice_core_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -2103,7 +2103,7 @@ static struct clk_branch gcc_sdcc2_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x14008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_sdcc2_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2116,9 +2116,9 @@ static struct clk_branch gcc_sdcc2_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x14004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_sdcc2_apps_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_sdcc2_apps_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -2134,7 +2134,7 @@ static struct clk_branch gcc_sdcc4_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x16008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_sdcc4_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2147,9 +2147,9 @@ static struct clk_branch gcc_sdcc4_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x16004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_sdcc4_apps_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_sdcc4_apps_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -2165,9 +2165,9 @@ static struct clk_branch gcc_sys_noc_cpuss_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_sys_noc_cpuss_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_cpuss_ahb_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -2183,7 +2183,7 @@ static struct clk_branch gcc_tsif_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x36004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_tsif_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2196,7 +2196,7 @@ static struct clk_branch gcc_tsif_inactivity_timers_clk = {
 	.clkr = {
 		.enable_reg = 0x3600c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_tsif_inactivity_timers_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2209,9 +2209,9 @@ static struct clk_branch gcc_tsif_ref_clk = {
 	.clkr = {
 		.enable_reg = 0x36008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_tsif_ref_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_tsif_ref_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -2227,7 +2227,7 @@ static struct clk_branch gcc_ufs_mem_clkref_clk = {
 	.clkr = {
 		.enable_reg = 0x8c000,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_ufs_mem_clkref_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2242,7 +2242,7 @@ static struct clk_branch gcc_ufs_phy_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x77014,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_ufs_phy_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2257,9 +2257,9 @@ static struct clk_branch gcc_ufs_phy_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x77038,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_ufs_phy_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_ufs_phy_axi_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -2277,9 +2277,9 @@ static struct clk_branch gcc_ufs_phy_axi_hw_ctl_clk = {
 	.clkr = {
 		.enable_reg = 0x77038,
 		.enable_mask = BIT(1),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_ufs_phy_axi_hw_ctl_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_ufs_phy_axi_clk.clkr.hw,
 			},
 			.num_parents = 1,
@@ -2297,9 +2297,9 @@ static struct clk_branch gcc_ufs_phy_ice_core_clk = {
 	.clkr = {
 		.enable_reg = 0x77090,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_ufs_phy_ice_core_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_ufs_phy_ice_core_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -2317,9 +2317,9 @@ static struct clk_branch gcc_ufs_phy_ice_core_hw_ctl_clk = {
 	.clkr = {
 		.enable_reg = 0x77090,
 		.enable_mask = BIT(1),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_ufs_phy_ice_core_hw_ctl_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_ufs_phy_ice_core_clk.clkr.hw,
 			},
 			.num_parents = 1,
@@ -2337,9 +2337,9 @@ static struct clk_branch gcc_ufs_phy_phy_aux_clk = {
 	.clkr = {
 		.enable_reg = 0x77094,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_ufs_phy_phy_aux_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_ufs_phy_phy_aux_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -2357,9 +2357,9 @@ static struct clk_branch gcc_ufs_phy_phy_aux_hw_ctl_clk = {
 	.clkr = {
 		.enable_reg = 0x77094,
 		.enable_mask = BIT(1),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_ufs_phy_phy_aux_hw_ctl_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_ufs_phy_phy_aux_clk.clkr.hw,
 			},
 			.num_parents = 1,
@@ -2375,7 +2375,7 @@ static struct clk_branch gcc_ufs_phy_rx_symbol_0_clk = {
 	.clkr = {
 		.enable_reg = 0x7701c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_ufs_phy_rx_symbol_0_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2388,7 +2388,7 @@ static struct clk_branch gcc_ufs_phy_tx_symbol_0_clk = {
 	.clkr = {
 		.enable_reg = 0x77018,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_ufs_phy_tx_symbol_0_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2403,9 +2403,9 @@ static struct clk_branch gcc_ufs_phy_unipro_core_clk = {
 	.clkr = {
 		.enable_reg = 0x7708c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_ufs_phy_unipro_core_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_ufs_phy_unipro_core_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -2423,9 +2423,9 @@ static struct clk_branch gcc_ufs_phy_unipro_core_hw_ctl_clk = {
 	.clkr = {
 		.enable_reg = 0x7708c,
 		.enable_mask = BIT(1),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_ufs_phy_unipro_core_hw_ctl_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_ufs_phy_unipro_core_clk.clkr.hw,
 			},
 			.num_parents = 1,
@@ -2441,9 +2441,9 @@ static struct clk_branch gcc_usb30_prim_master_clk = {
 	.clkr = {
 		.enable_reg = 0xf010,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb30_prim_master_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_usb30_prim_master_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -2459,9 +2459,9 @@ static struct clk_branch gcc_usb30_prim_mock_utmi_clk = {
 	.clkr = {
 		.enable_reg = 0xf018,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb30_prim_mock_utmi_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_usb30_prim_mock_utmi_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -2477,7 +2477,7 @@ static struct clk_branch gcc_usb30_prim_sleep_clk = {
 	.clkr = {
 		.enable_reg = 0xf014,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb30_prim_sleep_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2490,7 +2490,7 @@ static struct clk_branch gcc_usb3_prim_clkref_clk = {
 	.clkr = {
 		.enable_reg = 0x8c010,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb3_prim_clkref_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2503,9 +2503,9 @@ static struct clk_branch gcc_usb3_prim_phy_aux_clk = {
 	.clkr = {
 		.enable_reg = 0xf050,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb3_prim_phy_aux_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_usb3_prim_phy_aux_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -2521,9 +2521,9 @@ static struct clk_branch gcc_usb3_prim_phy_com_aux_clk = {
 	.clkr = {
 		.enable_reg = 0xf054,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb3_prim_phy_com_aux_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_usb3_prim_phy_aux_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -2538,7 +2538,7 @@ static struct clk_branch gcc_usb3_prim_phy_pipe_clk = {
 	.clkr = {
 		.enable_reg = 0xf058,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb3_prim_phy_pipe_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2553,7 +2553,7 @@ static struct clk_branch gcc_usb_phy_cfg_ahb2phy_clk = {
 	.clkr = {
 		.enable_reg = 0x6a004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb_phy_cfg_ahb2phy_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2566,9 +2566,9 @@ static struct clk_branch gcc_vdda_vs_clk = {
 	.clkr = {
 		.enable_reg = 0x7a00c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_vdda_vs_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_vsensor_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -2584,9 +2584,9 @@ static struct clk_branch gcc_vddcx_vs_clk = {
 	.clkr = {
 		.enable_reg = 0x7a004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_vddcx_vs_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_vsensor_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -2602,9 +2602,9 @@ static struct clk_branch gcc_vddmx_vs_clk = {
 	.clkr = {
 		.enable_reg = 0x7a008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_vddmx_vs_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_vsensor_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -2621,7 +2621,7 @@ static struct clk_branch gcc_video_axi_clk = {
 	.clkr = {
 		.enable_reg = 0xb01c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_video_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2636,7 +2636,7 @@ static struct clk_branch gcc_vs_ctrl_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x7a014,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_vs_ctrl_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2649,9 +2649,9 @@ static struct clk_branch gcc_vs_ctrl_clk = {
 	.clkr = {
 		.enable_reg = 0x7a010,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_vs_ctrl_clk",
-			.parent_hws = (const struct clk_hw*[]){
+			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_vs_ctrl_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
-- 
2.43.2


