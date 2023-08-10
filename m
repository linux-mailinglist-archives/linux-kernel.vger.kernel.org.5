Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8631C777485
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbjHJJcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbjHJJcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:32:05 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E405F7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5230ac6dbc5so855623a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691659922; x=1692264722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G5U9OyHZkyp7R4jd9YJoYn9GiUGEosxVPGm88bMk714=;
        b=bQOP8BXZG+PsoDvWGzlAR+7vcIHL3exlHy/6+jJ30kM54Q+zPdID7gdUx250QyqPeK
         q4sqlsR57/tpGFynpq191xhLWBZRpBA3j9mWyZUfyv5B7Fkmc/tz5d2SZsuIb5u6bm9u
         HS9oafI2uZh2lOqXQGd/SUynude/mUHXQypQKmDHY5mNL0q3LDvJr4bAxGMBQFa0jcUr
         QEA8mlYFH4Dcr5G1aOvmCmBf1s+PVfMmWhyOV7vXPmJ3L/uG7VjQgRRuUnkZpvUW+kTT
         8m8cr0SZ4MTQw8NqdBthJqCfuIq3Gp6V22yb0si0lBVwWSK80swEBUS4eG+h44+kprkM
         FUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691659922; x=1692264722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5U9OyHZkyp7R4jd9YJoYn9GiUGEosxVPGm88bMk714=;
        b=GKagJm08uQXArj3UI/yajsgQZQvq5BhHfGLBfCzK0w6IOV11flHzdXWN/kyX8GKBHh
         SIO0cT3y4KJA+XlEThPQFHOcNRERlSLFGFgA7MMtklbEiCVolu6H/oPktdHIczqKb1Br
         Bow7839p2siczhJ9xFkpzo7XN8SBRYt+8l/0jMNTvUoI2rOzGs95z65rr76d6UOJUL+v
         I0/JMMXrZ6LUicnsYD+T0RC0DJwTVm/56y8GRaIScNmlK5Fz1sICy4dxEBq2VaFaK1cY
         WwCnUXzV77BtZ706aa7utbucD+ToDY4w57cnq7rHm3gudWGXCTpADXirIdjAYT6Sx/s5
         Ym1Q==
X-Gm-Message-State: AOJu0YzgeX5WvRIoeResZV08C9KGSsYf3iuntkwk7vB3lRw4WQKgKB43
        Dp5flxyjAHpU1fPnbjRSmtQfZQ==
X-Google-Smtp-Source: AGHT+IH5Bqb3CQOStHITFc5O637GOa9y/gEBFquykoaU1GHTJzvzdpEXHn6jEdIpCthu9D3UsaaZNA==
X-Received: by 2002:a17:906:31d2:b0:992:9a5e:3172 with SMTP id f18-20020a17090631d200b009929a5e3172mr1473028ejf.59.1691659921724;
        Thu, 10 Aug 2023 02:32:01 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906249600b0098e2969ed44sm667642ejb.45.2023.08.10.02.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:32:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 01/15] hwmon: (adt7475) fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:31:43 +0200
Message-Id: <20230810093157.94244-1-krzysztof.kozlowski@linaro.org>
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

'chip' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  adt7475.c:1655:10: error: cast to smaller integer type 'enum chips' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/adt7475.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 5363254644da..03acadc3a6cb 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1652,7 +1652,7 @@ static int adt7475_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, data);
 
 	if (client->dev.of_node)
-		chip = (enum chips)of_device_get_match_data(&client->dev);
+		chip = (uintptr_t)of_device_get_match_data(&client->dev);
 	else
 		chip = id->driver_data;
 
-- 
2.34.1

