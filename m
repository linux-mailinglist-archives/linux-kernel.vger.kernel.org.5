Return-Path: <linux-kernel+bounces-162918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 842348B623E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51D81C21287
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3F813C8EC;
	Mon, 29 Apr 2024 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0Wakq0T"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF9213C80A;
	Mon, 29 Apr 2024 19:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419140; cv=none; b=uA1z/VarXprobB4gLxlbU4geo3mw7jd2cImdJkWDNL2ddZAhr1fchv7hBtWb4OWO9PZ4tDw2EWuVK41+ppr+kab68KTgFYkWt5k24yFKb3D+7FP+Z13m2aAG08/yqNRYQ956BZ2T8ljTgV1P1aUWmoGbaZcUBppT+qCy9LgPfGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419140; c=relaxed/simple;
	bh=0VZIGUJY1APDtSuwKzyN0ZpIScK4yGfkshz8+aXghk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8Ne5v6EqkcQDJLk+8fxi3JIkyW/6WvWK4KoLH1Hrwx0ZVOMexJMi2JLS7JcA0If99NxjJ9muGg5VoPlMkDQNU8mZHuyR3ph9a9f9tfgNWGIlPCgDrs3bfNVLTvFjExcxp7mlWMlk7nTW+ZfL6Fr22VZAy9kczVgPDsLXsPh3Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0Wakq0T; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d9c2096c29so216604639f.0;
        Mon, 29 Apr 2024 12:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419138; x=1715023938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Joa2204E/UxJqisgLdnZkw4M+LvVemhw6NjXgwCAr8=;
        b=H0Wakq0TvLwWs6HTDcDMIClYkL/ti/IGbmeXCLBoc4WEpRMdUUGv6jS8oN/8er2LXe
         YOCihAiHFKG3RS7WLd1uh4wdooNDMHh7YMwqQGVNCogbNH9o2PqnrFO6HgNlvcM4LDAc
         cBxekralZO2HhyqF1j4ZpHiGnB8Eph62M5sa0pV6NRWfD3LP/ormM2PkV0xrh9zktqXT
         /BhscPyHHpAvwfhrQ2f8aIaIMRilRKGGpkjXGXpKwzStU6dnD+R90PlDcd+sK2FLZg9j
         pIPI+7fp8unsL2B9vbDXWlPKJg/tgzzIMBclUCy6guO7pSO9wnwGfncZeFtXFZsQO/16
         2p4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419138; x=1715023938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Joa2204E/UxJqisgLdnZkw4M+LvVemhw6NjXgwCAr8=;
        b=vNBCTmFFklj+JVILYf7cpq9LjlXHUEHRHaBsq2utJVMRWyO19ww2S9emo9WsFs4IXQ
         3ofucnHQiWpXOjcsWgRakOvApXOon+QA1+6DsOMKET7aMJw57JOo9WO0P7E8MzgnehaU
         cJJir9d05v/EQBLt+8GaiNx/lnLld9Knuz+VYyWQN+3S58ftSdwsiEIQs9nsps5vV2Gk
         +HX4XgTen4Of/hVwIUFWC4pDS/EYDq3vqm9dx+DX0ipvS6/qCnTYwjTlmQsFxYxOJ5En
         Xfg609tif2moZLH2M+U7Yg/Furtv6cq3/qNdyHuhErqkAW/lFu1p5ETfFKgGqxnD5WUq
         BA0g==
X-Forwarded-Encrypted: i=1; AJvYcCUZZviWbUHuvSybT9Joqj8GpZ2ZXSQtgMFxACTcEk7ix5XwOrTTjCD/5qsgFhL8iDEMXvcLIniw7Kc81gBUUUk82AslA6AJQlGBABdL4CNRavFVNPlHIKnN1IMGYQ01wWyrsIziZB7z
X-Gm-Message-State: AOJu0YweJxOnYFTxt7s/BouHX+j5O+4TDKnbVeSw6KdbqYXOTH1Hi4cd
	nz8bQ1Zx6dN5wgYonUbt2eRq07qimaL7+NYZmmZKd4P/w2PRHajM
X-Google-Smtp-Source: AGHT+IGTiODmp9/Hpma4qTIBG+7epNiV11HavVT2L36uk4LXH9pCF0sExJNXdX3JVHjQXaLaCttUUg==
X-Received: by 2002:a5e:8704:0:b0:7de:d55f:c1d3 with SMTP id y4-20020a5e8704000000b007ded55fc1d3mr2588947ioj.17.1714419137797;
        Mon, 29 Apr 2024 12:32:17 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id dq18-20020a0566021b9200b007d5ec9b77aesm5988402iob.51.2024.04.29.12.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:32:17 -0700 (PDT)
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
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 05/35] dyndbg: make ddebug_class_param union members same size
Date: Mon, 29 Apr 2024 13:31:15 -0600
Message-ID: <20240429193145.66543-6-jim.cromie@gmail.com>
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

struct ddebug_class_param keeps a ref to the state-storage of the
param; make both class-types use the same unsigned long storage type.
ISTM this is simpler and safer.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 2 +-
 lib/dynamic_debug.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 4fcbf4d4fd0a..5231aaf361c4 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -124,7 +124,7 @@ struct _ddebug_info {
 struct ddebug_class_param {
 	union {
 		unsigned long *bits;
-		unsigned int *lvl;
+		unsigned long *lvl;
 	};
 	char flags[8];
 	const struct ddebug_class_map *map;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 73ccf947d4aa..152b04c05981 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -799,7 +799,7 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 
 	case DD_CLASS_TYPE_LEVEL_NAMES:
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
+		return scnprintf(buffer, PAGE_SIZE, "%ld\n", *dcp->lvl);
 	default:
 		return -1;
 	}
-- 
2.44.0


