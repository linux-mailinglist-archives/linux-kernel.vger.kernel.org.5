Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5163B7AF2B4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbjIZSZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbjIZSYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:24:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FC410A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:24:47 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53447d0241eso4042874a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695752686; x=1696357486; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1mXLi+0rIXccn25x+LJrv2RkBxKqdDr4aU+Gv5GVsoM=;
        b=qvdlTL4BzurGFCOGcZshuDnvSoaEC9Mq/N+iKHOo4GKJkciE5GyDteT1HiOH6cnNdS
         nU2G4VfEPPWJcotzqBtm52lE+xkBacPjXscnEZ/jfgXIMMeSQJeTpxmNV4jQ5FM/oQLe
         RAht6h1kgw0wDtNosz2Epv7oLPmzdngwgIhJwMv6bnkEY561e2Tgl2e1Y5SE9+HE8bT6
         Arbep1HaJaAU5vBy6WXgUjPQDEXZFtUEP2t2uqXrB7Mqbmh2uBPLXGV6wGIEYhq8uIlT
         yFsgqVm2+9ZZy3mCZIAvShjXXA/CeG1P/gElwVML657qUEMXj0zX3p1rubG8ii76HR8h
         Tj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695752686; x=1696357486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mXLi+0rIXccn25x+LJrv2RkBxKqdDr4aU+Gv5GVsoM=;
        b=FGRwwp00rlDgq43j9cp8chvURa97qQfHBYqPJjc3b+m95tozlBMwMzVQ3KBRhc4EuY
         OoBMYeghgkHXF68qAJ6Gr3hRB2mA5bR2YGKjzapzlX8DbQk04XBWgluvciFvhXCKSdKP
         NmTYp7aCSlq+qFZyeEjWXGR6yapsfhVV0t346KfpLQvBcQlXHZvG52P9bOrH2Vgp7wzf
         f3yYHp3BzjrxJoL0jm4k0sXFMY4KKX67HTUu6cf6iSfYD6PFzrrBNrI/nJ6hv8spl6zF
         1X2tXALRQmwwUIbTaTfjuRVkH4E2aLFwbzPJ00ebfzNlRKg6SrMfXJwLtigg+yTnR8pq
         8aiQ==
X-Gm-Message-State: AOJu0YyGO2ezVFh+4cmJCaC8zL4PD5+DwN9kNdKkxi8zZi8W+TDGMIrU
        ryRhV/GbhUy4/PrPMRSF3a30Wg==
X-Google-Smtp-Source: AGHT+IGh0ktD94Pk4wwsYiXRvrPoEyd0YO/XrDphwvk3G5mbEos4//shaUTYKbj122Zo01fAUAE68Q==
X-Received: by 2002:aa7:d7c7:0:b0:51e:53eb:88a3 with SMTP id e7-20020aa7d7c7000000b0051e53eb88a3mr8851616eds.25.1695752686393;
        Tue, 26 Sep 2023 11:24:46 -0700 (PDT)
Received: from [10.167.154.1] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402151300b0053090e2afafsm7020643edw.22.2023.09.26.11.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 11:24:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 26 Sep 2023 20:24:38 +0200
Subject: [PATCH 3/7] drm/msm/adreno: Add A635 speedbin 0xac (A643)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-topic-a643-v1-3-7af6937ac0a3@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695752677; l=751;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=4Rw51EV+m1pbTmR00ftxlMR26PkphHnsyFSR2kZ1LeI=;
 b=SXUVrGfcSRMs/58bky5kYAUilsScEIoXeRRt6NDpibqMT9twn8G3KlhPx8o0SOlAHp7e6EZAZ
 ljAxQUAiqQsAsx7kSjWbCIUQoLnRFJOt84DDBQzWxWuw9V//8Y+N+Ur
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Downstream calls this the "speedbin 1", but that number is already
occupied. Use index two.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 16527fe8584d..4977fd759b5b 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -460,6 +460,7 @@ static const struct adreno_info gpulist[] = {
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0,   0 },
 			{ 117, 0 },
+			{ 172, 2 }, /* Called speedbin 1 downstream, but let's not break things! */
 			{ 190, 1 },
 		),
 	}, {

-- 
2.42.0

