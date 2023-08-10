Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0642B777523
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbjHJJ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbjHJJ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:58:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E600F9F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:58:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31771bb4869so703879f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691661532; x=1692266332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FkvqrMOXwmTcAnreaYq76I2AZtMUkMuF0vVGwhitEBY=;
        b=g/N1DWT58qicPn7aM797a838CAd0plUzi2BJWNf6ENVZomSjPXW96FFjXdcqIPtGZA
         BD2ihtG76tzRLS2QdSMjMUBQKnIHTxGmuBP78cqDNu07vqDTWPH1maafZMCdE5PeY5BF
         673UABS0RzviQvrOKhpsOJZ085Yzz9tuwo7QyPMBaywSxJMZ/0sSEjBFNDkq08f/CfHm
         yBeU1fg8oWVHc0jKQPonwe7w4LrFo4shzFaxzZGKLobN5K2BysRlSs2iT8/gqBGuOhVX
         g4Osxd3++ssQbMdARZhvPXtmiP7+eh3xqNEyXCHS/ilTIusiG9AFAovZlOCppQ2xnLng
         dM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661532; x=1692266332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FkvqrMOXwmTcAnreaYq76I2AZtMUkMuF0vVGwhitEBY=;
        b=I/Amk/aN/zJjYhE0/AHBsdSJKoomXTIKGA6C9xLE3iY4JBf8bsQQlB8wX0s3tH03w8
         8SHwRUwXM7s7y4mAqewvnLEO5dC3kOYqb4/gK98dxdTNLfDfiZtY1vRmNM8nPa/x9JrU
         0nmAXsWA8+IyD2DncEN2AR5yxbic70O7P+EdulP2RMPGfngNpSR5wIvCtMWttnQI46Rs
         aI0gT27O32zsWUWhUKdGi7eFyQS0WFzZG7YYBXLx1C1X9McYD1uYcL3OIl6mCYG8POqw
         E9SaDEaCJrROrxgAQFhLes5XLgpQXelZ5T8efnj6A2QV4DDEZzgN6Yy7qiGz80Eo1BHs
         H3TQ==
X-Gm-Message-State: AOJu0YxfTkQ6vWHn6QrGPRbFa9vrV8bhAwCfAa3tBYGii8gY0d0AsRGj
        mOfFvwQeByezoNEL4GTFboSDgA==
X-Google-Smtp-Source: AGHT+IG3X88ZKNaaHQptsEX+0z/EjxkhWAIwDrqS7AJwZwHbDUAJ6BHLalxATlDkew0dnEFTGjO0cA==
X-Received: by 2002:adf:f74c:0:b0:313:f5e9:13ec with SMTP id z12-20020adff74c000000b00313f5e913ecmr1581022wrp.68.1691661532380;
        Thu, 10 Aug 2023 02:58:52 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id p1-20020adfcc81000000b003179b3fd837sm1621372wrj.33.2023.08.10.02.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:58:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        patches@opensource.cirrus.com
Cc:     Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 1/9] mfd: stmpe: Fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:58:41 +0200
Message-Id: <20230810095849.123321-1-krzysztof.kozlowski@linaro.org>
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

'partnum' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

stmpe-i2c.c:90:13: error: cast to smaller integer type 'enum stmpe_partnum' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mfd/stmpe-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/stmpe-i2c.c b/drivers/mfd/stmpe-i2c.c
index 1d7b401776d1..fe018bedab98 100644
--- a/drivers/mfd/stmpe-i2c.c
+++ b/drivers/mfd/stmpe-i2c.c
@@ -87,7 +87,7 @@ stmpe_i2c_probe(struct i2c_client *i2c)
 		dev_info(&i2c->dev, "matching on node name, compatible is preferred\n");
 		partnum = id->driver_data;
 	} else
-		partnum = (enum stmpe_partnum)of_id->data;
+		partnum = (uintptr_t)of_id->data;
 
 	return stmpe_probe(&i2c_ci, partnum);
 }
-- 
2.34.1

