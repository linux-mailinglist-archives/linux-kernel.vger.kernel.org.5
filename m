Return-Path: <linux-kernel+bounces-15591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E61822E86
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C951C21768
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D8F1A591;
	Wed,  3 Jan 2024 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IgvJB4hV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2703A19BDC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a271a28aeb4so660681766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 05:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704289021; x=1704893821; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfDCSXNar/0OypW7xIXC/SzvfN+SSQCc1nv247H/a24=;
        b=IgvJB4hVyHg3hf8XIM99RSVYOwlXZfk5qn3T/BwJuk6CeCupv890n2qKQn4ELULmcs
         nUGNfHEEVDRGQWpF6ysdnJCSkwmjlfQFaGyeilcqpeMf7b9a1vg8i4viJ2/R6D2Gk4KN
         NpM45rkW8lDXSJ+93um1cwn57l+1AYZQ+/I/UEIVdray/VdE9Mo8GPNafgPGKKLYGmtE
         U01MjvQLuRmIFKIdn3gQLIllgkg3GSQLpN+dJz/Lw0FIKI/6S1qFQhpo4f+NkYYI0vMV
         T4ACS9eEUQ/u7masbITeJDRJgWkekwCLrUAOLcF3yrxm58OOqKJk05vm4gr1XxFhbMqZ
         W3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704289021; x=1704893821;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfDCSXNar/0OypW7xIXC/SzvfN+SSQCc1nv247H/a24=;
        b=KhQDf2feg9prZrvahed/oFa2ReceWBB/dYB4feKa9+w6dLFDOgYwUC6I4vjYW3Dtms
         XIUr49pfXTnbgDfpvK8YZk9EcRowVepjGzrBTxF4p+4nZmsBKzyhlOhcnt5ktrlioMbD
         pC8ocATsgx2RiUwbJdG+9bVL3FvvXxhLauGzfGgpF0b/YeKTZ0SOaNOOvJOlz9Rf6z4l
         HwqlAxvV9Lh2Qfegf1ZD0qDDWv5CekKljTtHhj149okEoO6kueZkgJ7GU9BrSGCYHL4Z
         vbuo5bYXhecH6pv+wVugl1EW6gMWIwEjor3cpzNYsxqqHTt2N0O6/FzZQocJCHlqv7dx
         WjBQ==
X-Gm-Message-State: AOJu0YyLTr9LihoU3l0y1XKhJWUaZ7xoscuabxJIn62QYx+7sJxFS4TI
	Cd2kFhNVdBx+w5ggm4FiEjCeHvWKQOmG9w==
X-Google-Smtp-Source: AGHT+IHxiQuhkrSM0RX0P1zd4jMRtmlubvUGFuRkRDsJfTas5+F1IbZfHovp7xAyXzNb65nINVnfhw==
X-Received: by 2002:a17:906:8910:b0:a27:5343:d3e8 with SMTP id fr16-20020a170906891000b00a275343d3e8mr4661410ejc.97.1704289021333;
        Wed, 03 Jan 2024 05:37:01 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id cl2-20020a170906c4c200b00a275637e699sm6474351ejb.166.2024.01.03.05.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:37:01 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 03 Jan 2024 14:35:59 +0100
Subject: [PATCH v5 01/12] clk: qcom: branch: Add a helper for setting the
 enable bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v5-1-99942e6bf1ba@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v5-0-99942e6bf1ba@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v5-0-99942e6bf1ba@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704289018; l=1413;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Bhpm8sfSCBACZPHOO1eUmAv4id2tp/m4vWhfhP3T9EI=;
 b=hEZH4a69zyBqaQHiB5GodkQDXw08IHWnibGhlyALGGLFuAseNs0NvKha96pN6FJfWQb2xmkJL
 70H7xhOF6ikC2pE3knApl7HawF5a8QnHmPCx9eCtcxaXKpH2FNOuCJM
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

We hardcode some clocks to be always-on, as they're essential to the
functioning of the SoC / some peripherals. Add a helper to do so
to make the writes less magic.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-branch.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
index 8ffed603c050..0514bc43100b 100644
--- a/drivers/clk/qcom/clk-branch.h
+++ b/drivers/clk/qcom/clk-branch.h
@@ -64,6 +64,7 @@ struct clk_mem_branch {
 #define CBCR_FORCE_MEM_PERIPH_OFF	BIT(12)
 #define CBCR_WAKEUP			GENMASK(11, 8)
 #define CBCR_SLEEP			GENMASK(7, 4)
+#define CBCR_CLOCK_ENABLE		BIT(0)
 
 static inline void qcom_branch_set_force_mem_core(struct regmap *regmap,
 						  struct clk_branch clk, bool on)
@@ -98,6 +99,12 @@ static inline void qcom_branch_set_sleep(struct regmap *regmap, struct clk_branc
 			   FIELD_PREP(CBCR_SLEEP, val));
 }
 
+static inline void qcom_branch_set_clk_en(struct regmap *regmap, u32 cbcr)
+{
+	regmap_update_bits(regmap, cbcr, CBCR_CLOCK_ENABLE,
+			   CBCR_CLOCK_ENABLE);
+}
+
 extern const struct clk_ops clk_branch_ops;
 extern const struct clk_ops clk_branch2_ops;
 extern const struct clk_ops clk_branch_simple_ops;

-- 
2.43.0


