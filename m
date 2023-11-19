Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358197F0476
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 06:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjKSFIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 00:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjKSFIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 00:08:12 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B77E131;
        Sat, 18 Nov 2023 21:08:09 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77a453eb01cso219602985a.0;
        Sat, 18 Nov 2023 21:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700370488; x=1700975288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ad+7DeeKonJPGSO2EixeCkfPYP/580kvKkx8jJr6+Sc=;
        b=kLwfzujhtcN7CZHqFridaiwh5DejVaby6ED50VH/LE7ZsGe6YH0IX+3kgeTzSbdJSx
         wwITf85mToOMCW8CyulE81L5GrrUSZss7MeQ7PCMbVQmKafxoiSOCfXbvtOp/iDLKxKm
         LCvycD9W5j7ss3mhtCvnAfvZwJUyZwh0carFmJZsLuGIteoZFW5aqeXlmMOrJKoA5XDr
         WNHMVX/Dg5aTe1JQtFCHzcMqiKNeUO4T/XAfJiz8mmxeNw4I4FV1X1HAmWqqSomr4L4z
         8TPdomQLx5am/jKtOjbRd6ln6iY4Slw2J2hMjXTKontS5YMi/UKvLick4/2kh62GClNg
         N2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700370488; x=1700975288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ad+7DeeKonJPGSO2EixeCkfPYP/580kvKkx8jJr6+Sc=;
        b=R4Om6p1PBrhMaqK4rerTIVtxnD+0ZiVo5a+y7+Gb33i8cHATI++b7mWlwpWVfQXQoV
         aR+2/sxIGOJTRA9bvEUNeiX9weJW3SUh9u9ENgfiHElduLNZngcDZ2kv9kYdYuRXrHZr
         pelnZ0UqWvS+PLjCNkiCliQKX63btH+AVoyr5cKZfQS1WEp5kMsT5t9gwe/SRc6Ptn6r
         zeaDEIaVrnhQJvT8mJlnpnynycPOnuvaQ4LMiw+bwEVNH02+1ou9W5k4nxJxODO7Ob5I
         D0lZGWQJ+qmrcaZE4Bh5u8T5DzvruDRr5YDWQ+TzWq/tHQUJdE9MoTMX4F3AhWM49pgi
         3Hww==
X-Gm-Message-State: AOJu0Ywfc4pCFTuekUtOB7LGJgPVyz7W/V+RH50qAtqVTm8uhxkvXpH5
        Ts70Fd6pRYbzFx7PtmD5FYPIl90z6biseQ==
X-Google-Smtp-Source: AGHT+IGZt43Jfyy2ih3iBT+vcAlXdVHLGh+ZkU/C4gig3TcjiA4MYoWEgwa7E/vhCtGPI7Wue2o2Qw==
X-Received: by 2002:a37:e203:0:b0:773:be2d:7cd2 with SMTP id g3-20020a37e203000000b00773be2d7cd2mr4632174qki.45.1700370487842;
        Sat, 18 Nov 2023 21:08:07 -0800 (PST)
Received: from angquan-linux.. ([72.36.119.4])
        by smtp.gmail.com with ESMTPSA id pb8-20020a05620a838800b0076dae4753efsm1757059qkn.14.2023.11.18.21.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 21:08:07 -0800 (PST)
From:   angquan yu <angquan21@gmail.com>
X-Google-Original-From: angquan yu
To:     linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        angquan yu <angquan21@gmail.com>
Subject: [PATCH] selftests:proc-empty-vm: Remove unused debug write callIn the function test_proc_pid_statm
Date:   Sat, 18 Nov 2023 23:08:01 -0600
Message-Id: <20231119050801.52177-1-angquan21@gmail.com>
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

In tools/testing/selftests/proc/proc-empty->because the return value of a write call was being ignored. This call was partof a conditional debugging block (if (0) { ... }), which meant it would neveractually execute.

This patch removes the unused debug write call. This cleanup resolves the compi>warning about ignoring the result of write declared with the warn_unused_resultattribute.

Removing this code also improves the clarity and maintainability ofthe function, as it eliminates a non-functional block of code.

This is original warning: proc-empty-vm.c: In function ‘test_proc_pid_statm’:proc-empty-vm.c:385:17: warning: ignoring return value of ‘write’ declared with>385 |                 write(1, buf, rv);|

Signed-off-by: angquan yu <angquan21@gmail.com>
---
 tools/testing/selftests/proc/proc-empty-vm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index 56198d4ca..74ef8627f 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -382,7 +382,10 @@ static int test_proc_pid_statm(pid_t pid)
 	assert(rv >= 0);
 	assert(rv <= sizeof(buf));
 	if (0) {
-		write(1, buf, rv);
+		ssize_t written = write(1, buf, rv);
+		if (written == -1) {
+			perror("write failed /proc/${pid}");
+		}
 	}
 
 	const char *p = buf;
-- 
2.39.2

