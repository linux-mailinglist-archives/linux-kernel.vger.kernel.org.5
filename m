Return-Path: <linux-kernel+bounces-90310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D451F86FD5F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754E51F261C2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23E036AEB;
	Mon,  4 Mar 2024 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kK3BzVN8"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B05F210F8;
	Mon,  4 Mar 2024 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544239; cv=none; b=bWMqKhU301SgcSU83Rw/JjtWTWRfS0LpOD89qU6E3ED8dRfaIUyf6WtGN4fZiC4E9GWPSETmoPPrXy33bPk2IHBMzKtz2SOh3fvNSnbhdvWjM4GWRlSHwFANt7DD9tR9XxKDL73CGUoY6pIkPPAdIHKodIQaV9VCKIcA1JczC8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544239; c=relaxed/simple;
	bh=OjdXgl996KJ6kcslz1prq+1oitdyPh2abPpCxnR1xpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B66hYUr7avwQnsI6JxQT2RfTQ6sdGNF0rOEdiCu2AT4pi+SIE44WzeuCtgfI0hVPsdxagx3IReiJjnd3ZQ0B99IEC26ibd/llHH+icWVkb/vYkHRYLVMOTmDW48n3l5qZohUbputoRgouu0ZCjw7d44Y3D/vn/NPkWKrbd6hdkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kK3BzVN8; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709544237; x=1741080237;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OjdXgl996KJ6kcslz1prq+1oitdyPh2abPpCxnR1xpg=;
  b=kK3BzVN8tjaY6aVEu9bhqDIl3dXYAuRb/6QcQ7S08gIIsEgltS8OGPWr
   +oaVSF6pSFtDT8mTOQOHCat8QyW9a7e2Q3aQu3y1FZZPKkJFDS2fxMI19
   pkOkCObqbFGFUfgM3hm3ZDxSy8rdhDry/fm/WNs+Wgi1QpuNDJeLWLwek
   y86yAo2j+FVtqmGXKV+FooZKd9kSNMhDnotGriA5XPWzKM3P1aIV93hgT
   Tv+IUvGHGDobA20D9kVd1wes8CYbfwoFGNAvFMQS/szeisW/eeMUiQ9u/
   HcIusHUyPVqOf7Dwo1LkXfLkGoxfyRCEoWAR3FIEqRlOB5DCrVMonewrt
   Q==;
X-CSE-ConnectionGUID: QtHxfmh5SDeQnsihbwmKPA==
X-CSE-MsgGUID: PO1S7Z45Rk2GPXSr6Cw3lw==
X-IronPort-AV: E=Sophos;i="6.06,203,1705334400"; 
   d="scan'208";a="11326487"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2024 17:23:55 +0800
IronPort-SDR: 7nMD2euxlH8wRyz0fa3qFmKXlm+vV5EBzPgY6Q+IkRs85yNv7JaJrkkxcwH8ovDff5evndahfK
 PPGGQI4M6f7w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2024 00:33:08 -0800
IronPort-SDR: yZR0QJVOQPPKwAx+ursqZJ8HQsOKyOKft4ayJ7RdLkyl4H8LLIWxqbLDp8e0mzcg3B5oerY+SA
 5EAcvFk/6dxA==
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Mar 2024 01:23:53 -0800
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 0/4] Re-use device management code fragments
Date: Mon,  4 Mar 2024 11:23:42 +0200
Message-ID: <20240304092346.654-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 drivers/ufs/core/ufshcd.c | 200 ++++++++++++++++----------------------
 1 file changed, 83 insertions(+), 117 deletions(-)

-- 
2.42.0


