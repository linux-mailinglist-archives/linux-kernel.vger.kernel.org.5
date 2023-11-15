Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041C47EC0E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbjKOKon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 05:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjKOKom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 05:44:42 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF574109;
        Wed, 15 Nov 2023 02:44:38 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5441305cbd1so10148114a12.2;
        Wed, 15 Nov 2023 02:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700045077; x=1700649877; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbzuiJQ2vBegQA7voMECslTs5KDNKkKwd7ZxQs3+i5k=;
        b=RpY7ScT5lHA50+KIeOZf2uZXViIB/K4IDLSTkLT5Fw/9jhUVnf8LgakdmgT8NoHOBV
         YpSZEOfwyHXnDeCzU4VxThbNz9AQ1dM4NqMPYSrryTCyARq9h/Nvnet4LRb0bWpo8PSz
         cI6YHPDMyl5pLuyz14tPSZXw5qA5CO5RIT0V761mUaHIQSO2ZS9KhjupBExpq8NPXqux
         1T2YGIDgJIPqKFCh16xCBjR2D8m0klT6MaXL9mmTFKjOKUfGoOoc1zNDk5HBebSgcMzi
         HKyYVH3C7iNyVFWo8g3RBM0VzBAEzQqKjZTYc9hqt/Wicd8A7VJ0GZ3PW2GM1JBx13SY
         dv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700045077; x=1700649877;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbzuiJQ2vBegQA7voMECslTs5KDNKkKwd7ZxQs3+i5k=;
        b=K9DvB7urmw4nEnh1xiE2KAUFSbbaZcw6StwsUd9NiLDCOmGTBroHXJ9nrVR5U+jzEw
         ppJiq1J+bykD3TLojeEydF3TMDhjGt8s7yT2FsqagaQ5mp4By1B/BD2k8r/lEFyaj/Hb
         hkKWLQ/Bb8/TbK21ZteDL5PnBY9kaFJW3GpEC75BSeFRMkLVErHXTDuI12dHbWX4Ifkz
         JViRnqs6RW0oA833RUZzDAf9KF8qFCyuF33fH6oscPM6IPPzA0UmfBva5hgzj6tT/PtM
         kOf5c0QqpD1yGzdaQ02I3Lc6C9CLYF/zu5BLo4bgGHfH3YoIqIvI1kpIMUIPIX04Em1c
         prRQ==
X-Gm-Message-State: AOJu0Yz/9/TFM/kfT1n2HbwU3lX3+eDAvNQZh9seU7WwUZFw1J+VqIsw
        sbg1UJ5m9R50EszfJhqteoo=
X-Google-Smtp-Source: AGHT+IGoKYeYQ6VqydJ9DHVBCeRFwf/5TrkJAz59XZJNk/mqUrOM6/C5VjmJA5IM2b4Q5cpJvDiByA==
X-Received: by 2002:a05:6402:1052:b0:543:535f:cc74 with SMTP id e18-20020a056402105200b00543535fcc74mr8252049edu.3.1700045077059;
        Wed, 15 Nov 2023 02:44:37 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:999:a30e:2872:ffae])
        by smtp.gmail.com with ESMTPSA id l18-20020a50d6d2000000b00542db304680sm6470010edj.63.2023.11.15.02.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 02:44:36 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: add omap bus drivers to OMAP2+ SUPPORT
Date:   Wed, 15 Nov 2023 11:44:34 +0100
Message-Id: <20231115104434.25796-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While doing some code cleanup in drivers/bus/, I noticed that the files
drivers/bus/omap*.[ch] have no maintainer.

As far as I see from the git history, important changes to those files went
through Tony Lindgren. Further, the inclusion of those drivers depend on
the config ARCH_OMAP2PLUS being enabled. This suggests these drivers are
part of the section OMAP2+ SUPPORT.

Add the omap bus drivers to OMAP2+ SUPPORT.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 973568cae9e5..e829dbac1e99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15850,6 +15850,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
 F:	Documentation/devicetree/bindings/arm/ti/omap.yaml
 F:	arch/arm/configs/omap2plus_defconfig
 F:	arch/arm/mach-omap2/
+F:	drivers/bus/omap*.[ch]
 F:	drivers/bus/ti-sysc.c
 F:	drivers/gpio/gpio-tps65219.c
 F:	drivers/i2c/busses/i2c-omap.c
-- 
2.17.1

