Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E097F9E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjK0LLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjK0LLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:11:03 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A80BB8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:11:06 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54b0073d50fso3552085a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701083464; x=1701688264; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWIIj+kvMy4kZX5d0cpQ2c41mKIu3M1tMd1Zqq8If4M=;
        b=P0qPLrQChRjPwk0jDlfWWHntaedfqnRP44hGX0tzwQ2YYpX0ElcdpMjQHP9/Q+9CqE
         8dd5DTnepnlMb12tR5NN14pa6WUIF6xtDD9StblwWq0TZc/vui/bB96gZ/poKXmT1nTu
         tYQsQCUAyu5FayqROS4/lV1OroonVLR57GHaDPeFjuEbQpuNreXMBmNuvreJgXipYaCl
         Rjtj+cwG2Phl0EoxipfL8nhVzNmHV/+XBYzfbyHFyFXyhdyZArjnEJWRhLcWasoJkVta
         gHHUyUrjXfLhxTh1MMtCBZNf/jel80mFUnDkZ66oHvXlFx9kesZ9+2sUD7xDl3wF73eV
         k9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701083464; x=1701688264;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWIIj+kvMy4kZX5d0cpQ2c41mKIu3M1tMd1Zqq8If4M=;
        b=J4vj45KEzgxFNqJXsQf5I4O/hyGQCTe4gnuh7P5GlFOBsZ1CesUo1CQtF9QDdqvNtt
         7tDMEkilgkG/JPv2iYcdIm16CenTaNpre4gCIcI60ZjW5sGnEKbA+38q1QLXIPyeBdST
         UVm1VX+KwrQl4k5j+rCh9Eiqzadi8YO9wNn3l8Gj3Po16w1EF2wr/slK6XZAQd3HMcPA
         BkHc5iAbIYaOkeq5RC69P3YHYO6h7Z2IePmyyGhyUUXYAkWrI9jTrDR/A5qydyQz/lXJ
         F9+jDIcuYsdwYEs3iQshkABk9fGdh9XVyPH0qU7/Cc6X/8eegjYvQA6O3v9vR3FK9Z3E
         y/yw==
X-Gm-Message-State: AOJu0Yw3axyCeaNp92DNSJ2TJA0v9cw5Chl7l8prIwzvIlmiYoMEEAsN
        GuLEsowA/Y6Utcz+RoHSUTKF8A==
X-Google-Smtp-Source: AGHT+IG3CEZbOjnyg3S3/SHsocbkM+WWXlxkYAiY7U4XFuHw4QdaJTyPvJ1fajsn0I7iYexaJtwE2A==
X-Received: by 2002:a17:906:209e:b0:a0a:f9af:c159 with SMTP id 30-20020a170906209e00b00a0af9afc159mr6033015ejq.25.1701083464551;
        Mon, 27 Nov 2023 03:11:04 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id n27-20020a170906089b00b009fe0902961bsm5537329eje.23.2023.11.27.03.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 03:11:04 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/2] SM6115 interconnect
Date:   Mon, 27 Nov 2023 12:10:58 +0100
Message-Id: <20231125-topic-6115icc-v2-0-69d05d90871b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEJ5ZGUC/3WNywqDMBBFf0Vm3SlOSnx05X8UF3Ga6IAkklhpE
 f+9qfsuz4F7zw7JRrEJ7sUO0W6SJPgM6lIAT8aPFuWZGVSpbkRK4xoWYayItDCjoaZ2um1a42r
 Im8Eki0M0nqe88q95znKJ1sn7jDz6zJOkNcTP2dzoZ//db4QlOqOJy0HrittuFm9iuIY4Qn8cx
 xfdFCiMwAAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konradybcio@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701083462; l=1377;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=KDSOgOJZ9OKDivLFVaAgoa4LgcSMlJhCVgjjK2+bl7s=;
 b=8kGfGfFvWPhFWeVdYOYNJHM+n5qjYW3NtvraF/dOYqRWNPyV/6xu+2xjJmt4MAytbgsKuA43W
 zQbCVYwqlC1DDp9vBTCbw7l30rV7oMdjVcQcvOT0iNW1d9TcX5KXKnh
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it says on the can.

Georgi, Bjorn, can we please set up an immutable branch with the bindings?

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
bindings:
- Remove unnecessary '|' after description:
- sort property definitions in a manner that resembles their proper ordering
- define clock{s/-names} before using them in conditional blocks
- drop unnecessary allOf:
- move unevaluatedProperties after the conditional blocks
- disallow clock{s,-names} when unnecessary
- fix up the example
C:
- Apply my own fixup (ebi channel configuration)
- Link to v1: https://lore.kernel.org/r/20231125-topic-6115icc-v1-0-fa51c0b556c9@linaro.org

---
Konrad Dybcio (2):
      dt-bindings: interconnect: Add Qualcomm SM6115 NoC
      interconnect: qcom: Add SM6115 interconnect provider driver

 .../bindings/interconnect/qcom,sm6115.yaml         |  148 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/sm6115.c                 | 1427 ++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,sm6115.h     |  111 ++
 5 files changed, 1697 insertions(+)
---
base-commit: 48bbaf8b793e0770798519f8ee1ea2908ff0943a
change-id: 20231125-topic-6115icc-a187f5989af7

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

