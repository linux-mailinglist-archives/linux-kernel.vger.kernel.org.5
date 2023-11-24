Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AC77F7092
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345349AbjKXJwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjKXJwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:52:21 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2527C170A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:52:28 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5482df11e73so2328445a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1700819546; x=1701424346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lPiBn2j7nRC2ohY93oZwJpQOBSGsTTZbyG2+TlPFQiA=;
        b=GuRLhXgIIoNoHiXXElj/Uz50alI1JdzaFBgz6HNm0jkMA8K2Bb0bcsJbbw+Jfdf+B2
         cuGzMW/kI0M8GKmj3emS/8uoHTYV+/tD8CEHXZA3I+XmO8Dxho0k4v2g8k5dIGE62/K6
         zU/qZDypAnI+Mlqiz7q/BiPH3Tkdl7BZ9L14M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700819546; x=1701424346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPiBn2j7nRC2ohY93oZwJpQOBSGsTTZbyG2+TlPFQiA=;
        b=pjx8I2pvMguBfW+jQsGqoVSb7EUJNggVC6pOWvPA0bu8F6S/0E4ioJ84QCoBDlY+CW
         nzMuD/mX32N0Yhpvr22kaO1Z3l5IZh6SnNaAmA60CIXEvUN1aFpL2RmfrDwqccy1HR5T
         JkWXxzcLA0SKr1MUk8mHsrUCIgIejoaiE/I5khLjRZfMtm4HM4hJmiCDUVXwShf4wcWx
         GTJs0ydxos0Fnt1CI0nRAS9Buvy0NmYS64JZjokz2kj09fHg01oRBkgYPJ+vD3CexG4/
         tUoiXwSgMGkZBlEvlzEXf/QsW2dDuKmOi17vGD+qvJC8l4BXt3Kqa+61al/aB7XM7R8W
         hh/A==
X-Gm-Message-State: AOJu0Yw8CsVKXGLPCDR5N4x+UijNUhWORfb1vCW6srDu9rdQU5rdDlvu
        HwmqySMjg1j5LB46SuJoG9ofGdJMcIgrXKF4T066vw==
X-Google-Smtp-Source: AGHT+IEBfhEmsD5EKPJl+/lEhxi4nG9SttIahQn1yPMeWAXJB+1krEHdfcyXCHFNF8KJVIk8quJgcQ==
X-Received: by 2002:a50:d745:0:b0:543:5741:c9cd with SMTP id i5-20020a50d745000000b005435741c9cdmr1359620edj.34.1700819546366;
        Fri, 24 Nov 2023 01:52:26 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:7c18:b9c9:f303:f6bb])
        by smtp.gmail.com with ESMTPSA id i7-20020aa7c9c7000000b0054855988fedsm1588384edt.37.2023.11.24.01.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:52:26 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Helge Deller <deller@gmx.de>, Zhou Zhu <zzhu3@marvell.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH] video: fbdev: mmp: Fix typo in code comment
Date:   Fri, 24 Nov 2023 10:52:11 +0100
Message-ID: <20231124095221.659445-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
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

s/singals/signals/

Fixes: 641b4b1b6a7c ("video: mmpdisp: add spi port in display controller")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/fbdev/mmp/hw/mmp_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mmp/hw/mmp_spi.c b/drivers/video/fbdev/mmp/hw/mmp_spi.c
index 16401eb95c6c..64e34b7e739e 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_spi.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_spi.c
@@ -91,7 +91,7 @@ static int lcd_spi_setup(struct spi_device *spi)
 	writel(tmp, reg_base + LCD_SPU_SPI_CTRL);
 
 	/*
-	 * After set mode it need a time to pull up the spi singals,
+	 * After set mode it need a time to pull up the spi signals,
 	 * or it would cause the wrong waveform when send spi command,
 	 * especially on pxa910h
 	 */
-- 
2.42.0

