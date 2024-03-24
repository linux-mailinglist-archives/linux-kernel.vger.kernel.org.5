Return-Path: <linux-kernel+bounces-112813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187AF887E7E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3351281528
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938B2111A3;
	Sun, 24 Mar 2024 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eV0IRH3f"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EDFDDD2
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711306636; cv=none; b=foiuNh9KQk72iGnjBWHS2UAoA02n2HwamPQgNmxRI99VojjDonhjteBbojzhNhX/562dZhSso2vV8qgKdKyKMmBj3H4d8vKFnbkak9Q8efRq7E/XKm1cuwhQJ1onECW2PrEAdImkg+ZUrgVo9LpfnT115+TkvEXmCpl/RCQSi28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711306636; c=relaxed/simple;
	bh=PkLbbZIwmrZ4R8j4F93QwuHkzPwVCdYCtB3RljpFxJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KoIGZOfnhBiYSMGvjlspK8XuCEx5wW0DNgDixlUSPkGQxJ0C774y+2twdslxBdzX/znXNNH7ZwjSqXCzYhroQcIS3e5yBtW2Zp3Zzh8wRPH7IFGKcU6zQKBgawLSAsb9+VpNGnbx18RhVMzVyZ4hpYV2y8tgeaH/MyoZS+4+SDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eV0IRH3f; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56bdf81706aso3222989a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 11:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711306633; x=1711911433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tVdKnRbHolCy0YCQM9W1+uOdyw8nD9ks6qcNg/Gsxw=;
        b=eV0IRH3fx+0WrzFqkw4gTlRQy9x/u05svlkVFG2JvCbo1otrbLdCfnHPozcQGpF6z3
         ZDicudQyXpa+UsjrFTsPuv2nt1GbiEA11z/IlFM4vjh2M1x17dBswS+p8P3239rEst4x
         5dolJrnarMw6G/fyGf+FETptxGte8XQvGHtzFB9RsMYzhckOMCLPviD5lUk3yuZthBOu
         x6TiZwa1M6N81fpRrYb1uf61VK7L1lAPVsfCMUj2RToOlPwJAyo/0pOV0TgI8oaXrUsm
         n7dc9VqJFQle+ujWhk1oeb5FKIK5puBJ2VEvlQusYZlg86AkdhUABTgw4vtQFLqDap46
         zNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711306633; x=1711911433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tVdKnRbHolCy0YCQM9W1+uOdyw8nD9ks6qcNg/Gsxw=;
        b=ggpg50QEK93K1R5NYlEWgEQ2bv0QmyU94tN69TrMECgxvTJIpCX49XH3IMBvmK5rvH
         ahpqMtGdaC+LLuSS2PBTxUho27ZYSU9JrmhGUULenFoTMdaRIyxtdP0wWNG3WG8bi3q6
         C8Y0ocXe5mYwz3kSWmHD44nyk6Ds3t6PM/POM+WNHmCRWZEkvnXekV9LfJoTvTzPcJuf
         161po3B3t07m2kdlkfkgsUJMLFR2AA3iotBrLny1LL6UBxKYG8fAJ5SpzrmdmFlGI3u8
         rQS1ajIV3XwQvzstb8CuHh8LwH0xYi6mY1FKoI5nksTBDgjXkZvOHmkkKGkGhs3X6cLs
         7Vng==
X-Forwarded-Encrypted: i=1; AJvYcCU1waMXM4juMhH0+mXZvOvvYtSHjBkKKIQPvkXPkHcGKUEZRuIZTVvt54R8oY72fq7YoUkbhy/SccTMNHAZo2JgDEw0llnd7bFBpSVp
X-Gm-Message-State: AOJu0Yzge7dKH6M5sNpNsnkDtA3s7ndHUeLr9FJN2RmkfHs+snUmSChi
	lnDcRDjcFisb5egFS92T/VpFLHSiLf/KkpOJe8bbKt1JX0t8wGnYKlOrJLD+OEtovLigh0MDQkW
	G
X-Google-Smtp-Source: AGHT+IFlYd+N1SyUJACbQyzR/wjIo0WO1tpDaoNq3dpNT1n+rRamvALgE4pqCFDWWqICzw6XTh9dvg==
X-Received: by 2002:a17:907:7e9a:b0:a47:a340:c9c1 with SMTP id qb26-20020a1709077e9a00b00a47a340c9c1mr1428858ejc.27.1711306632877;
        Sun, 24 Mar 2024 11:57:12 -0700 (PDT)
Received: from [127.0.1.1] ([79.114.172.194])
        by smtp.gmail.com with ESMTPSA id m19-20020a1709060d9300b00a45c9945251sm2194008eji.192.2024.03.24.11.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 11:57:12 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Sun, 24 Mar 2024 20:56:52 +0200
Subject: [PATCH v4 2/2] drm/msm/dp: Add support for the X1E80100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-x1e80100-display-refactor-connector-v4-2-e0ebaea66a78@linaro.org>
References: <20240324-x1e80100-display-refactor-connector-v4-0-e0ebaea66a78@linaro.org>
In-Reply-To: <20240324-x1e80100-display-refactor-connector-v4-0-e0ebaea66a78@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1668; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=PkLbbZIwmrZ4R8j4F93QwuHkzPwVCdYCtB3RljpFxJA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmAHeCsdSOdvDkDbPs2pH76+yTRro3YCA8q9GcP
 YnUm/UMdjaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZgB3ggAKCRAbX0TJAJUV
 Vv47D/0bPwjqwBogmWH/gMYQiaOjOdd6oFTtCgEga2cRuC8pRUc/ojjgmMIeVDB38fOLJBWEU17
 p2QOOJKSWkeing/ZZqf883t2nfmg65Td2WSPkzyAc4l+y/joHDet+X9pigoK8ooI/g3/u+ZJrhL
 msjRbA4jbqtzUY1i31gywnPC6b/Na+fWtoD7ESMIfP89pn7ayOi+bkdgjcLLARvR6Je1f6RFkoP
 WOeAbwh42Ntxp9NdelGpTMn0qUMqmV/IhmtHPZkQNGWYIgC8HpI8NkZB4nINR42edrAgwmXmpnG
 Ww8KVz4SVaJakO4LqGpB/fjZB+tKlnqxhQfbWufuyAgL3Ny33wIz5v1ENIaV10CP76uTm1YDLo9
 bPLjNC97jnrRRCZ313O8TAKgVJ+SiynpC/yCPp/djnEB8bv5a3sNvDJNn1ZG44DuOeAgRzOFe7d
 /mVEZM20uyNkTMntw8BTyao/mVvHZ8KVekyVYb2e9IBuF8f8T3FoyZ95ZK9ID8WLSAGMJlIQ8gH
 2mNj/S8CzrQYd3NPuz9VAPaJq25EVGJBBk8iugr7DViW6IDzQHDv07z/mB8s0+EUDyKFZbxmSH1
 62rlNUJ4GrUCNXiF46OaRkmxqVnjYcI+bstOWoP6HeMmiI5kb7V7OeKt0QjIedIjhH2U+ac9cZs
 LSkgE4FXQkBq1vg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add the X1E80100 DP descs and compatible. This platform will be using
a single compatible for both eDP and DP mode. The actual mode will
be set based on the presence of the panel node in DT.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 9169a739cc54..521cba76d2a0 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -171,6 +171,14 @@ static const struct msm_dp_desc sm8650_dp_descs[] = {
 	{}
 };
 
+static const struct msm_dp_desc x1e80100_dp_descs[] = {
+	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
+	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
+	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
+	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
+	{}
+};
+
 static const struct of_device_id dp_dt_match[] = {
 	{ .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_descs },
 	{ .compatible = "qcom,sc7280-dp", .data = &sc7280_dp_descs },
@@ -182,6 +190,7 @@ static const struct of_device_id dp_dt_match[] = {
 	{ .compatible = "qcom,sdm845-dp", .data = &sc7180_dp_descs },
 	{ .compatible = "qcom,sm8350-dp", .data = &sm8350_dp_descs },
 	{ .compatible = "qcom,sm8650-dp", .data = &sm8650_dp_descs },
+	{ .compatible = "qcom,x1e80100-dp", .data = &x1e80100_dp_descs },
 	{}
 };
 

-- 
2.34.1


