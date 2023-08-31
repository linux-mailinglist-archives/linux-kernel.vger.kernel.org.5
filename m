Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D292F78F37E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344097AbjHaTma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjHaTmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:42:22 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C69E67;
        Thu, 31 Aug 2023 12:42:20 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-34df4799a62so3877405ab.1;
        Thu, 31 Aug 2023 12:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693510939; x=1694115739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4bhbRn40G8fRejY3+skmba0LjRugGKFU8ATlgbxA8nI=;
        b=kXpH/SvFufnthqjj05E3M3tl/LUa7zBe5kyFphNB6EqnenaeEAkOCf2+XwUNbd0m5G
         mVOyEpd67lsi5QZgjmIN2MNkLiJOVt9UzDCM9fiZk4TaT3y1d5dlECwvrR6XQ6+BdnOE
         OVZX75s8kkdEoOh26mazP9Hr1X2Omwl9Bv9kuqCmMYw8s/8qfHCyAfiF5p6NU/GC6y2u
         vM7E/EPgiJIkL1CPQGeZr7T+BZITlVwd1ZfctUXIi+SCdGAIxMoGZ0+aHrIWi1IJtVQR
         UNFJ6Pi5T+I9HTQVFtQgGFXIBV4KYTfm5MULKN7P3OyMVOF5z0iTi5t9jKLb6fo2D7tD
         qKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693510939; x=1694115739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bhbRn40G8fRejY3+skmba0LjRugGKFU8ATlgbxA8nI=;
        b=lkYqCBWB849GdRdb4plfhwS+pfiJzDjzH3zm3le8JFvaq2kz04b5eF+grsk7Ha/0xa
         l+iAWOJhvUhQ5Lk7c1W6jMLpe8kQplZwZmaVrBRA8bEFJCQUvVaH4Do14R3nV9WdMlIe
         QiQ66VAy36D2XUhTW2cYTyNqROqnVwnjihXQzdDV6TS42Bnw2KQnYSwVeFegPOMKKtAd
         6C6nkcoDPWEtUHRYT6pP9TNlI9rkrjY6nE9NPg+fFU+9d1XOuMBcoCrmefXfM+RX3Wu8
         +lpOapQ0w33sLqfUuGpC5huIMT5jPgoQYmC8m/XmP2bjjSERsjCttbmsFb7uLf76wRyJ
         cx0Q==
X-Gm-Message-State: AOJu0YyTEl+ErywMEUJbvFz8EWFY8W4RB4qvjaX+VnoI/1ySbDqxcYNV
        tbBglz1moQXoIs4aM48gBHJWvFK+PlaMrOEO
X-Google-Smtp-Source: AGHT+IEqblxyuxbnA6AuhEjq3Z4T0ccLwA4x66EDYw1ywPwueiJDqLZlOX79wI6j7lDd6p4M7jrjoQ==
X-Received: by 2002:a05:6e02:13f0:b0:32c:9c5e:900c with SMTP id w16-20020a056e0213f000b0032c9c5e900cmr444776ilj.8.1693510939369;
        Thu, 31 Aug 2023 12:42:19 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id x5-20020a920605000000b003498cdb93dcsm569685ilg.31.2023.08.31.12.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 12:42:18 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] trace/events/task.h: Replace strlcpy with strscpy
Date:   Thu, 31 Aug 2023 19:42:12 +0000
Message-ID: <20230831194212.1529941-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
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

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().

No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 include/trace/events/task.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/task.h b/include/trace/events/task.h
index 64d160930b0d..47b527464d1a 100644
--- a/include/trace/events/task.h
+++ b/include/trace/events/task.h
@@ -47,7 +47,7 @@ TRACE_EVENT(task_rename,
 	TP_fast_assign(
 		__entry->pid = task->pid;
 		memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
-		strlcpy(entry->newcomm, comm, TASK_COMM_LEN);
+		strscpy(entry->newcomm, comm, TASK_COMM_LEN);
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),

--
2.42.0.283.g2d96d420d3-goog


