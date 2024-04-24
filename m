Return-Path: <linux-kernel+bounces-157114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFEB8B0D02
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3AA284A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD45E160880;
	Wed, 24 Apr 2024 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6+X62iu"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41BE15E80A;
	Wed, 24 Apr 2024 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969930; cv=none; b=EPnozXfJmT0p4UGQf4k+zYiCqRW74SwyxRcGyloM5W4GpD0Cl60CRvR/dhpIMrPKG8pstiS57knqfr7jraYXdaQsOZmVPo9gg2h1thgXcQIop+amHmpQsiDJMKsi0AIZaLxN0he5ObTbTxhJhhVtES1qLmsEQzxx25/eOhJ1M6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969930; c=relaxed/simple;
	bh=aix1wltbnvI+LGeK2npCFHtEWRnHLDoEpx/+kltaLE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gp1zYtQSgUOC9ANgVU8bPfckeo7r7tPJy3g9ysl0iEChEHY64i8FDzm4MUZF8ncq9fCxCDdRdmNdNavxqRn+0z0lnGYr3gWgxR2TIPdhrrIfcGtdJSvFbfNCgPDUcRz+XJVh+V60wHDBblQ0dgijcgG1jRfJUjnniQGvnvS/v5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6+X62iu; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed691fb83eso5549718b3a.1;
        Wed, 24 Apr 2024 07:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713969928; x=1714574728; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvl1jMUGuwOdmWEm+br3UjKr3cLcAoB/+uMyF5RTu+Y=;
        b=J6+X62iuCjpd/aLdssNw0/BBvIHoi94ORO/1evY4ZBFAWmvhbSYXKXZsw117wGA082
         sZt6l5VQsTBDrNfSRhZSUAjyNz3Jo8qwYfKaC4l9b8P/CKulObxja+bnou9fGc/xq6sO
         H6Yw7Lb8gUZnn/Q6ywRmOh3a35Cu++ZWXQTWRuwrs8WAbUjmjfq5h/DMqwn+3x7AyCQJ
         LH+dP+5kRH0ZczyIdtMpXycOj0YcgJyE7+6vXNvGE1uofhCRHSOY5/mHopJdT4yKSjEq
         JuzynVBMUpumnDBUOhZ1HNDARTdq7g5tBLB9a1R/h2i3hOyUss0Z7WJqvHietAylZPhx
         zFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969928; x=1714574728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvl1jMUGuwOdmWEm+br3UjKr3cLcAoB/+uMyF5RTu+Y=;
        b=buGjRdSy9AnK+Zb6btaKoM3W0moWQFXZpOu1+eljk5hlXYm5TuUCW5TxRpOYfjyLI5
         t0Q9gzKV5grOTFW1l/Eh/UsShG4Jmj0Egopr2xews0v9HdDULIGZcRMAR7a0e7WK0MTT
         ObLPFwMFhe5b7s8YVurgEX8H3KkFiDYYz6GwOcXZx/s8tpb4EGiJ0ua3mG0phhH2rdrH
         4DX393JWXaxbcurgXjuaNdvlCxR4Zvf02T5x19Q3/mxNxmwLsz2oBIOkg55Na7y5w3/E
         z38SJWNGgRHZl+R0rQsNAR+qECJAkrH0JTOEGajKvi9yA3zqhP37KdPaktQPtNZjjXvz
         LuyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxFwpCis311p1x3zD59XJPVhBkXRqDXWln1qdxm0joqrcJ+AG9xTDR43NtPhACFAmrKj5HPebWUbKP5Mzjox3oKqaeatxorwcM523RoXD3YYRRF0VmABuI6IouiEItq4mSETp6Ossf9E/USCzyspdE10BZZsMzoAtQ1jjhi4Gu+QJJ86ALzY+m7JaA5k2KhaxaJvoJpqOs+No7Mpw=
X-Gm-Message-State: AOJu0Yw5vJ8i2lXyFd+gUSi+vTkZH6cqIi1hJz+Gnnc5MayiIo460dGR
	lgwLw/Xio1g2XbQ6VyqLFKfGV3SydOdOcy8VumQEp+bjdbGtOydS
X-Google-Smtp-Source: AGHT+IHIplfZzFXa/iQYXqPqGxrFFD3ZiSSQJzv1wptjoAyF4wVcTuCyNZAS4Gj6injBtEh1O1LdTw==
X-Received: by 2002:a05:6a00:2e18:b0:6ed:d68d:948a with SMTP id fc24-20020a056a002e1800b006edd68d948amr3330617pfb.23.1713969928004;
        Wed, 24 Apr 2024 07:45:28 -0700 (PDT)
Received: from [127.0.1.1] ([2001:ee0:50f5:5d0:6ca6:7f20:5242:67cc])
        by smtp.googlemail.com with ESMTPSA id a5-20020aa78e85000000b006e554afa254sm11495743pfr.38.2024.04.24.07.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:45:27 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
Date: Wed, 24 Apr 2024 21:44:22 +0700
Subject: [PATCH v2 5/6] cio: ensure the copied buf is NUL terminated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-fix-oob-read-v2-5-f1f1b53a10f4@gmail.com>
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

Currently, we allocate a lbuf-sized kernel buffer and copy lbuf from
userspace to that buffer. Later, we use scanf on this buffer but we don't
ensure that the string is terminated inside the buffer, this can lead to
OOB read when using scanf. Fix this issue by using memdup_user_nul instead.

Fixes: a4f17cc72671 ("s390/cio: add CRW inject functionality")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/s390/cio/cio_inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/cio_inject.c b/drivers/s390/cio/cio_inject.c
index 8613fa937237..a2e771ebae8e 100644
--- a/drivers/s390/cio/cio_inject.c
+++ b/drivers/s390/cio/cio_inject.c
@@ -95,7 +95,7 @@ static ssize_t crw_inject_write(struct file *file, const char __user *buf,
 		return -EINVAL;
 	}
 
-	buffer = vmemdup_user(buf, lbuf);
+	buffer = memdup_user_nul(buf, lbuf);
 	if (IS_ERR(buffer))
 		return -ENOMEM;
 

-- 
2.34.1


