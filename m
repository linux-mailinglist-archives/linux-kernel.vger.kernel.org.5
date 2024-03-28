Return-Path: <linux-kernel+bounces-122680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E258588FB50
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F62C1C2D8D7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0FE7E103;
	Thu, 28 Mar 2024 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJYxgW1R"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BD07D08D;
	Thu, 28 Mar 2024 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617814; cv=none; b=kQkLdjIQ8vRSW8DHqehr1JrI0/T98A/0fBPI0cZpwGG6f2mFGvmGpQ8k4ykEfLvjb6ss52AJ4PhOqDRMciqpxR+xE1lT64zxoUAgrEsS0jFtgmH02j0J1TQhqRpiKVc7Cw4TF9WJ4+9OUcSKvxs2TMiZOFDP0UgK/I3o39TZCAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617814; c=relaxed/simple;
	bh=dud4rMOe/pelC+qupk8nIgRzOOgdNrICweSnDQ3y0/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MyYaY9K/TGipwns8Pnxt7JXGmNBY2QmxV4iMIl9r66FiMEydDmboL2MKGXR/INFzvVfFJbMsHXsVRfo2aIR3281YlZVybHAEyXN/ETEzWIX55GSbXuF6xd7qP2A7QkAZyJkfc1LQDr2hU04zfJ+KQBztvVwczYIGIW3JA0kxu0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJYxgW1R; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56c1364ff79so814781a12.1;
        Thu, 28 Mar 2024 02:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711617810; x=1712222610; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQ8KrwSH0geLnE8SddHj11JFI0VYSS+O6h5YQENmBAI=;
        b=aJYxgW1RgmzapvpldTsCYbckoTVJ/rm//TDDd2OEuvp3QQX6Gi8qR0fVzq8hE2OG4F
         ajICT8NRB2uyUG3h2/88GB78eyu6yjYHPGSfVqgnWDc5KGc+iSjJYwBZzbL0Za/6fvuc
         sqFa8x/YRCvgx+Ipd4sRYE4XZrjdLj4inr7Zq+D8M00FM/g64y9t7+7lSj6jnBJ2FSJs
         miN/eBq4o+rhWL4JnEXJojdrKAZmxhtJHvBRWCevwn/enCc8Q8lv7oCMS/5JaU6iniRx
         zNX3E1pjnbfiv456godagDdQp13kfd5W12MiAelyV5ZCiqnNquLB4Xadja5UT7H1a47x
         RNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711617810; x=1712222610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQ8KrwSH0geLnE8SddHj11JFI0VYSS+O6h5YQENmBAI=;
        b=Bpn/MpTY3kQ4at3lIEwfTf8ZhA8LZvC+cIKj7vVqsTFMmg7rGqrxfkDUSZBUHYKSYU
         CWiZhRxcVc6wYzdzyiZrE55CqZ8fm+GecbEqyhjgcN3i14uRM+jY5sc4F5OMyvjmG1Qo
         emr6azSrPH0eR//HZcwFUqS82cbjrcEXAl8XDSXAKTTuVszGHrrwGE8bAkuKzUVtbVa5
         o7+PRohxtNek1Q+nQiP+Inal+IRxzVkg2m28NmPY0p0HVa1g51aauGZih8KAjS86/Gs6
         LegbUlp9MvwZJfEQxo+wIUTsnlDc1nP8y2yMCWddfInXN5OnUkFecu9fAj6tfxr3YKL+
         S2lg==
X-Forwarded-Encrypted: i=1; AJvYcCUyOd2Bo2n05T7iGN4rR362kNbjzeZ6fg58zqbxx7FIT/vyIq8Q6xEJCbgL+UnIU1IjgCsPptt+4rNrqmSr/Gyd9uA+dQiTzM+6sOY9Xn+LmIIBq/kjYapA9IoluG7n9fZlBvyJLxO7
X-Gm-Message-State: AOJu0YyaWLwfLXLt3V2AXr4pTK4WP2qy+x/Ik1drGq6r3yU1R2B2Dx+V
	m4kG3O8e0GCyhrCm5AzVj7zem0rRa3yF2mFK+4hsE+D5vVW6oz1k
X-Google-Smtp-Source: AGHT+IGAdCDez0IPTXRC0YmrhgbaNY+LKvdFxPcOBOp9jrO/6eCt3QeLPDC0AtVCAJjfpPeysYz1Jw==
X-Received: by 2002:a50:bb65:0:b0:56c:d44:f1c3 with SMTP id y92-20020a50bb65000000b0056c0d44f1c3mr1588180ede.25.1711617809876;
        Thu, 28 Mar 2024 02:23:29 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id cf2-20020a0564020b8200b0056b0af78d80sm609298edb.34.2024.03.28.02.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 02:23:29 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 28 Mar 2024 10:23:14 +0100
Subject: [PATCH v4 5/5] clk: qcom: clk-cbf-8996: use HUAYRA_APSS register
 map for cbf_pll
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-apss-ipq-pll-cleanup-v4-5-eddbf617f0c8@gmail.com>
References: <20240328-apss-ipq-pll-cleanup-v4-0-eddbf617f0c8@gmail.com>
In-Reply-To: <20240328-apss-ipq-pll-cleanup-v4-0-eddbf617f0c8@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.13.0

The register map used for 'cbf_pll' is the same as the one defined for
the CLK_ALPHA_PLL_TYPE_HUAYRA_APSS indice in the 'clk_alpha_pll_regs'
array.

Drop the local register map and use the global one instead to reduce
code duplication.

No functional changes intended. Compile tested only.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v4:
 - fix a typo in subject (HUAYRA_APPS => HUAYRA_APSS)
 - add Reviewed-by tag from Konrad
 - Link to v3: https://lore.kernel.org/r/20240326-apss-ipq-pll-cleanup-v3-5-15c4aeeb14ac@gmail.com

Changes in v3:
 - rebase on top of v6.9-rc1
 - add Reviewed-by tag from Dmitry
 - Link to v2: https://lore.kernel.org/r/20240321-apss-ipq-pll-cleanup-v2-5-201f3cf79fd4@gmail.com

Changes in v2:
  - new patch

Note: Although this patch is not strictly related to the subject of the
series but as the change has been suggested by Dmitry during the review
process it has been added here for completeness.
---
 drivers/clk/qcom/clk-cbf-8996.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/clk/qcom/clk-cbf-8996.c b/drivers/clk/qcom/clk-cbf-8996.c
index fe24b4abeab4..76bf523431b8 100644
--- a/drivers/clk/qcom/clk-cbf-8996.c
+++ b/drivers/clk/qcom/clk-cbf-8996.c
@@ -41,17 +41,6 @@ enum {
 
 #define CBF_PLL_OFFSET 0xf000
 
-static const u8 cbf_pll_regs[PLL_OFF_MAX_REGS] = {
-	[PLL_OFF_L_VAL] = 0x08,
-	[PLL_OFF_ALPHA_VAL] = 0x10,
-	[PLL_OFF_USER_CTL] = 0x18,
-	[PLL_OFF_CONFIG_CTL] = 0x20,
-	[PLL_OFF_CONFIG_CTL_U] = 0x24,
-	[PLL_OFF_TEST_CTL] = 0x30,
-	[PLL_OFF_TEST_CTL_U] = 0x34,
-	[PLL_OFF_STATUS] = 0x28,
-};
-
 static struct alpha_pll_config cbfpll_config = {
 	.l = 72,
 	.config_ctl_val = 0x200d4828,
@@ -67,7 +56,7 @@ static struct alpha_pll_config cbfpll_config = {
 
 static struct clk_alpha_pll cbf_pll = {
 	.offset = CBF_PLL_OFFSET,
-	.regs = cbf_pll_regs,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_HUAYRA_APSS],
 	.flags = SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_FSM_MODE,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "cbf_pll",

-- 
2.44.0


