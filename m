Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FB178DC66
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243100AbjH3Spi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242262AbjH3HoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:44:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7756BCD8;
        Wed, 30 Aug 2023 00:44:08 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a520dba33so4193828b3a.0;
        Wed, 30 Aug 2023 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693381448; x=1693986248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KaI3PfD8joR99TjMB7Mb3TjzWqZ8IotMwduAcjhk/lk=;
        b=gf77cZ800GC40FJrd0lVKsSlrFpSewybhTXRscHHqeTx6zAvxpnNlaisMmWkFl4Osl
         M3UxNwQkLofiOajnFYKqof3AxLkkW/7/PJrIR9pXfHSoZzSXxVXJcEqYkIXEDTDFXB3O
         rZ/fogGfH9kmY9r4k+Z0SzKrbEi1pQVMs8XxsH69xIHEV4l1dPmbOwG1VoxkPFAZoPfa
         Av877gjC9oTym1LNQ+z9BbT1325IdtMYQ/sFanedqitrnUDXwbsOze5Hq6t2RYXwd6mt
         90LVEyp6JduYOa/EwKL0oFVu48WbpGlkDMPE5XYFtdmJliT7z0NqOzmz3KCIoQPrmgcn
         QRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693381448; x=1693986248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KaI3PfD8joR99TjMB7Mb3TjzWqZ8IotMwduAcjhk/lk=;
        b=YhGdIU0JR26B5CydR3A9vwD0oty1BCgJiQ+e0+hhigPNKWel8jQTXLm3rh/tJwMZ9M
         9tPVJhVb3kdmycjwTPNfbnqUllIC+J0xPK9yYvdPDVqVg9SvDgkgdik8Zs2ixLzhSKzB
         zIAYFjxIjb8Ag/c7zSOqarTAq5lgPgBRn/22d6yUdoWI1YRcIzddgkiRnOwxewx1FRtM
         S5cWoiObxr78V68JknP9JilkJn6ej7ZuWqF2LpklMHUmKmWkXMRoMV+mSQBKPTBTcFvF
         KPO1gDPcqrT0ZQA7XLBm95HGxM2OUn6q+Vq9P6Md8NO1OvR8uCtwhNCCJgasMJbQZp3q
         UZsA==
X-Gm-Message-State: AOJu0YwKsgRd+TXnTe8XhBb7p00eonVHCFyZs23QxRG1Xkf+cDRIO4AN
        DkDg9ZlXjzGpUQrFzDc6qcs=
X-Google-Smtp-Source: AGHT+IGaQ4P8EvC7PlpIhxszpNMfsVh9XWh9SaGCCo1nYYOFuxiN9tKA8ohVp4yCvqqpSXyx313liA==
X-Received: by 2002:a05:6a21:7784:b0:14d:f41c:435a with SMTP id bd4-20020a056a21778400b0014df41c435amr1839509pzc.39.1693381447705;
        Wed, 30 Aug 2023 00:44:07 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1033:772c:a5cb:ea8f:e44:ec54])
        by smtp.gmail.com with ESMTPSA id i19-20020a170902eb5300b001b8b26fa6c1sm10467189pli.115.2023.08.30.00.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 00:44:07 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     hverkuil@xs4all.nl, mchehab@kernel.org, slark_xiao@163.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>,
        syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com
Subject: [PATCH v5] media: gspca: cpia1: shift-out-of-bounds in set_flicker
Date:   Wed, 30 Aug 2023 13:14:01 +0530
Message-Id: <20230830074401.7696-1-coolrrsh@gmail.com>
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

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

Syzkaller reported the following issue:
UBSAN: shift-out-of-bounds in drivers/media/usb/gspca/cpia1.c:1031:27
shift exponent 245 is too large for 32-bit type 'int'

When the value of the variable "sd->params.exposure.gain" exceeds the
number of bits in an integer, a shift-out-of-bounds error is reported. It
is triggered because the variable "currentexp" cannot be left-shifted by
more than the number of bits in an integer. In order to avoid invalid
range during left-shift, the conditional expression is added.


Reported-by: syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/20230818164522.12806-1-coolrrsh@gmail.com
Link: https://syzkaller.appspot.com/bug?extid=e27f3dbdab04e43b9f73
Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
---
v1->v2
Changed the patch. Instead of avoiding shift operation for invalid
input of 'exposure.gain', throw an error for invalid range.
v2->v3
Changed the commit message details
v3->v4
Removed the trailing spaces in commit message
v4->v5
Replaced the hardcoded value with inbuilt macro
---
 drivers/media/usb/gspca/cpia1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/usb/gspca/cpia1.c b/drivers/media/usb/gspca/cpia1.c
index 46ed95483e22..5f5fa851ca64 100644
--- a/drivers/media/usb/gspca/cpia1.c
+++ b/drivers/media/usb/gspca/cpia1.c
@@ -18,6 +18,7 @@
 
 #include <linux/input.h>
 #include <linux/sched/signal.h>
+#include <linux/bitops.h>
 
 #include "gspca.h"
 
@@ -1028,6 +1029,8 @@ static int set_flicker(struct gspca_dev *gspca_dev, int on, int apply)
 			sd->params.exposure.expMode = 2;
 			sd->exposure_status = EXPOSURE_NORMAL;
 		}
+		if (sd->params.exposure.gain >= BITS_PER_TYPE(currentexp))
+			return -EINVAL;
 		currentexp = currentexp << sd->params.exposure.gain;
 		sd->params.exposure.gain = 0;
 		/* round down current exposure to nearest value */
-- 
2.25.1

