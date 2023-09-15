Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A4D7A175D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjIOH1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjIOH1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:27:44 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3DF30F2;
        Fri, 15 Sep 2023 00:27:05 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso14319265ad.1;
        Fri, 15 Sep 2023 00:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694762824; x=1695367624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JjZ5p6sECHH5hqVMsjk72FLLIZN3XyOMXABaFLbFiJ8=;
        b=KlA2Wq1cQiPQK/VawbjFWMVbeztX019C3U8/29+wnlBvtYHM/Xspours/cRhkSI9Vg
         Sh1p/NH3G9+AULYm/QP1U9riU9WvldxY7IXpJ2vSVcudTzZd2RG6mmKb1WLOHIS7GRGU
         FtT1c5E3O0ltuQTvxX7xCw4MVfkDZBn0qTdTrt3tIN5QGAsB0mFPOdBhu+pfl/0CCFRk
         PN7kMFXy4BTAN1FwiPs8aXkzPd8AEGpvvrb452QnnS6qXXYQ5K6q0hTRPTL4+X8Qg4Kx
         ncelM205Y/Pl4cpDwhxVhyYMpAD2tEZjQ5HZ1F8NOsL82R23S2rG3Xb+a6PQyd7NzV+p
         YZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694762824; x=1695367624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JjZ5p6sECHH5hqVMsjk72FLLIZN3XyOMXABaFLbFiJ8=;
        b=g5bO0m7NVH6+6OEvJJoTTMbWrWSsxOhhN/XgGEZCkWn9zBX8n38uc0B2G07YmJjURr
         05SJ6gecWuyXyvkTJnCHhpI3M2AgPObU2EZ4Dls5YJTcjS9TdREIlnB2fDovyzZDfSIu
         M6t4HcyADu463c4fYvBBpGtTbBqgjFjW9y0XwzG8MLELk6qW9EvQKvGmBpJPGgCe7UcA
         krdqhZ2Tre2bJRZtLP8UmxkRgHhrk2387AX0fzhxtYse0nSDMiqJAmSJ+I16+OwV6sZM
         cKCr1WX0C0p6FKeaShSlaKY5ARkroXjqyTeFWmqrZXY9gXQVT7pJQ/vWfw+qEH4PguMq
         LzHA==
X-Gm-Message-State: AOJu0YxaQ+EainCI3czUveBmG1BVMf83VDCXrD1ZmDYDitkBRSS5Y7Ko
        plS1Tr7i73Rjd91JCDwnJ1I=
X-Google-Smtp-Source: AGHT+IECzMqNl3d2ZZIy7/6r98qWTBpjr7wsj1gzpMfTrN07Rf3lIiwbg+FaRYaoR2DjxlC43Ef4zQ==
X-Received: by 2002:a17:903:22cd:b0:1c3:7628:fcb3 with SMTP id y13-20020a17090322cd00b001c37628fcb3mr873796plg.47.1694762824624;
        Fri, 15 Sep 2023 00:27:04 -0700 (PDT)
Received: from localhost.localdomain ([222.95.63.58])
        by smtp.gmail.com with ESMTPSA id k6-20020a170902694600b001b801044466sm2761928plt.114.2023.09.15.00.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 00:27:04 -0700 (PDT)
From:   Wang Chen <unicornxw@gmail.com>
X-Google-Original-From: Wang Chen <wangchen20@iscas.ac.cn>
To:     linux-riscv@lists.infradead.org, conor@kernel.org,
        aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Wang Chen <wangchen20@iscas.ac.cn>
Subject: [PATCH 12/12] riscv: defconfig: enable SOPHGO SoC
Date:   Fri, 15 Sep 2023 15:26:53 +0800
Message-Id: <20230915072653.118448-1-wangchen20@iscas.ac.cn>
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

Enable SOPHGO SoC config in defconfig to allow the default
upstream kernel to boot on Milk-V Pioneer board.

Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index ab86ec3b9eab..bf737cfa1d2c 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -32,6 +32,7 @@ CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_STARFIVE=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_SOC_VIRT=y
+CONFIG_ARCH_SOPHGO=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_PM=y
-- 
2.25.1

