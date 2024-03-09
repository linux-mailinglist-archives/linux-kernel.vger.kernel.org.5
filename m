Return-Path: <linux-kernel+bounces-97805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4C8876FBC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3E4281E00
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9A937702;
	Sat,  9 Mar 2024 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mtckFTT6"
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5994249F5;
	Sat,  9 Mar 2024 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709971931; cv=none; b=C1yvr/9TbEADU74Z9PQ4392og1Q4o2UCE5MIojhY90S8Of0ko9k2R2zPksRxL61Mn8DCadfMY4wovbWS1Dt4Lp7zWV7RB+NegvsRt/NChM4ePaVbWhZapmM9yE0LLmLt5QSP+qpXoYBtWrMP+T51co5IMz2uPsk5+1VK1jtfs54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709971931; c=relaxed/simple;
	bh=YUXiHY4k8KdxfRkpMRa4zrfX6fzO4umIBuPK9q+tKlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IaIuvAzq0sphS2sk9XC+DQEE2SyTM7D2UOgKX+y1e6ZkgiwunIlCz6/EbkrhY0Xzyr2Pt0ETsr+F1ZI6ls87SmH9LmQ1POUx133s5K2A0ca+hXfncB99DkoXgn4v4P79VqMto7rn4OforJyb1VeS9OCvloGg0Ebyd9wVGOo6pcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mtckFTT6; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709971930; x=1741507930;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YUXiHY4k8KdxfRkpMRa4zrfX6fzO4umIBuPK9q+tKlE=;
  b=mtckFTT6nYEuitlaINCOORYAJOvtgPAAdpgCrCPhcsFEkW6AMiCWMBoC
   J+scBnWhPm8iEo3B/HWl2ag5RcpcwhNdnSUGVNpR/Y5YHkkCtWP4H0y7Y
   vidVxIgSp9OqdJva4t0k69tREMyuWC6S8EzSymzcIXbw0klfDlaQqviZm
   nvy+Pjb04GenNVCBL8am781doqzJGv3MAOMqe1mreh3GMg0kkToxj9KLK
   HWpPAV7xdtG8IhOYIq0U3A3pM3VLXqcA6lofrLOx/Yz4tzTbfRqedsMTX
   zae8M0mYnMa4DE3SmGIUp2w2NMadlVgOXm+WHOQupzgde9RRArSWuJTYX
   A==;
X-CSE-ConnectionGUID: NvKoeE8dSyO2eCb06znFxw==
X-CSE-MsgGUID: Zuiiz2TyRIa70X024KqZpQ==
X-IronPort-AV: E=Sophos;i="6.07,112,1708358400"; 
   d="scan'208";a="10715102"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2024 16:11:07 +0800
IronPort-SDR: jSC2buZsMmFz+I5Tn+6SLJpkng26O2S7da8W9BYkAhvcYr86IgKLG24qr5RUME5OiDxX4dqMPj
 bzkHcBOYsKhQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2024 23:14:33 -0800
IronPort-SDR: xo0xJQxqbFnR1B0uE3yFCV1Jf1+WGqrMjq4vctoJz5Hd8fWZNDKLSNkqkJ9cP48N7/iAVnAYzi
 FL15C8bINO1g==
WDCIronportException: Internal
Received: from 87h6l33.ad.shared (HELO BXYGM33.ad.shared) ([10.225.32.8])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Mar 2024 00:11:06 -0800
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 0/4] Re-use device management code fragments
Date: Sat,  9 Mar 2024 10:10:58 +0200
Message-ID: <20240309081104.5006-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2->v3:
 - 2/4 - Clarify commit log (Bean)
 - 4/4 - pass cmd_type to ufshcd_prepare_req_desc_hdr (Bean)

v1->v2:
 - Attend Bart's comments


Device management commands are constructed for query commands that are
being issued by the driver, but also for raw device management commands
originated by the bsg module, and recently, by the advanced rpmb
handler. Thus, the same code fragments, e.g. locking, composing the
command, composing the upiu etc., appear over and over. Remove those
duplications.  Theoretically, there should be no functional change.

Avri Altman (4):
  scsi: ufs: Re-use device management locking code
  scsi: ufs: Re-use exec_dev_cmd
  scsi: ufs: Re-use compose_dev_cmd
  scsi: ufs: Re-use compose_devman_upiu

 drivers/ufs/core/ufshcd.c | 204 ++++++++++++++++----------------------
 include/ufs/ufshci.h      |   2 +-
 2 files changed, 87 insertions(+), 119 deletions(-)

-- 
2.42.0


