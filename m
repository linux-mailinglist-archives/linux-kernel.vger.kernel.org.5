Return-Path: <linux-kernel+bounces-96887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE043876296
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7FD282210
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A995916D;
	Fri,  8 Mar 2024 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Khw4wH6o"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A5C56773
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895564; cv=none; b=GlCE6P6nvL36ADBVI5uP4LtRS8GjAoTo4qlP7Bh5+PJSL9joo3B8HOQ/gyHcTVsMxTxvMMPG5fFd2K8nBbjagsZXE8vd1uz901MY/y+TPmmcl53YXSE23Jsq+Z3a8MT5vrM0rCfYJCgqY9+fHIwLIBAAtSfawPHP3YCoEqxDD54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895564; c=relaxed/simple;
	bh=M6CW5mBJg38Y9c2Xjs+dT2XhOrcXFYv3cx4DXUuJqvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eDVJCR0Pk91zh3UyhKM2VYWhz8NnXMXba+Uy5nBBWikS3lNKVohE4r/6GLy87lEfchpl3ZrKZjQxp4vN4RTzVIWQ2v44trFgEKxGiHf2A67cf1/p8I8vLaKmPrzkNtx8e2F+80EVLUtyGcyMUb1Q0PM3y3rTwK8rCOfcrQu/YjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Khw4wH6o; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-413131d40f4so4995205e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709895560; x=1710500360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnwAghIMKls3/k0E6rrASoLxxZUTrO+4ycesi8BiBsQ=;
        b=Khw4wH6oO9dALGcFM1nNcyplRDxMZypKIG3uIg2GNzA6Q3sJK+rY+9mBS1NUleSTWY
         uOcHAOVgZ+F3RZb1fWe3KcjA8Lj6M6tKIzAylvlu2n5lhJEvZxqCm7PSrbuKzCxW0fW2
         q4suy7xizJxAJqmqjPLq4NnuqDPMdtGVD+SPzVl0XCZBT/GB8BJKYI8ZVTQdbj22y5z/
         lqPffvVIcB5N74y/mAezQg1VjnKfGviw+qaJZMijHJP6s3XJbJcl0iFFk3xTgBDNccCw
         K3eFwgW7Co16stzpyw7Mwh4b/qm8vbPL5J/KAKuyjYxURQh08FjWhBpNKI0GUPdHAUCW
         ifwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709895560; x=1710500360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZnwAghIMKls3/k0E6rrASoLxxZUTrO+4ycesi8BiBsQ=;
        b=NeqemWIiVic9xJbRn1iOMVUms3xhiJyyDYnSELkqpOHzvnMYlWoSHWUVgFsGafglOC
         VyEQDD3rg+PTtujeeCyDOZ6j1WbT3mvOIdxMwb71oS7/yXm/aSFcbKe6cTFBk2IfK/se
         5PBpMwpJQgKRu4nJx5srMcjejfqeiy2fSBJFE1wKgCV2NUkgstLc//bPU876aFad8YBp
         WGbJ/W5mho6cHE8n1vsMIPfAA2LSpbOZVQNg8FuLGt2udS3A95y3+6a1qMyqEEFc6Jjo
         N3jRihUNLxZ/7+OPhce9pHqU9H6TTwptZLT2S8KTy64S57HzRHmQPEMYYRrJ+x+aDI3U
         0m1Q==
X-Gm-Message-State: AOJu0Yx7uAU2L1B09+DG1uHKrxc2li9p4tlqHN9c0++OjMmPIB4Jqc2X
	f+peuzV6YzKGpbSGwNj95XcxGFEloYVJskirUgMszw16FT98qI0f/clJOJ78lSM=
X-Google-Smtp-Source: AGHT+IHjQHk5yqTQuoPifepV8kMlcmbrx8rEtxqRPbAD2qnPa5kueJ3P6e/gAklenZepWS8KfzhoSw==
X-Received: by 2002:a05:600c:1d9a:b0:412:eaf0:110c with SMTP id p26-20020a05600c1d9a00b00412eaf0110cmr8059893wms.21.1709895560433;
        Fri, 08 Mar 2024 02:59:20 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b00412f679bae1sm5632382wmq.26.2024.03.08.02.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 02:59:20 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 06/10] sched/balancing: Change comment formatting to not overlap Git conflict marker lines
Date: Fri,  8 Mar 2024 11:58:57 +0100
Message-Id: <20240308105901.1096078-7-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240308105901.1096078-1-mingo@kernel.org>
References: <20240308105901.1096078-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So the scheduler has two such comment blocks, with '=' used as a double underline:

        /*
         * VRUNTIME
         * ========
         *

'========' also happens to be a Git conflict marker, throwing off a simple
search in an editor for this pattern.

Change them to '-------' type of underline instead - it looks just as good.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3a510cf1fb00..84d4791cf628 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3679,7 +3679,7 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 	/*
 	 * VRUNTIME
-	 * ========
+	 * --------
 	 *
 	 * COROLLARY #1: The virtual runtime of the entity needs to be
 	 * adjusted if re-weight at !0-lag point.
@@ -3762,7 +3762,7 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 	/*
 	 * DEADLINE
-	 * ========
+	 * --------
 	 *
 	 * When the weight changes, the virtual time slope changes and
 	 * we should adjust the relative virtual deadline accordingly.
-- 
2.40.1


