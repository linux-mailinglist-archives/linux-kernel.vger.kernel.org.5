Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BD37756B6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjHIJvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHIJvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:51:22 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EADE1986;
        Wed,  9 Aug 2023 02:51:22 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-687ca37628eso2014514b3a.1;
        Wed, 09 Aug 2023 02:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691574682; x=1692179482;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dMmvRAr3WJDJPERsTgA3XXQnHXs/O0R8IKemxQ6u/U8=;
        b=kCIHP/P//featsTbOj5vRMc05VJ+kesXTUsIbe4/v6sNPkqDMH63zPgGmpUU1iBURF
         XsNGeI2Rn4RfXLC/fPIjzPsvswPIdDw1B6a8QpAfJCaJFnzzQBDQ6/Bq1vwlcKCa7Nt3
         p6JTpwXtCm+O9YdYxRaJjBc4nQ7yk8vJp8BjaqTntF71fBOFz1rDd+L6K+LFQXFQm/47
         cJZlwrt3+AgNoXb3HKblRGs4sDZ3WJ8wgvHcF9yaKCwexhwxt5vqOYNrhOIfqlYHMvDB
         RlFWHZbc3G176ScMExI8MwqOyi4hELE/BzVJsc51x44B6ZMRPykzJaoN+N5WowQ71N22
         xw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691574682; x=1692179482;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMmvRAr3WJDJPERsTgA3XXQnHXs/O0R8IKemxQ6u/U8=;
        b=OznQfRL9dJKccJQ6gtQjWkLRxxbmZGo6TwDn9p3dNTGqKochhUbFHeYIKIfPtTteit
         QSG68lpATC0Xmp8M+hKhDZOtKCTFOaQAXOSUG40aHP3lIxlV6arwAW//9sXKc3N6sVOx
         RtQ1VQDYquEu77DW9KVQhXJ+nl7/0dXM1kxnZ9MqQG++6ds9Joai+5OZVjz31KXBMEZ0
         rHOddp/NOprN5mxQVByMIr936W/BxYWFOQZC+dzqHNFWvz8YuNaHaZ6oaWNPEpJF2SB/
         11SLllpNfcMZzAfgE90fNSwapFsQb/JAjpONAklluyvv+ReZ9eAOSJ4Y9/534FhXxLSi
         obVA==
X-Gm-Message-State: AOJu0YyJIxAEdqinNHxt2TFVttILQgwj0uWQ++hPtz+/eMC9ZPhOYI1P
        frMld9RqMNbGloyIMC0BtBg=
X-Google-Smtp-Source: AGHT+IFBps0WlArKN0bzaJSa2FqF89rO4p8pLeDZrE6fYEiZG2hIGrqyLrrFGjDdeegcOUWsdt1HyQ==
X-Received: by 2002:a05:6a20:4ce:b0:132:8620:8d21 with SMTP id 14-20020a056a2004ce00b0013286208d21mr1906030pzd.58.1691574681786;
        Wed, 09 Aug 2023 02:51:21 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id j21-20020a62b615000000b00687375d9135sm9493822pff.4.2023.08.09.02.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 02:51:21 -0700 (PDT)
From:   Mia Lin <mimi05633@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
        KFLIN@nuvoton.com, mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mia Lin <mimi05633@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: rtc: nuvoton: Add DT compatible
Date:   Wed,  9 Aug 2023 17:51:11 +0800
Message-Id: <20230809095112.2836-2-mimi05633@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230809095112.2836-1-mimi05633@gmail.com>
References: <20230809095112.2836-1-mimi05633@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT compatible "nuvoton,nct3015y" to select

Signed-off-by: Mia Lin <mimi05633@gmail.com>
---
 Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml b/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
index 4f9b5604acd9..67fc60fd395c 100644
--- a/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
+++ b/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
@@ -15,7 +15,9 @@ maintainers:
 
 properties:
   compatible:
-    const: nuvoton,nct3018y
+    enum:
+      - nuvoton,nct3018y
+      - nuvoton,nct3015y
 
   reg:
     maxItems: 1
-- 
2.17.1

