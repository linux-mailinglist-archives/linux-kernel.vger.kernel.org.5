Return-Path: <linux-kernel+bounces-61941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170468518B8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C648B21122
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985513D397;
	Mon, 12 Feb 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WIFTB655"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFEF3D0B5
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754256; cv=none; b=STi0IdeSUv8JKq0uxUH9lOjiebMsjROAwRwz+BiGp0JaUHmL0u4RQqkcoiTEQ/1PuAkk7KqA+YGCWKaLLTIQQdKsxMjBkI4FUw2eYznR4cwaxvhbnVFpRCAHCmtSJBB2qOvS8PXwb7UzK7JUqRnQ0jjV2hcbflDZR5UvMvIjA3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754256; c=relaxed/simple;
	bh=b0wLfJlVaSUQG2JbwKmhWZbUkd5VW0gCuAeGx3m+/KQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hFnJ8RYAGo1qr8dOFNusTv3mJHQ5MRXkYh3xU6aPdXcPb0hrcwCc9mLZ7xInHQXzIH5keqbTvdstqRR9SC0RWfjk2+usieDMY1Lj2OFxwWNyDQVKsak+TVWloG25sb1QqP/lUbvsuwk4Hwmq6O7+6p/9nuRg18hGYa/YZDkyTB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WIFTB655; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-560e9c7a094so4481293a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707754253; x=1708359053; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFqSVVUmRROOSX2ZQ6G0l4YngA0gkWhF6F+ZryO0iBE=;
        b=WIFTB655PY9+OHxd0N2MTXvI+YIx+ppF08wDHQq+egDzm4O9pmLYKk90K0hDrPr53m
         fBKCy/iAxGRmryYJoSJvNYk5oeDMIx4xZ5H528q+ket8JECYYsG3pT4kmp5VEl/5eZq7
         FH/p5Fud6zmkyJf8P1YKcXhJQyPmBO2JM8IDasigsemkZU6nxUHR0LxKAhQb8YyxVfgW
         csiSQkxLFAKZl+rdON6mRSqpbBLkfnk1vIIX2D7Krt1JSFh3E4gJdO0W5+k3F+3OYGB0
         vbqagL8ev4EDEzL+TIpML+mxEp8id1BjPE2zEspmsn7EhUZVNXu/cW64VFT0lF4zTHeS
         /RAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707754253; x=1708359053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFqSVVUmRROOSX2ZQ6G0l4YngA0gkWhF6F+ZryO0iBE=;
        b=nX43XmBzLqYEsCpflAs9DbsIdvFLoTHkZ3USDT0R0GyNyZPQNheEFDkpMGfWRfxjoX
         8a0EC8GzQLl7hTh/5xXSJpDc35QVA8fSNeEipDvG7QBV10q6PZCox+wPH0rQYHppAMez
         hyyEhtfMPqQ59doSmmXIlXgbzyuP5JE/cEWj4i/ZXGUxzHWcSsGlmBxX57YfndykNpgz
         8j4rN/OG4Gmas/IDp4W6Wm+gWpv2I9MAZ6ec67bmEoGr/EsANM0O0GyDlFj2hds3CB5U
         PO3NpO6Z1ARus8RoLYbamFefBX+Z+Hi3np6fCnNXLCCW4RhgaT02Xfopd0qsFBuEl4X/
         TnYg==
X-Gm-Message-State: AOJu0Yxj89LVQJVLpRd/RvexIKeUbh9tx78lMkhLmp8AilonUwUhIsB9
	EOY320z0Oxx+wF9jUTV31zvU7oJzxrNtCQc3kokI8GJk8NKimoodqny/zQjv5tY=
X-Google-Smtp-Source: AGHT+IHOsNDvpwvn/lpRUTluZS4sscHMpEIH9qAkgM4T7veSl8FsWfJ90mj0/Dl+EKGXa0XWU2gfng==
X-Received: by 2002:a17:906:f88c:b0:a3c:8770:3795 with SMTP id lg12-20020a170906f88c00b00a3c87703795mr2597216ejb.15.1707754253309;
        Mon, 12 Feb 2024 08:10:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXluE+PhBHOqFAxLPsZBEfTgG/XwINOj7tDDo+v7S31xcuZchzNNnTcZfgbxPSpjFS7KVNBfqiQGWCYam1anaMj6emAD8LZdDdXkPS7QSnybIjAVqlxjQsyqznhIU+c5lsv+/V0Vgz82g/H5ZLrnhDSU/S2wqQtpYZ9IcLDLD8ulOTSYfPohaDdk0GXeY2OmoV8NiiXH99igvCffLmjqtZt6+n1Pj35J2BnPJhy94tZGUCeQAkvqdvnB0TKeY3KyNzY0IKo5ZelgrPMpr7KaXeIhsp00BTPazTagoW4iyqED9SzIb3UyeSOwk81VPsUq35rx8MowDPaOK6pArv0oSCh
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id n7-20020a170906118700b00a3845a75eb7sm336246eja.189.2024.02.12.08.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:10:53 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 12 Feb 2024 17:10:46 +0100
Subject: [PATCH v7 1/2] clk: qcom: branch: Add a helper for setting the
 enable bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-topic-clk_branch_en-v7-1-5b79eb7278b2@linaro.org>
References: <20240212-topic-clk_branch_en-v7-0-5b79eb7278b2@linaro.org>
In-Reply-To: <20240212-topic-clk_branch_en-v7-0-5b79eb7278b2@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707754250; l=1404;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=b0wLfJlVaSUQG2JbwKmhWZbUkd5VW0gCuAeGx3m+/KQ=;
 b=YG/7NUziS4cLbLZKnjfCVh8PWY/engmAeD3WJiKsrfxEzniHJSiOOGADP/Y3eqGkv617/SxTg
 We79mvHoTu8A++0SMGZ4fzoUYqJVrIMGF60yra386fXl6eA41DbaUp7
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

We hardcode some clocks to be always-on, as they're essential to the
functioning of the SoC / some peripherals. Add a helper to do so
to make the writes less magic.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-branch.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
index 8ffed603c050..f1b3b635ff32 100644
--- a/drivers/clk/qcom/clk-branch.h
+++ b/drivers/clk/qcom/clk-branch.h
@@ -64,6 +64,7 @@ struct clk_mem_branch {
 #define CBCR_FORCE_MEM_PERIPH_OFF	BIT(12)
 #define CBCR_WAKEUP			GENMASK(11, 8)
 #define CBCR_SLEEP			GENMASK(7, 4)
+#define CBCR_CLOCK_ENABLE		BIT(0)
 
 static inline void qcom_branch_set_force_mem_core(struct regmap *regmap,
 						  struct clk_branch clk, bool on)
@@ -98,6 +99,11 @@ static inline void qcom_branch_set_sleep(struct regmap *regmap, struct clk_branc
 			   FIELD_PREP(CBCR_SLEEP, val));
 }
 
+static inline void qcom_branch_set_clk_en(struct regmap *regmap, u32 cbcr)
+{
+	regmap_update_bits(regmap, cbcr, CBCR_CLOCK_ENABLE, CBCR_CLOCK_ENABLE);
+}
+
 extern const struct clk_ops clk_branch_ops;
 extern const struct clk_ops clk_branch2_ops;
 extern const struct clk_ops clk_branch_simple_ops;

-- 
2.43.1


