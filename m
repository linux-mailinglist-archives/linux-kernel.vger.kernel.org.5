Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462407838D7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 06:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjHVEer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 00:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjHVEeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 00:34:46 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4A3184
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 21:34:43 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a81154c5f5so2777632b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 21:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692678882; x=1693283682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I/B6vSrfqQkHZ9MGnWavpPlid0LaCXX9sTu7mRh3O40=;
        b=CSsvM8hp3zvOhZ7qiYO2s6YUw1K8nGMdYE2Uzxl0HaavaRsv77ln3r5n2G5ISifKpA
         hebPnxsOLxQ3SjeysWxYOAVDiLwb61VMKn61shKH94GEJkHUlYvsrYY6sKO4x15eHSMB
         uarrQmG2qmxHU14g6et8c2XSmyn3r6tJ8o6kmuItlQgRZqugoiBgtTKGoxJCpjvmllJW
         r6w7wbPTbuKF0hSk4EG6xf7nivvkWP2I2xXgZVv1AiGOqOwn/jqiH8T5ASns1FvV9E+b
         JzA8VGaLp/3zvmcAAqcCH7jTMeLxZmADd4AjFq3j6QYuLcLfKXLh1hznSWtnYEFDOxYb
         KHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692678882; x=1693283682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/B6vSrfqQkHZ9MGnWavpPlid0LaCXX9sTu7mRh3O40=;
        b=d7iPKAcavJDLtHFTE/MxtN97q8voNfqN6LII0tFgvrM5mT/krQuIpKC7aFTPqwWJ6k
         TbCoxCxvEa+19pRtcJvppWNbOJtDPw4HMgZmgafZ0Z8PhGrPHjrnv8BOkoyInu3BbCPt
         v590MDwzTjM6rbDH/hnvAB7hKVYarZ3jqs8tMEtVVDdT0/lSXA7h7WnvrBk+JbEq/LaV
         ocwfMXtOyyNl39AyHJ+Nz+Z5OwxsQOoJDmGuIKYBEfK37RMxHdSjHCM6WD+jp9J6NpjM
         kknKQoVxqHwwTv0lZmHBAot+hjztHvDpjeSO9E99lGggpzn2IIm9xI3bCC2cu8mX6SuU
         KGYA==
X-Gm-Message-State: AOJu0YwRgq0T3+bNANa9zuUJgo7Rw+j1p7loLskUmxB/P8ACEAX4eVy0
        6dB7k5Mc6wmFhj3haFsdV0yyc0uIFxk92w==
X-Google-Smtp-Source: AGHT+IGfkVNEJkRALtoo5l+ZFeQlBOR5Jv8a61+OQq8fWc5wxHXxbi1m3M88hFXxMvz0I6Qipj9a1w==
X-Received: by 2002:a05:6808:408d:b0:3a7:470a:e702 with SMTP id db13-20020a056808408d00b003a7470ae702mr8893825oib.16.1692678882647;
        Mon, 21 Aug 2023 21:34:42 -0700 (PDT)
Received: from XHD-CHAVAN-L1.amd.com ([103.115.201.73])
        by smtp.gmail.com with ESMTPSA id a17-20020a17090abe1100b0026b76edd607sm6959365pjs.15.2023.08.21.21.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 21:34:42 -0700 (PDT)
From:   Rohit Chavan <roheetchavan@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] staging: axis-fifo: fix alignment of open parenthesis
Date:   Tue, 22 Aug 2023 10:04:26 +0530
Message-Id: <20230822043426.1966-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Fixed all CHECK: Alignment should match open parenthesis
as reported by checkpatch to adhere to the Linux kernel
coding-style guidelines.

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 727b956aa231..d0ca82a755e4 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -381,7 +381,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		 */
 		mutex_lock(&fifo->read_lock);
 		ret = wait_event_interruptible_timeout(fifo->read_queue,
-			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
+						       ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
 			read_timeout);

 		if (ret <= 0) {
@@ -522,7 +522,7 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		 */
 		mutex_lock(&fifo->write_lock);
 		ret = wait_event_interruptible_timeout(fifo->write_queue,
-			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
+						       ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
 				 >= words_to_write,
 			write_timeout);

--
2.30.2

