Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248C5777353
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjHJIuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjHJIus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:50:48 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8981BFA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:50:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-317716a4622so641920f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691657446; x=1692262246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zUA6Uop1470tUJbDViYaX4LRHpvZYJIyke3HCwbN6+o=;
        b=o2dv9R0JA3ZxL9ing7at6nqKjTLilmMT0IQRbfsOpS8nBL9yjoITmy2fRO+my3ZMRu
         s+5a+R+fxQDERaGpBHUyUsDhTzQNOaKC1pNAuNA+P2i1Xra3XgkKLHODmJEyEABz5lIc
         TXXVcRuElWHjZU30tkr19+P3PI+9FiD2x5wOPq0sKGOuxqcPPX5lDd0IdorEgvYuO69p
         y+gy90/0W/HJqjb4yqVFS9X0OzWyl7T/ieaeEWoX9DIa9bDckj/75hVKwniRSqhnIkHo
         Z/2LKe7ax2ZNTZUzXO+Wr1qNfv94J30qMRMfgJb1ULBW+y9rLXuhZHfbeeMvy2Gto9tr
         s/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691657446; x=1692262246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUA6Uop1470tUJbDViYaX4LRHpvZYJIyke3HCwbN6+o=;
        b=TCVb/95oIrrBHX+Clr9crBjsbPOXqIu4dir+Rrazql/sGsWs20nxxBQf2BItEPpxbT
         2Xx3XAmCzGqFNLRNxkF8dyDsG+YE9sp0sWGzw67dELi9c8FlkUaFSiGlnscXVsgf+eMj
         Ns1d2Dnp20OW78yk2bB544yJRy6ZwbN2Gyfu7R7WlacgacNR0eoKH9/bgOSrCiD100FQ
         H0zRshN15BnixtoPW9b97WbdgePc7JuW4Ss4Fio4sMfuzHTka/kNGitoJJfw3Z6fKJwD
         KLfx6oht1SzwaKhI2In8B4aWiaQXtxZF0CRkOSjHFTYpiMVnf5RBGa5a283W8R6Qj5UI
         dISg==
X-Gm-Message-State: AOJu0YxGtLoOw0u2rDkdjsW1hg0CFL7WfShjr9rN0h6ELKxUiuROBCd0
        3tIzUlSM9MvDlhvTkVfQGOkKRg==
X-Google-Smtp-Source: AGHT+IFb8oMsS0S9gnDkp6ZtkyHaO2DhrB8218z+QoY+VxqPi+V1z6jMgz1d8pK94alrz+7qUBOzLQ==
X-Received: by 2002:adf:f011:0:b0:317:43e0:3f47 with SMTP id j17-20020adff011000000b0031743e03f47mr1605618wro.36.1691657445994;
        Thu, 10 Aug 2023 01:50:45 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id q11-20020adfcd8b000000b003180155493esm1395013wrj.67.2023.08.10.01.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:50:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH] serial: mxs-uart: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 10:50:42 +0200
Message-Id: <20230810085042.39252-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`devtype` is enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  mxs-auart.c:1598:15: error: cast to smaller integer type 'enum mxs_auart_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Cc: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/tty/serial/mxs-auart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 8eeecf8ad359..a9b32722b049 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1595,7 +1595,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	s->devtype = (enum mxs_auart_type)of_device_get_match_data(&pdev->dev);
+	s->devtype = (uintptr_t)of_device_get_match_data(&pdev->dev);
 
 	ret = mxs_get_clks(s, pdev);
 	if (ret)
-- 
2.34.1

