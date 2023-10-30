Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665487DB648
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjJ3JnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjJ3JnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:43:17 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA401B3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:43:14 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5082a874098so3894735e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698658993; x=1699263793; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xnHWU+WQVP4k7S5E1faDC22pH1GlE3IL+UX99IRJ/aQ=;
        b=XgZS+8nA7BtugN15UdAxZuelmYGAKJXNViErHG47Ph0lzREonmtRnAkBFB2UPlmtDb
         f16p9N362/JjPMTrZxJtI/Qg0HhwRVx7EIM+gjEcoEq2tGbkAf0mMXrMAdg6njdQKwhc
         tmBK549VtBw4RzAcS7nGsnxIeUm56q3R3/Euxc5toABJiAt8h82aeYznSKARFTTtdW+3
         uJoR0Qua3SjE+yXfBRpRttlyYDki9voHn+g1T+TqI5esbKT6uK0Sh+DVlcRxn47/8iTU
         +rQvt1N9/lVGQun5bXRoVwWiIkLgtcd2SctI8KLUcMDIh0smdoCqZcANIbVb2A/F5aM3
         PDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698658993; x=1699263793;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xnHWU+WQVP4k7S5E1faDC22pH1GlE3IL+UX99IRJ/aQ=;
        b=EvsRXIkwLVO+cys2Lbpp1x5o4ZwZKffu35VGbSkHvmjpNg17b5NDN9hBF0AEIF1KUE
         U3PBy41Us77AlxbE8Xq+ni9ln/4kZzyhJ/eVFKWGhTLj049QWMnKKlOHefuTtU2SK5de
         yhmG3WtEocQls2msf0GBOTjG/Rldhs0G72dl+OTCzwut4g64/OGl+KZf4waMplT0ud4t
         wqc24QoE2WDHwJfHuJ2QUjg77bu5nymLOdQWngpiYU6FxIvIvBnUjEkY22AuL+4RbDyn
         WV1vEv8puVTYkhS8tdiW7ZMSwuovWoAi7K2bu88tz2F9Vg8w8MGVMqwn99WIjgWG5fea
         dbUA==
X-Gm-Message-State: AOJu0YxFurSd88BgD42WGQrQeQIygi/YWq5M/RXH2RXqRCG+9cI+Dytk
        CrOyXRaauObt+buStF0fsuKInA==
X-Google-Smtp-Source: AGHT+IGNM/yQoF6/HdXJLNHPDgyk9s8UeWq68znES/T8/ru4wJ0so2bXxVd7UradeFcVRwrKDKRIvA==
X-Received: by 2002:a05:6512:401b:b0:509:e5e:232a with SMTP id br27-20020a056512401b00b005090e5e232amr4816819lfb.42.1698658992838;
        Mon, 30 Oct 2023 02:43:12 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id a17-20020adfe5d1000000b003142e438e8csm7880556wrn.26.2023.10.30.02.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:43:12 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 30 Oct 2023 10:43:11 +0100
Subject: [PATCH v3] dt-bindings: ufs: qcom-ufs: document the SM8650 UFS
 Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-topic-sm8650-upstream-bindings-ufs-v3-1-a96364463fd5@linaro.org>
X-B4-Tracking: v=1; b=H4sIAK56P2UC/5XNvQ6CMBSG4VshnT2mv2icvA/jUNoCJ5GWtNBoC
 PduIS5uOpzhPcPzLSS5iC6RS7WQ6DImDL6EOFTE9Np3DtCWJpxywSirYQojGkjDuVYU5jFN0ek
 BGvQWfZdgbhNYKkyruFUnq0iBxuhafO4jt3vpHtMU4mvfzGz7fniufuEzAwZaKOXK1Uqw6wO9j
 uEYYkc2P/P/TV5MKqm2zEjZyPrLXNf1DYbBbAUpAQAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1824;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=pi242ASpvMoXd5cxDim+bVxNqfCmgVxX4FXXbCCELqw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlP3qv5KVtyXLPavDx/xKMLCC63AR7cuF7sX7duPjd
 KjNPGy2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZT96rwAKCRB33NvayMhJ0bf+D/
 9GB1KDkr7jr5XU/Ks6BiAKKFKmVnKkSezGTV6EloIVHKkdtQ2zyT6op88OjGBCKprKF2CVCQnRmxEi
 fZyG2t86ochCEXPu9GYDJSjJJA8Tr6RiyA832K3D9RwPCmkBO1lZFgDJoP+BHwg0cvpIC6DnjCr13A
 uxV9W9BPJZZjBYWOKQWTMT7cKBfCQ/gxaRXY+8LhTA2befEE5Q58V4/XphIVZrxOXFDguHEJ2YpdF3
 3P4hhq6UaX23cQs6by/DddWX2X2j4P5ZNmRCMRO7YkM0WQUpUAsd2sggR6IiMv343upTN61KHlA8xR
 MtYMIQ35EOzZdcMWA8iJac5AvaWZsUNtPxp04kBDbyiMH7iJKkHGGXq//Yq2vImDnFRUU9SIMHjbrM
 C7ekW+EOLEGuiQeBZkzBlk5Pb/MLHJiUuD/ftAwDwet1UUzyO4RJvF0qNvV89JvBRCyH8Q8hyXMWqi
 JGCyJFfIZ93WJh7c87igguQ5dtKzQJsORID90kxAo6I6DmplNYrBYhdpwl2GYJNnrRDCpeLFfWCcU4
 hxolI3XH3eVZ3Xk8CMLOZWRAM1N0OO8/c+B972ZZU0yCzFVK1uf74cJ8tRBx1+2Xv+mxrXEU+9l8Dk
 4o/5/RK6LBHnOuRJ+FR70pGy9daCti868vaBjXdaf76dfhnyqFTyT5oGdnJg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the UFS Controller on the SM8650 Platform.

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8650/upstream/integ
---
Changes in v3:
- Add missing sm8650 entry in allOf:if:then
- Link to v2: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-bindings-ufs-v2-1-040ad1c44b46@linaro.org

Changes in v2:
- Fixed subject
- Collected review tags
- Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-bindings-ufs-v1-1-a355e3556531@linaro.org
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 462ead5a1cec..2cf3d016db42 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -36,6 +36,7 @@ properties:
           - qcom,sm8350-ufshc
           - qcom,sm8450-ufshc
           - qcom,sm8550-ufshc
+          - qcom,sm8650-ufshc
       - const: qcom,ufshc
       - const: jedec,ufs-2.0
 
@@ -122,6 +123,7 @@ allOf:
               - qcom,sm8350-ufshc
               - qcom,sm8450-ufshc
               - qcom,sm8550-ufshc
+              - qcom,sm8650-ufshc
     then:
       properties:
         clocks:

---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-bindings-ufs-d03cf52d57d5

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

