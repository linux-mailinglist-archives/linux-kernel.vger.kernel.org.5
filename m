Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9D17CCE67
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbjJQUp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjJQUpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:45:22 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E71BFF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:45:20 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-27cefb5ae1fso3582511a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697575520; x=1698180320; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEp58o5jHhf4WpbbQN22nWQx0p8/zKOYMNnof7eHdFk=;
        b=XyUH0exzrO3kCOpB6aFZBQRuV8LtEBstVdbWewp2MZTCHgkZ3KJpDnVWzwUt2xuWm/
         yMOYekAZLAofK9S9AP5V0n0IUUFjFfzp2zGCaCkjYQhU4vP9581z6bEBEy5kIbcV9tWA
         yZthFyBkEpuSv2eCzXmxBMPWnFG0ZnN+ijify2YXn/k9gi4nm3YkZU16CNSIVh2Et9wm
         fOgYHEPECBS8QmD6M3yaSMmpfTU96H8RN5lg9cPRNOkjnaj8hAWbTEBBevicu2awPOLX
         EibzkbA64gGJRZJ2DCuDpvHolRX8ON0K6TXgxxjRSVeLEf+aYHtWN5gWfYYMJSWP35w9
         OXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697575520; x=1698180320;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEp58o5jHhf4WpbbQN22nWQx0p8/zKOYMNnof7eHdFk=;
        b=m0IHsrOq+G00z+7XTMHo2ZYOUOJfKScq6WpTw2AadMoib334G/mXe+84ya6eCrDr5V
         gS95g3UFwuhueW8+R1vxDnt3zB5aW55fLf+4hyT8ryauX2qaL1TV/OMMUwNQb7Kj56IG
         JlHMhQFoaRfKyaCng8eLNfEyp8AHsctVEgqiWatn1n8P6S3oeLuemeivKbmRshRao6m3
         Zd7D6wfihpArPRFJLw2/V2rxRJs0rnu8icMNZVicKfU2n2YFj5/OAzRRhcrNBf0hutgV
         MxaaaIPBqvZm/rcZ4tq/dtSOYshPx/rL4Uj7LINqE765OK+TI+3DaT+PZwvSoVCAPUUV
         N1cw==
X-Gm-Message-State: AOJu0YyHIqYBwwhZkFBo4xhXK9VZIPEM27zdcrXBQSWOCRnPp/8IHt4q
        3Y0o+EpL53AOn4tH7hjVR1cdjA==
X-Google-Smtp-Source: AGHT+IFp9pFfIQEXNfCKkC3vHINl59IS1m8/a0WaUgexa1L64KCFZa0B5E8Uxe+pqG+nf7JdZ+AKhg==
X-Received: by 2002:a17:90a:800c:b0:27d:5ef6:2862 with SMTP id b12-20020a17090a800c00b0027d5ef62862mr3354510pjn.13.1697575519879;
        Tue, 17 Oct 2023 13:45:19 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:51d6:dcd6:63ef:52e9])
        by smtp.gmail.com with ESMTPSA id w3-20020a17090a6b8300b0027b168cb011sm1906553pjj.56.2023.10.17.13.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:45:19 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Tue, 17 Oct 2023 13:43:47 -0700
Subject: [PATCH v2 1/7] dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head
 TH1520 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231017-th1520-mmc-v2-1-4678c8cc4048@baylibre.com>
References: <20231017-th1520-mmc-v2-0-4678c8cc4048@baylibre.com>
In-Reply-To: <20231017-th1520-mmc-v2-0-4678c8cc4048@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697575515; l=752;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=N4XyeVof9hR52mLfjwIJ/Ek5oPrydhGBm0Gy7EtJsFw=;
 b=+Ob+gpIgFt2gGa83X788FD8dq4mXWEM1rO3tlCBf2HwM5l8WNPiB40d3qp2Xd4waLgjW94rAb
 nu/B5dApi0JB/KK0nc1z5V5Bw3NqrLUU4ThP/xnLvrDfw+Z49RjOadw
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible value for the T-Head TH1520 dwcmshc controller.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index a43eb837f8da..42804d955293 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -19,6 +19,7 @@ properties:
       - rockchip,rk3568-dwcmshc
       - rockchip,rk3588-dwcmshc
       - snps,dwcmshc-sdhci
+      - thead,th1520-dwcmshc
 
   reg:
     maxItems: 1

-- 
2.34.1

