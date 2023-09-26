Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718B17AF2A5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbjIZSY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbjIZSYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:24:52 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A008CBF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:24:45 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-534659061afso2136785a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695752684; x=1696357484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rdOeaLeHcwftMyYfA8G29tOCdXwXQaoJFb0mcu8r5zw=;
        b=i24kSgq2i8rJgR+WoHufsvGJOPIKXRKuuFpXtAdJkKiFHCf2dGEb1X1ZjjLieX90hm
         tIDtmI9LbwoUrIYh7QjeMuSOLcmBWfjZ50bg5C7iHdOnfylSZ/02EyNGxcSX4i20TzGz
         q7nrmI80zuurD7OUCpjWmNa0E5G0B4gUIgSclHeqQ+AX3pj/iwg779o0I6wiODgbYnJ5
         sAu+uCS0zl0OJeKLDRyZbjNeygz+NOIGQNUZdljiChK8JYXAnvS44yMnawqa0Sf4kMq2
         G8lk1J9wzHnhVWsgHSWJglcGVvodjSX5rvNIYH5hZFen3/n0J0zvFc4o4FGK/4026HQk
         hRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695752684; x=1696357484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdOeaLeHcwftMyYfA8G29tOCdXwXQaoJFb0mcu8r5zw=;
        b=GYEJXPvPaxNhw0KPK8SMfxjk7HK4yYw1grevbH6vUQnibrUWiFcoYDoXWqVxG8iYe4
         M0IEBX7kVPLaTgs+PRThByGXGmOWC7YCa4T9fKWE5+xDtFHfHMiSE61zl98x4IxgewbF
         WyjN5rvgGGCE6gdU+wVHMuQB21E47DEU6ci5hzSksHWUyxhDFAipZlyLDTTdgvReIA0u
         YoYc4ZXU8gckXoe0mAhTZ9pyA5DnnXXAtc1+iyPL1JESEn0mXq7n1WQfrxvHfZw931A1
         9FeeaY5PNxhzCw15UUrMHCckHlljiJ9xH0MY7tw5k3Jo91MF7siHjjUrvRQCfWzkYRQh
         LGpg==
X-Gm-Message-State: AOJu0YwAsiy3w3pfizID+bycTqhVy8WCF8F1xqymhSi/O0UQjFqz5e0z
        M7lyt0xmwUJjbND3rr0scSgZ8w==
X-Google-Smtp-Source: AGHT+IFNPKWtqP96Z/0gyVWxTahuOivQkjQlQvuDt3caSQC/FoLkRgSGW7croA7ASQ1ChCEC2PL20g==
X-Received: by 2002:aa7:d0c2:0:b0:51d:f5bd:5a88 with SMTP id u2-20020aa7d0c2000000b0051df5bd5a88mr10428662edo.38.1695752684159;
        Tue, 26 Sep 2023 11:24:44 -0700 (PDT)
Received: from [10.167.154.1] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402151300b0053090e2afafsm7020643edw.22.2023.09.26.11.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 11:24:43 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 26 Sep 2023 20:24:37 +0200
Subject: [PATCH 2/7] drm/msm/adreno: Add ZAP firmware name to A635
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-topic-a643-v1-2-7af6937ac0a3@linaro.org>
References: <20230926-topic-a643-v1-0-7af6937ac0a3@linaro.org>
In-Reply-To: <20230926-topic-a643-v1-0-7af6937ac0a3@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695752677; l=810;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=j4J3bf93En8hfomc6iMl3gRDui2N6DxaHKguZItPSOc=;
 b=Z/8uVHWeeJiYMBhmKxURKKCY6E5ujoQW1IdowESmbyutCxeRpM55YuxSzaiPf3F/h1M6I0ebF
 Yo50w8YlEoVB1iHo9jiNgpsMDNM+4THYBPUM/ETvorOic57gT4f4kk5
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some (many?) devices with A635 expect a ZAP shader to be loaded.

Set the file name to allow for that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index fa527935ffd4..16527fe8584d 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -454,6 +454,7 @@ static const struct adreno_info gpulist[] = {
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			ADRENO_QUIRK_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
+		.zapfw = "a660_zap.mbn",
 		.hwcg = a660_hwcg,
 		.address_space_size = SZ_16G,
 		.speedbins = ADRENO_SPEEDBINS(

-- 
2.42.0

