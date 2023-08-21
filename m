Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40301782CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbjHUO6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbjHUO6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:58:10 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F21D1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:58:08 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ffa248263cso5188768e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692629887; x=1693234687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0wE2zt8g0Wv4wfv5ccirt3Iy9YTM6OrFQ7AyCGM9Z/Y=;
        b=YBcoIel9aZ8B/LEazKHjIiabsYhQ2D7m+4XXSme4K3zuoKEhJziS8KL9rEZlQz6Arm
         vICnq3zyZgkq5D5M8ZcVvdQjmB3qUouHOgGeID8Swu5yAAttFz03p1vXQnYkT1vNprWk
         seTTdXdBZHK++JTMFf2WW8LPu0zKnKzcvxy0I1eEHc//J+HI+DXPodPpQer7AENambQQ
         t6I5mF3Dy0ieG0wNnED9++WTcDawGSiz6eX1XEZEt7lKnjZPxX/V8Z7DsmP5KaBmxBoa
         yY20xKJFKIFqmv69fhvO+JG8gttb3PIgmhxZx9oKCG+sRTfNZkFD8Fg9nw2SXMqumyaY
         5N+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692629887; x=1693234687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wE2zt8g0Wv4wfv5ccirt3Iy9YTM6OrFQ7AyCGM9Z/Y=;
        b=ai0m41cwCcBHhug8ierZ23WWa0ak23TcRAVR/suzQrQ+IvSHNujoa2xDQIWzJR8JzY
         /Yx1atkgLa9WUV3qWi4xxn7hX+4rlix/KoGh0LMtUEp/U1P9wzwlh63jpQ/Qj6gsgnxr
         arEb6DbRbYiTfjt8E+52HgrYZohd+JaK0snkP1bm0p3e94A31r2lq6KVKXuQJK91d09Q
         7V+41Nxw+85wOw0yAvypoe+SLFKotG31pvnmtCIH2WYwcoLwlOFdFjobjo9ksLe6ViKm
         9/qFeR46gEdt9lG5ZTRY6n9xvv/TKbuZGONASgbuizDOrWrk5vcjeKhDVyqRSjqsyl9X
         6Ltg==
X-Gm-Message-State: AOJu0YznafwwLyM4xcLFakytUdArfHPb5QlOJ8inYy9s3gMogWWBBhC/
        xadWrVtkwRMSovd9xEWxx/aSrY9pFe4=
X-Google-Smtp-Source: AGHT+IFn/3AuiAPJOg2Gh449w9l0VkWH1IUJilqxS4AsvZfnegj9xx/6B6xmlLTEWEEk3krz52yNyg==
X-Received: by 2002:a05:6512:ad3:b0:4f7:6966:36fb with SMTP id n19-20020a0565120ad300b004f7696636fbmr5234936lfu.12.1692629886700;
        Mon, 21 Aug 2023 07:58:06 -0700 (PDT)
Received: from nam-dell (wlan-246006.nbw.tue.nl. [131.155.246.6])
        by smtp.gmail.com with ESMTPSA id s16-20020a1709067b9000b009932337747esm6617540ejo.86.2023.08.21.07.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 07:58:06 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcaov@gmail.com>
Subject: [PATCH v2] riscv: put interrupt entries into .irqentry.text
Date:   Mon, 21 Aug 2023 16:57:09 +0200
Message-Id: <20230821145708.21270-1-namcaov@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The interrupt entries are expected to be in the .irqentry.text section.
For example, for kprobes to work properly, exception code cannot be
probed; this is ensured by blacklisting addresses in the .irqentry.text
section.

Fixes: 7db91e57a0ac ("RISC-V: Task implementation")
Signed-off-by: Nam Cao <namcaov@gmail.com>
---
v2: add fix tag

 arch/riscv/kernel/entry.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 143a2bb3e697..d7dd9030df3f 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -14,6 +14,8 @@
 #include <asm/asm-offsets.h>
 #include <asm/errata_list.h>
 
+	.section .irqentry.text, "ax"
+
 SYM_CODE_START(handle_exception)
 	/*
 	 * If coming from userspace, preserve the user thread pointer and load
-- 
2.34.1

