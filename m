Return-Path: <linux-kernel+bounces-60790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DDE850978
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 14:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2FD282ED0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469475B5B2;
	Sun, 11 Feb 2024 13:52:29 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FF35A4C7
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707659548; cv=none; b=tJMXn8XAwK2UqxCoSbs82tNABHgvLpdOWYPrLIqiqmYXCxC13uzqs441w547wuq9oJPTWb9vsFp8L4/SCH1rS4cCTW+9CE4NLkRgedLgHpcK6A0TlqgE4AP1l1X8ovLIApvdpIJiHckargsqiaUELUu7cLo6FPI0w7WO4/tH1hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707659548; c=relaxed/simple;
	bh=0X++hbDOXD50Nw+a1vwueSJjviqMRnGrd6GZTpX5e70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q+SyLdA41bCpfSZuUSKHcOdk0+L3dWFAsS/04fyDffBg+v/9HVm8sUM8T+sTxRjEPow1qNRUldo6oFJZNveV7rp1IkPLkPwfxrDLERqlXIJQnWCdajdA7o0s3C9q+H1TORWvIsqFGcz+n/UTxHdyqMWWPpDAjhAWksLF7p2gasU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc74aac68a1so2404153276.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 05:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707659546; x=1708264346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HlgapUubE5TgwcjYU1S02NneOF2XqCpP/rByk6oNb28=;
        b=R+CKU7cp6o5fLcNDp10hzMx6jvGGjw6pxNeUO1Qgz8baBl1tMBEls3SG9ps11QJCC1
         iymwFhMKPn4B33Di5k2w9iLa4elTmCqBehdWdiQ/SDDL2JX3gx9UAYfG4pGQxAA9REUH
         c/HN/TwAA7+cZm2z1pCQBwBR1jGBnngelqTNdjhavxByOoFRNF6iymUcEeqB3XJ2avS3
         SuMPijrrqOz66dUTqEAoRzD5JweAILHH6eFml9BZdUj3as0V44ZJcysGZqx0Ag7YDIvb
         kUlTctUV4cr3UDYAg0BxxdKgJ1mo9tqz0lct/2mCE6pDNseXLh1Bg/uLVpYYsT7T3p0j
         9c2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWajvKLtDkwrd+YYFe4Bspb2njG0Dp1aH/vktFLFKPpkQfQmgMG55+H3lgiRY7LZNL+LWzF29jmBixLf1EeKwZXKcl9GG0JTI3DPvdG
X-Gm-Message-State: AOJu0YwhCMOrD3So7cz+NaDhKN+VesW+4kRYVX18UjmfpyIDASzUN6s/
	fb0CYD3/Qo4/QYGaZ+krIrDrWatqqgEYy2p/Ap+wr8U1bddPdE96
X-Google-Smtp-Source: AGHT+IEcKpyCi+eu+JVIbj+m7y0he71ajPWKmHGuFJe9UnPtvZGJGboh9Mkqmjo2hJiCndPVLEbKnA==
X-Received: by 2002:a5b:14d:0:b0:dc2:2f7a:6dfe with SMTP id c13-20020a5b014d000000b00dc22f7a6dfemr3336242ybp.52.1707659546261;
        Sun, 11 Feb 2024 05:52:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCOgrFDt8NAgbrC6IkzrTbQRaS6+30OLoNziOsuE6wbWNWIuQQq4thPr2OaK8VR6lcmU3vE0Zbt2tbdmPf5wJFAsWwmlFisanVmYX2BZBpzNaglp7gktHl0sGGEsbEkVE=
Received: from costa-tp.redhat.com ([2a00:a040:1a4:9a9f:19ad:6a8:f94b:c9c])
        by smtp.gmail.com with ESMTPSA id ld27-20020a056214419b00b0068688a2964asm2717380qvb.113.2024.02.11.05.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 05:52:25 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Waiman Long <longman@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH] hrtimer: select housekeeping CPU during migration
Date: Sun, 11 Feb 2024 15:52:13 +0200
Message-ID: <20240211135213.2518068-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

because during CPU deactivation a timer can migrate
to isolated CPU and break CPU isolation.

For reference see function get_nohz_timer_target,
which selects CPU for new timers from housekeeping_cpumask(HK_TYPE_TIMER)

Inspired by Waiman Long <longman@redhat.com>

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index f82997cf53b6..460d916e24b7 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2227,7 +2227,7 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 int hrtimers_cpu_dying(unsigned int dying_cpu)
 {
 	struct hrtimer_cpu_base *old_base, *new_base;
-	int i, ncpu = cpumask_first(cpu_active_mask);
+	int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping(HK_TYPE_TIMER));
 	pr_debug("ncpu=%d, dying_cpu=%d\n", ncpu, dying_cpu);
 
 	tick_cancel_sched_timer(dying_cpu);
-- 
2.43.0


