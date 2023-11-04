Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566BD7E0E7D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 10:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjKDJGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 05:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDJGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 05:06:38 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69462194
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 02:06:13 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b2e73a17a0so1829037b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 02:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699088772; x=1699693572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kBC4c9FAt9Gr/4aY1zrwIt9ZU0ReMokHXCMgH7+KRKY=;
        b=iD+vrumWXtZDmHSGj6lYqbHv8qNt85yoA2VdJwWD/884QncWClUlBtXwVCz9UEznJj
         Zxd74VEqNlqTYi8dZyuZCGxLIJy/7nZjrQ5dX4Fm9O9b+ClEEPyCqNlI334WDTBKStwe
         mGyV16YI6LDGn8dWatYkRQxW3o75rxTq2/UkM2ofL7JZqc6dRA70x83LWcT7vgBVASY9
         pb6zf7dXnv42slMToGMfYQdMbqTTai0rbdsIO5eTLFV+NLXe+Ha4OTJtMwleriAVNbFI
         fSA1UVPqR1NN3MezXGTn41QwVpfVnewIAMH0OjUJhFnNZ2d5BbxQ1J4cD1jhWy88V+TS
         2iBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699088772; x=1699693572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBC4c9FAt9Gr/4aY1zrwIt9ZU0ReMokHXCMgH7+KRKY=;
        b=dFfJ1GNl6EOMzxOyCbSkvPEtNCVES6AuPL2rak9XEEi3tEN6AB9MxZbd6w3lF2RPi/
         cyW9ooKCw5iW/tmMBs/u4jDpYvUgq23UEw2Wqvfw8PsgFzG4DOc0f++PzwHZpfWYzK80
         KlLeNS4TjKO/3ulUJQx1GDW38LGFd77AXDc78mZtAp4vi6uGZkcGxpyVtC56XpgVplZE
         14aRKHH7mpPBwJY+vNSz4XPHPvUccddn73p8w7vQE9jsZ+IpdtDQMUlWLN1HQwsTmSUS
         3/5aGD9NhlNtj5Ce27HSU6/CC2aLQaIaGJcySmIhhOfpwscCLpohG6+uXul+CyM2YimD
         q5QA==
X-Gm-Message-State: AOJu0YxYcFVC7z97ztuQSQLY75sXiAMbHTJunQ4eIsFSA0LYEFAfZ0Nx
        BW3UZDae3idDD5oBY9sFqCX2sA==
X-Google-Smtp-Source: AGHT+IElbETWz4J5LyBl6CbkqlTld72BfFKKHKXDhFHgU4let2s7nH1JvMQvY0kXXYKvJ8jGXjdNOA==
X-Received: by 2002:a05:6808:1389:b0:3b2:e60d:27f6 with SMTP id c9-20020a056808138900b003b2e60d27f6mr29896164oiw.29.1699088772632;
        Sat, 04 Nov 2023 02:06:12 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id c4-20020aa78c04000000b0068be3489b0dsm2656148pfd.172.2023.11.04.02.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 02:06:12 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     chris@zankel.net, jcmvbkbc@gmail.com, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, palmer@rivosinc.com, geert@linux-m68k.org
Cc:     linux-kernel@vger.kernel.org, mattwu@163.com,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v1] locking/atomic: xtensa: define arch_cmpxchg_local as __cmpxchg_local
Date:   Sat,  4 Nov 2023 17:06:03 +0800
Message-Id: <20231104090603.4253-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xtensa architecture already has __cmpxchg_local defined upon the
native __cmpxchg_u32 and __generic_cmpxchg_local

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
---
 arch/xtensa/include/asm/cmpxchg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index 675a11ea8de7..956c9925df1c 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -108,7 +108,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
  * them available.
  */
 #define arch_cmpxchg_local(ptr, o, n)				  	       \
-	((__typeof__(*(ptr)))__generic_cmpxchg_local((ptr), (unsigned long)(o),\
+	((__typeof__(*(ptr)))__cmpxchg_local((ptr), (unsigned long)(o),        \
 			(unsigned long)(n), sizeof(*(ptr))))
 #define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 #define arch_cmpxchg64(ptr, o, n)    arch_cmpxchg64_local((ptr), (o), (n))
-- 
2.40.1

