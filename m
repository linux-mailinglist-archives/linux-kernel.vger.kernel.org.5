Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FD3788810
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244925AbjHYNFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244993AbjHYNFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:05:03 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CCE1BF0;
        Fri, 25 Aug 2023 06:04:57 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf7a6509deso6658975ad.3;
        Fri, 25 Aug 2023 06:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692968697; x=1693573497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CoViU47zP7yqEj1KNAwCFxEy/0OkP50WBChNobdQpEk=;
        b=sQCeZG7uH3nYcY9GRHENnPT1vdy5VoPjMwd6NtQHIoP6NwKM//XPBwxEkhNWjdUpRD
         amDY6MEIj/UtMrkdHxEVjOVVRHBbkwlHD7FbSRbkUnX8jZbtq95YQux5rn/h9vpmSqPf
         eS0LWQ87xMkTd4xAhnS8oiYpsf3nVgmepuGx0Y2atVv1auCoVon0/sCk7+lVMzx3xUpJ
         AdjPa03Kf6n5TNvGhrl71La0H+Ttew+jjdiyyn9ybKY28K5zf+neUxFrBlD+r3rP9Zei
         nG1PQCLTBCwMd6C53KH/EeCaj73s+eqtZL0a9mSjvPrdXpWyNBqMkdTkmoKYxRpgEqvQ
         zwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692968697; x=1693573497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CoViU47zP7yqEj1KNAwCFxEy/0OkP50WBChNobdQpEk=;
        b=EN/o7IMYQVQYF+TY2phPikDsl1gnG5SVINXw5vCttNvUhU+c58FYN1ALEHHx3qXFuh
         OnigaHEzYC8Ir0gaGhBB6MpQo+I3MZnFXcg3TPR3mioMRZb/GUCut64W/Kq/oNtjz543
         q9YtRGu7K40ya1AJ4orwABMkgQeleBmz+5C/MBt2qpsho8Q2gCFabL63sV7vNz8KDq8p
         DE3zNU1yX3JTKBC+td9B3TY2ldceUrcMfE5hksenOMps84aNMjypktRsnJdgvQxoeoYs
         QEGN+nPlW9RU3mGbu2ylPAE87+oiJaPM4+QMnkO6XHS6S/rG5NMbepktdePWKWMynrmj
         RCuw==
X-Gm-Message-State: AOJu0YwuQuMSLdD520tGda8hm14CeLS5AxUmuu0mOf5Rp8KGsIdDLPbk
        1TxH8NPJGtIqw8pjndX/1SQ=
X-Google-Smtp-Source: AGHT+IEbTobU4DbNr3PSeZyqieW87FG8QQedMMZBFS8FhdmFZ42tpRGksnN8q1UwAmrTAvxAKmyBxA==
X-Received: by 2002:a17:903:22d0:b0:1c0:9bef:4bbd with SMTP id y16-20020a17090322d000b001c09bef4bbdmr11219724plg.14.1692968697146;
        Fri, 25 Aug 2023 06:04:57 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:100b:f444:c0d8:b853:252b:aa3])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170903049100b001b9d7c8f44dsm1638155plb.182.2023.08.25.06.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 06:04:56 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     hverkuil@xs4all.nl, mchehab@kernel.org, slark_xiao@163.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>,
        syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com
Subject: [PATCH v4] media: gspca: UBSAN: shift-out-of-bounds in set_flicker
Date:   Fri, 25 Aug 2023 18:34:50 +0530
Message-Id: <20230825130450.5287-1-coolrrsh@gmail.com>
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
Changed the patch. Instead of avoiding shift operation for invalid
input of 'exposure.gain', throw an error for invalid range.
v2->v3
Changed the commit message details
v3->v4
Removed the trailing spaces in commit message
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
+			return -EINVAL;
 		currentexp = currentexp << sd->params.exposure.gain;
 		sd->params.exposure.gain = 0;
 		/* round down current exposure to nearest value */
-- 
2.25.1

