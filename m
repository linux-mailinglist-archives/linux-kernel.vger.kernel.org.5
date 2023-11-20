Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAB47F12F3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbjKTMNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbjKTMNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:13:17 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD996E3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:13:11 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-548a2c20f50so1682282a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700482390; x=1701087190; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQ0ypSe1N8mypAau3OPEaXjK2/eDjD7aM7p9a0KkeYY=;
        b=ICP2DQGQDKXDfqZ+6Jqsi9twBZXRpaNMVW1c7+kAnQe5JDVHmpoyAUf45HV598eCRA
         oaQYdc9Kh8f0CbGhb3ch2ZgvTmOTSIqPPjH8zJ+rEoBBDWdJpkJx8MM3gU34NYCKwjZ4
         FVWDGGl8CkwRhD/rzVsQ9In/r+hNFnmq2f90U2QqCo9nzh9siGao93+/siXMDFhuL3r9
         WdMA9QvsvY2C+0eeuYR7/+hJ+Vvj7BYIj75NKFoOJyjUzTjOWpBCDgnV6MLXvpge5EXv
         H6v3AKQA+92jEHCAxDHOKs3bZeG+t3M0Lf44ZVwIlWtGU4qYOhFk988On8BBQ6nRLnwb
         8W+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700482390; x=1701087190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQ0ypSe1N8mypAau3OPEaXjK2/eDjD7aM7p9a0KkeYY=;
        b=ZA16kqriQ80Fx+yKUQsiYLqDh5exZlA43TvelcZ/9Xr85LvPH+FFI3G3lVdEtA+qfY
         j3lVtVrs5ngQK+fnrMidDm+ebP50AKiC1HqnRPF5mzjzJkuYe6SmBIbyYCJdDmBnuDG0
         KwN/uSp+LzvtNniln/bvc26CM/dRiaFRX2DBzPP+VNniAYKiKHpPRWw+mbZAt4jSo9lQ
         bPmGgeVZvVjg62SC2ukTwNMh5wHoTv74pxwHGOaaa+NJS0pp8xsf/Offq3UV89Vu0Lc8
         VnBsjYp8YIvGExt6bIdu0z+wL+satlOf/wIVq4PAQ4hnBPOYmjmJ3a/H+GQ02Af+FNgG
         14nA==
X-Gm-Message-State: AOJu0Yz8FE5HLjBnbBvQinrtRgB1niF7HnIauyczrdJwoc5sNB4ULUZb
        v8G7Wym3lLCmACtchT+6zZnQlQ==
X-Google-Smtp-Source: AGHT+IHgHEWqlDlsQXQAl07jhTuaRXFLhW6gDO2Rl+xkYrooOqkwo/D69PwFKDS16PgzgicY1iZj2Q==
X-Received: by 2002:aa7:d795:0:b0:53e:29c1:ae1f with SMTP id s21-20020aa7d795000000b0053e29c1ae1fmr6220141edq.19.1700482390140;
        Mon, 20 Nov 2023 04:13:10 -0800 (PST)
Received: from [10.167.154.1] (178235187204.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.204])
        by smtp.gmail.com with ESMTPSA id i22-20020aa7c716000000b00548ac80f90csm1324584edq.40.2023.11.20.04.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 04:13:09 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 20 Nov 2023 13:12:53 +0100
Subject: [PATCH v2 2/4] arm64: dts: qcom: sc7280: Fix up GPU SIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-topic-a643-v2-2-06fa3d899c0a@linaro.org>
References: <20230926-topic-a643-v2-0-06fa3d899c0a@linaro.org>
In-Reply-To: <20230926-topic-a643-v2-0-06fa3d899c0a@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700482383; l=1308;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=N2IVhDhpEh9zFeokJPv6QBy10GmMVdulaG7b6AuvP+g=;
 b=uG783dcu48EoyZtmTibdT6s18RnNyLq6HJ4ZSeg0kSXPAOezOy5rAXKriMyErZZssZNCUWxWR
 adKpfYAOfdWARCJg24F0tWOT8i81Lrg67x10qpdZ8oWQW/Nxp+Eihif
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPU_SMMU SID 1 is meant for Adreno LPAC (Low Priority Async Compute).
On platforms that support it (in firmware), it is necessary to
describe that link, or Adreno register access will hang the board.

The current settings are functionally identical, *but* due to what is
likely hardcoded security policies, the secure firmware rejects them,
resulting in the board hanging. To avoid that, alter the settings such
that SID 0 and 1 are described separately.

Fixes: 96c471970b7b ("arm64: dts: qcom: sc7280: Add gpu support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 58563f8fdc16..db47af668232 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2608,7 +2608,8 @@ gpu: gpu@3d00000 {
 				    "cx_mem",
 				    "cx_dbgc";
 			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
-			iommus = <&adreno_smmu 0 0x401>;
+			iommus = <&adreno_smmu 0 0x400>,
+				 <&adreno_smmu 1 0x400>;
 			operating-points-v2 = <&gpu_opp_table>;
 			qcom,gmu = <&gmu>;
 			interconnects = <&gem_noc MASTER_GFX3D 0 &mc_virt SLAVE_EBI1 0>;

-- 
2.42.1

