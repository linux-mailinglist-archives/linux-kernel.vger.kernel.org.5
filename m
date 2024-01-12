Return-Path: <linux-kernel+bounces-24386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0436082BBDF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F25282D46
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2D25D726;
	Fri, 12 Jan 2024 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhuOaNR0"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B085C90C;
	Fri, 12 Jan 2024 07:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9cdd0a5e6so3696431b3a.3;
        Thu, 11 Jan 2024 23:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705045151; x=1705649951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ltxfqdn8oMs6HiFEgPdU5d3jRUgHJ3wntYFCndBlEL0=;
        b=AhuOaNR0pSJdkFQuwOxyK/b+ALALPGdN+knq/7Nz+ZiLKnzr42VEUvIB6C0wAb+lLQ
         iw+NxI045owqxnRWew7nA9pydu0QuTP6+CDhD9Vj6W3iD2xp50tionHGh5njl1DtCC8Y
         rbWf3aI3OGCpt1PIPLXhW0B2IM+kuqUYcrAzzDB3gnWCVs3S9yvySfWHO0inAAfJGg1D
         TyRN8vHfahW8kcwZUL8wioTzM83ZMsGu+vR1VTFdFFCoxpQSn58QMBsJZi+A1hGlzsyc
         tFcIw1VMBYymTW7YfBZHAw2WAQ/zO63v7CyhXDVUIFKCrj/tb51UMJi9vfqa3odonm+y
         OSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705045151; x=1705649951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ltxfqdn8oMs6HiFEgPdU5d3jRUgHJ3wntYFCndBlEL0=;
        b=PbuAG5MdgrEoyADk99a6m7ZqnaUmM/0N5jocaRUdK0phYPx4yCbs6mkw7MKnNoeBV2
         Eo6pDzv+f2NoqeXPyz/2ewhZCrWMTipjmTDZXfCeMth1jorYv9T0an3ipV/cU1x/+DFK
         sfbalUDROK6Mbb/Q43FL1GYQSVd+PwfKFCy1ZMcIKQUZxC8nOuUDCeo/692axVSyhEuE
         2SasWymN3TGYpi/bGMAR8hbEaRrSNdpYHP9CzBbXGV4lazLMLS5u1s9a0dhyDnUNbvyN
         wa+UDagVNLc6EB7Zc13k71KMtNko+cv6EJJX57EgJWnfQD8WYN9ZAeVR5oJfJS1izERm
         VzyA==
X-Gm-Message-State: AOJu0YyenFN72QPgNBX8R7Mtp7TTGzMtf4HHO9AtZ6HwBVWft6suBIv7
	C+C4TwzBecgkNqIw9EKci9E=
X-Google-Smtp-Source: AGHT+IHHyM4INeewJgDCfByb1wR/DWXGrSMUSzpTM4WgHiY4EFQ9S7QWLIsDnv8bY2tCOBNXv8rW+w==
X-Received: by 2002:aa7:9e52:0:b0:6d9:a0a2:a7c0 with SMTP id z18-20020aa79e52000000b006d9a0a2a7c0mr388151pfq.66.1705045150890;
        Thu, 11 Jan 2024 23:39:10 -0800 (PST)
Received: from g2039B650.. ([106.39.42.152])
        by smtp.gmail.com with ESMTPSA id ka6-20020a056a00938600b006d991505b4csm2565570pfb.76.2024.01.11.23.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 23:39:10 -0800 (PST)
From: Gui-Dong Han <2045gemini@gmail.com>
To: dmitry.torokhov@gmail.com,
	arnd@kernel.org,
	schnelle@linux.ibm.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Gui-Dong Han <2045gemini@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Input: fix atomicity violation in gameport_run_poll_handler
Date: Fri, 12 Jan 2024 15:38:55 +0800
Message-Id: <20240112073855.16594-1-2045gemini@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In gameport_run_poll_handler():
    ...
    if (gameport->poll_cnt)
        mod_timer(&gameport->poll_timer, jiffies + ...));

In gameport_stop_polling():
    spin_lock(&gameport->timer_lock);
    if (!--gameport->poll_cnt)
        del_timer(&gameport->poll_timer);
    spin_unlock(&gameport->timer_lock);

An atomicity violation occurs due to the concurrent execution of
gameport_run_poll_handler() and gameport_stop_polling(). The current check
for gameport->poll_cnt in gameport_run_poll_handler() is not effective
because poll_cnt can be decremented to 0 and del_timer can be called in
gameport_stop_polling() before mod_timer is called in
gameport_run_poll_handler(). This situation leads to the risk of calling
mod_timer for a timer that has already been deleted in
gameport_stop_polling(). Since calling mod_timer on a deleted timer
reactivates it, this atomicity violation could result in the timer being
activated while the poll_cnt value is 0.

This possible bug is found by an experimental static analysis tool
developed by our team, BassCheck[1]. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations. The above
possible bug is reported when our tool analyzes the source code of
Linux 5.17.

To resolve this issue, it is suggested to add a spinlock pair in
gameport_run_poll_handler() to ensure atomicity. With this patch applied,
our tool no longer reports the bug, with the kernel configuration
allyesconfig for x86_64. Due to the absence of the requisite hardware, we
are unable to conduct runtime testing of the patch. Therefore, our
verification is solely based on code logic analysis.

[1] https://sites.google.com/view/basscheck/

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
---
 drivers/input/gameport/gameport.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
index 34f416a3ebcb..12af46d3c059 100644
--- a/drivers/input/gameport/gameport.c
+++ b/drivers/input/gameport/gameport.c
@@ -202,8 +202,13 @@ static void gameport_run_poll_handler(struct timer_list *t)
 	struct gameport *gameport = from_timer(gameport, t, poll_timer);
 
 	gameport->poll_handler(gameport);
+
+	spin_lock(&gameport->timer_lock);
+
 	if (gameport->poll_cnt)
 		mod_timer(&gameport->poll_timer, jiffies + msecs_to_jiffies(gameport->poll_interval));
+
+	spin_unlock(&gameport->timer_lock);
 }
 
 /*
-- 
2.34.1


