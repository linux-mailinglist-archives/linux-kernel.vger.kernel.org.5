Return-Path: <linux-kernel+bounces-132665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BF9899838
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADCF1C21810
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDC615FD1F;
	Fri,  5 Apr 2024 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJ5y7dHV"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361D615FCE7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306500; cv=none; b=afSmwy521LfLg1RofiX7NMO5O3T4sg4vyPrxuC+PNhJPGOVWyJFTWKDugQ+LWJErAuNmC+xiAqeT5T90f5iWznejMmpt+fbfT1LpRMqKoNu5HzlbVzP/O+fer7eCbTbq4eaDv5E/8U8MLNgPvhw3r3wyOPR/nupzLcnckp+ti+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306500; c=relaxed/simple;
	bh=QbBX+3ptX/vEM35+LrbeCca6Amf4o7uxf9unmWCmhUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aMnDBUVUI6jschIkwPCCBFnjK5J0FEZXoNwsFn+XjxeeM1cYo8BhHM5Hq9PAbIVvvomZ7r7vnsz860GXVh4n9ql+r6XuI4IX//OeVW4qdP+ybh25etpDjWBaquti8Z79CVfKPaL8N0yORVcKq2JKNdYrnEjKh96y9deFJk2Qm5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LJ5y7dHV; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d71765d3e1so23057341fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 01:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712306497; x=1712911297; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMQPSpYP56c6J9vLcqBPSaIPmeQARU36ywfjOCBX01Q=;
        b=LJ5y7dHVZnaCpdZ7cnMqV2GZ1CWwPZyahqWqAqKfFuL6PEZrMfO+fUjbPED3TD1Lxi
         Gw0VU2sV4DIMUQ3hSgJtx6Y15qEAoDoa3GYF0bNPEVC/ikAEN2E0fRkq02/BWCa07cVU
         qZJ+T63MAXM07PxbDYZQPCY+ehxXqRqEDs8+mAn324n9grQCerGBpy+je/BR5NfgwSPV
         p6MeSdmfCcBWJsF+06Y35OuP1Y4nbI3IRQNXAXQUDFf7oTtr3K99D7Axsd87a9tvFRMS
         CkEukETbyLrq+dIZLE1CJp1DQlIkCxF2+olarHJiznfXR7zTLwT9TD6Pm2uj7Lii8oSF
         8dfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712306497; x=1712911297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMQPSpYP56c6J9vLcqBPSaIPmeQARU36ywfjOCBX01Q=;
        b=hX+JW80AU3I6bAYKrGEy/WPKfYdS/XNE26Br9NIWw6d9RMp7sPpFlryNrjSNH0bxUm
         T6CJCfdCfsZZ4eO7PC6so8tU1jEZJV24eDfvKelNWN9GsLILBrUvN2GdEb7mizjbg9xY
         bQif64dniwCA1zE6GtCnMbHcKFLpqi6TqKjBYpY2FrTOW3Mr8IsKwYasxGN8jazJ29ix
         042YOdy3lNeyvVzVgXiTT4qYx59qc8FHsQBkTZhsP9SvaJTxXXJZIt1LrV/ajSlozH4b
         wwmVzSgm7tqq356qXeDDgLEj24c8bp95JkoyV4otSa2AMHF/4JsD3J+segrS3n8W1/aj
         kUAg==
X-Forwarded-Encrypted: i=1; AJvYcCVmHT96b/oHRNii3o0FzItKMryqtpwBXpAkoanStsbOaap7RO8K6tE7vyfTTgW4WiodZKH9iZWOKD7qz/mvEM8mxDGC5xtE0FqnQx+Z
X-Gm-Message-State: AOJu0YxFz/zuG8S+LxVNPPogUbfF2CTdGLTFPR5+AGebaU5rR7u9BC1G
	vi0GVpUEqZhs1geRcz/i2xRJsszPmfBc7+1zOJeWpyJEVaZFD38Oo1lfVqtZjyM=
X-Google-Smtp-Source: AGHT+IGRGwh+Bw1TVzd4MvJb8LHdlr/hhr4GZWQTt68CsoYHGEkiFJ07eVdIxIF1UV+Fa7fgy94vhA==
X-Received: by 2002:a2e:9b4d:0:b0:2d8:4c05:64d with SMTP id o13-20020a2e9b4d000000b002d84c05064dmr720157ljj.16.1712306497545;
        Fri, 05 Apr 2024 01:41:37 -0700 (PDT)
Received: from [127.0.1.1] (netpanel-87-246-222-101.pol.akademiki.lublin.pl. [87.246.222.101])
        by smtp.gmail.com with ESMTPSA id y3-20020a05651c020300b002d429304a20sm116880ljn.8.2024.04.05.01.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 01:41:37 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 05 Apr 2024 10:41:31 +0200
Subject: [PATCH 3/6] drm/msm/adreno: Allow specifying default speedbin
 value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-topic-smem_speedbin-v1-3-ce2b864251b1@linaro.org>
References: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
In-Reply-To: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c

From: Neil Armstrong <neil.armstrong@linaro.org>

Usually, speedbin 0 is the "super SKU", a.k.a the one which can clock
the highest. Falling back to it when things go wrong is largely
suboptimal, as more often than not, the top frequencies are not
supposed to work on other bins.

Let the developer specify the intended "lowest common denominator" bin
in struct adreno_info. If not specified, partial struct initialization
will ensure it's set to zero, retaining previous behavior.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
[Konrad: clean up, add commit message]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 0674aca0f8a3..4cbdfabbcee5 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2915,7 +2915,7 @@ static int a6xx_set_supported_hw(struct device *dev, const struct adreno_info *i
 		DRM_DEV_ERROR(dev,
 			"missing support for speed-bin: %u. Some OPPs may not be supported by hardware\n",
 			speedbin);
-		supp_hw = BIT(0); /* Default */
+		supp_hw = BIT(info->default_speedbin); /* Default */
 	}
 
 	ret = devm_pm_opp_set_supported_hw(dev, &supp_hw, 1);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 77526892eb8c..460b399be37b 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -110,6 +110,7 @@ struct adreno_info {
 	 * {SHRT_MAX, 0} sentinal.
 	 */
 	struct adreno_speedbin *speedbins;
+	unsigned int default_speedbin;
 };
 
 #define ADRENO_CHIP_IDS(tbl...) (uint32_t[]) { tbl, 0 }

-- 
2.40.1


