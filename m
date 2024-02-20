Return-Path: <linux-kernel+bounces-73166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0076E85BE81
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820351F25005
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817F56A8C8;
	Tue, 20 Feb 2024 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pdc/qalD"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E455A6F06D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438578; cv=none; b=WLGky4Rib3DU/BGn9oNCl6/bErfLC8Kps1Jz116C1vXWy4fAaMa6XrYmhnl2H/4Dm387h1IqtEC2SQibjDwwtYqQdtyueyhW2xXa5iz+LsS1LU6tonEwV8J6eyaPCOYeQvfaUU81vCcGZQElWsr5tvTjPPBCNe6KZ44q/PoddGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438578; c=relaxed/simple;
	bh=u2lRwHQr+DNTmD6MOY+Hc1uiaIEemJ6XjPTAocMI6pg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N4WQZbYfbMlI5t8ncDE2Ltn7DZweWb0SZSjC2qvJnL0NhYwxJRSMU77jMnQP0tp+d2uJwlPjgDHKLNcNHFI17n/NrtTrgNAA3F5XnACPuwW+VgjXuUm6SUkBsN9P53JOiyyd7tIN6LCqnTRNEOGKCeue127ca36mtHfTQ28wRmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pdc/qalD; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so5811654a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708438575; x=1709043375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuyUU3yi15kmc0JQ2NK+KRF8Ebxp3j+SrJjLGk5UHWE=;
        b=pdc/qalDKGwJWtdd9F7zL/lstPzHhMrNCp3NcwE1XIDeEsFH5JQ75joO2UgqVyRZk9
         pTUIv2J84vGje8vPzeXQlaIUiaB/IGouMzkuBe6UBhQszTO4znQUEL067IzxGpUA8m0n
         JFCzqNs/bva7/TLHC0+Rfjfb/5G+hvG8Jc6NmamOvU9bRvKQ0Z3k+SjSE0h3bC7iSJzS
         N4nhYoFjbdHpg0rvohnak6Y4DB+0qKJQV+D+sKEYZiIimsDQmBK3JSqUqVZx7COMj26p
         MI45RMPT0XAl4SamU2Avf6ZZ8AXVUqK6kLS9l26nPH384pvXO77r6l4u+L3is2rMPiTp
         5dCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708438575; x=1709043375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuyUU3yi15kmc0JQ2NK+KRF8Ebxp3j+SrJjLGk5UHWE=;
        b=E4hct2YmFqvZEWIZMk3H9ZzZoakwM2e0cYyXU2hnWD1zSoQdzDsTSLXk7F3u45DtrZ
         OKA42lsvDtJEmLi1Wn0/uS7GaL43uZz6bVGd6Gi0KO4ENdm206jsj4c6Ona34L5jCVsO
         w3lHnNUUCqq061/TKVpfoTnl3jNKv7HtXbU77BNX2Lry5vp0+PwCIDbEtnw7J/ZQJPcE
         fvmxry/2eppXeMZozIg/v3GgWXN3NWZgofXV0gOkzc/AMHzA2AeEMXFZjH9WFKsbZ3ID
         xy7HfxurWBAHHRtWVZd38KhfN24bHy7y96fZE9anJj/5R5RVE4EwVKNK7yKafiTErv45
         ch1A==
X-Forwarded-Encrypted: i=1; AJvYcCU9+n5tMeoPjrt7a2EJld4LybRTxfu/rm10WJfTibspqRoq9T4D0aikSGdtEg0guYxT2GX+EgTvn9Hn6AvGldoEla4p6kOEcHnShvqL
X-Gm-Message-State: AOJu0Yz2rkobMLWYGnHl1LB7QsGb23dFDsMliP+JmDL+LQZrNgmLWfxo
	AXPO7UMBJrmlLceHfKAmpxmXbKu9/vtKX3BuBGU9F6EqwT4V/OPHrnQ5k3Aom/w=
X-Google-Smtp-Source: AGHT+IECUFBhZGWCW/eOe/rUJ51UGWQ5S19p4bZtDBtlo6u0dqqv5FQRLFS6KHy59qUVzGO1BibIQQ==
X-Received: by 2002:a17:906:48d6:b0:a3e:eb81:ab62 with SMTP id d22-20020a17090648d600b00a3eeb81ab62mr1923965ejt.7.1708438575151;
        Tue, 20 Feb 2024 06:16:15 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906500800b00a3de4c7bf00sm3998534ejj.79.2024.02.20.06.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 06:16:14 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 20 Feb 2024 16:15:58 +0200
Subject: [PATCH v4 3/4] drm/msm: mdss: Add X1E80100 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-x1e80100-display-v4-3-971afd9de861@linaro.org>
References: <20240220-x1e80100-display-v4-0-971afd9de861@linaro.org>
In-Reply-To: <20240220-x1e80100-display-v4-0-971afd9de861@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1429; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=u2lRwHQr+DNTmD6MOY+Hc1uiaIEemJ6XjPTAocMI6pg=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl1LQmpwQCwaM7h86l7n/lgwLER6BCHp8FIaw4s
 fSeFtMTqzKJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdS0JgAKCRAbX0TJAJUV
 Vmd0EADFMcoAAj5UThHklCNqyD/WAnBBW1CRjsolukiODmf2oSbkcpO9G6XiedqbIBOh/kavUsG
 7FlOh8qlEo1gR1CY4UUwRlQODaCbfMgzYqlh4gchEPmSubydMkZMCOPI51V8NiN382TRCGB5fg/
 2V4tb91dybOb8pVOrOhXfAO/Fs/rOY9deJIGCvWDinV1A1afxLR7Lng2iUefVHJnQWIDxGLdqMu
 OTt5x/e7Mt+GE9yMPpu95CJWIO0gh7B5EnHWDDkxfC2ZaOe3rbiA8s7eYYPYX0ZTMTAO3V13cZt
 iqzxigN9D76pKtpT4V0n9IiDxCh5RofR4mB52tpc9m7HPcAV3iqzrz+d7EQhhQ/LC7IrORFWZ48
 X7s/cgawdWVoustKBZTufdlXGuchGIS2uisf2o23Jy81Of85ajUP7O6Rs6h6gID6PjU7P8aayjQ
 B75tUOWme28NLtaWnD24Wo3lW9HBdDyudt02y+DL1CYDdarSy8EQMotu1zMMUT+Bpx/yhWVEgGW
 tjmUe2av10CCV6DQWdIhLR36b9CJAKsdiLR4iyXxUxeiE1wdgmGuhYipSa1oP7x6ro58g3RsYnY
 j0qxH8yewcX+e2o8xEAhgzykYOoxysKm8JrxA4mbJVJflcRfGW2TFArf9zM0mg9TUxrP30ojNNH
 xTCm/e2pakgsFrQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add support for MDSS on X1E80100.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/gpu/drm/msm/msm_mdss.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 65657230bbff..fab6ad4e5107 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -687,6 +687,18 @@ static const struct msm_mdss_data sm8550_data = {
 	.macrotile_mode = 1,
 	.reg_bus_bw = 57000,
 };
+
+static const struct msm_mdss_data x1e80100_data = {
+	.ubwc_enc_version = UBWC_4_0,
+	.ubwc_dec_version = UBWC_4_3,
+	.ubwc_swizzle = 6,
+	.ubwc_static = 1,
+	/* TODO: highest_bank_bit = 2 for LP_DDR4 */
+	.highest_bank_bit = 3,
+	.macrotile_mode = 1,
+	/* TODO: Add reg_bus_bw with real value */
+};
+
 static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,mdss" },
 	{ .compatible = "qcom,msm8998-mdss", .data = &msm8998_data },
@@ -707,6 +719,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,sm8450-mdss", .data = &sm8350_data },
 	{ .compatible = "qcom,sm8550-mdss", .data = &sm8550_data },
 	{ .compatible = "qcom,sm8650-mdss", .data = &sm8550_data},
+	{ .compatible = "qcom,x1e80100-mdss", .data = &x1e80100_data},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mdss_dt_match);

-- 
2.34.1


