Return-Path: <linux-kernel+bounces-108117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E309880635
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FE31F23350
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DF83FBB0;
	Tue, 19 Mar 2024 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HCAA8OEY"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8372B3BBFE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 20:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881083; cv=none; b=Kbn/QAYQelPAEjfCfywzX46OPaFL/p4yC5rnV8inPfjNnfq4b8JPHWsDJnLUo3kfljQ2WhAu5/9UKFQmOdOplydSHtgL/k0V23lPvGi8z1Bo6p7pzm85skmOY4cab1tZjeLeOP8RhuYh9jboc3wgaHun0/fVnII9gD4SCkpGXT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881083; c=relaxed/simple;
	bh=lIO9MabCA0Vp4l3RyBQKLB7GagIDesVLqRMDYikDatA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2ZlFX7LX1xw+nl4J2ywVozOqLfgymthyh/vVWLNHpi8sJ4MOC5byDJqVdrVF4s6f1cO1S8a3VAl0s9tEyqhT8mklaJuLkhSggSZgtKm8SXlFsXlP3PttDLiA3NNLgBv2xmKmeJz6hpKs/7CN2dW8vl3k1zOfBlB6ZRT43dwtuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HCAA8OEY; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-430b870163eso2338471cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710881080; x=1711485880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VcyYWRaJ2z9OCo3//n/tTkrj0ma4Eol6nlX2m3ez4hs=;
        b=HCAA8OEYnfyjXPN2g/n0nTxMowCW9mbg6CmydUQ4bRuoUnuFFjOGSe7LQBcrPfVCfo
         O66rE/8zgWpIJpaOa3Sq+UhcGgXJ8m0MpKrQuuknWJ4oCXcMR8+RGly5ALckHNlubq/A
         3imWG14J7mdr1txJbwWOxf/G1VJXAsNkGYW3/Y1BvDEhytt4RZ8G75qa09HIHpz+mOIS
         KlyE0+eCY68tqAyxdvT2yzzjl1XSWGtD00xXOwuBDHrdr0ve8mMC2+1rOVhKxuYrgB7K
         ZmbZ47+/QWKD+AFC8NSvtJ/0JVlW01OCOSplfV0JulmAm408jLy7fWSn8VOutYm+ajyv
         dMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710881080; x=1711485880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcyYWRaJ2z9OCo3//n/tTkrj0ma4Eol6nlX2m3ez4hs=;
        b=FdCOwCVdm5yRbuQmM2rvPpLrH+StT+20mRqB06LC941BNuJikcQ/rbDu6w+CCql8vm
         QLY+FEHQq6m1X9UOirRbzZwLYuXCtUtrTdYqphDEYWA41sAGtoAOeP9cDA8x3x/escGv
         lnShV3Cryhs0i48NHAN2iX51TREqoxPUSUdRWbBmHSa8Tivh76An17HIndL+b/xbaO5H
         ZxRlKYP8y8CGEayE4ag0wCI+CRm5YYBjPKEUOlgDhipqWn4hE0geeQOCBl3I9mZ73dpY
         Eo+DSk5R+s1wIdDQYtOkm3aeRBxugExy409GqWC3Sc2bfk6zMvGCjk8CbpHzgvQ/T3LX
         Hy9w==
X-Forwarded-Encrypted: i=1; AJvYcCV9GI7ypL5FCWHJ3V0H4I1Pd3io7Tg9bL0J6vQGNYByTrGUqGdHoGbXCyRcrWYGSWInWrjcYM08qJGACxwgVKzIDki8IPHNOgl0OP6O
X-Gm-Message-State: AOJu0Yw9liTm/ef8KqUY8ZGNM8970kNyE1tmFVx2LWhJA+g7AwxIJZmO
	ctlGjrLvxoIYxRwRnn2VRR5ott9u5/UH4TzO9QPn2kq7MfxUKktXigbNud1BGWQ=
X-Google-Smtp-Source: AGHT+IEqJqSfTz5bjyf6+FFNUXSLrbwrdMDLWUdtYJ2krdBAfEjY8Q3lzIBNIXbpm1TJn+LzQI6kHw==
X-Received: by 2002:a05:6214:14b0:b0:691:3cf5:b7ad with SMTP id bo16-20020a05621414b000b006913cf5b7admr1034118qvb.12.1710881080537;
        Tue, 19 Mar 2024 13:44:40 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:1cd2::2df:49])
        by smtp.gmail.com with ESMTPSA id pn4-20020a056214130400b006961c1d2b6fsm2822954qvb.80.2024.03.19.13.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 13:44:40 -0700 (PDT)
Date: Tue, 19 Mar 2024 13:44:37 -0700
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
Subject: [PATCH v5 net 2/3] net: report RCU QS on threaded NAPI repolling
Message-ID: <4c3b0d3f32d3b18949d75b18e5e1d9f13a24f025.1710877680.git.yan@cloudflare.com>
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

NAPI threads can keep polling packets under load. Currently it is only
calling cond_resched() before repolling, but it is not sufficient to
clear out the holdout of RCU tasks, which prevent BPF tracing programs
from detaching for long period. This can be reproduced easily with
following set up:

ip netns add test1
ip netns add test2

ip -n test1 link add veth1 type veth peer name veth2 netns test2

ip -n test1 link set veth1 up
ip -n test1 link set lo up
ip -n test2 link set veth2 up
ip -n test2 link set lo up

ip -n test1 addr add 192.168.1.2/31 dev veth1
ip -n test1 addr add 1.1.1.1/32 dev lo
ip -n test2 addr add 192.168.1.3/31 dev veth2
ip -n test2 addr add 2.2.2.2/31 dev lo

ip -n test1 route add default via 192.168.1.3
ip -n test2 route add default via 192.168.1.2

for i in `seq 10 210`; do
 for j in `seq 10 210`; do
    ip netns exec test2 iptables -I INPUT -s 3.3.$i.$j -p udp --dport 5201
 done
done

ip netns exec test2 ethtool -K veth2 gro on
ip netns exec test2 bash -c 'echo 1 > /sys/class/net/veth2/threaded'
ip netns exec test1 ethtool -K veth1 tso off

Then run an iperf3 client/server and a bpftrace script can trigger it:

ip netns exec test2 iperf3 -s -B 2.2.2.2 >/dev/null&
ip netns exec test1 iperf3 -c 2.2.2.2 -B 1.1.1.1 -u -l 1500 -b 3g -t 100 >/dev/null&
bpftrace -e 'kfunc:__napi_poll{@=count();} interval:s:1{exit();}'

Report RCU quiescent states periodically will resolve the issue.

Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop support")
Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v2->v3: abstracted the work into a RCU helper
v1->v2: moved rcu_softirq_qs out from bh critical section, and only
raise it after a second of repolling. Added some brief perf test result.

v2: https://lore.kernel.org/bpf/ZeFPz4D121TgvCje@debian.debian/
v1: https://lore.kernel.org/lkml/Zd4DXTyCf17lcTfq@debian.debian/#t
---
 net/core/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 303a6ff46e4e..9a67003e49db 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6743,6 +6743,8 @@ static int napi_threaded_poll(void *data)
 	void *have;
 
 	while (!napi_thread_wait(napi)) {
+		unsigned long last_qs = jiffies;
+
 		for (;;) {
 			bool repoll = false;
 
@@ -6767,6 +6769,7 @@ static int napi_threaded_poll(void *data)
 			if (!repoll)
 				break;
 
+			rcu_softirq_qs_periodic(last_qs);
 			cond_resched();
 		}
 	}
-- 
2.30.2



