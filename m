Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065E476F5F7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 01:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjHCXEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 19:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjHCXEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 19:04:07 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361D81FED;
        Thu,  3 Aug 2023 16:03:33 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so12921375ad.1;
        Thu, 03 Aug 2023 16:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691103812; x=1691708612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqQhR/5Zg/iUnJ10XmwJefyLz1QkYmSYn+GFkwwlYbc=;
        b=fhxBpCO3SQTUHyytwbtWYj1SDwLbSUkacsfS7IFhv4GS4d24YEZB54L6kSZMpRxSU4
         SOHzyVUgKVmC6DSkb9016yUKAR8ca5RVgyUjvi0UPlUTBty3e+QmQapVf1VV5ZDZSdQH
         dKtRBX+lK71xW4/lL/sIVoJMs/JOgz2N2NVQ+3P9FN0sP6FFVvyrOrVTqh4e5Ouwh6H2
         6eyNtqjjqNZ7KJULOJZFGkZnEf3K8t7fOVIFWlDkPti1GXcTjuyzQi/Cb9yzPlJ69Yjn
         R+1Oi50z3ZUbrJLX2U7BZ3PIPJ5p7k6cev1ucTu5udSm5TNgWdP8/BvvrL7fsEsHyRJX
         uLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691103812; x=1691708612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqQhR/5Zg/iUnJ10XmwJefyLz1QkYmSYn+GFkwwlYbc=;
        b=EWa08o2zIdIQEJfMf//hs93ty6tZEjpCcwvCegoXaDbtP8GU/wfWod21ZRBhcbIsya
         Y/HUbY9QUR9F21HLO4dnNtCohTJBGYJji9+tiXPBwuXrcKw2gO9DlMbn42MixIATUvyP
         k0g+i/a2B2swVvHYC49yYARqiWs1/62ocFtKfjphBrMKFCDuL/ALg1jwseoKmthpVu/l
         DQT4W+RhEkflrk3WDzLMIWmuYclmAwXo7YU8LqW+ULPz6tseHskDzaPlYfa9Pt+siQCN
         YKkVlTxhJb2m4KxmnY3e3GMvWkUj1LtGAQ0ovQfesUzKw2l5KlALKqpRT/vQZjkSlnul
         /BEw==
X-Gm-Message-State: AOJu0YzkHihGXRyHghfj8XCIs6myrcrghwMTpRs1SnavfvI9yZMPdeFk
        ZslvrOXupLmzUQv2rrow+Ig=
X-Google-Smtp-Source: AGHT+IH6qzLAEk0DNXUGSi4Ov1sMseW89CXGNENYfRxBDHDuYglyYwG/GmeBL1qR9REfd6DQoc6BZg==
X-Received: by 2002:a17:902:e744:b0:1bb:bbd4:aadf with SMTP id p4-20020a170902e74400b001bbbbd4aadfmr122041plf.61.1691103812666;
        Thu, 03 Aug 2023 16:03:32 -0700 (PDT)
Received: from taoren-fedora-PC23YAB4.thefacebook.com ([2620:10d:c090:500::5:e60a])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090322c700b001bbb598b8bbsm372349plg.41.2023.08.03.16.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 16:03:32 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        taoren@meta.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 1/3] ARM: dts: aspeed: Update spi alias in Facebook AST2500 Common dtsi
Date:   Thu,  3 Aug 2023 16:03:22 -0700
Message-Id: <20230803230324.731268-2-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803230324.731268-1-rentao.bupt@gmail.com>
References: <20230803230324.731268-1-rentao.bupt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Set FMC controller to "spi0" in ast2500-facebook-netbmc-common.dtsi so
the spi bus is consistent with the flash labels defined in flash layout.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed/ast2500-facebook-netbmc-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/ast2500-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/aspeed/ast2500-facebook-netbmc-common.dtsi
index c0c43b8644ee..7f1ae3f4df9d 100644
--- a/arch/arm/boot/dts/aspeed/ast2500-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/aspeed/ast2500-facebook-netbmc-common.dtsi
@@ -4,6 +4,10 @@
 #include "aspeed-g5.dtsi"
 
 / {
+	aliases {
+		spi0 = &fmc;
+	};
+
 	memory@80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
-- 
2.40.1

