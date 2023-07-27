Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3562876583F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjG0QG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjG0QGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:06:25 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3BB2D45;
        Thu, 27 Jul 2023 09:06:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52227142a27so1428400a12.1;
        Thu, 27 Jul 2023 09:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690473981; x=1691078781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KJUb5wJMX455Ly+7ii8j4l9cAoayBImjBImEkrRStY=;
        b=UTD2d/1H3fEe3uEhBhHdDJP5WJa1vOv1Bk1xcS49fZYSHyisOMs574Eib844vVW3nW
         JFLs5xYkb5iwTsBM+KV+G25HuM0/U9M57rjGGVUG0RehxGNG/4IMFTPwiH8MDjg5jJ9v
         kAdyNHv0embVoj+ag5HbF2NZe4Y69Es3/9GtcAyeVNF4sQ/Jop/vnOuY0a9V804XRD2n
         /7eNglqFxdJ6k+CqxAnTjOzDrbMLTsnrpWbwpwizRBmAWr+OHt5GNqDU0MG8PqEK9cPy
         bTMb2ncHP1oxIpHePnyj76zZ0VzTsX/HwXN5uccUJS7y5JUdDOyjg+NuDNwsjm2TtsPP
         eApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690473981; x=1691078781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KJUb5wJMX455Ly+7ii8j4l9cAoayBImjBImEkrRStY=;
        b=JeFQD9OGP3NpfJ85Pu1Svtm0CjzbAdkvpoai9HsfKflOS8tf2CbM4y5CHnHR/roMoo
         Wlzbvg27+88L/T10MFKVXX7A5bDu6N8YirwyGWRCFiZiLUHeJklxRRVyIlQRH/YGrpoK
         wo2xt0yH38+9Tzo9hGs82NV9dBUtxgwgYrYZ4hXcU7X2D7MbJoqMO3o3hNe3zAwVwu9u
         DtcT4qtU9DEUtuenH2ticBYFrZTL7QRmcX3RxZ/eO6omxlRklZKNzZtWGgzmjFW1Ctck
         ZEPQkAjI90QG3rQFJRj6t+4IqXLqVEksT3c7y0/wdFpXcbkKCtUaQII9D2J1zRKBQcHu
         r/LA==
X-Gm-Message-State: ABy/qLajj3X+u5E6CKgMNfXFmbn57ZNFLpTDN7hYZVDQIskisFKLGzU9
        4Ttl9aZHlsFc/Qn3medRxX4=
X-Google-Smtp-Source: APBJJlFQ5aa+IoIf4ApWsONPuCycLjstk/YHtbUGTH1E6Vfm8G75YVIrg2tXFM2MNx/N5JZfPRkFJg==
X-Received: by 2002:a17:906:cc49:b0:993:f9d4:eaac with SMTP id mm9-20020a170906cc4900b00993f9d4eaacmr2074811ejb.24.1690473980698;
        Thu, 27 Jul 2023 09:06:20 -0700 (PDT)
Received: from localhost.localdomain ([2a01:c844:242b:b300:215:5dff:fe78:868])
        by smtp.gmail.com with ESMTPSA id ck8-20020a170906c44800b00982be08a9besm936540ejb.172.2023.07.27.09.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 09:06:20 -0700 (PDT)
From:   Matus Gajdos <matuszpd@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matus Gajdos <matuszpd@gmail.com>
Subject: [PATCH 1/3] dt-bindings: Add vendor prefix for Broadchip Technology Group Co., Ltd.
Date:   Thu, 27 Jul 2023 18:05:23 +0200
Message-Id: <20230727160525.23312-2-matuszpd@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727160525.23312-1-matuszpd@gmail.com>
References: <20230727160525.23312-1-matuszpd@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Website: http://www.broadchip.com

Signed-off-by: Matus Gajdos <matuszpd@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index af60bf1a6664..dc1ed3dc0c9f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -202,6 +202,8 @@ patternProperties:
     description: Bosch Sensortec GmbH
   "^boundary,.*":
     description: Boundary Devices Inc.
+  "^broadchip,.*":
+    description: Broadchip Technology Group Co., Ltd.
   "^brcm,.*":
     description: Broadcom Corporation
   "^broadmobi,.*":
-- 
2.25.1

