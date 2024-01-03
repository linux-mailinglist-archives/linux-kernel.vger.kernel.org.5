Return-Path: <linux-kernel+bounces-15969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1693F823675
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A564D284801
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817511D541;
	Wed,  3 Jan 2024 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SUHljg8X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E50E1D522
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so1316741a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 12:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704313233; x=1704918033; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k4tbVTuBseaOKe6F2sTtNlV91d7o5NJbIEDEdAscPJY=;
        b=SUHljg8Xu5t0qPZOLOtvh1AbJ9YjzY8qtrqVOxQ98KU4eSvn2RFSQmomU87up7AsNu
         /SluexvlNFlUZKos5putj7CSXaC3pGtihIu5okxsBlMfiLjvWWJ3C+x2Q9no07RD4UTR
         v+ukp5hSXWjf34YCQEKbhIjw6TW4F5OCXCcutnzprLqD9eLHmmbIZsUmnV1qdHdf/emj
         yE5UPuuVbKCSCcGeL24+ykGSOHADO2zz2WhxQOIurTjLilZkgxMEvrgBMRvOdXKsZcKV
         0w517u13Zl/wUni76RM56JXzi4ZtL43PjnHCy8H2uE6Y5WNw4XpdfqNss/knooXC8Lri
         enIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704313233; x=1704918033;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4tbVTuBseaOKe6F2sTtNlV91d7o5NJbIEDEdAscPJY=;
        b=kAnVDThqMT5Ak2MBoPhQDEnAOJYNYBxLeow9zwORipcP9hhI9kao82fybZJ/u70rM9
         zLm7ARIBrqOC0HKXUMEFsjkxKVheuwJUcG+ygUtWs1fE9Enl9FkGg6Qnr8Vlkm/1V5UU
         S9Zs8xpyOk2OTHd1jqotqU+niCiiHRMA0loectko1gy+V4wtZVQapOf0LyuWDQsc6cnC
         1LgmUKIDQEHOCY09LdMMyuVqc3NzneAzCW8kzjKcdV3WOirqOfxoCX3uQjxoPXNl8cJW
         5rI41djD13Vy0qT39BL3aV4SXZCba4ChgRHIK8FfIOVR4C5O8Ua9zFRbKfOuu0hvi07/
         R6NQ==
X-Gm-Message-State: AOJu0YyyQQAmMuPzELi4COjVmjcIcIXiOl5CpkJnbaFkQE0yLmSEA61x
	FpBrchSROgG1vltnul8z7SSQgHqjFIcj2A==
X-Google-Smtp-Source: AGHT+IG7kp79wvHon1BZ74lJ9hHWzPd/UXnExJPnn5O4ULK5QPUSOZIiED8lwk8n4mRkQEh0WyHV4A==
X-Received: by 2002:a17:906:b103:b0:a28:46fe:77f1 with SMTP id u3-20020a170906b10300b00a2846fe77f1mr1147886ejy.179.1704313233637;
        Wed, 03 Jan 2024 12:20:33 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090629cf00b00a26af6e4604sm12143136eje.107.2024.01.03.12.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:20:33 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 03 Jan 2024 21:20:18 +0100
Subject: [PATCH] clk: qcom: dispcc-sdm845: Adjust internal GDSC wait times
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-topic-845gdsc-v1-1-368efbe1a61d@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIHBlWUC/x2N0QqDMAwAf0XyvECrLcz9ythDm0YNSJVmjoH47
 wt7vIPjTlBuwgqP7oTGH1HZqoG/dUBLqjOjFGPoXR+cdwO+t10I7yHORQkzlbHEME4+DmBNTsq
 YW6q0WFWPdTW5N57k+588X9f1A4n/lZR0AAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704313232; l=944;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=5toqP0lFGtj9eNNbeiZrB9TS1y8+JkIhCriQKhK2LUk=;
 b=ayQoYDpiVHvtozAgvHKomd7CluAQM7F94qyU8j7sy+4nrpzsXjPt/ujoyuxJrGSHwDDQC1mVt
 8NksIbLJ9CTDO1iUdff+iznJOuCKAIPlzBfE9u5l41ncxcBOXXjEzxH
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

SDM845 downstream uses non-default values for GDSC internal waits.
Program them accordingly to avoid surprises.

Fixes: 81351776c9fb ("clk: qcom: Add display clock controller driver for SDM845")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/dispcc-sdm845.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-sdm845.c
index 735adfefc379..e792e0b130d3 100644
--- a/drivers/clk/qcom/dispcc-sdm845.c
+++ b/drivers/clk/qcom/dispcc-sdm845.c
@@ -759,6 +759,8 @@ static struct clk_branch disp_cc_mdss_vsync_clk = {
 
 static struct gdsc mdss_gdsc = {
 	.gdscr = 0x3000,
+	.en_few_wait_val = 0x6,
+	.en_rest_wait_val = 0x5,
 	.pd = {
 		.name = "mdss_gdsc",
 	},

---
base-commit: 0fef202ac2f8e6d9ad21aead648278f1226b9053
change-id: 20240103-topic-845gdsc-bcd9d549f153

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


