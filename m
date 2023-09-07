Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F72796F33
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 05:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjIGDOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 23:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238038AbjIGDOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 23:14:03 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9DF10F1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 20:13:58 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf11b1c7d0so11821585ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 20:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694056437; x=1694661237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DTEliymHGGsjHkf9gOQvp04Ee/X7GkoMiapI3zHqYg=;
        b=Cw9YURglDcaFDIW2Ze25FDZcDgLOOu0iHKVXwxawE0HzVR/9k2oupphQNxX0V/d/Q9
         QTbRpnJn/P7jcQdoQx/Na2g9ZzvzJDEHpaqFfcYv7dCSVBDyFM8JQ+Ul2SbMpexcgIsc
         DOxBbQQvJ4E1n0f0HkIJn0wFJhLCycPqY8QjjUjhYmzAqWedxqRwWol36elzQDj5e8+6
         mV8haMkrgsI9R8SrY1ZIENN+QvqWIT9dXEiFml9RWbwOG8dQeVxNPtbnB+TmVk7YOh9S
         VU7GET/1YFCAtGGvOhTj7M/uc8fGeIMjuoTkdGXEXQePS7JZz3+x36LQy6AL4tOs9TEb
         Mz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694056437; x=1694661237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DTEliymHGGsjHkf9gOQvp04Ee/X7GkoMiapI3zHqYg=;
        b=kfwn+LvPgX2/GhEVJPKaGZ4yNDV+u90acL2QDY0VNHM1XXua1O9+okVC97kJd1TkXi
         m4+cPlev9QpQKzVCCnEO5K6lW6apZaI6QYhB8R3UmjbHfVCGCGixQ1p6hy9K2oVzRYSo
         SXBJatKMjMI6WTnfDP8c57bNbZvMez3lzbpHuh0U8STGjFJa70cvxp+Yq8ck8FVrnKWE
         k5od2NE+iFK5zFAfFnrEo9EDxdeJ3xbz4gBmn+kOpjpY7pYiRZxnvbgJciIUWnFE6WSa
         n9YjyrWi+8+r/hQghlFfuUW0Ei1wUG4dnIlt49bS2z0KHsa+3ECj8PQJGyZB4sddmUGl
         Izww==
X-Gm-Message-State: AOJu0Yw8VjFtwgJ+EzW5NMoPxUIVZsXSYdU0TjC9Sn1Q86Rpza8Wz8Qf
        3JAP4fe7v9BOYktjziPpTfkM9A49xKc=
X-Google-Smtp-Source: AGHT+IH1GNIj5KngpiOl6YqNBSSwIdokF8UAu4o0Ra+cs7LfoXmoEGGWWjFmc55EspggbPXfFY2jlQ==
X-Received: by 2002:a17:902:e54e:b0:1c0:bcbc:d67 with SMTP id n14-20020a170902e54e00b001c0bcbc0d67mr1716353plf.22.1694056437641;
        Wed, 06 Sep 2023 20:13:57 -0700 (PDT)
Received: from wenkaidev (118-163-147-182.hinet-ip.hinet.net. [118.163.147.182])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902c3c100b001bb9aadfb04sm11609943plj.220.2023.09.06.20.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 20:13:57 -0700 (PDT)
From:   advantech.susiteam@gmail.com
To:     advantech.susiteam@gmail.com
Cc:     wenkai.chung@advantech.com.tw, Susi.Driver@advantech.com,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mfd: eiois200: Insert EIO-IS200 core driver to Makefile
Date:   Thu,  7 Sep 2023 11:13:16 +0800
Message-Id: <20230907031320.6814-3-advantech.susiteam@gmail.com>
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
Controller core driver to the Makefile in the drivers/mfd directory.

Signed-off-by: Wenkai <advantech.susiteam@gmail.com>
---
 drivers/mfd/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index c66f07edcd0e..46dc303ddae4 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_MFD_CROS_EC_DEV)	+= cros_ec_dev.o
 obj-$(CONFIG_MFD_CS42L43)	+= cs42l43.o
 obj-$(CONFIG_MFD_CS42L43_I2C)	+= cs42l43-i2c.o
 obj-$(CONFIG_MFD_CS42L43_SDW)	+= cs42l43-sdw.o
+obj-$(CONFIG_MFD_EIOIS200)	+= eiois200_core.o
 obj-$(CONFIG_MFD_ENE_KB3930)	+= ene-kb3930.o
 obj-$(CONFIG_MFD_EXYNOS_LPASS)	+= exynos-lpass.o
 obj-$(CONFIG_MFD_GATEWORKS_GSC)	+= gateworks-gsc.o
-- 
2.34.1

