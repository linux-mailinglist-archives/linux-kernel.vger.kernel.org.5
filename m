Return-Path: <linux-kernel+bounces-36055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16279839ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A6128AAF9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F22E46525;
	Tue, 23 Jan 2024 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="CtKF7IDS"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCE519BDC;
	Tue, 23 Jan 2024 21:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043877; cv=none; b=dNRj/GDGZOiT9x6xWTuxATKa8M2Ks9L8Rx88ZmBVaHzI2n220qVZy/0s6kk1UkUY57x5L9wKqKuUnIKJ1K2+X1km7fhbWjYPfrYoh/iZQXKiKdB0HSvslbDD95fjRgiirexWuTZ2A8u6W4Kip1jxS8omWIw2ax3HGRcvMw68ClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043877; c=relaxed/simple;
	bh=fKNOuDoTzwcVzhQKQRV0risOvkUSvEE2mxGjG+qiGFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HLvVYL/AwqHiUCxp2CxS0xd0z3OFg1u0nEMpY1jzaMhqFHBIn8Yo1++dvR2uBw7ySxDrXGbkEWI+fZzLUVdFjRongXEH8xEL5YClrH3SjUQzEdScs7Y/2Z61YTNOUSVizneLNZ9JdPt7cH0vaqmdYmFNjB5R+QPFtDFK3qN7kxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=CtKF7IDS; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1706043866; bh=fKNOuDoTzwcVzhQKQRV0risOvkUSvEE2mxGjG+qiGFM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CtKF7IDSkGMIKSDjrC1pkNtds5M2ywxHYrRxbtNMREIAyL4pUvLKsGB5vQDWoKh9h
	 U8BS2PosNaOpKKPaenf9PzHQ5EnbVAIeOE5V8yPMnWQWt9DlDaYjV32aaSxorELBLV
	 1YAr45GvXy8ID20tQgnYD+bebzFZhr1iPq4WywyM=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Tue, 23 Jan 2024 22:03:55 +0100
Subject: [PATCH 1/3] dt-bindings: clock: gcc-msm8953: add reset for MDSS
 subsystem
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-msm8953-mdss-reset-v1-1-bb8c6d3ce897@z3ntu.xyz>
References: <20240123-msm8953-mdss-reset-v1-0-bb8c6d3ce897@z3ntu.xyz>
In-Reply-To: <20240123-msm8953-mdss-reset-v1-0-bb8c6d3ce897@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>, Vladimir Lypak <vladimir.lypak@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=736; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=nowTyNlcYWdBQrzi/O5J4gsbaEoQ6NuvDACFQUsNsms=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlsCnWW0r9jBCJrtoQbLrBv0ZaFIeW9WTt/l0Iq
 xYcLVturdyJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZbAp1gAKCRBy2EO4nU3X
 VoivEACI0QI2XZfoqVKppuc4WBE91IwWNshNwI/+dbesUmPY5DQjl1UerOfNMOzMYQ248FULlgI
 B2vih7/EmjR9dPfsjO0BLHcYSagtV2kzA6Cygwzod0iTc0zf3lXmwTRjMTeb7ZcgpR3DwbF1a3t
 F1LG6VzYVqeU+dXQDGTXjFS8Q7SaE/4VL1195xE62eidr2ruh74QVBqKMkYbCKjwd6SxpVAYdFy
 X7V24Ba/YxQK4MXGXUibclPuUoUSjisaKUOPxcWRKP0U5bWAm7vq1QCxd8LGM+aJSUHRhFBPJ9e
 /fpsXHlrSX4LBTUEZozSlHlK6kj/fkuCmjxay+7PDNOM6jPJrrmCystrdUMhmwkiARZKtEEmMgI
 KCrRbs6+rVA8W5MS5yPvOkIFrlRToebabO8/lCFRvKCgKhORGAg/KaqO+69bFurkrEP3eSYMZXy
 yC7zhRa/xy3tM4lYMoA1LqEjbi9Auu6VMVx5D2R2uTLkhtIIAmYj3Y20xYzEy3Et8MfsBJzL1ra
 1uKWrYyEcc3f/qDvp4WMic/xf5SWPdnCxUE67YF2QcP9b+uqgYI1j3C9Kzixu0+r1SxEQntbPNo
 vdEcSBuVVEYtpAI5rSW7u/+oAxx8k7CFWPYybFseFMGfNvsqFS/5Z57PfRkIXoh4q9WQ+tBxyIn
 DDUXoCbBQ3lgPtw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

From: Vladimir Lypak <vladimir.lypak@gmail.com>

Add a new define for the GCC_MDSS_BCR found on MSM8953.

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
[luca: expand commit message]
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 include/dt-bindings/clock/qcom,gcc-msm8953.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-msm8953.h b/include/dt-bindings/clock/qcom,gcc-msm8953.h
index 783162da6148..28090f9d7f24 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8953.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8953.h
@@ -218,6 +218,7 @@
 #define GCC_USB3PHY_PHY_BCR			3
 #define GCC_USB3_PHY_BCR			4
 #define GCC_USB_30_BCR				5
+#define GCC_MDSS_BCR				6
 
 /* GDSCs */
 #define CPP_GDSC				0

-- 
2.43.0


