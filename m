Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51E4774C40
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbjHHVDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjHHVDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:03:35 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7510E30EB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:03:02 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so3153771fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 14:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691528580; x=1692133380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vyXbhGhn18q2epfu4SWH/aQDrzkgDXaFIhnNbGtGC7U=;
        b=VujgEBjwyScdy4krYp0PsisUqplwWaZEowKlMh+MXClybDubRW1i0x4zIXf+cBxDC8
         DwOo9NWhfAObZdHzDVck9UugL8XOeJkkWzMGhGpk0cQTs605Ww9IhwQjL/xtDd6dxa5k
         y8BfiC2JqDSi1HnrcRRVR9XjKIpUTJb4/wl6ONuWTKDqfAA3WNVRt+iFBLtTJf992jk+
         XTOxtJvZuyVsTc4/8IvcLtOTdiq54fgYZaK2QCLbMZskAoE5V4vY3Tr+hC1g8DjEkuIX
         0M5cQ/tXZgQYD7nC39CcNZN+Mw6Cx90Njg43yHRNmV1918sPXf3M80BbtYb0PNSprQww
         DoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691528580; x=1692133380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyXbhGhn18q2epfu4SWH/aQDrzkgDXaFIhnNbGtGC7U=;
        b=FHkZfhM6EivezpD//CjN9YdWpIiEwzNlOXKVNjD1P++vY7BMyoNUwSL8KAe7JYOsWD
         anE2R2DKCCAL0Mgv48mg8FXDRN02AbIKqE6/1isznMuOhMulaOTM7E1DOwUXmu5UMxYi
         6LZ73KLkhzX5FM9VQz9NdrjGrGmGHbEgMp5A6mrtOgq9SlxuPOT5PF7Iu8Kf/ZCn2+kO
         BrXH24jcRkWH98NW4XzBBd8X14KrQGrvSuTXY3gre0XstfASWJJTMXW4T5AWBtDCnbbx
         lu79fhOV0e41VaFALYv1F2gnTeAZtvY62ECqD6Wpb9ZCnkqHxQSLKcQvn1k7GWkwKRyZ
         wJtQ==
X-Gm-Message-State: AOJu0Yzvy5oRdwihUw6WZfRgFpTkDOSXbXxwB3A8XxtEnnrEQH1+LTYF
        4l/mzkhqsFba0qemxw7cTb6ATA==
X-Google-Smtp-Source: AGHT+IHoV1oF15QkBUldmZLMCtLPoUuJyJYtuXzGep5+KTw10AGDZo6lCAtzJhHf8ovdFAPWY8uLkQ==
X-Received: by 2002:a2e:b547:0:b0:2b9:d965:fbf2 with SMTP id a7-20020a2eb547000000b002b9d965fbf2mr3284565ljn.22.1691528580533;
        Tue, 08 Aug 2023 14:03:00 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id h11-20020a2eb0eb000000b002b6cc17add3sm2431483ljl.25.2023.08.08.14.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 14:03:00 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 08 Aug 2023 23:02:45 +0200
Subject: [PATCH v2 07/14] drm/msm/a6xx: Bail out early if setting GPU OOB
 fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-topic-a7xx_drmmsm-v2-7-1439e1b2343f@linaro.org>
References: <20230628-topic-a7xx_drmmsm-v2-0-1439e1b2343f@linaro.org>
In-Reply-To: <20230628-topic-a7xx_drmmsm-v2-0-1439e1b2343f@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691528566; l=1076;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=eKaMrn2nEo1t9dG12+njAKjMPE3YGEK2vLhd6tZW2mA=;
 b=oYA7dxokB+2a54oH9Jf1VwY7xcZib3TY3MJ+n+qR5kxnmlSD/8n7GK/svGTU/OhFgcpD4UtZI
 we5G825DbTbCz3tmp2CUl7JV8Ercmly2mfEsQvY2f/8YthWHWlFypQk
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the GMU can't guarantee the required resources are up, trying to
bring up the GPU is a lost cause. Return early if setting GPU OOB
fails.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # sm8450
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 6dd6d72bcd86..d4e85e24002f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1201,7 +1201,9 @@ static int hw_init(struct msm_gpu *gpu)
 
 	if (!adreno_has_gmu_wrapper(adreno_gpu)) {
 		/* Make sure the GMU keeps the GPU on while we set it up */
-		a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
+		ret = a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
+		if (ret)
+			return ret;
 	}
 
 	/* Clear GBIF halt in case GX domain was not collapsed */

-- 
2.41.0

