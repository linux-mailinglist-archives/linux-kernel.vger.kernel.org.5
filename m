Return-Path: <linux-kernel+bounces-47511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C348844ECB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 288A4B2BDFB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9633429408;
	Thu,  1 Feb 2024 01:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODXak1IS"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3764419BDC;
	Thu,  1 Feb 2024 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706751741; cv=none; b=USTIHFdH+04gRHNsr1+Hd5fc5MAeycDaN/WycXibE3ScqHd2PwLwOQaVjMoZq+NCzevuxuV1sSXbNPsqZJLDmK2RHL6aGPOX6r/IuE2Cw60n/9fdcEoGnhgcY5vtJoW53S31loikxXlgxPhE/wPZT1f0d7BxXlo4t8Cw8MXiDNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706751741; c=relaxed/simple;
	bh=O8nU5bEULJUElIjpZZSaHK6+7EZs2Vxmkgn27DuOtNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OH/KiaTktl71BvdPb7EE/CU4gubHves2PX9f998FgnmxIib1t4dspGrBqGMO4u/qFe3nhkhAW1jtZQ9DHnhQGYl5yuasAprx+C33afpl993jsiQAHgF4i8XEokB8UvSpMA2dtZdPcJgaAEQzy3AkrGO9lY2EB3fUMVh69lrC96w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODXak1IS; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42993124fa1so2500961cf.3;
        Wed, 31 Jan 2024 17:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706751739; x=1707356539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kITZv0k9fxTTu9rhEhSjW/uQbfGz/wypbxDOcIf6Ytk=;
        b=ODXak1ISq3RHSWZkzysRoiT0/3TxPFnaRFie//clqDP80Q3g3grT/GdOK449OdLs5f
         3183wCIfRVA3/vwTXRo3lyfN4PnrJyYX8oq70q/Gr6Z+3BA14wrbL2+y4p4ZLW/0eHPo
         u9IhFKG4B9c4UgtuQE3d01QSre1RcaKv50OANTWxFK++w5319eXt8TgmUrZJhv2lk41u
         XAldT2rZKMNEWlTKoisLuxBLbL4Bjxi7RsaVhfdw2ZwJZRHwzmU2Zps6HFsaZCENr8BJ
         BgJaNshSNXhQnbYw6a+7q5k8gCDqwBNnYVOfG77OqACKl5peEIoqIA9hVfxLjgqp1Yoa
         ZTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706751739; x=1707356539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kITZv0k9fxTTu9rhEhSjW/uQbfGz/wypbxDOcIf6Ytk=;
        b=wlRkShvR7xaeJgzZMzgpOdJTMEJjMDLs8F1w/pNf3xAWfIpw+e177ixKp0Xdhm+KCv
         f8BrlER90VeRXXZHAnkxusLbze6hV2P1X5YGQNyAJleIPv7knar4WU0AJfaFsr4MaBdK
         uh81BVj4wcGGsEMjaFd9hgMwekPrmmUzSgwiIRSFguU4yLzPkbquAJEgIUw3eGoi47hL
         RhLoT4gnvl7jc52307KEvBAhzsKubdHn9MEwDJFzXYPdpg9FoQb+GeubXiAR/A4H1wg2
         nBXSTp6/7vxqxrzLEqiOAYKDOJQ/cJtpJ8FjHH+pL7DzX5IEcrXlO9iSMqNfOH6jAo6M
         /acw==
X-Gm-Message-State: AOJu0YxK0fdgJNfCfktbGmu7Hd0IrFKIDqFzEwoEMlqnrNoiwKkDZ6R7
	1RQttLCfxuC+3jAEQ8vP3/TfU/N+oSUsx91JjgvQ7UNSdugM+rvc
X-Google-Smtp-Source: AGHT+IF54iKoob1lK/h1KqyUuXfADz8JsCv1IYCAn+54L6vf2AXkZQQbqJz9nYKw5YPhd78F/D79Jw==
X-Received: by 2002:ac8:5947:0:b0:42b:ec11:1a6b with SMTP id 7-20020ac85947000000b0042bec111a6bmr3654721qtz.67.1706751739040;
        Wed, 31 Jan 2024 17:42:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWyQ/sB2p8wMYMTrAO5UrG4Qn303OKDFKXkbM494Xo3znQVI0CPuSatGuIIl7tjl5Ipx9gD9xmEvBfHDcdi3f6XqxCMfJ3CgzxfZmt5xR1sZOrcOvv9+qWeZ0fkIovuhKs8au6MeHk2kCqz/mFa3SEBbv/JtYn2/jtB5WkIVJBb91c5R5pWwwd9G2zZSI3L0N61ZMZI1PikHXWuRYBTyMy2qLEvB56XnqscgUK3ifJo2aKdzRfMmiqUogxqeWSyqVaUeM8umARUCyZsJR8TAkLBTzDKSKYcmBVlqhWfZ5j0++XMWMrho1MHAIl+whO0Eajq+zcxdYWHEeeJsf/+1TWeUK/HnJkih5BCWXdS7MJMmywmtZ15nZFg
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id gd13-20020a05622a5c0d00b0042992b06012sm1644885qtb.2.2024.01.31.17.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 17:42:18 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 438251200043;
	Wed, 31 Jan 2024 20:42:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 31 Jan 2024 20:42:18 -0500
X-ME-Sender: <xms:-va6ZSS1vKh9T7cqs0owimNx9xGyLGC84NkA2sHXUtBm8A4VjskaYw>
    <xme:-va6ZXyUPeDjDD2Nx76TB_w-XsNYDZCGBUAguPBs-k9iCOGjfmXhLiGRMPGppU96z
    vgJp9taVo18IsOPag>
X-ME-Received: <xmr:-va6Zf34Ty8JarLWeywwbLf10kSi0ojzfAQY3MU99dVHJaq1zo_Ugoy4RNf8VQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:-va6ZeC93zJt_VXxQ7-1OL0SaXBwTFHJgx3mZeyzQz16_LCpInFhVQ>
    <xmx:-va6ZbjcnjTaGAKEJyEODzh86wxdoO6gCc0M5p76DYqpXxScA8l8LQ>
    <xmx:-va6Zarmd6zAQrZGIFY3KLxbZuCWCmqDB_m9KSkvkuv4XTh9U5cx9Q>
    <xmx:-va6Zer33D3381nhzR-3ZpCbH-mAzHJ36FWhkjgPqTMweWp8iIeIt0BaCTU>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jan 2024 20:42:17 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Zqiang <qiang.zhang1211@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 5/6] rcu/nocb: Fix WARN_ON_ONCE() in the rcu_nocb_bypass_lock()
Date: Wed, 31 Jan 2024 17:40:57 -0800
Message-ID: <20240201014100.3204532-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201014100.3204532-1-boqun.feng@gmail.com>
References: <20240201014100.3204532-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang1211@gmail.com>

For the kernels built with CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y and
CONFIG_RCU_LAZY=y, the following scenarios will trigger WARN_ON_ONCE()
in the rcu_nocb_bypass_lock() and rcu_nocb_wait_contended() functions:

        CPU2                                               CPU11
kthread
rcu_nocb_cb_kthread                                       ksys_write
rcu_do_batch                                              vfs_write
rcu_torture_timer_cb                                      proc_sys_write
__kmem_cache_free                                         proc_sys_call_handler
kmemleak_free                                             drop_caches_sysctl_handler
delete_object_full                                        drop_slab
__delete_object                                           shrink_slab
put_object                                                lazy_rcu_shrink_scan
call_rcu                                                  rcu_nocb_flush_bypass
__call_rcu_commn                                            rcu_nocb_bypass_lock
                                                            raw_spin_trylock(&rdp->nocb_bypass_lock) fail
                                                            atomic_inc(&rdp->nocb_lock_contended);
rcu_nocb_wait_contended                                     WARN_ON_ONCE(smp_processor_id() != rdp->cpu);
 WARN_ON_ONCE(atomic_read(&rdp->nocb_lock_contended))                                          |
                            |_ _ _ _ _ _ _ _ _ _same rdp and rdp->cpu != 11_ _ _ _ _ _ _ _ _ __|

Reproduce this bug with "echo 3 > /proc/sys/vm/drop_caches".

This commit therefore uses rcu_nocb_try_flush_bypass() instead of
rcu_nocb_flush_bypass() in lazy_rcu_shrink_scan().  If the nocb_bypass
queue is being flushed, then rcu_nocb_try_flush_bypass will return
directly.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree_nocb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 9e8052ba14b9..ffa69a5e18f4 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1391,7 +1391,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 			rcu_nocb_unlock_irqrestore(rdp, flags);
 			continue;
 		}
-		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
+		rcu_nocb_try_flush_bypass(rdp, jiffies);
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 		wake_nocb_gp(rdp, false);
 		sc->nr_to_scan -= _count;
-- 
2.43.0


