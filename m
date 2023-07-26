Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457D67636CC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjGZMwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjGZMwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:52:09 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ACF2719;
        Wed, 26 Jul 2023 05:51:42 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-78372b896d0so260791239f.2;
        Wed, 26 Jul 2023 05:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690375901; x=1690980701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=27g7ROOYGsxjIJSe3q14Ar1yX5esmHUkSGM/lQemacc=;
        b=gn+uiCfZlZZbT24ixY/cnqPzC9ctxD6Tj+x7ZwPUqGg7kXEIFjnRz+VxGZ5bBNKykp
         1b9QgXxmrVTXinSzj0TZdQ+5c2oKAhSBXV7aPF4XVEO3VYDII/3ktWj66ehYc5lioKoY
         m0/OMUwDUucWczX0OkjDNaunROwl+Uv/guzERTIpiQ/7YXEnkoKFVBLSRk6Pc3Dd/Vxz
         o7gaMT/w8ktLo2MvDKLkW6yEPzbXFiLmvn4ZRgY/pvOvsbgMSq6Gtk7+8FEfYjYU9iFQ
         6E2xZ4UeSs3yU1C4PNnoQJUz6nUggDUZB/2GAJZAnGNp5y/PDPoOpMYhHegXk8X9f4bM
         G6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690375901; x=1690980701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27g7ROOYGsxjIJSe3q14Ar1yX5esmHUkSGM/lQemacc=;
        b=JPIkyV6cuWhTTg5WxLCCRc3ljJiLxKqHWqDS00HlHjb7vNoxhLfrqKPUJiVAfV2ZWz
         rbnhEg2U4M5wcslS9j2WdcWh/Bfih3seVbUbyfqFzgoKLOVPtmLicPRhG+cXaTrYeKDF
         M7iVFqOOVahb6kCirPyW2YQI4hKcktm1oBiTPr3ol5PqYm1KKIb8vKaNZViBJrvTWDTA
         PHSG36i8JNMBFRV1OBD5VtNdwBJXPaMEEC63Uw2JlPadA8zLDx+duDIFbjkZdF1iynSS
         aXs5B1AL33WqtrfRD+bJ87/kHyBalVFOzkRWlirmguvCDkOKM2u2S4Tkb+O7ZUXZKSS1
         f/OQ==
X-Gm-Message-State: ABy/qLYIvDncF796sfBisGSqMAklpXSuNJ+YQyyynd/9/agbm6EdX+OL
        2vuVu+qdcGM207zlK74228L+YQTYG5U=
X-Google-Smtp-Source: APBJJlFG6H+RRZ1QmDGiWMJfKNbE4TqkcfiSJqpT+T4oZgkRslV2Q45w5mahNm8zZFbePTguhlD5pA==
X-Received: by 2002:a6b:3112:0:b0:787:1d0a:ce81 with SMTP id j18-20020a6b3112000000b007871d0ace81mr1834300ioa.13.1690375900759;
        Wed, 26 Jul 2023 05:51:40 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id u4-20020a02cb84000000b0042afd174c62sm4161593jap.99.2023.07.26.05.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:51:40 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v2 0/2] MIPS: loongson32: Remove obsolete header files
Date:   Wed, 26 Jul 2023 20:51:29 +0800
Message-Id: <20230726125131.462257-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

No one is using regs-clk.h and regs-rtc.h.
Therefore, remove these obsolete header files.

Changelog
V1 -> V2: fix the build error of "‘LS1X_RTC_CTRL’ undeclared"

Keguang Zhang (2):
  MIPS: loongson32: Remove regs-clk.h
  MIPS: loongson32: Remove regs-rtc.h

 .../include/asm/mach-loongson32/loongson1.h   |  2 -
 .../include/asm/mach-loongson32/regs-clk.h    | 81 -------------------
 .../include/asm/mach-loongson32/regs-rtc.h    | 19 -----
 arch/mips/loongson32/common/platform.c        |  8 --
 4 files changed, 110 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-clk.h
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-rtc.h


base-commit: 0859bdf1ace659e8981a82956920573c1f8203da
-- 
2.39.2

