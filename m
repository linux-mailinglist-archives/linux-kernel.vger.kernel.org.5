Return-Path: <linux-kernel+bounces-39583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8484783D332
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 05:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3318F28CFF9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3561171C;
	Fri, 26 Jan 2024 03:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwjB1pYo"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4C3D29B;
	Fri, 26 Jan 2024 03:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706241564; cv=none; b=HAWXlMmP6dv0lmMHs7tpZNvkQjxH6R8LAPdgETwSzy2qrqxkeRF3eYcymti+xQXumoGsMvJZqqmGbln7xYWevsWFvc7p9UVGu8I8HlhDfhpkp5CgE532jddmcewseMR62Izytwv206c8DsutE1DrwnntnO9D2/zwjyh2YNKXL8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706241564; c=relaxed/simple;
	bh=FNWtIgM9IxJJ/n1X7p2clj7JyxfCP6T+ugF4coDERKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxLN2IoAqPsjhQi876TqoWKydPvUsMFLax2chvDZiTAXXWrJEaqH9qguqmVaS/hjg0T0RKA677n/Nn/YG2uY3XKk9aFjnJGJiXUOPQcDCPte4sbMTqNqHuwseQ54pmpgnDrtLJRlEuuDaPV8+THBIPm+EY2eAJqiycJFCuNW0RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwjB1pYo; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4298b23abffso1711511cf.0;
        Thu, 25 Jan 2024 19:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706241556; x=1706846356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ec+oZMGt7I/sXDo2HDWfHkpmX9raXfcV0tRYDCJOyxY=;
        b=MwjB1pYod4O4utrPNBGSbWwbRB3So9ck4iszaKQx1UFG/KLFV/uQWD2Pk8pMxIyqbS
         CkSrKJIzQZ9HrMpIUNHNRUsrq21m5DaPJEexSKSEut3ixRlr/bjz+dNKKyy/1jE0w3vM
         tTQHfbZqy5dE6muGEbHgzf2R8PMCm5DyeuxQU1e1tHHjEvvIo7w6vx9cB+Yi1Mzck/Md
         3athfiWcZI7wKtPe80/XktIlu2xwO9iRk5pXGF6FpibWVshINAfRKfzCJTHT7hlC1Xk7
         kJhHllfY2vOKx4jSy7VbL7JZ+mQ0OBApDVMCbxlBsa8Ht2cDMg2QrT0KkteVDZPI0XYd
         o4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706241556; x=1706846356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ec+oZMGt7I/sXDo2HDWfHkpmX9raXfcV0tRYDCJOyxY=;
        b=thOjcD4efJmaGOOKt81iOCD7RcS0kOFq3QENRiQTVgersH5xRkay4Oj6Q08xVac6LP
         J3Fm8VlY/1rF3wREMqzFU/FBH3sbKO6DG8v5fezu/Qt2fpZDtFiR/4XjausgJDJdZtJ5
         927DhYqVULoKiozlbIzvPl+Do+Z/MbtYSRUs8Nx+UWfYGk9c+fUA/Q8smlv//fuNYDQV
         y0ecs1tAEoly6IIbKMeHTq4dUbZh1bdZypw1rPpJgYpRg7RdeDEldmSHT6afUoxYzi9J
         3ck8nxn3Lrmds0a2UJlucSd+i5+2Zz+ct1zLP+VGBe6ajR8m0c4ZailfNWgLYZqRKGwd
         srgg==
X-Gm-Message-State: AOJu0YxVKn9L6G+JeeHiOK/1WWA0KglVEL4flXj5xyz3mZvvU3QMAAPI
	44got8cAFWDtR9Q+p6icxjxQ6moYP384dbQTznQvv05JuWPk4KpH
X-Google-Smtp-Source: AGHT+IGeshD2bZzndtui5NhXwd4hSS/vcea7AvTLd5mvDiVIP11+gSlxO5rQiEsgBOMvR0efH9/fcA==
X-Received: by 2002:a05:622a:5d97:b0:42a:751e:c2c2 with SMTP id fu23-20020a05622a5d9700b0042a751ec2c2mr473591qtb.40.1706241555874;
        Thu, 25 Jan 2024 19:59:15 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id cq11-20020a05622a424b00b0042a109265d5sm152988qtb.20.2024.01.25.19.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 19:59:15 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id 2E7F727C005B;
	Thu, 25 Jan 2024 22:59:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 25 Jan 2024 22:59:15 -0500
X-ME-Sender: <xms:Ei6zZaNSMTo3tyXdFAiOxFJ0lfjI6q743cGrkWKRDaqyvvBySrTJ3A>
    <xme:Ei6zZY-9eOeb9aAB8cFA9Q0nBQAEW23f4yCdsvcA89AaZq_iokLmKhWeJc5-cHRia
    OWeQ6ygEtUK9d_0Qg>
X-ME-Received: <xmr:Ei6zZRSI68G329kz-824Fleo0VKfcmeiPjjkIahtm-_76pVxk7efD2lEr6c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeliedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Ei6zZatU3jxt4LHnHBa5uYdv-S_POTFJCKYTVQxIAJzKuZiOUDEYAw>
    <xmx:Ei6zZSdzoz4elDkBwWlXi_G20NyOcW_anFNMXmXv6Pi-GyTiXZ5x5A>
    <xmx:Ei6zZe2t5_9zZfLM8eP7kz9kVJhNnqqxufhJXcjFOdkIzmQAXgPwtQ>
    <xmx:Ey6zZY3Hd4uuD4GVCEcV1Zy_z83Vt5AmiWyGwhEzWdeqtO33xiLClA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jan 2024 22:59:14 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH 3/8] doc: Make checklist.rst note that spinlocks are implied RCU readers
Date: Thu, 25 Jan 2024 19:58:06 -0800
Message-ID: <20240126035816.3129296-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126035816.3129296-1-boqun.feng@gmail.com>
References: <20240126035816.3129296-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

In kernels built with CONFIG_PREEMPT_RT=n, spinlock critical sections
are RCU readers because they disable preemption.  However, they are also
RCU readers in CONFIG_PREEMPT_RT=y because in that case the locking
primitives contain rcu_read_lock() and rcu_read_unlock().  Therefore,
upgrade checklist.rst to document this non-obvious case.

While in the area, fix a typo by changing "read-side critical" to
"read-side critical section".

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/checklist.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 2d42998a89a6..98a622f77248 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -68,7 +68,8 @@ over a rather long period of time, but improvements are always welcome!
 	rcu_read_lock_sched(), or by the appropriate update-side lock.
 	Explicit disabling of preemption (preempt_disable(), for example)
 	can serve as rcu_read_lock_sched(), but is less readable and
-	prevents lockdep from detecting locking issues.
+	prevents lockdep from detecting locking issues.  Acquiring a
+	spinlock also enters an RCU read-side critical section.
 
 	Please note that you *cannot* rely on code known to be built
 	only in non-preemptible kernels.  Such code can and will break,
@@ -444,7 +445,7 @@ over a rather long period of time, but improvements are always welcome!
 	real-time workloads than is synchronize_rcu_expedited().
 
 	It is also permissible to sleep in RCU Tasks Trace read-side
-	critical, which are delimited by rcu_read_lock_trace() and
+	critical section, which are delimited by rcu_read_lock_trace() and
 	rcu_read_unlock_trace().  However, this is a specialized flavor
 	of RCU, and you should not use it without first checking with
 	its current users.  In most cases, you should instead use SRCU.
-- 
2.43.0


