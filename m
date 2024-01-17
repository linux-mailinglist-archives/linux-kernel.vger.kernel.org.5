Return-Path: <linux-kernel+bounces-28832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5400A830387
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5281C21211
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC531BF5E;
	Wed, 17 Jan 2024 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+2uUPPW"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3651BC2E;
	Wed, 17 Jan 2024 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705487190; cv=none; b=a8B/WQKz5IOXqUTPSc4ZbKeRgQQmexwDQtWdqbcGhm+PjAELwy7/pG4A+QcGfH7WZI0FUa3ARl/RJyz/tq8HLOgik/zGTT6DlRDQQV3p7QtzJ3kz7RYGjyFJv8UzjRpxB4D6wKxQT+RZttKnBoMeAozyHjJhno/g34IpgSO5NUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705487190; c=relaxed/simple;
	bh=nw1ctmmn99ih3vrMxnXPLShNwmlGeic28XUYbf2UxTQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer; b=QOBpmUa9rXc+M5y6Gac9qcbRxNk7j6EFJ3Y2OH5+FLdmzgH7oetquzscmv9ZZV4YUUv+LYeimOGhUoLLir/3u1/SqHoNfhIHi8mlN/zb4XcMfArwAzXfUOTfgJ0b63Q40yIP/jjdeYKfwy5SQtIlUDmgt6lcwHaCKeRmExIqyIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+2uUPPW; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5f8cf76ef5bso97801697b3.0;
        Wed, 17 Jan 2024 02:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705487187; x=1706091987; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cr+Yty3TNQxQc0mfbzoHMY7BuPSC95Nw8wev9SQkgyM=;
        b=W+2uUPPWHR/jIIWzwTg5Z57VExOAwg6Kd7m1XlJrTweJjsNpwObS0dcjCzfQRtpxi9
         zMwonfbsQiGmU97L38AR4R6qoeV6jKdVKlx9Ezszr9+f5ZbIfxMePaSQtjjn3nfQ4mvX
         FmZRo929peXTPTBGow5Y7kLtY7whZLCW8LKQqiMMBQzkJtX9V2kfl9ABbttME8PpVQvS
         ibBfFFVZu4zNBG/2E4Pnplf7ImmzS46Pz2T3RlvrNGs4GM4sr7axJs/s4YXSLVcBH+YX
         3TEYaKY42ZVdIkTh6Uekt3EttwRzUxiII9jDkPYkcc76nTJOzX+R+GEbYagvgCIwryPW
         t/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705487187; x=1706091987;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cr+Yty3TNQxQc0mfbzoHMY7BuPSC95Nw8wev9SQkgyM=;
        b=FTRGtEl/iu/Yd0tyou2fwBE85UpM8OdJ/UPXV2HbGHu2176ZIyZumY719PSIkRIfeA
         f+Zt5ByMPkBXr65GPkf/SLaDiJJ5vMgMlaA6OK2dxj0w/61O5ftcL9PVOi/WGVpamcjE
         JMuOKicA7OYIPLwGh82pm2m9OQeXFLMcPtHnAB9e3KF6Vb2XTr4iC4X3WEf5iaOvpfzU
         vm6z6hJYdlxpKqswtWGc6JGRIcxJTDDySV+kCm1xhNaLgINq7LY8ZO2D44g+D88Sb8Pn
         53one/21xM0LMCPpv0vkNYd5iPg3/oLwxd9uFkCRfwW5e7L6W7IE2R86kORb75JjGGH4
         msCA==
X-Gm-Message-State: AOJu0YyKXdmalnRNfT6A1uwgQ67eSLxsAginOIIjL3Z9AU7XPnoBCWoY
	Wque0/6ou8v7ecgGvyah7zA=
X-Google-Smtp-Source: AGHT+IGFxfJu+5xNE/cuDHqTxgWQmGMLi+De5VIsw4LLcuQlf1punDqfdOJy58C2YToxWnP5pMgTaw==
X-Received: by 2002:a81:b385:0:b0:5e9:5538:d930 with SMTP id r127-20020a81b385000000b005e95538d930mr6529658ywh.47.1705487187588;
        Wed, 17 Jan 2024 02:26:27 -0800 (PST)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id e18-20020a170902cf5200b001d58ed4c58asm10657042plg.63.2024.01.17.02.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 02:26:27 -0800 (PST)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	quic_neeraju@quicinc.com,
	joel@joelfernandes.org
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcu/nocb: Check rdp_gp->nocb_timer in __call_rcu_nocb_wake()
Date: Wed, 17 Jan 2024 18:26:16 +0800
Message-Id: <20240117102616.18302-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Currently, only rdp_gp->nocb_timer is used, for nocb_timer of
no-rdp_gp structure, the timer_pending() is always return false,
this commit therefore need to check rdp_gp->nocb_timer in
__call_rcu_nocb_wake().

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/tree_nocb.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 54971afc3a9b..3f85577bddd4 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -564,6 +564,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	long lazy_len;
 	long len;
 	struct task_struct *t;
+	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	// If we are being polled or there is no kthread, just leave.
 	t = READ_ONCE(rdp->nocb_gp_kthread);
@@ -608,7 +609,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 		smp_mb(); /* Enqueue before timer_pending(). */
 		if ((rdp->nocb_cb_sleep ||
 		     !rcu_segcblist_ready_cbs(&rdp->cblist)) &&
-		    !timer_pending(&rdp->nocb_timer)) {
+		    !timer_pending(&rdp_gp->nocb_timer)) {
 			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_FORCE,
 					   TPS("WakeOvfIsDeferred"));
-- 
2.17.1


