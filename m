Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D68C7DB46F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjJ3HgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjJ3HgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:36:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06694E6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:36:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7ed6903a6so42309287b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698651360; x=1699256160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MJYRMGz5Km6YdZ6S41UQtlr9nImkATltc1KA9WGy+hA=;
        b=yI67vC9fqrQEeXKZsIIS1FL+y29Hx2GYVD96oofZiRfIwyPbry7HG7w5KQqvm8TtYG
         d2dYUpJfgL7nZvgsJ6Yvl1n1BfHIfd4NLC7l4tJG/E0n3XyBy1OHSXbqSkqejesnBgpS
         61OvFzVx+v9TH63rL/bOtCZ8ujOeDhVbnm1acE0YidnFr+AHx6SQUsHPv49k8j5Ky3a9
         PHGc+Iytv8PXBACnIPRGj/jc0x6jqXFQRTw0SfMz7GXFjAcPtc1NyPogYpRz3F/zEa3O
         7U70Pkr8/jjEBz3LeNu46vA7C7wt2ZJ9P39lWq7B6seQz+pITVm9jta4cmNPU0AGqs7d
         AGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698651360; x=1699256160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJYRMGz5Km6YdZ6S41UQtlr9nImkATltc1KA9WGy+hA=;
        b=iCdsLNxzp9OOvkk0cTjkzTCaRLmv9T0tulCB/mXVf5y1f5lJat+u7sSDJLohBpVqc3
         HOW5RWdf0Vx+4BLQndutlW3VgToG/ucxSUyynjPjJdwgOn6m2muuKcSbKB9sqNFZCQpo
         nc9SLSg7R75VMdzzK/3F59vENfQHtZ2kzWY3SLjGzUpFLRSMdbLv9JOLOKDGsJlzhukM
         yYUdcIaqQYvL5DrPvB9XCUp9h9jz3nXuNTEv7fugtrZ4BVw82cLG8ncODWM/T3/YrvCH
         E1RoK8GDzSCBksA8Do0prBbTZZi0CAVZAT/BQKXrNJ+4PZ5QyCEtka9DoTJyx7vEs7GB
         QF1w==
X-Gm-Message-State: AOJu0YxvPuBUd8L5DiE9OHayYw7S7LvKawIBMqcudn/vXdpDA40CCBN3
        3h/YK1aMs9TD5/8K8GU8uewLnFNUuhLrm1/Kr8vd
X-Google-Smtp-Source: AGHT+IH43k6QWEJV2RtBgKwWnWVAcIXj5xEnffXwHQsmz+m5ajj1E80bw/CPBrQ699JZ3HJWOMm33zn6gH7AL2HWwX8P
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a05:690c:2a45:b0:5af:a9ab:e131 with
 SMTP id ej5-20020a05690c2a4500b005afa9abe131mr155448ywb.1.1698651360172; Mon,
 30 Oct 2023 00:36:00 -0700 (PDT)
Date:   Mon, 30 Oct 2023 13:05:42 +0530
In-Reply-To: <20231030073542.251281-1-vamshigajjela@google.com>
Mime-Version: 1.0
References: <20231030073542.251281-1-vamshigajjela@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231030073542.251281-3-vamshigajjela@google.com>
Subject: [PATCH v5 2/2] serial: core: Clean up uart_update_timeout() function
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the variable size to temp and change its data type from
unsigned int to u64 to avoid type casting in multiplication. Remove the
intermediate variable frame_time and use temp instead to accommodate
the nanoseconds. port->frame_time is an unsigned int, therefore an
explicit cast is used to improve readability.

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
---
v5:
- shortlog changed from "serial: core: Make local variable size to
  u64" to "Clean up uart_update_timeout() function"
- renamed local variable size to temp, generic name
- removed intermediate variable frame_time
- added typecast "unsigned int" while assigning to port->frame_time
v4:
- no change, not submitted with series
v3:
- no change, not submitted with series
v2:
- no change, not submitted with series

 drivers/tty/serial/serial_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7bdc21d5e13b..21d345a9812a 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -410,11 +410,10 @@ void
 uart_update_timeout(struct uart_port *port, unsigned int cflag,
 		    unsigned int baud)
 {
-	unsigned int size = tty_get_frame_size(cflag);
-	u64 frame_time;
+	u64 temp = tty_get_frame_size(cflag);
 
-	frame_time = (u64)size * NSEC_PER_SEC;
-	port->frame_time = DIV64_U64_ROUND_UP(frame_time, baud);
+	temp *= NSEC_PER_SEC;
+	port->frame_time = (unsigned int)DIV64_U64_ROUND_UP(temp, baud);
 }
 EXPORT_SYMBOL(uart_update_timeout);
 
-- 
2.42.0.820.g83a721a137-goog

