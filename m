Return-Path: <linux-kernel+bounces-86852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9269386CBBD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44BC1C2093E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCA5137742;
	Thu, 29 Feb 2024 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="mYt5vXd1"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C713D31D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217528; cv=none; b=cICgQx55P6qBcMxtvMqGdZd7vwPsGm6rtAQKOQn6SIah5VZT4fS0q9CU5en27rKUuTdewsgc6EblccKhAmh90djGq6Je/Jnm8CG6/4vlHBZJ/txa9jntxpicyby/7AJoufpFcwLjLG23+un2sPw21+GHb3J8NgSXiKvBJlJ7AaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217528; c=relaxed/simple;
	bh=Ih9xawQi49XQbDIpr/3pub8/701foOZuv4pQwUVsysA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qpOSVtmEQvNVUmgWA1VVDVZlvT4rjadesYcL4wUSUhRV3vTGfmBb91Uikgum9lrDU6UB8I8zYSIwPVQGNcrY30aYX7muAef1iFHLnnGkvVTbmJ7E4o6cL5dJ3wmLNDl4wfEwfMOB1ezZflwIF6Qd1jA9OBsnoC4y+cBt9z69Ogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=mYt5vXd1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dbd32cff0bso9671585ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709217524; x=1709822324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ovH92alGJPjHMagml3lx70tu4OqX/bHmHdTqKi6ex+k=;
        b=mYt5vXd1T5Yj/uIMYhlhgYGTqDHWdnQH8W+lsRDtGAdQRcRJpnc7FU3M0wRDsOI9At
         Arn1IMysKRjAsSl/rxIj8IG3AP4I97RjpsmeDaqVx9exlPp+DGd0a8TcIMXbqek3AB5e
         ewkULoDczButUnx0O7mL7B5UfJIJ40/riba0HWI3rfRKoBAbnD3+2L+T6cj7J9mP52+J
         zVMqHNj8Z31G8/EL1qwHlRw4IN3kFRWzhAXDhpiz7j5i7lNC2QYE6yHt1FC/0AahKgRx
         oDR2TH9IdNVXg5zxJ7dpXI9vofFoMIneHIMve+fI0rO/eblFB3ZlSIfR1uvAMRaLZNix
         CnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709217524; x=1709822324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovH92alGJPjHMagml3lx70tu4OqX/bHmHdTqKi6ex+k=;
        b=fENG/Kb8GjjDIfK9+TSrkLy4rygM/LaLuI9dOvjvo2lNa0ehDpERCZDTL6vnCO+w24
         VXvGOYB1UXAWjZFVOzw/T0hA53J1DDC7jB0Vqatd6IkGwqKZ7W9bQ/g20fLF9gBrfvP2
         Ph7kUeT2PH14UBMCtBqt8RBf3gxrcMdwl8hzUFfvSUO79/2IL3CQ/L8BcWx9MU8uMbJm
         8oOikf6nwyGfjUv07EfAogv3WjbJlXW6cLqikktwV5gv4QL9qFCCcJpd7jQf/UrALE4N
         s+dzXolRq99rHgyoTfZjKslgRUyyWt2J3jqQHzB3ZGzqmRF5YgHLKDHOgRDHTIL643q+
         PeiA==
X-Forwarded-Encrypted: i=1; AJvYcCXy6ud24naOFlarJ7pOtDtDqNYX7UCbgLiKSvP4Uj3RRJGW0zP7bbr7kQKXGzWDlDMfNWd9gZ5Frn/eFUNUzZDBEbHZEVwKNF5wxnZ7
X-Gm-Message-State: AOJu0YwjaO6hRo4SNGmAjCg+A1RMERxMnX5qelb807NZOhZdDKjiNIXU
	YC9TNSSdWMx9H07fdmY+u8rJi1mOeFh4kr94plaRo0yMHbrbST1vHWNGOP4gsewO3XMfxE2Op/Q
	=
X-Google-Smtp-Source: AGHT+IGZ1log36VMtE5h4eVg4BqFBZpMh6ssQ+jauSzwFcFX7v1a7ZYEKHkDGSDxxL1HqXMm7lHAOg==
X-Received: by 2002:a17:902:ed0c:b0:1dc:26a1:da26 with SMTP id b12-20020a170902ed0c00b001dc26a1da26mr1968539pld.30.1709217524532;
        Thu, 29 Feb 2024 06:38:44 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id l3-20020a170902e2c300b001db82fdc89asm1552912plc.305.2024.02.29.06.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 06:38:44 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	shuah@kernel.org,
	pctammela@mojatatu.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	victor@mojatatu.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH net-next] selftests/tc-testing: require an up to date iproute2 for blockcast tests
Date: Thu, 29 Feb 2024 11:38:25 -0300
Message-Id: <20240229143825.1373550-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the dependsOn test check for all the mirred blockcast tests.
It will prevent the issue reported by LKFT which happens when an older
iproute2 is used to run the current tdc.

Tests are skipped if the dependsOn check fails.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 .../selftests/tc-testing/tc-tests/actions/mirred.json      | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
index 795cf1ce8af0..b73bd255ea36 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
@@ -657,6 +657,7 @@
             "actions",
             "mirred"
         ],
+        "dependsOn": "$TC actions add action mirred help 2>&1 | grep -q blockid",
         "plugins": {
             "requires": "nsPlugin"
         },
@@ -711,6 +712,7 @@
             "actions",
             "mirred"
         ],
+        "dependsOn": "$TC actions add action mirred help 2>&1 | grep -q blockid",
         "plugins": {
             "requires": "nsPlugin"
         },
@@ -765,6 +767,7 @@
             "actions",
             "mirred"
         ],
+        "dependsOn": "$TC actions add action mirred help 2>&1 | grep -q blockid",
         "plugins": {
             "requires": "nsPlugin"
         },
@@ -819,6 +822,7 @@
             "actions",
             "mirred"
         ],
+        "dependsOn": "$TC actions add action mirred help 2>&1 | grep -q blockid",
         "plugins": {
             "requires": "nsPlugin"
         },
@@ -873,6 +877,7 @@
             "actions",
             "mirred"
         ],
+        "dependsOn": "$TC actions add action mirred help 2>&1 | grep -q blockid",
         "plugins": {
             "requires": "nsPlugin"
         },
@@ -937,6 +942,7 @@
             "actions",
             "mirred"
         ],
+        "dependsOn": "$TC actions add action mirred help 2>&1 | grep -q blockid",
         "plugins": {
             "requires": "nsPlugin"
         },
@@ -995,6 +1001,7 @@
             "actions",
             "mirred"
         ],
+        "dependsOn": "$TC actions add action mirred help 2>&1 | grep -q blockid",
         "plugins": {
             "requires": "nsPlugin"
         },
-- 
2.40.1


