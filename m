Return-Path: <linux-kernel+bounces-153738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3588AD28A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0748028A3ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474A7156226;
	Mon, 22 Apr 2024 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPaby7jt"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC621552FC;
	Mon, 22 Apr 2024 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804159; cv=none; b=JggUPqRgYDWSuCSCm1nJrPopRV0MTQxLxUkraqssGV6MwMp0o52PcqP+wNR7oV/1LbtYqDlwji6W8OWPAwqzkYUj0Q9xtFuuZdRxs1hI+jm2k7UmWNgBWL1rIQBFX5kxLpQphlLcUfNgUgTl08TGa9ETS3aXJnnjC1qGaylL600=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804159; c=relaxed/simple;
	bh=5qTfVU19Uhv7IKSJxI/EImm9oveNfOjQF+DaIPmQs6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rD5Ou9Wp5wpd2kf7IaQSvmtCWVPCIJ4m+L0RPuIPTqnPcsnp5+01FMaBWEs7vx4lD+1mzOCX0E9xa/hy2XZ+VEU/60qU4j/NI4NzxaqnBRmfRZ1OYIa+oS5H1D8obY0rxbCHlrVlB2dHOZpxxtIgzn4gXCmAz7BOAzSatlzSpQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPaby7jt; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e411e339b8so35388575ad.3;
        Mon, 22 Apr 2024 09:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713804157; x=1714408957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDVH41VbP2tcWCidq0GxDLy5uHVpzfSuy3cESbFhDE4=;
        b=FPaby7jt5wUMSXvThg0iPvpS+rMTOzWMXPlywr1aU91GZXulD2wpPJ33J5YvO/0QYz
         gLOOeQDitbqx23Jm6Tl2Y+/3Gk4LqvK3eHh4NITVYSEsFlvxLfb/bFYyDPRE90rj0ajr
         LRnd+ateUCyEUSIqtrHOiue6MkBP9x0h39Iota6BDrfwKcz13Gaypg2acyUpbbdl0/Hp
         YxPv9oZn2NzEZgydNGBUrb60l6WPdnLFU5xIMOxde53V5azCxTtdzaXKDYKKZTLM7O2B
         QfHdI8lSLbo7MrcRUGUsh1tOs07U4Mbwsj4M5YLbtj4VJwF3eyMjZLfetVaUJso4x/bj
         0xDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713804157; x=1714408957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDVH41VbP2tcWCidq0GxDLy5uHVpzfSuy3cESbFhDE4=;
        b=W/wPL5d0j+p+E4AbuRgsK1tX7b2zTs5QQmpScpbD8cqXM0dZ7b8fdG3eq1sUKHiE6H
         R60sYXSyjGy3byO/Fql44+5NsO5Ey5Cc1t1/9TK5lt9sA00FEFk+zmEv+gWkQ827oFNH
         XrtRP4xOo2e5TPlraRp75cRlYsWMh8aXAH0HoWNBLWDjR6eMX8v4Pbgp+Un/KNYBsJ+d
         kbAJOMThYvcp+vVSnwS4Oezf3MI0OdY7MODMVzrhoJ7NJ0qXd7sEu1V1U6TwYA5xv0uF
         LJYu/8eUazGDqTEoT5mPCN1m6Jj7eE1WjK+mhQSC0nlivGyee8QjpH7gfefs0rMvet0M
         RzrA==
X-Forwarded-Encrypted: i=1; AJvYcCU5YTLzX5JIcSnhOi287u4w5rtcL8tc+Qy9VyJdeSJ6c/jpPpxxsrZTOHS5Pr5MzcgLH2eMU4TfTUom0gDjdDTWn5lLfrVMjCU40hbsxSg4KlghU0VLfqYpbCW8X9i00ApyOkCkhmVbXO4cJ1JySR7HArI+QiL5xQULDbuo+ub5DinZQ4g8NDQjiMBxy2fL/yD73qXHd7DkVIUCbUE=
X-Gm-Message-State: AOJu0YzJJH/a4oaUVngSC5bXqi20SoqcnPDYgmtdMuY7TXgMR0Eb4zV0
	nGYVZCiOVMP+xL49u9gjhhHyqOKjrnvYGkj+nI/5aDeIMwVWocuX
X-Google-Smtp-Source: AGHT+IGFR0UrE8vlHS9G1xyCFL9Kk8tc6zrtPIBXdEQTIZOCIFTVAjgPZfeNjdeZQpipcvC3xcdlSQ==
X-Received: by 2002:a17:903:584:b0:1e5:d083:c5b3 with SMTP id jv4-20020a170903058400b001e5d083c5b3mr11983186plb.5.1713804157395;
        Mon, 22 Apr 2024 09:42:37 -0700 (PDT)
Received: from [127.0.1.1] ([2001:ee0:50f5:5d0:f32d:f608:a763:3732])
        by smtp.googlemail.com with ESMTPSA id p3-20020a170902780300b001e7b8c21ebesm8461702pll.225.2024.04.22.09.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:42:37 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
Date: Mon, 22 Apr 2024 23:41:38 +0700
Subject: [PATCH 3/5] drivers/scsi/bfa/bfad: ensure the copied buf is NULL
 terminated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-fix-oob-read-v1-3-e02854c30174@gmail.com>
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

Fixes: 9f30b674759b ("bfa: replace 2 kzalloc/copy_from_user by memdup_user")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/scsi/bfa/bfad_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/bfa/bfad_debugfs.c b/drivers/scsi/bfa/bfad_debugfs.c
index 52db147d9979..f6dd077d47c9 100644
--- a/drivers/scsi/bfa/bfad_debugfs.c
+++ b/drivers/scsi/bfa/bfad_debugfs.c
@@ -250,7 +250,7 @@ bfad_debugfs_write_regrd(struct file *file, const char __user *buf,
 	unsigned long flags;
 	void *kern_buf;
 
-	kern_buf = memdup_user(buf, nbytes);
+	kern_buf = memdup_user_nul(buf, nbytes);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
@@ -317,7 +317,7 @@ bfad_debugfs_write_regwr(struct file *file, const char __user *buf,
 	unsigned long flags;
 	void *kern_buf;
 
-	kern_buf = memdup_user(buf, nbytes);
+	kern_buf = memdup_user_nul(buf, nbytes);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 

-- 
2.34.1


