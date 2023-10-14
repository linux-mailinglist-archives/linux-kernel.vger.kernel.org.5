Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA677C942E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 12:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjJNKuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 06:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjJNKuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 06:50:03 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C273AA2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 03:50:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b5a586da6so22474137b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 03:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697280601; x=1697885401; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rhmpXagUV1Eroi8NsqxMkQ7rrh98dWj1q7PH6sEyJW0=;
        b=wcNgefQ4O/Qa+X1vZ1a6Prnxsn9zQBeunBJaQVtybAUSD8Ps2zSAkmGhgoLYdg1Znm
         MBHVq+P9Hfg0Ib/V59SJqAPgIGvaDLmsx70bCwly+H9Ackta0hUpZh/u4lY3tqQT1enm
         7v23y44PpSgJ6aKqzw1kDF4fJZ63fEkKeIy8YePGLs4ynhRQU80+NLd0qPdQAZ840esq
         WzPgKxEMgxNdPlW6FW9apro65szce1bKLo3cPshn5D4rJSkHRiAFFHrshRTmWwRn3hsT
         f9PHGjyVLLywrlKJTJJupeiNl3peIEdWhzUGz18819QmQMP6Le8w8R9ZL0znau7WGThl
         AJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697280601; x=1697885401;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhmpXagUV1Eroi8NsqxMkQ7rrh98dWj1q7PH6sEyJW0=;
        b=Voo9oPiuazxX4aQmojKiYY1j4mRGfKcgIX9PA//P5oXtuxaWm4RVh6AEchSBHC5fni
         8Ad41tS2bZ2t/VXWmhQIjU/D4J0HPffYw+AfuLHjReTU7iMkXRVkBmgdnx4lCzfQpCQW
         1Gj9MQakhPxLRBBgdVkNv3wtlP8oW/bGJbmJosLBDc2EiWEoGN8yF5mjwweeJ+B7Ad2u
         FskOIA4qgOC/q0fURemb8XXW/GBvymmBF5/cokO3MvFNdpu40J3Ikv0Vau5FV0rsI7tC
         TaYrr54JxDs2vSZiTi0aQX24uCz5lWvgu5OLCZyHywDqE0eDb0UQUYo4wZX3GmtgcIrs
         C2WA==
X-Gm-Message-State: AOJu0YyRTQ2RDSQCfDC3KWYpr5mKCfkGOYw9v5wScmEdXyhbP5mLLQzx
        PxtfclwKvnaqZJR0DVmZLcJb+UZURQLWJuNjnvxl
X-Google-Smtp-Source: AGHT+IE7JZZ8b+8I6w6WItkOzFEAzTGjgqr1rbZmCGJsOmyu9ORRrodargaaM+oO4bTNb44PEYUzZ9P0mZecR3ZMsH62
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a05:690c:368b:b0:5a7:a731:3360 with
 SMTP id fu11-20020a05690c368b00b005a7a7313360mr88331ywb.2.1697280601060; Sat,
 14 Oct 2023 03:50:01 -0700 (PDT)
Date:   Sat, 14 Oct 2023 16:19:40 +0530
In-Reply-To: <20231014104942.856152-1-vamshigajjela@google.com>
Mime-Version: 1.0
References: <20231014104942.856152-1-vamshigajjela@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231014104942.856152-2-vamshigajjela@google.com>
Subject: [PATCH 1/3] serial: core: Potential overflow of frame_time
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: VAMSHI GAJJELA <vamshigajjela@google.com>

uart_update_timeout() sets a u64 value to an unsigned int frame_time.
While it can be cast to u32 before assignment, there's a specific case
where frame_time is cast to u64. Since frame_time consistently
participates in u64 arithmetic, its data type is converted to u64 to
eliminate the need for explicit casting.

Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
---
 include/linux/serial_core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index bb6f073bc159..b128513b009a 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -558,7 +558,7 @@ struct uart_port {
 
 	bool			hw_stopped;		/* sw-assisted CTS flow state */
 	unsigned int		mctrl;			/* current modem ctrl settings */
-	unsigned int		frame_time;		/* frame timing in ns */
+	unsigned long		frame_time;		/* frame timing in ns */
 	unsigned int		type;			/* port type */
 	const struct uart_ops	*ops;
 	unsigned int		custom_divisor;
@@ -764,7 +764,7 @@ unsigned int uart_get_divisor(struct uart_port *port, unsigned int baud);
  */
 static inline unsigned long uart_fifo_timeout(struct uart_port *port)
 {
-	u64 fifo_timeout = (u64)READ_ONCE(port->frame_time) * port->fifosize;
+	u64 fifo_timeout = READ_ONCE(port->frame_time) * port->fifosize;
 
 	/* Add .02 seconds of slop */
 	fifo_timeout += 20 * NSEC_PER_MSEC;
-- 
2.42.0.655.g421f12c284-goog

