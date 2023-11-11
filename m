Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657887E8C96
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 21:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjKKU1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 15:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjKKU1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 15:27:03 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FFDD72;
        Sat, 11 Nov 2023 12:27:00 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32ddfb38c02so1877483f8f.3;
        Sat, 11 Nov 2023 12:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699734418; x=1700339218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bDn777LjiyZ8GAUT5k/ZqELGvfKeffJjqAcHYCvV4Gc=;
        b=YHyxIWmw8PYe7Ujeoa9H8C5qs6LdLveQiYmoFNA5dYMU8GmWEuCoh6TqDY20ndqQE1
         vDKNwvOr2y4fCYaEu2u7Gy/nfJnjRjLmzb1yr5gQeEUF3oaxIe7mWP7nfINtyCVTTg5j
         n4ANESgvWgAzdy+pPAU6vtmrPVvi4kJMciAy7LhG+N4Z58uYwOyX07uQwLAlCkJzhw4t
         eaGUiCIartZYxp/fjVOzjjGRXBeUpR2m8dQx4VFcXSuC+iFo2eV/Ez2Oh64ff4yyjLzb
         0n6/rndJbZ2DFPZgMImEobUtgP+VJ/8MEFf40fKH3KRuxyTtDiQfhlGmxwC5lI6JbE0L
         Kf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699734418; x=1700339218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDn777LjiyZ8GAUT5k/ZqELGvfKeffJjqAcHYCvV4Gc=;
        b=Eu5FdYHlwUgQcET6DV+reHQmBXWn6wg4Wys7veQ8ObOylaPt4AsYXPSrcK60XbXAqp
         1b0fxs3DpXNx6d95vaBBcYnMij5aTu8Pfcpc9dsUOZVYby2CbWnmlhdPtsmjqnDg0d7B
         UT94YWTV+5W2jAI4kc65hHiZCvl6W+omN1Pea33U7I14pEtNsna7JJoYN3/YFH9rd2ID
         /4/XY3YaDK66P665w0BsMjOhplXFf7V8mC80MUD8+TZ39dWhoMNSOiNFilg2zfu5QG6O
         wMaRDjuFd7/r+N3g60PhU0fmOUSS5HCCA2Ijj4VlDPfqhYd2X+2ap7NqbraIkye+hy6/
         +Fsg==
X-Gm-Message-State: AOJu0YzHN8EhhzT+/Q8DmTjibLUjVWyJ7+7HseH91abFXttwK0SRuDRq
        phxOKPQql5J16jijf8xHPjc=
X-Google-Smtp-Source: AGHT+IH2vnHUzi9+/+7nKNqLcoZVbpuHwJPql1ivHMOtCDo0akTE+5Hwy6kdXrqNvha3OyiK/om/Iw==
X-Received: by 2002:a05:6000:118c:b0:32d:ad44:cec1 with SMTP id g12-20020a056000118c00b0032dad44cec1mr2062106wrx.3.1699734418205;
        Sat, 11 Nov 2023 12:26:58 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h9-20020adffd49000000b0032d8eecf901sm2111432wrs.3.2023.11.11.12.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 12:26:57 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] USB: misc: iowarrior: remove redundant assignment to variable io_res
Date:   Sat, 11 Nov 2023 20:26:56 +0000
Message-Id: <20231111202656.339103-1-colin.i.king@gmail.com>
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

The variable io_res is being assigned a value that is never read, it is
either being re-assigned a new value that is read later or it's not used
depending on the cases in the following switch statement. The assignment
is redundant and can be removed. Cleans up clang scan build warning:

drivers/usb/misc/iowarrior.c:504:2: warning: Value stored to 'io_res'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/misc/iowarrior.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 1e3df27bab58..6d28467ce352 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -501,7 +501,6 @@ static long iowarrior_ioctl(struct file *file, unsigned int cmd,
 		dev->minor, cmd, arg);
 
 	retval = 0;
-	io_res = 0;
 	switch (cmd) {
 	case IOW_WRITE:
 		if (dev->product_id == USB_DEVICE_ID_CODEMERCS_IOW24 ||
-- 
2.39.2

