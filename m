Return-Path: <linux-kernel+bounces-51427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3322F848B14
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 05:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D4A1F22E1B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A3F8BFC;
	Sun,  4 Feb 2024 04:46:37 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F586FA8
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 04:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707021997; cv=none; b=HPbpDryiNI7SidDvWt9nZHv330871qsryTIYGSLGPTasddOvNO1xMyldweUFklKFfK6jJ9/SruapIW+TOfC84fI8/MtOBtREeDQHm8bvkmIMDd2uhpjs8cxNGa9AZcGIUT57zDBYeyn4gANzyd/q3yWRFWkgrzFibf7iRPnzDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707021997; c=relaxed/simple;
	bh=esJff9D3QxDKh73OdhoQpybzSp8tl3pv5yUOn5L2Or0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPhyZx6BCcBjOGiOILtAU3t6dFBNB55ProfJIs41NTNWLD6DurfB19PdRnJ38efnPDiLkIR7J9lN2OtL4RyDfiZQugQHPmt/o7MoYP6thcLsD7xkM0azVPCdOXXT0Elz0UVomfPEa+eQn42o+f4KYreqyB9DObuIT1meMmY2k14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-783ef8ae70aso247544485a.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 20:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707021994; x=1707626794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTl2D4iOo0GV1DAY/ZjWEvwTNDLK6aFt78YqxSZPvBQ=;
        b=C1Z0tjsMTcXNvyQ0l4P5j3ERERGxJDEWDAe9WaVgxYx7sZ2fKD757JmlTu6qFT35fv
         HI5SsLeWyU+aFld7AgQpL9bXE8rjgnHkeFNX1DssmcMQkoEYnCInMxex2OvnoRRg9EOb
         VkyK1gJpd5ktvMYAeZ1i9BOBfpZLOwPIVPCnwWoyGC/j5kOwOQznNZzlqAM6TwLD7+pv
         /AE65wFTbm2lY+ImoWwCdUgLJGRQcey+cZgpm8FgbarkJgL2mSeBX7y76h2ocfWKPT3t
         edm5JbqZTFAvOVoLKXrU4bkpmt9hdtTlczUwst2N93dSi+dXJbkgtusuni2UiRy+Xkgk
         C/xw==
X-Gm-Message-State: AOJu0Yz9SDsXM7gRj44wfxhmH/pyGXy+4+vWtxS5K6MO01qa5WHV4pDY
	p5XshD+0CUqQRHVoeRcfSjdnD1sUTZ7vjAzCDkqrW2NU0iYQbsrRuUXCRlZu9Y8=
X-Google-Smtp-Source: AGHT+IHY+ayHYkGzoNKi9AUfjjJw3yZrERG3kPAAS6HF43SQ7uMfILchiNl4eEuK5xIxARONgntRxQ==
X-Received: by 2002:a0c:e082:0:b0:686:a185:dc11 with SMTP id l2-20020a0ce082000000b00686a185dc11mr2339381qvk.55.1707021993889;
        Sat, 03 Feb 2024 20:46:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXEw3NEGoax1wKTMcPEjLAOa+mI6JFt9Fn9dr/BacCCq/KLmBIwJglX11ETVmzHeqLm7qluTBvMjTx5KBbBEH0DMJPk25rtJEbif1AowmGxrK+a4z7BcUSxCyG+3mL01bcsMIBa5JkJ6gDplxUMnmB0FLMflqp7e7ggdpiUgx8rdVJPhJXXKcehp1s1+Nkh+bNs71h9J4th8kHpGOjm8cL7QoLc8hokaQW3GFcDmy9oqqsSug+rvKmpt/7xvkfig5eY9dcbLb1TE67qK+kncPpzAb2KoZnbh/samfk5Z2puv4O+FH/Cyw2KoZSG3ieGGeSWN1w7f1/sg0uQuZHjMZsKHxna27YLbiaX7A==
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id ny6-20020a056214398600b00681785c95e0sm2434781qvb.46.2024.02.03.20.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 20:46:33 -0800 (PST)
From: David Vernet <void@manifault.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	kernel-team@meta.com
Subject: [PATCH v2 1/3] sched/fair: Remove unnecessary goto in update_sd_lb_stats()
Date: Sat,  3 Feb 2024 22:46:16 -0600
Message-ID: <20240204044618.46100-2-void@manifault.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204044618.46100-1-void@manifault.com>
References: <20240204044618.46100-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In update_sd_lb_stats(), when we're iterating over the sched groups that
comprise a sched domain, we're skipping the call to
update_sd_pick_busiest() for the sched group that contains the local /
destination CPU. We use a goto to skip the call, but we could just as
easily check !local_group, as there's no other logic that we need to
skip with the goto. Let's remove the goto, and check for !local_group in
the if statement instead.

Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/fair.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b803030c3a03..e7519ea434b1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10578,16 +10578,11 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 		update_sg_lb_stats(env, sds, sg, sgs, &sg_status);
 
-		if (local_group)
-			goto next_group;
-
-
-		if (update_sd_pick_busiest(env, sds, sg, sgs)) {
+		if (!local_group && update_sd_pick_busiest(env, sds, sg, sgs)) {
 			sds->busiest = sg;
 			sds->busiest_stat = *sgs;
 		}
 
-next_group:
 		/* Now, start updating sd_lb_stats */
 		sds->total_load += sgs->group_load;
 		sds->total_capacity += sgs->group_capacity;
-- 
2.43.0


