Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15207792B28
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242493AbjIEQtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353494AbjIEGYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:24:50 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81539191;
        Mon,  4 Sep 2023 23:24:47 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c1e780aa95so9196505ad.3;
        Mon, 04 Sep 2023 23:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693895087; x=1694499887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxsrMn8x6tATGpvznfjqzPrwJumviFEl/w5yRwpiI7s=;
        b=WNzlzIaGv8YFA+uWY2fyISqnQEIafl2sUP/766sOu2rQSx2iip+GDdSVsE79dvPtpC
         gMUhYB/ZrawS10fdh6T0dAeqi+5QefXdv60ZXSPrAkAePagebVdDJYjRaw8V8XgxHUVu
         SGfAjecDqdDVNwl3fYiuRnKsbttrT83MgNk+hTINwnSpSUu/ChVCwOKufYZ7+BE/bNEQ
         6UTb4VK4v1hrpjCKaSQWJx1Suv9pJ/+/IAzEAZ8WEmNjrT1U7Y2JK8UF+pNaUb1fKsui
         zzExirWyHOs/f9rb6QCUwwLXfOMXNNm5uc0cotARf6gd/PJ7EE5zQW5hZ8tYABXkTQjV
         7/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693895087; x=1694499887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxsrMn8x6tATGpvznfjqzPrwJumviFEl/w5yRwpiI7s=;
        b=PQhk+gl6NH1XRzrMG5TtU+CpYO70OdONpB9lFSMdBLEB3rQzDwVRL4NbAOWJJfmlLz
         O3LaqaJmLexNdrMZaLoBz9bcEg9m5XolHKdOVqm6BDlQlZS6r9ZnMQOaq2CMgGC5CrLQ
         OM/W4S2gT4iOg5gYkKLNJY4dpaJqN+7Dfr54Q5aVvDJjsTC3iPu2sMHL8wX0jWDEEo16
         LmNIb10UoWONro87PGFAEFtJzc2pf2FSHVfxCZ5NRfg2Domr//7Qdynh98AC1GeIlF/2
         TIKzVoosMjwTyVQe8P6O1Auy6KXo800g1VroEApK1zdjqaQFb6x+y4dtUY5EBmb2s9JI
         EY4w==
X-Gm-Message-State: AOJu0YzHer3B6HwIn2pEYHdwDSoKwLWfMHVHc1KL6K0UcdS6PvXV5Ip9
        Yx4LeF2oGNXo29fmIdDPE1I=
X-Google-Smtp-Source: AGHT+IEmYFc4UXj9sGYfzDZOUMWP0jG5d5GRi/cJBVbr6OKF0F7K6iBbRd7s5GJlOBV4JH85PJYWbw==
X-Received: by 2002:a17:903:3256:b0:1c0:ee68:fc84 with SMTP id ji22-20020a170903325600b001c0ee68fc84mr9132351plb.26.1693895086970;
        Mon, 04 Sep 2023 23:24:46 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b001bd41b70b60sm8526721plh.45.2023.09.04.23.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 23:24:46 -0700 (PDT)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     peter.yin@quantatw.com, Peter Yin <peteryin.openbmc@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 2/2] dt-bindings: arm: aspeed: add Meta Minerva board
Date:   Tue,  5 Sep 2023 14:22:22 +0800
Message-Id: <20230905062223.774871-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230905062223.774871-1-peteryin.openbmc@gmail.com>
References: <20230905062223.774871-1-peteryin.openbmc@gmail.com>
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

Document the new compatibles used on Meta Minerva.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 68f717670f78..32582ee56264 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - facebook,elbert-bmc
               - facebook,fuji-bmc
               - facebook,greatlakes-bmc
+              - facebook,minerva-bmc
               - facebook,yosemite4-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
-- 
2.25.1

