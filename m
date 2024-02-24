Return-Path: <linux-kernel+bounces-79746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9E086262B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5031C213BC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4459F47A6A;
	Sat, 24 Feb 2024 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIEJNvi8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF734C6B;
	Sat, 24 Feb 2024 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708793774; cv=none; b=RvwzJ67WuFxcrycky8M46a08lr0xS/U580+mkZ5EA/vd2Bp2kXUgKjIHJGt8bLLUtsX6uMJK1VxTSZbmGyRwty/+1FlCpu/eiQFp9TGPuW6STaMfYFFx74GAByTa5Qs+wKznV5/RuyMNjWIBLiLeve5PCjJP+/OqxmHHCDFzBJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708793774; c=relaxed/simple;
	bh=wKkGrhKZpWd/BwtJ4dXpC6KH8T0ZmrTFSOOKkvCP4Ng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ntF3EP7gV9Du3tqTIj5TLjtVBzXFVydqxHjHjU4OU/fFQo1IWYeQZs318xQnfr9S/69SE3FnHjApk2ONSYVZf5c0tQ2xLFCMlN3wOkLF3RtbN4EZnT3d/UR2n1eCRU14GUXc9Ro6KJ4aXLEUS5OQSATw1vSKp/e+wLTpaagk6Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIEJNvi8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A8E3C433C7;
	Sat, 24 Feb 2024 16:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708793774;
	bh=wKkGrhKZpWd/BwtJ4dXpC6KH8T0ZmrTFSOOKkvCP4Ng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XIEJNvi8A7YkihzdAP4sCB9StegVyE9U+CoRFcODaUzHwA3e56SdnPY0nJagN2TdK
	 PCYNCBx/GMF5A95LhaS5UL1ryS022OxKvaMTYXNgHWtxa1CHzfZciPuD1au7011u7T
	 LtT0Ie0s6kDr4rdjJVVcIjxigXSLhSGdMsPtGwk/Cnn73yf3qFT+f5lNYkTo4h9ZKM
	 sT1zIDXkkvqc243PwuyAVmdpEe3bMxDkJm/l3ST2tCcLh01gm92TsXqvheNnW7C3Lu
	 QQ/zN6ITlh1CwZqdbhXMvzKxz9icJbiaFl35Pwv59YoCVTl9LDYlXJSLnAUMlKugNY
	 W/sIEXFYTzg7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29EEC54E49;
	Sat, 24 Feb 2024 16:56:13 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sun, 25 Feb 2024 00:56:09 +0800
Subject: [PATCH RFC 1/2] clk: hisilicon: rename hi3519 PLL registration
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240225-pll-v1-1-fad6511479c6@outlook.com>
References: <20240225-pll-v1-0-fad6511479c6@outlook.com>
In-Reply-To: <20240225-pll-v1-0-fad6511479c6@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@foundries.io>, 
 Jorge Ramirez-Ortiz Gmail <jorge.ramirez.ortiz@gmail.com>, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708793775; l=1253;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=RjDdWKwpGyzyVB1dZKcx8ShQs0qG7CAnl7kkoTOnoFc=;
 b=QlwkUL5n+D2xcLQWoH0d8vCOTVanik7rxPAd2tCP7zr67tXHaUwqziZ5IYv4k0T+7Ac0VN/OM
 +Ga6WfGfqWmAaZQ6NxFn6zHRMCAR1RHP2JR+SidKbtQ2MGxW+gmZqd1
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Hi3559 clock drivers implemented their own PLL driver. Unfortunately
our generic PLL driver will use a same name. So add a prefix "_" to
avoid that.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/clk/hisilicon/clk-hi3559a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
index ff4ca0edce06..77fa4203a428 100644
--- a/drivers/clk/hisilicon/clk-hi3559a.c
+++ b/drivers/clk/hisilicon/clk-hi3559a.c
@@ -452,7 +452,7 @@ static const struct clk_ops hisi_clk_pll_ops = {
 	.recalc_rate = clk_pll_recalc_rate,
 };
 
-static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
+static void _hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
 			   int nums, struct hisi_clock_data *data, struct device *dev)
 {
 	void __iomem *base = data->base;
@@ -517,7 +517,7 @@ static struct hisi_clock_data *hi3559av100_clk_register(
 	if (ret)
 		return ERR_PTR(ret);
 
-	hisi_clk_register_pll(hi3559av100_pll_clks,
+	_hisi_clk_register_pll(hi3559av100_pll_clks,
 			      ARRAY_SIZE(hi3559av100_pll_clks), clk_data, &pdev->dev);
 
 	ret = hisi_clk_register_mux(hi3559av100_mux_clks_crg,

-- 
2.43.0


