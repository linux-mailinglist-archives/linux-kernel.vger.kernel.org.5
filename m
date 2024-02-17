Return-Path: <linux-kernel+bounces-69640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7F5858CB9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACA51C214C1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE5F17727;
	Sat, 17 Feb 2024 01:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT9C+nFm"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5D74C8F;
	Sat, 17 Feb 2024 01:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708133280; cv=none; b=Hae704mcMC4M5q9G/2OpbadNvL7QbnqZ+tPBqkMkLdx5QSjFL8SBxXkbmg2MlzQIVxONMsDTbhwpvNkVfrk55srH9pij4DPzWuD4dTVGNOEiRc359ZB1v2glCLklbvU1rWMXOZv/rwyqc2u38wpwRDgLGR6QikhhSxSAsYJrgrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708133280; c=relaxed/simple;
	bh=IPhTwhd+sG/j2XT8YGeqy+Bq/Ymg/GX/lulfajzIek0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJwFe0Qao+Xk4nNOYrsRgb74kSdgOBoim74lFi2OvTGZgeobEJFUdBZyGXWACYgNvJL9ikLG6KlhqEQVqu/CI3AqfNd40iXcL3xvqm+FE87I+qEHQC8nkShNWGLOkxThIy7QuEPhS0yATaNxK53675MFqJg7rHpA7U+C3aWZGoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XT9C+nFm; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-429d7896d35so15653621cf.3;
        Fri, 16 Feb 2024 17:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708133277; x=1708738077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eSS+leYgx/1CnoRDNP0u4WvLSnhQI+J7A/LTWeqZnSM=;
        b=XT9C+nFmGsjUZelHvCh7UDqtDD42//xwV/56k6cCZLDvmYUkD9sDbV6YYbFcPS0dpZ
         eDCWIvQcrse746JM2AtyG4xmO4C9A0+1zAy9dmO/R1RD+a40FYxABwdyaxrz36s/ZDSq
         Y8PkUXjyD27O3h7ezsatIZAju3AktWYznlFTpELllRQk4BSDQDmaxAUk1XtuaR90dcEM
         hDYzQvzGlIZ7Ugu1JwUUlpVddz8N//CNVquXmwyqIJDGdXPM4cc4go93yUWBVl0FgRj1
         oUzayr8jEUsTOLDs9/gPoJqn0sSTiy6tbeMfLGqQgD8JTK5n+gnMqyc4L746qzXfeY1r
         HYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708133277; x=1708738077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eSS+leYgx/1CnoRDNP0u4WvLSnhQI+J7A/LTWeqZnSM=;
        b=Gmz1sDU+L0U/Mj1hsLwIgnqGPdOSI/UJcVQzch17WL72NeIlhOSH/XOVKaDLCmBhn7
         QBx+YH/DjkjMrGykfIrNDjhdCfWbhRc1Q5JvO7rb2V7vacOh/Z20IdYwb4mvCyCV5ra+
         BCc/kPNQg0TH1cIZchrNBUks7l4zvwTFSrwQ9NEXMGJ2hopa380pTkmkgQLvoTa0xt1f
         jQqkO9G0I7tTUuHq4eXSSTBHwPKi4pcF8glmkQWWzOvNrPlmwMTSZVXAmUevESLGXXFG
         LrPoDyKl5HSdWdqBRVmoja8hnmxn1diP6Q4fDVbpmnxU+VyUT+BKGvTdNlKuycnSikPr
         +8GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU1Mb5O1oyfnRfKGK1mSbAf687DbAcfSxHqzrwM3SxG1yjE6D28x7e9+TcvVAZZXL/aX5mO4Mi3c0DQvBLBWjH8EXb
X-Gm-Message-State: AOJu0YxhVuAjXoQOxCuI0IO4Mib4j6Wqv4Xm35HQUc5gGHUbE62+R9Cm
	PuXRsnIn1cou8HO4oikDoQFlGVw5LDgnY2Q18YOffZFaVL7oAn/W
X-Google-Smtp-Source: AGHT+IF9hnR8bSREogk3Hx7qKQPxYhV2naVJNGag3z7heJHOlNa3UknBb3TQfKVs7wDTqmEfBCFvaQ==
X-Received: by 2002:a05:622a:316:b0:42a:9d03:1c1d with SMTP id q22-20020a05622a031600b0042a9d031c1dmr7243965qtw.63.1708133277533;
        Fri, 16 Feb 2024 17:27:57 -0800 (PST)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 2-20020ac85742000000b0042d8bf105c7sm432772qtx.2.2024.02.16.17.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 17:27:56 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 77F1D1200064;
	Fri, 16 Feb 2024 20:27:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 16 Feb 2024 20:27:56 -0500
X-ME-Sender: <xms:mwvQZYQygqj-rtOrZi-ab66mGlPjsE-3KliRxk_hunsvGSvLemk2AA>
    <xme:mwvQZVw2eAqIkr9diykZtOz57PHa3FpjG0kT3ygDFm4iVdJ5eprIe_osFTjF4FCDS
    qYX7ICXqV0V4OQi1Q>
X-ME-Received: <xmr:mwvQZV0lNlI2QX5hsTbWZJZ8PqDij6WOyRhbiatRuug-YeITCBlPztP_VG0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfevffeiueejhfeuiefggeeuheeg
    gefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:mwvQZcDiPgNJiiJbGRBDm_JEGN7TfizEkXIcdR6IuOCJVVxGj2pgDQ>
    <xmx:mwvQZRjQwqZeRoc9H4xwEKffgxxLimmkgxdu2duRv_AP2GyFQjIeSg>
    <xmx:mwvQZYrG7i49mhF4obfPXQ68SZf-pWsmusYBv1KxDEH_5qKzbUjzEw>
    <xmx:nAvQZaY4Xh9UNsBJ6ulZFJf-QvALes8u2c1xbt8-wUn9cYYvL41D_vRn8l8>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Feb 2024 20:27:55 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v2 1/6] rcu-tasks: Repair RCU Tasks Trace quiescence check
Date: Fri, 16 Feb 2024 17:27:36 -0800
Message-ID: <20240217012745.3446231-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217012745.3446231-1-boqun.feng@gmail.com>
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The context-switch-time check for RCU Tasks Trace quiescence expects
current->trc_reader_special.b.need_qs to be zero, and if so, updates
it to TRC_NEED_QS_CHECKED.  This is backwards, because if this value
is zero, there is no RCU Tasks Trace grace period in flight, an thus
no need for a quiescent state.  Instead, when a grace period starts,
this field is set to TRC_NEED_QS.

This commit therefore changes the check from zero to TRC_NEED_QS.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/rcupdate.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 0746b1b0b663..16f519914415 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -184,9 +184,9 @@ void rcu_tasks_trace_qs_blkd(struct task_struct *t);
 	do {									\
 		int ___rttq_nesting = READ_ONCE((t)->trc_reader_nesting);	\
 										\
-		if (likely(!READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\
+		if (unlikely(READ_ONCE((t)->trc_reader_special.b.need_qs) == TRC_NEED_QS) &&	\
 		    likely(!___rttq_nesting)) {					\
-			rcu_trc_cmpxchg_need_qs((t), 0,	TRC_NEED_QS_CHECKED);	\
+			rcu_trc_cmpxchg_need_qs((t), TRC_NEED_QS, TRC_NEED_QS_CHECKED);	\
 		} else if (___rttq_nesting && ___rttq_nesting != INT_MIN &&	\
 			   !READ_ONCE((t)->trc_reader_special.b.blocked)) {	\
 			rcu_tasks_trace_qs_blkd(t);				\
-- 
2.43.0


