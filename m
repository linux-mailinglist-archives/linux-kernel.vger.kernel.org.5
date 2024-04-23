Return-Path: <linux-kernel+bounces-155893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ED58AF8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44DD1F25D54
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711CC142E90;
	Tue, 23 Apr 2024 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="A4F8BDiV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="jvkZwTSM"
Received: from fallback2.i.mail.ru (fallback2.i.mail.ru [79.137.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E495B143873;
	Tue, 23 Apr 2024 20:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905594; cv=none; b=Sm/KT1M7zxzj/rzPLApDFnaRDY+DDqRK1Jri0rNPTVns7Wc03vXT/PQtZE66XoaDrud+P6BeidCcYxHpnUVJ8jzx8bQEbGIzWsuRSQW092J4AInpAfQDwbjypur/Pybo8JqCxXU5BWXK8gWYeEmKlDIPrkQgSOXWVXzWx++XLEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905594; c=relaxed/simple;
	bh=tkJQhuAxRxkvlrKAxT/DYjqof9/LOkisJTnyrjWYV14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQUkZm8J4OtQrH/0UO/Gv3ea0r4cHEf9sucP4kTT2DoEUYPXj/aLkIMN4e2siiRGxrhfEYxMeXTNr5Yzs5rdIn0Rr+mfdX49jXuRKUaRKnJl1GqVI0OwfM2933Zmf5Jm/wZzZKB+huN51pFBmy0ioQkxGrBtt7GFMW5GLgZVc8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=A4F8BDiV; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=jvkZwTSM; arc=none smtp.client-ip=79.137.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=7hcB/HPbOxH1LOV4E8zMrvgm7jVmfF4251sN1tcnEj8=;
	t=1713905589;x=1713995589; 
	b=A4F8BDiVzjwJhB2wRlYpGnDAhQrfZiUed9tXA/GDpgmz5MNDRTYT1QXY3/P3N+B/Ipyy2V6BGODGD1pPiCDnGbi5ri09xsMjxge79GDt/HypyCI/oAV1CMwwKiKXe0s2A/Wa9DuoKHjA++42M9pduXuSiLpAjWqluognrgT7uZ8=;
Received: from [10.12.4.6] (port=43420 helo=smtp32.i.mail.ru)
	by fallback2.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rzMpk-003fU7-EJ; Tue, 23 Apr 2024 23:33:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=7hcB/HPbOxH1LOV4E8zMrvgm7jVmfF4251sN1tcnEj8=; t=1713904424; x=1713994424; 
	b=jvkZwTSMueRqsri8BrY3uVo4Zctjuh5MPDzNalYB9Rs5aivWuzpJryE704lgRMqoaVine9xVZoz
	UkkjWvB2cWpzqjgOF+rT5F28HwjXDX673Z2DcUU86fV8LjDtmu4HiSj3ZMOmvbmcUoLx4Ry+5b3c5
	6X+WfAMkfUHMsj74rYw=;
Received: by smtp32.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rzMpV-00000001fLu-2PSQ; Tue, 23 Apr 2024 23:33:30 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: andersson@kernel.org,
	linus.walleij@linaro.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH] pinctrl: qcom: pinctrl-sm7150: Fix sdc1 and ufs special pins regs
Date: Tue, 23 Apr 2024 23:32:45 +0300
Message-ID: <20240423203245.188480-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9CB0CA91FF61D77F079DB05CF36BBC9A3F69AE33A8C859DB8182A05F5380850406946F34C56A382629487ABAC94A94B54471C65A309377891598152BD3252769AB14F0FA0E0289DA8
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE77E216A0E97507353EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063703E3935C5A8197E98638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D85C2982A8BDF01D17A411E1E24DA7AD66A20C02CBBD2F4920CC7F00164DA146DAFE8445B8C89999728AA50765F79006377FF6DF7F8AE7C7A6389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8632EDEA9CD5989A3F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C6089696B24BB1D196E0066C2D8992A164AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3C778128E6DD73434BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFE478A468B35FE7671DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C310D8D88A3CEF7A9335872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A59BF55377A6AC763D5002B1117B3ED69650AA5E65191A7B99B74D9144D44E4FCF823CB91A9FED034534781492E4B8EEADC3194D76C41E9723C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFE02C963CED2E748716C353189E1DC92A896897DD9602F5F88AE5DEDA4A54973FCCDF2CE9FE05F2E7930DB2EDDBD5B4A185302B5F5BA37EE0A7E06B51654D070DDA75654BAFD43DF477C8E16086367389913E6812662D5F2A78A556DA1408BD603BAB4BE5B351B77B77D7EADF59166DF0
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXif34LPabVk/xqkB+AD+gK2
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949817A7D7943590EEF51D85FDC519B83646028049072C5A59D1E2A72FDF98597EBDB2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B475A7E96CA7452FC883DD00B47595C7BFD442F0DCAF96DD3D049FFFDB7839CE9E89C7DB93084D3E9CDA427CD6706D5A64A10E8988E20EB5F14B4C8169A88E8F15
X-7FA49CB5: 0D63561A33F958A5D914510388C8334F0E83B89AE99F3855DCFF150050F863BF8941B15DA834481FA18204E546F3947C0072D29C69FDE18FF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006372D0AD69218B09DB0389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3770A2E5BFE0A2A8135872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojzz1Jr2ms4lXxX+WP3M/0og==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

SDC1 and UFS_RESET special pins are located in the west memory bank.

SDC1 have address 0x359a000:
0x3500000 (TLMM BASE) + 0x0 (WEST) + 0x9a000 (SDC1_OFFSET) = 0x359a000

UFS_RESET have address 0x359f000:
0x3500000 (TLMM BASE) + 0x0 (WEST) + 0x9f000 (UFS_OFFSET) = 0x359a000

Fixes: b915395c9e04 ("pinctrl: qcom: Add SM7150 pinctrl driver")
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 drivers/pinctrl/qcom/pinctrl-sm7150.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sm7150.c b/drivers/pinctrl/qcom/pinctrl-sm7150.c
index c542f9bc6bcd..095a1ca75849 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm7150.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm7150.c
@@ -65,7 +65,7 @@ enum {
 		.intr_detection_width = 2,		\
 	}
 
-#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)	\
+#define SDC_QDSD_PINGROUP(pg_name, _tile, ctl, pull, drv) \
 	{						\
 		.grp = PINCTRL_PINGROUP(#pg_name, 	\
 			pg_name##_pins, 		\
@@ -75,7 +75,7 @@ enum {
 		.intr_cfg_reg = 0,			\
 		.intr_status_reg = 0,			\
 		.intr_target_reg = 0,			\
-		.tile = SOUTH,				\
+		.tile = _tile,				\
 		.mux_bit = -1,				\
 		.pull_bit = pull,			\
 		.drv_bit = drv,				\
@@ -101,7 +101,7 @@ enum {
 		.intr_cfg_reg = 0,			\
 		.intr_status_reg = 0,			\
 		.intr_target_reg = 0,			\
-		.tile = SOUTH,				\
+		.tile = WEST,				\
 		.mux_bit = -1,				\
 		.pull_bit = 3,				\
 		.drv_bit = 0,				\
@@ -1199,13 +1199,13 @@ static const struct msm_pingroup sm7150_groups[] = {
 	[117] = PINGROUP(117, NORTH, _, _, _, _, _, _, _, _, _),
 	[118] = PINGROUP(118, NORTH, _, _, _, _, _, _, _, _, _),
 	[119] = UFS_RESET(ufs_reset, 0x9f000),
-	[120] = SDC_QDSD_PINGROUP(sdc1_rclk, 0x9a000, 15, 0),
-	[121] = SDC_QDSD_PINGROUP(sdc1_clk, 0x9a000, 13, 6),
-	[122] = SDC_QDSD_PINGROUP(sdc1_cmd, 0x9a000, 11, 3),
-	[123] = SDC_QDSD_PINGROUP(sdc1_data, 0x9a000, 9, 0),
-	[124] = SDC_QDSD_PINGROUP(sdc2_clk, 0x98000, 14, 6),
-	[125] = SDC_QDSD_PINGROUP(sdc2_cmd, 0x98000, 11, 3),
-	[126] = SDC_QDSD_PINGROUP(sdc2_data, 0x98000, 9, 0),
+	[120] = SDC_QDSD_PINGROUP(sdc1_rclk, WEST, 0x9a000, 15, 0),
+	[121] = SDC_QDSD_PINGROUP(sdc1_clk, WEST, 0x9a000, 13, 6),
+	[122] = SDC_QDSD_PINGROUP(sdc1_cmd, WEST, 0x9a000, 11, 3),
+	[123] = SDC_QDSD_PINGROUP(sdc1_data, WEST, 0x9a000, 9, 0),
+	[124] = SDC_QDSD_PINGROUP(sdc2_clk, SOUTH, 0x98000, 14, 6),
+	[125] = SDC_QDSD_PINGROUP(sdc2_cmd, SOUTH, 0x98000, 11, 3),
+	[126] = SDC_QDSD_PINGROUP(sdc2_data, SOUTH, 0x98000, 9, 0),
 };
 
 static const struct msm_gpio_wakeirq_map sm7150_pdc_map[] = {
-- 
2.44.0


