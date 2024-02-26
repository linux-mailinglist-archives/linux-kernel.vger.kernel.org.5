Return-Path: <linux-kernel+bounces-80466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2365E8668BD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71FD6B21283
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51E51401B;
	Mon, 26 Feb 2024 03:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI+7F4xq"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4140817;
	Mon, 26 Feb 2024 03:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708917892; cv=none; b=YpCVPh2jwMG15n1rRmXfP0YzRcRuV6XMsKlNb3Ty4U1tVFBpojzdzWnEkZvxRlOEvtfhFUih3fOBGyfdeSXDfldmxyzj1sya2HnrJmELpPHAeN3epHiAzs3gLGa9zJSxK9pj9h7WgFAFeSDhu6MRWmJuYZtGXWhTksGtbNWwyWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708917892; c=relaxed/simple;
	bh=Jp3jqtB6F7xaFyXjnSbJGnMf3tzGvIxIsZ5MZca7QiA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DK1Wg2FLfvShCe0pj6e9DImA/lAfeGQZ67J+m6WKlvazbgBmyVgsfH4Bwt/M28mHjalQTbx1ychFtHyX/TAgKBwlS4NQT9fuws0Xx3EWrlmcSOG1z4ie6TRFmgccTt0B+/VjjRbcUpoucww0u3tPlac31vicAx2HDb9YcEiIKcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TI+7F4xq; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c19937913fso998155b6e.3;
        Sun, 25 Feb 2024 19:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708917890; x=1709522690; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqkuukQYWkULDM9YxCpCSWnr5A2uXAjWxG1aocPkSfI=;
        b=TI+7F4xqAexSSmimJtZ2xBH1IJHhNF6q7OO02VO4JUePzuEZYXH2+eyocPE2+6ttdz
         LUZOd4dWNxqIu43bXpVRnlX529Jh46xHjfSlkhmM9Q15DqJvy6vRFyj8PZiXJkiHhOo8
         EaHWenTcPc+i48XMN+pVOkS6u3e+LOuRMBPnkeM3N15+7UHLo5xaN0+vy6kmt4cY8bYR
         Q+2AdgAU4/WE0tgXRMsAcuRhRAGR/xtQhue4fmtVENoUzzHaK/ULckvfJtbcfJwNAD3O
         81IV/ks03hD3SjOZLyUUpuv0noLv/0O8nKS3fRPjelRE0lN9zLa/X1o7TCjtAP5XgGCN
         UCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708917890; x=1709522690;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqkuukQYWkULDM9YxCpCSWnr5A2uXAjWxG1aocPkSfI=;
        b=sQhczKmTVo9SAz/NLCllmrjR2klvoFRbPbF33JTZv1Mpt52c7eb2TK2pUOedCypxl/
         cri23Fz+e2hBUmtw0Cco/CroaekzU9qQKupy+34Aj9rdT31ehKHWq1ywHi3H78n7illY
         e6OLulBuDPHpyRmg6mWtUefbB0u6DeQxLOiPzB9QrrRcOPCz9cFiJEJ3vKpQmOLH4XYF
         zmckkNvuL6vg6ABYoT+1QPrdj/gnovR+nnwM8C9mLVQ+8gvt55ocu/eU9X83UygAPj0b
         CnAdozVqDSaI6mpdrKlkTe1cWGWsIIBxXOZEVpydBa4iqUqeaw8Tnx8nnJUmWxJ2XnZX
         aVwA==
X-Forwarded-Encrypted: i=1; AJvYcCV6LySvrgCiOfbt09Wevkp6pD9rxg78eurYvDyjxGeDBoud6I9XAMposOBwjGgbzmIvBupZZAX3WXBArK+MdDT48laFDUK2R5n4AJfjihCgTZLRkkbCE6HCo9Z1xCU3c68B
X-Gm-Message-State: AOJu0YwdWTz1bQln5a2KBMH8oDXuYsTX9BnoOdg2eEY5nnVEL1+dpxV/
	20K6fOLJMDnrr4MWeRtPqWf/OJFqRe9AR+CN+UZIay0i1BkWI6aD
X-Google-Smtp-Source: AGHT+IEl9Nr8OFjgMxUxl701ERytHKDwa7TONCAaxBVCpMr1WxwXM0nFILcrKrKt0JH8OCQfmhTjrQ==
X-Received: by 2002:a05:6808:3988:b0:3c1:a1e8:aa56 with SMTP id gq8-20020a056808398800b003c1a1e8aa56mr2486270oib.17.1708917889715;
        Sun, 25 Feb 2024 19:24:49 -0800 (PST)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id x29-20020a056a00189d00b006e50e79f155sm1227787pfh.60.2024.02.25.19.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:24:49 -0800 (PST)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcu-tasks: Fix the comments for tasks_rcu_exit_srcu_stall_timer
Date: Mon, 26 Feb 2024 11:24:39 +0800
Message-Id: <20240226032439.26359-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The synchronize_srcu() has been removed by commit("rcu-tasks: Eliminate
deadlocks involving do_exit() and RCU tasks") in rcu_tasks_postscan.
This commit therefore fix the comments of tasks_rcu_exit_srcu_stall_timer.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 78d74c81cc24..d5319bbe8c98 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -150,7 +150,7 @@ static struct rcu_tasks rt_name =							\
 
 #ifdef CONFIG_TASKS_RCU
 
-/* Report delay in synchronize_srcu() completion in rcu_tasks_postscan(). */
+/* Report delay of scan exiting tasklist in rcu_tasks_postscan(). */
 static void tasks_rcu_exit_srcu_stall(struct timer_list *unused);
 static DEFINE_TIMER(tasks_rcu_exit_srcu_stall_timer, tasks_rcu_exit_srcu_stall);
 #endif
-- 
2.17.1


