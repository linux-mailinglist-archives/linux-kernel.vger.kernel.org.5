Return-Path: <linux-kernel+bounces-80227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD8C862C4E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664C51F218FC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6A81B95A;
	Sun, 25 Feb 2024 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTSHE6E+"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635F018EB3;
	Sun, 25 Feb 2024 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708882401; cv=none; b=NAmmV8nPJdJ/C5cMfXXspdXha45tKNqiYXAmPgwO+AugpDHbOEsm9npxsAHGEYZkNRcZca5z+m+eNunIVy8SFL+Vo7dUTslXBwx3tr0Q8PjRORu5euHkaKf2Th5Nj+x4NscBXm/X7kjshoGqC+/LfX81xJFeco7pObK294Hjz2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708882401; c=relaxed/simple;
	bh=u13Abosjh0ga614pMN+V5dneBLpTZCOLofp1E7MVTPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gN7uzIb/ZyQB/dnAxKHw9iYx9G7d18pB/4QcgoATw6z5hDkpvOYY7vh6O/UWUCt+iNMlVGsU4kYNJ6q15YnVYZ67xRTSwI2aKmQP9kuTpRNiDuZth85nWUi1qpNNI7G9kx1USgcyl3MCBxTFfiepAGc/utRss7cJJWUwW+laJJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTSHE6E+; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so986247a12.1;
        Sun, 25 Feb 2024 09:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708882397; x=1709487197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u98TGKSGxMD5MBX7AoX+yh5eBYy610WHJxOYWlsyDu8=;
        b=CTSHE6E+atDbBAaTek/Et+y/D8x+ejXzMM4bzMo9S0tMyo1rxUlQr0Us2By9ICAf/3
         ZlC0t8b8gJNcq1G016YErXW07hBumDA/jNhKTHQp5NGRqJQusQaSC1iAt7cNJdzVTAF8
         ft2EvOaDcRhP+xNElCtxiPbc4lYQfDw4RYCf48A1Vdzatd8Nr52YYMtLTIm98E1oqhaU
         pxcOaugMva8UMVc88O/T29abmCkMf8GbMHCWXMiIraOkVd9FUCKCOVbDfvNXQbvDhP/k
         DN8+WDNoychVuiIfLdKMNkWdG2AAC5XbvlVgSVKsgYKYG02Yrjcux/Ag8p2m2T81rht7
         X5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708882397; x=1709487197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u98TGKSGxMD5MBX7AoX+yh5eBYy610WHJxOYWlsyDu8=;
        b=gsAVjBOaS61gIezdigNWIM1WwOeER49KjsB9UAESPos3gVLgcyO/A55qjkDSccbrN0
         YT4C8EQdXfrafb/PaGlJL4WlgEo92/Ua9qyoIXpkH43GiiWUl0Dpgq5raX7n+c5qRZSm
         Bij9FwkRhVIrCU/47aZLD54Nd+7DAKo7IHT0foy0fEZmN3+JlIXfFk5CYoQNZTjpy4DB
         G0T5JrbQpKN0fclxRqNCHVm/ApFw1ETPvK2GeDGLWrj+IMqJdTTXUyGfKsWk5wOhYpbm
         nVfeizWDJpx+V3ezcYa1j1AUlwfYkll7E1+sYB/dPFJ6hMwdLpRe+pDDr3jv1YfeYpPr
         o3Ug==
X-Forwarded-Encrypted: i=1; AJvYcCX8oumgwBicj7IjtKz2Lj1d7VgVn4PZd4S+WnQY8UTSSYpCMyFbPHn1ml22rHjluhLsi5OXh6wtXgwPQVFSbbdX/3itVAvMtnUzJUlJ+eGo744ICEIPC1Vu8LlbohNdnBnMXIO3PAAy
X-Gm-Message-State: AOJu0YwpF+PfL035sCocdDvziXOqs99jfXBKY1nfnRz+BYmgmllpAudq
	ckaseaDh+eoj61WeteRxzyNZeO75nsjgtgi2d7UBQQhByCHGXZv2
X-Google-Smtp-Source: AGHT+IF9xvmeRkngW8HgN9QJ8ja1/uQuYQMA3p+UHNLddikjuLZBWi9qZwv/pr+xVo9KTAeZAdQ17w==
X-Received: by 2002:a17:906:918:b0:a3f:ae09:5f8a with SMTP id i24-20020a170906091800b00a3fae095f8amr4367654ejd.14.1708882397499;
        Sun, 25 Feb 2024 09:33:17 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id cw16-20020a170907161000b00a4306ac853fsm1182007ejd.206.2024.02.25.09.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 09:33:16 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Sun, 25 Feb 2024 18:32:55 +0100
Subject: [PATCH 2/3] clk: qcom: gcc-ipq5018: fix 'halt_reg' offset of
 'gcc_pcie1_pipe_clk'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240225-gcc-ipq5018-register-fixes-v1-2-3c191404d9f0@gmail.com>
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

The following table shows the values of the 'halt_reg' and the
'enable_reg' fields from the pcie clocks defined in the current
driver:

  clock                        halt_reg    enable_reg

  gcc_pcie0_ahb_clk            0x75010     0x75010
  gcc_pcie0_aux_clk            0x75014     0x75014
  gcc_pcie0_axi_m_clk          0x75008     0x75008
  gcc_pcie0_axi_s_bridge_clk   0x75048     0x75048
  gcc_pcie0_axi_s_clk          0x7500c     0x7500c
  gcc_pcie0_pipe_clk           0x75018     0x75018

  gcc_pcie1_ahb_clk            0x76010     0x76010
  gcc_pcie1_aux_clk            0x76014     0x76014
  gcc_pcie1_axi_m_clk          0x76008     0x76008
  gcc_pcie1_axi_s_bridge_clk   0x76048     0x76048
  gcc_pcie1_axi_s_clk          0x7600c     0x7600c
  gcc_pcie1_pipe_clk                 8*    0x76018

Based on the table, it is quite likely that the pcie0 and the pci1
clocks are using the same register layout, however it seems that
the value of the 'halt_reg' field in the 'gcc_pcie1_pipe_clk' clock
is wrong.

In the downstream driver [1], the same '0x76018' value is used for
both the 'halt_reg' and for the 'enable_reg' fields of the
'gcc_pcie1_pipe_clk' clock.

Update the current driver to use the same value used downstream as
probably that is the correct value.

1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r4/drivers/clk/qcom/gcc-ipq5018.c?ref_type=heads#L2316

Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/clk/qcom/gcc-ipq5018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
index cef9a1e7c9fdb..5e81cfa77293a 100644
--- a/drivers/clk/qcom/gcc-ipq5018.c
+++ b/drivers/clk/qcom/gcc-ipq5018.c
@@ -2180,7 +2180,7 @@ static struct clk_branch gcc_pcie1_axi_s_clk = {
 };
 
 static struct clk_branch gcc_pcie1_pipe_clk = {
-	.halt_reg = 8,
+	.halt_reg = 0x76018,
 	.halt_check = BRANCH_HALT_DELAY,
 	.halt_bit = 31,
 	.clkr = {

-- 
2.43.2


