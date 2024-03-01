Return-Path: <linux-kernel+bounces-88338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F09D86E02F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58EDE286EDB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9736CDAF;
	Fri,  1 Mar 2024 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfToHa5f"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2506CDA0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292413; cv=none; b=hw7zgIM3aCXdd3aBW7qPwgzBxKdkz4Z67RXa18zq/4dhXcNfEwM+yG/RR5/PjePwj4Wh2nstPVU1S2eDxJZt1tFST2f/o7334EG5lStgmmERdPqvgIVkxBICDeN4MlQ+FbWofCc7gmPKHhVsFX+ZO3ic4SSBHm/ynK8lnkze7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292413; c=relaxed/simple;
	bh=kCj9Rovdwbcq2XlKGpXJo3zaiI60tfXSBC3dJ5D5Ut8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STku+b/Xv29Re+KvzVtygkcWc/Kbyk3kjVgocBzZqjauHXy+H03XqxXMMBPKoJPL6iBy/13zq5TK1klCigwqg9+RyBdngoECvPLbvJucARmszQtznwG5NP98GZWBPDZqgTwuZEQHo8bA6K2cK5Kcv2XZxFU963KUL3WL+V0mQEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfToHa5f; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so22752201fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 03:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709292409; x=1709897209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzH3P5qMQroNOdQTSOHArHxI7GPz6QqJAEyL6agayJ0=;
        b=OfToHa5fyhmYvzzmZ196DfP5CLlVii3Yht+NWDYoiwa8h6K3tz7HO1ec8OAc170OfB
         MktcxSPEyVi+8aVTy1Dwmgf18Og1q5d/DWUaH+tA9yjlXlSlax+auf4VjM9U1uxYJpX/
         2MrJtSSaTxRlJbKeb9roKaMYLq8umlk/NN1hE9Mg4DiKHDR9uE7yJVXtS5zaIwhV8ez2
         /y+JRVMaDeC97W/cJ8ZzZ0koQKUD0yZ3nSsrbbr2gxwLiEWDKALO/IQAqb5KZKlr6apg
         TFkLj2UkhdJOxu/32DiIRU0yAIwZt0Pc00ELxdBLhTIDBcYB6jK/pY0I5Zwrrhj7FNQs
         oe+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292409; x=1709897209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzH3P5qMQroNOdQTSOHArHxI7GPz6QqJAEyL6agayJ0=;
        b=H5BQeeBT+uKD0ITxFUBChRJdPVTU5voW7osqXOlRaCmg2iNf9TgKs2EoW2l0kYy7W2
         VBB6csfkvHwnFbgUUulx5hvUFV7EMVUfaSNy415lmcarueIolNpb4WLbxqwyFEdlcg0s
         2eeRsmbgZ0xAZ5mho5CbcgCybffsdEfcrGT03xVI3vsj5zJI8Zazs4Gg/sIPd3TFrPQH
         GsuHd+KqbUxHowFf1r/DPfH1YGhMlB7k3C4HJvchFArOx7fwmluE4Jocb5ImwHNbVBjY
         NZcTshqpSeni4DbZgcZxVnvkkh6LBDz+1nRLX5tcsjnWyVMHuAFlADDZaBO2VjsB57cK
         eqZA==
X-Gm-Message-State: AOJu0YxRLyhMjDIvJpilIiLE7j4HRyjoZN8rYFTwcqjooHGiWlOE1d/C
	97QhSFnLSBxmzBHAaTxxy2P5UdzG4tYrI/MDoJnRFCkU9sTdPwT3DIYz+RZtHrs=
X-Google-Smtp-Source: AGHT+IGLjVAGuaN+JQo9szNqme7uWC/vqZTCMom3zEn9avVzIWR94FIv5pWIfXlMnzLf4w4xBhH0eg==
X-Received: by 2002:a2e:a409:0:b0:2d3:4bef:45fd with SMTP id p9-20020a2ea409000000b002d34bef45fdmr358257ljn.33.1709292409318;
        Fri, 01 Mar 2024 03:26:49 -0800 (PST)
Received: from gmail.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c4e8c00b00412ad64cc69sm5068102wmq.29.2024.03.01.03.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:26:48 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 1 Mar 2024 12:26:46 +0100
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 5/7 v2] sched/balancing: Update run_rebalance_domains()
 comments
Message-ID: <ZeG7dt50PCQ8fFHw@gmail.com>
References: <20240301110951.3707367-1-mingo@kernel.org>
 <20240301110951.3707367-6-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301110951.3707367-6-mingo@kernel.org>


The first sentence of the comment explaining run_rebalance_domains()
is historic and not true anymore:

    * run_rebalance_domains is triggered when needed from the scheduler tick.

.. contradicted/modified by the second sentence:

    * Also triggered for NOHZ idle balancing (with NOHZ_BALANCE_KICK set).

Avoid that kind of confusion straight away and explain from what
places sched_balance_softirq() is triggered.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4c46bffb6a7a..18b7d2999cff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12409,8 +12409,13 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 }
 
 /*
- * run_rebalance_domains is triggered when needed from the scheduler tick.
- * Also triggered for NOHZ idle balancing (with NOHZ_BALANCE_KICK set).
+ * The run_rebalance_domains() softirq handler is triggered via SCHED_SOFTIRQ
+ * from two places:
+ *
+ *  - the scheduler_tick(),
+ *
+ *  - from the SMP cross-call function nohz_csd_func(),
+ *    used by NOHZ idle balancing (with NOHZ_BALANCE_KICK set).
  */
 static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
 {

