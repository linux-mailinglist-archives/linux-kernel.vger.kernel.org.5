Return-Path: <linux-kernel+bounces-122544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F09A88F93C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627051C2AC4F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AD050276;
	Thu, 28 Mar 2024 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtHr+Wsr"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528CC537E0;
	Thu, 28 Mar 2024 07:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612490; cv=none; b=N57xoxsTPP65lmTwxiMtFoptx3YHnPR0/kS/3B4B8FZGMOTBiXPMU6HfPNP7O6Vx7q9fqYHS9Xqul1rqp2ip6uspl8EKuBjz7ckKiMb09U/oLmOVgmrw2vdLSe6KsJBo9JAfU3jQU94ut4DpCfpa3IgmKXytaynh37x2dVuBlAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612490; c=relaxed/simple;
	bh=7TuQoMUJ6APooA15msUPA1QoRn2CnlT4blDuFPO0e+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=G7RsTgsVGmgTB8g2727+BBqfzUDURwy2lMEyxGd3RTCYxsdQbxsiZ/yMmFBa56W4HWTj7S8cJTctTcubxTpSkBMkinRGcVomBjKBmVQS+8kejE8PjVT0KND4Hwm805vdV/ue8Un2USOxMDw544UlXg00MPe6mQDFmAkiSz+CPdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtHr+Wsr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-415482307b0so1023405e9.0;
        Thu, 28 Mar 2024 00:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711612487; x=1712217287; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z/9k825Fqxzz9jmkn3nJFGHIDNvvQD/xvUg6iDj53dY=;
        b=gtHr+WsrSWA3TwdphK7gmjAqWeh6VER4m13wzcLh6z/zZJ4MbVmT6Eo7TEWHFfp1c5
         nU5khv7GGnyu/lYIBg5h3uzfKRgLsdgfVWg6w2YZ8DTzoUxqXG3umew/FCnUdtwdNsSg
         itValM0uX0VCix9FLXMg5JRbP8LUWBDvjNyjzukI+DwuzBes13K9ZopXZVAsnGzwN3M9
         bn+C1ekZFA9vgicGoBiY3wiJgNDn/NJJD6n8S2I0zjHqX/OOD9fZQfPobsXp7lcioboq
         Aj5dk6x+U+2UNhr50PrQ5ioyFNDyabNe+dWIQz4zMoZhqiQJmxU3NHys84wV5v4Qghig
         nXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612487; x=1712217287;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/9k825Fqxzz9jmkn3nJFGHIDNvvQD/xvUg6iDj53dY=;
        b=j9QSYyTb7c34ojK8UxcsTyiWHT5ziIs5H+A6bGwlPNSNUSedPkaQWKXyI28/IAtIRB
         BTCqD/ERgZUCBX4aNLVZvm8R3Dyc1sjfhXFtTkSJ/2FLvwN2O8uZ32WZRgwMi+5l0m6y
         xxxfRSceV8BMPmKQ/Oq4uort363tbH0BG73Tg+ypR+YWvfprqqk2t8HH2+wPwmfXsIDz
         E2mVnc/i1nqOxqnNSJd25YczLhK4tkBR1TiuZd7R/NPntN4SYEM78pOKVIvg4pus5Qd/
         Es8sMGrsAeHpOb6tdXvFQqfytrkXP4gkN64T8MIzOlf/hh2yWJqvc38RDPHxFMBvtoBQ
         0exg==
X-Forwarded-Encrypted: i=1; AJvYcCX+hrH2sjLeQ39KQkLmD3Bx1GzVS+E8DFsFRzXZugGGc2PMu9LCVTTUmRpH29yWJIDvK6NyUgikHrREMBpCQUMike+1cafBoeDfukjuImDcsXAD7leW6m2UAwN0dfK7Eh1/zZXJX5d2yk4nHJ+ifxq/q75zfP4QzRxqmuQGvvzV
X-Gm-Message-State: AOJu0YzUQtEOC8xWkWjq+9EAFyAv5SHEZoZkGr4HfQNdemkyC1wjbYXF
	JR0oYWmC3GTeUSFvQoIrOhQtTLn6yBpq/pLazc4UOZlFLAFfvSlqswBwG5bMn0k=
X-Google-Smtp-Source: AGHT+IHZs9twLePrVnJ1cVOtuujAwLRvaOgRuObZxlafswz4BIhH6CPle3cRX9DVemoO803NyyQIMg==
X-Received: by 2002:a05:600c:3505:b0:413:7f3:8d5 with SMTP id h5-20020a05600c350500b0041307f308d5mr2229096wmq.0.1711612486695;
        Thu, 28 Mar 2024 00:54:46 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id v12-20020a05600c470c00b004131310a29fsm1425083wmo.15.2024.03.28.00.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 00:54:46 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 28 Mar 2024 08:54:31 +0100
Subject: [PATCH v3] clk: qcom: clk-alpha-pll: fix rate setting for Stromer
 PLLs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-alpha-pll-fix-stromer-set-rate-v3-1-1b79714c78bc@gmail.com>
X-B4-Tracking: v=1; b=H4sIADYiBWYC/43NQQ6CMBCF4auYrh3TTgtFV97DuCg4QBOgpG0aD
 eHuFlbsdPlPJt9bWCBvKbDbaWGekg3WTTnk+cSa3kwdgX3lZshRcYkKzDD3BuZhgNa+IUTvRvI
 QKII3kUBplLqkElXLWUZmT/lvH3g8c/c2ROc/+14S2/VvOgkQIGVR81oUGsX13o3GDpfGjWyjE
 x658ieHmVOVoUqaVoumOnLrun4BROUC6hsBAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan R <quic_srichara@quicinc.com>, 
 Kathiravan T <quic_kathirav@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.13.0

The clk_alpha_pll_stromer_set_rate() function writes inproper
values into the ALPHA_VAL{,_U} registers which results in wrong
clock rates when the alpha value is used.

The broken behaviour can be seen on IPQ5018 for example, when
dynamic scaling sets the CPU frequency to 800000 KHz. In this
case the CPU cores are running only at 792031 KHz:

  # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
  800000
  # cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
  792031

This happens because the function ignores the fact that the alpha
value calculated by the alpha_pll_round_rate() function is only
32 bits wide which must be extended to 40 bits if it is used on
a hardware which supports 40 bits wide values.

Extend the clk_alpha_pll_stromer_set_rate() function to convert
the alpha value to 40 bits before wrinting that into the registers
in order to ensure that the hardware really uses the requested rate.

After the change the CPU frequency is correct:

  # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
  800000
  # cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
  800000

Cc: stable@vger.kernel.org
Fixes: e47a4f55f240 ("clk: qcom: clk-alpha-pll: Add support for Stromer PLLs")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v3:
  - remove constants' comparison (Konrad)
  - Link to v2: https://lore.kernel.org/r/20240326-alpha-pll-fix-stromer-set-rate-v2-1-48ae83af71c8@gmail.com

Changes in v2:
  - fix subject prefix
  - rebase on v6.9-rc1
  - Link to v1: https://lore.kernel.org/r/20240324-alpha-pll-fix-stromer-set-rate-v1-1-335b0b157219@gmail.com

Depends on the following patch:
  https://lore.kernel.org/r/20240315-apss-ipq-pll-ipq5018-hang-v2-1-6fe30ada2009@gmail.com
---
 drivers/clk/qcom/clk-alpha-pll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 8a412ef47e16..8a8abb429577 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -2490,6 +2490,8 @@ static int clk_alpha_pll_stromer_set_rate(struct clk_hw *hw, unsigned long rate,
 	rate = alpha_pll_round_rate(rate, prate, &l, &a, ALPHA_REG_BITWIDTH);
 
 	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
+
+	a <<= ALPHA_REG_BITWIDTH - ALPHA_BITWIDTH;
 	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
 	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll),
 		     a >> ALPHA_BITWIDTH);

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240324-alpha-pll-fix-stromer-set-rate-472376e624f0

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


