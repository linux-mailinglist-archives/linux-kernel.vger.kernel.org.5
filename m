Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01428786AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbjHXI5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbjHXI5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:57:40 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AC110FC;
        Thu, 24 Aug 2023 01:57:38 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bc3d94d40fso50797505ad.3;
        Thu, 24 Aug 2023 01:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692867458; x=1693472258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wONcFGWq+PGpZIkK9NYcTrSr8kaoXLZnug4VTSpfpPY=;
        b=Tznc5ZWr+3NAD2cD/d5ogGrBOTq3TgjrZld+TW6mk6d+TZXYJDLL4Auc8V/6Il08eL
         CFGn6otYSEkPncaBfF/lylKc4yQdlxsoLvhlLhj55ZwSwBoapNB6oAegGg3atmr/ZwYw
         O4jgpo+1QrG+3X4XwixG0r5828IiHdmSTrb3B05pngmFwxlaxC0SK6MAnVgxWSh0SsJ6
         slWAhrUde5orpCa1ycNpOJEHZqqKPj7f7cKV/NdWsBPjPYhwk+JeRr7Fo19Wc8/O4tKt
         c8HZD2zgcCyIkRpv/3tGM7t4bgPV7gzozmyIXHsDS/kcyJNx1jMyMsA/JJn+Ezp7N4GJ
         foPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692867458; x=1693472258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wONcFGWq+PGpZIkK9NYcTrSr8kaoXLZnug4VTSpfpPY=;
        b=drwXHqtDeO90PohyLU8gjLSf26X5mc1RioXuIdtAhoot1gssyVpM3stpvsg9GcB6jG
         wm+oZqCVF1SJtlgkEKMnrN0Tk3IGihAKRG2WU3lighiYYjPU8bEZrdM9h7Z7OskYhH7r
         csOP0W7cwFpGn6KUhuTnJQOqyZeQW7IxiJnqbq2CuMxVjSGLGqGrCxT11JdP0uIXueq1
         DLwg+/Zh444fgQrHg+AMZlnoad959FlTKyaR12LSNuJk8F205OxO5tuQBvekBAdGmANj
         XZ3SGQ3t+EokLwV+vj6Lqzuk358SzxZr8GKhchit59lmXma5TQqXA8loNMZD6s8wJqdX
         3vtA==
X-Gm-Message-State: AOJu0YzcW+M9gC3T5amZ5ZtibmNR6VlkBysTTB1nkz+TEROetSvhyeQF
        X2Y/H/TzulxkyIWcRkx0R6k=
X-Google-Smtp-Source: AGHT+IHsmAb2LrAKerZ9+R8nOBbMmaVsg9zBo6JFh36BUqIlI7RiLy51goYsL07hTZ4IdFaQPCDi+g==
X-Received: by 2002:a17:903:234e:b0:1bd:aeb3:9504 with SMTP id c14-20020a170903234e00b001bdaeb39504mr17985769plh.15.1692867457815;
        Thu, 24 Aug 2023 01:57:37 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1047:2379:8974:f63f:c2f8:6a5b])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001b8b26fa6c1sm12322673plk.115.2023.08.24.01.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 01:57:37 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     hverkuil@xs4all.nl, mchehab@kernel.org, slark_xiao@163.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>,
        syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com
Subject: [PATCH v3] media: gspca: UBSAN: shift-out-of-bounds in set_flicker
Date:   Thu, 24 Aug 2023 14:27:31 +0530
Message-Id: <20230824085731.9930-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

Syzkaller reported the following issue:
							
UBSAN: shift-out-of-bounds in drivers/media/usb/gspca/cpia1.c:1031:27 
shift exponent 245 is too large for 32-bit type 'int'
						
When the value of the variable "sd->params.exposure.gain" exceeds the 
number of bits in an int, a shift-out-of-bounds error occurs. The error is 
generated when the variable "currentexp" is left-shifted by more than 31 
bits. In order to confirm the range is valid, the conditional expression 
was added.
				
Reported-by: syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/20230818164522.12806-1-coolrrsh@gmail.com
Link: https://syzkaller.appspot.com/bug?extid=e27f3dbdab04e43b9f73
Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>							
---
v1->v2			
Changed the patch
v2->v3				
Changed the commit message	
---
 drivers/media/usb/gspca/cpia1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/gspca/cpia1.c b/drivers/media/usb/gspca/cpia1.c
index 46ed95483e22..dafc522d5e7b 100644
--- a/drivers/media/usb/gspca/cpia1.c
+++ b/drivers/media/usb/gspca/cpia1.c
@@ -1028,6 +1028,8 @@ static int set_flicker(struct gspca_dev *gspca_dev, int on, int apply)
 			sd->params.exposure.expMode = 2;
 			sd->exposure_status = EXPOSURE_NORMAL;
 		}
+		if (sd->params.exposure.gain > 31)
+			return -1;
 		currentexp = currentexp << sd->params.exposure.gain;
 		sd->params.exposure.gain = 0;
 		/* round down current exposure to nearest value */
-- 
2.25.1

