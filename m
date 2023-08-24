Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262CD787BE7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 01:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244055AbjHXXQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 19:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244108AbjHXXQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 19:16:47 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E221FCA;
        Thu, 24 Aug 2023 16:16:35 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58fb73e26a6so4844737b3.1;
        Thu, 24 Aug 2023 16:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692918995; x=1693523795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ej7u2sLvQYFwoj3+JMpYyYaVBr+a1QkbS39xV9nWpM8=;
        b=YRtYe+M0+6RKAQaXsi59YjPn1gzEQmddS7HMwouYy0Cm1U3JBzXozWALtTGMj3vQW8
         d7luEkJ8zbaXhGghLa7FaX1covHm+kDVdnO1ctStsx9Kdh6dY/nx95NmLU6y5iC/U9kf
         FI2YsMAr+KR8KEDPwURip2a+0Jhj5RNvoAOgIc2ZbemSzQ4P34TZQzEWnjqIT2I8kw1T
         mEDR2iKl5wAIzfy08WG2HJEWRuU1zqbHUqMSefQXCRdiayrm1xhfLJFNrQ2nbdTbUqW8
         BR3jM0KPJ9Q3uD51YZ4+ieQxYHYwxC+HUGpYuF+mpq/xcofhPwvkehyPQuY+5pg0sy3W
         IG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692918995; x=1693523795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ej7u2sLvQYFwoj3+JMpYyYaVBr+a1QkbS39xV9nWpM8=;
        b=PRaDUBM9vXU0jrLoD8+7MdcASk4MBJyPcxLvYvfkCQ6RW4wlcf7y82veSxVWznYqqo
         hvqyldKwyuYtV5qfIp1+Mombaa7PHlvCUIqJVETAeeM7qgtFTX+eCABdpkReyq97rt1j
         HK0XigoKIaqkSclqv94Y3snrg6lWcuO8iQCZh8dz26ZJxFjU4xKHvLmSzwD2Uj2yZjoc
         w0nYEbuReniggs2YmUfNPBg5/teD5+I1x9RljGS0PLVN9RZhOwDUXxRWpCUb2r9eu0fx
         wtwAH0Wib9Gdm/QS7thZEjyv2SseOBI2f4iIfUC8PNTrP8NnFOQhXNv+18vHecJBrFdx
         +skw==
X-Gm-Message-State: AOJu0Yx72Fla/Ibx3BYqQ9GYZ8FKugg/fMx0DRf81dfOCMabXLuxCbTB
        l/L3syz9mJg8hER0uxGUKdw=
X-Google-Smtp-Source: AGHT+IEU+QXBGth08X/fOlo9uPBl3YqWbyO0Y4mDMeSldqEhV2hi5tn6poA/RuNY7sAPLdsLXVDScA==
X-Received: by 2002:a0d:e903:0:b0:56c:f32d:1753 with SMTP id s3-20020a0de903000000b0056cf32d1753mr17204913ywe.44.1692918995016;
        Thu, 24 Aug 2023 16:16:35 -0700 (PDT)
Received: from [192.168.0.16] (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id eo9-20020a05622a544900b004054b435f8csm151322qtb.65.2023.08.24.16.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 16:16:34 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
Date:   Thu, 24 Aug 2023 19:16:26 -0400
Subject: [PATCH 2/2] dt-bindings: gpio: pca95xx: document new tca9538 chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-tca9538-v1-2-ee3bf2065065@gmail.com>
References: <20230824-tca9538-v1-0-ee3bf2065065@gmail.com>
In-Reply-To: <20230824-tca9538-v1-0-ee3bf2065065@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Liam Beguin <liambeguin@gmail.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692918991; l=779;
 i=liambeguin@gmail.com; s=20230824; h=from:subject:message-id;
 bh=ehWUU34QqJnFQoLIq1OiPWMuGaqHSy1ALJlg/xzhrX0=;
 b=P2OKcdQBh8pK6Zf/svMplB5ghwmM/dtnSrCW4yhCyS+SorU0JCDXWwiE4qA7trxm1MX0nvtg1
 nrT9Skw7gy2CkI+Gr6XH6cvjNseR65dD+gi4NygGn7ZBMhMCWprXWr3
X-Developer-Key: i=liambeguin@gmail.com; a=ed25519;
 pk=x+XyGOzOACLmUQ7jTEZhMy+lL3K5nhtUH6Oxt+tHkUQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch added support for this chip. Add its name to the list
of allowed compatibles.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml b/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
index fa116148ee90..99febb8ea1b6 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
@@ -66,6 +66,7 @@ properties:
               - ti,tca6408
               - ti,tca6416
               - ti,tca6424
+              - ti,tca9538
               - ti,tca9539
               - ti,tca9554
 

-- 
2.39.0

