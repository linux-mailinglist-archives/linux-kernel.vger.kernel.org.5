Return-Path: <linux-kernel+bounces-162914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD148B6212
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6A01C21104
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF41C13B587;
	Mon, 29 Apr 2024 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSsEnDau"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AC813AA5A;
	Mon, 29 Apr 2024 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419134; cv=none; b=V+dmFT+Ett0c2peW4tQ5xMjuWy+XcHOK9v5kGIBpeQ59kG5dr0gRz4kQyMLrHP+JtL3sEFB26TPL46K3hMVJWH3wOkTc3MFTUq3pE+PcT+41mqkmHt2EsuNx5XgQJHlo+naJOk73dQCyliPdY9qerg8IRj44WFFXE0cqrf3CtUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419134; c=relaxed/simple;
	bh=MxxpWFWIkQTnaHMmRSSNu1GlLY2Bctt1yjxnIAL7ar4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwcDHnd9u5YoYbmQmTejD/EOdFznTAIzO1eCfTDPTaf1Ax9pWqdRpO/gUJPRdoT6iiepcwe26qX8FfNIZk6fx3/sTkVsswKenvIqyl+730CV99tJovzGIOqpg4H0hYYXto9mDhmPpipqv1KTl21jH8vEte9N+JsnlhxMU1T2XM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSsEnDau; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d6ad896c6dso215357539f.1;
        Mon, 29 Apr 2024 12:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419132; x=1715023932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ap0abnHnzuA+pCntBOpzm99vZ6Zv5ODzcROoP3CQSrg=;
        b=OSsEnDau1VjQGx8YkSLalVJRWqWN1bRmA9+G9st5w1h74n+bqM1uapiXx+5T1p4YFw
         NozIf/qtgApZPtglsaXmjCEO/MdHUeOocnGB2TFl2RhBV68SeH9UlMuagdOHPzvFFgcS
         5KvYmxccYhdcQpAaN45Z9fEMT4M0OFbcWqnD20wEUuuLP5EdHXyBWrsTc+6jz0du0eFp
         Omx0a64u0fnhPc+yjQKD2HKtkmnJOQc9GbtF2UO0AFORpA9XsSzG8y+IKI5oAZfL9InL
         DQ2Ys09Kzr1XDT7pZ5XL/UmW4q3iTisNRAO8chwv6AJbgb8f3asCY4arlnxgzPN+ZL6z
         FhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419132; x=1715023932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ap0abnHnzuA+pCntBOpzm99vZ6Zv5ODzcROoP3CQSrg=;
        b=JLP4bXxzRhewUjKR3MwK2tA8wY7P3s7rZo5hrpHqgs1IQOv9d002qWG0XNcdCvVLfx
         8SToQ7dhOPI0rfLFVNDNyDilZ4gZ7j4mOb0bmAeO0Zf1TbZL660vTnFrtjeFLV90c9FF
         TsWFR6YCF8DumcVC/bgJWWH+W4YbkLVB3JBZ/zyjbKFu9YzO7HJvEX6mgyODmhVB1t3K
         kdSnrFKEUaSIL0Ovexio+1WuUsp7udAQyfhtm6qYmIwfIXI3S0Z+U4K6lc/20sMKpOV9
         F9nSNi5geoRqCTFEiXmoYEUGsalq42/oantPA8Ax6CBy24jH8VLeAqWdRor7wHitcviM
         EamA==
X-Forwarded-Encrypted: i=1; AJvYcCWqmst+evQn8gWvRirg/ZaWp8QLTws+EOYx+JMk1L/qiNj53+J2CgR1rJjRY8/MUYsxynFb3t6dJRZ17adJSV4O2DMbGsHNr5kYBw9GXIOB85el9TIbLFhWS5vA6dRukzFR7XxkAfqB2Sj+5Lxo86BZMA6NT7Sjfu4PjkmExS7O
X-Gm-Message-State: AOJu0YyXV4Yk2h7ZYCv32TWqCnzBszodCcC89QNlpKNnVVvewuNcjRYS
	DPCIjHxBOw2Ct6kYJL6GmAwH0+pbUegvcYRhlVne6+2jg61jKq8a
X-Google-Smtp-Source: AGHT+IGRdeeN+u2zMfjhDij9Il5S46oy16VyUUR7QmAHR8HDMNzTIxpnF8fD58yH4IXlMsHdP3l6HQ==
X-Received: by 2002:a6b:6417:0:b0:7d0:8cff:cff3 with SMTP id t23-20020a6b6417000000b007d08cffcff3mr13514911iog.8.1714419132083;
        Mon, 29 Apr 2024 12:32:12 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id dq18-20020a0566021b9200b007d5ec9b77aesm5988402iob.51.2024.04.29.12.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:32:11 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: ukaszb@chromium.org,
	linux-doc@vger.kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v8 01/35] dyndbg: fix old BUG_ON in >control parser
Date: Mon, 29 Apr 2024 13:31:11 -0600
Message-ID: <20240429193145.66543-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429193145.66543-1-jim.cromie@gmail.com>
References: <20240429193145.66543-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a BUG_ON from 2009.  Even if it looks "unreachable" (I didn't
really look), lets make sure by removing it, doing pr_err and return
-EINVAL instead.

cc: stable@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c78f335fa981..f2c5e7910bb1 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -302,7 +302,11 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 		} else {
 			for (end = buf; *end && !isspace(*end); end++)
 				;
-			BUG_ON(end == buf);
+			if (end == buf) {
+				pr_err("parse err after word:%d=%s\n", nwords,
+				       nwords ? words[nwords - 1] : "<none>");
+				return -EINVAL;
+			}
 		}
 
 		/* `buf' is start of word, `end' is one past its end */
-- 
2.44.0


