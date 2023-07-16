Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4CD75589D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 00:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjGPWiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 18:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPWiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 18:38:14 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D681B8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 15:38:13 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7672073e7b9so265460885a.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 15:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689547093; x=1692139093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y3TDuYSgYiiRhqCEjzbwHrr/s0j0cJsJcXGsxFIFGbo=;
        b=WG4kSJe+gXFk4Zwnf8e5MNtmyrP5jstJ1thI17hY7HiosWX+G3IuzRsByYDEX0k4Cw
         sVT01Q07UMUk3oMgAg4suOmLmfbAaGOTdxQGTHBW0mKu/txUdreCaY6IjPvV3FpktrS/
         FindJCHbeVHdJqaQRNItpsAyYIgptU4q2fTshTINUEmwSHFKf2WPTvJpRUgPfKhvsVJR
         ZGC02GwMdOLlRzcc7sNq3j4mTqWC5AoCW+UngZ3T+gamby+kSGgwsijUR3fqGQ4UV52I
         i+GayPe9GfWsRgbR3wnjolFgfBvNpWnhQnf/xvpbfcMjIuP5uIGxKpR1ZL6V+kBAlEQm
         OHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689547093; x=1692139093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3TDuYSgYiiRhqCEjzbwHrr/s0j0cJsJcXGsxFIFGbo=;
        b=SA9dlZvjyyrxX2GW4dJzjS5co7NeS26TJ9mdGV+9Af7VMX5bCFR6VQxW1weVxEk4xk
         8eTQY9NpMcKE8ehmH0EefaevanbJXubq53sLnMUePzhlS/qJtMqw6LlPRBkGIHrBsJ6j
         KExTA9Vw5vvKMwknXBEws6mBunEu5cEWIGEcUnMkfL5P8qZc8i2Q3k8ZzAkTz82jZxco
         EayHJWGk59EG9FcQ/S4fdzNkImVOSL8380X0cpAwHha7u7pfu/Ymn56OgnadhhwLcwhe
         NXSQgmZtwq3KVIPcZF3oQ1qUcN6JFNvvrOGxHMJgp3/wgbDzJZkrgAoB4qwoUi+OufQy
         214A==
X-Gm-Message-State: ABy/qLZaUy7QStU+IxH+qmN3riHNj9wAAlDRTL3+cJkjOc9ihaF+AdUS
        /AZWdSlRDyRLbXSHb3LRz/4=
X-Google-Smtp-Source: APBJJlHlAZq3+RHOmjEsNjMTcfiaJ0e3QwfTTHe3vwPY3S7KzhlSUZbtirpUKQOEHjQq3NoMesvz9Q==
X-Received: by 2002:a0c:e314:0:b0:637:ae7a:798b with SMTP id s20-20020a0ce314000000b00637ae7a798bmr8478329qvl.57.1689547092786;
        Sun, 16 Jul 2023 15:38:12 -0700 (PDT)
Received: from localhost.localdomain (c-73-236-155-147.hsd1.pa.comcast.net. [73.236.155.147])
        by smtp.gmail.com with ESMTPSA id s4-20020a0ce304000000b00636b3519467sm5940479qvl.54.2023.07.16.15.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 15:38:12 -0700 (PDT)
From:   Cyrus Ramavarapu <cyrus.ramavarapu@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     Cyrus Ramavarapu <cyrus.ramavarapu@gmail.com>
Subject: [PATCH] staging: rts5208: Correct line ending with '('
Date:   Sun, 16 Jul 2023 18:38:11 -0400
Message-ID: <20230716223905.2187-1-cyrus.ramavarapu@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Adhere to Linux kernel coding style.

Reported by checkpatch:

CHECK: Lines should not end with a '('

Signed-off-by: Cyrus Ramavarapu <cyrus.ramavarapu@gmail.com>
---
 drivers/staging/rts5208/sd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
index 4b7122add51a..74c4f476b3a4 100644
--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -4501,8 +4501,7 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			sd_card->sd_lock_notify = 1;
 			if (sd_lock_state &&
 			    (sd_card->sd_lock_status & SD_LOCK_1BIT_MODE)) {
-				sd_card->sd_lock_status |= (
-					SD_UNLOCK_POW_ON | SD_SDR_RST);
+				sd_card->sd_lock_status |= (SD_UNLOCK_POW_ON | SD_SDR_RST);
 				if (CHK_SD(sd_card)) {
 					retval = reset_sd(chip);
 					if (retval != STATUS_SUCCESS) {
--
2.41.0

