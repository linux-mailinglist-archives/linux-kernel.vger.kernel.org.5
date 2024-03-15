Return-Path: <linux-kernel+bounces-104105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AEC87C900
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D167B21363
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D635917C67;
	Fri, 15 Mar 2024 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhW18W1Y"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FC3DF60;
	Fri, 15 Mar 2024 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710487108; cv=none; b=WJBDH/87T3BDbR5XntKAERJhkY1TDpr6V7j5oUM5eVC7wNsmM+xU4ne0hov4e/ej0Hpg9hKRzZc3un0Lnt7ULj8shDbNudT0R3Aa3J5BKy8Do8b+yPpQ67sCkGgh0Ot2Sa9YiwPA0Vx+K8QkyqjQD+xkVjNLzICDYeRUi5QoRPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710487108; c=relaxed/simple;
	bh=lnVDSxRnrhdlQcUBHCMyR1xKcTJ+DlbtvKjuwXIpnNs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ZhNClKZrm4HSCq0bzC71Dw2K9e2nZjN8HVNpbF5dhSET0G6OiH2ZBu5svlqkTefWOMKvkdEM/wYEYEVoa6/y153RyqXTgcRFKpdgHhJl7IUkgSPDuCzF8SI/kOfc0Chs2yt5TXxhpDpNX73GrTcosj6zo6y3kgXuBSDgKdcW9A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhW18W1Y; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e677008501so451108a34.1;
        Fri, 15 Mar 2024 00:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710487106; x=1711091906; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvCAXC34R/eOVHZqXM9EX9OFdu5vFiFX2M+c6KaiAjk=;
        b=hhW18W1YIY5sA2jUsHD7y5OAv+ZzLgFcMSb5eZ7ZoQ/3LZUDBPpLJUsrKihE3hVoOt
         +gpT+NRIHc/An5R9DiomJzoZiVXEV38znEzi2aZaePKcrG1DtYB9pNXi/IFWK6qS5k9E
         WkR5ODWrjp51RMnkJ6Wg6XJ8NIPnWe1PJT1KRIqLyGMOxCs0dI8+EV/fGvqJPQznv0Nm
         X0WiQoOeJzHulTg9JqcvGy7eMYs7jGLaqGrtB3e7BL7KQIFRLULaMnWCD2eTCuKODJmw
         5KIUTXgTELSK5IDMtRLoGi/90BKk0272H9NJWtXvPr/l0cFgUZPjxC/JX69wRCfac+FX
         tjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710487106; x=1711091906;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AvCAXC34R/eOVHZqXM9EX9OFdu5vFiFX2M+c6KaiAjk=;
        b=ubTi6FtYjEKclAz+FoP0bjBAQLilSbT6tERZtspL5yF0sssE4k3XMh0vvOVuwdFvWq
         +xbYX8sPHytQr4FkbceTD+MNXoMssNJODViJTn6QYXc/D17mDhtVAb9x7BQ+TXHiwj6h
         qqdPOw5FpdIAo1a1UBOzmGKVRkWIAu6wo1TwMSoKNuaNNE5JcdbLDyXV2oEdXyN59Tgw
         4FTsw0WDslNLiGppIvCro3X7zmG1pe4S4J2Cj5ciaAFSL7+6hmwwXSbSxGbCmjzjnOh2
         zXOuzm4kQNSTDAz8J8CAsMoVwpjHVyv7axgqYosfdWsaYfFBtuhDs446JKEr4s+yNTRw
         SJIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNX55ZWnQJFkyJgpr1GibQuBYoZWckakRIfiIDO4q5UfGgq29BkdrywpsX6KJ5HQ0RSwezp55CY+SKYRqexMkdC3Lx0Z1yVt186NAGwhx4yvaHF/4Ruhue11pbN/Vq0zn2
X-Gm-Message-State: AOJu0Yw8Z1ntk1BU20tpKJ9YY5Zq99BSXPeoMDmCF2koQBy5bO4bL16N
	AbJsgUv1f43mYzTZN0cC4ojKy5dO7wW4tLuRN/lTJSvLbnNBsXPt
X-Google-Smtp-Source: AGHT+IGQjq6iGTr3cCLjW1gjSUTvMBLV/uQ9uw4tq3JmQvI823Gw3aOTFi6TtMBI1ibTk60eA2yx6A==
X-Received: by 2002:a05:6871:3a22:b0:221:97fa:888b with SMTP id pu34-20020a0568713a2200b0022197fa888bmr4498594oac.45.1710487105819;
        Fri, 15 Mar 2024 00:18:25 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id x17-20020a056a00271100b006e66666de0dsm2696212pfv.199.2024.03.15.00.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 00:18:25 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org
Cc: qiang.zhang1211@gmail.com,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: [PATCH] rcutorture: Use the gp_kthread_dbg operation specified by cur_ops
Date: Fri, 15 Mar 2024 15:17:10 +0800
Message-Id: <20240315071710.8575-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Currently, for different types of rcutorture tests, when dumping
gp_kthread because of slow gp, always invoke show_rcu_gp_kthreads().
this commit therefore changes show_rcu_gp_kthreads() to
cur_ops->gp_kthread_dbg() to dump the correct information in
rcu_torture_writer().

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/rcutorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 51eebc523f08..9d269682256a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1617,7 +1617,8 @@ rcu_torture_writer(void *arg)
 				if (list_empty(&rcu_tortures[i].rtort_free) &&
 				    rcu_access_pointer(rcu_torture_current) != &rcu_tortures[i]) {
 					tracing_off();
-					show_rcu_gp_kthreads();
+					if (cur_ops->gp_kthread_dbg)
+						cur_ops->gp_kthread_dbg();
 					WARN(1, "%s: rtort_pipe_count: %d\n", __func__, rcu_tortures[i].rtort_pipe_count);
 					rcu_ftrace_dump(DUMP_ALL);
 				}
-- 
2.17.1


