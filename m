Return-Path: <linux-kernel+bounces-87234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C074186D177
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774C9285B66
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DED07A14D;
	Thu, 29 Feb 2024 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="As62mqys"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333197827B;
	Thu, 29 Feb 2024 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230106; cv=none; b=BLOe0EuX/bFndgHnbLsL7IGdVCXssNegkDlyI6BuAxntuZP3FnrIdXN7BIzUJ+glDgu+d+vJ4/76yq4gXXHWl9uFMJvrVMEiBgRENkrprRV5Nb2R7aUP3dbxVpTvl6dPR7E1+Fy2XenajIbaLxg+cFiyIH+VcrtEPV6VXY4i7N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230106; c=relaxed/simple;
	bh=BHpXmfCdFm79sHhjj+p/LhjJdEv9za2/JcqtZAjCXiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hvl6othtHNF+BOSC+0O22T9tHhxboukMhYsdBVz1NbhhIIW0HcVFBtwhsIAVPxXrEeigZ3o8z/wXDSacJDuui1KtIXx2rH97ZGNYH0pITGek71orXaDit7xH4iVy9TqUExZsmZp64KzCgBpcKiOqJjXEMhSCgnOnxLVHyPoL0iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=As62mqys; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412c34e8464so2023155e9.2;
        Thu, 29 Feb 2024 10:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709230103; x=1709834903; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYAAhEwR/E+dbtNSsly8JocDfIPA8JdctVrwVBpoHmU=;
        b=As62mqys29FsIoghvULa8WvplWlStc87rv+dTChhRBeKNST6UZWcMQ1/BxZ0g6NPLs
         RfVmO+/D8s1y9ke4B2U52Fy24Uek+IYnCWFabHsgFHUq93hS8HiMmtmQ6nvirHSi9oZp
         GFMnUdH6qPuExTuPHKUivO1cVDGvWFAtDNDXDYSI51OMq0EZE8pVurzTElcl3urtI4A+
         9+vQVbPZ0a7shleWtENBDXCtjEov+OJyWrfljmqXtyVf/3f+/lIUdDLptPvBTKsH9Wrz
         Z8rnD6YyhjJKsyR4uI72DqsoZ4drmuaZL+ttBRpPpJeJKNdHkkloLrDhK1NPc7iv6Xbz
         wDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230103; x=1709834903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYAAhEwR/E+dbtNSsly8JocDfIPA8JdctVrwVBpoHmU=;
        b=JwbeIMEfx3BxkoPieO4ZycbbRG/wlxFy4znQEuPxk8wih+HkSe4Juu73Ubar5RP4VQ
         VeaAwFH1vW0PHnYapesVrLMnaHig7UVTjx+SBRSs85/WEOU0oOCCbRogSrNKag1pQMbV
         oiixaydU/RdaV4qWoVzmlQ9CLnmFed10apNNQEpVYvU/P7j37HBdhCRHMpDXMcl77VJ1
         QV2USNZbUhOUiiWu2/kns0J5FSJGf9ApOpvmSV4mKmomXgQBsiUuLsxVVMgURHayuZPw
         mq4P5HgGLdnMKIaGChb/skCQn+LLb02F9b08GzrHZ+nsiE1DIxzTPbEeH+3kpyI4pWW6
         uq7w==
X-Forwarded-Encrypted: i=1; AJvYcCWTsjoq6Eank3PVoj7kvB7A3NqYZKiauwIuJHJExmz+fKDkriuzSMq6eAVWVopAwmSRGuzIFCX1GAW3JESAVdJ/DgGcJmLi9Jrlgo0P0uoOtPubFOSDer2OaeVYv2oFewPxlfjygKJC
X-Gm-Message-State: AOJu0Yzkret5+XTSw1Dmco2vxj9bVNSjSN2wOZRxnJh4z8jVVkq0war7
	+rOjlM8UB6kousTxNohwWg+Wq9m96YV0Re7Qa84IznKiwzPOqBmVGfzTa/VTNuE=
X-Google-Smtp-Source: AGHT+IFbMhZnLqk0ekw5mroQWt83bAhrD2xbKJ27yht2Wk15dYszLSpQEeaaY9h+SMhfmgKOClRF2w==
X-Received: by 2002:a05:600c:35d2:b0:412:b42c:8ff1 with SMTP id r18-20020a05600c35d200b00412b42c8ff1mr2389897wmq.21.1709230103496;
        Thu, 29 Feb 2024 10:08:23 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id z11-20020a1c4c0b000000b00412ba5cda16sm3100620wmf.33.2024.02.29.10.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:08:23 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 29 Feb 2024 19:07:47 +0100
Subject: [PATCH 2/7] clk: qcom: gcc-ipq6018: fix terminating of frequency
 table arrays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-freq-table-terminator-v1-2-074334f0905c@gmail.com>
References: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com>
In-Reply-To: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, 
 Devi Priya <quic_devipriy@quicinc.com>, 
 Anusha Rao <quic_anusha@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Georgi Djakov <gdjakov@mm-sol.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

The frequency table arrays are supposed to be terminated with an
empty element. Add such entry to the end of the arrays where it
is missing in order to avoid possible out-of-bound access when
the table is traversed by functions like qcom_find_freq() or
qcom_find_freq_floor().

Only compile tested.

Fixes: d9db07f088af ("clk: qcom: Add ipq6018 Global Clock Controller support")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/clk/qcom/gcc-ipq6018.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
index b366912cd6480..ef1e2ce4804d2 100644
--- a/drivers/clk/qcom/gcc-ipq6018.c
+++ b/drivers/clk/qcom/gcc-ipq6018.c
@@ -1554,6 +1554,7 @@ static struct clk_regmap_div nss_ubi0_div_clk_src = {
 
 static const struct freq_tbl ftbl_pcie_aux_clk_src[] = {
 	F(24000000, P_XO, 1, 0, 0),
+	{ }
 };
 
 static const struct clk_parent_data gcc_xo_gpll0_core_pi_sleep_clk[] = {
@@ -1734,6 +1735,7 @@ static const struct freq_tbl ftbl_sdcc_ice_core_clk_src[] = {
 	F(160000000, P_GPLL0, 5, 0, 0),
 	F(216000000, P_GPLL6, 5, 0, 0),
 	F(308570000, P_GPLL6, 3.5, 0, 0),
+	{ }
 };
 
 static const struct clk_parent_data gcc_xo_gpll0_gpll6_gpll0_div2[] = {

-- 
2.44.0


