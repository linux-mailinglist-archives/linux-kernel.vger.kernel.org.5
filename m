Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B98C7BCBD4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 05:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344317AbjJHDE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 23:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344270AbjJHDEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 23:04:55 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C051EBD;
        Sat,  7 Oct 2023 20:04:54 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-691c05bc5aaso3096579b3a.2;
        Sat, 07 Oct 2023 20:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696734294; x=1697339094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4DsUPLRhnHwmRtdg0x+DIFluUBwrT12Qx0/lT882TkQ=;
        b=Xw0CVcwYQPxenK2jjKFqH5MXAI3m46tNZAVGGYNgKjlKYwPvfqzKwQO4zkTIWaIsTL
         ZyKj8CQ4Gd6EVeOBKYVoNO0x34+x3L8+4Vq00/Xk16hv5XqQcJm2iJ03jWt+k8N+luZ5
         qg/yztYAKUMIiSfQDbV/oVNoVFsyqp559hpZ0nLig95rqFdeCdHXA32IhpzD+ALd6EuE
         OGhYpN8t46LNne0AKbtHI06tq/04Q6i9iqZXdrgH77GKM3QnVnto60VbvJ3YR3Ye/jEk
         LPM1DkjIMEwqucx0zyhFSPQYA/plGp9uXNz1JF7HF904GjQq4Fd61X3L+TAwk36drPJc
         RjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696734294; x=1697339094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DsUPLRhnHwmRtdg0x+DIFluUBwrT12Qx0/lT882TkQ=;
        b=R/M6Es9lwHVcRhm6dwmOe0JZpyPMUh2jN3yY1Oe7VpDt6fFHuZl/iNDjoYQnwjFFfd
         cbALhyGHwe6C1Iu9xc3uxy3IzyVPrnhCbpU66SZhKD16zANMdzhc1ktaHtWLf0H6uoWb
         ufTQ88TuAXRtwDeHxhFEw7f8aCH2rBthiztLZD0Xd3spewDKrtQ8AmdzS517NPxZ5FE/
         V6N9HwjMvCTCajcWy0/IvFLCEwVNJbjIQi/XaVDuZ5YteJ9KiYNlhMEEnA7U7fZu4Zbk
         aPfhnwBDrVk1G6OcjE8iWwPos4nIwEd/9dEgi2yC5y2rCM5/czYuTllZLmj8eTUTy3zp
         IEXw==
X-Gm-Message-State: AOJu0YwjKOBvdGuqTymnc91iB0Ews/awieWDDnRSAfBhAWD7qZiJ6v+t
        fPSH3FFkp7zt3V2gmRGDbRg=
X-Google-Smtp-Source: AGHT+IE38qe9crJ6OpXan72TEgMoTTQCZaYZ1JP8LT8isaS3+a0YuDpaWV+uv79Oqqj0vMXm/0K1Qw==
X-Received: by 2002:a05:6a00:cd1:b0:690:c1e5:9359 with SMTP id b17-20020a056a000cd100b00690c1e59359mr14311260pfv.17.1696734294162;
        Sat, 07 Oct 2023 20:04:54 -0700 (PDT)
Received: from localhost.localdomain ([61.16.102.74])
        by smtp.gmail.com with ESMTPSA id p24-20020aa78618000000b00690c0cf97c9sm3825562pfn.73.2023.10.07.20.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 20:04:53 -0700 (PDT)
From:   zhailiansen <zhailiansen@gmail.com>
X-Google-Original-From: zhailiansen <zhailiansen@kuaishou.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhailiansen@gmail.com, yuwang@kuaishou.com, wushukun@kuaishou.com,
        zhailiansen <zhailiansen@kuaishou.com>
Subject: [PATCH] netclassid: on modifying netclassid, only consider the main process.
Date:   Sun,  8 Oct 2023 11:04:42 +0800
Message-Id: <20231008030442.35196-1-zhailiansen@kuaishou.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When modifying netclassid, the command("echo 0x100001 > net_cls.classid") will
take more time on muti threads of one process, because the process create many
fds.
for example, one process exists 28000 fds and 60000 threads, echo command will
task 45 seconds.
Now, we only consider the main process when exec "iterate_fd", and the time is
52 milliseconds.

Signed-off-by: zhailiansen <zhailiansen@kuaishou.com>
---
 net/core/netclassid_cgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/netclassid_cgroup.c b/net/core/netclassid_cgroup.c
index d6a70ae..78c903c 100644
--- a/net/core/netclassid_cgroup.c
+++ b/net/core/netclassid_cgroup.c
@@ -88,6 +88,12 @@ static void update_classid_task(struct task_struct *p, u32 classid)
 	};
 	unsigned int fd = 0;
 
+	/* Only update the leader task, when multi threads in this task,
+	 * so it can avoid the useless traversal.
+	 */
+	if (p && p != p->group_leader)
+		return;
+
 	do {
 		task_lock(p);
 		fd = iterate_fd(p->files, fd, update_classid_sock, &ctx);
-- 
1.8.3.1

