Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3375A77753D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbjHJKAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbjHJKAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:00:18 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A872683
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:59:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso6495455e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691661579; x=1692266379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Qov7/EIECuN7YtcszuKxgzKAg/7N7RK250nQPWPETE=;
        b=v30CTiX2qKSiN2j2kOUXUCQ/qjZOMt4Q+Owm3rESRLeuhidDmOvCrOs1B751U7IBfS
         zndSh6XEzMhiKeb+ubNbtz+e+V72tx4UaERrTzDLqmbUcQYMs/Az6xez653LBbsHef++
         T9dy9CN7KcU+b943r8yFryvjBu0JP7Mk4ItyR7P7x3+Q5qJFaJ51j4Q2b/y97aIH/w6P
         1RV2EzPllNQXNlOmHPs6wh3Qhc6uM/GvDWF1x8cfo5KWrurWHjgFCklcDtSh+vy45EqG
         /52U0A0GZVABjs+kvw7xVTeo0AFbVpIu6lKE/5Y7B+42GaFluEopx4cLAWbAg1eFDTnp
         NyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661579; x=1692266379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Qov7/EIECuN7YtcszuKxgzKAg/7N7RK250nQPWPETE=;
        b=ZJ6qfZehBbHClvKQraD8/Xu4rwj2207PgVJ857pPb90NLOI0rsvAWlRch8eejsiLBl
         vxkpSJah7IYjE4aiGN4+Qygc2Kn+qvvjTYWIgItIjDFqsgF9qEJm210eWs5YxmyT42vI
         DrZRZJv4r8IeTkK3BFaX/mfIzPOBJKxj0yxW4qtBLGUn+fIvqvJyL53hOkoT1uGHJ2rC
         72vWehBcoSTxOaJQCG/abAkkaW253QfKjtaXiK8o5mQGh5s4MkMAhYzuhDSHzpOzsQYL
         y9lp+p4ilPGrahyqzJumwEpm+mUMGmmcoDm8zds3WX3pd6CONfsSwH/1fPZox5HkbxVR
         sxUA==
X-Gm-Message-State: AOJu0YyBBDy9UbTWa+YKUrjxhdV0nOgiaFoKvEuZXqiA37zOLw5CP03F
        vQ6zdzJ6cKj4LuiW2ig3XTV1a/+bvdR4p4zhD1TKQw==
X-Google-Smtp-Source: AGHT+IHW36O9ukQNOr4QWHcwll1B7aloOQhK9sSqv/YA8EWyZmzq6BHWsNTyVSKuU/1PJGhLJb1ZvA==
X-Received: by 2002:a5d:66c6:0:b0:317:9537:d741 with SMTP id k6-20020a5d66c6000000b003179537d741mr1614416wrw.54.1691661579124;
        Thu, 10 Aug 2023 02:59:39 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d4d42000000b00317ca89f6c5sm1623182wru.107.2023.08.10.02.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:59:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] Input: mms114 - fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:59:35 +0200
Message-Id: <20230810095936.123432-1-krzysztof.kozlowski@linaro.org>
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

'type' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  drivers/input/touchscreen/mms114.c:507:15: error: cast to smaller integer type 'enum mms_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/input/touchscreen/mms114.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index af233b6a16d9..d9beb15a3676 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -504,7 +504,7 @@ static int mms114_probe(struct i2c_client *client)
 	if (!match_data)
 		return -EINVAL;
 
-	data->type = (enum mms_type)match_data;
+	data->type = (uintptr_t)match_data;
 
 	data->num_keycodes = device_property_count_u32(&client->dev,
 						       "linux,keycodes");
-- 
2.34.1

