Return-Path: <linux-kernel+bounces-150183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2B28A9B72
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7DF91F2061E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02D0160790;
	Thu, 18 Apr 2024 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xlJnhtHj"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C87A15FD16
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447702; cv=none; b=Qmix6LiRDgJwmHfkVeLXPfAbGkOTUJhBe0SnHMdW6d0RVlK83qMPXDAwe1B4S+0idoPzEU/BVIO/RtfHJZ+R8y0uA3szGuD2BBsUW8U7fRGwuICD1VAwcX9xKbQzm2bCOgE/jyPO6wX336muBLV1DdTJ5gW2usPBQ0H1Rcuwku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447702; c=relaxed/simple;
	bh=8MzW49dMcgqrWLiS7mwIpQOpeo1dbVcEjhaJQWBw44Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h6RoHM6m726MlhfIs8FgZ/Ht/7govxxFMoltw11KEHbEt/eSjrkD9eXX9v8c4JuoToLbK3uB/u7XQJT8rir2Gs8CwsYJPuCnGNwRtveM5p/ZtGPkK0EfVZBwu/HfPFgx3MTV+4PwGp/Q2WKoFBhCZYmePJmtX15Bpt4EeMY+THY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xlJnhtHj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-343e46ec237so615460f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713447699; x=1714052499; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8Q8PkKj9VfKJC1mpdjogpO5/6dV0GWIjsKclaHyBuY=;
        b=xlJnhtHja0Dclh8taVACp9PDwUc0/kUUiCKi3YaA6+zI5SCZYOHP+iLHmyLiyucS/U
         fChC2MrxKZOGwjyAoIZtaRMcsuweoPcEgE6t6RA/PRsGYY5me49gSEgPbgZLcSrQciFn
         muEUAwVQ7XKDmES9E3BfM3DXNfWlokYd/lpMM3VLebErXpd3QXW+s7yQXtST70f3Htxv
         EFhUIrsKA3leJlI7LHccQ/bGnnHyJs+ZMJLZrgHWc/4/AudJ8FksehC7JjGDaPXUxqRC
         qGHiODxKZEl7R/NsvxBPa1dDj1X+tgpsUMm5opcq5qSDd0MutLS3wA/1blWUNMD/YE+J
         OoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447699; x=1714052499;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8Q8PkKj9VfKJC1mpdjogpO5/6dV0GWIjsKclaHyBuY=;
        b=nLVVe1uZZHEDZpBpRNg3k7ukHF3BS+qBX0IxypKPh3SzBwiAfTmxCqwzLti9P1lwIr
         qJP8G24tVpAmxNIQbv1gk4PtmSsg4PNwcmIfbDjm3ox0Xz/IBhxOdZLVIEOOKlUNWUUg
         3vH7XFvW36qbmjwHYQl8orqpgKijnrbFztaHB5u82BlNY9TTRJDCo1hXr1ukHRhccW5B
         +ty9Z37cgl4MSQ8knT8R6m53Ja9x2nNPnMSndTwC5i19d4t7beHE22GNecovsYpJIX69
         ujoXZmJkK6RIBxHl/vrvIJXlb5i674MASjsPwx9k/QExrlpr+PwH3MOw//8v0BQIVhr/
         fhFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI8jSUyarBmHdGFMlzf6uU/hlKnZoxPVj4bABUku6DOWkAJN/LAGnhFJnd0g6sKKd10w6wxpOl2Zse+cg6L5lW24KY8raHBHMClxxS
X-Gm-Message-State: AOJu0YzoLk4ISLkK3HJnhDK8xTB7y5wedaHcE8ScR3o+3SvohHn1XdoY
	J8qrvUOQJlY+kl2RUia6Qi3JuNL78zaYt9otoZl+imx8Q6OrevE6R6MlLAsLY/g=
X-Google-Smtp-Source: AGHT+IFihOygOq+RuFRNYpUjc3dh2ppGPOrymInr2wa7gdeDSW8Z2jhCCG4NPFX9yOx59qxtCJF4vw==
X-Received: by 2002:adf:f107:0:b0:346:d7d9:83ae with SMTP id r7-20020adff107000000b00346d7d983aemr1974699wro.52.1713447699420;
        Thu, 18 Apr 2024 06:41:39 -0700 (PDT)
Received: from [127.0.1.1] ([62.231.100.236])
        by smtp.gmail.com with ESMTPSA id bi18-20020a05600c3d9200b00418d5b16fa2sm3540809wmb.30.2024.04.18.06.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:41:39 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 18 Apr 2024 16:41:32 +0300
Subject: [PATCH] clk: qcom: clk-alpha-pll: Skip reconfiguring the running
 Lucid Evo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-clk-qcom-lucid-evo-skip-configuring-enabled-v1-1-caede5f1c7a3@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAwjIWYC/x3NQQqDMBBA0avIrDuQWEukVyldmMmYDqYTm6AUx
 Ls3dPk2/x9QuQhXuHcHFN6lStYGe+mAXpNGRgnN0Jt+MIMdkdKCH8pvTBtJQN4z1kVWpKyzxK2
 IRmSdfOKAzlrv2I3XmzfQimvhWb7/2+N5nj/6GHCzfQAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=8MzW49dMcgqrWLiS7mwIpQOpeo1dbVcEjhaJQWBw44Y=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmISMNHLTmgu0xX/TL+OLtu5GJXEUyNoWCimTfq
 tbNZOviUHSJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZiEjDQAKCRAbX0TJAJUV
 VtJ/EADLoUXsaikbAsY4EWLnvAbdfIRHcu6YkRARES1bYuTmIw4WTNqpe66miuk4dFMkrJ6b8Rm
 D+/b1TLzpzS5Ua9w16t+EHDIoPIdOK6OZeECopbWIY+Qz7sRmlXe6Xk5n+0Wh5KEjulOfb/vlR0
 +PuepWRH3+lxr/ctyWZ1GgEVncjMgwLhqxQbn1FDYLJRF4tLj/KwsEfM4DZwMc0BIsmTMhR9px2
 inQ+2Y4/krMtEHAYTxk12bnp5xoxVQ9SgMol4oE9flajb+SJiTTuBe7/VUZPYgrYOn65QK/uKcZ
 pQPHcYXA5O4W5VZvcnTXdEDEe9kcSAcElJ5bAdA6Cag25ODSM22CQQ+KjGd/AHzbUY4dmLZIDUd
 YxvXarxk+QofUBiVRBH3gXs6eNI4VGyqePJm5rC0lO4A9hj8eM3r9mR5DtLzXPx/haOEyTywkcI
 p9mUNg/l7SNryQEg9QtQDT3YiTnB+Ow2lCPaN9Hdl25eA9JTNuvNxu3cqqy/ql6nM4Qjt1JJooX
 GgxNydIWFJ8h0UxXVj9lFBSivfFtPPoVbQwDHU/SY9K7D8HoQsXQdne576yzco2rQRe/79b/W3B
 kDQhsoBseoMwGJp2NKcL7xzJCCoXqvyIhUmQj4IoVZBOCdkjwJWT4HWZvZmj3q1el5ZxwTIhM7U
 uNCOFy+AC2ZxZCQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The PLL0 is configured by the bootlader and is the parent of the
mdp_clk_src. The Trion implementation of the configure function is
already skipping this step if the PLL is enabled, so lets extend the
same behavior to Lucid Evo variant.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 8a412ef47e16..4c5aeccff0ef 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -2114,6 +2114,15 @@ void clk_lucid_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regma
 {
 	u32 lval = config->l;
 
+	/*
+	 * If the bootloader left the PLL enabled it's likely that there are
+	 * RCGs that will lock up if we disable the PLL below.
+	 */
+	if (trion_pll_is_enabled(pll, regmap)) {
+		pr_debug("Lucid Evo PLL is already enabled, skipping configuration\n");
+		return;
+	}
+
 	lval |= TRION_PLL_CAL_VAL << LUCID_EVO_PLL_CAL_L_VAL_SHIFT;
 	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), lval);
 	clk_alpha_pll_write_config(regmap, PLL_ALPHA_VAL(pll), config->alpha);

---
base-commit: 4eab358930711bbeb85bf5ee267d0d42d3394c2c
change-id: 20240418-clk-qcom-lucid-evo-skip-configuring-enabled-711b7e7835b0

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


