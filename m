Return-Path: <linux-kernel+bounces-103002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE1E87B9A1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C98B1F2122F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E3F6CDCE;
	Thu, 14 Mar 2024 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="nwYqSfSr"
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E38B6CDA9;
	Thu, 14 Mar 2024 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406076; cv=none; b=fbWvrknfV4bcb47TUFl80mG462/FxmHUCp+CKARwSHSXTFSK4kfxo3BvZXdTmzvWlHx1mVrpITiYx6PbQHRym56klgNXSs1Hk1arOAv1P8h/8y0KwrmLuRnfE5E5RJr15+CrhoePd28KxUQJQG8COUE4hCMhywcs0CwCpghqe10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406076; c=relaxed/simple;
	bh=wAcO1IpntOHEdG0AKWa5VqlvhorvUSXFJzyhOp2iimw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H9ApcPkDqO4ZVfA10KAzLfdhbj9GNnHzG6/gLv0kabaZ8iESzpiSMliUuGw334pYijDJgqimE48CY6l9Ta7xFzNuv8H7MmxE3j3Ng/Bkymo9Jm2JO5Hdr6F+Bg6C0UYnkgR96gej0d8ukbC+aUOxp3XPBKzmq25f5TvmOjiPkGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=nwYqSfSr; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710406075; x=1741942075;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wAcO1IpntOHEdG0AKWa5VqlvhorvUSXFJzyhOp2iimw=;
  b=nwYqSfSr7L9MBySRKr9DmSH3sCZpMCVa8MP0w88d5MXZ/6YE4slCyBrQ
   v+lRNDHkIFTOTZvSxiNunNP4F4CJxh6CxcIiJnWBkfuhoh4JZXQtp5czC
   rTl4EKn8PRUSeGx+lDA6i05oIeXYvkXEHBklag226SxCj0fosSDrJe7wY
   8zFAAaOCfabEWwH3T0uqs5suxOZNUrKTNdvCWCTQ9k7iXmx3cSrgZldNr
   lwThibUPbqjXCrAgb7ZUouXaNMDYyIBAt6RaXIyjAjU+0NyHSkJMkp2Ry
   NTP1atEmqqUzJf3irsi6xxP7FhzwO5PNlgm29OWj0LLfMyxcdLWTjpznA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="152123706"
X-IronPort-AV: E=Sophos;i="6.07,124,1708354800"; 
   d="scan'208";a="152123706"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 17:46:41 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id E09BC2326A;
	Thu, 14 Mar 2024 17:46:38 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1DB0DF7D7;
	Thu, 14 Mar 2024 17:46:38 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9928E20098E08;
	Thu, 14 Mar 2024 17:46:37 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id C007B1A006B;
	Thu, 14 Mar 2024 16:46:36 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org
Subject: [PATCH] EDAC/mc_sysfs: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 16:46:28 +0800
Message-Id: <20240314084628.1322006-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28250.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28250.005
X-TMASE-Result: 10--7.234800-10.000000
X-TMASE-MatchedRID: z2BzWfwZiWs4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbSfc0UG4EkZrGIkRP7M27eX2O0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/8E5XPQnBzGXq8KsbROd9VSArq
	oIZrVn15fzUkBpc072FUpxEqvctVLs7aQkqkpFyrnHu4BcYSmtojQrbrPpzzrHwEnu5JwrbSyOx
	jnKDQBj1ZfxqqVrxASdqC2fLtk9xB8TzIzimOwPC24oEZ6SpSkj80Za3RRg8L9X8I9jdNOBfSW6
	ADVA5GG+DOGK/b5ZKEbh6KkT6LGlzruA0Aqz72g=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() will be converted as weel if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

CC: Borislav Petkov <bp@alien8.de>
CC: Tony Luck <tony.luck@intel.com>
CC: James Morse <james.morse@arm.com>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Robert Richter <rric@kernel.org>
CC: linux-edac@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/edac/edac_mc_sysfs.c | 48 ++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 5116873c3330..5820b6c4da18 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -146,7 +146,7 @@ static ssize_t csrow_ue_count_show(struct device *dev,
 {
 	struct csrow_info *csrow = to_csrow(dev);
 
-	return sprintf(data, "%u\n", csrow->ue_count);
+	return sysfs_emit(data, "%u\n", csrow->ue_count);
 }
 
 static ssize_t csrow_ce_count_show(struct device *dev,
@@ -154,7 +154,7 @@ static ssize_t csrow_ce_count_show(struct device *dev,
 {
 	struct csrow_info *csrow = to_csrow(dev);
 
-	return sprintf(data, "%u\n", csrow->ce_count);
+	return sysfs_emit(data, "%u\n", csrow->ce_count);
 }
 
 static ssize_t csrow_size_show(struct device *dev,
@@ -166,7 +166,7 @@ static ssize_t csrow_size_show(struct device *dev,
 
 	for (i = 0; i < csrow->nr_channels; i++)
 		nr_pages += csrow->channels[i]->dimm->nr_pages;
-	return sprintf(data, "%u\n", PAGES_TO_MiB(nr_pages));
+	return sysfs_emit(data, "%u\n", PAGES_TO_MiB(nr_pages));
 }
 
 static ssize_t csrow_mem_type_show(struct device *dev,
@@ -174,7 +174,7 @@ static ssize_t csrow_mem_type_show(struct device *dev,
 {
 	struct csrow_info *csrow = to_csrow(dev);
 
-	return sprintf(data, "%s\n", edac_mem_types[csrow->channels[0]->dimm->mtype]);
+	return sysfs_emit(data, "%s\n", edac_mem_types[csrow->channels[0]->dimm->mtype]);
 }
 
 static ssize_t csrow_dev_type_show(struct device *dev,
@@ -182,7 +182,7 @@ static ssize_t csrow_dev_type_show(struct device *dev,
 {
 	struct csrow_info *csrow = to_csrow(dev);
 
-	return sprintf(data, "%s\n", dev_types[csrow->channels[0]->dimm->dtype]);
+	return sysfs_emit(data, "%s\n", dev_types[csrow->channels[0]->dimm->dtype]);
 }
 
 static ssize_t csrow_edac_mode_show(struct device *dev,
@@ -191,7 +191,7 @@ static ssize_t csrow_edac_mode_show(struct device *dev,
 {
 	struct csrow_info *csrow = to_csrow(dev);
 
-	return sprintf(data, "%s\n", edac_caps[csrow->channels[0]->dimm->edac_mode]);
+	return sysfs_emit(data, "%s\n", edac_caps[csrow->channels[0]->dimm->edac_mode]);
 }
 
 /* show/store functions for DIMM Label attributes */
@@ -207,8 +207,8 @@ static ssize_t channel_dimm_label_show(struct device *dev,
 	if (!rank->dimm->label[0])
 		return 0;
 
-	return snprintf(data, sizeof(rank->dimm->label) + 1, "%s\n",
-			rank->dimm->label);
+	return sysfs_emit(data, "%s\n",
+			  rank->dimm->label);
 }
 
 static ssize_t channel_dimm_label_store(struct device *dev,
@@ -243,7 +243,7 @@ static ssize_t channel_ce_count_show(struct device *dev,
 	unsigned int chan = to_channel(mattr);
 	struct rank_info *rank = csrow->channels[chan];
 
-	return sprintf(data, "%u\n", rank->ce_count);
+	return sysfs_emit(data, "%u\n", rank->ce_count);
 }
 
 /* cwrow<id>/attribute files */
@@ -515,7 +515,7 @@ static ssize_t dimmdev_label_show(struct device *dev,
 	if (!dimm->label[0])
 		return 0;
 
-	return snprintf(data, sizeof(dimm->label) + 1, "%s\n", dimm->label);
+	return sysfs_emit(data, "%s\n", dimm->label);
 }
 
 static ssize_t dimmdev_label_store(struct device *dev,
@@ -546,7 +546,7 @@ static ssize_t dimmdev_size_show(struct device *dev,
 {
 	struct dimm_info *dimm = to_dimm(dev);
 
-	return sprintf(data, "%u\n", PAGES_TO_MiB(dimm->nr_pages));
+	return sysfs_emit(data, "%u\n", PAGES_TO_MiB(dimm->nr_pages));
 }
 
 static ssize_t dimmdev_mem_type_show(struct device *dev,
@@ -554,7 +554,7 @@ static ssize_t dimmdev_mem_type_show(struct device *dev,
 {
 	struct dimm_info *dimm = to_dimm(dev);
 
-	return sprintf(data, "%s\n", edac_mem_types[dimm->mtype]);
+	return sysfs_emit(data, "%s\n", edac_mem_types[dimm->mtype]);
 }
 
 static ssize_t dimmdev_dev_type_show(struct device *dev,
@@ -562,7 +562,7 @@ static ssize_t dimmdev_dev_type_show(struct device *dev,
 {
 	struct dimm_info *dimm = to_dimm(dev);
 
-	return sprintf(data, "%s\n", dev_types[dimm->dtype]);
+	return sysfs_emit(data, "%s\n", dev_types[dimm->dtype]);
 }
 
 static ssize_t dimmdev_edac_mode_show(struct device *dev,
@@ -571,7 +571,7 @@ static ssize_t dimmdev_edac_mode_show(struct device *dev,
 {
 	struct dimm_info *dimm = to_dimm(dev);
 
-	return sprintf(data, "%s\n", edac_caps[dimm->edac_mode]);
+	return sysfs_emit(data, "%s\n", edac_caps[dimm->edac_mode]);
 }
 
 static ssize_t dimmdev_ce_count_show(struct device *dev,
@@ -580,7 +580,7 @@ static ssize_t dimmdev_ce_count_show(struct device *dev,
 {
 	struct dimm_info *dimm = to_dimm(dev);
 
-	return sprintf(data, "%u\n", dimm->ce_count);
+	return sysfs_emit(data, "%u\n", dimm->ce_count);
 }
 
 static ssize_t dimmdev_ue_count_show(struct device *dev,
@@ -589,7 +589,7 @@ static ssize_t dimmdev_ue_count_show(struct device *dev,
 {
 	struct dimm_info *dimm = to_dimm(dev);
 
-	return sprintf(data, "%u\n", dimm->ue_count);
+	return sysfs_emit(data, "%u\n", dimm->ue_count);
 }
 
 /* dimm/rank attribute files */
@@ -758,7 +758,7 @@ static ssize_t mci_sdram_scrub_rate_show(struct device *dev,
 		return bandwidth;
 	}
 
-	return sprintf(data, "%d\n", bandwidth);
+	return sysfs_emit(data, "%d\n", bandwidth);
 }
 
 /* default attribute files for the MCI object */
@@ -768,7 +768,7 @@ static ssize_t mci_ue_count_show(struct device *dev,
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 
-	return sprintf(data, "%u\n", mci->ue_mc);
+	return sysfs_emit(data, "%u\n", mci->ue_mc);
 }
 
 static ssize_t mci_ce_count_show(struct device *dev,
@@ -777,7 +777,7 @@ static ssize_t mci_ce_count_show(struct device *dev,
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 
-	return sprintf(data, "%u\n", mci->ce_mc);
+	return sysfs_emit(data, "%u\n", mci->ce_mc);
 }
 
 static ssize_t mci_ce_noinfo_show(struct device *dev,
@@ -786,7 +786,7 @@ static ssize_t mci_ce_noinfo_show(struct device *dev,
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 
-	return sprintf(data, "%u\n", mci->ce_noinfo_count);
+	return sysfs_emit(data, "%u\n", mci->ce_noinfo_count);
 }
 
 static ssize_t mci_ue_noinfo_show(struct device *dev,
@@ -795,7 +795,7 @@ static ssize_t mci_ue_noinfo_show(struct device *dev,
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 
-	return sprintf(data, "%u\n", mci->ue_noinfo_count);
+	return sysfs_emit(data, "%u\n", mci->ue_noinfo_count);
 }
 
 static ssize_t mci_seconds_show(struct device *dev,
@@ -804,7 +804,7 @@ static ssize_t mci_seconds_show(struct device *dev,
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 
-	return sprintf(data, "%ld\n", (jiffies - mci->start_time) / HZ);
+	return sysfs_emit(data, "%ld\n", (jiffies - mci->start_time) / HZ);
 }
 
 static ssize_t mci_ctl_name_show(struct device *dev,
@@ -813,7 +813,7 @@ static ssize_t mci_ctl_name_show(struct device *dev,
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 
-	return sprintf(data, "%s\n", mci->ctl_name);
+	return sysfs_emit(data, "%s\n", mci->ctl_name);
 }
 
 static ssize_t mci_size_mb_show(struct device *dev,
@@ -833,7 +833,7 @@ static ssize_t mci_size_mb_show(struct device *dev,
 		}
 	}
 
-	return sprintf(data, "%u\n", PAGES_TO_MiB(total_pages));
+	return sysfs_emit(data, "%u\n", PAGES_TO_MiB(total_pages));
 }
 
 static ssize_t mci_max_location_show(struct device *dev,
-- 
2.29.2


