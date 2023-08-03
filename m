Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B0876F358
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjHCTSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjHCTSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:18:39 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196F035B5;
        Thu,  3 Aug 2023 12:18:39 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76571dae5feso96886185a.1;
        Thu, 03 Aug 2023 12:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691090317; x=1691695117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZrXNNcaZSVoaRBZujz52OkIqfXSxSB9T1O6Wwsy7t4=;
        b=MguT9N3d0+TA4/O/U9k2a2sVca5+9zvquBlRXcEe/+jpeV3QyG5xGF/Rw8rwsBMTVF
         W0MtCMLDeE7OHOsDDhKfx2EuA+euGdTWmxjZNXP2ag4qYo3HceQl+8qji7AE5bSZrwpY
         OaKiuYRUYdzh/NFvCWVw7RcDqY+nO3RwzGjhJbvuyG6wu3bTWeaHxAap4eOFHV5Jz0t1
         m8hkVDNYvi1XQ9u9R+HlvAUdrcWBExNZdquMTyIdEVaMtco8IXjs52sBIyLhqxZVbhI/
         pqNfktN+ACvbQisSAE7gtcgRoXPBBRqrrwOkmBT3ypcjakScuFT+CkH/Oxx0jgNuHrD5
         WKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691090317; x=1691695117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZrXNNcaZSVoaRBZujz52OkIqfXSxSB9T1O6Wwsy7t4=;
        b=QQH6GyExl/bCfGaetvWssws7RV2OzbCy31f6V995xwtwpQN+9loFPbe29pi7pRm+9G
         n+ffhFkl3MF/n6GpRETnWjCRJmoAH5e5SVBztRhU0uda+kNcOXcsv2FVtzh/kQ2S5Wt/
         cL2CVCqBYtKDKF+1WA5NhtwDM00XsntMrE+GOV4NAjyQjjnvo0GJTGpkK297J82j6K7a
         Dfl8S2oNUxQBvoYjy2LNAHa0qlC61zj2iQQfBVQN1oC3N0nyvfiry/+UaHNhMEoS1Z1F
         HXCyI9aw/dxJa0ySrcVRdlyDdTXu3XTrp6NAuodIa1q1Z2QDKgeAv/zTWo6pD7w4qUNp
         exTw==
X-Gm-Message-State: ABy/qLZ0cKppRa3To+pWURt2ZVnnxCs0oXYV7S/0cwy3qri8Az/piZ+o
        yiU5FmKBbzv0yvDbFZi45LTkvxSWEbs=
X-Google-Smtp-Source: APBJJlGf7gn/3VzckMV54ckcBxQl/uNtl43LcdrAzScCUUVDknYdmsAXOlNpgVLcpOfbcPFMFSbTVg==
X-Received: by 2002:a05:620a:170c:b0:76c:de57:7b61 with SMTP id az12-20020a05620a170c00b0076cde577b61mr3654401qkb.25.1691090317462;
        Thu, 03 Aug 2023 12:18:37 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id n20-20020a0ce494000000b0063762ab2f90sm108897qvl.83.2023.08.03.12.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 12:18:36 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: [PATCH 3/4] arch/arm/configs/*_defconfig cleanup: drop CONFIG_USB_MUSB_AM35X
Date:   Thu,  3 Aug 2023 15:18:17 -0400
Message-ID: <20230803191821.36793-4-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
In-Reply-To: <20230803191821.36793-1-twoerner@gmail.com>
References: <20230803191821.36793-1-twoerner@gmail.com>
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

Drop CONFIG_USB_MUSB_AM35X as it was removed in commit 57f8e00d8a82 ("usb:
musb: Drop old unused am35x glue layer").

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig  | 1 -
 arch/arm/configs/omap2plus_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index c7b2550d706c..497274c81ea2 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -851,7 +851,6 @@ CONFIG_USB_MUSB_HDRC=m
 CONFIG_USB_MUSB_SUNXI=m
 CONFIG_USB_MUSB_TUSB6010=m
 CONFIG_USB_MUSB_OMAP2PLUS=m
-CONFIG_USB_MUSB_AM35X=m
 CONFIG_USB_MUSB_DSPS=m
 CONFIG_USB_MUSB_UX500=m
 CONFIG_USB_UX500_DMA=y
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 047b625e677f..98fbd16e17ce 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -554,7 +554,6 @@ CONFIG_USB_STORAGE=m
 CONFIG_USB_MUSB_HDRC=m
 CONFIG_USB_MUSB_TUSB6010=m
 CONFIG_USB_MUSB_OMAP2PLUS=m
-CONFIG_USB_MUSB_AM35X=m
 CONFIG_USB_MUSB_DSPS=m
 CONFIG_USB_INVENTRA_DMA=y
 CONFIG_USB_TI_CPPI41_DMA=y
-- 
2.41.0.327.gaa9166bcc0ba

