Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ABD770D78
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 05:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjHEDPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 23:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHEDPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 23:15:18 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BDF4EED
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 20:15:15 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bc3d94d40fso23392505ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 20:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691205314; x=1691810114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKcPemMGXOGkd6e68fBQ7r4rih8Hsd/tMIAFH2zBKKY=;
        b=U9I8H4H2oSIiHiOYExHzDbtlEabitxKvBb85zzo0r3kYZ6LI5LNB4FdOfbfx9fW+CS
         I18MTXDsOia6GwK/EaiQtLBaEXYAxJhtyGV6rUdIpPPTYVLBaHiC58bVnDkZG5khGWS4
         S/Sm67JmUcT6KSvSYPyRUuElVgQqKIeqbz7BNVmjWMJyw5BmNgCZQfXFu0BsSrKP/B1y
         ZJtjE2W7iJVx/r2vONa4XeykBpdVvBfpbg3TnpF87W+C+YCIwUP/jrUbfXVCng7E9Xbr
         CM1oxTtUzu7e4+Iy7+BbFj8NPKmqBxH67qQEG4lno0ULzNVPG9N8ScrbsW3jubkcIbVn
         V9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691205314; x=1691810114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKcPemMGXOGkd6e68fBQ7r4rih8Hsd/tMIAFH2zBKKY=;
        b=BvaCph3ExW/LgImONc2vDNVIcm+tqDmyJej9emXoX291lsEGYDqrlhPewzpIDO/PSD
         3Jo9L4nrYqvYKUkjM9YseMl/9FQSGrF+qSdd1VGTguBc08QNQ6dl+syOPffXHJlRXvHV
         3M/LkyonG+K9bi6GaJOK5TdqCLPevq7GeWWQtPoOxBLOnR1FNM+pWhH7+4Hi+Nl694Of
         QOuKISiDGR4iSZAQBn2k+umQzwYbiTuul+3tOvQWpgdITwX8i8IjoriU5Fv/0YbfNylN
         BWlP1Vg2DIldI4AhTjd+kNT94N9J7zd9bYiNQObbU9JPcR8EDOKWwUIUNdFi0l0TvfiW
         yFNQ==
X-Gm-Message-State: AOJu0YxttKs1dmojpxNjQj3Is0g6T4eoccN89Gywl7oFk0xjO1HvYmCO
        PRhMnds9OnwzKKuNskK16cMd3A==
X-Google-Smtp-Source: AGHT+IF727UsB1OR6XS/j1Pmf2w+TyT9qGOvl5s/PK4idgD8K/HaVsCLAuTp3MqO9Y2YOQmfrB930A==
X-Received: by 2002:a17:902:da89:b0:1bc:2437:e54 with SMTP id j9-20020a170902da8900b001bc24370e54mr3797471plx.24.1691205314561;
        Fri, 04 Aug 2023 20:15:14 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:e1a0:2f9c:e6f9:e66c])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b001b864add154sm2412145plf.154.2023.08.04.20.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 20:15:14 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Fri, 04 Aug 2023 20:14:45 -0700
Subject: [PATCH RFC v2 1/4] dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head
 TH1520 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230724-th1520-emmc-v2-1-132ed2e2171e@baylibre.com>
References: <20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com>
In-Reply-To: <20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com>
To:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691205312; l=1185;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=3K5rDs8cYMn2D0gb/trpA7jiBkfDo26+066jZaEVEao=;
 b=s97bIRVyIikHucjhtT5xHg6IE+2nJkWw++h9HqF38zuLSXpBN5TObT50Cq6e4vAfFPT3/ekl1
 v33K7rJ9RVLAuIBoLMoXCyjGyiH993EE9BTsK6JRgLspdZdKbuBOumq
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible value for the T-Head TH1520 dwcmshc controller and
thead,io-fixed-1v8 and thead,pull-up properties.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index a43eb837f8da..57602c345cab 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -19,6 +19,7 @@ properties:
       - rockchip,rk3568-dwcmshc
       - rockchip,rk3588-dwcmshc
       - snps,dwcmshc-sdhci
+      - thead,th1520-dwcmshc
 
   reg:
     maxItems: 1
@@ -60,6 +61,14 @@ properties:
     description: Specify the number of delay for tx sampling.
     $ref: /schemas/types.yaml#/definitions/uint8
 
+  thead,io-fixed-1v8:
+    description: SoC PHY pad is fixed 1.8V
+    type: boolean
+
+  thead,pull-up:
+    description: True if pull-up, false if pull-down
+    type: boolean
+
 
 required:
   - compatible

-- 
2.34.1

