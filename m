Return-Path: <linux-kernel+bounces-151732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C3B8AB317
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7E51F226B7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFC1131E2B;
	Fri, 19 Apr 2024 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qSzuSBV7"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D70130E49
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543257; cv=none; b=nuxHIPG0m3FEHxCmyWG9pHFl5Z0aTY71n88RBDga2EZNvi24Lxy2t50CfoGgCxYwsUK0UsA5z/83x6tKV435AbBXPutdqXTmGzk7fZZhkIFu3U+Ei5mbBWyWM8QRTk2/cYduRlkLROO6BW3obTYdPTxqb++wE+jsApfyEw1ACjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543257; c=relaxed/simple;
	bh=Rbz2aolgmJrfetqrLLzvkkpNrmNjBGZJ2H2n7fAWRyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sMKoeS4mj+Q+QdYroNygOxfwuPaUR0eLigjT+GT/Gb0wI7zQ6qGpD+dfx9X7c+j5OjjSBq2zuvkkEN/XSc3gjiqeA1eKVRSq6YJDDOs6qQV6Dltr1CHaAR85oXZC6H2CIJy9xSSM24FHnUqVnsE8WOAakLuC50zTfhnqXdi/0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qSzuSBV7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-418c2bf2f90so12888445e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713543254; x=1714148054; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGQbC6Bg+yKyDrnruX44aTSq8ZmWSf/7UKZ5GbUS+cw=;
        b=qSzuSBV7MTCE6OGwOXYyPC/nkmuy1aqF7soHXGl58vao7mBiW6KaHSbbbpNrFbnabE
         epnDa6E+EuBEr9CMv2Z4Oy3K8NriuRHwQLuUBly0q50Mq6UHmRa8V+wZz8yKxH8RccMC
         1Bf/SkMqm2kc7te5urj6QJv+v949gGFgnZddQbFDDndq6Iuh6yBvQQEcoA8yoVCHpvQl
         DDO0xLodsKj41SvFLSp0WJ9wynT8IIMcmQlPRbFko++6IPXmerCtLH7Qr5xhY39JwyHW
         8BWoa+KzaXTDF9lyiTB4fCeP6OYcSPTn7zRvHahAAXpOfKGDdNPVZrHxV0tv1F7glrFp
         WLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713543254; x=1714148054;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGQbC6Bg+yKyDrnruX44aTSq8ZmWSf/7UKZ5GbUS+cw=;
        b=Nl9zoO4QyloFxXR/2Prybq7MC/ZvwRlYzMT56OkCx5FmrCJAyw8hw3bwBuZ1PJ+sOo
         R2Wj9DrFPhOXpKRHqW/lW034fiDx6elH1dllzxjPLr3CUa0Dn1ukpAcabANMyhQaxWDO
         uXc+s+PA9BYngLM2X0cI+0suBaKNsMSZwrqCr8iroYlNJLyN+xqfNBaqxs6q+fKzSVAy
         h5pdu+2pG1DQfXyvYBMcFmSgzcUKYfSP/7xTIWkWPX/ips2lfcD6jubeEGrkF4GACK0l
         KjjERkZX0dxgC7bv4aXK676EgQ45rPcre4qA4MShvqC6Xqh+sA5AiqgpUEV3aVhf3Q2B
         zxXw==
X-Forwarded-Encrypted: i=1; AJvYcCVcjgQj2EGCAH4RIC9PiDJCMMLmO/cEEB30hjxEwINTa/M4zvMBxvPgJmueSVQRsIJtavNeKP4jXGMoNPMafguj4TzCm7SLbFTwfAM7
X-Gm-Message-State: AOJu0YwaZCp6ENtEb5e/qUomTrx8TVi3kguYH0ItoWKBbRbyM4pBp/zG
	WpCjc7QIzRb4AU+clyH3kBUbt+AQr5+UZlTma52V23fXywLLPjli4PPLIEzNBVs=
X-Google-Smtp-Source: AGHT+IHOnS0887UCRMS4ym4B8uEA6tekJr2rk+qnLwV8qrIn6rA2h1x4wkghpyhGBk6BGLxPktzdDQ==
X-Received: by 2002:a05:600c:4589:b0:418:d3f4:677b with SMTP id r9-20020a05600c458900b00418d3f4677bmr1925430wmo.17.1713543254213;
        Fri, 19 Apr 2024 09:14:14 -0700 (PDT)
Received: from [127.0.1.1] ([62.231.100.236])
        by smtp.gmail.com with ESMTPSA id d20-20020a05600c34d400b00419c4e85b54sm1448229wmq.16.2024.04.19.09.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 09:14:13 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 19 Apr 2024 19:13:57 +0300
Subject: [PATCH v2 2/3] arm64: dts: qcom: x1e80100-crd: Add data-lanes and
 link-frequencies to DP3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-x1e80100-dts-fix-mdss-dp3-v2-2-10f4ed7a09b4@linaro.org>
References: <20240419-x1e80100-dts-fix-mdss-dp3-v2-0-10f4ed7a09b4@linaro.org>
In-Reply-To: <20240419-x1e80100-dts-fix-mdss-dp3-v2-0-10f4ed7a09b4@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Rbz2aolgmJrfetqrLLzvkkpNrmNjBGZJ2H2n7fAWRyw=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmIphPi3T3R/bRyWMZNuGlTxqoMBa7k03KcNMo1
 R/ybM9zI/uJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZiKYTwAKCRAbX0TJAJUV
 VpQiD/0fAXJ7Wf3FS9A78oqpi3BmRe1FRlMyCeFoufk9U3qcLmf8DHnvLU6gBrf3TBugP8Orcvn
 JsIkpNb1Htl8wKYC5U4Q2JDtMwMK6rjpTqYSiLHnmtR/7Ie73XrXjYBsp9NgZqYByXXuqLmi5YP
 79HPogZ6aMOJPvZxn5oEqCeAzhuM0walHE/AI+xRQXBfX0Cnl8kln6EVye8dT17JNG7xYbIzsbZ
 wU5zEudPQwyD5wWIZ/gR05NWYZmQx4kXqZbBFLjdD1Jn6LR6EAwlVjbHlxqd1PtUG/A7Zk/WY1Z
 wpqHcawwMdv454o+qWAXykuwBGl6d4keZhjf/7pJtAndrLJulh9ljWRs0C88Pk12WbJb3ynsN4K
 i7IDMzTMZ+iDEqFsUlgVggMkC5OLyEcgAlFbcbnY7o1JHzh80G+AuFrisBES0rI797uROrArLVd
 sOv+RCaRFkyY1NxJ9R5tZBK9EPmQ3VSIjWaYMSL5Im7aT6Vslw0H8+HybVE0z8JqcWQ8fQzH0sV
 tBpAqVi66dgR4zhTcUcD4mvgJ0XPhlzjo7hIVam9v3l3zHqgCMj20Ww7ZxPjA5N0YP9IC8mqi3S
 +mcYWEjlocTpG0xIV8hkdDMLeng8BJAIZoco2EZOnIKLR8cHpsEj2Nouc4zGMcX4mvU6KJ/oZiQ
 RGp8VRU14rVpeoA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The data-lanes are a property of the out remote endpoint, so move them
from mdss_dp3 to the mdss_dp3_out. Also add the link-frequencies to
mdss_dp3_out and make sure to include all frequencies.

Fixes: d7e03cce0400 ("arm64: dts: qcom: x1e80100-crd: Enable more support")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index d4198fa204fd..c5c2895b37c7 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -599,8 +599,6 @@ &mdss_dp3 {
 	compatible = "qcom,x1e80100-dp";
 	/delete-property/ #sound-dai-cells;
 
-	data-lanes = <0 1 2 3>;
-
 	status = "okay";
 
 	aux-bus {
@@ -620,6 +618,9 @@ ports {
 		port@1 {
 			reg = <1>;
 			mdss_dp3_out: endpoint {
+				data-lanes = <0 1 2 3>;
+				link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+
 				remote-endpoint = <&edp_panel_in>;
 			};
 		};

-- 
2.34.1


