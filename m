Return-Path: <linux-kernel+bounces-54319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D24C84AD9F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C049F1F226BB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019E17C08C;
	Tue,  6 Feb 2024 04:39:32 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A8978B5B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 04:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707194371; cv=none; b=JeqMDT9e8G0/zIVVE5cDJrM6Lsf/V5HKsrpbkMyJq/5UHsSx4z4zT0kVeW5f5GiRMenWKIUnmR5UtGXY2F1bj7nsgDce7xLvAu0Mmg/JaDKYeUuMZPXKL7+4rIc/M4BYW+uSIB2jdKxsnOyo6bFGUp3apa2rzREwS8JogVsqluE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707194371; c=relaxed/simple;
	bh=/yBd5sGe3byMVW8sDxeCS54/0Z37uF3CUIi/XstrLJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNFeIEaFF1CGbCmfB+gkcLphhDk7UcYNlrLgKARIG6aNySiIs22VOaZ5o2KZLXpeSrTS+keFPXhzvOEfBx0VrMW8/0XJgnoB336yDS3xzWipxijiHPeiXBRgv7ji7h2HDK2t0XYZs4u1YVrKharmRw87dsuFefyaWIx0ALEdscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-783d4b3a026so306313485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 20:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707194368; x=1707799168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIX6iuoRN440ik6kRv9x9Dd8FfCsaf7euCk0kuQlv08=;
        b=JjMw7DZ/Zem8tGI1B287dMck9mLtWnBuqznI6w94CdMI5bm2Ve6GsP+ODJYCWRm40h
         m7UrxRWdc2BRR+dsH2Zxo+s09SJQzZ11zJxS0gPDGWG+ear9koUg2kuqrlI6vNpAwjS0
         5Cd7JEts4H1ihCkTVsuGP0PvbQA8iIJPS2GnuIdhhNQsKHbacicCcxgSexlaLMWij0YB
         miJfbSD3djqTAQrkDj8Xb9rdMaqp6A/fcFfoHI6xSfid7iX+IyXuXuLxdFemr2a4MHjr
         wdjDXw1wZ0ID+xJjXCXSsmFQ9EdZpfp/nKFo5bcpYxd/6L0bmVlGCCSKanAa2tk2dinb
         wGhA==
X-Gm-Message-State: AOJu0YzZ/kpp17aHjTWPsXF/l6qzTYa9gWm0r8eBTWiWx3FdmCm+M+k6
	61FnaiLND3H7Z2csctWg3yJWD6qwnMo5iXRA27X/n1LDScNttdgU6uaE2GOZciqqZQ==
X-Google-Smtp-Source: AGHT+IFse+cZLfWPvFEZN2GE4pbUvSAvzWnxUjKViyUDSmHNJaFAS53IslLuT+dTJgeQ/Eyq+tEn+Q==
X-Received: by 2002:a05:620a:b8d:b0:77f:8a87:ebfd with SMTP id k13-20020a05620a0b8d00b0077f8a87ebfdmr1060218qkh.41.1707194368565;
        Mon, 05 Feb 2024 20:39:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUgawVg/8epGHYSQn5u9fEP0+FbcAkJEsMGMiA1exxndl2m3HCeu+0Oih2o/j9ee/jC741kzplIXOUSpbHhojMejoJN/wdRAPsrBnE0BhRMWwY9WAIbpg/mcuunBJezmBwiiiIdegzHULCnUpVuyDgqD1o3Vya+cd+Pj9EtXhQCTZEtil3/aMUha7uZ+NNpRbUhvB7aMfgpGP5Cjb/0gtNagl7pT1yLl0LrxYNs7V+F+TpQubS0KO91RDnCRHG0z6uoj6v56agPFuwkLBT2CoOJ9I6/rhHagU/k/oRTAXQ4fMM/q04=
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id f6-20020a05620a15a600b00783749b0d2fsm577757qkk.94.2024.02.05.20.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 20:39:28 -0800 (PST)
From: David Vernet <void@manifault.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	bristot@redhat.com,
	vschneid@redhat.com,
	kernel-team@meta.com
Subject: [PATCH v3 2/3] sched/fair: Do strict inequality check for busiest misfit task group
Date: Mon,  5 Feb 2024 22:39:20 -0600
Message-ID: <20240206043921.850302-3-void@manifault.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206043921.850302-1-void@manifault.com>
References: <20240206043921.850302-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e7519ea434b1..76d03106040d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10028,7 +10028,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 		 * If we have more than one misfit sg go with the biggest
 		 * misfit.
 		 */
-		if (sgs->group_misfit_task_load < busiest->group_misfit_task_load)
+		if (sgs->group_misfit_task_load <= busiest->group_misfit_task_load)
 			return false;
 		break;
 
-- 
2.43.0


