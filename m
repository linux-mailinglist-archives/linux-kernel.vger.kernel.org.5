Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9043C7B127C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjI1GOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjI1GOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:14:12 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4450810CB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:14:09 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3515694c6d0so15006655ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695881648; x=1696486448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36mJhajWQppw1r4vewDK4hFKpILxPms9Bh84cWTmNnE=;
        b=ikRSD+/OWPk7RQvpvUrceP7VG6v7OaqlVtxKRa6zIXoomEzdVGkvOYJSzleGEfDwjf
         rTEK/fVQVAbJOMj5MjwcK5nUowVfo11fWhpe2fsgRbpZbFuoZ/pB3y2QIW6e8IywsjAP
         Qz7vaESBndPa0ODpdblBcJ+/L4ddblAa8vyAViN+QUIsb8bHGIkD0KLO8HxD2Y5Ybly/
         AivIkgfzkI1Ro+JhCBZPtO5v1Eyf6l5pbyF1NaLIQJuR3bpU0cUVL6Mgqa09JdhICkpu
         u07a5nFF8a9mijV0zkSO2PWBxzS0qGUV2CdiH0MZPQooL35xLNZ2tXFSMWmpsLBjoCy/
         kchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695881648; x=1696486448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36mJhajWQppw1r4vewDK4hFKpILxPms9Bh84cWTmNnE=;
        b=U3ZAJA9rROfBp3W9X1laFJDE57Pr5gYOPM+ep9jj5RvenXnRwA7fR457QHGhqyLocf
         IIRaAV0JKwPLcvVaWzJjs5d2/J8lzuMkiGsOwAu2rmgUnt01wx/qW9xJAtTivNRfjnSN
         AU7hA6OtQp27bZJPOzGH5qI/fd+3lNAQfotfRGL2G8VvzuRdqeoFXuExWL1YYEHVQmid
         Vcnl8hK/a6mlIwvboZBtyezMTwiaJ2xVgr4pMnaT70yFbGXL8tNC80HCgBKWte0JM9S+
         zNUXAUODGmJr7Shc3AmkcejE36j/yhLPmAJUZS+0Wex0qLJNBwBHGI/Eufy+8FBftHd4
         mBTg==
X-Gm-Message-State: AOJu0Yx/F6ljA/dKs0pZKHPkASks5X8gXpGvfjMADAc/ZHercNR3a+qy
        QOK/C/I2b8AQ+by3rvp7TkVv9w==
X-Google-Smtp-Source: AGHT+IFbbvM94Q+//vWERN5yhwqSCQt38ZTPmzZg3tJJpWfKRlW+a3F51L0ogbuW46vtUY7trJEjqg==
X-Received: by 2002:a05:6e02:1705:b0:351:5322:b820 with SMTP id u5-20020a056e02170500b003515322b820mr321488ill.11.1695881648326;
        Wed, 27 Sep 2023 23:14:08 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id x6-20020a92d306000000b003506f457d70sm4774467ila.63.2023.09.27.23.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 23:14:07 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v9 14/15] RISC-V: Select APLIC and IMSIC drivers
Date:   Thu, 28 Sep 2023 11:42:06 +0530
Message-Id: <20230928061207.1841513-15-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928061207.1841513-1-apatel@ventanamicro.com>
References: <20230928061207.1841513-1-apatel@ventanamicro.com>
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

The QEMU virt machine supports AIA emulation and we also have
quite a few RISC-V platforms with AIA support under development
so let us select APLIC and IMSIC drivers for all RISC-V platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d607ab0f7c6d..45c660f1219d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -153,6 +153,8 @@ config RISCV
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_MSI if PCI
 	select RISCV_ALTERNATIVE if !XIP_KERNEL
+	select RISCV_APLIC
+	select RISCV_IMSIC
 	select RISCV_INTC
 	select RISCV_TIMER if RISCV_SBI
 	select SIFIVE_PLIC
-- 
2.34.1

