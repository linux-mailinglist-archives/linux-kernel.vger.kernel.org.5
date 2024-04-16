Return-Path: <linux-kernel+bounces-146616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4227A8A683B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A411C20F65
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B69A127E05;
	Tue, 16 Apr 2024 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OCGnUjQM"
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12D61272BA;
	Tue, 16 Apr 2024 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263039; cv=none; b=r9OVbF/gqz4uXmtO8OtBC/waTXBhjI1OMyXSK/psa8jF/WxpUZQiajKlBrvZPwsJEpfwgfOQdmgU8NbSWhN+GLhIuVXHwaHuoRo21c3/Z7SYOfmRC86oooCYW1BROKCj7MCMT3CI82t9FNNESwzdyAQsLCAtUd2acOSjpuMfihU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263039; c=relaxed/simple;
	bh=c80SH17Ne35IZ+CzKwzMIAK7sy4K/rP0mMdmckoUeNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tWlnGmVMCgvTOSgjTrAVzL4UGDwSqg/917IfZ0Sn3B8PXlF5tfGhqdlqvE8vvNYG9IJaHkjf75w/xb2xx4wt2oBZK5nokVDZJdmIRuLMPdbvCLqELk21dvykpSaWmtGxnm4UH3OO1/10g3ihRPEDiqZpuPCwJbU8WDNINFaDeRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OCGnUjQM; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263038; x=1744799038;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c80SH17Ne35IZ+CzKwzMIAK7sy4K/rP0mMdmckoUeNc=;
  b=OCGnUjQMgM30cUd31T+98BMvPe3h911xhlFg9z4EGlg3WJ+e9Zmkd34+
   bwyhqhqBRU6zZIYTRTvi48nv//S4cHj3bXN2WeX8h0VMNSbxE8jt84Lp7
   IjdpwYokRU9t/3fCveti2cyZIOJ6iwyXor40JSEgqee6eAHvq5UfzTHVk
   7gFCHHYVUe5sUbIukfEoPxW0osQkI3V+nwGYXiDAZPyB/a2lD5N1u0lQA
   G9C4StA1cfiWa42D+UkDyJFi29qvOSEjZ4ohBpLNw5SmxbmwwaQSJ3JY9
   YEZmpOS+4kiNHobdfPH9wwt9S3y6nxO8lgGuTnya755T7w5/LX2bH7UwR
   Q==;
X-CSE-ConnectionGUID: /BG0sHYmTI+XF1J9FF6O4w==
X-CSE-MsgGUID: vpqCzmtkTxawTEVtqwVS9A==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="13887171"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:23:57 +0800
IronPort-SDR: kxkHNSAXkw1bzYEPmvr7lG3QyiOJs1FOg6BvGp4Zbgib9YHz8nX9jG10U7LS9xPIPMoZiVPMlh
 z6LBVF+ozOQw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:26:35 -0700
IronPort-SDR: GeYIbBfZTukw0NghE3pfl/fYNPxPdAXiFGThzeNIXsFkLoFpIeu5DeZzh3CS70+k+D85NpUx5S
 AEw4CE3K5xxRJ/hg4Nh9qaxgzxAO5L3oYD0cSShNZOrLXxthxLBXvdQLKKpm+UkZtcNhpvIXDL
 w3IlaiQYLxC1g4syun30T9V8kl4KEfa5D5uPYvuEWbRJCccHUX+orVq02YWUaF4793s3LK9CKH
 GwCb0VxUz8MyATVqU2Hrq9nZmK0mFKeECgC7091wk688SvYsH8VrtIOQizIFnUsFiN6Ji5ukyv
 uoQ=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2024 03:23:55 -0700
From: Avri Altman <avri.altman@wdc.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 0/4] simplify ufshcd with the guard() macro
Date: Tue, 16 Apr 2024 13:23:44 +0300
Message-ID: <20240416102348.614-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can simplify the code with the guard() macro and co for  automatic
cleanup of locks. For making changes easier, this series is divided to
per-lock type patches and only address the ufshcd module. There are
still a few remaining explicit lock/unlock calls, and those are for the
places where we do temporary unlock/relock, which doesn't fit well with
the guard(), so far.

Only code refactoring, and no functional changes.


Avri Altman (4):
  scsi: ufs: core: Make use of guard(spinlock_irqsave)
  scsi: ufs: core: Make use of guard(spinlock)
  scsi: ufs: core: Make use of guard(spinlock_irq)
  scsi: ufs: core: Make use of guard(mutex)

 drivers/ufs/core/ufshcd.c | 623 +++++++++++++++++---------------------
 1 file changed, 270 insertions(+), 353 deletions(-)

-- 
2.42.0


