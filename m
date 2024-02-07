Return-Path: <linux-kernel+bounces-56033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B27184C528
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC80E2863E9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA031CD3A;
	Wed,  7 Feb 2024 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RB9K4zZf"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689401CF8C;
	Wed,  7 Feb 2024 06:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707288711; cv=none; b=STtiU67VuNx8bIAZJlOisZxDFsMvoS9EL/xbYSTrKNeOlWyaQtR9DkiUjCaIHwCQ04EuHBYR3aMWAc57TTD39D9IoMkt/t0HE9xxXkdC4KwrmhXIA+PqVaiwDo4Ojag6L95gvmGgA3pQdbkGDwyVL30hozeNBUDSkLkJy46e6r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707288711; c=relaxed/simple;
	bh=Un6imQ0Se89xJmzC2upsuqaudSRJIPKdgjRiCf+0kis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AlvixN1OQpij8lEwqNOi9pRGe3Mt5SsnohnCNQYJPHA1EVGbhIf1UR7ByAgZh88He6q244uP/JKKtWHQtOmlM5izbnIcqnJZGbowgNe0fUeAz5rjIBL8ukhppRrivKnW4OKU6hT0DjrWckdP4CpFV2ktl0iYXryKMLgWE94NOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RB9K4zZf; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e06bc288d2so57817b3a.2;
        Tue, 06 Feb 2024 22:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707288710; x=1707893510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OsVhk4/iw8m5jCa9vNBoAYCL/UoZmovw6VE82rLNyc0=;
        b=RB9K4zZfBoGVz4AuXlO63JCVNrakqL6VeRfAJfETsfqcmnEeydn+vyqkmsIGoE2Z+/
         R0SV1OfNTO0eWEKhZjD6nsSjgWPXpC0LuCvgjO//pbUlm9SSUWLx5C4Nin03ROCXRqar
         8qK0is7J4cz2KhU9ug5qEIehXD9Ju2i4nIyQUNEcfbSaCfU9799oxCvNs5npC0t2mDQl
         txOKyHJoqrIl2yFOeV+uGb8LOnvw1f0BTK+YwfdlX8EMnTkwakHBEhPXYqSE2eP1dM1r
         q60uH05gAqqJf5jVhkrguwp0iWF26QLQB48TeLvxj0czMVlw4Zj9QwgYctk69n56M0Gl
         C1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707288710; x=1707893510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsVhk4/iw8m5jCa9vNBoAYCL/UoZmovw6VE82rLNyc0=;
        b=OaovGNhpyQKPesyyHul6YtMZjsTSFghKZHdhFGGvyxLhej/f0XHxaGPisdufgHGhj/
         XqTlX47fnvTHm/4Dc0W2pGWNzDm8Hpjr/I2XKntdTQD120gwImsqn8OQB10tTGs9NLlD
         QXOq5ZqtmoO+Rl/Pr1IAM1r1ahg2h6A7laLL1nn5T2UFv1mrUCto/P6muZsiLLX50lP0
         srSBoI//dWdXMx7CaKdwawYBet261iChWuozMcnTjerBSH2vZgf50QC627WsOghT6BwN
         uEkkr/IQcQOPOr2O9Dh91U1dg8HgjsMSa4ZwDF0FWgVJEXRmiLxTsXZ7qibpYMhfcQkD
         85rw==
X-Gm-Message-State: AOJu0YynM9j1TarfLiyDAuYqQSDyLj4N6KwMm6Lt2KaWpHwTCczTTsE1
	Vian9m0jCnrbwIt0BE/SPLWAk3L0hMozN0TBmCYn+HEqXlhjmvmq
X-Google-Smtp-Source: AGHT+IFXCjaaXWIUPJylAzcJmmD6TFWtc5MdJatF19jt16Hh1DeFrpb5C+u9VUpBkyHf8OOEParMgA==
X-Received: by 2002:a05:6a00:2315:b0:6db:b267:aee2 with SMTP id h21-20020a056a00231500b006dbb267aee2mr2144940pfh.17.1707288709697;
        Tue, 06 Feb 2024 22:51:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWe/AFTayeeqZNW74XOOicW7Ed3RdqFhCElLMg6DYeuJ1vTOCHL3xGTVaFJU9HqiD2LVleotB+9TAeN8CFsOGcvRBjd1B3/zLbirXGAITSB9LzmfyHCg6z3RSDUSTptBBjslruIWe0TRzKF9w9S4N5ioGwLOaTim2dtIBsVcfqfD845JeiCzrFZSqtAa1xG9akzyfYbNv5viSMftZjUG7oBDfpeUuDrvxidyZGFySltS+poCE1xBhaOOzr/Fz1G0iiV8pK/eYJNv39L7lSpBk5TcBfaeflOlJ0I/unfBnrzir4iGjGln0x6Y8xmqlx7lJrl
Received: from localhost.localdomain (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id z2-20020a62d102000000b006e0651ec052sm687274pfg.32.2024.02.06.22.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 22:51:49 -0800 (PST)
From: limingming3 <limingming890315@gmail.com>
X-Google-Original-From: limingming3 <limingming3@lixiang.com>
To: bristot@kernel.org,
	rostedt@goodmis.org,
	colin.i.king@gmail.com,
	corbet@lwn.net
Cc: juri.lelli@redhat.com,
	williams@redhat.com,
	bagasdotme@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	limingming3@lixiang.com
Subject: [PATCH] tools/rtla: Replace setting prio with nice for SCHED_OTHER
Date: Wed,  7 Feb 2024 14:51:42 +0800
Message-Id: <20240207065142.1753909-1-limingming3@lixiang.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the sched_priority for SCHED_OTHER is always 0, it makes no
sence to set it.
Setting nice for SCHED_OTHER seems more meaningful.

Signed-off-by: limingming3 <limingming3@lixiang.com>
---
 tools/tracing/rtla/src/utils.c | 6 +++---
 tools/tracing/rtla/src/utils.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index c769d7b3842c..159de175ebcc 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -479,13 +479,13 @@ int parse_prio(char *arg, struct sched_attr *sched_param)
 		if (prio == INVALID_VAL)
 			return -1;
 
-		if (prio < sched_get_priority_min(SCHED_OTHER))
+		if (prio < MIN_NICE)
 			return -1;
-		if (prio > sched_get_priority_max(SCHED_OTHER))
+		if (prio > MAX_NICE)
 			return -1;
 
 		sched_param->sched_policy   = SCHED_OTHER;
-		sched_param->sched_priority = prio;
+		sched_param->sched_nice = prio;
 		break;
 	default:
 		return -1;
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index 04ed1e650495..d44513e6c66a 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -9,6 +9,8 @@
  */
 #define BUFF_U64_STR_SIZE	24
 #define MAX_PATH		1024
+#define MAX_NICE		20
+#define MIN_NICE		-19
 
 #define container_of(ptr, type, member)({			\
 	const typeof(((type *)0)->member) *__mptr = (ptr);	\
-- 
2.25.1


