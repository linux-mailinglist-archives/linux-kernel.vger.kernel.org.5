Return-Path: <linux-kernel+bounces-157110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0828B0CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6F128A380
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE5E15F303;
	Wed, 24 Apr 2024 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHj7KEer"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9B815ECCE;
	Wed, 24 Apr 2024 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969892; cv=none; b=Dj9cLToW1rr78YovFKHu05TXFVB3NDSPlQUCywALCiydzE6Nl2XjUOJM3G0EQQ4Mj+4ov1UJA2OM3ttUqemFUJi0Uw/d/Rc9r26gCxor7ce/uES6ZlUm2a5ymZE1DLYqZKjYSy8y5szgPIdOMg5fiD6XBCUXngIojlutz0VQlFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969892; c=relaxed/simple;
	bh=i9yBjXKi50Q2frU9aGfX8QLUJWrV8BgeZoBMUnJSQFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TsLw17PpoLQV9RHL7EmBd7qd3dyS0Tois7DFX9s4mXp0wjfX1R5JuO6NHRZAN8kprGqPDtqyFWKurbFCUiknEhjGcA5/CaXShF4WKt/S3A1dSgLnjfBOqo2QMk9FxwOvczmWPnTWulvKWzqEa47gEYEBl2GXsLc2ZKbQCYXjUdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHj7KEer; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed20fb620fso5886151b3a.2;
        Wed, 24 Apr 2024 07:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713969891; x=1714574691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qdUgcHPztLd0lwxO193DGh85zNO3Tk4LAWPrMFFJ1g=;
        b=AHj7KEersSon9L6ytA3vVcUM2hhl4sdvxa/guuwbcH4cNlxiudf+Kvwd8dhBuyybxh
         xzdEYeeDO9c9Mfv2hphVa8leLtpa0v9GXdXR78wruX4FZ4QIDCACJudebGcyzvT+4J4f
         rvGMPv9ffsa78wofp9sqlk02gdFeTIWKDGbOVyqC77jShQjBG2hdpTW7Fi0X5MbfQUQz
         M0C/4YjzjujRTuooMtTANrelmGE+HHLtMt54oUkEqNCj434NCSkZWY9LfOD5jHTtdC9m
         FPp6dzz7/OErkXgn8zDLEIXlRs0g9mgr29Wt9oK/heI+L50ovx8N226HATVknaKiK826
         KAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969891; x=1714574691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qdUgcHPztLd0lwxO193DGh85zNO3Tk4LAWPrMFFJ1g=;
        b=NgL+j3NdTUrZdq21jYYCgs1PN3EFKE5hHMf4UO5/R7L/ZXsR5M+2Ysv205qvdAoH9W
         6fV0V3qQxRmnD2Q9QrhpUBPq/wZQIYQTuCDwuUB0BmHetGxd43ftcCR77de4GQmI58IZ
         +If2YGM4YbR1hOEzc9kUJlk7xLIRff+rgoPBFP20nISOaCCGlKo8ZMFbazOXAjVxmAvj
         7TQDl2F2aOcZpYJYpMaZ7tOqULHAd7RMPZAS91rDKV1zOc77wobWzpFuhfI3DBul8khm
         b9BKOX4tN/5h9QJOYQsE5zTJYTPHEEF/rjvvbTS0jgzKIJS/Q1Zpsa72GB1l/UNgQKmD
         8t6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV51FhoSKzekkiGoiGuuNrFkv2SF4QdGci+bVAcM4ZdoFbqQbaShCRC4oEMEmB1MjzyY8b4qV7M61vhWxoAftSGyqeiP54RRICuFybVLcxkWqJUYuWq8G98chSBVmp8cPpz/+aK6ntbkpbblS8iRflvXcyAoiNsBTSRbgHdqe7Ououzzbzdb1xeX5lhJsWmtgXTD1MM15zLBf+Ayu8=
X-Gm-Message-State: AOJu0YwHEzgHryVvMvUmFEQho1z5vPL6PC7xVEmMFBA/rC7g9sfIqaQr
	ABhNDgAw56mQ4YR7/ApmDKzrIPBv2cMIuM2+gbV7TBXDQv6MEsgmBsmXqnAa
X-Google-Smtp-Source: AGHT+IFJ/y+DruBf2Lm1UhtzVWoEV8AN6SFg6+AIBmZtn4lSLmIs4uj6gpgqse0hCeEeacgja8d0pw==
X-Received: by 2002:a62:ab0f:0:b0:6ed:416d:e9a with SMTP id p15-20020a62ab0f000000b006ed416d0e9amr2762304pff.7.1713969890708;
        Wed, 24 Apr 2024 07:44:50 -0700 (PDT)
Received: from [127.0.1.1] ([2001:ee0:50f5:5d0:6ca6:7f20:5242:67cc])
        by smtp.googlemail.com with ESMTPSA id a5-20020aa78e85000000b006e554afa254sm11495743pfr.38.2024.04.24.07.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:44:50 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
Date: Wed, 24 Apr 2024 21:44:18 +0700
Subject: [PATCH v2 1/6] ice: ensure the copied buf is NUL terminated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-fix-oob-read-v2-1-f1f1b53a10f4@gmail.com>
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
 Jens Axboe <axboe@kernel.dk>, Bui Quang Minh <minhquangbui99@gmail.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.13.0

Currently, we allocate a count-sized kernel buffer and copy count bytes
from userspace to that buffer. Later, we use sscanf on this buffer but we
don't ensure that the string is terminated inside the buffer, this can lead
to OOB read when using sscanf. Fix this issue by using memdup_user_nul
instead of memdup_user.

Fixes: 96a9a9341cda ("ice: configure FW logging")
Fixes: 73671c3162c8 ("ice: enable FW logging")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_debugfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index d252d98218d0..9fc0fd95a13d 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -171,7 +171,7 @@ ice_debugfs_module_write(struct file *filp, const char __user *buf,
 	if (*ppos != 0 || count > 8)
 		return -EINVAL;
 
-	cmd_buf = memdup_user(buf, count);
+	cmd_buf = memdup_user_nul(buf, count);
 	if (IS_ERR(cmd_buf))
 		return PTR_ERR(cmd_buf);
 
@@ -257,7 +257,7 @@ ice_debugfs_nr_messages_write(struct file *filp, const char __user *buf,
 	if (*ppos != 0 || count > 4)
 		return -EINVAL;
 
-	cmd_buf = memdup_user(buf, count);
+	cmd_buf = memdup_user_nul(buf, count);
 	if (IS_ERR(cmd_buf))
 		return PTR_ERR(cmd_buf);
 
@@ -332,7 +332,7 @@ ice_debugfs_enable_write(struct file *filp, const char __user *buf,
 	if (*ppos != 0 || count > 2)
 		return -EINVAL;
 
-	cmd_buf = memdup_user(buf, count);
+	cmd_buf = memdup_user_nul(buf, count);
 	if (IS_ERR(cmd_buf))
 		return PTR_ERR(cmd_buf);
 
@@ -428,7 +428,7 @@ ice_debugfs_log_size_write(struct file *filp, const char __user *buf,
 	if (*ppos != 0 || count > 5)
 		return -EINVAL;
 
-	cmd_buf = memdup_user(buf, count);
+	cmd_buf = memdup_user_nul(buf, count);
 	if (IS_ERR(cmd_buf))
 		return PTR_ERR(cmd_buf);
 

-- 
2.34.1


