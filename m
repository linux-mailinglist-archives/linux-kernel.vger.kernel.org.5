Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C607FCD97
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376821AbjK2Dp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjK2Dp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:45:58 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF42DAF;
        Tue, 28 Nov 2023 19:46:04 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-67a47104064so16036736d6.0;
        Tue, 28 Nov 2023 19:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701229564; x=1701834364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=50NgtX7SvQ7Ubnw7wnZdr9/ovViujYpH8S6F31BeVuI=;
        b=gVQFsS/by3aicyS8w9m8gEXhWVaQx+TNh4fVmc3X7nf+pI0d1Trkn+77D9/fOZQLMb
         oOiQGZ+DAjRWi8whEnHcXH5nUpgIoNX40ta4ub+UBWGFmVxlfFD7YZWprQPlw++B+6t3
         q93X7krb7Z2oHbXfd66tOJ6Y17vo8/2rh4V0x9GqgwxUaUcfbmEKnACop+qntJaPyZrP
         oIcCrndmObv2d4nmAuDTBHHBIryWtHGB/7hpKCiJK7aa/NEKPVbbilGH+5zmqc1KOX4W
         8uc3+pZQtY8rB8K0bQIVDbHHJ0Um17vMNA2RP1GLZEjA5R2WBVtB1VfgBk7CGXcdiFN6
         9kJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701229564; x=1701834364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50NgtX7SvQ7Ubnw7wnZdr9/ovViujYpH8S6F31BeVuI=;
        b=xR1bI7KrNx1nvOv+chLwwnMvSWPFjPRkWXk/5d+zniXzsdKUosdwZr7UtTuzFYL8yH
         68EDWdajA7rVc2CwfuuGxsfxxCRUjg7wFBvpAXDFbfPgi5X6vPE6Ap1i07QKBFnlrHlg
         2d+UsVSj6+PBeW1fM3fhsLhRzcPkVruu8oAsklPkzl5LWV7fusZ7oF0SMniFkZ6xDFSO
         SOivU9JNdavsVWo/SCmDWxdaVWUC5qMKvQyIwzY0jxMvMTbkUrwgU6t3F4842ntiCBzE
         0aRZszHePzPp1kM8p6MH4CA6dwel9YUreDrONi+yhLvmct43ZgsFO+69dx7jC0Kob5cn
         sylA==
X-Gm-Message-State: AOJu0Yy/oFHzrt21vpcGhQdhG6W86d5RT+zJW0UVwzPx9AKEnzRQI7tW
        Q9SJZG4p2tl22nu2YHw16lB1IKJ7AaRKsA==
X-Google-Smtp-Source: AGHT+IHFkdWY6z+ESxpeYzxOj8MBjfPGl3gnCqPYymnVMncuFnlo83TFW7xMNwnxW3JIhr5arYCmpQ==
X-Received: by 2002:a05:6214:892:b0:67a:3efb:df5f with SMTP id cz18-20020a056214089200b0067a3efbdf5fmr10622237qvb.0.1701229563907;
        Tue, 28 Nov 2023 19:46:03 -0800 (PST)
Received: from angquan-linux.. ([72.36.119.4])
        by smtp.gmail.com with ESMTPSA id fb11-20020ad44f0b000000b0067a1201f3cbsm4882805qvb.100.2023.11.28.19.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 19:46:03 -0800 (PST)
From:   angquan yu <angquan21@gmail.com>
X-Google-Original-From: angquan yu
To:     skhan@linuxfoundation.org
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        angquan yu <angquan21@gmail.com>
Subject: [PATCH] selftests:proc: Resolve 'Unused Result' Warning from proc-empty-vm.c
Date:   Tue, 28 Nov 2023 21:45:56 -0600
Message-Id: <20231129034556.5719-1-angquan21@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: angquan yu <angquan21@gmail.com>

In tools/testing/selftests/proc/proc-empty->because the return value
of a write call was being ignored. This call was partof a conditional
debugging block (if (0) { ... }), which meant it would neveractually
execute.

This patch removes the unused debug write call. This cleanup resolves
the compi>warning about ignoring the result of write declared with
the warn_unused_resultattribute.

Removing this code also improves the clarity and maintainability of
the function, as it eliminates a non-functional block of code.

This is original warning: proc-empty-vm.c: In function
‘test_proc_pid_statm’ :proc-empty-vm.c:385:17:
warning: ignoring return value of ‘write’
declared with>385 |                 write(1, buf, rv);|

Signed-off-by: angquan yu <angquan21@gmail.com>
---
 tools/testing/selftests/proc/proc-empty-vm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index 5e7020630..d231e61e4 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -383,8 +383,10 @@ static int test_proc_pid_statm(pid_t pid)
 	assert(rv <= sizeof(buf));
 	if (0) {
 		ssize_t written = write(1, buf, rv);
+
 		if (written == -1) {
 			perror("write failed to /proc/${pid}");
+			return EXIT_FAILURE;
 		}
 	}
 
-- 
2.39.2

