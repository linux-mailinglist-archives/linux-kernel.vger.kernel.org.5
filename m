Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BFE7FB602
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjK1Jiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbjK1IlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:41:22 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1149691
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:41:29 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-332e7630a9dso2963693f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701160887; x=1701765687; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FArHvLSE7t70Dxa/JAUxZleZFl01Zkt3aczR0p4djvo=;
        b=gkBH9yHnTsNEcH3vIazqNT9c8zbVn7PQ5JLr04GIITNX5X+ipQkcD2pdmzIdlNaa3i
         egJrvmcC9kIgk/cxdAScttBwQ4K0IdkKqzIO7SCxTS3VEJIZsxU7rxhVvCsKxAEDrDDz
         3XaW4I9fIxmptEpqtkdxBZkH+91CixYjB1fXo8gjd+1rolHR+oa6AciXLcvEEWLEpYYc
         fI44TF1CgulIeT5u/0T+tLLwK2vhJtxMDRAke4aV2BfpdW4DsBhg7+1JYvc+xBnT+5R4
         YmvNFSYTYJmSDQCp/quD49pS4z158UFvKYo6gKRneZ0pr4wp4vOlBwxH5yH+7oHRdqsp
         heJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701160887; x=1701765687;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FArHvLSE7t70Dxa/JAUxZleZFl01Zkt3aczR0p4djvo=;
        b=J3D8119LJr1W28A8jq/P0hClwyX/RQTElVh3Mwucby0V3BsCZBPyZeRi6IcDFvwMgW
         4AUoJiyZvbnE+ysYECdCwQQQX5xCp1xWMBygR/cLKxMutSlDlgKu7YOTR7ORsANggUfq
         0WruFvKXOx97w5DcJEqZKRyWHw40TkDFdHPQY6RklsiX2qoq8k+PGJshAFTvq0bmMFz1
         hS4iEOT5K6qVRpNLduOcOLE4jmpFkLjifZarYOaomtndZZfJnod3geP6ig931JYQsYaY
         vQgPvcDqN4t/tohWd7BJCBqRLz2GhStc3RObmcPtyoza+OdZwVmRmmo6aot4yPpONM9T
         AKUg==
X-Gm-Message-State: AOJu0YwMe8xFaAK9VdXTSj4vjD6Yrr/651A++IQCduAkqDCalRQGAwLT
        dJ0f0fO8eAu7VMKKKfoED5UoVQ==
X-Google-Smtp-Source: AGHT+IGSwQZaP4dBVCrX35EPpPiEYt2lAGGRRqwQ84D4zrY7KQq1APLCHRYcHamkS+UEOeJz5gN9aw==
X-Received: by 2002:a5d:4d51:0:b0:333:2ac:33f2 with SMTP id a17-20020a5d4d51000000b0033302ac33f2mr3654000wru.4.1701160887549;
        Tue, 28 Nov 2023 00:41:27 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id cp12-20020a056000400c00b00333040a4752sm4092435wrb.114.2023.11.28.00.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:41:27 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 28 Nov 2023 09:41:23 +0100
Subject: [PATCH v2] dt-bindings: iommu: arm,smmu: document the SM8650
 System MMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-topic-sm8650-upstream-bindings-smmu-v2-1-d3fbcaf1ea92@linaro.org>
X-B4-Tracking: v=1; b=H4sIALKnZWUC/42NQQ6CMBBFr0K6dkxb00pceQ/DopQpTCIt6QDRE
 O5uJR7A5fs/eW8TjJmQxa3aRMaVmFIsoE+V8IOLPQJ1hYWW+qKksjCniTzwWFsjYZl4zuhGaCl
 2FHsux7jAtTPa13XrbQiimKaMgV5H5dEUHojnlN9HdFXf9efX5i//qkBBG5w2wTlpFd6fFF1O5
 5R70ez7/gFHIvud1wAAAA==
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1614;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=4QQJrLSwqX11gi0iupHS+1VQiYE7nq7ckVQvq7PgbkY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlZae2K4EuU5HHOy3yOrVOFC/hyVZ/UP2kxvwjxoS+
 Qjmj96+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZWWntgAKCRB33NvayMhJ0fQID/
 9QXxJsBhGGxdq8/cPw1x800aIV3EZMCXGPn6wp0VLcMvY/vIMaufbgB0X8U1lfRI5bD0BKFY+qSY7j
 SfBHfxjAAWARTXMsgrpTpaDjVF+rkIz63bNrspJ+uXxIgxitP4pLYr8MUSwG3e8hNPO486Ld1m360H
 DB/qweMGYH2hzVKe1sWpBnVBUpHx8VIVZ8dcmx9FujAYkCu6IkGjLJnGeVziGZDbUriaBqsdatWh8d
 vTeRUWAm0Qksg72Axxq/ac0rzWEnem3ySLoPh/N8AhmDlwpWsnDlvZrnalmqOAz/HdmNknhHBFo0tH
 eW+SrEZw/5UUQLkJ4fBHh3U+VJT1JOtm3w3H3TNzwUlsvh0EevlkAyf2JibtgC/Bbfmj797dezfjGO
 VTQMGXFD0OzDI9n4Pah88zuGboPyDdvsF9MCf8uPQq/iXrvMaW/R5tPuAjXQi5jxDLE5RCYltzyyQ0
 UEt3E2oEBVUh7QF636gt3yfjOTQidO4bqberGm/I2YaWyFz1K7nFPD/owQ/iD8oItSaBIe7yHUmUz+
 8D1/4yH6MxuEBYRQwpwPIfyT6yUqJL/ft/wTojTX0SKd3RLKB4uLZvdCilIYAlujFewCAwRVdos61I
 9fB6CSPqqkSLlORTh+wHaNDo6kePazDYT3u6v3bUlzOXwY1Tf0wgEtxcVcaQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the System MMU on the SM8650 Platform.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8650/upstream/integ
---
Changes in v2:
- Collected Rob's Ack
- Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-bindings-smmu-v1-1-bfa25faa061e@linaro.org
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index aa9e1c0895a5..157de0d0a24d 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -56,6 +56,7 @@ properties:
               - qcom,sm8350-smmu-500
               - qcom,sm8450-smmu-500
               - qcom,sm8550-smmu-500
+              - qcom,sm8650-smmu-500
           - const: qcom,smmu-500
           - const: arm,mmu-500
 
@@ -475,6 +476,7 @@ allOf:
               - qcom,sm8350-smmu-500
               - qcom,sm8450-smmu-500
               - qcom,sm8550-smmu-500
+              - qcom,sm8650-smmu-500
     then:
       properties:
         clock-names: false

---
base-commit: 48bbaf8b793e0770798519f8ee1ea2908ff0943a
change-id: 20231016-topic-sm8650-upstream-bindings-smmu-7d52c88bc6ff

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

