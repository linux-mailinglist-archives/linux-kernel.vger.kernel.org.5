Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FA17A16FA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjIOHLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjIOHLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:11:04 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D351E6;
        Fri, 15 Sep 2023 00:10:58 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c0d5b16aacso15379685ad.1;
        Fri, 15 Sep 2023 00:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694761857; x=1695366657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qQmq9ukAgL6NI2NMuw97RcY8w9KjAc8eVRWmfFz2hDw=;
        b=GFJA32dUb50Rg2amSdiZfcKCZOnCPOaJ0YgC9xgY6xJuvzknKxj+S2ntfi2z+PZk9I
         dkc8qwnPbIezfUkM7XXEi7NNzGUw3xJZJou7jfRB0oro6Ec85MGFD2n7VulnsfzRzJeo
         cOh9/AErcOChRVKRmz3Zz+xpzDxz1YLMQMWiXnVQpVYzHmlhKhp5beQVZwOCiagydmSK
         +UIsqMshMThSg5gFaDM7E5cPXa4wfzz+zCvzBhL9OiF2EU4wLueTJH4Uikle+tdALZzz
         sDHGdD/ZoCGbJ+xFyC3P+HpwI3VC/vivw6ay3WeaFLsbPeD8+WMyxmVjatbhy59Ct8g5
         Ez7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694761857; x=1695366657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQmq9ukAgL6NI2NMuw97RcY8w9KjAc8eVRWmfFz2hDw=;
        b=aUYPlGsebg1JEfwXw636LaEufRB4u873b9Euw5eLaIdiVE7OOlYFMqyonz37fExphn
         WCX/XHzAmUT4/KcVu2IklQoEnB0Eif7UuYDwpMKgvLovnF8FpHl869dVZhot8mPMzFjT
         Bb4FiXG3pfmUtN2A46O5KbpGefn+r8+ls3hS+IKLrdLL0Jee+uSwWQbhvs1AfDvquK8w
         TZQyDO6oj3Fo982mSG2uZ214kYrq8TCh+p698CGbK7sYgyXQctsQJDNZxU2F6W4QBdA9
         Nt7G8nRTj4sSAMjgc4PDV6FlShG3hdyHe7d0F+32Ehoua+sOo+VAf7JM1DlG5Cl8WY67
         OW8Q==
X-Gm-Message-State: AOJu0YwRcN3V1OHeEjDqjiB3AQ9xpqONUZMu0R6IyZjpMVB7EefBQTeQ
        IJiekb2qT/El0xDoy/pQT+c=
X-Google-Smtp-Source: AGHT+IF3DJKc1rTypHdvtMUd/6ki1y/rSqs2TXtFWiq1JzuCqZ1o5VF+3dtVHRWFnjxmHBgSmPXI5Q==
X-Received: by 2002:a17:902:c941:b0:1c3:ea2a:9058 with SMTP id i1-20020a170902c94100b001c3ea2a9058mr786561pla.65.1694761857415;
        Fri, 15 Sep 2023 00:10:57 -0700 (PDT)
Received: from localhost.localdomain ([222.95.63.58])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902eccf00b001c0c79b386esm2749955plh.95.2023.09.15.00.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 00:10:57 -0700 (PDT)
From:   Wang Chen <unicornxw@gmail.com>
X-Google-Original-From: Wang Chen <wangchen20@iscas.ac.cn>
To:     linux-riscv@lists.infradead.org, conor@kernel.org,
        aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Wang Chen <wangchen20@iscas.ac.cn>
Subject: [PATCH 01/12] riscv: Add SOPHGO SOC family Kconfig support
Date:   Fri, 15 Sep 2023 15:10:05 +0800
Message-Id: <20230915071005.117575-1-wangchen20@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
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

From: "xiaoguang.xing" <xiaoguang.xing@sophgo.com>

The first SoC in the SOPHGO series is SG2042, which contains 64 RISC-V
cores.

Signed-off-by: xiaoguang.xing <xiaoguang.xing@sophgo.com>
Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>
---
 arch/riscv/Kconfig.socs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 6833d01e2e70..fc7b5e6c7def 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -110,4 +110,14 @@ config SOC_CANAAN_K210_DTB_SOURCE
 
 endif # ARCH_CANAAN
 
+config ARCH_SOPHGO
+	bool "Sophgo SoCs"
+	select SIFIVE_PLIC
+	help
+	  This enables support for Sophgo SoC platform hardware.
+	  SOPHGO is committed to become a provider of universal
+	  computing power, focusing on the development and
+	  promotion of computing power products such as AI and
+	  RISC-V CPU.
+
 endmenu # "SoC selection"
-- 
2.25.1

