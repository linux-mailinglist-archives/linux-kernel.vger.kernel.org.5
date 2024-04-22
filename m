Return-Path: <linux-kernel+bounces-153739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 410308AD28E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CC228A872
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDB315665B;
	Mon, 22 Apr 2024 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2uYJfFY"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF94154C12;
	Mon, 22 Apr 2024 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804168; cv=none; b=EnOO9pIG4mOAJGdXL6CuXB7UOqDQGtHlmL3ehrP1/XFy0IoSezeeBoRdoMxHsCCmz/4ooSqMxP+Ctjc97dZMQnAxPY1FNjFnG/xRUFD+JA7Qo70Wj7OwnNOAxvS2XO0R8sj1vUuOd0T5nf/EPjYEgNSGTk/raw2ILVz2hpwf7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804168; c=relaxed/simple;
	bh=VaK7Dc1ZgvBEif7TgA4tb6qDQZcFjHq4J5gOM7PFKSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gquz2wxoqi5XdF5+aVqWQ7xNY7HNkPNrZSPj/31h9coGt7tHCXYHrG9o9q6Jyw6f78aM1/Wk1+aIiY49AnrB1mPo+L2+GXpb+NxYekxB5zSWSeWAMJn4U732ktKkg1uMQ+OopbGF6TnDTmrUl3yRIeT41Lz0IOQdR1I5lTjJB9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2uYJfFY; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e3f17c6491so36130195ad.2;
        Mon, 22 Apr 2024 09:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713804166; x=1714408966; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jL5u74w472gVJgaoFOuurGlZOko3LllmO61ppXmRiz4=;
        b=k2uYJfFYF8Vz1DG1MkBVKnbVbdgRq8QS1HHvjY8Yn4XVpVCO+hJ4YgHRHvAL2bFFwn
         djPLpTf63LafIHIbPlWBGQOQpgwYHW2b2OWdFNw5SLb0iID/1YHY9t7RcGfBZA59xqPm
         Ji7ux1y17/bJv6k2cdAbMTSV1eVhSbv0K4Y0A6XUm43F7j6+hT1A8v9vLk7CNUC2W8zh
         0iyZXksg/VQx6h/Vd1pS8uDFaONBeq9jJoX6TZVlZl5k8KN5HXCNoshhKIGJYgP6D3uI
         WuQdC9jHhynkZrgoM1wcKhBlKnsPNDkW7eq3f+szASIghz4UklabW/I57H/5d5U6+Q8f
         5fYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713804166; x=1714408966;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jL5u74w472gVJgaoFOuurGlZOko3LllmO61ppXmRiz4=;
        b=vTls42g8DZ+d8/RYdCkeq0UvgVDcNgH8x27qeMofxcsqCu3vgRW8A4VZo4tDry5/Jh
         W062H/p4feHM0i0OZt0Gj933jtBnneZ9pIsM6r6wGBdx8rmn1Yv79I0CyZm3mCSZhC6+
         2nvZNo+P0pcg2f/mhIB1t20zbE1nQ99YB0vq3WVN/E0L3/itHcLJUiZ5EK0IwLegIidc
         TKCmeMiKazRvAQtCt7kF6Zpc5xvAC4TkhgnhynuhIG6dJBpk18+fnE/+zL5LST3jflME
         ulHywgazaON0Qfb3LpHZVZf1AOvcS8Ws6xDMqDUtkx3D+bXIyHMP5FsjSXKbO4Px6H3H
         VPXw==
X-Forwarded-Encrypted: i=1; AJvYcCVl1aXpBsctSM3M4I+aw2Ao7K2kiZWLpYfgiI8gucstS9PeDbNfoJVoBtN/raLdlZNuAvvR5ihuCtlzNffBjLXOvmEDQU9xIm3NBJ5oXdYC6zac/EIECkpXmjOvgTYiqGbvh7iikfWJQEEZkOtu53hEswrCoQ9kB58C2xHFL0JQ9RfHvzUfVuz+kGPn+NYOXV65GM+n+7kB7SWwjtU=
X-Gm-Message-State: AOJu0Yy/u5/g7jp+SxZ9as2dhL3K8cAkkjt+ndmVPml4JxBQx2hxeRWW
	w85A+4aEp8E00Fo2BX9JgA8i4EbT71ljdjxEg3p1N3igGlgNKB0/At9jwtNI
X-Google-Smtp-Source: AGHT+IGFYxmbMrycOqL+3S4jQuGH3EvQ4YJVKxorFUyzvblrMx0EhcdYzSTzQFFqrVCB/jUZ0HpnMA==
X-Received: by 2002:a17:902:b187:b0:1e4:17e4:3a30 with SMTP id s7-20020a170902b18700b001e417e43a30mr9577651plr.31.1713804166091;
        Mon, 22 Apr 2024 09:42:46 -0700 (PDT)
Received: from [127.0.1.1] ([2001:ee0:50f5:5d0:f32d:f608:a763:3732])
        by smtp.googlemail.com with ESMTPSA id p3-20020a170902780300b001e7b8c21ebesm8461702pll.225.2024.04.22.09.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:42:45 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
Date: Mon, 22 Apr 2024 23:41:39 +0700
Subject: [PATCH 4/5] drivers/scsi/qedf: ensure the copied buf is NULL
 terminated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-fix-oob-read-v1-4-e02854c30174@gmail.com>
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

Currently, we allocate a count-sized kernel buffer and copy count from
userspace to that buffer. Later, we use kstrtouint on this buffer but we
don't ensure that the string is terminated inside the buffer, this can
lead to OOB read when using kstrtouint. Fix this issue by using
memdup_user_nul instead of memdup_user.

Fixes: 61d8658b4a43 ("scsi: qedf: Add QLogic FastLinQ offload FCoE driver framework.")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/scsi/qedf/qedf_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qedf/qedf_debugfs.c b/drivers/scsi/qedf/qedf_debugfs.c
index 451fd236bfd0..96174353e389 100644
--- a/drivers/scsi/qedf/qedf_debugfs.c
+++ b/drivers/scsi/qedf/qedf_debugfs.c
@@ -170,7 +170,7 @@ qedf_dbg_debug_cmd_write(struct file *filp, const char __user *buffer,
 	if (!count || *ppos)
 		return 0;
 
-	kern_buf = memdup_user(buffer, count);
+	kern_buf = memdup_user_nul(buffer, count);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 

-- 
2.34.1


