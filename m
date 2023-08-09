Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF347776875
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjHITVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjHITVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:21:05 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B2E3C30
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:20:48 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9cf2b1309so1728531fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 12:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691608827; x=1692213627;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sVxJJpzcYYfK3TLE6tHWcTq1QcT1ENtNn8bY1sBquA0=;
        b=MiLKH6m5rUcLO0KU+eQGJ8iVBj+ZdABFkFF9JN0DDrPyRkchV6dUcT0Re4p8bZVcBR
         H3UqZpJlEmyNRf8LQDATEmFttzf3uvaQFyrrswvMv57pec88Rm1I0TzBUZ6GlX7DqRl0
         BiCEJ3tzJIcr7JMpp7g24c8jdIJFom6e1vE+hGzwq145Ao8ccJPwutTqDv42dNElKfxe
         zScewUD1VLn98GboSmRdX6PO6SsiiFiQ4q74GaejrWGVaScrtL2kMqPEtJ+YpgH9pEHs
         N2IRLthpwH3gmFvmUkQpcMHT7bVbIvwfUUpJm+Va78XDnGR70x4h4Xxr300qlnND6OoI
         NM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608827; x=1692213627;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVxJJpzcYYfK3TLE6tHWcTq1QcT1ENtNn8bY1sBquA0=;
        b=Nu/NsQpzY8BEPswrgbD4xDQStxbhZqOA/FEmQJVZRUaIR9ms1c6MJ10kENRZfmr3mT
         qM2cSjjJYwdqZvsS7cRrQmTwb/TvgLApZAeQBnkvlwahsQmjBjh7Lvgbaa7MI8ut0qiY
         GaGOwMqAP6H9yEW9LHYQra37FFyMQcXyyLDhbBwiD3usQOjFw8OOPLPs/8xeN3/EN73L
         8nQNEWoea0Uqu0HDWVPli6EYNDyYg2NVOpLWefqYohMbgjp0NtFL/nSmKRiEsmcUfAnp
         cgl7L+P1HSJZyH3CGHEWfVRxnFBEK7/Hz8vy0rlPvJGMKHGH6nsdGDWmoG8YK0HyEuAz
         0GsQ==
X-Gm-Message-State: AOJu0Yz2mR9f6AyCQSBT1Mpgh6OkONLree95ieM0DiEGHh0uWBrbpt28
        S0hHiJFu8BvD5uDm+WGctLjtIKd+X4fZ4g6dPHk=
X-Google-Smtp-Source: AGHT+IE43WLrxARXDliqvvtib67PqUUwSMJq1m3RW4BtVCVyaQuyxqqa8JROBmHmorHk9IfL9klW+A==
X-Received: by 2002:a2e:8841:0:b0:2b9:344c:181e with SMTP id z1-20020a2e8841000000b002b9344c181emr101477ljj.19.1691608826816;
        Wed, 09 Aug 2023 12:20:26 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id o3-20020a2e9b43000000b002b9ed203af1sm2863218ljj.132.2023.08.09.12.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:20:26 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 0/6] MMCC MSM8998 fixes
Date:   Wed, 09 Aug 2023 21:20:23 +0200
Message-Id: <20230531-topic-8998_mmssclk-v3-0-ba1b1fd9ee75@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPfm02QC/4WNSw7CIAAFr9KwFsOnpODKexhjgEJLRGigEk3Tu
 0u7c6PLecmbWUA2yZkMTs0Ckikuuxgq0EMD9CjDYKDrKwOCCEWMYjjHyWnIheC3xyNn7e/Q9q0
 iVnWWawzqUclsoEoy6LFew9P7Ok7JWPfaS5dr5dHlOab3Hi54W382CoYIEsUkt1ogIfDZuyBTP
 MY0gM1XyH8HqQ7ako4a0jHNvh3run4AO4d7nQ4BAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Imran Khan <kimran@codeaurora.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Joonwoo Park <joonwoop@codeaurora.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691608824; l=1754;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=egThBZwSTxM3F3X+KJcsxzhYTfwA9D4NBQYRWl4CZm0=;
 b=29IaLLRfDw8KxdgD/8yLej6UnjeOxoOFQg2Fy0arvCcHBorncfoDdlbi9vHct9vX5d3QDFxeC
 STYvzYHj0b6C/3d2cqJyf1ulMPfLt4fUF2gyKMF3n9jLHzsV583BMGp
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

8998 has a couple of issues related to its clock controllers. This series
attemps to fix some of them.

The DT patch should go in first for bisectability, otherwise
clk/pd_ignore_unused will need to be used, as the SMMU GDSC is no longer
considered always-on.

This series results in less "clk stuck at 'on/off'" messages and should
marginally reduce power consumption.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v3:
- Make the commit message more meaningful in patch 6 (krzk)
- Pick up tags
- Link to v2: https://lore.kernel.org/r/20230531-topic-8998_mmssclk-v2-0-34273e275c51@linaro.org

Changes in v2:
- Update bindings
- Separate out the dt patch into two
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20230531-topic-8998_mmssclk-v1-0-2b5a8fc90991@linaro.org

---
Konrad Dybcio (6):
      arm64: dts: qcom: msm8998: Drop bus clock reference from MMSS SMMU
      arm64: dts: qcom: msm8998: Add missing power domain to MMSS SMMU
      clk: qcom: gcc-msm8998: Don't check halt bit on some branch clks
      clk: qcom: mmcc-msm8998: Don't check halt bit on some branch clks
      clk: qcom: mmcc-msm8998: Fix the SMMU GDSC
      dt-bindings: arm-smmu: Fix MSM8998 clocks description

 .../devicetree/bindings/iommu/arm,smmu.yaml        | 41 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  8 +++--
 drivers/clk/qcom/gcc-msm8998.c                     |  6 ++--
 drivers/clk/qcom/mmcc-msm8998.c                    |  7 +++-
 4 files changed, 55 insertions(+), 7 deletions(-)
---
base-commit: 21ef7b1e17d039053edaeaf41142423810572741
change-id: 20230531-topic-8998_mmssclk-fd4b2fb7f8c1

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

