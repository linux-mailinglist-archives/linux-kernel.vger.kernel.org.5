Return-Path: <linux-kernel+bounces-107085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B7687F763
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD224B215CF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF82535C2;
	Tue, 19 Mar 2024 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="LY94AJaA"
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2CC2628C;
	Tue, 19 Mar 2024 06:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829952; cv=none; b=KlKTyl6oq8XbRzRCeXsJW5l7lJc+WrKtqU8smVrU8DtmKBcnOcMRJ8+J5WnXF4FqGt9gIxQfFeJB3Tur7gt1XcufmMlpL/Iberk45N2/owPYxpVRtFCMcHv6H/7H5PtlPeKy45K9PGhb/PPFmc9jHlgMioXqqv6szAvCzAsjSrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829952; c=relaxed/simple;
	bh=K2Yido6l2Harc2sExVjNgO4huCImJneSbabgn0YyLvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qJ6itSPQO+nM7GQkNLe5NG2fSWA8xP+pCz6aCHoYufbmOel2oTu0BWfEejHsO+oWNbFQgYAC7Nl0vMQUCLK7AwKNmRbcm6STxT9oxrfspKP2X2MqQ5Oj1KeRkt2gBHxkHFAFps5eqkvyHGKHZt8hE96XwJJRMfhdrmoSpMtvIZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=LY94AJaA; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829950; x=1742365950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K2Yido6l2Harc2sExVjNgO4huCImJneSbabgn0YyLvY=;
  b=LY94AJaA0upSeQmjq9iIlFTV3pGrjgjyvpvgQJ+a/0umtF5IFmPs3GE6
   wrjo4f2F/6hZet+R/S/8jBWYOCm3vwe+wM87udasHoHp5lNhgFlgAzFGr
   7DhAdSCiOMCgqzDnNcdvgQI1i1MnvSjpe+emY2NgtA1dbkyh0fX1sMz5k
   NAtvahHf03OGvQbi4qwCgncqLhSFRe4+objMjQSjsUB11B7aWWcEGCapu
   JazAV5w1kAgmnJqDvrMSR/SSJXL+Xv+439z1UFfqNsbPxjvIQPhaltRtL
   sqiB/2WL7diB008eG4wScDnXZ19o7IYjVuT2TGfxPu40JeKLM3cIRqcBx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="154551200"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="154551200"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:26 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 69CBAD9F04;
	Tue, 19 Mar 2024 15:32:24 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id A77D7D7B90;
	Tue, 19 Mar 2024 15:32:23 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3723C200932DF;
	Tue, 19 Mar 2024 15:32:23 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id BC6771A006B;
	Tue, 19 Mar 2024 14:32:22 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 09/25] scsi: pcmcia: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 14:31:16 +0800
Message-Id: <20240319063132.1588443-9-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240319063132.1588443-1-lizhijian@fujitsu.com>
References: <20240319063132.1588443-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28260.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28260.005
X-TMASE-Result: 10--3.342400-10.000000
X-TMASE-MatchedRID: xt1fvVgCaAwbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/iwxLjNbuPBWO0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/8E5XPQnBzGXq8KsbROd9VSArq
	oIZrVn10Bh0sVevfs+bG2wDyGdkFGR9GF2J2xqMxRFJJyf5BJeZVXUb4KTaXv6C0ePs7A07Z5Vb
	9l0vnaP6BiQH5RE9GykJuPIM8bumHugYxnMUtnsUnf7Nq2zVouDOCaAfFRgnXgv4L5We1m0Rj9j
	9K5jZHac80ZtDh/a4d4qZkKihSdfhpPsVGqnTA8BxCsB8GHr28FEsV4fo4lIJMMP4MGO4TA=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() and scnprintf() will be converted as well if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/scsi/pcmcia/sym53c500_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pcmcia/sym53c500_cs.c b/drivers/scsi/pcmcia/sym53c500_cs.c
index 278c78d066c4..264eeb24b811 100644
--- a/drivers/scsi/pcmcia/sym53c500_cs.c
+++ b/drivers/scsi/pcmcia/sym53c500_cs.c
@@ -624,7 +624,7 @@ SYM53C500_show_pio(struct device *dev, struct device_attribute *attr,
 	struct sym53c500_data *data =
 	    (struct sym53c500_data *)SHp->hostdata;
 
-	return snprintf(buf, 4, "%d\n", data->fast_pio);
+	return sysfs_emit(buf, "%d\n", data->fast_pio);
 }
 
 static ssize_t
-- 
2.29.2


