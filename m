Return-Path: <linux-kernel+bounces-55478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C6F84BD30
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D88F1F26454
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B111B941;
	Tue,  6 Feb 2024 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HMZonAVv"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7301B27D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245036; cv=none; b=chvdq1nk3akrHSfwq4tsg/zu/W8ENiBdS3uaioK1YQFYMR75xNjyKrhxGAwOSrjozUpa9o1WKnaXmbCHCimC6dnrRAWWDZjrPRLfb3ht6BA2fnb6YHCfBL4SUi0DB5yywRXyRayp2WDB7BT66B+m98pJh3KknK7RZpv0I4+owYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245036; c=relaxed/simple;
	bh=Um3XHTCPqPzKjXY4QlaL0lzOw9Adn3IKIs6tquKWAGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LdMk+VLCTpIJVyg+YDGp7+/yRUPMfCp3GHXC3h7IURB881ZgU83UwhmlA3qOC20cFDtfnVQxPqfu3H9W1NwG/3vkuT8E5WFGFdm514JTSqRGwVmx/kd+b5aVxqtHTOgTlQC5fUh84Z1MPhe2HXfXkfhcAq0qq791FM9niu0YYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HMZonAVv; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a380a1fa56fso171158966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 10:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707245033; x=1707849833; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sx2jWOy3+mcft3g2k461xAsra2Zzmr6pjNDzJKoJgMQ=;
        b=HMZonAVvSxziRwXXY2E77c9gtJKwpXLP48NaGhCN7hA0onOURTAN/QeNJm7l1ddRgD
         6Clj3GNKFBkxJVmCZ7HX0biBdWQmstEgCSrF6WM84OT+1Tt5WyyGqmcEeVApUUbDJ+je
         rBMAj0qjSkS1xD3WJZKhudwGKtI35Y6in1TlRonDyMj7VZt5HXhMSGbSsOotsrzKDpdX
         OOucltMXx5/qy6cmSw6UX98kzU4XXWfTnuzD0fX/bTMtKIZf0sJmAHstNjfSyCNMLsjM
         zRGXruXzhMuW7pb55yCuGzOzDXnlunghr/q1eURriMdkGKDuNnutJx0PJx5sAgtO6H/4
         Xx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707245033; x=1707849833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sx2jWOy3+mcft3g2k461xAsra2Zzmr6pjNDzJKoJgMQ=;
        b=APTKaUcfuaHatr+Y7qff3MpvO9D692tlRxFJGjKm+bhpyKf9QquL7eCZOeKxSo4aPO
         iDSObrbR8BGo6J911AaNOtgt0EKh7gwRANNtU6a0kVJdYH4KdEeX+EzWLqcrGrOJzbIH
         b4cbCZjrOnNbQ8xosFxkKk/0e9FGmOuucJBrRQfTsBiCPi2uwtT+BilFe36JDtvXRw4W
         u30aAAT/TjqRZk7yiUOdaf2i+Q+UXh4ND+tz2BfE1SNcqiuExwsoUWyWQeyhtkoQ+lKM
         6rlFgutEGqdwuU8QKYboOhtPlKK62OwulNdBIPFFpSUrBlye43lLMf8YNdyAbCZvBSGt
         whUA==
X-Gm-Message-State: AOJu0Ywt9+LR9g8kMuGS5Kv5YmKa3ELy0EkUPQ2+O0vLuEnfuU4cl7qv
	6VodwAptducHLkpxo2Ql+yfCVB/lllfWgmaM59mIm7uSwBHmGx0ZaoggiDAkB+Mrb7XELi/JM8t
	w
X-Google-Smtp-Source: AGHT+IHdgIMDLE+qw3jwrHAaomcUMXOC4b2jvJ1Pc5h7C6eE7EE+S7xI2quLCslWdMEmJbGAs3+Usg==
X-Received: by 2002:a17:906:4e8b:b0:a37:687:275c with SMTP id v11-20020a1709064e8b00b00a370687275cmr3895790eju.20.1707245033098;
        Tue, 06 Feb 2024 10:43:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWf0xsvKto8gDTOhhkvQRLi+YvCUaDUUyZbwlbZTXzQ8pksP0S6iOjf7HSmedSdJerkcvnapbXfIgNEQD2dzCLKV3Q1IjjCemsiuN5p56++qSGgNmQEjffa4dNgdP4ACUDSTG+jm8g87jmkHTNy9qYiJHn9/FNgXvXQVr8/rx3L3Jfd/o0sgzur5xLR0mfmNeV9NdLSWaGXSU1FKbLBJoyn2Ekk9jpYgRfgWZDOj2O4tfrDOt9nTwCG6VjcHZl9OXe7DFeQirdiji2YSGJc1gIsgGBYfwWmc8jSnoUWU80RD6EfQppGNXUEaPK1A1tMJksq9tNYK8R4yrel8uEY+POcoZcUmVCv/BNUEIEhPCHFVemqS+M1LRdeoem8CuK2xIfPF94WTc3sByFGNDcfM8/SUmt2xOxxImStOsFbG7uLEFo0fF7gXKzPrXj8gB3XbXbP1yLHeL8M
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id un9-20020a170907cb8900b00a384365e3b9sm562305ejc.195.2024.02.06.10.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 10:43:52 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 06 Feb 2024 19:43:42 +0100
Subject: [PATCH v2 09/18] clk: qcom: gcc-sm8250: Set delay for Venus CLK
 resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-topic-venus_reset-v2-9-c37eba13b5ce@linaro.org>
References: <20240105-topic-venus_reset-v2-0-c37eba13b5ce@linaro.org>
In-Reply-To: <20240105-topic-venus_reset-v2-0-c37eba13b5ce@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707245017; l=1210;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Um3XHTCPqPzKjXY4QlaL0lzOw9Adn3IKIs6tquKWAGg=;
 b=V/zN5DGxKHRNUqW9xIcpmoQbVyk8TUrsM4Bgad0H4xzD6h7GzxAQn+4hIs0phzgj6rlmWZ0lo
 PAG4qSv/eiqBe/BhYdE93BqftCEUl87uipHK2YVu2f+fyyqH44SPhlT
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some Venus resets may require more time when toggling. Describe that.

The value was obtained by referencing the msm-4.19 driver, which uses a
single value for all platforms [1].

[1] https://git.codelinaro.org/clo/la/platform/vendor/opensource/video-driver/-/blob/LA.UM.9.15.c26/msm/vidc/hfi_common.c?ref_type=heads#L3662-3663
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sm8250.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8250.c b/drivers/clk/qcom/gcc-sm8250.c
index c6c5261264f1..61d01d4c379b 100644
--- a/drivers/clk/qcom/gcc-sm8250.c
+++ b/drivers/clk/qcom/gcc-sm8250.c
@@ -3576,8 +3576,8 @@ static const struct qcom_reset_map gcc_sm8250_resets[] = {
 	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
 	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x50010 },
 	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
-	[GCC_VIDEO_AXI0_CLK_ARES] = { 0xb024, 2 },
-	[GCC_VIDEO_AXI1_CLK_ARES] = { 0xb028, 2 },
+	[GCC_VIDEO_AXI0_CLK_ARES] = { 0xb024, .bit = 2, .udelay = 150 },
+	[GCC_VIDEO_AXI1_CLK_ARES] = { 0xb028, .bit = 2, .udelay = 150 },
 };
 
 static const struct clk_rcg_dfs_data gcc_dfs_clocks[] = {

-- 
2.43.0


