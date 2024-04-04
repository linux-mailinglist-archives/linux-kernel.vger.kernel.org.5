Return-Path: <linux-kernel+bounces-131778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 122C9898BAF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426991C26F75
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C742E12AAD7;
	Thu,  4 Apr 2024 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jy4v4Xzm"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E3512BEAB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246267; cv=none; b=KT0mqU702AhQVba5IBPEnikky0aaUlXqFqd/Rs6KHrH663YgKW2aMUaTT+oaHa1+IGjfXeuSwdWlHynu9gdvfRNh8W0OyrhwWMytwN3WcoQF2fc4+GEhM/2O8+er+DfwP5Hmzj40ECK+p0GNa2XIt//vr3N6FZTTWD8C/StdtKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246267; c=relaxed/simple;
	bh=bIhafewhD65Nv4K87uihFdEliJQyj7NLSA3aEzT5HOA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uTftUw3URPnsopWq3asFeksoYw3uhPPD8bFjCxPELAQ8iXEue/VrXL3B5uFwIx+5yN6VGJY2rZH0MK4i8h7y0ntrbBiKJgdjyq0z+9txx07b0mng4r+XuSvxxHNJNVQbz8WYJ0ZGftttsYtsVfMaJGKhnu7QJPweDbcMSfV6e1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jy4v4Xzm; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3439ce73766so614851f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712246263; x=1712851063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NZR6FFh5triaxzvgEajm/H/9Zv9Gv7TXy+hMNkzqKys=;
        b=Jy4v4XzmvVvkkJcuT4Bx0tRTBbE5ggnrVSU1rDnHuLbxMrYlrkh4M6/QAdkaPMCNRI
         4TqNISNaYl1vfol6FC16CFym213MmTtid8n0nUc3P103u+KvNmA0RKNq3bvgGiIdm2IA
         5+Om/LAob856oR2t0npNKvievc6IzgzuHkxIOOyizsJzKls01bdpB4syZQYaGMTsjnfd
         TXx1uKBD8d03teFUIw1kQuOIe8qmvg43tefTkBp4qDNMJ/KaN4EyzFryWjwYZ56HLRtO
         vF5bT+x47+DUMlYtrhn8gcU2XBZigHWFK6ioIWnNBFWdRi1jm2JlMyjAlYFBG6bvlQyt
         fXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712246263; x=1712851063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZR6FFh5triaxzvgEajm/H/9Zv9Gv7TXy+hMNkzqKys=;
        b=vjI4BvKotuU2ooLu2xsfubDu6ZRJpwSprq50095Jy9q+ABS+Z25lTyIWG7wieh4AXZ
         GGAh67Y6Yty6yGlFW8z/JaWYdvwBf/z4RjNqyCN9KbNV5F9GjBCrO/l6CSSMpUDpdh1F
         qonq4h4nxE1UmsefF/HwlLnUcwvUdLf5EKrvEWpqW6cZJf/GNlFculDxCu9XjoiP4TKz
         zhZkA/O/2FKvOiQqiyh+S4w5ACqMyc8JBqGCP+0p4lIDz0mxNfL+pf4Ej+kYbjIR5zqR
         d7fSbYiZUeWDX3aueo3ssVgQDaRbVGfAQCq8xXBGXe1YQBa5ql/EodGvsUqG8N9J5WiF
         TQkw==
X-Forwarded-Encrypted: i=1; AJvYcCXZwilY3vgOJc4FiZg8TphC/diUGgs2b39P556nte/SX89NyH6USPAmMivZcrTGgC7K1qsmmb0HoxZfS0m9HomNv7j9fDlIXULBQrgk
X-Gm-Message-State: AOJu0Yxcw2RU8DijlgsEHENfKWgCS1Pvw+TS62/52l3bJdoGVVQDSyyt
	G+60QOKH80aXwXHyjGBnG2e9unC6DWiSPA8sozDjRCrM/XXgjAgI/SZZ0lLc9XY=
X-Google-Smtp-Source: AGHT+IFT7/XbicPZGke3WroBDV3w3RunUI1go6Iixv+jz9dHtwPawk2ZIPoaX6fw+uUNfellYOGPjg==
X-Received: by 2002:a5d:5403:0:b0:33d:a944:54c0 with SMTP id g3-20020a5d5403000000b0033da94454c0mr2225858wrv.22.1712246263577;
        Thu, 04 Apr 2024 08:57:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:b106:a204:7cdc:fc96])
        by smtp.gmail.com with ESMTPSA id m18-20020adffa12000000b00343cc702c56sm1232806wrr.47.2024.04.04.08.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 08:57:42 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	sshegde@linux.ibm.com,
	linux-kernel@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: Fix update of rd->sg_overutilized
Date: Thu,  4 Apr 2024 17:57:38 +0200
Message-Id: <20240404155738.2866102-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sg_overloaded is used instead of sg_overutilized to update
rd->sg_overutilized.

Fixes: 4475cd8bfd9b ("sched/balancing: Simplify the sg_status bitmask and use separate ->overloaded and ->overutilized flags")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1dd37168da50..bb1ae4ed0d91 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10661,7 +10661,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		set_rd_overloaded(env->dst_rq->rd, sg_overloaded);
 
 		/* Update over-utilization (tipping point, U >= 0) indicator */
-		set_rd_overutilized(env->dst_rq->rd, sg_overloaded);
+		set_rd_overutilized(env->dst_rq->rd, sg_overutilized);
 	} else if (sg_overutilized) {
 		set_rd_overutilized(env->dst_rq->rd, sg_overutilized);
 	}
-- 
2.34.1


