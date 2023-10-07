Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C237BC823
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 16:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344013AbjJGOBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 10:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343969AbjJGOBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 10:01:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD1CBD;
        Sat,  7 Oct 2023 07:01:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40684f53bfcso27918125e9.0;
        Sat, 07 Oct 2023 07:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696687260; x=1697292060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hntI7Hmvp9NHpiyQmV3a36nodfLUjXNIuHQCuLeWAZw=;
        b=YA9R/26AQSLXlAzypkBZKGsGD5Cj63LWemKShYqdclBiuqx4DFUpZWEl4Wo+KA6OKb
         soWZcdBDTmj14KpcgjBtBafrY+4JZ4BJljnONPezGejlUo74ey7UFE1OgsenZ4c0STN+
         oPp22/y31zODcR3KTOoGJXu3dGTj5jXXt3ZojCtremV3tIM07/mCNcIhpW50h3BJvyyr
         3seIZEOzloLn5X3iesaaEVYI87DIPAxbJLdS5WviwLS9E/xFe6JatFjfGwhMr6+Zxxaf
         WjD8qBejy2TUC9m/+hRuJ83Hy4hC+rZs4/cHG2olYVI3B9pQnU+SxFKxvBluF95lzX9T
         A7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696687260; x=1697292060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hntI7Hmvp9NHpiyQmV3a36nodfLUjXNIuHQCuLeWAZw=;
        b=R3YNoM7f0DasX66zKSq7ADH6s3qV2swmOHu5CQ2rNQVsZjS5iVhDAPuIzTJE63w4Et
         /m2WzwRRqkIPLKdnuRo7WEr1SXtGYu8XQPHwcyl0qirGx+w4y5ojo+my5Ndyy1olNvt4
         WrJkZriHz0AHsljRkcZWz6dTMgopX5X68G+hScW98mZf5CtzYt9or7x8iMadBc6VsZmX
         X97WV78OBK6HR7t9fcx0joD0WKu8oCi7zbtqTfpAmDqqN5sb46471dcIPNTmm4nAF/bA
         KCTw6YVSEQCu+zbkEgXxphqtTGeQl1VWuRIC9bjZF02XKiV3sFMkVnql41NVTSyZK6pO
         bp6Q==
X-Gm-Message-State: AOJu0Yw4xXzSlLXcqckQCau7FXuKConKk45SEml+2rkmGlFILVEO3bBs
        bCSWjVBYERmgUQP2id4y8l0=
X-Google-Smtp-Source: AGHT+IGmI0hR1r89mbKERJ61t8qbqXeoRI18pH1s9Q/bcuWYAdvgKT2vzmfdQtLVL6VEi3SNgRLgZQ==
X-Received: by 2002:a05:6000:128a:b0:31a:d9bc:47a2 with SMTP id f10-20020a056000128a00b0031ad9bc47a2mr10713714wrx.53.1696687260289;
        Sat, 07 Oct 2023 07:01:00 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([77.22.112.104])
        by smtp.googlemail.com with ESMTPSA id q8-20020a05600000c800b0032415213a6fsm4332043wrx.87.2023.10.07.07.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 07:00:59 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Joe Mason <buddyjojo06@outlook.com>
Cc:     cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        hexdump0815@googlemail.com, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, David Wronek <davidwronek@gmail.com>
Subject: [PATCH 2/7] dt-bindings: phy: Add QMP UFS PHY compatible for SC7180
Date:   Sat,  7 Oct 2023 15:58:26 +0200
Message-ID: <20231007140053.1731245-3-davidwronek@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007140053.1731245-1-davidwronek@gmail.com>
References: <20231007140053.1731245-1-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the QMP UFS PHY compatible for SC7180

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index f3a3296c811c..f2eee8b5326f 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -19,6 +19,7 @@ properties:
       - qcom,msm8996-qmp-ufs-phy
       - qcom,msm8998-qmp-ufs-phy
       - qcom,sa8775p-qmp-ufs-phy
+      - qcom,sc7180-qmp-ufs-phy
       - qcom,sc7280-qmp-ufs-phy
       - qcom,sc8180x-qmp-ufs-phy
       - qcom,sc8280xp-qmp-ufs-phy
-- 
2.42.0

