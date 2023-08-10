Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A42F777601
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbjHJKjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbjHJKjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:39:07 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14A810DA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:39:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso110232766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691663945; x=1692268745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GPET/8xbW9KfixaXy/3dH2F6+eueO+mbhdFOuDhANY8=;
        b=jWqntEcnvXKTmbnxQsFCm2cMvf8PLiBuQrLk1rwrhS7jnuPQ4z0dp6n0IaXAHIsqUH
         V7d6UeOThHJ9cA9npB/LOT1Y3FqrCGdD4cnAb+TcBwkfROII6L+dMuIdvpnlpGS7XZfV
         o1w4VR5gEZrNu8MCXlKbeAskkttLDiulZ6vi8zDn+2oIk37SosmpHjRmXDpM19Tn/pIV
         YWfXeuNQLi6Zy+SgxMHJAVvPccHXbov74I/bLdyLNDz8aAmPhYAAe928NM/Q5SnqgONN
         GJDeAw1uC4rL79BzKUOAMXa1J9sxZuEAZ0hVapKvNxpa3CaVnrnEQWyYG4OJ7L5y6gp9
         IYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663945; x=1692268745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPET/8xbW9KfixaXy/3dH2F6+eueO+mbhdFOuDhANY8=;
        b=IUyUDehs378CmqxaMDHO5ZTmx4uLfgOTFn9qTEES2WQdATN2u4nma9ZfpjlGWLbGn0
         9aECBxLPrtwVhgx5CNO/MlJVy3rb3FiohMuFI1LHKouDM8RxRCdKxtxX+YpR9o4amGde
         9VL2HbqJkqoof1ftSO9cxUltT+zr/MSfYjKpjwMgJwUvK7whg2QMC9Zqv+5VnVdojC6M
         8igW0qPa7rQ0UI38mp5DvFqjiKaYkEHztj2PzgGXugq2nHV++0TT7m8AyT76y/YseWd6
         7wCeU3fBQk3YhAB3zy6EH7AcBBdL4RlCJN+Fu8Ngp/aXzbvzokar9aq+MgoMkmGZf67R
         aMQQ==
X-Gm-Message-State: AOJu0Yw5KdwRIzRK7CLrTONrWhW3RF65i8UiwWfEjrjF3M3Kc69T+qWk
        rtJqrgeTdWmUw4jetmBdwrFQIA==
X-Google-Smtp-Source: AGHT+IELgt+KjxK743DSJKaI1jmqAfjuVrtmcAw9JFRkl7XRfteq2RZ4ARNgkHjliKBPKGwIjteatg==
X-Received: by 2002:a17:907:2cd1:b0:992:61c5:dab0 with SMTP id hg17-20020a1709072cd100b0099261c5dab0mr1693290ejc.62.1691663945185;
        Thu, 10 Aug 2023 03:39:05 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906868b00b0099bca8b9a31sm742180ejx.100.2023.08.10.03.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:39:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] rtc: ds1307: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 12:38:59 +0200
Message-Id: <20230810103902.151145-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'type' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  rtc-ds1307.c:1747:18: error: cast to smaller integer type 'enum ds_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/rtc/rtc-ds1307.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index cb5acecc11aa..506b7d1c2397 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1744,7 +1744,7 @@ static int ds1307_probe(struct i2c_client *client)
 
 	match = device_get_match_data(&client->dev);
 	if (match) {
-		ds1307->type = (enum ds_type)match;
+		ds1307->type = (uintptr_t)match;
 		chip = &chips[ds1307->type];
 	} else if (id) {
 		chip = &chips[id->driver_data];
-- 
2.34.1

