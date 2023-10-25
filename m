Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627837D69EF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjJYLVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJYLVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:21:49 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E84AC;
        Wed, 25 Oct 2023 04:21:46 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53f6ccea1eeso8602373a12.3;
        Wed, 25 Oct 2023 04:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698232905; x=1698837705; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2rHfcsjlV4rlBGbf4CfwSEr1+dgsfk+VxIq/saYt7A=;
        b=QH0zn8AfCu8yLe24O97F19CUDfYyn+D7LnEY0TkkmKEz5V/1ZTA2X+oFxl7IIUytjG
         qeuTimXeMYhkcZxvvonlb26y2shQbxQSXEZvHWg26eB2xbgBLGJaSS30UVc3xcswD/Ru
         +mMPx8ewrIo9Itjt1wwLwpOLrNq2MrFICSE/ufd/Y6n81bu6NIq5U1uzR8l1frnc9eFu
         5t6HGUDogPpbaIC5ubC/U/Hqk6YGFJ0koPIiljYGgT3wpNcrxFlrKDy4pDfszp02vtfX
         KouhZHXlCpAC50EgERnsVae3WU/MP3xUBygq/t/a2CBg0OJHfB8jQx8lgqmZ4pyMciCJ
         cMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698232905; x=1698837705;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2rHfcsjlV4rlBGbf4CfwSEr1+dgsfk+VxIq/saYt7A=;
        b=ogyiRrtICWbTri2PLWhU7dpLbXnGyz4kUuPvBpEbTeNW6Yd2y6TuiYJYH+6lI9yTrK
         prtMCC8DGsHlkay2Km/rNinscgg6SU9HBiWw7AMmkHhwO5d/GY+DW3LaX/p8oFU83QED
         oP3hAg0zD0O0htKMIvQcX0nonWtN9xLWolkZfE562LOQfnC8b1OJFWdsHRZHkVmqpGsj
         1RlYWxX8pL1i6ldp1H5IYZcLAbf2H1UyeYgT+q13huPeYUtJB/qoSY9Q6TYjohzJKzz7
         wINFf8rbI/ytnQDP4rGqfx0F5yajyjaGa7LsN4WOlJDfdfSiryGs0n0d3EB3aDwiCacL
         KcYA==
X-Gm-Message-State: AOJu0YzrL7lLR71sumFjbMAR+c8uz12FsLJQDk8b/05e0KgJaxoLdq+b
        MMNQ8lO7neMZJPmXRexcGu4tX0D0VVg=
X-Google-Smtp-Source: AGHT+IGPuYW/6V1UmkcJQL53Gndt5qS6mrifdkq1FD6CQye3uPK1nErdTXZVKKpQwX3DZ2hm9yT2yA==
X-Received: by 2002:a17:906:6a0e:b0:9be:45b3:1c3d with SMTP id qw14-20020a1709066a0e00b009be45b31c3dmr9871645ejc.48.1698232904750;
        Wed, 25 Oct 2023 04:21:44 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:2cbd:f9ec:f035:ebea])
        by smtp.gmail.com with ESMTPSA id xa22-20020a170907b9d600b0099bd1ce18fesm9841288ejc.10.2023.10.25.04.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 04:21:44 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] arm: debug: reuse the config DEBUG_OMAP2UART{1,2} for OMAP{3,4,5}
Date:   Wed, 25 Oct 2023 13:21:36 +0200
Message-Id: <20231025112136.3445-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d2b310b0234c ("ARM: debug: Use generic 8250 debug_ll for omap2 and
omap3/4/5 common uarts") adds address definitions of DEBUG_UART_PHYS for
OMAP2, OMAP3, OMAP4 and OMAP5 in ./arch/arm/Kconfig.debug.

These definitions depend on DEBUG_OMAP{2,3,4,5}UART{1,2}; however, only
DEBUG_OMAP2UART{1,2} are defined in ./arch/arm/Kconfig.debug, and
DEBUG_OMAP{3,4,5}UART{1,2} are not defined. Hence, the script
./scripts/checkkconfigsymbols.py warns here on non-existing symbols.
Simply reuse the config DEBUG_OMAP2UART{1,2}; there is no need to define
separate config symbols for OMAP{3,4,5}. So, just delete the dead
references to DEBUG_OMAP{3,4,5}UART{1,2}.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/Kconfig.debug | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index b407b7b9b715..fc2b41d41447 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1593,10 +1593,8 @@ config DEBUG_UART_PHYS
 	default 0x48020000 if DEBUG_OMAP4UART3 || DEBUG_TI81XXUART1
 	default 0x48022000 if DEBUG_TI81XXUART2
 	default 0x48024000 if DEBUG_TI81XXUART3
-	default 0x4806a000 if DEBUG_OMAP2UART1 || DEBUG_OMAP3UART1 || \
-				DEBUG_OMAP4UART1 || DEBUG_OMAP5UART1
-	default 0x4806c000 if DEBUG_OMAP2UART2 || DEBUG_OMAP3UART2 || \
-				DEBUG_OMAP4UART2 || DEBUG_OMAP5UART2
+	default 0x4806a000 if DEBUG_OMAP2UART1
+	default 0x4806c000 if DEBUG_OMAP2UART2
 	default 0x4806e000 if DEBUG_OMAP2UART3 || DEBUG_OMAP4UART4
 	default 0x49020000 if DEBUG_OMAP3UART3
 	default 0x49042000 if DEBUG_OMAP3UART4
@@ -1719,10 +1717,8 @@ config DEBUG_UART_VIRT
 	default 0xfa020000 if DEBUG_OMAP4UART3 || DEBUG_TI81XXUART1
 	default 0xfa022000 if DEBUG_TI81XXUART2
 	default 0xfa024000 if DEBUG_TI81XXUART3
-	default 0xfa06a000 if DEBUG_OMAP2UART1 || DEBUG_OMAP3UART1 || \
-				DEBUG_OMAP4UART1 || DEBUG_OMAP5UART1
-	default 0xfa06c000 if DEBUG_OMAP2UART2 || DEBUG_OMAP3UART2 || \
-				DEBUG_OMAP4UART2 || DEBUG_OMAP5UART2
+	default 0xfa06a000 if DEBUG_OMAP2UART1
+	default 0xfa06c000 if DEBUG_OMAP2UART2
 	default 0xfa06e000 if DEBUG_OMAP2UART3 || DEBUG_OMAP4UART4
 	default 0xfa71e000 if DEBUG_QCOM_UARTDM
 	default 0xfb009000 if DEBUG_REALVIEW_STD_PORT
-- 
2.17.1

