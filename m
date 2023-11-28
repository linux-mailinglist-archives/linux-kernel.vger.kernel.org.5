Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BAB7FC874
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344617AbjK1VaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjK1V3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:29:55 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0851FC1;
        Tue, 28 Nov 2023 13:29:44 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-58cf894544cso3188224eaf.3;
        Tue, 28 Nov 2023 13:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701206984; x=1701811784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=50NgtX7SvQ7Ubnw7wnZdr9/ovViujYpH8S6F31BeVuI=;
        b=TUVAe8smsZ6z+1ZFTR2an12KqE4/vs3YhHDoM17/h1AnTS+izbilnRHZOO5Sh1om2v
         Y8LaAvp4sk4/lYS8/AjBloAm9pWy9nZCgeeqhOEr4WVDXp2Bbz+iAU1V9jvizIemOG8l
         MdUC6jyip0mb1YhJMBQJ9ba3Eu1ftjh3J+QL5jBaqY2OolRa/+7tCZvjg95vaY500N4z
         lF2pv8RmFUi5zDBNyP1UtJtOOE138EUO68v36CppW5OBy1A4i+zVPs4E31mtOKoCUK3m
         egyh6DFGQK6xE5QfjazVXsuHB1EcvxHODdE1tKXwBQXrIMsna4pIk0haUjCYdf5v0OKa
         XoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701206984; x=1701811784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50NgtX7SvQ7Ubnw7wnZdr9/ovViujYpH8S6F31BeVuI=;
        b=bsVtOGtPdM4f6wuGZ3aNsJh0QI+QG5C8I08fQf4eF3cx6lrMYmiomgPLHLkS6cp7gh
         6gjcWHB3Czn8IJjLj3lrVdlOVTsRwN0OeyJyrA1bUVBHMrvf7NjiKrFCifeo2vVCL2RU
         Sb73hHmNWPwoJmUW4Ys4Zs6inPrCBVLgP3IIhN58nvXT7tqHXTCg0NsNW3PtovIG+xEV
         3aJxgpRC4q+TWipsawMNjcWqEbYavE9GdOGZAXj49jofRgxixne5GoMtg4olFVte7msd
         FBOTkvdJdB6KnWPpDB5FrKmeMCXaOR7uY4TL4hcK2B6ykhgWAXwXNZ51A9t1+ykgsXWy
         VdWg==
X-Gm-Message-State: AOJu0YztE+ei+qPDkEAgXv93O75DuOGfxi4s0GhWHZ8tG4B4vldFKUL7
        KngEpZWEyUJm/FSdrbS2sLc=
X-Google-Smtp-Source: AGHT+IGoswHYUfxHCB9J9zdO0iBkdDHzl9EW8tcmrjnfJTMp+HEs56LooAoxnz1sJN9WJ+Oji2aJaw==
X-Received: by 2002:a05:6358:106:b0:16e:13c:ba48 with SMTP id f6-20020a056358010600b0016e013cba48mr16308704rwa.0.1701206983758;
        Tue, 28 Nov 2023 13:29:43 -0800 (PST)
Received: from angquan-linux.. ([72.36.119.4])
        by smtp.gmail.com with ESMTPSA id t2-20020ac87602000000b00421c272bcbasm4880712qtq.11.2023.11.28.13.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 13:29:43 -0800 (PST)
From:   angquan yu <angquan21@gmail.com>
X-Google-Original-From: angquan yu
To:     skhan@linuxfoundation.org
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        angquan yu <angquan21@gmail.com>
Subject: [PATCH] Resolve 'Unused Result' Warning from proc-empty-vm.c
Date:   Tue, 28 Nov 2023 15:29:27 -0600
Message-Id: <20231128212927.59313-1-angquan21@gmail.com>
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

