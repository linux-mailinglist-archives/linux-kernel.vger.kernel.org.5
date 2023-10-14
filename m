Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5897C9432
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 12:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjJNKuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 06:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbjJNKuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 06:50:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC104DC
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 03:50:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a60a104b6so3442602276.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 03:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697280615; x=1697885415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYCXn3ElgcmgyYLbM76CHob0tkZSwXwvOlTaEhXB7SM=;
        b=etTkr53JSOwwe+9PYrUPt0fKjQzkeRwQurPJYvFu50+iJS82nIAp2OZH0BGPIDKSte
         wzXIM+FLJpCsDRsWttk2BJWWujVK9/25j6b156OUkm048163j6yefEzyTrg+qveQQYqC
         3Qg07eYL9toqsF4l6ffl3K25Mz18P4/JFfUWjSnYCIzmHmLINxv2WZ8o9kgb76HyQLDt
         p2sMbBJWwGReTttyu+gJPJc5DmMCGzClQWa+oimYx2iFZ1taBk2haJvLSKb5zS4qQKQO
         X1o6zQ93FKkn8PEDfJDF+d0DzMp4Y9SD0YAS3aCq9erFGKfAnMhDXYBPKmjat7aCtStn
         sxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697280615; x=1697885415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYCXn3ElgcmgyYLbM76CHob0tkZSwXwvOlTaEhXB7SM=;
        b=QXty7BfR8A1B3N5FoE0N2ZwphWOWIQxzMMU9JBFtbMbM/Fcfd2mWU2zyCFqNfB5k4J
         t047yxCxE6a+7sCjhbeoHz5vsF+e0qbJWmZeGJug+WVjrvZVQKAtR5ZCN+mUPFE1+Q7A
         QHsHm/b3ByV2K/teIvwRn60X5O1TZ1LevuQE+IxfjzXRHd5L8k6qQ5D2aEf14Lssye9O
         fnHFVcTWfGaIMRQWcN3ae58vdUbDtnWi5wusLf2c5eSKChtlRSCz/igaMY56dOeQdztN
         XBbOF3a5aj6y3EI0cEauv4eIl6oiMLIZqDC2klMs//xryeB0gIONTGnbDoOK09VIE8C3
         EuTw==
X-Gm-Message-State: AOJu0Yx711c1AVl7CuX0a3TrxGJK9FDGLGQOBLr3w5YOJwOlo73aWhCw
        UG19ZB89GUrd2FkC+eXwXgEWUKGIXqvKwWy58qHX
X-Google-Smtp-Source: AGHT+IFVE7RAEJUGf8YGFcAVvRgkulAAOaL0R9FyNAXbNStbKMo++OMbut/K3NfJyNBOOqWXBW0gNNZv5PLmsODNykx3
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a25:aa83:0:b0:d8a:fcdb:d670 with
 SMTP id t3-20020a25aa83000000b00d8afcdbd670mr78496ybi.1.1697280615084; Sat,
 14 Oct 2023 03:50:15 -0700 (PDT)
Date:   Sat, 14 Oct 2023 16:19:42 +0530
In-Reply-To: <20231014104942.856152-1-vamshigajjela@google.com>
Mime-Version: 1.0
References: <20231014104942.856152-1-vamshigajjela@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231014104942.856152-4-vamshigajjela@google.com>
Subject: [PATCH 3/3] serial: core: Update uart_poll_timeout function to return
 unsigned int
From:   Vamshi Gajjela <vamshigajjela@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>,
        VAMSHI GAJJELA <vamshigajjela@google.com>
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

From: VAMSHI GAJJELA <vamshigajjela@google.com>

uart_fifo_timeout() returns unsigned value, hence the function
uart_poll_timeout has been modified to use an unsigned int type for
timeout values instead of a signed int. The return type of the function
has been changed from int to unsigned int for consistency with the type
of timeout values. The result of uart_fifo_timeout() is cast to u32,
indicating that the value is truncated.

Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
---
 include/linux/serial_core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b128513b009a..445a1ff7e502 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -773,9 +773,9 @@ static inline unsigned long uart_fifo_timeout(struct uart_port *port)
 }
 
 /* Base timer interval for polling */
-static inline int uart_poll_timeout(struct uart_port *port)
+static inline unsigned int uart_poll_timeout(struct uart_port *port)
 {
-	int timeout = uart_fifo_timeout(port);
+	unsigned int timeout = (u32)uart_fifo_timeout(port);
 
 	return timeout > 6 ? (timeout / 2 - 2) : 1;
 }
-- 
2.42.0.655.g421f12c284-goog

