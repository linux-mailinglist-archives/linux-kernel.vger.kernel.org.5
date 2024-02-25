Return-Path: <linux-kernel+bounces-80226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDAC862C4B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9A61F21AA7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0F51B597;
	Sun, 25 Feb 2024 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9jzupH8"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A584E17C7F;
	Sun, 25 Feb 2024 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708882399; cv=none; b=ntDqskW59NPL7LLDbArsw8pLT0H7PJuR1STzU+FF0yQcTZ20oNOgaNY6SinXgBsMNF47NNngoVCB1XYLxQg38D6lJOn0ACBuuIt2rwxC3SkHSk+z9yZlQQKBAE/1bEz6u156XsC3TYLRP3Fd7E5XwQdc8ss1qIc2gzo8RsaaU1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708882399; c=relaxed/simple;
	bh=BgSFijZKhA2ufG2qmUVQ6xxgoG3VAnT3dyE2UsJjYvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sFC3tCySr3AHDXrd0F4Z0NYyCruZA3vcZYF/6bR8MA+TcN7I5yhmTU2OEOMn8Vmp+d9g6N28lZQqh9kGTViba543g7He4qgeQmkAgnR22og/l6z7oULkOcifZYJuxvYdiQ4xPS2UD1355Xeoen+7JYgXN1jpGqv/M5DXywoEHoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9jzupH8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3d01a9a9a2so248474566b.1;
        Sun, 25 Feb 2024 09:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708882396; x=1709487196; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EuE43dLqTxHSUlJvt5Y7Dme+S2ucf6kxW2kDutXSIZw=;
        b=E9jzupH8COfAB6GHsU++aF2NoY5/UW/DjshtQfgF8LcSUUeZo1m7s3Si93NFOqRFR7
         Z7zp3BFjEzhrbw37wc0PnwxcDGg5YwB3p4O19/jJdqYCJdphJRfgGRsqZBxs2aSuwIND
         CLHxYOqKxeeg0iDzkAXuTGz+BeWJ0RwmNJnmHkEze27hv+osuFW/ZfLZRvP8Sdimyasq
         VTie0K+UV1eIBfxGqrojCIkljGy/GGDOP3lJFLQHe/E5B/V7HH3n3te/F2Je18Gf3uRt
         uxgUNDmSJFwpfEiAcixn4tucofmkO0x7DgTcZkrV6ZRUQz+wtUH7iCA6ohcTFPPH2fh/
         BSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708882396; x=1709487196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuE43dLqTxHSUlJvt5Y7Dme+S2ucf6kxW2kDutXSIZw=;
        b=gLRwaFcGIrZB01SyhHp0bTQG6mcBhXft4Xlm//JNQ7YNJQIDRTt6RGq1LPTrU8yahR
         u1Kq8MwWvgxKKZp+dU5KJLkJFGGxCFrWlINOJFU/dUBttn0RBQTEqulBAErj+K0AFARs
         ZhR307YWyXhPA9E/aw7RpGb10v+BE+hlwrmyM5pAe74ylU0DlXacB7xKWVJlxFDRE96/
         dNOSapSeZST3cm0uc9fwe6pkrdelpNOtOoR4I9U3kxph5We0iA1NfVo12Rtc6KKliMKO
         KtXuGQG0LofUwQ8XtHcKZMjzJlj3YjtFiLob4jTr/GkTE0Wi9V4x40lL4gf/nE6HO2qg
         S2+w==
X-Forwarded-Encrypted: i=1; AJvYcCV9np+7wQ2QnpiYp6H5wcKJsHMKNe/4O94g9BbiVt8s6+vWYwoxgqVlnRqy7KcnpZlELiBwJnBYasA8rydeZrvB/vGo5ycY1/uC0TRn2YrmvWVGL3+TQGeNBjS9DqkCXgPGRjczlEJQ
X-Gm-Message-State: AOJu0YwZGspOL5r1YbzbmZA3gqxYjmvP4G/fM36+Davye8MXE4UhvljE
	iBSzrc+9SvXxG+Fn1IzJERemO1/TwRhGL1nDgFI7YqgWqZ6u5Yuq
X-Google-Smtp-Source: AGHT+IGIpqOBt7fQjwIMj081kucds8Wp+cwRdl8dbWAwFNJPtz929Q1DLouOmc3Nz7Isc8b18o/Ctw==
X-Received: by 2002:a17:906:558:b0:a43:2418:2ab5 with SMTP id k24-20020a170906055800b00a4324182ab5mr1020247eja.60.1708882395871;
        Sun, 25 Feb 2024 09:33:15 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id cw16-20020a170907161000b00a4306ac853fsm1182007ejd.206.2024.02.25.09.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 09:33:15 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Sun, 25 Feb 2024 18:32:54 +0100
Subject: [PATCH 1/3] clk: qcom: gcc-ipq5018: fix 'enable_reg' offset of
 'gcc_gmac0_sys_clk'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240225-gcc-ipq5018-register-fixes-v1-1-3c191404d9f0@gmail.com>
References: <20240225-gcc-ipq5018-register-fixes-v1-0-3c191404d9f0@gmail.com>
In-Reply-To: <20240225-gcc-ipq5018-register-fixes-v1-0-3c191404d9f0@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

The value of the 'enable_reg' field in the 'gcc_gmac0_sys_clk'
clock definition seems wrong as it is greater than the
'max_register' value defined in the regmap configuration.
Additionally, all other gmac specific branch clock definitions
within the driver uses the same value both for the 'enable_reg'
and for the 'halt_reg' fields.

Due to the lack of documentation the correct value is not known.
Looking into the downstream driver does not help either, as that
uses the same (presumably wrong) value [1].

Nevertheless, change the 'enable_reg' field of 'gcc_gmac0_sys_clk'
to use the value from the 'halt_reg' field so it follows the pattern
used in other gmac clock definitions. The change is based on the
assumption that the register layout of this clock is the same
as the other gmac clocks.

1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r4/drivers/clk/qcom/gcc-ipq5018.c?ref_type=heads#L1889

Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/clk/qcom/gcc-ipq5018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
index 4aba47e8700d2..cef9a1e7c9fdb 100644
--- a/drivers/clk/qcom/gcc-ipq5018.c
+++ b/drivers/clk/qcom/gcc-ipq5018.c
@@ -1754,7 +1754,7 @@ static struct clk_branch gcc_gmac0_sys_clk = {
 	.halt_check = BRANCH_HALT_DELAY,
 	.halt_bit = 31,
 	.clkr = {
-		.enable_reg = 0x683190,
+		.enable_reg = 0x68190,
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data) {
 			.name = "gcc_gmac0_sys_clk",

-- 
2.43.2


