Return-Path: <linux-kernel+bounces-127042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C185289461F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A935B221C9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAB758AB9;
	Mon,  1 Apr 2024 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lJFdxoSl"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C09856B8B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 20:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712003633; cv=none; b=O44zZ82L3Og9IPNP79C6VFo63vEi721mnKQC9JoOOXv6EVgWADFd4/hk4+qYrcdeck3SGcGUS5VHExtEF6N8pqNMlA/GTIvV75I83nGpqWYqJVtMPILLmXJpMLlXnAAh/IYQzFr3XId8RGX1/DRhe6JAZUBIumdydXvij74Ru64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712003633; c=relaxed/simple;
	bh=+m4KcknPtPtiYtZonTjzGx6OYYK5R2lRlFqksVKoy6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AtZtGCwy9/mIxxyrdjP1kg37kTIbbKnp+v7AoJaQuPSb09elZcTdLB72uWDo431PqmdGUFZXUXASqOV2dh823rbYEmBVgMcDBKssfa0ZeTBEshHAF2qB9tlwARrb4mNqYplnHcbUgC6B9OoKI6ahUaFBDeeJfRKy2Z8lHY56bLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lJFdxoSl; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513e10a4083so5026659e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 13:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712003629; x=1712608429; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QA39XfS6kFKT4ejZVfv3YPVU/6vd+JV/fWoR8cy3Hug=;
        b=lJFdxoSlm/M0aZoVMaULjVN3txSdpIH/3YcqThTKXHk9sUVS1uin2sD0+HbLJcBZEH
         PLBQXPzZaQJ7JCWvsrJTlIErjfaOzxcPNEQDuHYleqQt0S3JdG7yMiGNDNU2mqCHrWxg
         ptvnOxGH8ifGYsnnzL0yrssZdOyQbtHaDVc4wPsF02BGlPZR6dSjqmCC2++RtcXe00vv
         g+l+45ZnBjdDT5kbv/NFGr1QHa3Um4OuRxNj0gtboyKnLFVjZ8fy4lRKHd0lPrFDWBVW
         1/cX2EUIuLyuVCMQh0lPRljrF0Dt5VnwJLl/GupH4uyvLtJkx5sjyOlES32Z6Z/Ldn5i
         aAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712003629; x=1712608429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QA39XfS6kFKT4ejZVfv3YPVU/6vd+JV/fWoR8cy3Hug=;
        b=cKIPPriPBfNP3q6V8nC+E6mJaGlzAIg5buP4mt+dQMyfdY4KqHhDFfQnHh7Bwpb5IR
         e/nsxluZzyeKRbIuScbnTS+Bq28/QNYqWXUNF79vrDRJVF2MPQ2x0GK815CTkGsL14sV
         tvfwhA3OUezLpnRFQ13zwNgeX6l4bbzhO8d7+MSjdRYU2DQhIDqTYWrvOm45CgxJOuW2
         HP7YGKhNE4OUbXuUaDPUY5CnjY2efcevigpRpNLBGvJNQivDn0rDMv9veCw8160hH6iA
         wI3DfVTBUoRi3KwrEwVjV/RHAl35gA2rjkzI7VwgEikEnp5I0tQRyInozEJlRtE97IoM
         O5Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXlL9gfsUuUZQkUjy8yDk/Vy9LnMUmRPKP262o7DhWZUKAJUx0yNhirT5U1DAaHWpatOO/DgjWiNrjO1V62BmAHGLXxZJp/58gJKvGW
X-Gm-Message-State: AOJu0YzUPQswwadu9rhKdqXhIRNOsK/KZcgl+POc3TUT4TOVZn5bWqO8
	gKksGwiKKX/HsiuO2TUpGUOXt8yamzTFFn2n60h26BlCML9tcHq0I+XjLliiet4=
X-Google-Smtp-Source: AGHT+IEX2xucaNOqEi45e6rA7xWiaBbHHqTl57NjxOHbuJYOV2LS1R05RrcHUWwFbQgnVwIACR9hfA==
X-Received: by 2002:a05:6512:3e4:b0:515:ccd8:37c2 with SMTP id n4-20020a05651203e400b00515ccd837c2mr6005739lfq.44.1712003629119;
        Mon, 01 Apr 2024 13:33:49 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id j11-20020ac2550b000000b00515a6e4bdbdsm1478342lfk.250.2024.04.01.13.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 13:33:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 01 Apr 2024 23:33:48 +0300
Subject: [PATCH v3 9/9] arm64: dts: qcom: sm8150-hdk: rename Type-C HS
 endpoints
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-typec-fix-sm8250-v3-9-604dce3ad103@linaro.org>
References: <20240401-typec-fix-sm8250-v3-0-604dce3ad103@linaro.org>
In-Reply-To: <20240401-typec-fix-sm8250-v3-0-604dce3ad103@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=948;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=+m4KcknPtPtiYtZonTjzGx6OYYK5R2lRlFqksVKoy6E=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmCxomu5aU5NG+Z/64wI5iPLxDf2d2pJXxtC/9V
 Rx789XMZ+WJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZgsaJgAKCRCLPIo+Aiko
 1W9oB/4wBdn4/QHKK+hmLb6lInouPt5uF6PHRC0lKI3zIsxUg16wXXI51U/eaV/RNDk9pdHaLT2
 cOAt0rJnUmgWfnPWEay58qAIQvzAsCrrcWzaa1nxo1b6l77uZiPOS2Q2WjUe/Bodju8/nO/lOAK
 Bp4IJsH/hI5PJxhM3OrE/3Vb843jIurkukowYDFHkLW3optfQyWNSA4K6q0dTvOpwEGR1unUtQ9
 qkVDpDGcLTwEnhwmEKJqzYecFpVqA6h3i1bC+UQHJngXJkCEAN3y1yrbidup8fJybfWBIBRZaMw
 KoPnzwMlDq2mGU0o7eeJqeF2tCOieBcQVC0svm+3y/5XIszQ
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Follow other Qualcomm platforms and rename pm8150b_role_switch_in to
pm8150_hs_in. Corresponding port is described as HS port rather than
role switching.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
index de670b407ef1..857ccc5de085 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
@@ -556,7 +556,7 @@ ports {
 
 			port@0 {
 				reg = <0>;
-				pm8150b_role_switch_in: endpoint {
+				pm8150b_hs_in: endpoint {
 					remote-endpoint = <&usb_1_dwc3_hs>;
 				};
 			};
@@ -703,7 +703,7 @@ &usb_1_dwc3 {
 };
 
 &usb_1_dwc3_hs {
-	remote-endpoint = <&pm8150b_role_switch_in>;
+	remote-endpoint = <&pm8150b_hs_in>;
 };
 
 &usb_1_dwc3_ss {

-- 
2.39.2


