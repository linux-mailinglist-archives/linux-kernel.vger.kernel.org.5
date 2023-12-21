Return-Path: <linux-kernel+bounces-9046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA76081BF93
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1987D1C21740
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA615768EB;
	Thu, 21 Dec 2023 20:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3+JqzNlF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FDC370
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e786bb28a4so25563787b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703190756; x=1703795556; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iV3pHD3dLDjn2ROxOXnqgrLZZtWXQoFaEfuMaFId/0A=;
        b=3+JqzNlFUYRrCJadJ0IWWHHcj5NYAIgBLeKGMuQdCKJilHAu5vuI6btOUUEbVtUtVQ
         gYYNgCp/B9sfe0aQFWkA0cYINS2aEG4KuA3xiKODYuyJeBJA6etRj+pvLDcsT/UuxgR8
         ABW8xDYTZPp6v5+yWhurZeIhMXp0Tb4j4AKjJ/3dOSwCxGxs/ZoKYhtG/OBpsdD3tGA0
         3JAJR5hWcxre6cL64V3mEjQa9ZspKg0ZRlD/JzCmaSQ6teulSW7CbEeiW5lRLZCpPgV5
         n4mm6fDQMNJgYHb+3gBvIuO7+1+OPptQ1hBgM4LVQqmUWjBGUjyA8QuL6Q8Nxmg6zEux
         SHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703190756; x=1703795556;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iV3pHD3dLDjn2ROxOXnqgrLZZtWXQoFaEfuMaFId/0A=;
        b=ethqYWpdjX1zMxiSLnBJ3w0mDO6ewgO/Ux9NQLXc1NY3QBR7a+ElhRj3OCVU9n5sLc
         NF64oulJ7Obp9fEIDS3FVkBpY24Ag+KS5sich6T1VZia+xD3wBDZ2V50p8thev/5LI99
         7Qlva6wT1T19GSoIVNBHM4PMTo/dfywGttj93ef8z5F9ADXee/CpV5BN7rHEmDKu0Hms
         yH2dW5TeWIV7SNx13w2Tb4soeCrx20vTqqvZ9hU/00fTBgXa6JoS6OCJK7Z3FeZTBws2
         q2dOaZ70U7dbDUE8mTYjS5GJIAevtCBbx/gK8KA479Ke5MCb2VeHpYGcfGZ16DAsTZrz
         Wf1Q==
X-Gm-Message-State: AOJu0YxNh/w2FXgbZ1+2v6dGd2IIJNdAqZDath6enUfSvgI7oaNvlWxb
	xiO4xBlpIDI+UrY8M0/IoYMl9PTggO9zaBpD5LA=
X-Google-Smtp-Source: AGHT+IGZFx/e3PMU9RCQVKC9HOvmeejycMJ0rBpdeGCbewHzRH6zPbFESQHR2kqVh8PPQTzF+WmH5dr9cRok
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a25:4f06:0:b0:dbd:b613:46a9 with SMTP id
 d6-20020a254f06000000b00dbdb61346a9mr448951ybb.5.1703190755832; Thu, 21 Dec
 2023 12:32:35 -0800 (PST)
Date: Thu, 21 Dec 2023 20:32:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOCghGUC/x3MMQqAMBAF0avI1gayCSJ4FbGI+tVtomxEBcndD
 ZavmHkpQQWJuuolxSVJ9ljAdUXTFuIKI3MxOes8O2fNqWGCIsy3ygnTILC3Iy/sWyrRoVjk+Yf 9kPMHVur4ZGAAAAA=
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703190754; l=866;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=qyvah2+uejd935j+AyakrSHmlj03YOjQFZBrRYM+gU0=; b=MgVwLJauBEeUoMIQPtbzgFq0GBH9nK7lwPadSi8lRKAEsr4rgyJ5zIRlHvPXcn/38DUbvVZHQ
 IKQBj3o9WW/DSdhaICyrFdpg8x8Q6Usk40cXWJ7NDzT4OGf469PV6cp
X-Mailer: b4 0.12.4
Message-ID: <20231221-tracereadwrite-v1-1-a434f25180c7@google.com>
Subject: [PATCH] lib: Replaced asm-generic/io with linux/io
From: Tanzir Hasan <tanzirh@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Nick Desaulniers <nnn@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"

asm-generic/io.h can be replaced with linux/io.h and the file will still
build correctly. It is an asm-generic file which should be avoided if
possible.

Suggest-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
 lib/trace_readwrite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/trace_readwrite.c b/lib/trace_readwrite.c
index 62b4e8b3c733..a94cd56a1e4c 100644
--- a/lib/trace_readwrite.c
+++ b/lib/trace_readwrite.c
@@ -7,7 +7,7 @@
 
 #include <linux/ftrace.h>
 #include <linux/module.h>
-#include <asm-generic/io.h>
+#include <linux/io.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/rwmmio.h>

---
base-commit: 55cb5f43689d7a9ea5bf35ef050f12334f197347
change-id: 20231220-tracereadwrite-5ea130b1f137

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>


