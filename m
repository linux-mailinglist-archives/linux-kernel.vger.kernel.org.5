Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4177C6DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378478AbjJLMNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347214AbjJLMNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:13:39 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8455B8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:13:37 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50435a9f800so1265529e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697112816; x=1697717616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVofpk94WCg/ueIpWywY+mApBR+nkRgqe3Q79vu2RjU=;
        b=AQOEU5qxfqYcIMrL/0qlcbOX053RErSINHMVZWlwOKqD2JD0Fh52w0o8A1l+Gh0xVi
         uk7RRlgyjiy2Xiu13b6OqU7ODKEeNXGd44KCjsJlNEzHCq5t4QiLGVSDpiEIkOo1xzF5
         gLSKb+0O01wnj7l/pYnWH426kQDZ0R1NIXz3k28qIXEysrch/rAWy1SOpBLaxJM+Vp8z
         lZBoAJFGaxn4vf63i537YRITi4EtGwFYAh105ta+ZqKi+3wYJmxoTlJERWsY+L1ZNECH
         +2i2p5Zg/lpcuRwfVw4YXGNQiFgaUhAS3hpfJ++qP8Q67bBZ02XLYvWI00TGfmWZ0Yo7
         YTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697112816; x=1697717616;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVofpk94WCg/ueIpWywY+mApBR+nkRgqe3Q79vu2RjU=;
        b=cINL1RTG34ZJinePmhZze5+xEOlrWchlhAEGzH6FodOg9PtVPfdMeurx+wxvZecG+b
         KTmNLZ7uXoicKz/e9pwnqLUuDF1eqTPwoZwvAwJt0janxGVD6ElI0vwcbzkZ2/LByBp+
         kK+56mgWpXoPVs6vitD650yD4TuV8Ux+IvvK1HpXYuugAVc/WzHIN+AuzDnzICMWHrGY
         tnAwpAsTenF5iHIgelD8LNUJs4v99wlKsiekZzRrYsy65fOpZtoj+epFgCZWYL1N8GMG
         MVHjSM2bqInMGyrJpiSmycYSI7WvBhwftHNXXFasdmZfDoMRqTUOxmsmnHlSnnGpgzNR
         W/sA==
X-Gm-Message-State: AOJu0Ywqz7qkQG1IeZ5zo6atUKPXBgcLT1M1yBnFVSQkByMpxYRPvh6X
        tjPw0HtlC2GoVXNCF9NaLC930wBg/f1umdBB
X-Google-Smtp-Source: AGHT+IGmN+i0oRbSLI3w/xj7YZRnKL2XsVKxl9gdSLConKt7Dcf2g+IMjnmhNr+WEQ/xHuW+Uc272A==
X-Received: by 2002:a19:6d1a:0:b0:4fe:7e1f:766a with SMTP id i26-20020a196d1a000000b004fe7e1f766amr18495242lfc.24.1697112815697;
        Thu, 12 Oct 2023 05:13:35 -0700 (PDT)
Received: from GK0179 ([91.199.127.174])
        by smtp.gmail.com with ESMTPSA id v1-20020a056512096100b0050480e8a676sm2786794lft.268.2023.10.12.05.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 05:13:35 -0700 (PDT)
Date:   Thu, 12 Oct 2023 14:13:38 +0200
From:   =?utf-8?Q?Bart=C5=82omiej?= Konecki <bartekkonecki97@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] staging: axis-fifo: Alignment should match open parenthesis
Message-ID: <ZSfi8nPauVatDm3E@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix 2 checks reported by checkpatch.pl in axis-fifo.c
for alignment should match open parenthesis

Signed-off-by: Bartłomiej Konecki <bartekkonecki97@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 727b956aa231..ab758a527261 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -381,8 +381,8 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		 */
 		mutex_lock(&fifo->read_lock);
 		ret = wait_event_interruptible_timeout(fifo->read_queue,
-			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
-			read_timeout);
+						       ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
+						       read_timeout);
 
 		if (ret <= 0) {
 			if (ret == 0) {
@@ -522,9 +522,9 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		 */
 		mutex_lock(&fifo->write_lock);
 		ret = wait_event_interruptible_timeout(fifo->write_queue,
-			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
-				 >= words_to_write,
-			write_timeout);
+						       ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
+								>= words_to_write,
+						       write_timeout);
 
 		if (ret <= 0) {
 			if (ret == 0) {
-- 
2.39.2

