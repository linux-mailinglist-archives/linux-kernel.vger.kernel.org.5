Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBE87FA58B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjK0QDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbjK0QD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:03:29 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B348BCE;
        Mon, 27 Nov 2023 08:03:35 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cfc2d03b3aso9291245ad.1;
        Mon, 27 Nov 2023 08:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701101015; x=1701705815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ovFrH1/AjRvHdNMB/VJzZliD8vmbG1p5UDUluMTuF88=;
        b=YV2ORvXzh7l35zmejRS8FCx/Gp0ta6nYjxeLnvEmtB7Pc2eS7r5BOEpp5Us+R1OVz4
         6rKDUFglNapdQbwUL9jSRU1Q5zWIJcY8h2/oRWskQDwYqD0bmKdwZaFXisQjlydfIdoe
         ydqk1YjZDWqWtXkVK2VrwNDdndVTcd6orHlQPTZZBM7J64byN5AGGVkoKXMT/AAUI3xX
         84CqDzU/pxr3DErSBCGvB5qVhN/n6pKsyqCQK0Mgpu1RQvHfl8HcxIOoYHxP/AasI3x5
         zp+9dn4FcM6a1KQjn2YRRYCe1BTEiYZeyYn78mnF2J7tUQm1zdDSOqdq74b+n10tv0A5
         2OPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701101015; x=1701705815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovFrH1/AjRvHdNMB/VJzZliD8vmbG1p5UDUluMTuF88=;
        b=u3I6ToS6h8E4sHnle6Zrr/9D1pknySsSy6AvSDrUJdRcr+tsM1UpcUuZc4dUBeTd9W
         OxrZqg1Yg0ddZBPJEFMQ/7vuVC3tqsRvbmJJ89inlMmrDgqHF1UpbFXO8BBeRm8o/a6M
         UTxm114PiDDdErbKhLR7oGaXw6F4Wyjojl+hg/9ISSs4roPVQw6JNzsIoHVpWvqWFF7M
         ITORovKb6DVE9E//pWu9A/eGuKKLUmad48Eff8QgcUfCzNgq0pKk8tAI4KqzuZcHxTyn
         GoF2X8kC17NQT5qdGtIxMo69xVrplWCiUmBbm21GH//ErHo1VVAIo1MZxgKQe5utQy+F
         MLJg==
X-Gm-Message-State: AOJu0YxU1St3So7P364bRAT4XxyvKZkcqxS5vQ9dlKUGT4cktQno+AOE
        UEzQzprkadXmMaqh7KBXkMs=
X-Google-Smtp-Source: AGHT+IGnxD/CA9o+aJGc6sy/WMss+ZbwTeVZIqa0C9egy5zZUpC4NNFjbJIiL7xBxYNlaQK7er42SQ==
X-Received: by 2002:a17:90b:1d09:b0:285:80d5:6e51 with SMTP id on9-20020a17090b1d0900b0028580d56e51mr10792245pjb.21.1701101015022;
        Mon, 27 Nov 2023 08:03:35 -0800 (PST)
Received: from attreyee-HP-Pavilion-Laptop-14-ec0xxx.. ([60.243.28.47])
        by smtp.gmail.com with ESMTPSA id hg18-20020a17090b301200b002836c720713sm7470143pjb.24.2023.11.27.08.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:03:34 -0800 (PST)
From:   attreyee-muk <tintinm2017@gmail.com>
To:     jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
        pmladek@suse.com, joe.lawrence@redhat.com, corbet@lwn.net
Cc:     attreyee-muk <tintinm2017@gmail.com>,
        live-patching@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Took care of some grammatical mistakes
Date:   Mon, 27 Nov 2023 21:27:59 +0530
Message-Id: <20231127155758.33070-1-tintinm2017@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Respected Maintainers, 

I have made some grammatical changes in the livepatch.rst file where I
felt that the sentence would have sounded more correct and would have become easy for
beginners to understand by reading. 
Requesting review of my proposed changes from the mainatiners. 

Thank You
Attreyee Mukherjee

Signed-off-by: attreyee-muk <tintinm2017@gmail.com>
---
 Documentation/livepatch/livepatch.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/livepatch/livepatch.rst b/Documentation/livepatch/livepatch.rst
index 68e3651e8af9..a2d2317b7d6b 100644
--- a/Documentation/livepatch/livepatch.rst
+++ b/Documentation/livepatch/livepatch.rst
@@ -35,11 +35,11 @@ and livepatching:
     compiler using the '-pg' gcc option.
 
   - Livepatching typically needs to redirect the code at the very beginning
-    of the function entry before the function parameters or the stack
+    of the function entry, before the function parameters or the stack
     are in any way modified.
 
 All three approaches need to modify the existing code at runtime. Therefore
-they need to be aware of each other and not step over each other's toes.
+they need to be aware of each other and not step over each others' toes.
 Most of these problems are solved by using the dynamic ftrace framework as
 a base. A Kprobe is registered as a ftrace handler when the function entry
 is probed, see CONFIG_KPROBES_ON_FTRACE. Also an alternative function from
@@ -50,8 +50,8 @@ some limitations, see below.
 3. Consistency model
 ====================
 
-Functions are there for a reason. They take some input parameters, get or
-release locks, read, process, and even write some data in a defined way,
+Functions are there for a reason. They take some input parameters, acquire or
+release locks, read, process, write some data in a defined way, and also
 have return values. In other words, each function has a defined semantic.
 
 Many fixes do not change the semantic of the modified functions. For
-- 
2.34.1

