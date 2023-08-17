Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C9E77FC8F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353603AbjHQRIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353857AbjHQRIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:08:32 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FAD30F7;
        Thu, 17 Aug 2023 10:08:28 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bdfb11ea2aso122785ad.2;
        Thu, 17 Aug 2023 10:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692292108; x=1692896908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7NWIyxKHGTcZUh3pE/+j1hXTU1RElUSlh9m4J1oVdP0=;
        b=XafT0oWTXXtxTncl5MhBhEkug2jSN3luOh8Zhq8IcL5f3RHZNwfr2Tb4nv1AkbTGak
         QXfYnvUvTgxlGEDIt5WUBlHBu9ZXIixLc0w4Ljj5w7fOgoUAjyoVjimM3CQ8B4yO2QNJ
         zUp8d15eizIQ4yewsaBmNwz2NmU2uUvqG1oIltLtbrAn6d8IMjw7py6qk6kyziFFqpIk
         u2OZT4Shx4cond5guUG8TFA1RWgwfzhvCfxYF7eXdJKtZFMLW16k3GknxJm2JmCNa70g
         bJrI3URMs/q9XSxVVhgrPNMdvnPfdDaT0Co0X3GTBgwJOB5+YsM5UAAX6MRDJXpuZQ0o
         zl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692292108; x=1692896908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7NWIyxKHGTcZUh3pE/+j1hXTU1RElUSlh9m4J1oVdP0=;
        b=hUEwP0dca3J3z3YveIWw3/ns4CCywLbuY3yXV9lEZeGVMZVFJdF37yTDu8/ruFx5h9
         prgZL1j7EpoYcGMtLFLwhb9ffk0vX37kHuHag6AFDOjZnvq+EwfKBVu1gKbbAV4O5RKS
         JTLFPAJ7aNevuFORoOWOBjAlhJjx9JRDoEk5xE4urpihSlpuLNtlTzrro0an5hOd4A1q
         czgsZyLAa935bSdbtLdSEwgMMUF6SqVHbe7X35eIGcpsmfc9kWPTnVyXGa2xrLZOY1Hr
         XbLS0Y6xH5K2LsAUODAZYAxa8fdThr4qJohIDu+JhzwbL1K57I5rwo6tIY8GXs1WY41J
         q6HQ==
X-Gm-Message-State: AOJu0Yx3m3wQjb8PTLz8+y3a56EOb7K7YD7MsG7gwf6BQlJs8Jcmrpr6
        e2fr1v+F118OdDBBOU5ZG+A=
X-Google-Smtp-Source: AGHT+IFr+3gG7MMJKJLLVSDApdX7jk8TogII4+aNPg9CqA42X0ljIhGCtwyPlK1gzyJ5sARF+JiFPQ==
X-Received: by 2002:a17:902:ea02:b0:1b7:e86f:7631 with SMTP id s2-20020a170902ea0200b001b7e86f7631mr14797plg.19.1692292108334;
        Thu, 17 Aug 2023 10:08:28 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c009:58e9:c155:d912:d62a:88e5])
        by smtp.gmail.com with ESMTPSA id jw4-20020a170903278400b001bf20c806adsm19106plb.50.2023.08.17.10.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 10:08:27 -0700 (PDT)
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org
Subject: [PATCH v1] samples: kprobes: Fixes a typo
Date:   Thu, 17 Aug 2023 22:38:19 +0530
Message-Id: <20230817170819.77857-1-atulpant.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Fixes typo in a function name.

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---
 samples/kprobes/kretprobe_example.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
index cbf16542d84e..ed79fd3d48fb 100644
--- a/samples/kprobes/kretprobe_example.c
+++ b/samples/kprobes/kretprobe_example.c
@@ -35,7 +35,7 @@ struct my_data {
 	ktime_t entry_stamp;
 };
 
-/* Here we use the entry_hanlder to timestamp function entry */
+/* Here we use the entry_handler to timestamp function entry */
 static int entry_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
 {
 	struct my_data *data;
-- 
2.25.1

