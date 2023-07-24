Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AC975F943
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjGXOGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjGXOGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:06:33 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BADAE53
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:06:31 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso6682194e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690207589; x=1690812389;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rmu60T8Zh0IAH6zmF8BDywGRhKd9xpQhUa6OjSxooAg=;
        b=Vf5h91tlg8gxpGK/5JFapaH+ioZd+rWlSeZotv+0OyZdzqTJt6/suRbIoyKHe5PMFp
         IaciO5zCDe4MxfMcqTjBBkhUtq8d9nF1te+nEl3rKDSg6L0kqbn7aiy1YoWlyA8bObT6
         N1U0GuQ80GCVklnLEhnKRBPsaYs6R7m8hYbbWiGr0g6WrIieG20lyCmDh+DgctafXpHt
         DtHaMV0j7CeI7fVg6OzD7zWiG+nqJ5CT3k+kG7KLzKx3NdaY+favbbBnvCDG5hWT1J9l
         Pxfy1j5kI1waAkeGZB7utuOPvAONuqwP8JzZXrlDmwRg9zFYZp+WrvjJ9JULCXtzy43J
         rGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690207589; x=1690812389;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmu60T8Zh0IAH6zmF8BDywGRhKd9xpQhUa6OjSxooAg=;
        b=WRfT51W5EMRcPVN/4jagcCRf3NBH/LGBY7y154yhVgUnNbQJt7OIkRKEuwzQvjl5Pg
         U7BMy8MgQbSmR6sidjxX76HqysKdcKikiIQFr3xhv+maw3lk+nHk9/1YqnThp4B8SHoc
         L13fN9hIuKLlJeTitlJ4bAGLXtVqmr12SOvfuCgxoX1BGKpLClzKaZu+COZXr74DhWYi
         jYd0kz49pEOrs3LL/t2VgrrGWZCVMzG7JQF6MQ8+2XfOaatYoGEM0g5FJCvIIBvEToM2
         eRIHs2mah/iNYnUkP713ZDATcOvZah0/sFoJMYzgZ2hN9xHTJQ0J3Cl42dviFL+vkYog
         P9Kw==
X-Gm-Message-State: ABy/qLZ++z3DkTcSlAxA7C5N/bJUJ3KVbolX5lkXSdr5zX6ME+6E+PAb
        S2KE1dx6QURNsOYfNzy1fh+fEg==
X-Google-Smtp-Source: APBJJlH0Ct7XsVqwfQ5+ONo5s8bEMEEnT/fMQmqSet/l76QKkIX1oRVGXYQdTK9cVdpQlOXdJGEqDQ==
X-Received: by 2002:ac2:4c23:0:b0:4fb:9129:7058 with SMTP id u3-20020ac24c23000000b004fb91297058mr4880627lfq.8.1690207589488;
        Mon, 24 Jul 2023 07:06:29 -0700 (PDT)
Received: from [192.168.1.101] (abxj221.neoplus.adsl.tpnet.pl. [83.9.3.221])
        by smtp.gmail.com with ESMTPSA id er26-20020a05651248da00b004fbab1f023csm2223481lfb.138.2023.07.24.07.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 07:06:29 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/7] Update RPM ICC bindings
Date:   Mon, 24 Jul 2023 16:06:26 +0200
Message-Id: <20230721-topic-icc_bindings-v2-0-e33d5acbf3bd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGKFvmQC/32NQQqDMBAAvyI5d0sSsak99R9FShKjLshGNja0i
 H9v6gN6nIFhNpECY0jiVm2CQ8aEkQroUyX8ZGkMgH1hoaWupdEK1rigB/T+6ZB6pDGB0a0yUl2
 Gpm1ECZ1NARxb8lNJ6TXPRS4cBnwfp0dXeMK0Rv4c46x+9u8jK5DQ1kE7b/R1cOY+I1mO58ij6
 PZ9/wIAi1ZnygAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690207588; l=2183;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=A8LpiXmLBVmMdUw98d7AMUqCxngJBApa7pOnf7AC90Q=;
 b=+VB70vlmAU0xRrBWNBbXgW6M1WBxIZZBCnb5CnANELALNAo6XSwFcJAYo2Ray0mODQl/sZ/HK
 fflLR+1yn+QDgxiwbvqDrUyCsFu7raZsuwalEzrW2I/JeCZaT7/L7xV
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

The recent necessary overhaul [1] of how we represent SMD ICC and RPM
bus clocks changed the way they're connected. The bindings however were
not updated to reflect that. This series tries to address that, while
also making the relevant bindings less convoluted.

Now, instead of referencing RPM SMD bus clocks via clocks=<>, they're
handled internally within the interconnect framework (via direct RPM
calls from there). We still need to allow some "interface" clocks,
which are necessary to access some registers and not managed for us.

[1] https://lore.kernel.org/linux-arm-msm/20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Keep reg: local to the individual bindings
- Use the rpm-common yaml for child nodes
- Keep msm8916 and qcs404 in the common file
- Keep only meaningful examples
- Fix up some indentation
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20230721-topic-icc_bindings-v1-0-93e2bc728fb7@linaro.org

---
Konrad Dybcio (7):
      dt-bindings: interconnect: qcom: Introduce qcom,rpm-common
      dt-bindings: interconnect: qcom: qcm2290: Remove RPM bus clocks
      dt-bindings: interconnect: qcom: Fix and separate out SDM660
      dt-bindings: interconnect: qcom: Fix and separate out MSM8996
      dt-bindings: interconnect: qcom: Fix and separate out MSM8939
      dt-bindings: interconnect: qcom: rpm: Clean up the file
      dt-bindings: interconnect: qcom: rpm: Clean up the example

 .../bindings/interconnect/qcom,msm8939.yaml        |  74 ++++++
 .../bindings/interconnect/qcom,msm8996.yaml        | 126 +++++++++++
 .../bindings/interconnect/qcom,qcm2290.yaml        |  60 +----
 .../bindings/interconnect/qcom,rpm-common.yaml     |  28 +++
 .../devicetree/bindings/interconnect/qcom,rpm.yaml | 250 +--------------------
 .../bindings/interconnect/qcom,sdm660.yaml         | 108 +++++++++
 6 files changed, 352 insertions(+), 294 deletions(-)
---
base-commit: ae867bc97b713121b2a7f5fcac68378a0774739b
change-id: 20230721-topic-icc_bindings-72917016f595

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

