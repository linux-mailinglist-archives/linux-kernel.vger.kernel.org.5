Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015557887AE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbjHYMli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243326AbjHYMlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:41:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD0C1BC9;
        Fri, 25 Aug 2023 05:41:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bdb7b0c8afso7031785ad.3;
        Fri, 25 Aug 2023 05:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692967281; x=1693572081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gXAf/hSFvMeedA7BD7l7YHpWhJ5cz9EkE5Wd98sTmLs=;
        b=nb2W4Tk0l7WHfarOZ4/Y6ZrQeEOH7J4jyA2WdiWorO7w1ttxpr4LuvF8fVd4FedKdG
         doQwntQ9oNKGvvzXUKNXcECivn1b6GNGcrpMJ3jmlqcAwj5jyOTo4NZXb/QSLA+4/cYT
         1+AGLzYB9lLdHE3sqWRmNgOa2fEnzawIJ2kj/+5NgRva3zlqq3B2uUCNY9sdOPSBWy2j
         s55GLCOgYloDj9VZvSA7XuekR0fHw7jlGn47goxKfVUy+5DNxQceSzZFooABal9c5OJG
         AQg/clG9xJOVyBGjkTwXSoBC0x2OPh9XoYZk5425nEZFgHmfl8Fdxvlf2FynWt34jOei
         Jbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692967281; x=1693572081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXAf/hSFvMeedA7BD7l7YHpWhJ5cz9EkE5Wd98sTmLs=;
        b=iqaW8VFs3iN1Hhaz7gim6QvKxES9j/b/nOY4ByZzD/cl1M97BVH8ZjJuJwrGbSjR09
         HEHNGLpSbgX5MrbhK8L74jTkSnp1VZQbN/SVDPh+7IUi6xFIdf7m06VZpxVi5XDTOgeX
         l7pzNbZJ49LtCO3+lgxRm8yqZf/dFhV75hs+ZQVv4b4kokrlurTmsK9SMxaY/sIUMtYC
         z0/QMhsxoimoG7b9Ak8NZI7Xi/11wL2NLrCXRdGQWgmaYn8jOKH2qdxoOGQNPMAAz73x
         8epbhUXK+4Ln12MfdNeCAHKliO45awu3JmJ0UE9+z4IoOvOEYLz+NzDl9kdpyC03BEZ9
         DeAQ==
X-Gm-Message-State: AOJu0Yw1ydYsDvFwQuOPmPY22RrhQ3FW+8t3WMwjAmIp+OHLrdJxA4Tx
        Q0j8S9bck5IObsA7Za3uu93dr5no8Yj0+A==
X-Google-Smtp-Source: AGHT+IGDa/9m0tO41WDucSDWy1mkwn4NDBWB4Vz4pI/1/bmMdHFpEGuxqaZSGEKAe1qqyBiVA9iMOA==
X-Received: by 2002:a17:903:110d:b0:1bb:d59d:8c57 with SMTP id n13-20020a170903110d00b001bbd59d8c57mr18706021plh.18.1692967281161;
        Fri, 25 Aug 2023 05:41:21 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id s18-20020a17090330d200b001bbd1562e75sm1599570plc.55.2023.08.25.05.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 05:41:20 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH] dt-bindings: mips: loongson: Add LS1B demo board
Date:   Fri, 25 Aug 2023 20:41:15 +0800
Message-Id: <20230825124115.1177577-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Add compatible for LS1B demo board.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 Documentation/devicetree/bindings/mips/loongson/devices.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mips/loongson/devices.yaml b/Documentation/devicetree/bindings/mips/loongson/devices.yaml
index 099e40e1482d..8736eb9fe224 100644
--- a/Documentation/devicetree/bindings/mips/loongson/devices.yaml
+++ b/Documentation/devicetree/bindings/mips/loongson/devices.yaml
@@ -40,6 +40,7 @@ properties:
       - description: LS1B based boards
         items:
           - enum:
+              - loongson,ls1b-demo
               - loongson,lsgz-1b-dev
           - const: loongson,ls1b
 

base-commit: f11a9967413281b49690d864795e7c5f8f8e4fda
-- 
2.39.2

