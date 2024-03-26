Return-Path: <linux-kernel+bounces-119703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B59588CC39
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA341C65A78
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D858613CA98;
	Tue, 26 Mar 2024 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYMAHjHt"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8433913C9D6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478767; cv=none; b=h8rTmCx/2/8lUh+UEJhyKXTYK1EmPl2Mc5PDl6LGpFBhOKxDGNJqCSCpK68A9ZD0w6QXPRgT7vGWwT70cNa2zmhnwIqE3+aR2+yIcaIdHCYMaN8isdcLfRHbJTnBPOZ3z3PKnJtJjqSkFBFZqbQjDnDkyUbUqf8+o0QaYhX96J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478767; c=relaxed/simple;
	bh=kCyQ979AVJ0xdrSEgkcxGjUENL4xlQ2T9QgRwAx/dLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lEOrkSXgijd4UMJkeb1BqWIMgSiyIgp7SsBs6weOqW6D0BnWJ1OIOTANtd4wbQ4ky3VKNm/cUqIINyZr7Y+pNxnkrsmnEr58l3NG3t8MKlWhVikVcql4UDeDjfWdDCg8+i5SfTADS41pVlZSoX898CJDuXCG9vdBkhWCJyOBiIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYMAHjHt; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so78612901fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711478763; x=1712083563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ldBOgjbepYPciYaLHBtp2xoQsBifAEwo23Ufds/fgw=;
        b=TYMAHjHtxdFicsSC76judKvGehkf5KyjfNY7CLHkTC8ylsBWJ7vBh2j/aF/N7E/QIa
         oOVWF6HWLXGs8E1ZKyQ9OZCvoncn8HZrQ7uvozUJ6PFkb+8YZ8ABI8Bv5zIPoKkqMf+I
         k0hbA/BJTNsPIO2Tr2J+7iMGp+nhdxGZZhwmMJuMbfKVZYQlLcRZhMM1psc7SF9UyOdK
         +fKESwrY2mGCOaGw9cbRCycj6JcC/BEFIr5eKF+0DhSngAYVU54w4Xz8L/25fHy+acxs
         C95NputAVBBwEui9Cnd4Q/6JtJ4FplSKXEGUSlMT0f0Pw2m05zQpyzp0sAM7O+OFLn+w
         4Ncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711478763; x=1712083563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ldBOgjbepYPciYaLHBtp2xoQsBifAEwo23Ufds/fgw=;
        b=OM0eL7dLwhdgIM/Yqnzoyv1Nqx2fxIH+N4cROOjgQmPcVKk0QZb4QDwN7VHXSdqlHr
         /4l6MMUsabsGRX2oZcILw01hm4GwkLE38CJzp4nLWkXXIUlgqtgr179zVAjh/Rme0By7
         IWu5IaXatlLlWW4s35x9WIYruFmi/8mQp403lmgw86u1oYVsmPf0rKPvfMzoU2Kq0j3Z
         YUxHQowSdJcaOkWOr6inIwzcuua+obsOGaGAWsQTopJLeNizRRfGguC/BYGCyizTl55M
         3HOGsZbt5IHSP8W1vliqT5N1JYAp3OhlqnJKH4ImMUwpDCYNabWwHV8JzWgOGVyiLkxe
         IYPA==
X-Gm-Message-State: AOJu0YzP6VQWCQTuac0I2culs/8DqPGlW8EJb2ju7mHvYJZkPdJKh+6G
	3bwOl+wFkFdoti202WHZVkoV3q7ZgmRNa/nIgUAQdigvZXfORaXEyLNUiWad
X-Google-Smtp-Source: AGHT+IHistzYneoiKIftyZzW4I3+XZL2PkZbDqJAVmOmB2N8m6xuD2IiTNtdXa2at08zOw5IndFWpA==
X-Received: by 2002:a2e:a309:0:b0:2d4:9936:a45c with SMTP id l9-20020a2ea309000000b002d49936a45cmr337861lje.41.1711478763187;
        Tue, 26 Mar 2024 11:46:03 -0700 (PDT)
Received: from localhost.localdomain (109-252-14-191.nat.spd-mgts.ru. [109.252.14.191])
        by smtp.gmail.com with ESMTPSA id u2-20020a2e2e02000000b002d69b9a6513sm1855621lju.48.2024.03.26.11.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 11:46:02 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: linux-kernel@vger.kernel.org
Cc: maximmosk4@gmail.com,
	Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
Subject: [PATCH 2/8] cgroup: replace seq_puts by seq_putc
Date: Tue, 26 Mar 2024 21:45:58 +0300
Message-Id: <20240326184558.8583-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326184514.8478-1-Maxim.Moskalets@kaspersky.com>
References: <20240326184514.8478-1-Maxim.Moskalets@kaspersky.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using seq_putc for single characters is faster and more appropriate
than seq_puts, since only one character is passed and there is no need
to use a more powerful and less fast function.

Signed-off-by: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
---
 kernel/cgroup/cgroup.c | 2 +-
 kernel/cgroup/debug.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a66c088c851c..011db8474d69 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6300,7 +6300,7 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 
 			seq_puts(m, buf);
 		} else {
-			seq_puts(m, "/");
+			seq_putc(m, '/');
 		}
 
 		if (cgroup_on_dfl(cgrp) && cgroup_is_dead(cgrp))
diff --git a/kernel/cgroup/debug.c b/kernel/cgroup/debug.c
index 80aa3f027ac3..d18f7dcb4def 100644
--- a/kernel/cgroup/debug.c
+++ b/kernel/cgroup/debug.c
@@ -55,7 +55,7 @@ static int current_css_set_read(struct seq_file *seq, void *v)
 	seq_printf(seq, "css_set %pK %d", cset, refcnt);
 	if (refcnt > cset->nr_tasks)
 		seq_printf(seq, " +%d", refcnt - cset->nr_tasks);
-	seq_puts(seq, "\n");
+	seq_putc(seq, '\n');
 
 	/*
 	 * Print the css'es stored in the current css_set.
@@ -159,7 +159,7 @@ static int cgroup_css_links_read(struct seq_file *seq, void *v)
 				extra_refs += extra;
 			}
 		}
-		seq_puts(seq, "\n");
+		seq_putc(seq, '\n');
 
 		list_for_each_entry(task, &cset->tasks, cg_list) {
 			if (count++ <= MAX_TASKS_SHOWN_PER_CSS)
@@ -189,7 +189,7 @@ static int cgroup_css_links_read(struct seq_file *seq, void *v)
 	if (!dead_cnt && !extra_refs && !threaded_csets)
 		return 0;
 
-	seq_puts(seq, "\n");
+	seq_putc(seq, '\n');
 	if (threaded_csets)
 		seq_printf(seq, "threaded css_sets = %d\n", threaded_csets);
 	if (extra_refs)
-- 
2.39.2


