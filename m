Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229B5765A98
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjG0RkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjG0RkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:40:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE9BD9;
        Thu, 27 Jul 2023 10:40:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso13801255e9.1;
        Thu, 27 Jul 2023 10:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690479610; x=1691084410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vm0hSF63AJjNABtvNsjawRxsPZnGdoadnD63dXFyEDM=;
        b=Ff2d1S0oErgHRpjDgvPd5pgl+pv8TT24oUFTO0FDFso5x+0BX2ZijGrgNwNXnCvzsI
         QlPCFCav09nxJB7Ds9PGNv2IdfTTza8CVrqc7xb42bOputCRiSc6J1D2S0zgPRhvuruc
         jSgKb6nM9koO5S2oZjCjKykH+qS4cdEqRWvZ4gRwNnOpuJF6roTm7VK+mxVBIJnvzTlH
         3sLmtvCWB0+Muy1IL3jvx8lgfF21PIlLHeen/JO9RqNAeToeg1ypykVMvcft48sRrP1B
         MJLFX6/kEI/MN+grpINzG/+1T2BNe9rySrR2MwbF7ltgAs9zfGKBIz5RR+313tSZQQQk
         Jzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690479610; x=1691084410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vm0hSF63AJjNABtvNsjawRxsPZnGdoadnD63dXFyEDM=;
        b=lPxlSQeDjoQ/awmG2o4pPwY2hxL2C41pW4jTYBKbpWoIawUp9AU3oI/D96rffGdArN
         3rGRgR2WcfV4HMOHEWGhocPmwu9Y+d1gowHw1RL+DJN79YDuW5pI8cNUPvf6wULv/M5q
         5IdF7wyVtWVc7V76pzQZIZ+ypl3ObauCEqoP0sxeTDvDPTAdjjcH8XjAiuDAnSClGoMD
         ZzXB2za4WVbu6ZyOiaw5PZq9pTqu319mAVvamM0wBhe+KVbnYby2mRqWHTzyefWguR5u
         tUxWZwINJryHivtZU0DYUSBTHqxsVdT8PBL25vTTl9E+UQjeGWjaNeWYn7JeSgaj0FV2
         olaw==
X-Gm-Message-State: ABy/qLZ6z4OjstzKO0OJOh+1nJwezLdbQJk8HuITcZ+7jTIATEHDTjEN
        fuf066YX1iG/jNiOZLWWn0EwpQh7qP79BQ==
X-Google-Smtp-Source: APBJJlHc2w6sCUiG+DIW9ehHlUyBy4YgfHUYrF3BYticU2IXTL8gQsGe1A0YAEzh5iTKl8d1WM4Rwg==
X-Received: by 2002:a05:600c:3789:b0:3fb:fa61:a4ea with SMTP id o9-20020a05600c378900b003fbfa61a4eamr2276514wmr.11.1690479609421;
        Thu, 27 Jul 2023 10:40:09 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c378c00b003fc0062f0f8sm2400003wmr.9.2023.07.27.10.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:40:08 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] [media] go7007: Remove redundant if statement
Date:   Thu, 27 Jul 2023 18:40:07 +0100
Message-Id: <20230727174007.635572-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The if statement that compares msgs[i].len != 3 is always false because
it is in a code block where msg[i].len is equal to 3. The check is
redundant and can be removed.

As detected by cppcheck static analysis:
drivers/media/usb/go7007/go7007-i2c.c:168:20: warning: Opposite inner
'if' condition leads to a dead code block. [oppositeInnerCondition]

Fixes: 866b8695d67e ("Staging: add the go7007 video driver")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/usb/go7007/go7007-i2c.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/usb/go7007/go7007-i2c.c b/drivers/media/usb/go7007/go7007-i2c.c
index 38339dd2f83f..2880370e45c8 100644
--- a/drivers/media/usb/go7007/go7007-i2c.c
+++ b/drivers/media/usb/go7007/go7007-i2c.c
@@ -165,8 +165,6 @@ static int go7007_i2c_master_xfer(struct i2c_adapter *adapter,
 		} else if (msgs[i].len == 3) {
 			if (msgs[i].flags & I2C_M_RD)
 				return -EIO;
-			if (msgs[i].len != 3)
-				return -EIO;
 			if (go7007_i2c_xfer(go, msgs[i].addr, 0,
 					(msgs[i].buf[0] << 8) | msgs[i].buf[1],
 					0x01, &msgs[i].buf[2]) < 0)
-- 
2.39.2

