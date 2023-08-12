Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF8477A0C2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjHLPMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjHLPMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:12:30 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E834E171B;
        Sat, 12 Aug 2023 08:12:32 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686f38692b3so2756662b3a.2;
        Sat, 12 Aug 2023 08:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691853152; x=1692457952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLKDp3T6ffay96ib2FA9KVmMuF8tytRGA1tsnDfcuNs=;
        b=jcGsstu8S3vEwBz5ePUklEY5prrQ2W3LObE9qaprsVYWf0Ur3o3lzEcNCVWFLiljp6
         atOLRLplDheA5GNNeQvYpZq6mAXQELTvDjfzHbbqJweBQZiajFGMtWFStUeqiTTz6YFs
         LyUGh0TIWdHapWZd97lMHdkAD66AoNQxyzA8pAkVh0psC/+gEy1aXtPvte99ManFdF/z
         dhBxV7FXeLYUMNhUAYx0R2bS4HZ4jA0PdNasgOCTkQCVpa6bq0a2HfxTneQb0bOfl3IK
         csDoL98bJkLqCgQhpu3WjnD9fRpCB21LmCNok8LOdBRRsh99dSvalYQQjI4eFQwD1K8Z
         HsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691853152; x=1692457952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLKDp3T6ffay96ib2FA9KVmMuF8tytRGA1tsnDfcuNs=;
        b=KaZMEz/I/wDyIXIly4v57WnvtUxVyIwlaYP2Gl+60g1V6RAjZyzY/asE7IOzfRzSx4
         xRnBTs/JhxjuOOlGn0KrQbB4bEJ+6A0/5jq84f/jFi6WDDvJYVEp0PItZqE/19Zm3gSq
         ANJ2yVEy3p6XEXMjISlMTVsGw9M2SY3prgxYIYgGKULHKrMa7nBJa8KvV3mzk9SpSC+i
         Ya0jWg9ncvsy636YiZyVPZXx2Aeq4mtGAgdS0P2MrdF/SHPMl9aXZvBrAKe8G+To/K4C
         hwlI+ARb96fixSL6qG/LrXj7hfDmhJLvsWUkE4bOdWvLS2Aorn+u+EsRPB3tyohkvFWO
         H7Aw==
X-Gm-Message-State: AOJu0YxzyvugMeOalyejKRViJhMCCyxmSO/vcEcnBq3DLUR/wOV4ToQx
        faxXixoSWIvoOcZns9FSWZrYeTFS1R49HXkh
X-Google-Smtp-Source: AGHT+IHY9afC8zBSv4tsGszq25Eb9wETHJeaXyDIT/2sfKfCfDnWL80tgUYa1XpBgikYc+gDeetNWw==
X-Received: by 2002:a17:903:32cd:b0:1bc:2d43:c747 with SMTP id i13-20020a17090332cd00b001bc2d43c747mr6830712plr.38.1691853152056;
        Sat, 12 Aug 2023 08:12:32 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id 17-20020a17090a195100b0026b41363887sm1040927pjh.27.2023.08.12.08.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 08:12:31 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 5/5] MAINTAINERS: Add entry for Loongson-1 DWMAC
Date:   Sat, 12 Aug 2023 23:11:35 +0800
Message-Id: <20230812151135.1028780-6-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230812151135.1028780-1-keguang.zhang@gmail.com>
References: <20230812151135.1028780-1-keguang.zhang@gmail.com>
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

Update MAINTAINERS to add Loongson-1 DWMAC entry.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 02a3192195af..3f47f2a43b41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14309,9 +14309,11 @@ MIPS/LOONGSON1 ARCHITECTURE
 M:	Keguang Zhang <keguang.zhang@gmail.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/*/loongson,ls1x-*.yaml
 F:	arch/mips/include/asm/mach-loongson32/
 F:	arch/mips/loongson32/
 F:	drivers/*/*loongson1*
+F:	drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
 
 MIPS/LOONGSON2EF ARCHITECTURE
 M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
-- 
2.39.2

