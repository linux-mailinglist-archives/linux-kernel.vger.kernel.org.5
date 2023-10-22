Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98BA7D20DA
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 05:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjJVDMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 23:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVDMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 23:12:15 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D176E8;
        Sat, 21 Oct 2023 20:12:14 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6b5af4662b7so1731006b3a.3;
        Sat, 21 Oct 2023 20:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697944333; x=1698549133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zd+0FlCpxjN0Ur53m7FdMqpc+SVtrfNr+NITjaBoxE=;
        b=EThJDrF2Rp271Zrr05WmLqTDhgW2aquJzYtRQaOsDDJiuTJWqtRUWYEPhSaS1OoM0S
         R/3A0cTrYBdt8+bMkotFK1KN8a8skUnElGFYdxXqgVtkgYUNvTmzLvC8S0lh2TMH2aem
         1jWJ5QrU7FRwQk+0tVGxv1SxztgoJXtG56j5K9nb7Bq82zLs2U8N5dRxy5RXFqXRmHYu
         sxVfrDjyiKVKfioWoL8Y+IgzT95HKRjtKbuSgwC16EheFB+ExRm5gB6NOc1ZhxDO6I4S
         AbFl7mYViIghZNeRcYe3gsRJsEoNZqsk9bJU8+v4HkbicwwEtqyKGd/kw8faTVmrGXMU
         k8JA==
X-Gm-Message-State: AOJu0YxGNJ8OLA1Cz+1YT5Qr/tsLJqxqe+RW5QuNbGKoNBkGglYjQ210
        PRMLsw8vfrO6TNNAsHwN4lnr6B9u7aoPb89l
X-Google-Smtp-Source: AGHT+IE+nTRcMsN9zRkItzQBzFRpACZVO1Gt/XiL8tBeShilF3ZdtRdDmlvfvoeyW9DP3i4iGYIJKw==
X-Received: by 2002:a05:6a21:7795:b0:171:c88a:890c with SMTP id bd21-20020a056a21779500b00171c88a890cmr4485675pzc.25.1697944333424;
        Sat, 21 Oct 2023 20:12:13 -0700 (PDT)
Received: from dev-linux.lan (cpe-70-95-21-110.san.res.rr.com. [70.95.21.110])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001c9c879ee4asm3789589plf.17.2023.10.21.20.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 20:12:13 -0700 (PDT)
From:   Sukrut Bellary <sukrut.bellary@linux.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Nishanth Menon <nm@ti.com>
Cc:     Sukrut Bellary <sukrut.bellary@linux.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: ti,adc128s052: Add adc08c and adc10c family
Date:   Sat, 21 Oct 2023 20:12:02 -0700
Message-Id: <20231022031203.632153-2-sukrut.bellary@linux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022031203.632153-1-sukrut.bellary@linux.com>
References: <20231022031203.632153-1-sukrut.bellary@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adcxx4s communicates with a host processor via an SPI/Microwire Bus
interface. The device family responds with 12-bit data, of which the LSB
bits are 0 for the lower resolution devices.
The unavailable bits are 0 in LSB.
Shift is calculated per resolution and used in scaling and
raw data read.

I have been able to test adc102s051,
hence adding just the missing ones in that family.

Lets reuse the binding to support the family of devices with name
ADC<bb><c>S<sss>, where
* bb is the resolution in number of bits (8, 10, 12)
* c is the number of channels (1, 2, 4, 8)
* sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
and 101 for 1 MSPS)

Complete datasheets are available at TI's website here:
https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf

Co-developed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v2: 
        - No changes in dt-bindings
- Link to v1: https://lore.kernel.org/all/20220701042919.18180-2-nm@ti.com/
---
 .../devicetree/bindings/iio/adc/ti,adc128s052.yaml          | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
index 775eee972b12..392b4a3e867c 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
@@ -16,6 +16,12 @@ description: |
 properties:
   compatible:
     enum:
+      - ti,adc082s021
+      - ti,adc082s051
+      - ti,adc082s101
+      - ti,adc102s021
+      - ti,adc102s051
+      - ti,adc102s101
       - ti,adc122s021
       - ti,adc122s051
       - ti,adc122s101
-- 
2.34.1

