Return-Path: <linux-kernel+bounces-105360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C73687DCA8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 09:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1FE1C20984
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 08:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87194134A9;
	Sun, 17 Mar 2024 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDGgdG6F"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9714C9B;
	Sun, 17 Mar 2024 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710665864; cv=none; b=AAkW73uq+Rc/yj1OUOzgIQ5/YeUsQ398OQZHLFOGxwRNa45r2fkD3o3ourJcYxczQn+YQfLTpOpEth5MUsiuZzzafubI6o6K81wm5ywNa8fhPmeMsmGWk+9bkZ5k8XLB3WUTVQV76HjiiTAEEi4rj3tAoHCZnGsPGjcgwWGjYXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710665864; c=relaxed/simple;
	bh=asv0cBPR28MBXshoVE/nETVp0XrutCztzTsUvJ4lhNA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u9a4T/IafniUYLZf/XZ9I5SRhPJ5vUqBQKjP9jWrxm/2i0Onv9c6F8c1cMEea0wGcjTI6E22QF36mluLU9EtBThjUxXFE22+fmHb8NQod3GPca5DwFiXqJk8o8sG4UDjwpTeFYwm9/BfvtdoqETHVllP1r6m/c9UEI9rRe4PoCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDGgdG6F; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso4248007a12.2;
        Sun, 17 Mar 2024 01:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710665861; x=1711270661; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fIjwHO2kK13iUtmD0+UvARxjXLrJ4q2jGaLpjIJdcpw=;
        b=CDGgdG6FPRe31UMyn+VdYCz36TVIPw8pmU0SsmUNGcuOzvawtaUBLelUNKFAvP4g5e
         kVpenTASdeRrhnKxCvzxIwFrNfIbQn2OvkOUlZL+SActW4KYME9EanNmFm7pSDrbxgfV
         k+2TlcrhnReT0aVFUSi/7hUoNK4kYgv8Wvl5XOlVHvQr3TSIv3NyNSgzE4SSTvIEDj75
         Z/AJPp96oYMJXQGXX0Xc2DKQfFElqlOB59hZLYHo/tzRyH2od8hXyI/kMNvWoQ9ZcCME
         /ccMD0P5c2yxAi0s4pTNHdPRn11YztDE4P3BisTvu5Lo6NLEVey7xftCVKj8XTIPL22L
         RwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710665861; x=1711270661;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fIjwHO2kK13iUtmD0+UvARxjXLrJ4q2jGaLpjIJdcpw=;
        b=LfwWIpWJD1o24oWpFYTYLDxOnta8tPY0asrmVZ+4Dqsb+Z1isEanABlHuGUNAW8jyJ
         HFaGRT6mpqJL059rOUPKKDFl6H00EnF9biwBYmYsrmZWIVbXaGmP0KaijuvZTBnlFJmw
         uvJb2gxXtwj8ubk76yPeCwHxF8lC/RwBMycmsWv6pb1CYpM56HNAEeqUyE8rwKs5wgWt
         C/AqFD8YVcA/AMGcFYAMefxMVk3FRWA6sBC4F22ZVxQriKoS/F/gK+CfcME9ElHSOfKO
         iRCqh1tMQSg5vJM1mBoMmU0DTSVZgYtBPbr+TNEn+17O87GPtvWssKLcTsQFD2pXeHHL
         9stg==
X-Forwarded-Encrypted: i=1; AJvYcCUIt0vRG2TfyVuY/7jSfRcZgsGyAxRiG5WpRfZJ7DrWHZHVHDAhO/wgt3za7o1XnZ2YFxzqJNeTKymQ+iIy4cxpiRd4CWsxj3fG5Pt1YjzXGQ==
X-Gm-Message-State: AOJu0Yyv4ownIaN7o42r6gJO8WVmMWKD9eaVPbPlClY0B1rHJbgGNvkO
	K9wnn2h8ZtEwCspU5wVUrvhin4bS8Gvy+Z1fhFP+32bip7mUiNeu
X-Google-Smtp-Source: AGHT+IFPbvHRc5h3pW77s2BzQjCzPJmoz5cWOfWLH3LukRl5xqSVxzzHBJk0IwnkBmSRYUg/IpUV0Q==
X-Received: by 2002:a05:6402:5018:b0:568:b18:ee19 with SMTP id p24-20020a056402501800b005680b18ee19mr7162402eda.16.1710665861180;
        Sun, 17 Mar 2024 01:57:41 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id cs4-20020a0564020c4400b00568a1ce4562sm3243500edb.25.2024.03.17.01.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 01:57:40 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 17 Mar 2024 09:57:38 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf events fixes
Message-ID: <Zfawgi3HBOSuWMy3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest perf/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-03-17

   # HEAD: ad8c91282c95f801c37812d59d2d9eba6899b384 perf/x86/amd/core: Avoid register reset when CPU is dead

Two x86 PMU fixes:

 - Work around AMD erratum to filter out bogus LBR stack entries

 - Fix incorrect PMU reset that can result in warnings (or worse)
   during suspend/hibernation.

 Thanks,

	Ingo

------------------>
Sandipan Das (2):
      perf/x86/amd/lbr: Discard erroneous branch entries
      perf/x86/amd/core: Avoid register reset when CPU is dead


 arch/x86/events/amd/core.c | 1 -
 arch/x86/events/amd/lbr.c  | 6 ++++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 69a3b02e50bb..aec16e581f5b 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -604,7 +604,6 @@ static void amd_pmu_cpu_dead(int cpu)
 
 	kfree(cpuhw->lbr_sel);
 	cpuhw->lbr_sel = NULL;
-	amd_pmu_cpu_reset(cpu);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index eb31f850841a..4a1e600314d5 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -173,9 +173,11 @@ void amd_pmu_lbr_read(void)
 
 		/*
 		 * Check if a branch has been logged; if valid = 0, spec = 0
-		 * then no branch was recorded
+		 * then no branch was recorded; if reserved = 1 then an
+		 * erroneous branch was recorded (see Erratum 1452)
 		 */
-		if (!entry.to.split.valid && !entry.to.split.spec)
+		if ((!entry.to.split.valid && !entry.to.split.spec) ||
+		    entry.to.split.reserved)
 			continue;
 
 		perf_clear_branch_entry_bitfields(br + out);

