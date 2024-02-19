Return-Path: <linux-kernel+bounces-71415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1A885A4E7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6061F21C37
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F69383AB;
	Mon, 19 Feb 2024 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ssl4sjxJ"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B66C381D4
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349778; cv=none; b=p0T7Rbiy/hQBdYxWfYA7HPdLM+WfpxX1wN4Qhg79Jrc49NjIm89oC0CfBNg+TTQXRJsbLC0IvzqX0wje0D26nsQcBycnyCGnHSjz2DU4jAj5QGsjab0UnoGU7Ss+GeVSazg/pbyC7z41KrigdAalWmkOSJfT2oEP2ePms9TiGyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349778; c=relaxed/simple;
	bh=2VUaTHaFXwk9sVr7gsAachnQpNO5KMem0UoFA2HST7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EReeqXtuz0t6V4EGJX1f4n5uc9IyiSJHIz1JkrC566ul5nYYP1vckmgyza6O5Q9dJNN3NsBBkN20nzvyVxjczy1kA0cIls/AXMyebAvgZLh9LKyint+hd1ZQmcIWZlH6nk39iWqW6duyWS+nmiKw9xuIpWSDKYEwdHugzztKEps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ssl4sjxJ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563c0f13cabso5101618a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 05:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708349775; x=1708954575; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjP12Zq06nby7HMeSJ/EUbYJ63ENO6BkYD8FuiAok6w=;
        b=Ssl4sjxJzcFd5xYTrymLfoecsB/HfYk80Nsw0Mxn6tDSn3jWgV5ZPbwuAOmEe1fZnq
         sD4gOctRV2VQ7BnZY5Dij/U52+ulKuvIpRA531mBxCcA/sx8TmJIVeejHeBDJC9xOrTm
         kiSoBXGIt74y/Psdnh/yRyJuMOxc1BmDR5e6uGqcs23g5f7RG71KAvdpiJ2/5D3hvmia
         beEXxa8PZULntObJ2g+4TLS8W+/YlDJ6K55YPyR6dZAoqMzSL48n1qLmn4d1ca6q2Hta
         KLkFibEIT2LtzH+Ku2minzw7yp2n5yYeuMmcFvVoE0FjfGR4EMLv2nbN+E53X2JlRlKo
         cfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708349775; x=1708954575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjP12Zq06nby7HMeSJ/EUbYJ63ENO6BkYD8FuiAok6w=;
        b=uOai4zbJ5aldE97qqm/TeBCJwzxZb7+riXNvYCtvsc4cjp8zmozcH/4AalaIo/j2IC
         Bt55NgJ2deDi2f0UtgdCyCFFlyt+vPyeqFXyO9xGEuhCn1XWIycXGAeZoCm71Eup9yo2
         MGaZaT/rcb9bpbXkV6zVrausJAhRIya1XOJIVlpvg1F0piRnpCjzDNtoNfwvxiuaeSBV
         EJky/OcVWOpSo2d6UbIBZq+DwX/cmA+JDw1kEL8jriLfoUUh3Jv9yAbo+weXf0inORKY
         dg+xP6H2PC3qQT42fMt+hJeujVYB6ERT9KXIMCnVtcQS6zDLGNYjlHIR77d5E1xzeB/U
         C+zA==
X-Forwarded-Encrypted: i=1; AJvYcCW7ceHempkszbq/ikfGCgT3eIMsZ6uUnYTPE4C999CfJEl4ClolXIX51KTJEEj43JhDMvQUQ88bIw4EJjN6TDSSzqXlD2rfYmCbYq3k
X-Gm-Message-State: AOJu0YwMF/kjlpPV3WaswRibhkMbPUpPyjMX9d6zBViH0M8mIoObNR5Y
	c08npqZcGbOTImAH/yBmuj4Pz7jvx24Dz9hwrbGXuatJu1vFEglMYFtK1Vvn+Y8=
X-Google-Smtp-Source: AGHT+IHMjM8WymNt4vEQq/mCWKYvpVNBNNxjTt8NZU0BjV3r5AoZ1THDhcM56s0PPBQZdIzF6HDHNg==
X-Received: by 2002:aa7:db59:0:b0:564:ad01:20b with SMTP id n25-20020aa7db59000000b00564ad01020bmr139795edt.25.1708349775056;
        Mon, 19 Feb 2024 05:36:15 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id q29-20020a50cc9d000000b00563a3ff30basm2900168edi.59.2024.02.19.05.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 05:36:14 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 19 Feb 2024 14:35:50 +0100
Subject: [PATCH 5/8] drm/msm/adreno: Add missing defines for A702
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-topic-rb1_gpu-v1-5-d260fa854707@linaro.org>
References: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708349759; l=1379;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=2VUaTHaFXwk9sVr7gsAachnQpNO5KMem0UoFA2HST7g=;
 b=uy8b7slouVEaFRzlMDQaQuGj6/EdLKuvoxlWss5WCvpYfkQIMuuko+sE6v3X1yKkbgzKjx7sS
 Sr/e/dPpNpcCFZmvXDeCJmc5sQgAXJeQ/E2oSh1XTeW54gedzNfKZ7t
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add some defines required for A702. Can be substituted with a header
sync after merging mesa!27665 [1].

[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27665
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx.xml.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx.xml.h b/drivers/gpu/drm/msm/adreno/a6xx.xml.h
index 863b5e3b0e67..1ec4dbc0e746 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx.xml.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx.xml.h
@@ -1945,6 +1945,24 @@ static inline uint32_t REG_A6XX_RBBM_PERFCTR_RBBM_SEL(uint32_t i0) { return 0x00
 
 #define REG_A6XX_RBBM_CLOCK_HYST_TEX_FCHE			0x00000122
 
+#define REG_A6XX_RBBM_CLOCK_CNTL_FCHE				0x00000123
+
+#define REG_A6XX_RBBM_CLOCK_DELAY_FCHE				0x00000124
+
+#define REG_A6XX_RBBM_CLOCK_HYST_FCHE				0x00000125
+
+#define REG_A6XX_RBBM_CLOCK_CNTL_MHUB				0x00000126
+
+#define REG_A6XX_RBBM_CLOCK_DELAY_MHUB				0x00000127
+
+#define REG_A6XX_RBBM_CLOCK_HYST_MHUB				0x00000128
+
+#define REG_A6XX_RBBM_CLOCK_DELAY_GLC				0x00000129
+
+#define REG_A6XX_RBBM_CLOCK_HYST_GLC				0x0000012a
+
+#define REG_A6XX_RBBM_CLOCK_CNTL_GLC				0x0000012b
+
 #define REG_A7XX_RBBM_CLOCK_HYST2_VFD				0x0000012f
 
 #define REG_A6XX_RBBM_LPAC_GBIF_CLIENT_QOS_CNTL			0x000005ff

-- 
2.43.2


