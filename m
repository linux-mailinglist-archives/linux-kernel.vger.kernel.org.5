Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368967F8B05
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 14:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjKYNEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 08:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjKYNEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 08:04:41 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4528AA1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 05:04:47 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a0b65cbf096so55763766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 05:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700917486; x=1701522286; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UlzufWUHKFDhFCD0mnL38mavq8i9eYfNJTalR1F6jUM=;
        b=UHhs0t83hGB56m51E0OoZFqwER/sZCfQ60YvDxTDCC6UUe2KLuf7O4b8T41aNfIMIM
         pGpAE4fDGyk2ArSaJO0ftCUbbRLCjNkmFySYZET2Dp70oAj7rq/h5Lwawta7KRrSZsvH
         2TWyMfZ+YZ8ioE/8WEQ0zpSRMolm7PJciNjRwcUMGI1S8u6Dd55MiFLwH50AYjAdZ5iD
         /waYaoST8F6odwcVlmYnS+HwUJIXzVYDnXksnofh8w5tF3B3jF0VkKk+AA9/bfy105zW
         WMDwNQvnJ9kGjLVSnX8pN2aw34oJM1gWnXLoh9HZQAYLRoP07gN8Nf/zS62tugRyy2PX
         gz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700917486; x=1701522286;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UlzufWUHKFDhFCD0mnL38mavq8i9eYfNJTalR1F6jUM=;
        b=fcR56SXkIZXdCRccK/Sw5Q6wy13/3txWTU7I7P4ocy7OBTV7ZWAvqYAzCwes4LHmQx
         4DZmwpVAq/9i5P5HMmPPqxDY47Vyfu1T1P1o9zV0gw9Z6sr6LB/bb45z9YG8sUwTxk6q
         lg2bjomvTRVrX1tnHWowgsNBoI4VIHZkryeO4jSqLbVV/agFDtCvDeqSZExi+0qdt/WS
         iygRzLVeITLCniLsNWkTHNnGS9nixu+PBiMiXvZkNIy5+6IYnn6dfREocAnqa2l0avel
         RujHdLJkknrNzCladO7e4w2qCVToUXAJKZY3to6eF2y5Y03Ho5uH1SsIIBD3ejKy/Fu3
         dLUQ==
X-Gm-Message-State: AOJu0YxMdoQmx4qADESzn8J+a6sb0qGOA8BA3weFpAxmaOgyTshF0v8W
        ctdDr+ULt7mQ1jI68kpTZEeqkA==
X-Google-Smtp-Source: AGHT+IGZe1Keh2kWDwVVxS0OLuNrYpULTlZnzmyMwr9TBaDQRbHU004WkF447OvuLiaLVNel5n/R+A==
X-Received: by 2002:a17:906:528b:b0:a08:f7f9:d9d8 with SMTP id c11-20020a170906528b00b00a08f7f9d9d8mr3298738ejm.6.1700917485744;
        Sat, 25 Nov 2023 05:04:45 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906361600b00a0290da4a50sm3433750ejb.186.2023.11.25.05.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 05:04:45 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] RB2 bluetooth
Date:   Sat, 25 Nov 2023 14:04:40 +0100
Message-Id: <20231120-topic-rb2_bt-v1-0-509db2e28e70@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOjwYWUC/x2N0QqDMAwAf0XybKDtNjb2K0MkqXEGpEqqYyD++
 8Ie7+C4A6qYSoVnc4DJR6suxSG2DeSJyltQB2dIIV1iTAG3ZdWMxqnnDWm48oM4329hBE+YqiA
 blTx5VPZ5drmajPr9P17def4Anmnj9nMAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700917484; l=705;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9oo3d7RN/T9srbOU/SssYvWYQEsLa8+tGvWkxfHAsKo=;
 b=Z6GqEHPAB59EgccYQFelcFjzOmkFH4R0pkciPJvTazTgBYZwItYtGdXbYrJ2xjMjX6pQItmE5
 Je7MotgCGMTAhY7SJY/WOZ+kiMis1MxQnaZgYyHhUudUQWM6eXKdh02
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bluetooth module on RB2 seems to work ootb with the WCN3988 setup.
Enable it.

Scanning for devices works, couldn't test pairing on a remote board.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      arm64: dts: qcom: sm6115: Add UART3
      arm64: dts: qcom: qrb4210-rb2: Enable bluetooth

 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 81 +++++++++++++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm6115.dtsi     | 30 ++++++++++++
 2 files changed, 110 insertions(+), 1 deletion(-)
---
base-commit: 8c9660f6515396aba78d1168d2e17951d653ebf2
change-id: 20231120-topic-rb2_bt-ad4b8abc750f

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

