Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCCB7DC49E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjJaCqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjJaCqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:46:10 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846CBDA;
        Mon, 30 Oct 2023 19:46:06 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d84f18e908aso4590309276.1;
        Mon, 30 Oct 2023 19:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698720365; x=1699325165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iEj8BMMHGmUiTt7opv9/MT6oAJvnqK3l5IxrH2wyANM=;
        b=AJoIxtymML6axJBQpvpN1gYhfJxMV6eTkhNFrgKAnBJL+WzZ8cid+8lb8/W68DPxAr
         RzMrQS+S+lEG0rkBfv2FL1PMiNc7OV0Xb2xkbS7ByzTcglx9eKKcwnyqyaB64Pf4a/ue
         J0oXomgcm84R0bFd0uRWOkqUwot2L6LONWiYXdXuySdPCjqG4Z+0VJ/jTKjiKxhVGXov
         WrzhenDBrkJKsI2SZqxJ2WiA0A8MxBE2f9gDlODUuPc7e9Vhl223yRbD0lYIIoqoXczl
         gMQgCDk/puOvY0EL/JMxOtjdCEUmKGKzCqWGdenzF2tVhcpe24lWNa4RmpjMz9ZVklU3
         RGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698720365; x=1699325165;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iEj8BMMHGmUiTt7opv9/MT6oAJvnqK3l5IxrH2wyANM=;
        b=ZjabDm5jF6siYqpWzPDaa4Ot0mYQ/T+WLXU5Y4o6XvwVOy86k+aiibC4x9XaH2LG0P
         P2FGqisLeuPa15GpqheaSxu2Mi0NUMBDfWWwlCYrRzecWY4mDnkKn4HdvQTyI6bmsr2G
         vhL2jdY7+1nPYaGIpNxWnoerGQgG8peSVTDy8QC9E/Yc0013wqQmj0hfEhqxJL8OCtP/
         fYmyytO6dSUiHbzZtmY0QsHjH0nyh7+2HnB4rjBzxDjKevSWwIWGWcsBjhs8ihinxx61
         sXmvbUU1SA0WPqEzQIr9ZeHBbQrKEBrViE2iC7JKTGRKHWD+jn89ylP7IhurEO/Fwj6k
         hnUQ==
X-Gm-Message-State: AOJu0Yxu4ctJp6aP5J+OFoeuuFdohc6QGSOhy0tB9Cufu2vMG6bN4Wei
        2suLwiZraBLP0qTmBrlh8LsueUCWmbq4MSdwsZo=
X-Google-Smtp-Source: AGHT+IH/bGsxbHnjN1HVWqIUrXaNGvq3zqC6QBGgP8GMaHmTYmiQJMf4eJayRsKfv+3Rs5puRD07Cqj3QaegslvojRk=
X-Received: by 2002:a25:d784:0:b0:d7f:af26:2c7e with SMTP id
 o126-20020a25d784000000b00d7faf262c7emr10985759ybg.20.1698720365625; Mon, 30
 Oct 2023 19:46:05 -0700 (PDT)
MIME-Version: 1.0
From:   renhai_lenovo <kean0048@gmail.com>
Date:   Tue, 31 Oct 2023 10:45:54 +0800
Message-ID: <CA+g2S9pkFLRV1foEHpEkaRwjMKOVQTxJrM=-sQsqoud92_WNFw@mail.gmail.com>
Subject: Update objtrace usage in Documentation/trace/events.rst
To:     xiehuan09@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bagasdotme@gmail.com,
        "corbet@lwn.net" <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation: trace/objtrace: Move the line entering the trace
directory to the first step, so that the commands in the first step
can be executed smoothly.

    Signed-off-by: Renhai <rh_king@163.com>

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 52ac8ca8ab64..d5fadf7966de 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -583,6 +583,7 @@ The following commands are supported:

   .. code-block::

+    # cd /sys/kernel/debug/tracing/
      # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events

   Secondly, we can get the value dynamically based on the object:
@@ -597,7 +598,6 @@ The following commands are supported:
      # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' >
./events/kprobes/ \
        p_bio_add_page_0/trigger

-     # cd /sys/kernel/debug/tracing/
      # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
      # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' >
./events/kprobes/p_bio_add_page_0/trigger
