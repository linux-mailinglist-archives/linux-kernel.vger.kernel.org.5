Return-Path: <linux-kernel+bounces-11713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B024781EA64
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 23:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF271F21806
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 22:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70B0F4F8;
	Tue, 26 Dec 2023 22:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FXUlIRaW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A41F4E0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 22:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e8d2c6903dso75253607b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 14:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703631129; x=1704235929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mzTueDBgYbCYMtNcPW/ZXt1x3+S6qKoIxNkZJZ91Oio=;
        b=FXUlIRaWtmjIw/SgbszdN0wbYPSNzlYylqsmYxHaLMtLKYAiYKiRMjDx5iOFw8rA+5
         2lxnDVux0TxOH16Yj7aqcicWkbRWHZfy/Q3YSWSZH5LlEVYR6AUr0TIObUr7of3SLPDo
         DkMZX3oRh7pERMwpNvq5nY5nCRg0aB3YyZo/Hvp5wU7odbJUxCmyUF9vaYa6HwYU62f8
         CuAjFJVQ6Xp+qhv8i3Md73RlnihBqC5rEDOsB7DO/5m/J2qhi7hppMZnoCTemfP9/BR0
         4qQa/PG3xaBFRzXcGO4NA4QROTlcFIxCvpKWALSa9YRTzwFGTmC6xLBfJsihEbRDRrWe
         WTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703631129; x=1704235929;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mzTueDBgYbCYMtNcPW/ZXt1x3+S6qKoIxNkZJZ91Oio=;
        b=BmrH3WaSmYExSwFD0xg2k4Dwiev4BHFtU8y6rOF5xO9nX8Q1NWCKsoYsyTX/+BCxQi
         nsZ9enRe4BvXYGqFquZQ7/YgdsxZ5ySD3TXEiVVVnk1q+PnvskF+9/Fr2ZClwrZmpbEm
         QkJC5GGi93VxcJmHuxDgD7YjiFwPl1Kc72yACFZNKTxKsBYkaQYmP+m1dt+eBl/jifuK
         AHKfjJvk+TxKXNV6Hn+HhkrYSZYFVoTfD+C8Lo97/Iof47mzeAMHC+mKgSgN8c1TuL+A
         HC/whv7vZcv+G3AxgDNRI+WWo2rAb3zzv5qpBLD2txemO+jMy67D5mynAQ+sthy+1iAf
         5rDA==
X-Gm-Message-State: AOJu0YyOjZuDt6MPqifhwRGB/7l/NwKXxfeBwfePCRAUG4A2rsXCso/v
	NnugkxNowTiQor58JeXv9g2mjTc0sDC8ytqmsxI=
X-Google-Smtp-Source: AGHT+IHmkLp9zCgFIkXlv29fXs4K1hw1q2LfxoR7SJPF8ZUVtoKtuxAVyzmE6eIl2DzCtlp6KUxgHOQhorBp
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a05:690c:c07:b0:5d8:eec5:f57c with SMTP id
 cl7-20020a05690c0c0700b005d8eec5f57cmr3925471ywb.4.1703631128933; Tue, 26 Dec
 2023 14:52:08 -0800 (PST)
Date: Tue, 26 Dec 2023 22:52:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABJZi2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDIyMz3eKM3NRcXcNEE5PERGMDi1RDCyWg2oKi1LTMCrA50bG1tQDtF0z qVwAAAA==
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703631127; l=885;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=lFyXVeGPL3vo9n9kpnUUAeSyU4Fs8lzXGF8YLokOzf0=; b=9Xa0bvuR+tjK+y2PlEDnlNXKQ5ltPkXju9aPZMeW6lS0etlh0KD2QWtCV7S3DxuxJiJ9Fkce6
 SJFhMkbfSf7CAgvWdu03juKl4IddKBAiJ9Efk6N1hq42y6b+DEdn9Xl
X-Mailer: b4 0.12.4
Message-ID: <20231226-shmem-v1-1-ea15ce81d8ba@google.com>
Subject: [PATCH] firmware: arm_scmi: removed asm-generic
From: Tanzir Hasan <tanzirh@google.com>
To: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Nick Desaulniers <nnn@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"

asm-generic/bug.h can be replaced by linux/bug.h and the file will still
build correctly. It is an asm-generic file which should be avoided if
possible.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
 drivers/firmware/arm_scmi/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/shmem.c b/drivers/firmware/arm_scmi/shmem.c
index 87b4f4d35f06..524509f4468e 100644
--- a/drivers/firmware/arm_scmi/shmem.c
+++ b/drivers/firmware/arm_scmi/shmem.c
@@ -10,7 +10,7 @@
 #include <linux/processor.h>
 #include <linux/types.h>
 
-#include <asm-generic/bug.h>
+#include <linux/bug.h>
 
 #include "common.h"
 

---
base-commit: fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
change-id: 20231226-shmem-1a44aa308e18

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>


