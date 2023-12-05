Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383BA804854
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 04:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjLEDyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 22:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEDyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 22:54:52 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09CED5;
        Mon,  4 Dec 2023 19:54:58 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77d645c0e06so337282785a.3;
        Mon, 04 Dec 2023 19:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701748498; x=1702353298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bwazqnNeub5DZ+rw7fMsVgByjnDtf2+w+fCVgKk8Ybo=;
        b=ZyFjcWOxbOFkMt3X7t7x9+dbdscYunMuWj8a4yWis488CkVDl0IMr8V8RMwKs8jFtT
         1kxvgDWW8z3HETz89hbQam7+kPdYqhSun7Xw5s5Wjsq544mmi1xieQqdqOuIu43secmx
         fVuzwvFPK8c309szmI/yTdlsl0b/sL3VLrL+6Ku+KGe0xECarfOITuTVlrxcQJUJpWXE
         G+jWJxEbHnOVIaPrqflcWYhPzXu5VNep3ymXwWIxnx0/Z4YWjhj+vlo69pzkDQrPY9vA
         n5UvM3PZDMJoVpF/ORRkm1nVxcH+XTzaha5QNwr30+0cMgRJ6ZEA/WFsgVNnhNp2BKsr
         LMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701748498; x=1702353298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bwazqnNeub5DZ+rw7fMsVgByjnDtf2+w+fCVgKk8Ybo=;
        b=UbcDyALycvKVuD7iOOgbuDn6jCQ/iDKqRmBjhKQAfACHmh+1WWRI820+Beq0ETTX3k
         DkGGvHqDLAwyZuWY1u6dQ7+E/9RZlRATBxNomllWs/CtcTeypKZJDnqnojR71VJPLzRO
         bqYvtXP7EIePksROBdOh6kXgxx0QnREguECEYiBgj/658E92RWRyYLSFs3RCW+++nXl7
         BPz8ycMvpMa6WQ7VyO9rc5eUpI+Kk2PqN0hoV8pDsQoSPFLEVLwpRpveEs6uwDlqgDnL
         cnU0JpTbr8SrE2zhd4bN8XvikekUDGi+91VtWdV1IDk7/WXumIt0nFfvOOy67ZFinw1K
         IL7A==
X-Gm-Message-State: AOJu0YwExUMeVs/V1n5NaYFPWynmddE7DZuKi3vY3T5OdcTIBmf5Tlkj
        plpfUt5CmQj3k0DrZPWadQqOZUQe78g=
X-Google-Smtp-Source: AGHT+IGrXuNd26CC92+UKforEnNgXpfQsAOCq+zgDCHvKGn5kXp78v53PsNa1+LPIetle08f0af8hA==
X-Received: by 2002:a05:620a:12c2:b0:77e:fba3:5909 with SMTP id e2-20020a05620a12c200b0077efba35909mr605638qkl.154.1701748497850;
        Mon, 04 Dec 2023 19:54:57 -0800 (PST)
Received: from Slackware.localdomain ([154.16.192.47])
        by smtp.gmail.com with ESMTPSA id br31-20020a05620a461f00b0077dcfc63c8asm4785137qkb.78.2023.12.04.19.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 19:54:57 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, mark.rutland@arm.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] Documentaion:trace Add the git web link to view it on the browser
Date:   Tue,  5 Dec 2023 09:25:17 +0530
Message-Id: <20231205035517.30534-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.35.8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thought this might help people to see the entire source tree on browser and
explore.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/trace/ftrace.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 23572f6697c0..e768a4c91452 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -3731,3 +3731,5 @@ Currently, -mfentry is used by gcc 4.6.0 and above on x86 only.
 More
 ----
 More details can be found in the source code, in the `kernel/trace/*.c` files.
+Also you can see the trace source tree on browser `Git Link
+<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace>`__.
--
2.35.8

