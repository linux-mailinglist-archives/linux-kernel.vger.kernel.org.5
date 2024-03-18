Return-Path: <linux-kernel+bounces-105885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D5487E5E4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F191F22720
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9EA2E63B;
	Mon, 18 Mar 2024 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1IMBsKQ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF022D61A;
	Mon, 18 Mar 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754472; cv=none; b=qq1c1ExRajcQ5jpqhf94bz/S9WGeSadZpM6sY3hkImjr/ITYZ8+WCAS4jCITwewDx/Le3emuerj/IpRw8TW0wpvBnUxkmzDdgAIDiGqoLrzSBR3hsgV+urwOvOgzoPlzGS06RdwQSJLBA6aMXHGmf3CXN88RI6zijz9vtD7g+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754472; c=relaxed/simple;
	bh=LoZvr4wF1w6+nEN9L2dkxrepBU7/tqNaPF5AvK0Iof0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=i4ZO5QTc7+Q8d6MQCj3Njx5dLanZ4n5w/tl8CTJWQ53YhGiS2oDlWHYzlzvy3hKuwbG1GS/bhIwkWQb0qCBwVa3gQtPNFZ9FQCpWoImuoZp2zlZ1q6MOcnAjKuYmv9emkrStaBhL6D/Laicsxokz8TzcjCjC8Fx2MvDdAYy39vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1IMBsKQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dde26f7e1dso28196005ad.1;
        Mon, 18 Mar 2024 02:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710754471; x=1711359271; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MnWvQ4IOf1o2COC2dZwDmjBZxbqzE4A+e4OK5GIwCvg=;
        b=N1IMBsKQ6dY1h9RNZ82DJvxc1nM2j9WxfasN+rlFxJaN+sTeX4lh2B+CkBYlyVhVIh
         SQmewQ5bufLIh3/Lgykn09xZhdoYvIu2l4Quy5ZTCo7pRxFs5NhEDteRjkuIC2cldjso
         qS/hAJiyBoP+jzHRTEibtoiIppiXtkvg9rATCjUdvfwTfgInIpP4py8JspClIsySNI6F
         PXAjEqdqyLaGueLU9c1rFiRCWaqMQfudwDFQoZ8N8B0PTx2K7UEAbvsPHozlRRqfw+SO
         TiB2gC3Bsr5NIdqxXjKDqs4YDmCujlonWjU+B+BdyEKMsqgcXW+82vde6dWo6cWY2qkt
         ytZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710754471; x=1711359271;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnWvQ4IOf1o2COC2dZwDmjBZxbqzE4A+e4OK5GIwCvg=;
        b=iVyHVdgdvAR2e2IgexLBpzd7wXFQONLGAATKPjgRb/NW53sJOY9z6CAzHkXAb9XmGD
         0Tz75JCHlnCPYYz0H2pFtpR8jLEPCxuf25yg4bL6L9w5yU6hLII/ARdNgtWsLOGFhtnm
         vaY8ip+PR64b4RRSczdRLVIwk6fujYgCbqtR3ic26rZZL5WFd6248/uBw+d6LPbaTDun
         nb8EpY6h6/QGR+VJqoXtmywq3ucrUaaxfEInmS5lVTwq0ciSdwsFYGl8rrxFvX5xQopj
         ztUQDAccmV9iKedOk3lU3rMb8CGRbQMYDBxDVR0ZaPsx1tWStYxtZ+T/p1NDsKAQGu4W
         xgoA==
X-Forwarded-Encrypted: i=1; AJvYcCWVSWAb4ECBljvY4ECXoDN+IfTt+m4wYDKcof8iQZXpcU2TIT2WfEs2DnAEtDqq3tyxG0AMndkKFsWS1zpITz+R+aOYK380/rsOVOTMyv+z9vrysZfOkCkrLHNX/3fkPiQK
X-Gm-Message-State: AOJu0YwfeZ/UWMLDjQrqasCQSBwousPVU6OR85nuBSFVLFZRrbRZfVca
	crmbEJrcY2uToUsLtf/+/PfzDaGNJvOHkFxpjnH/gp8Y5bSrCTVUjjAIvUoV
X-Google-Smtp-Source: AGHT+IGbMQlHVWGhErVK/cON53sEGMh+tLFU9QihGbgzfNI1GsC/lbV1R8od1DVI18435tU12ZOMqw==
X-Received: by 2002:a17:902:d68b:b0:1de:f91:3cf3 with SMTP id v11-20020a170902d68b00b001de0f913cf3mr9442135ply.55.1710754470612;
        Mon, 18 Mar 2024 02:34:30 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id z7-20020a170903018700b001def777afc5sm5828025plg.77.2024.03.18.02.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 02:34:30 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] rcutorture: Removing redundant function pointer initialization
Date: Mon, 18 Mar 2024 17:34:12 +0800
Message-Id: <20240318093412.17258-3-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240318093412.17258-1-qiang.zhang1211@gmail.com>
References: <20240318093412.17258-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

For these rcu_torture_ops structure's objects defined by using static,
if the value of the function pointer in its member is not set, the default
value will be NULL, this commit therefore remove the pre-existing
initialization of function pointers to NULL.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/rcutorture.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 85ff8a32f75a..3f9c3766f52b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -566,7 +566,6 @@ static struct rcu_torture_ops rcu_ops = {
 	.call			= call_rcu_hurry,
 	.cb_barrier		= rcu_barrier,
 	.fqs			= rcu_force_quiescent_state,
-	.stats			= NULL,
 	.gp_kthread_dbg		= show_rcu_gp_kthreads,
 	.check_boost_failed	= rcu_check_boost_fail,
 	.stall_dur		= rcu_jiffies_till_stall_check,
@@ -614,9 +613,6 @@ static struct rcu_torture_ops rcu_busted_ops = {
 	.sync		= synchronize_rcu_busted,
 	.exp_sync	= synchronize_rcu_busted,
 	.call		= call_rcu_busted,
-	.cb_barrier	= NULL,
-	.fqs		= NULL,
-	.stats		= NULL,
 	.irq_capable	= 1,
 	.name		= "busted"
 };
@@ -847,8 +843,6 @@ static struct rcu_torture_ops trivial_ops = {
 	.get_gp_seq	= rcu_no_completed,
 	.sync		= synchronize_rcu_trivial,
 	.exp_sync	= synchronize_rcu_trivial,
-	.fqs		= NULL,
-	.stats		= NULL,
 	.irq_capable	= 1,
 	.name		= "trivial"
 };
@@ -892,8 +886,6 @@ static struct rcu_torture_ops tasks_ops = {
 	.cb_barrier	= rcu_barrier_tasks,
 	.gp_kthread_dbg	= show_rcu_tasks_classic_gp_kthread,
 	.get_gp_data	= rcu_tasks_get_gp_data,
-	.fqs		= NULL,
-	.stats		= NULL,
 	.irq_capable	= 1,
 	.slow_gps	= 1,
 	.name		= "tasks"
@@ -934,8 +926,6 @@ static struct rcu_torture_ops tasks_rude_ops = {
 	.gp_kthread_dbg	= show_rcu_tasks_rude_gp_kthread,
 	.get_gp_data	= rcu_tasks_rude_get_gp_data,
 	.cbflood_max	= 50000,
-	.fqs		= NULL,
-	.stats		= NULL,
 	.irq_capable	= 1,
 	.name		= "tasks-rude"
 };
@@ -987,8 +977,6 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.gp_kthread_dbg	= show_rcu_tasks_trace_gp_kthread,
 	.get_gp_data    = rcu_tasks_trace_get_gp_data,
 	.cbflood_max	= 50000,
-	.fqs		= NULL,
-	.stats		= NULL,
 	.irq_capable	= 1,
 	.slow_gps	= 1,
 	.name		= "tasks-tracing"
-- 
2.17.1


