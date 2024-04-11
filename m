Return-Path: <linux-kernel+bounces-140135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F408A0BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D641C21D23
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C89144314;
	Thu, 11 Apr 2024 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT16ysT/"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D4714388B;
	Thu, 11 Apr 2024 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826339; cv=none; b=oJjeN/DFs0SKyb9Q4OBJeUnqMjM3cz2sY+zPZ+QNdAd5kFwBdjM6vnIumMe0IUh3ouVXDE6JaYe0XmvG2qimYRIUits9sc+u6f5kG834YWWq7+KpR05ytk6dzW1jXySAYeiWLfM4zdOQ2SgrhG7B/K1cKxGqF5yKpQBDW138umA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826339; c=relaxed/simple;
	bh=h1ECHJrI6yDGWiq8/tzickwJ+lsJ6Lz0fibT2Qel/bw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UMv9SpGoUGahc0S7f+0fvPWN2YbAFselh3sO6rvJUpqy9rUB0hjRUCtBc0ll2suXCUYPWJKPVtNA9u/5FOw4rlcZTntGyHN34r6/4zRP49b+qgShvQDRhR64pH8WHCeS+iixeDjJBvWiRG31lZRVd6iM/dBlh6cj5dP/MAtrv3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FT16ysT/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-346b480e1acso329901f8f.0;
        Thu, 11 Apr 2024 02:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712826336; x=1713431136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ThLGpbeHjKHISy6v+wWhWzlM1AmHv+Kiehy1oJijdu4=;
        b=FT16ysT/obu8gWYpZghQQR3McHt/frdzoZ3lpHLjGOzAnbwFckH+nMTazlJz3hIILo
         saerQ39IxNRjQKUlv7aKqr+dSyBEiGcWotdwFe1bwW60QOYWNDHdh6xVTB6RUy2YC4Ec
         Dz5r+Z/rBzxkHe6xBKZxaY6CGjereBOxaTbLFtRtTf92GJqyoWWOResVy1OFYgM5vNWs
         qg7Nriqs6+Ec+CkOMckTvtCzoCh3iZ0SVD5cntTydgG1fli7NgvPlYG/25GbzsLUINFw
         yQ3ZM75+/nEoP3LGSccwozsA7bblqDemkySkvJyqG/tkWCMwiaFQvhtmEhWvQzOzStkv
         bcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712826336; x=1713431136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThLGpbeHjKHISy6v+wWhWzlM1AmHv+Kiehy1oJijdu4=;
        b=I0BAQkmoP9W7xd0l90yxiCDn+ZkKKHdSVr7c/6gBz+b0c2jMqHt0V8b6yx8+vdLoyJ
         lTY0+KZu4j1V95YrvCjxhH8tdLFAtWn7h+3JZ/i4rkZymMel16v/GbuEG5gtuc1VcYv5
         QnfIQTGA93BnykO52BMuqWtSnP8fTlcG3dwOueIA4MXXZU/I5acpeoEfl3izG5JSNd0F
         4dTBCUPKV904ydG5T88MseWRPBcaqxY3ngZKadU4oXr24bg/ENg9RFQLThZXDGp0d2Ii
         rxLuCW935rtP1Nnpa8mUbpgz80KwNUCYnHWCetBkctDnlEFZ94vqDCktvm1CC8t2e4vi
         VNkw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ700d5S3Gmk7k3eY662w8Pkf9TSZQJg7cqYrzus05BH+VOjaKx82bUrfju+mTB0C2NhMkPF8IDH9Y3jMpbJdr1G719KuCU2auWwxi
X-Gm-Message-State: AOJu0YxaH+DKUOCAixeA+ZT2HOFlMvxHH3pvSTj78A/PLkuCOhHnHIn6
	4Ug4FitGcuO/FmyLkzTzT5SoLrYOJnjdmNpxV6mBpwa0kip3iG/Y
X-Google-Smtp-Source: AGHT+IFTY79T++ZLVntjb/YvHujT/vlh2HyBVoWR1sjZgibIrmibZdxv2OPUYMdSc/Jlz/ExOtnfFw==
X-Received: by 2002:a5d:47c1:0:b0:346:bca2:6184 with SMTP id o1-20020a5d47c1000000b00346bca26184mr949714wrc.0.1712826336250;
        Thu, 11 Apr 2024 02:05:36 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id m4-20020adff384000000b0033e7de97214sm1279914wro.40.2024.04.11.02.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 02:05:35 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] iommu/vt-d: remove redundant assignment to variable err
Date: Thu, 11 Apr 2024 10:05:35 +0100
Message-Id: <20240411090535.306326-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Variable err is being assigned a value that is never read. It is
either being re-assigned later on error exit paths, or never referenced
on the non-error path.

Cleans up clang scan build warning:
drivers/iommu/intel/dmar.c:1070:2: warning: Value stored to 'err' is
never read [deadcode.DeadStores]`

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iommu/intel/dmar.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 36d7427b1202..351be9455214 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1067,7 +1067,6 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 		goto error_free_seq_id;
 	}
 
-	err = -EINVAL;
 	if (!cap_sagaw(iommu->cap) &&
 	    (!ecap_smts(iommu->ecap) || ecap_slts(iommu->ecap))) {
 		pr_info("%s: No supported address widths. Not attempting DMA translation.\n",
-- 
2.39.2


