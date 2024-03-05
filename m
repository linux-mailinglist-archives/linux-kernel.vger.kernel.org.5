Return-Path: <linux-kernel+bounces-92984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ABD872907
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406C51F286CD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BDE12AAF5;
	Tue,  5 Mar 2024 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WnMd0/Lp"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9470C12AAF9;
	Tue,  5 Mar 2024 21:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709672459; cv=none; b=b2gtFOwOGZZjQai5seRfiXD1AYsQSfl//Ix2qoNMUUmNak4x1nYZ0IIegWgGABORl7qo4N7qovxVwGmAVQ4XEGeIxZhApWINWwOo40RLQL+7qYa5v7HRZu9mTtbG6aEEeEwHjZpkF8Z1p9MTnnFVFQA4EYWVLPTxK81wW0yKxBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709672459; c=relaxed/simple;
	bh=u9nBdyY2Zu/bsOk8ujnCI/Ne6Dmf1PlQ6sXI7ZNdlVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mbe4iLxDFbFOJjt8+IUawFa47wHJDXZDPKQh5h3nBAQzUGJTKgqI4n73oRtap9Rt8cHiUSnah3gqKi9YVzdip0Ae7lUOLk+oj2a4hCCA91OPZXGHqFZD6Q7Tn4qu64okW1lxccYLKclrs5dwH8G1vJes+K53lHOb6aIgU1dT4wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WnMd0/Lp; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709672457; x=1741208457;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u9nBdyY2Zu/bsOk8ujnCI/Ne6Dmf1PlQ6sXI7ZNdlVQ=;
  b=WnMd0/LpsdZ8M2BtsrRIK6YjtwRAQ+cBIkVlo7m06Vns1l0Rj8BBaMvM
   ELnOZ4rkiPzT3p18J2bkNy4FsisElzqOGYdb16KNYHYn3LMh2RRA0iOQ2
   YiOBRd6YSp2QLRB6dM2q4wpFzuRbhNW1laYnhrfCxbUS8PqV9lyb2KWdu
   UmnZDpthOvrYifrDG4kIM9xHVHtfruvQBifmljojh2FHuofgqlOP+7VXN
   OOTFk+wAFvfe1eF0ygaKh5xjmjg6fACSIMi9UTiXyWjN68zmdDSn5MV93
   anzfqsWLgUXRzOoAeyLFIqQZrgiTaHfgtpJy7a9ie7ovbN3rY1RQWqQuz
   A==;
X-CSE-ConnectionGUID: TqszR4n2TlSLwmbtNw7Xbw==
X-CSE-MsgGUID: OlrN9OUeT7eQ5q1FE/XOrQ==
X-IronPort-AV: E=Sophos;i="6.06,206,1705334400"; 
   d="scan'208";a="10855930"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2024 05:00:56 +0800
IronPort-SDR: Rt9R/jx9dnuzRa/Qt087XNDzD0R+qpyyVtCSjgiNpN0cw4FKITgPiN7vdAmA2B49+NH5FkCibc
 L1WnhlDP3RNg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2024 12:10:06 -0800
IronPort-SDR: rsMfJvruKGXeOGjuRyl9e64RgoyIPbr5JGMjLJuyvDNdH+2sB3u4GbXLrkLB/6QeNoSFIXQ47J
 X6e9lYOTia4g==
WDCIronportException: Internal
Received: from 87h6l33.ad.shared (HELO BXYGM33.ad.shared) ([10.225.32.8])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Mar 2024 13:00:54 -0800
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 0/4] Re-use device management code fragments
Date: Tue,  5 Mar 2024 23:00:45 +0200
Message-ID: <20240305210051.10847-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 1 file changed, 86 insertions(+), 118 deletions(-)

-- 
2.42.0


