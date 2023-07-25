Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE67760483
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 03:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjGYBAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 21:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjGYBAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 21:00:46 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DA410FD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 18:00:45 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bb2ce4f9f8so1347391a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 18:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690246845; x=1690851645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEp58o5jHhf4WpbbQN22nWQx0p8/zKOYMNnof7eHdFk=;
        b=vQYUIaP3UkOWg+UUsUvtJtrQeBkFRh2XYqhD/95/TJDC5tf8+Sxd4VYFWC5Qzp/DEa
         1+J3CECCqJYhp6+EgvglH4ZqQ0VBS168afINnhIjGsD5jZUh9tdtFonMC3JwySuSgkP0
         kdHC0TcCRCsnjY0EOZrhB3MFX/e6Gwf7UuEsCfMXSkHKkJ7g+Ht+16r5YgJdFstm2sE/
         vdBabJh+hBe0a/u3QHX92/XIRR3HGtSY4N82AJLpFMIZJP8KAM76Bi+b6OqGHsP5uaxx
         YTcNykj6Tplcgg0qhI7b4Twowz7OWDbyWitEkx0TdwG0P70Er1rDwN8BW6EkJJBM23Z8
         nz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690246845; x=1690851645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEp58o5jHhf4WpbbQN22nWQx0p8/zKOYMNnof7eHdFk=;
        b=jxFaD+NSk3K+s9Jvw4YfyghmvLKWuxrKq6g5MhA4XQVpdxcahs1I0HWh2PZM0105+7
         RYtlK4ZlSVgqTJ8aZKcYbMdJH8HclIHOtNERhYummjn0tnK9TRyYF16++mxgduMuJK4X
         j4OaxalOICjZWTdPYlSBkRQJKYhunVJTjhhGs0APRcMtStbKxFLvYvzJ3B9ng3d4oAN5
         ZvzY9NyHpLfSIWxckKzStzskAolBvK8Gx9+Wqnik7mz8L3SbzwtW2HyS3AqFCkeVE+ER
         cHJEmrIzlEwfP3Bld+4CNn/e9gOufC6PXkAceQ/G2S570BA99V3UEfLHQqLmM3g8zovF
         2fAw==
X-Gm-Message-State: ABy/qLat1bmzmrjM7oCCuRTRF3vtrsFcgw9zi2v8UjuOfX0JWEzwpLz8
        M9Q7sdwbGi7NTi8TmDTHBHiK0A==
X-Google-Smtp-Source: APBJJlGYcDIG17o3mn7rt/BZ3kSGI2riAzNxr3+T4CZvjH8BN0WgGybsiUplpUKV0LnPk51YAiQb0Q==
X-Received: by 2002:a05:6870:a2cd:b0:1ba:9a49:d967 with SMTP id w13-20020a056870a2cd00b001ba9a49d967mr12042723oak.23.1690246845066;
        Mon, 24 Jul 2023 18:00:45 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:2cbf:9196:a906:e222])
        by smtp.gmail.com with ESMTPSA id h18-20020a62b412000000b00682a75a50e3sm8576900pfn.17.2023.07.24.18.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 18:00:43 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Mon, 24 Jul 2023 17:59:15 -0700
Subject: [PATCH RFC 1/4] dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head
 TH1520 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230724-th1520-emmc-v1-1-cca1b2533da2@baylibre.com>
References: <20230724-th1520-emmc-v1-0-cca1b2533da2@baylibre.com>
In-Reply-To: <20230724-th1520-emmc-v1-0-cca1b2533da2@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690246840; l=752;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=N4XyeVof9hR52mLfjwIJ/Ek5oPrydhGBm0Gy7EtJsFw=;
 b=0OVYnsUPwsHTJB6utTUVvs+L8qB3QLAy9tLpLZXXUDTXz4CyeazHaGQ1XaIA7MYQNO7XeP0HB
 NVJqdcnkvQpAIxMHf7GEH1Vd/Pyve0bmoxyOFWcaiQtG8jPD3agvxxh
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

