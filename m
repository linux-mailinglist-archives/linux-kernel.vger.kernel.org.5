Return-Path: <linux-kernel+bounces-43617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8248416B6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7C71C22FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AB953E24;
	Mon, 29 Jan 2024 23:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jB2b44Kg"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090EE524B1;
	Mon, 29 Jan 2024 23:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570715; cv=none; b=qXSZHiKqdtZbbJGHIls/X7yBZrPLY8hpsB4lt9jXuoXVJey3fOLSUGX9131L5k0n6CUWdVpamjk/iru6I49wdeXhyqV1AddOMZbKU/p+xj3gCrh/HhI25KQo0Zfmp1+0hDBZcCcb59jcDgXCT9yB27Ht6FjANAllel8hTtj2yB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570715; c=relaxed/simple;
	bh=Zqiy6B3tSxq3Lcht/Qe5YvYYzwqyjV5IKSggLfIvui8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBtf9ffe2wEkrR4hBjYZ2JABRZKI/fazxn+dFM2gItsujlWq1TkJH/0LVzNa5ImO+ZfNoBTEhteK3eSGOnAPya3lcZdkKK8tFVFUzq3+061aqYMNDmmbEdn1+HGI3JLpJ+UkHhOOtnKEqWgVvIuYp/Sj5gcAZUGpNlLuF2/XzzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jB2b44Kg; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6818a9fe380so26030926d6.2;
        Mon, 29 Jan 2024 15:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706570713; x=1707175513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+/Xp+usnOvRKbEZhvdn/PthxFWiJZPSLxCe1oxzCzno=;
        b=jB2b44KgySkoYtOcLcsf/umy5Xmo+WUYlU3dQAuWuDW3/zRYJCbzT719YtV/oo4H2r
         +kSTYlKqoW6JmOELA/VWwJQcsIRtDml6ax9h7/ndKC/hwoyVeAREgMMLZAtqSFqrcfaa
         HhNaGgAXKmUAw9LCNAcTVAvCp11uHADVy/PeA0jHbdPSeyM3NntXOHVQBsvysInap48j
         x08iMFSCpuEt2L2cvY4Q9+XS8ohq1t98TJ6lcK71+yY3LQ8yEuVie1Q7aM42m08v9pMK
         ylJ0Runz09frrP4RzwFUb4fgHhGxhMWoLfxWyuuoC4/OiZgsWROLhAC+pxwe+oPMksZq
         pT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706570713; x=1707175513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/Xp+usnOvRKbEZhvdn/PthxFWiJZPSLxCe1oxzCzno=;
        b=NNNoXV4AloiQKcFV/ump7uzll7y/tF1mRzNsFMOCsRNlX3E5ESdmMfdCqSHr7j+d2s
         q+oBjBz4nj1LHHHZloPJht5GBr5YzLu+5xVaCfZ6CG2f0+pXMV3Ujnz2mschp17yXaFt
         2IC9MonK37DKfdP5mEEGjz1tM2oCB6GmDzWPAeBGWsEQd2XMlDeT5GZunO/KaGm+Gb3f
         xbqdC4jFUmpk9frG8Fpnx5daKjpCDSYcltZg6i7yVQzw6P9be6eFkzcNueM4E8dDg667
         hhaREd9YybGKocm0anngfSEo5Ako7NbR5LvOGM5VhjawV3MYjDTbvUDGKCe5wj4CtPLN
         5fFQ==
X-Gm-Message-State: AOJu0YzHWcv7wJWKztl0M3a6Aj11XplyunDHnGzmSkMXqtunyRTlquEm
	MB4a89b7C/gl3X/KuPrDWP2vtwO1ZbkHiJrp22zDIxLOeqTOx23f
X-Google-Smtp-Source: AGHT+IG/k7NjgAmVmJGWPMB872SnYL2SX/tx05iGELroNPsHBGQzkiDNmN+lYMOA4PsQgPEV+Udgjg==
X-Received: by 2002:a05:6214:2a45:b0:685:33e7:9ab3 with SMTP id jf5-20020a0562142a4500b0068533e79ab3mr7711849qvb.15.1706570712908;
        Mon, 29 Jan 2024 15:25:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXkrHBug8RO13YubK5W8zb2Otf2KhQkS9Q01pVSnxNNu91K4YlB4Sml/sK7P0MFo6O4OfstDiwyyZdnBjoYzCLHyNAnS17+KXfaKdjtlUmCXy7e7xWJ1JKzUAX1Y20JNCSW5vfkqMenWc4eXTeFH4gunR9pVE8yz8bF5HGsZCk3sQP2vDZp6h46VB4Gghg41Vb0/xQQrFVEmaEOzC8cwPto1DuoMlcMsnwrvaiFQ5oBjNPrbErvLC5YIUcV/iHQtc3vViBL2uNY72BOGpiuhmVVzP+OxJiiN4xVCSKoUEaL1RkSFOXQFQEJM/P+KpPReaXj9Jc6PiqOWaAadakDNb4I1+OSJXIhDRYyeEszeTP/9lR0DemCOTta60u+unc=
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id pd1-20020a056214490100b0068c5b3a7f2fsm508374qvb.37.2024.01.29.15.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 15:25:12 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailauth.nyi.internal (Postfix) with ESMTP id 0F20327C005B;
	Mon, 29 Jan 2024 18:25:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 29 Jan 2024 18:25:12 -0500
X-ME-Sender: <xms:1zO4Zb4_qqfdJWpXdjb4HsQClegv9cEbuksAMFPFd2jeydYC9im82g>
    <xme:1zO4ZQ703yfjmmAmJgRT-21ut1ryultBbjK2-83kuQkdC6hchqY4B1D8eEwP5gruK
    dXXLbMhEtmJlPVCMQ>
X-ME-Received: <xmr:1zO4ZSfW50evcyC2KFH8sKmnfraFxLxWJjDu_lx8rbzZckK9YDw78f20iORbgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:1zO4ZcKk9GqFtDNGU9csArtaBvGlMVKQI-PKsmxpsA1RYMr6k5pmIw>
    <xmx:1zO4ZfI2TLF9CrTg1aO8DM6KOPq3FBG8ikTN0gDFGt8sLteAJwgrNQ>
    <xmx:1zO4ZVxtz_qFEQ4pzv3nw77FOm-jz6ocMPMRTtwwakk3FYOKQUdX7g>
    <xmx:2DO4ZRyPy5ltck17rGzd_hBASQ71o2Q-t5-1lRSXenLswpMtxJ_Leg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 18:25:11 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH 1/8] rcu/exp: Remove full barrier upon main thread wakeup
Date: Mon, 29 Jan 2024 15:23:39 -0800
Message-ID: <20240129232349.3170819-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129232349.3170819-1-boqun.feng@gmail.com>
References: <20240129232349.3170819-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

When an expedited grace period is ending, care must be taken so that all
the quiescent states propagated up to the root are correctly ordered
against the wake up of the main expedited grace period workqueue.

This ordering is already carried through the root rnp locking augmented
by an smp_mb__after_unlock_lock() barrier.

Therefore the explicit smp_mb() placed before the wake up is not needed
and can be removed.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 2ac440bc7e10..014ddf672165 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -198,10 +198,9 @@ static void __rcu_report_exp_rnp(struct rcu_node *rnp,
 		}
 		if (rnp->parent == NULL) {
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-			if (wake) {
-				smp_mb(); /* EGP done before wake_up(). */
+			if (wake)
 				swake_up_one_online(&rcu_state.expedited_wq);
-			}
+
 			break;
 		}
 		mask = rnp->grpmask;
-- 
2.43.0


