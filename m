Return-Path: <linux-kernel+bounces-162926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F508B6250
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF1228277E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF9B13D284;
	Mon, 29 Apr 2024 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbRgJG93"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F35B13F006;
	Mon, 29 Apr 2024 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419150; cv=none; b=kNUFLfTvGrrj1+Qr95AUo2pv6t6K5HJmyDCkbso9Y5KuZYQGRxD3FYM8KXR452x9/q1gs4+wHIiSshXN/r93ena/ntbxECrGF6lRkBGsXkm7xIep4uEftiMDv1ripa0rjfDlxmAoVVkCFlhzIlKbRqbQVrVfk0WASH2Ri2hQiTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419150; c=relaxed/simple;
	bh=SdFFA2BcFRlqHysTWrsHwiAMVHKDHj/keJ4f8SVLTv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYAZAN8dlHL1rkDdzXaos5aNPARUbChY1DyRZEBre5Ltt8DrPYk36ix9+Ja7rdWDB63Dtbz4a80sFMgT22+6p6N6aPSXxblcP43Wn7EbToJ1sr9o0kFXNhZhtwyTWhnzTRA9StumZscmA6si/Pqa+yoMvtriCt3tmCFH2Q3cv7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbRgJG93; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7da939572b5so196844239f.2;
        Mon, 29 Apr 2024 12:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419148; x=1715023948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKfAMNS/turac8Euh1DGMMYVBr0Lo7lNnqANki4j/jU=;
        b=KbRgJG93BRq7udPFMziS/sd4Zz6PshfPVyo7fKZ0z0thEKEhx5ryorOc55GXGb8xI0
         yzt/Dljy6+DFFMJSqKpXKviyoxZR0Lg16v9HD+lL1vui2DSEF5sym8HxYWXJJV95NLWs
         k/O107ocNPEtunu43wR3/LDf7PvUvU8DqP7KyjE3l+fAKR0vaxM5DGmZKMvyaYvSV7LO
         ZEjWMx4OSfki+nJTTVpee70eUP2dZuaUzk0037vayCY55UvPyPHfmW09Sj0L4tKnERBG
         4IMD6QCoSLhVBADSH8YikfvfYwHUlIGu2njDcCjXCSCc39cdqSI+pm5QDLnODK2bZOSK
         xofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419148; x=1715023948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKfAMNS/turac8Euh1DGMMYVBr0Lo7lNnqANki4j/jU=;
        b=i0IyfLKPoilM06B4JHJ01ROly3VfifHwjLVTujrDmo9M0QUC0TjPU/61y2pAtJNlC0
         ytA+WXzSjH1kwk7XXQyOUIYgx+A/kCGZJQ7gNAmJcPgM1CI2zPO2efpswfs14msP6g1W
         UM0cfZTH5bh8b0gUgU4Y1eetPWT57By1rXH8vcfXU4qxzS2YMNj/wPP8AjiI/w6dhzPn
         qqRsrtLe18fBoLcQgD+3SdgrFu9Z7r30n3lmKVBSV2xE0Sy63qbY9wj0hiVQSG2eXmQv
         KaUGD+jlbgLh0iwlgGBOq74piQgD9Ln1MFt3gokMuqH88MF48GaocKbGV6RAbfF/bX+1
         UEgA==
X-Forwarded-Encrypted: i=1; AJvYcCWXyAXGhtAWLuZCjOcZkBETj6JjCCUfITODnMaL0eySakF4Yrzzv+Wi0+IZyITiFNXEQ+Z2qxhBO8/g7fgqEDmHV5roDsYPmBDvGXln4/taAMBlk/dx+Hp16SQYPLZPlfdK5iRZlKKQ
X-Gm-Message-State: AOJu0YwzzHXmeBQ0sfhC4oK6Tm7llqW2VxtDIHFXjzW3x9mXwt5VyvW/
	m3+R40CFo1VHj4v53CZgq0/5wFSE4WRZVdnnXvzxRsDZohvGA0Op
X-Google-Smtp-Source: AGHT+IEth0HTnZ5OjESwCh2zXJmE39PxG7k0cYJbZH8j9ndGkh1CAoNC7wcLskVxQu1dIKAOj0Zcwg==
X-Received: by 2002:a05:6602:1dc2:b0:7de:a849:688a with SMTP id hk2-20020a0566021dc200b007dea849688amr13589788iob.4.1714419148411;
        Mon, 29 Apr 2024 12:32:28 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id dq18-20020a0566021b9200b007d5ec9b77aesm5988402iob.51.2024.04.29.12.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:32:27 -0700 (PDT)
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
Subject: [PATCH v8 13/35] dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
Date: Mon, 29 Apr 2024 13:31:23 -0600
Message-ID: <20240429193145.66543-14-jim.cromie@gmail.com>
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

old_bits arg is currently a pointer to the input bits, but this could
allow inadvertent changes to the input by the fn.  Disallow this.
And constify new_bits while here.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 882354e1e78f..d4a0ae31d059 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -597,7 +597,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits,
+				     const unsigned long *new_bits,
+				     const unsigned long old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -606,12 +607,12 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	if (*new_bits != *old_bits)
+	if (*new_bits != old_bits)
 		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
-			  *old_bits, query_modname ?: "'*'");
+			  old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
-		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
+		if (test_bit(bi, new_bits) == test_bit(bi, &old_bits))
 			continue;
 
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
@@ -623,9 +624,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
-	if (*new_bits != *old_bits)
+	if (*new_bits != old_bits)
 		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
-			  *old_bits, query_modname ?: "'*'");
+			  old_bits, query_modname ?: "'*'");
 
 	return matches;
 }
@@ -681,7 +682,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 				continue;
 			}
 			curr_bits ^= BIT(cls_id);
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits, NULL);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, *dcp->bits, NULL);
 			*dcp->bits = curr_bits;
 			v2pr_info("%s: changed bit %d:%s\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id]);
@@ -691,7 +692,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 			old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 			curr_bits = CLASSMAP_BITMASK(cls_id + (wanted ? 1 : 0 ));
 
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits, NULL);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, old_bits, NULL);
 			*dcp->lvl = (cls_id + (wanted ? 1 : 0));
 			v2pr_info("%s: changed bit-%d: \"%s\" %lx->%lx\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id], old_bits, curr_bits);
@@ -745,7 +746,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		v2pr_info("bits:0x%lx > %s.%s\n", inrep, modnm ?: "*", KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, modnm);
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, modnm);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -758,7 +759,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, modnm);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, modnm);
 		*dcp->lvl = inrep;
 		break;
 	default:
-- 
2.44.0


