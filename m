Return-Path: <linux-kernel+bounces-43597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BDF841617
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A83D1C23907
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6074053803;
	Mon, 29 Jan 2024 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ8Y9deZ"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC3F51C3D;
	Mon, 29 Jan 2024 22:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706569140; cv=none; b=XU/h5wdd6l17G+I3emHdlLJHPZVSZ5hxy4XuLV/qaCPwQ1Tq/NlXtuDY3eIRq2CqSRlrBaghut/6hHsNFK0DRwa+/iZU5bQP5M3TQGOpd4zosSIed5ePTmrr7vSGT5J7YEt5SL0VOqLfC6thvvBcEB+JbeVVIYXApyEhrEoWSx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706569140; c=relaxed/simple;
	bh=Ct98LTnEHjEQ5QHUfLrl5bkdPkiFPHreddrd8pTZdCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFSAKEd/Gdm0kxFnDrmVRoNEAHBRW/yM8eYnIbE6Te93pZ4mp7otXR3UFaT+Yqndp2g6VviOvx7mNFORxfB7ZJswdLZ8eZcFsZxXiVeILk55HnNgdHiFiMZYaGCfJUz0tg6eA2BSKwTLgB8KIQW3md1AEK/d0WO1xg7F80RqvUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ8Y9deZ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-783cd265c76so191383085a.2;
        Mon, 29 Jan 2024 14:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706569138; x=1707173938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=58P04TyTgqVL15aFXrdXFK0+6dPEuuWKIGDYt+EKox8=;
        b=eQ8Y9deZ1fTuoCCOuU0XRmltJfn2vNZe6JG9h7gzIadtgRgI3efwZsADaCZF/9uHYU
         F+qB6XZwQ4RMNI290B3X8/C/ylMnUDMH7T+E1K+mHu7Aw9+TjXzCEOjHbD4xBCRci9BX
         PKmCQR08nKOhu16SJrwQuO2LT4ioW+aj6jouNap2RYYeI1NygzrOVBYndMqCUgmnWl3D
         0w0HoYBiM5+faETAIq11E+zNkXH+5jI4ZmzpDphnChiAitjXwcdROuOgrhEM2S2f1d4K
         laueZIQ9CrBL3oDMeqdLlku84/gA+KY5A2vxXTP0SDdVvxjkmgkQ2HYgu6Mmo31D+JTE
         T04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706569138; x=1707173938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58P04TyTgqVL15aFXrdXFK0+6dPEuuWKIGDYt+EKox8=;
        b=p7zONnUmz9ro6matgchVVyCaAAu44tp46dIqIPBgX3gAFPdC3M3HTfU+SofWkqe8oo
         7LaT4OseQFp4Rrpy+aFJB8UCEKdWTmmk+JDRc0B66z1tS4WrN7O9PN5jRs0y1opuj0Tn
         izhutU4vjxMo+2LQ099ceJVjJxgQkdiD3DFB723O/ncbb7+QRe7UpEah749DNL3oCe3n
         4z28/9HlMnJvv1f87rhkfOG9Uikh+yxvbjJhTkMOen8Z9nJ8fuE+vr3kNXixxqkCNxFj
         vzjoXm+Mr2g9LtlsUFKIUmip3+aUQ3Rl88J71vCnKYb4UlcgscYwjH5R3bbWZ02CrVC2
         cRmg==
X-Gm-Message-State: AOJu0YzZuoXXVdnXs3vwLSPiwxm1pIDZdRrSk7syMmSRyT+KzJd7hoUU
	TFo0JWqdIajd7hs0fHLj/xHkmoocKeOWcWa8/Lb1rFmnw7o6xiFx
X-Google-Smtp-Source: AGHT+IGe75EI87tW/uWHutXCUAFe2PMu/kdeYjch8HHf+xlG/AF2DVXrtFN96611kATMuh+ywGvBRw==
X-Received: by 2002:a05:6214:c6e:b0:68c:46c0:b8f5 with SMTP id t14-20020a0562140c6e00b0068c46c0b8f5mr4498305qvj.64.1706569137859;
        Mon, 29 Jan 2024 14:58:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWhx4wL7Czyzxam9xJSaSaRW3wpjCmroUsmTnePI8VjVDusKV1bSa/fCxeFb7yYFLdNett8qX+v5kL7I69RgiQZJzSHWTpvu3GHbPjazxT/7l87AVCxCTeziBuhOpXW1dCSppDPq/hKbEDQpFi/QYlmmRE1gpbYmeYZlxxBoDZajSwZW8GNEGVjqcJVvosf95LuSJS1ZFNZUm50GFnfsKJYr1dXb/yKew3bmN9EuR5jPlj4c/sgcP1x+QvLa65zGTTRcJTx5FN6unqmg5xrzWGKhWLTapjmd2yZRgQeZy9A0Wz80sLxJAyON/AuutUapYve8mNPPj7HbwueiYXm59YRoQ8g4YoT0nyOwhmvIB512ENLW7oN2MfNlViu8/hgvbGiyXdyKLuCEZD+cWZz1nm4nvNMiEHeVz6a
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id t26-20020a05620a005a00b007840137670csm987820qkt.24.2024.01.29.14.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:58:57 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id C78DC1200043;
	Mon, 29 Jan 2024 17:58:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 29 Jan 2024 17:58:56 -0500
X-ME-Sender: <xms:sC24ZacI937_TuM-ff4xAY4-WpUJoDRjHRwd2D0UNOR548Pf-QL5BA>
    <xme:sC24ZUPV3hRoI-8oB8M2vpPMnA01PLnqQPyMz4GuSm5PSY-RSYM8UyQRPeY5L47NE
    M_dg_IiVygp7qj5Ag>
X-ME-Received: <xmr:sC24ZbhXn8GS7uwxWMzScnD7MyPS40Y2qWwOUjHomWjLjAcYTGaP7ewUrarMRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:sC24ZX8VK0z86Zd9mY-NB2nbbPrSPGst8FpFXhuRlq421ifJkSqqfA>
    <xmx:sC24ZWsFAFMCHeqdJXmjksLwHLPmPuTO_ZGs-bsNclsQiSl8e0v2nA>
    <xmx:sC24ZeEMa6WbWU7uHAD0IbbCf7hz_8P4bbl82r4yY4o7OVc2-qf4Tw>
    <xmx:sC24ZXGu64DDugetVHpxkdrAYvhSwiuM_j8ZDT44hE9hI-5IFdXd1OVfPq8>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 17:58:55 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH 1/2] rcu-tasks: Repair RCU Tasks Trace quiescence check
Date: Mon, 29 Jan 2024 14:57:26 -0800
Message-ID: <20240129225730.3168681-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129225730.3168681-1-boqun.feng@gmail.com>
References: <20240129225730.3168681-1-boqun.feng@gmail.com>
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


