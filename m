Return-Path: <linux-kernel+bounces-108118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9A9880639
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C101F239CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81DC5EE8D;
	Tue, 19 Mar 2024 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NyPcINls"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA984F5F2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 20:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881086; cv=none; b=pvOmBo4Nro0kHoBChwXN8yAVtkmqae5vFTeh0aj4aCeLEYCDU0uQK3wquanEP9VCjPekgfhkd6gLVzVUU1RswrdYe0FseGKLis1sBWZZjeArp5Alw2TGsgZr8OA8Ck8X0/8SA2kpHFMdmU6Q11qZLqXBgT4Hi1CZZ1YKfizsDWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881086; c=relaxed/simple;
	bh=pKj7+vVBWGpGFKTYgRlu4W1CFWQUya7L1Dw9/pmHtFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCaRpL8nLktAK7uj+91Y613LLPFaMXM5rZrsGNEwX1s2cVfg6UXrZH7btwU2QjaBCB62hMnCUkW9MhXZDCwvvnL2l2BPmnBK6afcaY51Yf0lMpyiTQjSdsUE36e+k3XEHYkj5zc5Qs4OTvb+e9vK3jJHI3KJSrlflv47wSZ+8eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NyPcINls; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-430b6ff2a20so23722531cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710881083; x=1711485883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gsx2/BRS29DSIob/mTwxuIGO/Q7o98NCGCF5KqdWFH8=;
        b=NyPcINlsz3mOKL4xDbVdw6Rfilhtx668TBFIaThh32Uh0ARXv5MpM8I1QgpWsKEsZU
         a5/ABSppF6qhjspk7/xTU5i9Qhrjla4Pi+uo/FYCrRS5fzSrW3nC9NWpE87cgrioOCrz
         O6kkGkpFyQct36jifR34OvNZMaOtffrHEW39S/LZ3cXCD06nPFN+moBcKz2HlJ6YE1p1
         QYDFhj5GntPQ3HgeP+r9r2Acc2S6+6Dbpz/R9NV/KEiRfZ60NCnZLOXGTPWqwXN76owU
         7QtNxGKR81MhVxM/tEJKwqn12QaggklRczAlJz2u+UsVdZdra8zpsidFxYYEYCusO/GP
         kAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710881083; x=1711485883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gsx2/BRS29DSIob/mTwxuIGO/Q7o98NCGCF5KqdWFH8=;
        b=YbGEF/nEwON9Kj7KONoQYy9V7dyQmczxoi12qq8WGI+Rd81czLzBTwjLCH5fFk0kjB
         dTQ77rmgNeGn3diQpqh6dMiJF5SmGC7whRXlU7IwobXxqCqsZ8pHk9MDK/vmvVMPcVAw
         GjVDEDCPdPrBjy8vwmoyKF6c2DKAqvunVFv6ZW9rb9mdw+9L3Qj8EnTpmqlH/VxvW4mj
         tosbX1rQwIkPJGzMOj0BahooinmJZI5CFixzJkX7pMqbXyUcaVBQpfZlaDXVC6FLoapP
         hyBir9Z3lIthRU7rZDClwc1CQcSNluJ70I2kggbcm4ITZJPbWNJR7mbH0wH0z1gfyQKT
         UuiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcNZVEWXXBMtECJNZIpKF4jmxjl12q8MYqMs+PCbmfqk+Eizfh+7dvC2nPg1Y+x8DqoQ2M21VIMCedjsrlOOo/Y2DWtc1In5VaqLK0
X-Gm-Message-State: AOJu0YyACCVBC07sRyv81sEo198soIJ+JJ2JcSmlVcIAZaVcPh+ufz3r
	yZz7+hV6w26JmonjNuN82SD4if7FZ/8qyAfsJtlflElhuQxCKGMe1/8GddDdBik=
X-Google-Smtp-Source: AGHT+IH9gvsMwQ8Z4rqJt6819bKxcNAcmqm6NPCZSQ8iSNVkJDu8nkaCee0sRubQEvo4jJt+9rGXIg==
X-Received: by 2002:a05:622a:1115:b0:431:167:280 with SMTP id e21-20020a05622a111500b0043101670280mr63581qty.51.1710881083436;
        Tue, 19 Mar 2024 13:44:43 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:1cd2::2df:49])
        by smtp.gmail.com with ESMTPSA id cr13-20020a05622a428d00b00430b0f40532sm5307248qtb.9.2024.03.19.13.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 13:44:42 -0700 (PDT)
Date: Tue, 19 Mar 2024 13:44:40 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v5 net 3/3] bpf: report RCU QS in cpumap kthread
Message-ID: <c17b9f1517e19d813da3ede5ed33ee18496bb5d8.1710877680.git.yan@cloudflare.com>
References: <cover.1710877680.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710877680.git.yan@cloudflare.com>

When there are heavy load, cpumap kernel threads can be busy polling
packets from redirect queues and block out RCU tasks from reaching
quiescent states. It is insufficient to just call cond_resched() in such
context. Periodically raise a consolidated RCU QS before cond_resched
fixes the problem.

Fixes: 6710e1126934 ("bpf: introduce new bpf cpu map type BPF_MAP_TYPE_CPUMAP")
Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 kernel/bpf/cpumap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 9ee8da477465..a8e34416e960 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -263,6 +263,7 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 static int cpu_map_kthread_run(void *data)
 {
 	struct bpf_cpu_map_entry *rcpu = data;
+	unsigned long last_qs = jiffies;
 
 	complete(&rcpu->kthread_running);
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -288,10 +289,12 @@ static int cpu_map_kthread_run(void *data)
 			if (__ptr_ring_empty(rcpu->queue)) {
 				schedule();
 				sched = 1;
+				last_qs = jiffies;
 			} else {
 				__set_current_state(TASK_RUNNING);
 			}
 		} else {
+			rcu_softirq_qs_periodic(last_qs);
 			sched = cond_resched();
 		}
 
-- 
2.30.2



