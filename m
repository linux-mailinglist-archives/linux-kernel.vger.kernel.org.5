Return-Path: <linux-kernel+bounces-109823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D7988561E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8756728253D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54A63B2A8;
	Thu, 21 Mar 2024 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9F5l2CB"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9BB2837F;
	Thu, 21 Mar 2024 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711011556; cv=none; b=lDpEWdn/OpqPIrbvDU7uQZYEZmn8ndkr8hOkr5a7CF8Y9j5ttG1tX54skLu6kaByI4oP++clbnp18+sv71jSug0fATWfRMNV+J7mUFbaTnVe0Ynh/aav/hQEre3NegJPT9FzngrdZ/b7o0jx6S/cmbTapu/nkyM5zIpTpx7BqRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711011556; c=relaxed/simple;
	bh=NxDbZYgwH4jpjVelX1PrNVvVGA+QrJ3WUXZ1vKbEGXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qBlLArkDQQyhV/zlu1TqQJlF6G54lhPUKl/l3dE0o8JeMr0FDhCfY4gB8O3SHir1/0l9tGf6nFrtEsQMZMS9bOZ/Mogd9ZJ7uCr0xmIL9d70WtLCEr75WxhvTOF3u9Xjf/1Xt3R+2TJv1xv/PUxJI/uGhL3UdxlZp4/xbnE7ds4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9F5l2CB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46a7208eedso99928966b.0;
        Thu, 21 Mar 2024 01:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711011552; x=1711616352; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=50OqpzaNnJv0r4pTaChj38doMx6VdmtBy+/lDzIFTC4=;
        b=f9F5l2CB1TfcWEV4vZpYl1ojSdvlHOY4qcMY4F5nHeoxCIfIF34FbbZZ3lQTHVmsOl
         pxSfJyVS+bDIB9pnOlHwqlpb8lYF2zgR4nT0Zv91cSxfFTMZVGMozItIZTZH1TKG7/A7
         vpiixKafoLNt7RnThQmiLp1IFz/YQtggkayZrgg6jgffAwYjl3QyL76yAdd1XHYFq3+1
         pdpsaxG9jWZ93C3c/AWsffsMLTg+K+00GwaFU2CS/l3ReayEUyJaa4tLey8Iifv0oXuu
         g+oobw45r1kgPfIDlFwkQC0RG7if3ybXIVsnl/vPNaIczsALE6oRkQ91JB5f9YWL2NQU
         1a1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711011552; x=1711616352;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50OqpzaNnJv0r4pTaChj38doMx6VdmtBy+/lDzIFTC4=;
        b=DcTn3nUhgLen8jkqudG3UMjOCzkBJppYwXf9sq+4O1XaW6ttVVRR+V7RRMbXQWAWtp
         NTwQCGejaQsB8KAkmZ8kCpe7tI6mEgq/a39T2rktf46hDYWr3GwOJf7krKqiB7M0LlRi
         empeVctTlNxDyzO14IGTcW6cxCJ/o4SBQ3GFAAR+J/CJukhQW3KGWZdSFWikp0ih2TLM
         +k1x3Qpn/hHQyOVVZX4FpVO9fIUMIhzxiFqzVKa6ux3alVz9QJeKtptk0XcmpUPYT1nP
         3xMeoK4IVw5ym/w4fkdxEiI9wETf25N0x3ssKC92lpY0MrnL8f+nOYMJCR6fdvxzXzbt
         AoYg==
X-Forwarded-Encrypted: i=1; AJvYcCUsRjJHjaoLk1jcdheuOy90RJ+zk2OaC2w752LgE2A8KEjIctYzbdgIc9Z2GXub4K1T9xqt4MAbPnvsU6PGBV/DLVacq8tmbtj3Zn/5Nr+vDpCO8NhUdGgLPFhcaJr2SAQXO4l9L1fc
X-Gm-Message-State: AOJu0YwRw92ncdivZ5dUG+mcNfiERlvDoUWpRSFwHO2S833Xd7HrCvAk
	U9tFT+8WOy/tLzKdgcTgE+vZvDSY+xCpaTy6oFv2KWlYHwpToZU+
X-Google-Smtp-Source: AGHT+IHjSN1AJpIAG2e3sSoLMC5C2Cu5XoiqPCD4u42ssn18L9uLH9vYrvcZXsC4XrZGDxmYoknfRw==
X-Received: by 2002:a17:907:3594:b0:a44:e34a:792f with SMTP id ao20-20020a170907359400b00a44e34a792fmr12557655ejc.15.1711011552419;
        Thu, 21 Mar 2024 01:59:12 -0700 (PDT)
Received: from [192.168.1.253] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id af3-20020a170906998300b00a469604c464sm6719582ejc.160.2024.03.21.01.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 01:59:11 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 21 Mar 2024 09:59:04 +0100
Subject: [PATCH] clk: qcom: clk-alpha-pll: fix kerneldoc of struct
 clk_alpha_pll
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-alpha-pll-kerneldoc-v1-1-0d76926b72c3@gmail.com>
X-B4-Tracking: v=1; b=H4sIANf2+2UC/x3MQQqAIBBA0avErBuY1Iq6SrSQGmtITBQiiO6et
 HyL/x/InIQzjNUDiS/JcoaCpq5g2W3YGGUtBkXKkFYNWh93i9F7PDgF9uu5oOtb6oi0MUMLpYy
 Jndz/dZrf9wNx68ONZQAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

Add missing descriptions of the 'num_vco' and 'flags' members to
clk_alpha_pll structure's documentation. Also reorder the member
description entries to match the order of the declarations.

Eliminates the following warnings:
  drivers/clk/qcom/clk-alpha-pll.h:72: info: Scanning doc for struct clk_alpha_pll
  drivers/clk/qcom/clk-alpha-pll.h:91: warning: Function parameter or struct member 'num_vco' not described in 'clk_alpha_pll'
  drivers/clk/qcom/clk-alpha-pll.h:91: warning: Function parameter or struct member 'flags' not described in 'clk_alpha_pll'

No functional changes.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Based on v6.8.
---
 drivers/clk/qcom/clk-alpha-pll.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index a1a75bb12fe88..19717246c8b6e 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -71,8 +71,10 @@ struct pll_vco {
 /**
  * struct clk_alpha_pll - phase locked loop (PLL)
  * @offset: base address of registers
- * @vco_table: array of VCO settings
  * @regs: alpha pll register map (see @clk_alpha_pll_regs)
+ * @vco_table: array of VCO settings
+ * @num_vco: number of VCO settings in @vco_table
+ * @flags: bitmask to indicate features supported by the hardware
  * @clkr: regmap clock handle
  */
 struct clk_alpha_pll {

---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240321-alpha-pll-kerneldoc-f75060034495

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


