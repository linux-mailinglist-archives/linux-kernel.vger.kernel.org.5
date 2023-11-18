Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A91D7F00B2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjKRPxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjKRPwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:52:53 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490D81BE7;
        Sat, 18 Nov 2023 07:51:42 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a87ac9d245so33495957b3.3;
        Sat, 18 Nov 2023 07:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322701; x=1700927501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xU0+DezQv+68hocsYMOkgL5EeuD6VUR6bUdseKeBvTQ=;
        b=dZ2UyIN3A4I+uz+Sprjt0VFFj2X1jLL9nuNKSLztr7npWIr2Wwr9XCrUOUNsY1qTds
         8rkTbFjknSc3F3dFcBOhd5maeRBv1jYrtfv+w7Frs5L8gaFvgskYcb/P54v5XX/oVTaJ
         ZG7qKLROTfnDkmDrjNJNThlmazWaAfYEzaIQWmd0F0NOkmc5gpXXb2gke5lcxNMMm/4w
         7i5nlsgTGGT13TELNRctEnXItDifjQ9UB5GHshV5gb/vX06mZJPXZruDiK548QeTMO/5
         HPqXXnvTfTmaJO5Lmni60R+eYQv5LvUokaPYhqVYbvjFUPLz0aEEMOZ1yfBZ/rHPERmE
         qDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322701; x=1700927501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xU0+DezQv+68hocsYMOkgL5EeuD6VUR6bUdseKeBvTQ=;
        b=I7jo1eXBOJcRH97wbiZI+Ts0zwaq0W9hUk4s4hLhYqrpNTCyBR4EmlGt/WYW80yce3
         1OrctUM1MXyBpR7W+Is9pVVRom40yohTbH0yzZTSzaXKqZGfs13nQPITLFgHf7XzVSiT
         wgl7EYTlXu/MkLXCVW5vOTs2uhb+PNM9pD1HwW3CPYv1k5I0RfPNKZSqLhI6cn+BscDo
         t/aiFLdYeJpjNO/visorZ8IpJYV8+nWNB8+yDpoaiAlrRNa3+y4vH2JzNA15Assa3cri
         XuBKpxEGkyh8om7yv0s315DzvTSoiyQyAZyrVnS/pDGcOAj3SsqHe0GP13GVTfUdpT9I
         P1wA==
X-Gm-Message-State: AOJu0Yx+LLJpqYnfAeNVJwbUaW9IEnzim3iiyZlD05ZYoXL1F4W/s8uH
        YaG37nntgUQXGKqu0SVtugTfuYJURxhTuhKq
X-Google-Smtp-Source: AGHT+IG6nIXVYrYe/pryLJVqS9YCy2pJ5nYZyS8QkV+6BipP7usnXBp+kFRkjKxXiPygV0miOmYDaA==
X-Received: by 2002:a81:928f:0:b0:5ad:47ba:fa43 with SMTP id j137-20020a81928f000000b005ad47bafa43mr2864475ywg.35.1700322700888;
        Sat, 18 Nov 2023 07:51:40 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id x188-20020a8187c5000000b005af958bb2absm1157374ywf.109.2023.11.18.07.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:40 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 21/34] usb: cdc-acm: optimize acm_softint()
Date:   Sat, 18 Nov 2023 07:50:52 -0800
Message-Id: <20231118155105.25678-22-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
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

acm_softint(), uses for-loop to traverse urbs_in_error_delay bitmap
bit by bit to find and clear set bits.

We can do it better by using for_each_test_and_clear_bit(), because it
doesn't test already clear bits.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/usb/class/cdc-acm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index a1f4e1ead97f..8664b63050b0 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -613,9 +613,8 @@ static void acm_softint(struct work_struct *work)
 	}
 
 	if (test_and_clear_bit(ACM_ERROR_DELAY, &acm->flags)) {
-		for (i = 0; i < acm->rx_buflimit; i++)
-			if (test_and_clear_bit(i, &acm->urbs_in_error_delay))
-				acm_submit_read_urb(acm, i, GFP_KERNEL);
+		for_each_test_and_clear_bit(i, &acm->urbs_in_error_delay, acm->rx_buflimit)
+			acm_submit_read_urb(acm, i, GFP_KERNEL);
 	}
 
 	if (test_and_clear_bit(EVENT_TTY_WAKEUP, &acm->flags))
-- 
2.39.2

