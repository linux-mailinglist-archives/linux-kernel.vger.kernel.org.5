Return-Path: <linux-kernel+bounces-43618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DFD8416B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0E21C22DDA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094595475D;
	Mon, 29 Jan 2024 23:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSe+7jeE"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B553E3D;
	Mon, 29 Jan 2024 23:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570718; cv=none; b=PNJc7c1gxWW76Qc6AEVavS/Givu3MgU/yDKe+ZmeJ5KBIiYenYWN7MA+j6qkR7jEM1/BL21KTVp44H7h0N4dsZD8LfDjQv2RN66LeYlalDomVonvUH2KAxQBVwHumieRF/gJR4L2EEVzoflNGHief6jFQKYUbeUAWUZ74nEiqpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570718; c=relaxed/simple;
	bh=eZlXqC8Pmc3GZ3mUzsHXQDXY6PdgTGdVKdE/Qizw9Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbnPSHqYClb1wB6EBkLM3VtD00FagvcViqlyQt/9rEYEo3Dq/ASzaj8pcw7/CGZmc8IfPPbqs/OiJ5YMYh9vwW+w8vVRtFV4WtpmMnFkrShohMS9gfc/8uNrU+2q2wvrR2ZnbktzvIqjTKZDqSygQGTn5imQYGCdkZvtnSh4WVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSe+7jeE; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-783d4b3ad96so372086385a.3;
        Mon, 29 Jan 2024 15:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706570715; x=1707175515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=484fmT+HsG7TJfN7jslHEwU65M6sD6LVJAUCymHVcHI=;
        b=CSe+7jeENMEe5b2YFSDJVbauO/mLVZeSOznA+WEn2JdXKBA7VpSQZPswETj8juRXDQ
         FfcYJbTHrYmB/18s/Bx3iUUv5vqYX09T5fee7z8kMj7Ud24wXy36JiF019ZsBa8RiWGv
         ymVnN7rmdbgIAcrcLgfxATg6RyzjZ2qVwMlEwcpNweXrEOTMuR1lts/DExyC+zk7LP1R
         FxTvHG4ZBXuyaXY4fhLUXPmJVkQxPYL5ZQ96wPDKLR4p0BlESY39Sf0sBoaSpT/1MOGk
         XURu/vwYHXdlRy+gzY9m4rK5Eto8ttoLqZC/tBUo4dJJU/oNA1GicfjBc242ssdcdwCL
         T+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706570715; x=1707175515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=484fmT+HsG7TJfN7jslHEwU65M6sD6LVJAUCymHVcHI=;
        b=ZW8YLSOCHubMGHmOZTAqoHmQTTypqzJJ2GwpWmy2IbOvmuf1r4xW5PazoDg51CxEDn
         1XFb4oXi8Nc+Fp8GkwaDLXxeeidX9ikbP3vopetjp56lF8qiPGLun4mqxqPIr7Ar71w7
         ertcWCWXPcKU1mHP4xwMuPUjgFjbdl/HLV79i152zw8zTbzvMZEPQVoeZ2V5eSfGan3i
         fHCemYLJ++qD5CHh7TCz9gzN97/Oc/B+NFT5esGB03hFpHzyf7FHWESwW7bjiDLk/MK8
         bODCVnw1QEH0bLC0wTk4GBUufJ3hVyk9ub7fS81FdGCbRcvXGO4pvtf+twXkjRgTS+WK
         H7BA==
X-Gm-Message-State: AOJu0Yzy4jd9mrI9iWTdifvpW7OVztTqtMkxxyXpenb6WuPaDLm1seEh
	H9OIYQYxVoo3rkXmYvUrxZFP7VEbuxJ8LyV9FD/LZvhAE0MhIbZPO2xA22Zv
X-Google-Smtp-Source: AGHT+IE93z/pBgWHHsHxt95PwtqEuVFvDQWXYjf0t/+6Vj6mLH+0pnTruRl/BqesSMY3+GZ/ACvP3A==
X-Received: by 2002:a05:6214:224a:b0:681:89ec:9789 with SMTP id c10-20020a056214224a00b0068189ec9789mr8331362qvc.128.1706570715556;
        Mon, 29 Jan 2024 15:25:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWiKNk8/QJ1PGp5IApQf889EtnO9JFn9AofGp8GuY7aOQfvGrkNd6LbzyOs9VeRaX6V7Tj3PLqukLKDwi3dm7q3HhI2n99XGUkMteBxgTynntJBvxwSBhMEuaghOXIGQTFuFlFPft13goTQ4MaD1KwqxYzxc5GTgHBKaiUW+FRfrlZDZgVDksf4UACuBrrE1ypvyC5uLOORt8UZXcUKVO1bOoMC7mOTBJLkM7WjQ7+jm0n946NsOz40PnGv/XW7Vok/sVqqyegFdDIDHeOy7koqiP1usKxxDJtSMCQXUfW17duTqPeTG2trpJRyTKWMXfaSDTX8RaxSo9o6ceKmVvSj7EQljjCFxA5sPqnJ0QlZFUx/X8RN2d1bcWENgQOvDPFfR0z2eVO4LwOeh9RRlr2vLb34QGc=
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id ph15-20020a0562144a4f00b0068c50dec857sm1181786qvb.128.2024.01.29.15.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 15:25:15 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id C68601200066;
	Mon, 29 Jan 2024 18:25:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 29 Jan 2024 18:25:14 -0500
X-ME-Sender: <xms:2TO4ZWlBlHhszjMhfkdeLOTp6bWEPNcNpzBgUFaT0wbnMF6EabRuXQ>
    <xme:2TO4Zd1LpiwcZv02IVMEWi8gJCWldJw3kbhNI9iVxf7IpN68FCmWz_WLsAGoFIQlW
    ru1df1HSndiOJTHOQ>
X-ME-Received: <xmr:2TO4ZUozE_gYLbVGeq8V228wRY5-PahANsWmafO6UFPN1u6E2YmDkf2ysQG15g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:2TO4Zam-XJlPUKrjdH8OAWY4I-S6IKg1gmH86g2KBzUBuGJUjZ35ZA>
    <xmx:2TO4ZU3I2C2URSjosec1fVfyyWxByz-4P0plqNze9-iH8fcmFYz06A>
    <xmx:2TO4ZRsTJTdqfIrSIww63cTpg-wtusD6Q9OmofxtNaczYbmBYJNadg>
    <xmx:2jO4ZaOBjgvrCvb0D2vY-H1RI4GT0ELcUDQClgPwJqbaKNz6YTbVKHBLUTY>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 18:25:13 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH 2/8] rcu/exp: Fix RCU expedited parallel grace period kworker allocation failure recovery
Date: Mon, 29 Jan 2024 15:23:40 -0800
Message-ID: <20240129232349.3170819-3-boqun.feng@gmail.com>
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

Under CONFIG_RCU_EXP_KTHREAD=y, the nodes initialization for expedited
grace periods is queued to a kworker. However if the allocation of that
kworker failed, the nodes initialization is performed synchronously by
the caller instead.

Now the check for kworker initialization failure relies on the kworker
pointer to be NULL while its value might actually encapsulate an
allocation failure error.

Make sure to handle this case.

Reviewed-by: Kalesh Singh <kaleshsingh@google.com>
Fixes: 9621fbee44df ("rcu: Move expedited grace period (GP) work to RT kthread_worker")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b2bccfd37c38..38c86f2c040b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4749,6 +4749,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
 	rcu_exp_par_gp_kworker = kthread_create_worker(0, par_gp_kworker_name);
 	if (IS_ERR_OR_NULL(rcu_exp_par_gp_kworker)) {
 		pr_err("Failed to create %s!\n", par_gp_kworker_name);
+		rcu_exp_par_gp_kworker = NULL;
 		kthread_destroy_worker(rcu_exp_gp_kworker);
 		return;
 	}
-- 
2.43.0


