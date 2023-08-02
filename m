Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B97A76D0F2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbjHBPD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjHBPC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:02:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ADF4208
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 08:02:07 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bb2468257fso42020975ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 08:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690988527; x=1691593327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzjEf8gdmshIPz1UCPWBPDv9bSpwWIxt6/009doAlF0=;
        b=T3iwGETj4wk8BsrroMxNokL4un5cyLJxMkS0Yghktf+HS8BezQltxIZ0BfQvA68mka
         llJH8OFFMgrFDx5TDUnTJzKxZ4HrQdZ6Fr9y/2oNs6mf/6LUgN2jyb11T/B6TWF/D/wu
         GupSTBzd5zCUcj+LpHiXgl/WuEbfWQwdTGDAhy+tPxzpFXqEdCBS/17WhpZ0YDJPvEUP
         oJfqbUH8YCSSxXHPtW7akxZYPB186+u3GCnSB+A1zLaIccK4F+lDLKmOw8Xir51qJnS5
         QDO1I9r1Te3WvQNBkYTOQebaDyhRtykY7Ge9oJ5+kHlQagRLSTG4+v3fBLmg3zwhl0pz
         wtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690988527; x=1691593327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzjEf8gdmshIPz1UCPWBPDv9bSpwWIxt6/009doAlF0=;
        b=kApPn4L0VgEtjyRs9FTH1EW2UIdeqArpBJRNhDDVLN1uJ2NQZPa+BCeVXpBKL3KVup
         fSZiAlFyU7Ph+nn232NThIvahhC2+wwRphnz1+LFjRaus4DCGTF6iLSg7GUfS/+kZZX0
         rZwVYuf9WL5bwnNqV87R7TmdX0hitjDmwfD50ykdHLb0R82+04Hk/+K90+YgF3RXJqSY
         Ml70nT/M9cKeDeRj8HbD0hjuEDUqko8vw0UmQBsD2voaw7jxLGahImkBjhO80Lrpco8q
         xXXezF3/Mm1lzgW3tsp+LMwdYWb/UprQiZ2iwoy2YGTPng0BMIycQ0Syn1cgCumtoTxC
         UUMQ==
X-Gm-Message-State: ABy/qLbIBk7o1aYdjOgwIJueKXEjUTT/o+Vrc+7EGQdAYeiPUouDFzno
        q/HcSXsxWZaeMQtPAktKoy5vlA==
X-Google-Smtp-Source: APBJJlGNZTsOk79JzcpgWFDkaYvrxpw9ast6LoWe4ciQrJMbBZi7SOXmTU9v4q3t9h7VBETnKKPJiQ==
X-Received: by 2002:a17:902:8207:b0:1b8:b464:fa1d with SMTP id x7-20020a170902820700b001b8b464fa1dmr13027165pln.69.1690988526530;
        Wed, 02 Aug 2023 08:02:06 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709028d8b00b001bb99e188fcsm12503963plo.194.2023.08.02.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:02:05 -0700 (PDT)
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
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v7 15/15] MAINTAINERS: Add entry for RISC-V AIA drivers
Date:   Wed,  2 Aug 2023 20:30:18 +0530
Message-Id: <20230802150018.327079-16-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802150018.327079-1-apatel@ventanamicro.com>
References: <20230802150018.327079-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer for RISC-V AIA drivers including the
RISC-V INTC driver which supports both AIA and non-AIA platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 53b7ca804465..8e315aaa20bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18259,6 +18259,20 @@ S:	Maintained
 F:	drivers/mtd/nand/raw/r852.c
 F:	drivers/mtd/nand/raw/r852.h
 
+RISC-V AIA DRIVERS
+M:	Anup Patel <anup@brainfault.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
+F:	drivers/irqchip/irq-riscv-aplic-*.c
+F:	drivers/irqchip/irq-riscv-aplic-*.h
+F:	drivers/irqchip/irq-riscv-imsic-*.c
+F:	drivers/irqchip/irq-riscv-imsic-*.h
+F:	drivers/irqchip/irq-riscv-intc.c
+F:	include/linux/irqchip/riscv-aplic.h
+F:	include/linux/irqchip/riscv-imsic.h
+
 RISC-V ARCHITECTURE
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Palmer Dabbelt <palmer@dabbelt.com>
-- 
2.34.1

