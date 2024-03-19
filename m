Return-Path: <linux-kernel+bounces-107083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6F687F75F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931901F22B38
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A3F50A72;
	Tue, 19 Mar 2024 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="gmxL1uYd"
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05861F170;
	Tue, 19 Mar 2024 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829951; cv=none; b=CGYygn46Sm9yPEJkc+b/FfB4S+s0zqetNHe/eb2PlZoXPWaJ1KwqaGJCnIlQb0TKCKBjsB94aKLe71ZpO3yqTXolS7cdt6RTdSmEp/qDm961lQpDXunVKHDXmlXuDyl8Q1slztb4eOTzH4THRwGUeHmqcxDTuXPvPa3LzZi8bbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829951; c=relaxed/simple;
	bh=cXgjOpRTH/Gf/wlA+buzu3DapYAx2JRRGvALX/7RB0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4oYwLtckqEf2Lw1TYpcDSD/+KqJorWFOm+MCBxVTrN1AVhmmjFe+W5o5MIoqQ2UaYZtG6TATBnid25z3gs+7Zt4G59nBH+JhubHVQ82pMWrXwLURb6zBZpRwmpGtDUVQ4qAuCPpdGRGjAUrrAYOpTle/tfZt8E9im6gbZEdVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=gmxL1uYd; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829948; x=1742365948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cXgjOpRTH/Gf/wlA+buzu3DapYAx2JRRGvALX/7RB0k=;
  b=gmxL1uYd+/oA2mcJ77q0Cek3fWUDbmi6EA+ERw6+p+C/rHMjb7Bf/Yx2
   3PfNaSOWMbAQSjZafJDq4HFmlqUF4bndVm5A8v3nUVHmiSKeWu9zMxexl
   QF6HS8sc1/sIXb/JjEjqCeyX6YKQpRFjF9fbyxOEjOAciBajsnISlaT0F
   y48x2MV/XsJw+aDlrABtXHnmLODB5ZtfZfbe10/i5IIdO5K4NBljGbUOq
   hlzo8hys2Glr6QRaj4q32Qs900c9MVs2n3IFYQfD2IAAMwYzGd6Yxz4EY
   XKn/5r0PbcLAGSC4Ig3W2XIjEswv1GaoyRQ7CdP84gYL4m/peafxuKFZw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="140310354"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="140310354"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:25 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 170AF74406;
	Tue, 19 Mar 2024 15:32:23 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 38FF2FD7B4;
	Tue, 19 Mar 2024 15:32:22 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id C8551228901;
	Tue, 19 Mar 2024 15:32:21 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 40D991A006D;
	Tue, 19 Mar 2024 14:32:21 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 05/25] scsi: fcoe: Convert sprintf() family to sysfs_emit() family (part 1)
Date: Tue, 19 Mar 2024 14:31:12 +0800
Message-Id: <20240319063132.1588443-5-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--9.666600-10.000000
X-TMASE-MatchedRID: LFhZ4D3QpawbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/iwxLjNbuPBWO0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/8E5XPQnBzGXq8KsbROd9VTZ3y
	a1EhGxQ6/vNCEa2eMJuuSjDL80UMtMGF0Ua9spp3nlGDzIJIlrrzl8sNiWClKbKItl61J/yZ+in
	TK0bC9eKrauXd3MZDVENTKcqcJOav1crJUg+575oSFJUbkv+osNACfYu+hJ0JM3m/fUGS6q
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

CC: Hannes Reinecke <hare@suse.de>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/scsi/fcoe/fcoe_sysfs.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
index 453665ac6020..46a2f7f0669f 100644
--- a/drivers/scsi/fcoe/fcoe_sysfs.c
+++ b/drivers/scsi/fcoe/fcoe_sysfs.c
@@ -228,7 +228,6 @@ static char *fcf_state_names[] = {
 	[ FCOE_FCF_STATE_CONNECTED ]    = "Connected",
 };
 fcoe_enum_name_search(fcf_state, fcf_state, fcf_state_names)
-#define FCOE_FCF_STATE_MAX_NAMELEN 50
 
 static ssize_t show_fcf_state(struct device *dev,
 			      struct device_attribute *attr,
@@ -239,7 +238,7 @@ static ssize_t show_fcf_state(struct device *dev,
 	name = get_fcoe_fcf_state_name(fcf->state);
 	if (!name)
 		return -EINVAL;
-	return snprintf(buf, FCOE_FCF_STATE_MAX_NAMELEN, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 static FCOE_DEVICE_ATTR(fcf, state, S_IRUGO, show_fcf_state, NULL);
 
@@ -254,8 +253,7 @@ static ssize_t show_ctlr_mode(struct device *dev,
 	name = get_fcoe_ctlr_mode_name(ctlr->mode);
 	if (!name)
 		return -EINVAL;
-	return snprintf(buf, FCOE_MAX_MODENAME_LEN,
-			"%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 
 static ssize_t store_ctlr_mode(struct device *dev,
@@ -345,7 +343,6 @@ static char *ctlr_enabled_state_names[] = {
 };
 fcoe_enum_name_search(ctlr_enabled_state, ctlr_enabled_state,
 		      ctlr_enabled_state_names)
-#define FCOE_CTLR_ENABLED_MAX_NAMELEN 50
 
 static ssize_t show_ctlr_enabled_state(struct device *dev,
 				       struct device_attribute *attr,
@@ -357,8 +354,7 @@ static ssize_t show_ctlr_enabled_state(struct device *dev,
 	name = get_fcoe_ctlr_enabled_state_name(ctlr->enabled);
 	if (!name)
 		return -EINVAL;
-	return snprintf(buf, FCOE_CTLR_ENABLED_MAX_NAMELEN,
-			"%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 
 static FCOE_DEVICE_ATTR(ctlr, enabled, S_IRUGO | S_IWUSR,
@@ -396,7 +392,7 @@ static ssize_t show_ctlr_fip_resp(struct device *dev,
 	struct fcoe_ctlr_device *ctlr = dev_to_ctlr(dev);
 	struct fcoe_ctlr *fip = fcoe_ctlr_device_priv(ctlr);
 
-	return sprintf(buf, "%d\n", fip->fip_resp ? 1 : 0);
+	return sysfs_emit(buf, "%d\n", fip->fip_resp ? 1 : 0);
 }
 
 static FCOE_DEVICE_ATTR(ctlr, fip_vlan_responder, S_IRUGO | S_IWUSR,
@@ -439,7 +435,7 @@ static ssize_t show_ctlr_r_a_tov(struct device *dev,
 	struct fcoe_ctlr_device *ctlr_dev = dev_to_ctlr(dev);
 	struct fcoe_ctlr *ctlr = fcoe_ctlr_device_priv(ctlr_dev);
 
-	return sprintf(buf, "%d\n", ctlr->lp->r_a_tov);
+	return sysfs_emit(buf, "%d\n", ctlr->lp->r_a_tov);
 }
 
 static FCOE_DEVICE_ATTR(ctlr, r_a_tov, S_IRUGO | S_IWUSR,
@@ -466,7 +462,7 @@ static ssize_t show_ctlr_e_d_tov(struct device *dev,
 	struct fcoe_ctlr_device *ctlr_dev = dev_to_ctlr(dev);
 	struct fcoe_ctlr *ctlr = fcoe_ctlr_device_priv(ctlr_dev);
 
-	return sprintf(buf, "%d\n", ctlr->lp->e_d_tov);
+	return sysfs_emit(buf, "%d\n", ctlr->lp->e_d_tov);
 }
 
 static FCOE_DEVICE_ATTR(ctlr, e_d_tov, S_IRUGO | S_IWUSR,
-- 
2.29.2


