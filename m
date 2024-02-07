Return-Path: <linux-kernel+bounces-56988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8D084D25F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299BC1F246F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ED986AEE;
	Wed,  7 Feb 2024 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V85Za/Yo"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210AB8662E;
	Wed,  7 Feb 2024 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707335321; cv=none; b=ipSQO2wqIOj54zuXceXS5YoarzChLkQR8Sn4rpQZn5NvTAIHmCxfCzLDyyUD8wdloGcPOVahU/UKY0jOB4ooCLxeSXD3Nl4DyFJSBO7/kw9OgRQWz+oruZI+RQVu/GEZbxjElArMsdCk54CcOkdc54T83hrXYfpu/PYpG8hEepQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707335321; c=relaxed/simple;
	bh=kWZUl8wrzeMu5G0Rgxyc62XFeof5ltOrH34f/w3jkWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKj+Km9URO+SRQqVnkDmIc9UC8MhNOjCU3+jvAsqYyRFme3GvD/MA/e15pPRSyfrm4nCIFjQsjaskvRi+R8Upk082aVgLzoEN4/4384I+wVnV3S2JnUd0QhGLp2jNYy5jzV8/F2LI6BZDHti2hOuAZBsuRgsJOUH9ujTWCFuZmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V85Za/Yo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d746856d85so8318195ad.0;
        Wed, 07 Feb 2024 11:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707335319; x=1707940119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/Z5ubH8sw+w9JviokXli3hle2E560cbP/Ag5YM4elE=;
        b=V85Za/YoMgHJsBPQVH66aqkCwQ5pbEnCVbwzBCgQqyHyeDsUkV8ChZSrVCq+jiO/s/
         lQNImHh0Zh/SHxJmfLiECYr5DVTLBz79rgqQ3JvIdKJ33AoGUgPB9TU7jNRbT+XWunH+
         XEqS6NHnkQnt4AIkPloe/IivxG6g6DqQzB7A4YlMThFzMBrY1Bxjuq4mCKM1P2Dwpw+V
         P4q3qgfi96zj7wSDrqhkx4YCJK1X7Kv9BgeOEGapLQ6rAZIiyEy+8eoIyp/6Hv3TLe9g
         jKHXYuuJDCxIwWfiSoogSyujRID7emE8GF4hoRie1kSSaAvcYLIgwn4Ge67f9ob2jst2
         YFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707335319; x=1707940119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/Z5ubH8sw+w9JviokXli3hle2E560cbP/Ag5YM4elE=;
        b=dYc/rUiY3DIIVbBmN+oSwP04hxgbPDUa5yGGshStL1HnE2oUjBbT49brdzMNgkf32L
         7iPJepmiPA4qh9389neeDrzOdkPLjHwf9v0Q1hTRc5ZjWE5w/ub1P/aEmJ3geajxJKkE
         /ns5szWNsnj0CI5wJmH6aFPunfYZR/GquVEJ88r+d/1fAYSJcNd59gtO+/ee1eAyNBaX
         pGwnVgibTI/N2i6vKbnWWIWPvJ2BorpPbZDVN6WD2XCWjFuk2YmS91FxzJoyyLzdfkvV
         JNem/q63jw51TGhI9kBKGB4C2C+OS/mGmuf/6lSvFmrBHrO3tzLuFn7Yhdd0clZns7uF
         ZoyA==
X-Forwarded-Encrypted: i=1; AJvYcCXsODSYjSO6oPTrfxWoiKfNImDcWhDn+4eazMJlXFDFeZXCu4IeNEisjbQd48o4plf/TnSY80BwnsyI3y/KpmXPRKNDy/3wm5tvzJezJqPENQwiCjAacqdQnwEAa9U/Lh0XBH1kSVI=
X-Gm-Message-State: AOJu0YxbObxFLxpFVco8t33IJ1V+sW586R0g4yCQ1zM1hOptSzBh50H5
	KRhlhnnGCWsU+TXpMW19o0NLxXYVNuPyLW9USvNiMDlLFtJTZZrq
X-Google-Smtp-Source: AGHT+IFeJDf6mMvBzEPYeSI4S/fMZIKMvV5Bf3jtvS6eLCtPhkmqakyACt5yeClHwkb2VBUgYI9aeg==
X-Received: by 2002:a17:902:ead1:b0:1d9:6381:a4b3 with SMTP id p17-20020a170902ead100b001d96381a4b3mr5255246pld.36.1707335319154;
        Wed, 07 Feb 2024 11:48:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZnjgOY9P2LABNpuaXYCUdvEdDYCrJmTT1rF5IrkNaGjFHpR2E2NHnaehuHEcZd5YLg29lkdzBoI3GzJVUVYTVet6ps3pC8t3kwT7pqzojIEBI6ECDwrAP7JFqU3iiKZJnQGR6lviC7Edv2/oKZWIxoNbwMmkt4yjf0sMABoc7ziZ+nrEbk2dn7+JuQT7sWm5feXGTrWAam4wp3kD1wXV1ohrNa2jJxQeJcQOQ2pQRE9eD3W0mDp8cFMx/cqyZu6+YUlphrERVJ51MoVC6L7Z7mSPW6q5N+9ZSxfVrEbTkIwc6BOa7cxaxJZcN3fo/t1XSLWgntcy80ANimRzGTfrjMHGQXKQobAiQWMD08i7E0y4ybSSTxnPq7Ksu8oA=
Received: from localhost ([2620:10d:c090:400::4:3c45])
        by smtp.gmail.com with ESMTPSA id ki11-20020a170903068b00b001d9a1d498e7sm1847040plb.280.2024.02.07.11.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 11:48:38 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 7 Feb 2024 09:48:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume
 optimization
Message-ID: <ZcPelerpp3Rr5YFW@slm.duckdns.org>
References: <CGME20240207103144eucas1p16b601a73ff347d2542f8380b25921491@eucas1p1.samsung.com>
 <10423008.nUPlyArG6x@kreacher>
 <708a65cc-79ec-44a6-8454-a93d0f3114c3@samsung.com>
 <CAJZ5v0hn=KgaWn9pwtLsH2a8n61BNxzb1xrNoxUfEi3o9OAZGw@mail.gmail.com>
 <4a043533-009f-4db9-b107-c8374be28d2b@samsung.com>
 <CAJZ5v0hDmwaFEtLc8yDc4cXn2wODXAqATe0+_Hpm9QPODUPMQw@mail.gmail.com>
 <ZcOyW_Q1FC35oxob@slm.duckdns.org>
 <2f125955-8c7c-465c-938c-8768f7ca360b@samsung.com>
 <ZcPSuUBoL_EDvcTF@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcPSuUBoL_EDvcTF@slm.duckdns.org>

Hello,

I couldn't reproduce effective max_active being pushed down to min_active
across suspend/resume cycles on x86. There gotta be something different.

- Can you please apply the following patch along with the WQ_DFL_MIN_ACTIVE
  bump, go through suspend/resume once and report the dmesg?

- Regardless of the root cause, I think async should switch to a dedicated
  workqueue with explicitly raised min_active (will add an interface for
  it).

Thanks.

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index cf514ba0dfc3..93e5b837f2b4 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -368,6 +368,8 @@ struct workqueue_struct {
 	 */
 	struct rcu_head		rcu;
 
+	bool			dbg;
+
 	/* hot fields used during command issue, aligned to cacheline */
 	unsigned int		flags ____cacheline_aligned; /* WQ: WQ_* flags */
 	struct pool_workqueue __percpu __rcu **cpu_pwq; /* I: per-cpu pwqs */
@@ -1557,6 +1559,10 @@ static void wq_update_node_max_active(struct workqueue_struct *wq, int off_cpu)
 	if (off_cpu >= 0)
 		total_cpus--;
 
+	if (wq->dbg)
+		printk("XXX wq_update_node_max_active: wq=%s off_cpu=%d total=%d range=[%d, %d]",
+		       wq->name, off_cpu, total_cpus, min_active, max_active);
+
 	for_each_node(node) {
 		int node_cpus;
 
@@ -1567,7 +1573,12 @@ static void wq_update_node_max_active(struct workqueue_struct *wq, int off_cpu)
 		wq_node_nr_active(wq, node)->max =
 			clamp(DIV_ROUND_UP(max_active * node_cpus, total_cpus),
 			      min_active, max_active);
+		if (wq->dbg)
+			pr_cont(" node[%d] node_cpus=%d max=%d",
+				node, node_cpus, wq_node_nr_active(wq, node)->max);
 	}
+	if (wq->dbg)
+		pr_cont("\n");
 
 	wq_node_nr_active(wq, NUMA_NO_NODE)->max = min_active;
 }
@@ -4886,6 +4897,9 @@ static struct pool_workqueue *install_unbound_pwq(struct workqueue_struct *wq,
 
 	old_pwq = rcu_access_pointer(*slot);
 	rcu_assign_pointer(*slot, pwq);
+	if (wq->dbg)
+		printk("XXX install_unbound_pwq: wq=%s cpu=%d pool=%d\n",
+		       wq->name, cpu, pwq->pool->id);
 	return old_pwq;
 }
 
@@ -7418,6 +7432,8 @@ void __init workqueue_init_early(void)
 	       !system_power_efficient_wq ||
 	       !system_freezable_power_efficient_wq ||
 	       !system_bh_wq || !system_bh_highpri_wq);
+
+	system_unbound_wq->dbg = true;
 }
 
 static void __init wq_cpu_intensive_thresh_init(void)

