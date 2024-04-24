Return-Path: <linux-kernel+bounces-157109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 592588B0CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104BA28A37C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A4A15ECEA;
	Wed, 24 Apr 2024 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCycvUDI"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22F5158867;
	Wed, 24 Apr 2024 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969883; cv=none; b=RpSw/2xdRsnhNJxIFd/w/9Iz87nrnfsuVHlyTWDxNzLh032IVcvMtB61TEVD361kSoG1naBdAwCua97c4H6bgYO4ICS1tYQ7z8uD6lIsglmBVvtICnqtaKT9Xqg82ABFp1id4GzfeV6LafU0bNv8huwu+VEzkglTztBqhpJRDe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969883; c=relaxed/simple;
	bh=pFnSYolVK1sAbkMTB3+L70JGd/1tIizk76RsmxUjoqM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fLTl5aqQQAdcTv8eAnrpGU6ewqStUln+m5vawgkcVNgH4skj0HkyvntqgQM6u+6OWMHbdkiH6e8HClsJlBArT0FUHwXnqaGjFZTdXBnHNGAv7O0+vAUk4KPp6BLAxvud+CZMkTfxePLv1wj1wXM3Nq51ssrjN4Of4tBNEYsalMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCycvUDI; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ee0642f718so785638b3a.0;
        Wed, 24 Apr 2024 07:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713969881; x=1714574681; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9AlBe3kk5ztZRFTkgvZ6SOgy/VblETXj3psnO1nVDEQ=;
        b=fCycvUDIOelkS1dIvzCtIVwLCZRWx1Y0EF1FOiCQSMmO15VYNxelHGAePzA7m9Brdl
         d7TtVvfeBL4iOO6qgu1acrGAYFoTV+k4vA8II+5i3jQ1EWD8UzhGbmRn9r4/c4Mq4kXZ
         5gdJEEFPNUGT19YbG4frN+6n3pnfxHfDd7Ydp0EJaTcbA9wSGY5I6L8kfTk7DXXuMo5w
         R2tdH3zXsXSGCzoF+oriam75hPEB9nOeJnRW1HIXlv65VyWlSBUsqA/t4crP/bwOnjtt
         Lkop+/SXf0jCSwTy7kMx/FuW1iJb3aLa9F+jdBll5r0sUZpWYJeGHY3hgWWCd6e3GDzM
         13HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969881; x=1714574681;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9AlBe3kk5ztZRFTkgvZ6SOgy/VblETXj3psnO1nVDEQ=;
        b=CVsE4b4DHRFPWk4ZSy7+w5xbDLByfWamryGOcBdsOCKdy0OXDudm5El4O8fyFlV0Kn
         m3j3KTAs1c/MS6wtN/SeG0htNQNU62gZN/PBYrsyzqIboCOI159neKvzSIdeuZzkuIsW
         QtVIEiM2b1FWnzdBdw8Z3j1cDFsEqHcRFTxJm3CUGcRCfHTWPqzhTHDCSGRpkERP/p2t
         EvWKsaoeyvX6UyF+PSkrFoJx3Lgxb9wKHc8DtJsbANslLGngGZ/fc/JRTbt0e7YmU0pn
         itI+VqRWGYjgq2As9yNjYb9HIGcj4cwrFD9gE7MR0Hd0ObMOKsrZTuiBneRZo1y7oSk2
         ChjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5TFuIgRYyiNLi54bsy6UBqp5NJVPe8aJjSWR6/tTCOEoh54irVxs3OkKOlsu5Ogys6nFVQyEtt2H9G1Ju+VrMikaYdKLVX+iewPkOtQnYKN0Jn9jhpQcn8zoYgMbhQ9Sswkg0uF3nesyvdDwg8rFwisToXGEMzbaNavTwWGAjFZk44y9ZQEibaT1qbUUXAU5QL3nz7LCin1UIKso=
X-Gm-Message-State: AOJu0YwVavca6xjkRj9RttTQ7zMPfTlsoLxDmbJKiy9ibZfmYzRMF3z3
	/XFsqpNYXUcvqgWjRHu6N22YsCDLsKwQJmQ0Jfq0AI3z+P+5O/Mi
X-Google-Smtp-Source: AGHT+IEZ2apyKdcveQJKiKV0/EodXodOYVr/N97y8zIovzzSFGYRD4Ce2vZBNWEv4JnoIEF0HZVlwg==
X-Received: by 2002:a05:6a20:3c8a:b0:1a9:97ab:d09a with SMTP id b10-20020a056a203c8a00b001a997abd09amr4044692pzj.16.1713969880981;
        Wed, 24 Apr 2024 07:44:40 -0700 (PDT)
Received: from [127.0.1.1] ([2001:ee0:50f5:5d0:6ca6:7f20:5242:67cc])
        by smtp.googlemail.com with ESMTPSA id a5-20020aa78e85000000b006e554afa254sm11495743pfr.38.2024.04.24.07.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:44:40 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v2 0/6] Ensure the copied buf is NUL terminated
Date: Wed, 24 Apr 2024 21:44:17 +0700
Message-Id: <20240424-fix-oob-read-v2-0-f1f1b53a10f4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMEaKWYC/3WMQQ6CMBBFr0Jm7ZhOqSm68h6GRS1TmESoaQ3Rk
 N7dyt7l+z/vbZA5CWe4NBskXiVLXCroQwN+csvIKENl0EobZbTGIG+M8Y6J3YB0dmxDF1pLBFV
 5Jq7/nrv1lSfJr5g+e32l3/ontBIqZKW7k/GtImuu4+zkcfRxhr6U8gUzNIQ7qAAAAA==
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

Hi everyone,

I found that some drivers contains an out-of-bound read pattern like this

	kern_buf = memdup_user(user_buf, count);
	...
	sscanf(kern_buf, ...);

The sscanf can be replaced by some other string-related functions. This
pattern can lead to out-of-bound read of kern_buf in string-related
functions.

This series fix the above issue by replacing memdup_user with
memdup_user_nul.

Thanks,
Quang Minh.

To: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
To: Rasesh Mody <rmody@marvell.com>
To: Sudarsana Kalluru <skalluru@marvell.com>
To: GR-Linux-NIC-Dev@marvell.com
To: Anil Gurumurthy <anil.gurumurthy@qlogic.com>
To: Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
To: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
To: Martin K. Petersen <martin.petersen@oracle.com>
To: Fabian Frederick <fabf@skynet.be>
To: Saurav Kashyap <skashyap@marvell.com>
To: GR-QLogic-Storage-Upstream@marvell.com
To: Nilesh Javali <nilesh.javali@cavium.com>
To: Arun Easi <arun.easi@cavium.com>
To: Manish Rangankar <manish.rangankar@cavium.com>
To: Vineeth Vijayan <vneethv@linux.ibm.com>
To: Peter Oberparleiter <oberpar@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Sven Schnelle <svens@linux.ibm.com>
To: Dupuis, Chad <chad.dupuis@cavium.com>
To: Sunil Goutham <sgoutham@marvell.com>
To: Linu Cherian <lcherian@marvell.com>
To: Geetha sowjanya <gakula@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>
To: hariprasad <hkelam@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Cc: Saurav Kashyap <saurav.kashyap@cavium.com>
Cc: linux-s390@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Changes in v2:
- Patch 5: use memdup_user_nul instead
- Add patch 6
- Link to v1: https://lore.kernel.org/r/20240422-fix-oob-read-v1-0-e02854c30174@gmail.com

---
Bui Quang Minh (6):
      ice: ensure the copied buf is NUL terminated
      bna: ensure the copied buf is NUL terminated
      bfa: ensure the copied buf is NUL terminated
      qedf: ensure the copied buf is NUL terminated
      cio: ensure the copied buf is NUL terminated
      octeontx2-af: avoid off-by-one read from userspace

 drivers/net/ethernet/brocade/bna/bnad_debugfs.c         | 4 ++--
 drivers/net/ethernet/intel/ice/ice_debugfs.c            | 8 ++++----
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c | 4 +---
 drivers/s390/cio/cio_inject.c                           | 2 +-
 drivers/scsi/bfa/bfad_debugfs.c                         | 4 ++--
 drivers/scsi/qedf/qedf_debugfs.c                        | 2 +-
 6 files changed, 11 insertions(+), 13 deletions(-)
---
base-commit: ed30a4a51bb196781c8058073ea720133a65596f
change-id: 20240422-fix-oob-read-19ae7f8f3711

Best regards,
-- 
Bui Quang Minh <minhquangbui99@gmail.com>


