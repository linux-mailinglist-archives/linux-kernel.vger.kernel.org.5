Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867F575740A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjGRG0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjGRG0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:26:46 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296DC126;
        Mon, 17 Jul 2023 23:26:46 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3487d75e4c5so14236185ab.0;
        Mon, 17 Jul 2023 23:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689661605; x=1692253605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t7CLNl341a6qbr1/+SqD2wU8H0rNBWIA4UoKO2oRkIk=;
        b=Wl56MJJjwI2mGTf3k92EgT//sXuLO8UWap6B6DnjCHdiDGbk/T/t0FOA41rH9qKBIo
         hgFX+twXDXU+UPv3h+XZXDGthvIGgMAnjT01HXajCc32OR9aswCnZFxQdvURhkO7KvQI
         mZY/lCeQASJ+ztY7uVqrIJtC7qnmx1CaHZdwnNNN5/yvmDsHjMoXckiNnA/sj9sV6ycl
         d2iFmS62V8mLQV55duuSBNM7Q0ImbHFEBePwGLiUDyGlB7jcFmp+gu5m92wHG7W+yuh8
         2/BESdcUKDN9R5hinjFlpGgVEreT4Vi1D47ygIAzhsyh6AfnOG5s/zZ+xkdSzcbrzS1r
         fwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689661605; x=1692253605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7CLNl341a6qbr1/+SqD2wU8H0rNBWIA4UoKO2oRkIk=;
        b=QN0Wg4F8w2PL3haZhC8u/3qJ6y1CoxOv9K6lnWghKknJG4U/X7ldrBhzAQHcz/36KQ
         gVk1cpD9g7nGl8+fv+CsCDUzjnWkc6BGlHu/49Zf2UQf8+T4uwe3FQNrnxaaLb35sTM3
         OKid76wD/ub3M2xmCB90UtJsbCM7+uh8SNwCr4vpXVOp2ez07W4ogbSMF88HsF5u9VxK
         tYeLXIvXNBCjvvF/mdHKH+ggevG8nt34VDRWIDu04MRcr9HUmpJFPcZxK4rcPH+FWlOC
         BzXCnLNWYPMslghz7nREqEsNBoE4zwoz00kMD0nUwiuEzy7wwkYYf09K2tby4lelf4gH
         26Bg==
X-Gm-Message-State: ABy/qLanL1nD2zkziW6kzOVxr1+xHh8LwhgLw8MpVFCXOWd0fWkaXAAf
        TdQMHWPMDbgKMTGt0vpVhi4=
X-Google-Smtp-Source: APBJJlFZCsWQza7bUATlQ8O/mkdlO1GlCu58cJOBj4zgREHIvmUcerlXmnjVsM2gL+P6vDa3yNGz3w==
X-Received: by 2002:a92:cdaa:0:b0:341:f920:4483 with SMTP id g10-20020a92cdaa000000b00341f9204483mr2038959ild.9.1689661605424;
        Mon, 17 Jul 2023 23:26:45 -0700 (PDT)
Received: from localhost.localdomain (211-20-114-70.hinet-ip.hinet.net. [211.20.114.70])
        by smtp.gmail.com with ESMTPSA id n16-20020a92d9d0000000b00345d154ce58sm467680ilq.12.2023.07.17.23.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 23:26:44 -0700 (PDT)
From:   Dylan Hung <kobedylan@gmail.com>
X-Google-Original-From: Dylan Hung <dylan_hung@aspeedtech.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     BMC-SW@aspeedtech.com, kobedylan@gmail.com,
        Dylan Hung <dylan_hung@aspeedtech.com>
Subject: [PATCH v3] dt-bindings: clock: ast2600: Add I3C and MAC reset definitions
Date:   Tue, 18 Jul 2023 14:26:16 +0800
Message-Id: <20230718062616.2822339-1-dylan_hung@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
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

Add reset definitions of AST2600 I3C and MAC controllers. In the case of
the I3C reset, since there is no reset-line hardware available for
`ASPEED_RESET_I3C_DMA`, a new macro `ASPEED_RESET_I3C` with the same ID
is introduced to provide a more accurate representation of the hardware.
The old macro `ASPEED_RESET_I3C_DMA` is kept to provide backward
compatibility.

Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
---
changes in v2:
- Added back ASPEED_RESET_I3C_DMA for backward compatibility
- link to v1: https://lore.kernel.org/all/20230621094545.707-1-dylan_hung@aspeedtech.com/

changes in v3:
- Added an explaination for adding a duplicate ID in the commit message
- Link to v2: https://lore.kernel.org/all/20230717075123.1597977-1-dylan_hung@aspeedtech.com/

 include/dt-bindings/clock/ast2600-clock.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
index e149eee61588..712782177c90 100644
--- a/include/dt-bindings/clock/ast2600-clock.h
+++ b/include/dt-bindings/clock/ast2600-clock.h
@@ -90,7 +90,19 @@
 /* Only list resets here that are not part of a clock gate + reset pair */
 #define ASPEED_RESET_ADC		55
 #define ASPEED_RESET_JTAG_MASTER2	54
+
+#define ASPEED_RESET_MAC4		53
+#define ASPEED_RESET_MAC3		52
+
+#define ASPEED_RESET_I3C5		45
+#define ASPEED_RESET_I3C4		44
+#define ASPEED_RESET_I3C3		43
+#define ASPEED_RESET_I3C2		42
+#define ASPEED_RESET_I3C1		41
+#define ASPEED_RESET_I3C0		40
+#define ASPEED_RESET_I3C		39
 #define ASPEED_RESET_I3C_DMA		39
+
 #define ASPEED_RESET_PWM		37
 #define ASPEED_RESET_PECI		36
 #define ASPEED_RESET_MII		35
-- 
2.25.1

