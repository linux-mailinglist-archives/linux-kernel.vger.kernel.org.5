Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAB37DB46D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjJ3HgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjJ3Hf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:35:57 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDB1BD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:35:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afa77f9a33so28138037b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698651354; x=1699256154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+7qdvEqH9UQsG0XvkLdIs7iHiJPjbaVFxlERbYdwdFA=;
        b=yGlGjCtzcTwGQw5JyaI6KGo0AWun2Q8LefN3Yl1A7nL/t1Bcpf20YlYdVF/NntJL7r
         JgCDQxAI6daFerTQlw1rjltEjj+xiM5kCWHHqlgqshfXtW7lzCu5we95ByeML6rEGdLM
         qLgguYIuAhBEg/1ANr1a8zcmrB4BGe1h6uRo9BGvPc2lFBrTOGLUT6R6LMVPon4bp3yU
         6ZnLKVWXG+xhKZrzoCKKPC46l6WM7RovGNhCfTGe+JzIjDg4JfFi02goqLlBC2SnvoQy
         zy0oD/QsWX2ReMOtGiejPqRiLHba+o+XsUOK3QCb1Xk3F2q8wsiK7ya/cj5ZbxR9X1Ze
         cKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698651354; x=1699256154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7qdvEqH9UQsG0XvkLdIs7iHiJPjbaVFxlERbYdwdFA=;
        b=qIGz8TGeeOBpZh0oWtXSgUnIaEJcRcmmSvwB3mZn7tGz85seHDRalVanQni2EoJ+MK
         bDdJjgr97sU/JAX9vEUo4LjIgQ3TFdhErNQXkXvjT4SK/hJO7wEXNdIqDvl1lptaeniD
         EyvMBMEP89OVrVKaqOvLoENTmWP/JG9U4XmP2ify99x5O8SwyVJ/r8uIY8B0AwwY4iqI
         sYTjgSSdW+EzhPwlLWcqv9q+MF1Iu7dlq+Z4dLZm/6YCHGbjSmvqUy4DI3Yk7A2hXjGA
         1JZ8FfzoUZv4PxEonj3cJfAMr12ekP72jYNLp1wsO5CVs1nRA1t7CsMC7sVg55hTS4N0
         v4jw==
X-Gm-Message-State: AOJu0YxeMkB86smQfLPoPVtefs8xQnQvV0b02mEegppCvCUYX3/PhfOY
        cYcBhO8cCO81vqhSrSgRVpvTNz11WvRdaStXNvb3
X-Google-Smtp-Source: AGHT+IGGMn7WMwzw88OqfixdLw4Ao7PBRbYTEGPedxH7JeJpUjbQjZTP62q2ukCPPrUZJ3e0E/0aiLvOHbvQYJeo9uGI
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a81:6cc5:0:b0:5a7:ad67:b4b6 with
 SMTP id h188-20020a816cc5000000b005a7ad67b4b6mr174772ywc.2.1698651354698;
 Mon, 30 Oct 2023 00:35:54 -0700 (PDT)
Date:   Mon, 30 Oct 2023 13:05:41 +0530
In-Reply-To: <20231030073542.251281-1-vamshigajjela@google.com>
Mime-Version: 1.0
References: <20231030073542.251281-1-vamshigajjela@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231030073542.251281-2-vamshigajjela@google.com>
Subject: [PATCH v5 1/2] serial: core: Update uart_poll_timeout() function to
 return unsigned long
From:   Vamshi Gajjela <vamshigajjela@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>,
        Vamshi Gajjela <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function uart_fifo_timeout() returns an unsigned long value, which
is the number of jiffies. Therefore, change the variable timeout in the
function uart_poll_timeout() from int to unsigned long.
Change the return type of the function uart_poll_timeout() from int to
unsigned long to be consistent with the type of timeout values.

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
---
v5:
- no change. Consistent version for series
v4:
- author name in capitals to lowercase
v3:
- updated description
v2:
- unsigned long instead of unsigned int
- added () after function name in short log
- updated description

 include/linux/serial_core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index bb6f073bc159..6916a1d7e477 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -773,9 +773,9 @@ static inline unsigned long uart_fifo_timeout(struct uart_port *port)
 }
 
 /* Base timer interval for polling */
-static inline int uart_poll_timeout(struct uart_port *port)
+static inline unsigned long uart_poll_timeout(struct uart_port *port)
 {
-	int timeout = uart_fifo_timeout(port);
+	unsigned long timeout = uart_fifo_timeout(port);
 
 	return timeout > 6 ? (timeout / 2 - 2) : 1;
 }
-- 
2.42.0.820.g83a721a137-goog

