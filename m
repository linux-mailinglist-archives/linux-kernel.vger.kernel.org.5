Return-Path: <linux-kernel+bounces-85757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6DB86BA5E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9094EB28B08
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A6D7D089;
	Wed, 28 Feb 2024 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iYUTMa5G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5SHvrTi6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEB572927;
	Wed, 28 Feb 2024 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157619; cv=none; b=Qr/T0UhMXi3/E44fpRl6l5K0TJ8HYobtZGK3XuDnSVxW/pAopbTdySb2FjMn5E9apLaigwNhmVCXAp6mTqg9DkpZxc37MUfw/KO4r8SB2UsUHHKQQnP/GHvz2M2yrxZCHWULzES706NVE9w/lEJm4r/5xpdVch8Ibn3/h+dxuKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157619; c=relaxed/simple;
	bh=D4dsBE9SNfENmZbQssQYh+CbA2Sd3b8W99GldeI0y3E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oO9LP3u4+zRfJ2sR34KebsW3KyLds0enMH6RUivHphRYe27TRKJiKqcG6mmVxZk5Uui+fAqnhBfo6E2M4rmC6mHrQt0zki3loTczLKleB9g50rtl2Grq/RyT0QxQTQsyLSCj8hu/dlq/ExWkLP32pzeVEOO+NOiieEXfAmkBfNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iYUTMa5G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5SHvrTi6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Feb 2024 22:00:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709157610;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3SA4r/Gx3AtSlXeawLQ8OLlk/NKfZsBIGDG7j0d/YTE=;
	b=iYUTMa5GhuXF0NZAxuDK1eTDWvLkp+JvRxM2AOGOzX3smBHXgKZojaAnaVTdhugH0Pns6Y
	BiG684VT+0N0tR1X2KDarPxJzPFfOmcuImoCCPX0Qa2LdKbxQ5406XmArp4p4xOrohOQbe
	TvUC5eaf0BcX7q7HXhonc4hWz4U0NSJ/VFtjW73DExg90gZaKLSYJIlO1GkcxuVszox3UU
	B9zdOVQd+kqaVOR5z6T1gxslgnJvSFrj7olX4ohs7Us/rxbFgrXgFDSo9PaEkt2pmpWBvA
	6ruG+PBK3JZdAF39n2rpWcUvLTPr+DeA34wFRbYd9PcxK/ei08Ho2E9FkTCY0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709157610;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3SA4r/Gx3AtSlXeawLQ8OLlk/NKfZsBIGDG7j0d/YTE=;
	b=5SHvrTi6gVT82g2SGy4dGDUcRDYdKnJ26RJnm0qJ3iGdwndCA+zKi5fP//2vTUoaY+xpFt
	CDGT/6IHdE2HPTDw==
From: "tip-bot2 for David Vernet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Do strict inequality check for busiest
 misfit task group
Cc: David Vernet <void@manifault.com>, Ingo Molnar <mingo@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240206043921.850302-3-void@manifault.com>
References: <20240206043921.850302-3-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170915760926.398.7923117841020138205.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7f1a7229718d788f26a711374da83adc2689837f
Gitweb:        https://git.kernel.org/tip/7f1a7229718d788f26a711374da83adc2689837f
Author:        David Vernet <void@manifault.com>
AuthorDate:    Mon, 05 Feb 2024 22:39:20 -06:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 28 Feb 2024 15:19:24 +01:00

sched/fair: Do strict inequality check for busiest misfit task group

In update_sd_pick_busiest(), when comparing two sched groups that are
both of type group_misfit_task, we currently consider the new group as
busier than the current busiest group even if the new group has the
same misfit task load as the current busiest group. We can avoid some
unnecessary writes if we instead only consider the newest group to be
the busiest if it has a higher load than the current busiest. This
matches the behavior of other group types where we compare load, such as
two groups that are both overloaded.

Let's update the group_misfit_task type comparison to also only update
the busiest group in the event of strict inequality.

Signed-off-by: David Vernet <void@manifault.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20240206043921.850302-3-void@manifault.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 41dda53..448520f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10032,7 +10032,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 		 * If we have more than one misfit sg go with the biggest
 		 * misfit.
 		 */
-		if (sgs->group_misfit_task_load < busiest->group_misfit_task_load)
+		if (sgs->group_misfit_task_load <= busiest->group_misfit_task_load)
 			return false;
 		break;
 

