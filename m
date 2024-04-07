Return-Path: <linux-kernel+bounces-134186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F3489AEC3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400E2283008
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 06:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40F57489;
	Sun,  7 Apr 2024 06:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I+3HGjKJ"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB45184D;
	Sun,  7 Apr 2024 06:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712469856; cv=none; b=DZO20Owe58BYSe8/28ZDTtemJWumPOEDxb3WqK8hjhT/OfSqY/d1AZ8+Qp0yDshDv6Pph3dLX8V4wspqzUlUP3wfoY1NYqHZGBeD82yMMmkkwF5wTPW3n73SfdifdKKXdMtHV/LI+ocR7XqbHky1+jFKNDo4nlQZV58QZSWFMSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712469856; c=relaxed/simple;
	bh=QBPMGzUqywyQjNSFUH3JOgi6/Csu9eiQJ+PVKFyIIJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pi9hTupBird2TqECzIN2QwTc9IqwLkfG7lpxj7SqcQiJUivBdr/fc07NCV6CTUiVxR64MSw1cZ5greabc/qZhvFZWMXtmcvZsj2Btv/WHn8/aGhpSafvxBtKIEdf7Jm0fMoHfetQQXin40EUHB/MtArnmK7xJ5mAa1iq+24o5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=I+3HGjKJ; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712469854; x=1744005854;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QBPMGzUqywyQjNSFUH3JOgi6/Csu9eiQJ+PVKFyIIJI=;
  b=I+3HGjKJqFWo8yNlgyqJQAUUF3icMbRLJ3lO4C51T1AFfQsyRAQUy26D
   tICeK2kMDi9EqovIATxUAp8UXiEy0Ayouc3PtOV2fn/+3R3ieeRajDfb8
   0vh14V9pe8J6VX2QD8c9cRwsnG+hk4GPi/HRVhpVpLcrXF+rmuVeYT+O8
   KEVKveWZBEbR+lIow4tdHxmBc2GkqBSjn6kGl7usaF+nPT59gOXHvOD8T
   /ZHXtkImOQwtVGlZJONp4uwR7X3Xi/tcZzkMu6FXAW8R7yo7VAL9WNWb0
   kti7+enEi8K6NylbN5EwgzqELdfPhIRvU3AQ91zZWKwD3fR3W7J6aqwwy
   g==;
X-CSE-ConnectionGUID: Z3RA5XaYRWiViiS4b4giLA==
X-CSE-MsgGUID: d2Jy5zYzRu+uADE7gaiUew==
X-IronPort-AV: E=Sophos;i="6.07,184,1708358400"; 
   d="scan'208";a="13427328"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2024 14:04:11 +0800
IronPort-SDR: c8kgfwIGRn7JgPaslLLISagiIHLkFw8slI1yP71vcbgZRq7SFd87skmuReuptHWpox/4bzcVaQ
 4U1l6JWUOSqA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Apr 2024 22:07:02 -0700
IronPort-SDR: /dEc55hJcUtxtxhC14QGx3f5mG5R6coXL3FBksVOR07ag9g9gzn5zqx9MG1zEyyKlwvEnrjz/h
 9DBMCeeCk3OA==
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Apr 2024 23:04:10 -0700
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 0/1] Remove support for legacy UFS
Date: Sun,  7 Apr 2024 09:04:09 +0300
Message-ID: <20240407060412.856-1-avri.altman@wdc.com>
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


