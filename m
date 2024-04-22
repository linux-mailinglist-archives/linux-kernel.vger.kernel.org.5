Return-Path: <linux-kernel+bounces-153737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE67B8AD286
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425701F216C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965581552E9;
	Mon, 22 Apr 2024 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyc6frkA"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8498B154C0F;
	Mon, 22 Apr 2024 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804150; cv=none; b=JASRdSaezEc5mwbqzHOQ4yRj+cbAOewh0IO1zZoiMUi00x/8sKLqox6fcYqkvSsqpu511VvG8kyO9iv9cQuW9Qsc0OsNrjTjJDpNCqZjnyiog1pXqFZdLPRsT5/cIkYvzF0OUr0iaQJsF0ctAkqffGdk38JR3Wp8xlcmA8Mgv10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804150; c=relaxed/simple;
	bh=Hq/a7l+FanlA0Ntrju77wI3YLmKhqPs7hJ/bcC9K6K0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XscKLBjZ7aUbCocG+5Ao3/gTJ3JKGZpHU4xPtSy2JdSfF2L4WnMaq4XImYaBwIyVw71QQfRmI+K/uFuSBjn+NUWyxzpM7Hrp1jc8w7NVKQ/1BvOlaSKuU0fV8qUyHc6XEUr5gfzRzPdr4UthcnEZN89LOJ4DcSUGFPevMd4E2J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyc6frkA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e40042c13eso33853335ad.2;
        Mon, 22 Apr 2024 09:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713804149; x=1714408949; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MfksbOufaT50njTeYfjnrKEJiBfYKS364Z1TYz8n/g=;
        b=fyc6frkAVFV26+kipa7mAtrB9McntEcFIbHjgl3WzG24lQIgwbaZsh2NOwtluZ4Wyz
         y4c67x/xldMBtJSHD6K6jbf57DXErps45S/QdaTkO0G5mWHtVgojAcQGTmf46eGflgD8
         xck/tW5mK5cvECdKgnKvwwNpOSBOWBrKR3bVtgDyf8QXHjkYZ48iF/XKrXgJ8gcOyOxF
         rDig/UJrwH0MB9AgfCgWVnvzIuT+gfavKLLRvQJk/9eTAPVzSWyb4pVN3CuFY/p7hazG
         P4uk1VC5TEgpYv3P/HNw6x/iydlUiqgdt00CLxRGnjleo5bC5KJeym+j/dj/PzuxJca2
         orzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713804149; x=1714408949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MfksbOufaT50njTeYfjnrKEJiBfYKS364Z1TYz8n/g=;
        b=ViIuan3/wPtP30c70YuijCi6FfcZhypDfKlGpTQ7bklu9pJdqCwIbcYpJa1a8XIl89
         JRBwU45ycyZzXJCbxwY0IIiTOfnWUNUP5wV4aRl1B3dZ8ZyrohVymFmne3SGddt8BwnB
         iV+LqtQdx/sebyRbuTEsA1kHa3awx9aV6jWdV3opAGNf1BPiKhTrw/jFDFcgWPr7GaDV
         mQoJydql5gTdpEi71bHS77AqWxaTB/Z+2pmjJMvkQkL77B4ls/eGeVTzpQPpD54iE5VJ
         Fs6vwNbT255WKBWrJwQ6LkQxGNwjOB9FqWgsPcNNzXvyA78c1WIp3SYXyFfYXPVyUVwH
         ABrw==
X-Forwarded-Encrypted: i=1; AJvYcCXGh+6lAM8WAdAua+oUvgCJ81GEkEgtZvpctrRpwLU14EFMmGNgw2Ru3cLtId3DChPW2Odduwn2dhVK9F5sRDsu57IjheSJc/ze+qMA/2CG91gLUGAB4u/04tIyuhATDT7uIlttrGNxrc3MSpu50K6b7UN3RHo1Y1MKGz/cjr+GUTTtnsv5UNHUKWmuKSXsmIJYOEvj60Ecssufbd0=
X-Gm-Message-State: AOJu0Yy9ZPtR5KDgsS6vBonH9s0wdP/0o8/1D//XMeDEZqtLzdM6kaWM
	NT43xUDz7GN09adeYY9jTvavi5VCLXm6GD1UyF/gTugrHSAqyhGo
X-Google-Smtp-Source: AGHT+IEZjvXoEzE/pLr5/NyZgZYKfFkXXVzG2RM6VjSf62Suz057xfGfAYyCLpKwX4NqzGd5KB79lQ==
X-Received: by 2002:a17:902:d88d:b0:1e2:a40d:b742 with SMTP id b13-20020a170902d88d00b001e2a40db742mr8782691plz.56.1713804148793;
        Mon, 22 Apr 2024 09:42:28 -0700 (PDT)
Received: from [127.0.1.1] ([2001:ee0:50f5:5d0:f32d:f608:a763:3732])
        by smtp.googlemail.com with ESMTPSA id p3-20020a170902780300b001e7b8c21ebesm8461702pll.225.2024.04.22.09.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:42:28 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
Date: Mon, 22 Apr 2024 23:41:37 +0700
Subject: [PATCH 2/5] drivers/net/brocade-bnad: ensure the copied buf is
 NULL terminated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-fix-oob-read-v1-2-e02854c30174@gmail.com>
References: <20240422-fix-oob-read-v1-0-e02854c30174@gmail.com>
In-Reply-To: <20240422-fix-oob-read-v1-0-e02854c30174@gmail.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>, 
 Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>, 
 GR-Linux-NIC-Dev@marvell.com, Krishna Gudipati <kgudipat@brocade.com>, 
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>, 
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Fabian Frederick <fabf@skynet.be>, Saurav Kashyap <skashyap@marvell.com>, 
 Javed Hasan <jhasan@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com, 
 Nilesh Javali <nilesh.javali@cavium.com>, Arun Easi <arun.easi@cavium.com>, 
 Manish Rangankar <manish.rangankar@cavium.com>, 
 Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>
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


