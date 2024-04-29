Return-Path: <linux-kernel+bounces-162917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4448B6239
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6171C211CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C85413C804;
	Mon, 29 Apr 2024 19:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj8OlTIw"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A64913C3F9;
	Mon, 29 Apr 2024 19:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419138; cv=none; b=iAqqrno45ZuLe1CpeD8XLCavKEGYOHxI3MAsueDiVgg2kqhZMlZtMHnYxckrGA+QIPCELCT8KrHyYZxsYI8Vz/Z2D5WgfqsCFaiORsd86R9tMvg+WenxKkFvISCte1/0ue6NpvwCLe9RCl0yES1Ps9T3a7YbZEyIoZaO/a2Vswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419138; c=relaxed/simple;
	bh=zMFmJJwULaWExvGol+TjNkqMC0083Zqrgkttkhvky2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pqng6XfY1S3+majH4ptN4I5swKnitvdoJjbbfFDwCAFxP150vaX6S7HtgJlcE9O3mHGSpnbaTYl+tVbjlw3bsa2TZxcPANi4mmykeiXsU5lpKral/KEjwicM3mreMVY8UyIGXUOKzEPv7cZXMNHICFKsyz+fmneSLhhq6Prrkiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj8OlTIw; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d5db134badso207093539f.2;
        Mon, 29 Apr 2024 12:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419136; x=1715023936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCusk8GKkQWxBikouf75pGq1h+EOpfhpPreu3ro8jhg=;
        b=Yj8OlTIwxVQ/9W5v1V9r39YKJOmWogRHpw9x7elO6heBT0ZF80YHeL4EJlEHsq2K5P
         dAifAGRZNOFaGD30WdEHFkRvFlo8Unim9I4tYDB7eqyATGnYfqPCaPXVd7+iL1LjMVvt
         Rboszt2fU7x40PifZdRLsDCy8niIT4ez1J2WQLzcnvA4TJNdqQC9jJEQu8PjKXixGUux
         RRZ9pdU3TBZ4yIbmOzPyTkmC4UOo8Y10eneAt1U7JktAmU3Cgy2DwKpDR6hyFiWYdI8u
         gXY5RKFywUmRxnC31t7PsfY3piAnUcAYcuDkhXmgwCKUaC70vdg5TSAo/NfcQdwgWHwb
         8yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419136; x=1715023936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCusk8GKkQWxBikouf75pGq1h+EOpfhpPreu3ro8jhg=;
        b=F9OeU68SZDZ3/9anFF7h2ZSJXcvC76UVM34gnTZH7/jlw/62VYB2PC0TOD9ZXfytwv
         HisVGVhIfDr9HKVJYlbjUZw9xfW4T6un2MTe2z7esUk8Gv60CFoDhHF7gilOFG+2J3ym
         pzAw0ygtPFORYJRW1svwpd0N6upMm5FCqzkKO6oBVHPF6rGjSKyexbHhtvl9IbU3MJkV
         2xaUhd+nI3KS9fgvNoLobJW6B+sFeh70E7kgBzVnYHNUwTePPUGwpVX1ELE9FI7cB0a0
         wHHxvGmJ3mGq4wILdmASQrg1TwiZilgtwnXXDyxt/H6MwZRTXlQv6SGHcdC+5twYr1hw
         gtHA==
X-Forwarded-Encrypted: i=1; AJvYcCWLMJRa4f/PQ+lv4wLgwaiLXFFghDj9DZF39HPJgPjRSgOCMyuQ+ugOFUc43d8UYgyiAqnxg57Sk5XbroW6rm+dATlx0j0dKd7BDn6PKxiZyaRARBJ2/vfpl1MKRILOa5LevOS0g7nr
X-Gm-Message-State: AOJu0Yx1GLnJ6LLq5WXJ3PWoR8FLfauX57hmcxgMcD6ApYFiUTp7Dfay
	FDyVPc4xBSjbkkOcDDebCZDG6/wsPptf+Qioi437wNBg9vu+Dk9G
X-Google-Smtp-Source: AGHT+IH14GqaWbrfrr+QP4SpVTkK0x2ngYDCiN8y24Rs/2jpEJrSfNm2tmzjuCieVqr3UxjfHAADGQ==
X-Received: by 2002:a5d:8498:0:b0:7d5:f78f:ab21 with SMTP id t24-20020a5d8498000000b007d5f78fab21mr13368096iom.11.1714419136396;
        Mon, 29 Apr 2024 12:32:16 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id dq18-20020a0566021b9200b007d5ec9b77aesm5988402iob.51.2024.04.29.12.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:32:15 -0700 (PDT)
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
Subject: [PATCH v8 04/35] dyndbg: reword "class unknown," to "class:_UNKNOWN_"
Date: Mon, 29 Apr 2024 13:31:14 -0600
Message-ID: <20240429193145.66543-5-jim.cromie@gmail.com>
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

When a dyndbg classname is unknown to a kernel module (as before
previous patch), the callsite is un-addressable via >control queries.

The control-file displays this condition as "class unknown,"
currently.  That spelling is sub-optimal, so change it to
"class:_UNKNOWN_" to loudly announce the erroneous situation, and to
make it exceedingly greppable.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f2c5e7910bb1..73ccf947d4aa 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1154,7 +1154,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_puts(m, "\n");
 
-- 
2.44.0


