Return-Path: <linux-kernel+bounces-157111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE778B0CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECBA1C2489B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E406E142E7C;
	Wed, 24 Apr 2024 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyeKT629"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AFB15ECCE;
	Wed, 24 Apr 2024 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969902; cv=none; b=G+vwYtQw0P3pNdwBISJFTt3wDUQp/uZKIikV+6COby94bnZt5DBJNRZ1tiF52hUhQU0Tdq4GRh5HWaMrX9AlzzK9ZGEfalQAvrwofCKeezL9JB7vMTRqf/VYC/I+FVv3uhJET4pqxZvyAu6djWqY4Iw48sEmE12y7nry9Ql9zcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969902; c=relaxed/simple;
	bh=Hq/a7l+FanlA0Ntrju77wI3YLmKhqPs7hJ/bcC9K6K0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oeyOC2IFRRqYnZCk5+ovVeWvTVaDfbtyw2RkI8IRF1bYwLZn+4Kwu419Mh9rweigbHK42VfzK1hKXaGJHDYR5Tmrao0kha75FJYVpzXgfPsIzV+uougodSeZgrKVDHYf6DizynK8iACNEHOKfJIdKF3+pWScsuL5YqIqJNaZ31o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyeKT629; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso737159b3a.1;
        Wed, 24 Apr 2024 07:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713969900; x=1714574700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MfksbOufaT50njTeYfjnrKEJiBfYKS364Z1TYz8n/g=;
        b=XyeKT629afrsryzzJ2Y/mJqJD2r7IUf6Jcly3zneN2QfPIkMHT7M9sbChO9C/7PV/t
         yW4A6NNkRJ70CqqgA/Wz/IJJaAVRQoyvQ3UsX0lW33rTfrDr4X/4YulBg1/tR5XMRS3S
         IF+/sMcTklZUeyvWxtJgxWcY9Y4aW/kf+lJ54tdYt+AYvzwZZmEZqu9wooGrUDJ2ttmg
         VQLW+/td9zqfVnqhfoD6+G+7/F/7KtmvyNLJnla06yh4Nv/gCV5NawkRG2sHSi5EVs+z
         jdD1GYfIwvzgWj3477Tht/RNjRoMHhTXR2tsutlgkAoHBDDWtnRO1owqcsdGiPOuR1Lp
         qm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969900; x=1714574700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MfksbOufaT50njTeYfjnrKEJiBfYKS364Z1TYz8n/g=;
        b=m7OVWkHAtdaZ2PcTnou9JgQEKIkVSu46JTB9gDMBHH9QFK1IDVJ91gADnpelDS3cFJ
         HYz6++cDrETrLO5C67Gusp7JQkCwUpScGBcjJvRXLLAddZcGNzZEW5Zyk/pLyao5aGVV
         onDsbgd+sloSIcO5sZz7VZfzlMksLtctHIa5mAqLFPNPJSdeo+ZCeKDMBYyy4hott3Gm
         IfgAUJxWnlxAwhoAqvBkHVJZJFTZVNcsjf91iAUx//d495FEmNhy83CM9gIo4E+hMPIn
         uZB73HciR/6qIMUKo4r1gQ/UfzICItUqmDJHU/w/qGPATu1h4dN+0h9tQwtwEO9pWQxp
         VwKA==
X-Forwarded-Encrypted: i=1; AJvYcCUrL2820mlInjf4s9NVkptIH0ti4CtnQ4toq/udKAk6GI+mmbeNRcfx+TzNh8yE941ZxA2kdeCQB2h2XTeVIGCX3yOLmlDwJ4DNdbBpfm+DdJKJTco91399vTo/G9XfZEtZeehkZxJBJ7ha9j7ex5ryd+JlDhJkaL7WAkkZXgLHnOiINrggZKGc8PUKUmE+HqWDc8+k5DVXshFwd8A=
X-Gm-Message-State: AOJu0YzTtCylHx43D9XH9IpTsp+3F5ThXw/iU4k/pFriklAXIMiU/1Rv
	F4SJWQniB1MlourOSbmV8TQa/jFNY0HLQI3FyY28NljsWS0dorZk
X-Google-Smtp-Source: AGHT+IE0vvv8401MvcZvFuTAKSMkOxij157Cp6pNYN59rTcTx6IrZpNRkSO5z4E6xJDmFbIVwPhxCA==
X-Received: by 2002:a05:6a21:6d96:b0:1a9:509c:eba6 with SMTP id wl22-20020a056a216d9600b001a9509ceba6mr4486348pzb.25.1713969900053;
        Wed, 24 Apr 2024 07:45:00 -0700 (PDT)
Received: from [127.0.1.1] ([2001:ee0:50f5:5d0:6ca6:7f20:5242:67cc])
        by smtp.googlemail.com with ESMTPSA id a5-20020aa78e85000000b006e554afa254sm11495743pfr.38.2024.04.24.07.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:44:59 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
Date: Wed, 24 Apr 2024 21:44:19 +0700
Subject: [PATCH v2 2/6] bna: ensure the copied buf is NUL terminated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-fix-oob-read-v2-2-f1f1b53a10f4@gmail.com>
References: <20240424-fix-oob-read-v2-0-f1f1b53a10f4@gmail.com>
In-Reply-To: <20240424-fix-oob-read-v2-0-f1f1b53a10f4@gmail.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>, 
 Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>, 
 GR-Linux-NIC-Dev@marvell.com, Anil Gurumurthy <anil.gurumurthy@qlogic.com>, 
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Fabian Frederick <fabf@skynet.be>, Saurav Kashyap <skashyap@marvell.com>, 
 GR-QLogic-Storage-Upstream@marvell.com, 
 Nilesh Javali <nilesh.javali@cavium.com>, Arun Easi <arun.easi@cavium.com>, 
 Manish Rangankar <manish.rangankar@cavium.com>, 
 Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Sunil Goutham <sgoutham@marvell.com>, 
 Linu Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
 Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Saurav Kashyap <saurav.kashyap@cavium.com>, linux-s390@vger.kernel.org, 
 Jens Axboe <axboe@kernel.dk>, Bui Quang Minh <minhquangbui99@gmail.com>
X-Mailer: b4 0.13.0

Currently, we allocate a nbytes-sized kernel buffer and copy nbytes from
userspace to that buffer. Later, we use sscanf on this buffer but we don't
ensure that the string is terminated inside the buffer, this can lead to
OOB read when using sscanf. Fix this issue by using memdup_user_nul
instead of memdup_user.

Fixes: 7afc5dbde091 ("bna: Add debugfs interface.")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
index 7246e13dd559..97291bfbeea5 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
@@ -312,7 +312,7 @@ bnad_debugfs_write_regrd(struct file *file, const char __user *buf,
 	void *kern_buf;
 
 	/* Copy the user space buf */
-	kern_buf = memdup_user(buf, nbytes);
+	kern_buf = memdup_user_nul(buf, nbytes);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
@@ -372,7 +372,7 @@ bnad_debugfs_write_regwr(struct file *file, const char __user *buf,
 	void *kern_buf;
 
 	/* Copy the user space buf */
-	kern_buf = memdup_user(buf, nbytes);
+	kern_buf = memdup_user_nul(buf, nbytes);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 

-- 
2.34.1


