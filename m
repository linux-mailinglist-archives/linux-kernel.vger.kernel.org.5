Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5A27C9430
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 12:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjJNKuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 06:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjJNKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 06:50:13 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CE7FC
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 03:50:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a21c283542so46577907b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 03:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697280609; x=1697885409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I0MUXgCgPp7gRv8+WcNEgYQP5+7MSeABFPYxMKK1EzU=;
        b=FL36PbjdncuCHtvIiTjirmj8Y1uHygRUSEiSeK5NjGaW8kAni8c6BvB7VTxYgtO3GY
         mzzL1GlB7/TlqO/jV99WqnBvAt8nm1wBKYUwLZz1CiBCeD/oT8HQWTgtWKW0wzTNaqvM
         MKEh7aczALaYKVEMwOMq4hIrfdhPorxcAyvMV61i5+CCOIO86PbJG7EfkpWplE4GWkle
         3OHU1MyjtgDDdxc5GH6Uc7vOcMd7xT+w8Rm9gB733C0nYG1qf4YLn9jd9Eut/37YdaDG
         Lp7rlqLFOgoQ2pCRBuJMDkkNl+Fq8u1V0c9MLt3/+gP7odqA/QMl4AOSsUXYnHb9jmrK
         5u6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697280609; x=1697885409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0MUXgCgPp7gRv8+WcNEgYQP5+7MSeABFPYxMKK1EzU=;
        b=An8pw9e4FLTs01edXEoTirVQXY4HiS8DJ9hSJQsHIj7maEte+oSjvoa80S5VLKDRZh
         ryYXcJdIPlItK2220SOo0uHxNDvuJdqawRVHLy9xScis90IsJjaJTfm8UQoBHI6etU2A
         FlF7f2DEWvPT34e41MQoaESG0lb0XkE8CnpTTnwmnI7OCn4gZOmQhltMhjtSHLlI4zU4
         tViOiqtxzpC3ORmD30uPIZxAAZ2m5zCeio9/SI01+4b8Mj7XAZmuPLGCNN3qI/aWtgc1
         5k0eh+rUpAZzlp4F2+s8EggbcmkOZunq76RVh1xwOWHdQtYjCLGFsfMIpS2F5VqKDQ7e
         QudA==
X-Gm-Message-State: AOJu0YxT2Kgc2+iEMyLNDwchcJ+PGHrMN7pyFR72U2VKy/sHNsYXIE/6
        WULqxA6rlyIzEMekXe8OTVLYGML5jl9mHxYHrBTR
X-Google-Smtp-Source: AGHT+IECLjqnFxKwrfPtqN+hEWvDFTlsXiuek3R1asZ71+QVKuJMwQOlvflW0rK1xzYnt9ijnM15rGIZTBn4lcBdA8Wq
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a05:690c:4086:b0:5a4:f657:36d9 with
 SMTP id gb6-20020a05690c408600b005a4f65736d9mr522763ywb.9.1697280609769; Sat,
 14 Oct 2023 03:50:09 -0700 (PDT)
Date:   Sat, 14 Oct 2023 16:19:41 +0530
In-Reply-To: <20231014104942.856152-1-vamshigajjela@google.com>
Mime-Version: 1.0
References: <20231014104942.856152-1-vamshigajjela@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231014104942.856152-3-vamshigajjela@google.com>
Subject: [PATCH 2/3] serial: core: Make local variable size to u64
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

The variable size has been changed from u32 to u64 to accommodate a
larger range of values without the need for explicit typecasting.

Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
---
 drivers/tty/serial/serial_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7bdc21d5e13b..fb4696d17a8b 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -410,10 +410,10 @@ void
 uart_update_timeout(struct uart_port *port, unsigned int cflag,
 		    unsigned int baud)
 {
-	unsigned int size = tty_get_frame_size(cflag);
+	u64 size = tty_get_frame_size(cflag);
 	u64 frame_time;
 
-	frame_time = (u64)size * NSEC_PER_SEC;
+	frame_time = size * NSEC_PER_SEC;
 	port->frame_time = DIV64_U64_ROUND_UP(frame_time, baud);
 }
 EXPORT_SYMBOL(uart_update_timeout);
-- 
2.42.0.655.g421f12c284-goog

