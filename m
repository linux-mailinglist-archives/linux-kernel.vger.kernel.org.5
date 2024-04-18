Return-Path: <linux-kernel+bounces-149918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CBB8A97DA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183131C203F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078BC15E5A8;
	Thu, 18 Apr 2024 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wdqq8KVg"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B1015E20F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437496; cv=none; b=PivMyox2TItJYduucCGkMxpKh3VrZVJtIWXRWYEc21xGpQdgg597koHKPXDl8qlJpxFKgUcTr3V6CuzU/zYkKyyDVICjrWRIqVbmr5Bqsatfe3ggV8k3jGEXIpV/7Isw6wTi3Km8/R7WcBga8i5Ya1tLZ16ols+ntTsleq0RNyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437496; c=relaxed/simple;
	bh=0ciFJjYNBna6Z51Gvl7mG87GzaYImzsPtuVsZFJjh6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MEVFQ4JUEf+4KJp1VSXx67U7DRS1YNBz7teyVgxOtHXqAEzNSojgFVe43x3WmW63/o8F/42reacDo7eYC9mFYAYLWV/w+UBHIBYsCHzZIXSKpzjnW0uIlD8BJdDhMM4snA08Ymn+YG7CF/cI0mnmW11k03OhuY3lM4sn4Wv6xLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wdqq8KVg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-418effbc5d4so1747755e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713437492; x=1714042292; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ffWz4ggcM0E0BoGGSniCNW1lk0qBr3Zu+n3EFocarJo=;
        b=wdqq8KVgeVNQwBZ7wYi4h9Snn+eByhE/4yH42kjjF8V872u2RzHECfsATGasSGefJw
         cHmPZXT84qncRwYmw2Wab9rKC5VNDUyY8Jh38CJbwTXOqnSad54iitvibLQUnejGbNf9
         KauQJq2bWP1I1zR3U8Q/yIa7U10APgKIqnMtulMw/QaIeXXXoN0kyQ8SgNr2Rr10o2/3
         Yy0USTQO9GFACGBNQZ8PLu3BZc9UoTypKi45S67BGDuAyA/w0m1UsaE4xXFYtzhbMzAj
         ZHW+i0FkUjcApMhKUU8dapAOWAtlBWXhGDjrHEDU9l/vAzSQxoKjUmZA4ZVGiNDCzQyz
         06Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713437492; x=1714042292;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffWz4ggcM0E0BoGGSniCNW1lk0qBr3Zu+n3EFocarJo=;
        b=p0VNye4R3pXn7AQeiOKzVRFx178s+L6e6JHHBkvR+7qKEhiWLflpNXqCut7jSVrnCU
         cfYVH5s40Rwxc8YqtbTpXHs4GnELlRZZTpXJx68HjfCMUtzsNESTrVOWs6j+p3pb03hS
         +j7eUMjW0WwGEZGwwC0O5N3HJUYahSEu67484mS39TWzFGEqJEthVzhHInbqklQy6mke
         dIbf+XonsJb9A2fSBSIoxlyFWcfTJ1pbnNUGllAY7mC0//OujC7hBCIdtkWSVlgccxxq
         V5Y3N6DERr31XnYIdbIZBwhQtsUU/iHXVr5yPOHAtEc14u372EV1nCLpN1kOLhRDkFhN
         FTag==
X-Forwarded-Encrypted: i=1; AJvYcCVovATKLBdwd0+Hord1Id22/ocliFVqT1Z0f2a3M7izTGFQnnF5moV/x/T6Y8pr6HyQlISSLgjmkZ94+md+CuVBmsVVzmQN17pfYMbU
X-Gm-Message-State: AOJu0YzO+xaUpW3A3zFMXiNgjxP1jLFuL3kEgWKqjzuZPzmQK93JznUN
	d7SGMn3RiHUqTB/fFg5qwPjEU3kjK2/IrrkhOovBtmnQq2jRGYqh2SYdHNuupuqNuDQfffGWQAx
	J
X-Google-Smtp-Source: AGHT+IGayePpAYxdxkQ6lrjF9h/2Dh3xPxJfDGn5zbuN2vyze23VCBwFY299S/JBIvSepohp16hROA==
X-Received: by 2002:a5d:498f:0:b0:349:ca9b:545a with SMTP id r15-20020a5d498f000000b00349ca9b545amr2135137wrq.29.1713437491673;
        Thu, 18 Apr 2024 03:51:31 -0700 (PDT)
Received: from [127.0.1.1] ([62.231.100.236])
        by smtp.gmail.com with ESMTPSA id j10-20020adfff8a000000b0034335f13570sm1509773wrr.116.2024.04.18.03.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 03:51:31 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 18 Apr 2024 13:51:22 +0300
Subject: [PATCH] clk: qcom: dispcc-x1e80100: Drop the reconfiguring of PLL0
 on probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-x1e80100-dispcc-drop-pll0-reconfigure-v1-1-453e4e70e940@linaro.org>
X-B4-Tracking: v=1; b=H4sIACn7IGYC/x3NwQqDMAyA4VeRnBdIrIfgq8gOWxtdQNqSsiGI7
 27Z8bv8/wlN3bTBPJzg+rNmJXfwY4D4eeVN0VI3jDRONLHgwSrERJis1RgxealY953QNZa82vZ
 1RWLmdwgSJQj0VnVd7fh/lud13bwbv0Z3AAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2061; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=0ciFJjYNBna6Z51Gvl7mG87GzaYImzsPtuVsZFJjh6Q=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmIPstSihNwBB5uM+APSfl0MdpNjzf3YHx4nqaG
 pJoutt7etOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZiD7LQAKCRAbX0TJAJUV
 Vk4PD/9dDOkeP3I3QqwI7R9LK6r5V2cL1yMl5oWEI0n2hltX6TkrpX1cA8O2f9u3c0uVLlSXjT6
 oDzDy8WzTgckmYbM75d2w6WPcxq9M8oSB0P33VC8SNKHsSc20fr0J1qyvTgxwfKp3IHq/hsz0HB
 MOxs0hP5a+30P/H4DlD+4noruu7tsd/gf97bEVqDlOteIZUF42RT6VhPjTl1+AeN9pFHRJz9tXJ
 7+Y0kqlibxAGoxNwaqhmerc/1PVL4XvO9C2B7w9LwA2fP0Q9AcQhFbL10K7iowjybSpFqr5GfA3
 24mbKmaBf2gOM4Veq1UgwVvrBZzzrvd9s6pQ3rBCIIclsVCMFmMBXikJWkpbaLftxyMYUM2tSSg
 ziANbI47Cz3W+w8RD5LYdx/j7dyPnO1k+wkF0zl3SchecP84bW5nYZLJ6KYqUUacmJOTVdSOJsK
 p2le2fZmiRydElDGs1a4KsXS8TCkMlNECKsBmDaNkTMbMjgPJ7MVB6VPIFugwZru9hFpP8a+Pgc
 Tv/QXwoP+EYFjO1JBDbLeN/154gBrUPcJ1qUPenh+ixFAEtxHtQ4Mmxa0MB9hMW2X5YZFgZHStd
 2WEVEwXTVKiF8BVt7Ch/dOkMXAlX9tWDzdoCtXQlsD8rWNJ/VnEMHXr6zpbCnlSHYUS4iKofcNz
 1SfuP7hAoITTmIg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Currently, PLL0 is configured by the bootloader is the parent of the
mdp_clk_src. Reconfiguring it on probe leaves the PLL0 in "stand-by"
state (unlocked), which will trigger RCG child clocks to not update
their config, which then breaks eDP on all x1e80100 boards. So rely
on the bootloader for now. Drop the config values as well. Also add
a comment to explain why the PLL0 is not configured alongside PLL1.

Fixes: ee3f0739035f ("clk: qcom: Add dispcc clock driver for x1e80100")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/dispcc-x1e80100.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-x1e80100.c b/drivers/clk/qcom/dispcc-x1e80100.c
index 0b2ee6456762..525f645094a8 100644
--- a/drivers/clk/qcom/dispcc-x1e80100.c
+++ b/drivers/clk/qcom/dispcc-x1e80100.c
@@ -73,20 +73,6 @@ static const struct pll_vco lucid_ole_vco[] = {
 	{ 249600000, 2300000000, 0 },
 };
 
-static const struct alpha_pll_config disp_cc_pll0_config = {
-	.l = 0xd,
-	.alpha = 0x6492,
-	.config_ctl_val = 0x20485699,
-	.config_ctl_hi_val = 0x00182261,
-	.config_ctl_hi1_val = 0x82aa299c,
-	.test_ctl_val = 0x00000000,
-	.test_ctl_hi_val = 0x00000003,
-	.test_ctl_hi1_val = 0x00009000,
-	.test_ctl_hi2_val = 0x00000034,
-	.user_ctl_val = 0x00000000,
-	.user_ctl_hi_val = 0x00000005,
-};
-
 static struct clk_alpha_pll disp_cc_pll0 = {
 	.offset = 0x0,
 	.vco_table = lucid_ole_vco,
@@ -1670,7 +1656,7 @@ static int disp_cc_x1e80100_probe(struct platform_device *pdev)
 		goto err_put_rpm;
 	}
 
-	clk_lucid_evo_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
+	/* Configure only PLL1. PLL0 is already configured by bootloader */
 	clk_lucid_evo_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_config);
 
 	/* Enable clock gating for MDP clocks */

---
base-commit: 4eab358930711bbeb85bf5ee267d0d42d3394c2c
change-id: 20240418-x1e80100-dispcc-drop-pll0-reconfigure-0111b338c838

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


