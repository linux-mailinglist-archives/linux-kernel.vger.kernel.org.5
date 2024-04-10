Return-Path: <linux-kernel+bounces-139212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AF189FFE9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D754B1C22986
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BDA2629F;
	Wed, 10 Apr 2024 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PqMc/D/B"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05863E;
	Wed, 10 Apr 2024 18:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712774254; cv=none; b=Kdob+Ikad8e1/KkP/jzcVJTb3OEAehJkKFaoWydFISG9WnFKG4refCGsPm4hlWIxgY8UdSrNVILdljt5ZKX8qk4gvhtX2v8s9PmIQcKfDMWWomMqK89sPojsmngeJDDPrMTeaokBBTIrKENBcowUmCHjlfuw28XAqkenm0DFt3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712774254; c=relaxed/simple;
	bh=KOwDwhFrEA9KFntc2q5M4xYB9cNgaeTgoLBBx/yn9h0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zohc0uQ0i2A1oL9DgFgx+epgYtFHRz0nEYGG6qyUklRhLz0tzT9de/YcMQryNNbpjDc8us4wj+JqqL2Yk61mRKYNUSyTZ/KOL2I2QGGGuuVS3+jRTWuO6m+BZ8hp2QLXDtWuNuDNbq6jM16qbOGCVtQd14e8qCZxyE5aY2jLw4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PqMc/D/B; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712774252; x=1744310252;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KOwDwhFrEA9KFntc2q5M4xYB9cNgaeTgoLBBx/yn9h0=;
  b=PqMc/D/BVFIkTtSZ9AHYvxheqCW4noR5USrubO0LbBfXghkECFxfLCqd
   9xvKaK6eiK6kihyag5FzKBGuvBr1mfRvhS9Ee16W/Sf1sy5/+sFyqT4Rz
   TWTa5j+YCer0uIoo1Jj8tVgakfvv5k65CP5HaVdP1Hmwq2M4QapL9xSb9
   1UHm3ieCYn8qBjyV/YjHG2aLpBkQFlcn7b8MVDcAP2jhxFQkwNuUXotLX
   Zm7BB/RNScMzxFhoY9uzo5XKRqMVtAUo/jE57MpcuyRQGMF1nvgSNoLAX
   vPqaR74KqnYODK0Ql9wXnoLwwLiTHQFU5JqN3JiriC5hdh7GKn/m4A9pF
   w==;
X-CSE-ConnectionGUID: rUbHQ2VkRpCKdQbvTmyvuw==
X-CSE-MsgGUID: c5e24lcxRcyCaKWazjBRdw==
X-IronPort-AV: E=Sophos;i="6.07,191,1708358400"; 
   d="scan'208";a="13708143"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2024 02:37:30 +0800
IronPort-SDR: 9asQfIyI1quBsnttmShxpog3Ls4FOIlOKlDst6IdJufUdvUdqivw2SP4qRMSMO88NAwu2eRQq8
 ej+dVwNN7BWw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Apr 2024 10:45:57 -0700
IronPort-SDR: 1tjWe8ruonj/bA2iBcL7jVnw1ud9/hdeBM2j1B4uGHRWbN8iZHZQEHKATgzXCL9NBJAScY8luY
 6TaBCeVTDYtQ==
WDCIronportException: Internal
Received: from 5cd220gd5d.ad.shared (HELO BXYGM33.ad.shared) ([10.225.33.26])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Apr 2024 11:37:28 -0700
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v4 0/1] Remove support for legacy UFS
Date: Wed, 10 Apr 2024 21:37:18 +0300
Message-ID: <20240410183720.908-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UFS1.0 and UFS1.1, published in the early 2010s, were more of a proof of
concept rather than a mature functional spec. Toshiba was the only
device manufacturer with the most accomplished phy team to come up with
a small UFS1.0 device. Alas, there were no commercial platforms it can
be paired with. Even UFS2.0 that was published in 2013, didn't really
make it to the market: too moot to take effect. It's not until UFS2.1
that was published in 2016, were a myriad of devices and platforms
flooded the market. Designated to mobile devices, dictates a rapid short
lives for those platforms. Hence, we can safely remove those pre-UFS2.0
pieces of code.

Changes from v2:
 - Make it clear that UFSHCI2.0 is not included in this change (Bart).
 
Changes from v2:
 - leave UFSHCI2.0 out of this change (Bart).

Changes from v1:
 - remove ufshcd_get_local_unipro_ver which practically mean squashing
   patch 1 & 2 into a single patch (Christoph)
 - restore an if clause to avoid functional change in
   ufshcd_compl_one_cqe (Bart)

Avri Altman (1):
  scsi: ufs: Remove support for old UFSHCI versions

 drivers/ufs/core/ufshcd.c   | 158 +++---------------------------------
 drivers/ufs/host/ufs-qcom.c |   3 +-
 include/ufs/ufshcd.h        |   2 -
 include/ufs/ufshci.h        |  13 +--
 4 files changed, 15 insertions(+), 161 deletions(-)

-- 
2.42.0


