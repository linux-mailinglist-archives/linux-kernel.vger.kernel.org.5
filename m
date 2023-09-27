Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883727AFE64
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjI0I3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjI0I23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:28:29 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE19192;
        Wed, 27 Sep 2023 01:28:28 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3af57ce3d11so475546b6e.1;
        Wed, 27 Sep 2023 01:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695803308; x=1696408108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZTi49m1tRqik4s4OIHpvu+DZ0pGT5ycjrh8hjwTA/U=;
        b=EtBwKVQMdY6BlYCL/Yt43p6yAbcBvo/VUwU2XoptTJpks4Nadi4Zr144Ji0C2IW2vV
         8ZXifBqDbd0bINgnlismcaWSTlLVsaxMlhRw7cVIrO0OJvyx402jbPpKiLfesqqMSZpk
         HFzA0tsaJEKFK1sSUIr07M5LNGuaELueuO178HWAkEt7usqVE/3u9+QHFKZLg1cTRjJE
         NNac6ovyDlngPOVN5IizgEQyS+0OwGDe04QqNJ4FMlVbLzAUbGCeoilkSBKY4qlSfkLn
         LghjKVDKVEMfEXxd971sG8Id2eU6w1LqouORHijmNkX9jE6IRMZk8hvVX1LoAc0mgkWY
         exNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695803308; x=1696408108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZTi49m1tRqik4s4OIHpvu+DZ0pGT5ycjrh8hjwTA/U=;
        b=K9xfuuLd4WWSo+EK3IIJWxj0YC2DHtmk+/Y1CtmrOv/jPOsXC12LPQ30jtce4rYobI
         0Xp5AhdHT3bwM5le2quXiT145EdFubG2M7wY5JiQZnn8TsVhxm+Nhyn522A3Jqbkal8/
         f7JwYcZj4eHkkXzff6yB8b73w0D4yxORjj0qVmKpOUhshOEBsFE3YV59XUHROxGdnjks
         aek4azmEt3/+1aP2WK8KwKcWjZ8RcJahtHMTiy+3VOQ7F7WSstMnfRmO8VMUn6WZXQP+
         pqh+Mo7PpiI0iS2YWweBdH9jhdBiAsv4kNzb9BhnUbJ73AMUsZZ0NfRfebFdNWJPhNp6
         H54g==
X-Gm-Message-State: AOJu0YyXfHTYu2t1Ph+Lb6zmZMJTfVMlo6pJZSH2gyVPf/KhXBYHTLqV
        tGmHpYuadQFL3P0LBdYns8g=
X-Google-Smtp-Source: AGHT+IFWJGplOWqOpM2IFjOdrFg6ThLvBAE2KJ+l0wbkxriQgN9+p9DSzrcWzlgqMBpiqFYn+mQEag==
X-Received: by 2002:a05:6871:549:b0:1d6:6083:63a3 with SMTP id t9-20020a056871054900b001d6608363a3mr1630424oal.37.1695803308124;
        Wed, 27 Sep 2023 01:28:28 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id eg46-20020a05687098ae00b001dd17c5356dsm1359148oab.11.2023.09.27.01.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 01:28:27 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com,
        unicorn_wang@outlook.com
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Chen Wang <wangchen20@iscas.ac.cn>
Subject: [PATCH v3 01/11] riscv: Add SOPHGO SOC family Kconfig support
Date:   Wed, 27 Sep 2023 16:28:22 +0800
Message-Id: <bfa07dce9eb268b312bd64059773acf055727f17.1695800389.git.unicornxw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695800389.git.unicornxw@gmail.com>
References: <cover.1695800389.git.unicornxw@gmail.com>
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

The first SoC in the SOPHGO series is SG2042, which contains 64 RISC-V
cores.

Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Chao Wei <chao.wei@sophgo.com>
Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
Signed-off-by: Chen Wang <unicornxw@gmail.com>
---
 arch/riscv/Kconfig.socs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 6833d01e2e70..d4df7b5d0f16 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -22,6 +22,11 @@ config SOC_SIFIVE
 	help
 	  This enables support for SiFive SoC platform hardware.
 
+config ARCH_SOPHGO
+	bool "Sophgo SoCs"
+	help
+	  This enables support for Sophgo SoC platform hardware.
+
 config ARCH_STARFIVE
 	def_bool SOC_STARFIVE
 
-- 
2.25.1

