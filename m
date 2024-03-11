Return-Path: <linux-kernel+bounces-99045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 880FE8782C2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1C2BB221D7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C3F41C92;
	Mon, 11 Mar 2024 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNgN3+cu"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FB240BF5;
	Mon, 11 Mar 2024 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169607; cv=none; b=kW/dxye6uc6ZcWGXhScfikNvO+FOkbaHOtsKqht33OFzk6McAlX8ajE0w4pyagQcOGx8mpxn2gxE2Y/hRk5C7IqcKn+vcKdK4FnN1KbQOeRdGTSkCE0Ue2u/AKwOF8qDMmMiIVI8Ecz0rDaURepabBWcHdO5ZrfGM0e10Ms/Gkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169607; c=relaxed/simple;
	bh=jM8qojVi9Uw9YkOakv3MCyDt+Qa2825phjpnwYFimNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P73y9SWg6ct5ZpQ4Zl5BbNposeHUj+vsKdmMPo51MNH1SaZzxx24rQwvJzsgb/WoXrOU2RDmHdzpqFy5f3Fh++2Ux8bUwS8heF3KKMJJQBd2i6F1sAaBafy7ZhdPYiFo6w0XRexISQ75YO8IoLrMaKahSL/Wct5nY2VrstjA9Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNgN3+cu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4132fc7dea7so2455185e9.3;
        Mon, 11 Mar 2024 08:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710169604; x=1710774404; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mKYFGKVLjA7DwPR4EWY/H053eab3hrbKh5vIgRJziLY=;
        b=GNgN3+cu/Ttc/OdlRUVbqcrWZEvtgTczDqPN8fN5HQXo+4UjAREbIafamCPfHTf6JZ
         MnYbwhlJ9aw50ROs9pARDE+GpB6K9ljwHsJjtavO0r8Mit/xyDLZMgv6youVSzkZcEWD
         E0UePVGYEZExQqtrZCugYYinICZwaQBPVpVR1E0dPfr9qLn0digTBy+FeF1mRrQPF50F
         ieDJ2HMu4UOyWaxzSXin/Ovi+V7dF3VzZTLjta1pY1TZzy+C2jWu5Iq2mEm1vbYe4Jeb
         /HeB71YgVNk8Ljnlqc1AdmNP49/yvGO8oC2WyJ4VaCKkiAFXB/qMhSyDDaV2/TflM3/s
         iIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710169604; x=1710774404;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKYFGKVLjA7DwPR4EWY/H053eab3hrbKh5vIgRJziLY=;
        b=RhmbnapV4+uItNCg6ag/foqqYdHfSGyebq57oJpiOKr0KEvXkO+S0OpRqUbVjziugV
         EyiU8z5LrNrd1Sx/dcQ8AFXSRzGdI0FkcIOZwaUCb6PFk9XX2K2x5oipyLa3exfWlUw7
         Yk6TmcPpRB0JGZFUMykZa1ZamTvZb8iI5xcZ6ezrlUPaWxw0lxIk8x4EquuoZKDusR88
         jbYEorXszIXTVMJ3Q5BloqBcf9+1jEMTLFoVM2IUS/FKAHqrZKjLd/t+6IFXDRplkNVk
         dxJwt8F883xo4FEePTTAPLjZferbNcut62DlYqVjBkB5QmiENz5EHuorBoayuZYgEzLq
         diMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtf2j3MqnbjcAlIoZXwS9/yG2iaoyYh2FK3pfslM+jZtQaxjBgJYhHici5wPW1Lk29XsH8MhssbFqlT/HY7swKVZI9BvhjPfM9wnmLX0OEwIhbEtpmtKKoszBgZJ9YV80zY8XCXwO+5hzoUDhO22y5C5NNQnnNvY7YpE9OQKzt
X-Gm-Message-State: AOJu0Yx2wZxyZddUd90npoTbhF+bWHa4YEg8Yvv38N+06QJ88k7fzlZj
	hjCcG9fiEFhQXBKWlKN6m1zXw0yRT9G4ImZrDJ9rTN8UiI1JZJo8
X-Google-Smtp-Source: AGHT+IEZ3SyLmfuwQKnCqTycMi4T+LKgFX0T9zZ0XLJoTBQ5xOjNpdcNEPfnrFYRTNBW4NJq+8WLaA==
X-Received: by 2002:a05:600c:1e28:b0:413:2e8b:ecd with SMTP id ay40-20020a05600c1e2800b004132e8b0ecdmr945167wmb.19.1710169604416;
        Mon, 11 Mar 2024 08:06:44 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id p15-20020a05600c468f00b00413011933e6sm9477766wmo.39.2024.03.11.08.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 08:06:44 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 11 Mar 2024 16:06:36 +0100
Subject: [PATCH] clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018 to
 fix boot failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240311-apss-ipq-pll-ipq5018-hang-v1-1-8ed42b7a904d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPsd72UC/x2MSwqAMAwFryJZG2i0fq8iLopGDYjWBkQQ7251N
 QzMezcoB2GFNrkh8Ckq+xaF0gSGxW0zo4zRITOZNTkROq+K4g/06/qxMFTjV2Jlx8bVk60oLyH
 ufeBJrv+765/nBZC/M75rAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

Booting v6.8 results in a hang on various IPQ5018 based boards.
Investigating the problem showed that the hang happens when the
clk_alpha_pll_stromer_plus_set_rate() function tries to write
into the PLL_MODE register of the APSS PLL.

Checking the downstream code revealed that it uses [1] stromer
specific operations for IPQ5018, whereas in the current code
the stromer plus specific operations are used.

The ops in the 'ipq_pll_stromer_plus' clock definition can't be
changed since that is needed for IPQ5332, so add a new alpha pll
clock declaration which uses the correct stromer ops and use this
new clock for IPQ5018 to avoid the boot failure.

1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4/drivers/clk/qcom/apss-ipq5018.c#L67

Cc: stable@vger.kernel.org
Fixes: 50492f929486 ("clk: qcom: apss-ipq-pll: add support for IPQ5018")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Based on v6.8.
---
 drivers/clk/qcom/apss-ipq-pll.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index 678b805f13d45..11f1ae59438f7 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -55,6 +55,24 @@ static struct clk_alpha_pll ipq_pll_huayra = {
 	},
 };
 
+static struct clk_alpha_pll ipq_pll_stromer = {
+	.offset = 0x0,
+	.regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
+	.flags = SUPPORTS_DYNAMIC_UPDATE,
+	.clkr = {
+		.enable_reg = 0x0,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "a53pll",
+			.parent_data = &(const struct clk_parent_data) {
+				.fw_name = "xo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_stromer_ops,
+		},
+	},
+};
+
 static struct clk_alpha_pll ipq_pll_stromer_plus = {
 	.offset = 0x0,
 	.regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
@@ -145,7 +163,7 @@ struct apss_pll_data {
 
 static const struct apss_pll_data ipq5018_pll_data = {
 	.pll_type = CLK_ALPHA_PLL_TYPE_STROMER_PLUS,
-	.pll = &ipq_pll_stromer_plus,
+	.pll = &ipq_pll_stromer,
 	.pll_config = &ipq5018_pll_config,
 };
 

---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240311-apss-ipq-pll-ipq5018-hang-74d9a8f47136

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


