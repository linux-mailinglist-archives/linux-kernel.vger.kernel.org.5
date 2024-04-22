Return-Path: <linux-kernel+bounces-153736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 711F98AD282
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD60289A30
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1298D1553A0;
	Mon, 22 Apr 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPnghK4U"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C2B153BF7;
	Mon, 22 Apr 2024 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804142; cv=none; b=QM/l1bt7gyyUu+AcF8G9X4QKDvQyXdec3jANiPAykV4VETiW/96PQ+CDJGXnhVgeTaSoqVausOUslBGdvvordmWug0STIt2H4PepyUjWUBUCnDhO0mvMi8+569QErjwhaRCASNL8NvKnZb0wa2cImDNzjT/HX0aRUjrTDR4xD9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804142; c=relaxed/simple;
	bh=3bNaODrHrc9k0PUGRaeY+O8wNFHaMXtzuZ+w6Oy9dK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YFpaZ2nW8JbwPmoN7wfbruI+7GwYuw5wbf2xDa0zoc98bN00+QnJE37yaSovQPHTPwss1JH9pqb5kDJUnsYo8+7NX85lHejNWT2hclPNb7PY+0YYlttoCRtpOcNsidLbO/fKEvt/D6cNAC6T6fvgQLcAG1uCWmz8ukUh99OsLPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPnghK4U; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e5aa82d1f6so34485805ad.0;
        Mon, 22 Apr 2024 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713804140; x=1714408940; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eL4ffxjrw/Oouw+LwAu0XgJYOaiP8blt+5qz96VZZiY=;
        b=fPnghK4U77U2OI930aSZwBUYBEXg6ilQnrbdNYsXnrw9zZg3sZJHakHhANDj5hoqw5
         1H1Yti6Qf2iJekifTDBA22K5XGE8pUWliXEzPWeIiN4dI2XXBmQmWH3Ym0Lgf5cDPbkz
         FqLL7cW5rN+3dLG/rGn5wOe/Xf21HZqARECH8OnbLmeMNsihYzpCHgHxIgRvwlvooccI
         bfPaVzlUxrEeT33avoTbSrEJkDnPoflRxxedeCx4os6oX4n5XlvuPlnCJVNbESumUpGW
         4tP6f0ncI7G+WI1gjXdLinPD/xzgevZJumuN9B/UHXKVDnKYKTwjKZsXYIoI3wFRd27u
         aGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713804140; x=1714408940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eL4ffxjrw/Oouw+LwAu0XgJYOaiP8blt+5qz96VZZiY=;
        b=KrQbYvicrFMJ8XBcXhA8oX9CzjsjUzOtQUt391GtkNqUf0X+olz+381qL1tSQQIAsJ
         4SJXmMGeqso48bhzyC9cXr2qCBgvkl6yZsthdpaEo1aql+GyDD1FqCVL/haTWVgIjhzz
         o4u98yIY43a1b73vRdu2434DzKzvhpDlzYwZpnpOIpzrVzp16oeZICqUWTyj8ou0FEyB
         Tq5C1d/k2tlm5+iMwGk4w0FeDuZUJ1MTsniSre42qMHbLqS69eqP294xEZnc+ARgt+6p
         WrigXw8Nxgb0k62NJEoylc/ZCWqkIXB3pz4QklL2eBQclY6j12r9Bm7m8qklfMIJIHmF
         XFjA==
X-Forwarded-Encrypted: i=1; AJvYcCW5KH5nrReTa/ytxpHCWMaDrasL26cjUH0kqc5R64EvjIdOF5eGVZV/uAPU3TrXHW/ia2khXaZdmOHDE3JJuj/B4BbZGwvZl2b9i9WPGlIf5V3cd9bUNCa/TNbfH6wmPQu0InyyWbRXgTJNV6xIodFfdD08ZMD5bx6mgGo0lr+BQmuf2rhoiExyrfpCeSChEDpAjTis7C9eAWdgxgQ=
X-Gm-Message-State: AOJu0YxizeMJzFjBFJVPVvhUDYBe6iiLmpLehLhXKiQwZkrtS5dHUE1E
	ZI8rLvpsHAkZJ6AVMwk33wWYEbb2F9QLKUOKB5p1Kr9ZoHVPWHCOan0119bF
X-Google-Smtp-Source: AGHT+IEE3zCzjNrxH/2KcNM7PIDosav5wc2WckggravkOccoGJpeEQnzKLmEsUt2/yyWlk73nUulDg==
X-Received: by 2002:a17:903:1ce:b0:1e2:abc5:e28b with SMTP id e14-20020a17090301ce00b001e2abc5e28bmr216891plh.19.1713804140098;
        Mon, 22 Apr 2024 09:42:20 -0700 (PDT)
Received: from [127.0.1.1] ([2001:ee0:50f5:5d0:f32d:f608:a763:3732])
        by smtp.googlemail.com with ESMTPSA id p3-20020a170902780300b001e7b8c21ebesm8461702pll.225.2024.04.22.09.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:42:19 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
Date: Mon, 22 Apr 2024 23:41:36 +0700
Subject: [PATCH 1/5] drivers/net/ethernet/intel-ice: ensure the copied buf
 is NULL terminated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-fix-oob-read-v1-1-e02854c30174@gmail.com>
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

Currently, we allocate a count-sized kernel buffer and copy count bytes
from userspace to that buffer. Later, we use sscanf on this buffer but we
don't ensure that the string is terminated inside the buffer, this can lead
to OOB read when using sscanf. Fix this issue by using memdup_user_nul
instead of memdup_user.

Fixes: 96a9a9341cda ("ice: configure FW logging")
Fixes: 73671c3162c8 ("ice: enable FW logging")
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


