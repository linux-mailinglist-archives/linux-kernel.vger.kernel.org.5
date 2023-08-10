Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F67377754A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbjHJKCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbjHJKB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:01:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A67E3C3A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:00:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe5eb84dceso6212925e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691661606; x=1692266406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QWK8jSm7OZOgtf/JSqZHgi2knmx1jBIVO9gs3YkEoNE=;
        b=Ey5doVBcOsn4Yza5LN+1bFuLD/arvUZtuYgdbEmBPTSfp3GzIueTCMVxhExuU/c0m7
         oVfGdzGQpeU2bvetaaxAarPdT30QKXkq1K4yENdBMaB+nhA2VF8S1yj4Qi0W2FmDqHHJ
         /MJ5MZBuGkEcylWCs1+RJtGQRcCXW4IYbppWN40im3S1PM32W9kEzvEW5h7WFB9r7QOs
         AHsaFkXV9hWX3r6wlIprb4CgtnXhc8JV7KqJvTHtFK6FEsYyn2vSOfY0I0NPRF5X2uco
         qihncH/6tPk2VE1qiQyUDOzE09IfS3+z5GqHCoXj+t3S27uZC9Nj31w6hYznRK33AazV
         IbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661606; x=1692266406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWK8jSm7OZOgtf/JSqZHgi2knmx1jBIVO9gs3YkEoNE=;
        b=hTtYOrKtPyekom+vJtyRBqmZBF3vWtNj08iwirYr2XlRaNTOBqrAHobUo/LeiePhZB
         7Bv67ACI376YI5aUgoqnO4/tZMsO2xRm5z0b697EHLU2KA3noDHq1GIaP7a4zUGK8BfK
         FzgA7BnUioF87D5puWuFGxZ6ShdhaKYbaRRGb8vcEmPDnsmI2T4/WLM+h3cFDGDdU3kd
         jMINNQNJMKlBqOzzpBIRnep6wFkjoGaOdIF04mg8xvyjxcw0Fds2/aT3Xom9wbUtyqDD
         Qd664DzWeYJDpv+hgvaog/4IojtduVg5nn+4nKmw5gUi0cnWkR+rWqXYExodr45ZVJu9
         l2Ig==
X-Gm-Message-State: AOJu0YwsC83CFNH6mntqRTU4XPfIDZ4XzHhGZcMEjV8zWl2lWvdpqPoi
        FtxTPqEcOfkGPC99u0i7+aaKUg==
X-Google-Smtp-Source: AGHT+IEEVh8QZHoVHpvxYhNgkPw7Wd2mw7z2yO5JmlfgraMCtvSlLF7uV1u96DMiEdR/voWPpWT/1g==
X-Received: by 2002:a1c:7518:0:b0:3fe:687a:abad with SMTP id o24-20020a1c7518000000b003fe687aabadmr1443541wmc.20.1691661605747;
        Thu, 10 Aug 2023 03:00:05 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fba6a0c881sm4498953wmj.43.2023.08.10.03.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:00:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dmaengine: qcom: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:59:59 +0200
Message-Id: <20230810100000.123515-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'cap' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  hidma.c:748:8: error: cast to smaller integer type 'enum hidma_cap' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/dma/qcom/hidma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index b5e3633e6a5e..499df3c83976 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -745,7 +745,7 @@ static bool hidma_test_capability(struct device *dev, enum hidma_cap test_cap)
 {
 	enum hidma_cap cap;
 
-	cap = (enum hidma_cap) device_get_match_data(dev);
+	cap = (uintptr_t) device_get_match_data(dev);
 	return cap ? ((cap & test_cap) > 0) : 0;
 }
 
-- 
2.34.1

