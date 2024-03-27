Return-Path: <linux-kernel+bounces-120416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7C088D713
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB1B4B224FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1535A28DA4;
	Wed, 27 Mar 2024 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ifKIbeKz"
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E7E29D03;
	Wed, 27 Mar 2024 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711523853; cv=none; b=YVT7Dad/MIRszuTtCbDt2htk80ZkWM+B/cJW4LMqlWF6OfG8KCUJYsvPc/vN7TG7lzpc80h7+/ilf7vto9/E9LqKqVBbpLKUpdMXYxWiJF6wnpMawEWD2BlLj9YfyI6oONuxRoaEaKpCE9Uj/PDy7BfdR+e0tSj51E116wxdt/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711523853; c=relaxed/simple;
	bh=D9p4RfF5ezlFXA1XBBrfGcpjoZrd0yh0J08vc3C306I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LEoO6v/hzBc74rMXh09StZCm3KZeaLgh4mnh5AlpNGLst/JmAGMNPs5I4k8R/7zFvnsB+N5aBPaKapZm4ZWXf9LFezUzy/jAtftfeEhiUW36fu8mxyt9Pe/76AAuEIgMMseNSf3DA0H7aVhYuMo2Oemdir71PIWDDQ59xuJ8fE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ifKIbeKz; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711523851; x=1743059851;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D9p4RfF5ezlFXA1XBBrfGcpjoZrd0yh0J08vc3C306I=;
  b=ifKIbeKz/baAMHd0ZFX5fytumXXcP5KRzpAgeoVyeCPu090ybJh07mZb
   WGa5gG6Ril9pHXq385SZwZAtGu6dViYrvDJGpzNhIGufCtZQfzOxM8Khx
   E38Ehi+eAOfkiz+TuyS6DuUKv2dsn2KwNEHgx7y2xt1qYA9EGhTYT3s8s
   00DMtYZanle7jrizjKbU7Vu63gCnnqXgLpGbehjGUX7W0rmP2AdYdZOUK
   HUrjixJ+8zaCSox2HMuH8yZEic88AWWgyo7DHLbi1CiMt+xIdubsuFXMI
   VY72NIv/qupRgX+OCFRdEe3YRFrETBf/HUl3crXoFT/Thmqdl5A49CPKb
   w==;
X-CSE-ConnectionGUID: 4Yrb4TpOTKSBR9jzknzkBA==
X-CSE-MsgGUID: SWUjxgMoQtuWjA9GPC/46g==
X-IronPort-AV: E=Sophos;i="6.07,158,1708358400"; 
   d="scan'208";a="12423273"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Mar 2024 15:17:24 +0800
IronPort-SDR: OxjDc8QUt+xi9Bv+Bz87UssT3MbScp8mk5ewG3bnT/p1PDTXhmxy5UHXVNnljuDhYUSiHMkV88
 iMOIwZ0EZQ/A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Mar 2024 23:20:28 -0700
IronPort-SDR: FfGD8/6EtQX8e4wbLFYdT/qjbnSrpSvsyGzsWMp1rhmvRlV/JchFq2fxOAB+DhJgRFIJJDzEcb
 wjHp71eILZBA==
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Mar 2024 00:17:21 -0700
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 0/1] Remove support for legacy UFS
Date: Wed, 27 Mar 2024 09:17:12 +0200
Message-ID: <20240327071714.757-1-avri.altman@wdc.com>
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
lives for those platforms. Hence, we can safely remove those pre-UFS2.1
pieces of code.

Changes from v1:
 - remove ufshcd_get_local_unipro_ver which practically mean squashing
   patch 1 & 2 into a single patch (Christoph)
 - restore an if clause to avoid functional change in
   ufshcd_compl_one_cqe (Bart)


Avri Altman (1):
  scsi: ufs: Remove support for old UFSHCI versions

 drivers/ufs/core/ufshcd.c   | 174 +++---------------------------------
 drivers/ufs/host/ufs-qcom.c |   3 +-
 include/ufs/ufshcd.h        |   2 -
 include/ufs/ufshci.h        |   7 --
 4 files changed, 15 insertions(+), 171 deletions(-)

-- 
2.42.0


