Return-Path: <linux-kernel+bounces-157112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4F28B0CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A4C1C24798
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3822B15FA7E;
	Wed, 24 Apr 2024 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeQkZzPf"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E1915EFA0;
	Wed, 24 Apr 2024 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969911; cv=none; b=MMKSuf/8j/xhUqwCDi3qlNHrnQ7mi7Yh/USKQ5FU1pa1Ga4CpJRvL0wwU32hZhAmBHByItZdedwJaRoMOAF2CCU7ekGjwjgqS9ezKXl8UWwchhtFpZG8JR7XMotjlCwQNyXtyAYrAbCKBQd2RIsjXZYlx0CHY8/WXlHW/o2bao4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969911; c=relaxed/simple;
	bh=5qTfVU19Uhv7IKSJxI/EImm9oveNfOjQF+DaIPmQs6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dLkBu8T5EwsxM0pVgDRKbqaPS1tWYpEuEjZJnFFLajXwxRn0tHl41PNyOjVacZ6WxQONDCSj6qIZU3p+bHDgkiy22AbPLi1oShMPTgWkaqft+1BIQtElkEZDVvWVTmfeqzE+80ptampDeed/WqT9MLb0nRHYX0T90j1YBUu6gsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeQkZzPf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f30f69a958so2568355b3a.1;
        Wed, 24 Apr 2024 07:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713969909; x=1714574709; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDVH41VbP2tcWCidq0GxDLy5uHVpzfSuy3cESbFhDE4=;
        b=ZeQkZzPf1PsyFPY+9BPyc91yYyix7ODkEgq/Kw8ZX7Bg2hktumFSbLso6fToCG8f1l
         dOF+OtIbMGVwcoi0bNPcLoqKUd3adRDCX90llTj4wiW9VpOHwiBDPdX+lIE3kiRuWS0t
         5V7qSjB4yXnAQiBoiRWcwd1Cg0G4Z9QhbG3HnKURyueIUjw/b3e+6VUpbUVatNH2QBzM
         EwWF+e/zzC6BatQ2t2EU7hy7EgY8Duy6LGhWVuUbyBy1WPC1bKGA7yPDiWn2O74j9bSU
         DLpnqQhMi9EpDKsCAPJckVFQICUsnib9xJgtrNEsaJ3yKxS8CmAklM5FfMO0VInd9fpL
         9vGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969909; x=1714574709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDVH41VbP2tcWCidq0GxDLy5uHVpzfSuy3cESbFhDE4=;
        b=o731gKMXK5qhpZffLlFvPlVvC5hrEOKNjXssVVq2nJD+qJ0EqeBsFMRuoVqMq7fWnY
         NbF239Ll7RH5Q+tQh32HOHaIDJepGRykR4V0V5CqMDKkCrJJ0uoACdefnSJ9dkimZPYi
         4t4zOQ4dxFSXjTtP766FmP0JiitfGdB/wt+RDI7eH3AtU2/IQuzTLZ3tTEvSDn60WxcW
         wKNTLM3cY1/X0GPb/lJ7jGLkXuxDTpt5xilV+LAXgiPFNR2y+5wLrK1NDTTxasv4NgiN
         qzi9RIrLP+bLrkw9Db0cQCxnlUkX07H2eM5PCPVPBOuZ3nzaiZ3kPOvOipOa1Sxd1lF6
         KnKw==
X-Forwarded-Encrypted: i=1; AJvYcCXXq07c7cnlHaaNmRNquKRh8G0SYTWC7ifoIrQhLiEL88ST/NxdHRESJ4gyVfzVlkqXo9i3nTvCi3EC/S0OyB2yFrnSZbp5Zf04aHa7WiSm2OOMtz4Pt75xG39YW2dOi23JqtKpKSMr4+vkhXfbcD3B5K3kxqZ6KBnCWTpPu+pU/m32jMENAauVmBoK0JWeX6cqOn1AHeLrse3Vk8w=
X-Gm-Message-State: AOJu0YwQpwh6ZQpx83oDZEoYSS/GvkVBc/ADF+9WcBWRnQSax455t2UR
	EMYWcAFwffyZYLFGtHDtZOhGgbF74MW32SgqooSJUBOSfenQ8ETI
X-Google-Smtp-Source: AGHT+IH7hDlGcLTpV6B9afh5y3sKseUhS0nuv4tpE75qoG+uPsjDp5Z57e8vcBnEwXBPXU5/z8LMfQ==
X-Received: by 2002:a05:6a00:2405:b0:6f3:c10a:7bf3 with SMTP id z5-20020a056a00240500b006f3c10a7bf3mr503754pfh.0.1713969909373;
        Wed, 24 Apr 2024 07:45:09 -0700 (PDT)
Received: from [127.0.1.1] ([2001:ee0:50f5:5d0:6ca6:7f20:5242:67cc])
        by smtp.googlemail.com with ESMTPSA id a5-20020aa78e85000000b006e554afa254sm11495743pfr.38.2024.04.24.07.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:45:09 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
Date: Wed, 24 Apr 2024 21:44:20 +0700
Subject: [PATCH v2 3/6] bfa: ensure the copied buf is NUL terminated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-fix-oob-read-v2-3-f1f1b53a10f4@gmail.com>
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


