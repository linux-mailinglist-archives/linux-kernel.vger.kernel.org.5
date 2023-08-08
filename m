Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9D27745D9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjHHSrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbjHHSqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:46:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085854E735
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:53:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-523225dd110so5918157a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691513600; x=1692118400;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xXb3gGUTCuGI9f7CTmhZvudhYCVdkZDKGm57sq75z9A=;
        b=D8wbenn0Wj5JX92d73Qiazvd3rYoUYq4zwKoWs8SxpKqEaliZ2vMhCENkTA3Rb6TzW
         QPEVHvJ9NmheK44vyWYDfd5VTck5YdGX8hlwN6HimZ0kJDuBmFMBvp8d2j6Jagqm2spW
         7RRFVUdg0cQ43E9XuM7LCAWNaxwLQ9kpZ24OaHaEwosYqXQlu0elzTDgtvBU1pYRKg60
         wDw1j750aS1EY7q2iMYzIal4wzPkpLY36HWd8JiYlLSTdLH9QXCjMkcLbCYE/Zz6YIAl
         gX0aj/pktzzro4y2G7vjvQoLpsuXbjdfbYbJdUAxkM9XlzHtThpq3ZKvzKe6ZOE72h5/
         ZlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513600; x=1692118400;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXb3gGUTCuGI9f7CTmhZvudhYCVdkZDKGm57sq75z9A=;
        b=EYU1l/VtvESVkrpIPlhACMTKeHGaQUdzbKFEzeD3SkACdfdTmo099ESUKGfTL+8dMY
         /cISQT4luFrbubLhNxDGj923R5kICEHKZvfGh/bFxgP9Zw415Y1fRqm51LK0eQc2GvKi
         0ZNPzHSkPNuliEvNmhxCmlgvcv/exvMB1O0dqhNA5eRPaE0QJXKToZWM+AYU14NT6OXC
         BXxFmwFLLN8LO20FSqnPVBaM6QCAhX99L9fpV4+AB8dx2Ag+SzuiBKKFlz1OD7TsnVYf
         NpWig4O3fIeTNBQCVY7tiEn04ilY+3aTqp4p5LtLmTqt9neJvDa/59tFULBtSNNULnfd
         41mg==
X-Gm-Message-State: AOJu0YwLaZhGPKXuN/IYvKkolXsRTUUQgmpiT17uo6N/s9yVadzi2x8x
        QTfvzXIAtYwsmglbv3+3fcKS1PkRO4A7CeXIYl8=
X-Google-Smtp-Source: AGHT+IH+aKb/us+BJrh9hTz6KF/MXtFLXgEfAZaI1uc/X5WOfIfDWEdaa6Uiv+MPqfqqttpgiGhcBQ==
X-Received: by 2002:a05:6512:3ca6:b0:4fe:279b:7609 with SMTP id h38-20020a0565123ca600b004fe279b7609mr9597266lfv.17.1691487887970;
        Tue, 08 Aug 2023 02:44:47 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id i6-20020a056512006600b004fdba93b92asm1818884lfo.252.2023.08.08.02.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 02:44:47 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/6] MMCC MSM8998 fixes
Date:   Tue, 08 Aug 2023 11:44:40 +0200
Message-Id: <20230531-topic-8998_mmssclk-v2-0-34273e275c51@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIgO0mQC/32N0Q6CIBRAf8Xx3G2AuaAn/6O5Bgh6F4IDczXnv
 0d+QI/nbGdnI9kmtJncqo0ku2LGGArwU0XMqMJgAfvChFNe06ZmsMQZDQgpxWOacjb+Ca6/aO7
 01QnDSAm1yhZ0UsGMJQ0v74uck3X4Pk73rvCIeYnpc4xX9rN/HysDClw3SjgjqZSs9RhUiueYB
 tLt+/4FMewJ3soAAAA=
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
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691487885; l=1561;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=APl5fI6CgPz/P+aBiMrAGDV2ER8mxIXa42jNxZTZU0A=;
 b=utcVZVXR/N23ZVDqZiyeYw1eROZHDAt70NBzimNDO1RcNS9XaxCjRcvkl2Ey8pMFL7xr+tFi2
 MSKWoDguWMkDlbEplPK8WDVFypi/F7YhDNuLBVSMMOTLKgCLcnEy8FX
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
base-commit: 71cd4fc492ec41e4acd85e98bbf7a13753fc1e03
change-id: 20230531-topic-8998_mmssclk-fd4b2fb7f8c1

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

