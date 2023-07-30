Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B0976865C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 18:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjG3QPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 12:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjG3QPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 12:15:38 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A4C1707
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 09:15:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso5951451e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 09:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690733735; x=1691338535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5recWV/7FkYLd6mSLma/a+qiyOjQ21TUrbudJOgS8qc=;
        b=qiWLXEFScZ4SoKHXVTxpgpbHkWDjL+tisbcTJaSpXhTocAt44CSAXerjypvDD3HSrY
         l3kz/iV5KWYJAU7T/3opg4y+wjaspRU7rzL4d9PBPkSuq/QTda4pFhjSajwaUbavcbQm
         F78lkiIRjUv83fstrJAWpSEFg6/b5FtsuDD4m75dtLo/PLj4Wulq9RerY7di6pAzzd9d
         zrgnSrcFvyL0yCyaaM9o79wwv5xz7EUaluus8aXPnCxcW5MKxfCfGSSA0eZ7kGyz5Abt
         vnE65goemgmtqXqicmU+vqNo4PSoN7TEY8fxVHBGz9E014wYqV+KpJPOLu2JP5/QGWH5
         oa5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690733735; x=1691338535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5recWV/7FkYLd6mSLma/a+qiyOjQ21TUrbudJOgS8qc=;
        b=VA0i2W3iOSA+u+RUlKb1NOvIWnzuK1Q6AamacmaX5zrHiG9/uIBPOJ/c8UoEPRf5Ta
         WZyns9W7829gG2kGrKsXa/VvXpuwqB8nSj5IRCuO3tojUuWVpB6/diGyGwrRxN1yiEw7
         dZpVmqbV5rH4WTihI22P7E8Sh3lTvsMTiTJ5eNSu0+3xecE/B4OkexSD8r+sURH2cu7o
         PRugOvSQJzbPCqzAXTQX5w65zYVHsofZi9cVNJlgknTtwg8F0MGfskXju+HgDIfV5SEs
         HjD2FDru7P6OckQlIHHCiDSKCQEKCYfeI14rZoKG83WaSGLVUrK+Myu1QHiPRkfKw3dS
         tOxQ==
X-Gm-Message-State: ABy/qLayMX4+NnTRiGYbipE19d8TiKEf6unaBCrSnnTsw/q+vTF6VIPx
        IOgjFjeQ0Q3X0mdcRqR4LP8wRJMXZDq4fQ==
X-Google-Smtp-Source: APBJJlFrAfq3M891FFozfdDMtZcr99WH7W3j+1rV8ozSE7iNm82woz2A1hZqa5krNqzlpbpwXmU9BA==
X-Received: by 2002:a19:7619:0:b0:4f3:d682:7b1c with SMTP id c25-20020a197619000000b004f3d6827b1cmr4332745lff.45.1690733735043;
        Sun, 30 Jul 2023 09:15:35 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id j9-20020aa7ca49000000b0051873c201a0sm4194664edt.26.2023.07.30.09.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 09:15:34 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcaov@gmail.com>
Subject: [PATCH] ARM: optprobes: fix typo "consitional"
Date:   Sun, 30 Jul 2023 18:13:46 +0200
Message-Id: <20230730161346.64066-1-namcaov@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Fix "consitional" to be "conditional".

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 arch/arm/probes/kprobes/opt-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
index 7f65048380ca..bdd7264471db 100644
--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -307,7 +307,7 @@ void __kprobes arch_optimize_kprobes(struct list_head *oplist)
 
 		/*
 		 * Make it a conditional branch if replaced insn
-		 * is consitional
+		 * is conditional
 		 */
 		insn = (__mem_to_opcode_arm(
 			  op->optinsn.copied_insn[0]) & 0xf0000000) |
-- 
2.34.1

