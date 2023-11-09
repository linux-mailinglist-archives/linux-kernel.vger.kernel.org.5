Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3316C7E64BF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjKIHwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjKIHwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:52:01 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B07719A3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 23:51:59 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b44befac59so1330402b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 23:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699516319; x=1700121119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n8kI9UwJGdReYGKa944trNcHcU3YT757mZ4WuJyOmf4=;
        b=NyKLgokmqH2Wh86sbPRwnkVgIiX6af8Nr5tukVIxo5Y5S/Zgzztj57X380x9lYahi2
         UOkNprM/NaQegajEAYBuL3xy1BKIQCfVDJQNfolBjUDKnDAs+0d/uOdWOiAHsWvjGsOE
         vPbUh7eVBslQkLNKGl1R1Q9CCuP4UvlUmsx0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699516319; x=1700121119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8kI9UwJGdReYGKa944trNcHcU3YT757mZ4WuJyOmf4=;
        b=SCf5f+RyWJSerteCQNQn2JweqqfYngzjcZyFMCF7MxH1CIP8IC989PRSu/pftVV0ol
         Qlf8awt9MgzcX1bGTeQcf9w5pQHgdMQdAIuGyg2nnuIBksRABGADkYZxQL9DFMJNXreg
         Ar3FSODEHKCfmGRQhRIyLKJ2q4UvraatvyZv4Z1Slcb8CC7uIaw65+R5l7bhSxmoImMP
         a+kjP8pBJ0kDmCQCJKNW50Yohu1vnswVOJz9BwulrxCskRQ7J4/nbQavZSIQcXTDO7KJ
         9Y49D5/VyDBKpVJ3bAy3UuQyFlrpb8lzNAoAhssvDUPYww7Mbmw7+3BqKILOdY64W4lr
         +Sbw==
X-Gm-Message-State: AOJu0YzhmFMFCs6vpv1ddi0rHt4m6C+irmTLGyS+8kWaH3ojARxWUtcE
        by0rkuQmLCAS7nhERfzS4Pt/Rw==
X-Google-Smtp-Source: AGHT+IEBqLRG+PgqmeeXfwxIbLp4SSXoXRShAqjC5aVkkgrVEdxU6mExfjBMSbXup0ylcw9XeWqkrQ==
X-Received: by 2002:a05:6a21:6d90:b0:181:8654:8284 with SMTP id wl16-20020a056a216d9000b0018186548284mr9852558pzb.24.1699516319028;
        Wed, 08 Nov 2023 23:51:59 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:30b0:eade:dcc0:28e8])
        by smtp.gmail.com with ESMTPSA id h25-20020aa786d9000000b006be047268d5sm10418692pfo.174.2023.11.08.23.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 23:51:58 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] checkpatch: do not require an empty line before error injection
Date:   Thu,  9 Nov 2023 16:51:38 +0900
Message-ID: <20231109075147.2779461-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ALLOW_ERROR_INJECTION macro (just like EXPORT_SYMBOL) can immediately
follow a function it annotates.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 25fdb7fda112..a94ed6c46a6d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4054,7 +4054,7 @@ sub process {
 		if ($prevline =~ /^[\+ ]};?\s*$/ &&
 		    $line =~ /^\+/ &&
 		    !($line =~ /^\+\s*$/ ||
-		      $line =~ /^\+\s*(?:EXPORT_SYMBOL|early_param)/ ||
+		      $line =~ /^\+\s*(?:EXPORT_SYMBOL|early_param|ALLOW_ERROR_INJECTION)/ ||
 		      $line =~ /^\+\s*MODULE_/i ||
 		      $line =~ /^\+\s*\#\s*(?:end|elif|else)/ ||
 		      $line =~ /^\+[a-z_]*init/ ||
-- 
2.42.0.869.gea05f2083d-goog

