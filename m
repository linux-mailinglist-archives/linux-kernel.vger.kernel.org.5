Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718B3796F32
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 05:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjIGDOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 23:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjIGDOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 23:14:02 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69D810CA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 20:13:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68a42d06d02so459498b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 20:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694056434; x=1694661234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CweUPJL5xZp7oHDLbCdTD5dawMh3eCK/C8GrYfBGMCg=;
        b=qN0a++KZHBr+sVJix91vyJ2s4vMbc0d4bdzT3J00KyV3s6jugHls+O2z3ZsbQWwcxs
         0Xl3mXyQhTz+5tePPbMoXcz/4TbR0Z+kRSOwkq8YmGIAb2L+xz6O8wHgoHrkPDNG3ZZ2
         ZQCObYis/cywvYueWLXEVOAbsJknl49qBqcHr1rei5UfM5XRra3eO38RsQ0iUCFWK7qb
         /AGYKcUdVXJXQ95nq59Ppy08ujAk/bPWjLtXPihj4HGAb+w+LyuQSUqySzwn/fjv9Cwp
         +CLrLr7MkCLYK8ncYd0nJ3Qnekzx/XWGfcNbYJ2zZR80neVa681tRgFXV/8Fd+yxsH0y
         U5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694056434; x=1694661234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CweUPJL5xZp7oHDLbCdTD5dawMh3eCK/C8GrYfBGMCg=;
        b=lL0HRwKVS8lESQ5BotGcrFBzJsI+ij95Ojdi0R8rVBmsox0lGOsRkzar8Czg0NqrSZ
         NIo+8sxysJfMpObaDGoWatPxnKj/FQJXi4Q7lsQfiPVQIofXQeyzAuo6UG/5MaTDukYT
         DecpltsrIvHNuMG8rFYeIP6UFckvfpIn5boYCIVw9zVsAsiJFUfk9rzKaLvz67gEFRi+
         a0Ya42y8F9Po+vjACQS7jb0g4Zy+3VOB+QZpgRhuYfdys3x1dWA+S9MMR2eR51j1VxNv
         ZuQqz8DvJ63yzcf7cqsX0MCWmuEk9NPsLeCTqvdson5xmpz2oHsmy9kSG4lnraj4hKvy
         pKEA==
X-Gm-Message-State: AOJu0YwhlX5F7twMR6QlYW+oajYuyXLJnGuj9t/exZD/zQQJm42CbQQl
        Nuz+9GCbUBsnbCUfChTgWQyjtdCqNew=
X-Google-Smtp-Source: AGHT+IEv25aOYkrH42w0Sz/YQbI/4HwNCkvmTUNVzZDeFV88oGcjNjaefx6ornLdu89dHPXko2bUAA==
X-Received: by 2002:a05:6a20:9744:b0:14d:446f:7211 with SMTP id hs4-20020a056a20974400b0014d446f7211mr16211714pzc.53.1694056433896;
        Wed, 06 Sep 2023 20:13:53 -0700 (PDT)
Received: from wenkaidev (118-163-147-182.hinet-ip.hinet.net. [118.163.147.182])
        by smtp.gmail.com with ESMTPSA id o9-20020a170902bcc900b001c1f4edfb87sm11680361pls.92.2023.09.06.20.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 20:13:53 -0700 (PDT)
From:   advantech.susiteam@gmail.com
To:     advantech.susiteam@gmail.com
Cc:     wenkai.chung@advantech.com.tw, Susi.Driver@advantech.com,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mfd: eiois200: Insert EIO-IS200 core driver to Kconfig
Date:   Thu,  7 Sep 2023 11:13:15 +0800
Message-Id: <20230907031320.6814-2-advantech.susiteam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907031320.6814-1-advantech.susiteam@gmail.com>
References: <20230907031320.6814-1-advantech.susiteam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenkai <advantech.susiteam@gmail.com>

This patch adds support for the Advantech EIO-IS200 Embedded
Controller core driver to the Kconfig configuration menu. When
configuring the kernel using tools like menuconfig, you can
select M to build it as a module or select N to exclude it from
being built-in.

Signed-off-by: Wenkai <advantech.susiteam@gmail.com>
---
 drivers/mfd/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index aea95745c73f..85bcb8f95501 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -52,6 +52,23 @@ config MFD_ACT8945A
 	  linear regulators, along with a complete ActivePath battery
 	  charger.
 
+ config MFD_EIOIS200
+	tristate "Advantech EIO-IS200 Embedded Controller core driver"
+	depends on X86
+	depends on m
+	default m
+	select MFD_CORE
+	select REGMAP_MMIO
+	help
+	  This driver provides support for the Advantech EIO-IS200 EC and
+	  activate its sub-drivers, including GPIO, watchdog, hardware
+	  monitor, I2C, and thermal.
+
+	  This driver option only has two states: M and N. It cannot be
+	  built-in. To compile this driver as a module, choose M here; the
+	  module will be called eiois200_core. The system will force it to
+	  M if any one of its sub-drivers is chosen.
+
 config MFD_SUN4I_GPADC
 	tristate "Allwinner sunxi platforms' GPADC MFD driver"
 	select MFD_CORE
-- 
2.34.1

