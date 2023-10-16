Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FFC7CB1AB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjJPRzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjJPRzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:55:39 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1417EA7;
        Mon, 16 Oct 2023 10:55:37 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-991c786369cso778719666b.1;
        Mon, 16 Oct 2023 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697478935; x=1698083735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BhPkYhJAW7CH6nBOo+T09ywLEzEHOW0bchh9MjRNi/s=;
        b=fSnS3zhWwJzGUU/sPgDw+WXaXiX+JT+TPsmS5qkuIImnHRDQ8xvSK8RhqOxCF2S2aR
         rZgMJWf6+0jxpOYvytOn9IhDjefiDbIQjS+nQyBc7JeWG7puocyAeSmoB40YO4bU8SqI
         83Gsx8jdFKsIWOCctfodeqZ99EA5TC8G1LFwkq42+FJxLYQ+oe+6Yg5iriU7zarm5pPp
         rj+A10l9s5C1GsAxSrkkHtvTdGfMEU+qYTPL9RvaKH2w8YIL3FdhRisy9BlVvekkVdOS
         ZLLtHvt9/0X8fmUBzBJIp0/ihwOoUAvY+Sz6qlW0Dv95D9nqYHKGW2kZlD44RX4yLRDa
         CM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697478935; x=1698083735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhPkYhJAW7CH6nBOo+T09ywLEzEHOW0bchh9MjRNi/s=;
        b=ggThk9lgvefFQTjVgrSzTXQZjQd/zBt3f572+u9aCqnoAWm1E5urqBu/Qc8eWJyKG4
         W3Ne4dllk3FVt5ZvLW1VFh9fPvA+BZJfP80WHl+cwl943Ve3Z4nfPKcIU1YEZy5qmdrS
         S2McwCvvmdYLXGXedQm/WerMWa5HmbVX/LVIT6pW2KUwCNnltkPYVnv5uYqgcCd2VQhA
         hSj9/RgmTN1LYgEmfFH27eXxGm8qOBCNzm7W5CpNelDOeR+UkMc5X/bDiabpI5UNR7xg
         NWuNLlNtNBW9OHubQaPVTnY5SxVvljU48C0jL7dOOaxifCmWNreh2FM1tbqvVAH5Rt1p
         eMWg==
X-Gm-Message-State: AOJu0YwGUnOxnTDhN1TQH/4DtHbxiEM2I+FU7SfiUEkwGbFhxbynS3aV
        zYg7MY94v9v3H4gSNRPjeM8=
X-Google-Smtp-Source: AGHT+IGQoFoxmsZEJYD/hH3nnI9DdEj2LO5ATmuYzHnVSHJZ/f5Hk+a+1dS//iIYDEwSTI2ScjC7+w==
X-Received: by 2002:a17:906:7310:b0:9bf:5771:a8cf with SMTP id di16-20020a170906731000b009bf5771a8cfmr4954114ejc.70.1697478935271;
        Mon, 16 Oct 2023 10:55:35 -0700 (PDT)
Received: from fedora.. ([188.252.220.210])
        by smtp.googlemail.com with ESMTPSA id g15-20020a170906348f00b009c3f8f46c22sm2378007ejb.77.2023.10.16.10.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 10:55:34 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: document IPQ6018
Date:   Mon, 16 Oct 2023 19:55:15 +0200
Message-ID: <20231016175532.2081344-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document IPQ6018 compatible for Qcom NVMEM CPUFreq driver.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 .../devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
index 7391660a25ac9..f929892d654ea 100644
--- a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
@@ -28,6 +28,7 @@ select:
           - qcom,apq8064
           - qcom,apq8096
           - qcom,ipq5332
+          - qcom,ipq6018
           - qcom,ipq8064
           - qcom,ipq8074
           - qcom,ipq9574
-- 
2.41.0

