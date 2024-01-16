Return-Path: <linux-kernel+bounces-26965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A35AB82E8A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36223B22818
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0B88829;
	Tue, 16 Jan 2024 04:52:28 +0000 (UTC)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892DC125CE;
	Tue, 16 Jan 2024 04:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="134631000"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="134631000"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:21 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 0C1BDC137D;
	Tue, 16 Jan 2024 13:52:19 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3B7C9D52F4;
	Tue, 16 Jan 2024 13:52:18 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id CCBCC6B4C5;
	Tue, 16 Jan 2024 13:52:17 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 7AAEA1A015F;
	Tue, 16 Jan 2024 12:52:17 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Hans de Goede <hdegoede@redhat.com>,
	ilpo.jarvinen@linux.intel.com,
	Vadim Pasternak <vadimp@nvidia.com>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 14/42] drivers/platform/mellanox: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:23 +0800
Message-Id: <20240116045151.3940401-12-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240116045151.3940401-1-lizhijian@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28122.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28122.005
X-TMASE-Result: 10--7.206000-10.000000
X-TMASE-MatchedRID: TWQD+6s80gM4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckAQ9
	n8U23GDfgv3BhO/6LkBM0AWQBBcXdpRSkbxKeJc4rMZ+BqQt2NrBOVz0Jwcxl6vCrG0TnfVUg9x
	e4gtUJtpqw4mhfH/CjxItqQ/criE6KZ+Dt9Ic7YyeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8h+IC
	quNi0WJBwkJXeqvXeEFWInGAuZjE1zt2VIRSn8q3yRTY3oMRcYftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/platform/mellanox/mlxbf-bootctl.c:466:8-16: WARNING: please use sysfs_emit
> ./drivers/platform/mellanox/mlxbf-bootctl.c:584:8-16: WARNING: please use sysfs_emit
> ./drivers/platform/mellanox/mlxbf-bootctl.c:635:8-16: WARNING: please use sysfs_emit
> ./drivers/platform/mellanox/mlxbf-bootctl.c:686:8-16: WARNING: please use sysfs_emit
> ./drivers/platform/mellanox/mlxbf-bootctl.c:737:8-16: WARNING: please use sysfs_emit
> ./drivers/platform/mellanox/mlxbf-bootctl.c:788:8-16: WARNING: please use sysfs_emit
> ./drivers/platform/mellanox/mlxbf-bootctl.c:839:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: Hans de Goede <hdegoede@redhat.com>
CC: ilpo.jarvinen@linux.intel.com
CC: Vadim Pasternak <vadimp@nvidia.com>
CC: platform-driver-x86@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/platform/mellanox/mlxbf-bootctl.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index c1aef3a8fb2d..dd5f370c3168 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.c
+++ b/drivers/platform/mellanox/mlxbf-bootctl.c
@@ -463,7 +463,7 @@ static ssize_t large_icm_show(struct device *dev,
 	if (res.a0)
 		return -EPERM;
 
-	return snprintf(buf, PAGE_SIZE, "0x%lx", res.a1);
+	return sysfs_emit(buf, "0x%lx", res.a1);
 }
 
 static ssize_t large_icm_store(struct device *dev,
@@ -581,7 +581,7 @@ static ssize_t opn_show(struct device *dev,
 	}
 	mutex_unlock(&mfg_ops_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%s", (char *)opn_data);
+	return sysfs_emit(buf, "%s", (char *)opn_data);
 }
 
 static ssize_t opn_store(struct device *dev,
@@ -632,7 +632,7 @@ static ssize_t sku_show(struct device *dev,
 	}
 	mutex_unlock(&mfg_ops_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%s", (char *)sku_data);
+	return sysfs_emit(buf, "%s", (char *)sku_data);
 }
 
 static ssize_t sku_store(struct device *dev,
@@ -683,7 +683,7 @@ static ssize_t modl_show(struct device *dev,
 	}
 	mutex_unlock(&mfg_ops_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%s", (char *)modl_data);
+	return sysfs_emit(buf, "%s", (char *)modl_data);
 }
 
 static ssize_t modl_store(struct device *dev,
@@ -734,7 +734,7 @@ static ssize_t sn_show(struct device *dev,
 	}
 	mutex_unlock(&mfg_ops_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%s", (char *)sn_data);
+	return sysfs_emit(buf, "%s", (char *)sn_data);
 }
 
 static ssize_t sn_store(struct device *dev,
@@ -785,7 +785,7 @@ static ssize_t uuid_show(struct device *dev,
 	}
 	mutex_unlock(&mfg_ops_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%s", (char *)uuid_data);
+	return sysfs_emit(buf, "%s", (char *)uuid_data);
 }
 
 static ssize_t uuid_store(struct device *dev,
@@ -836,7 +836,7 @@ static ssize_t rev_show(struct device *dev,
 	}
 	mutex_unlock(&mfg_ops_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%s", (char *)rev_data);
+	return sysfs_emit(buf, "%s", (char *)rev_data);
 }
 
 static ssize_t rev_store(struct device *dev,
-- 
2.29.2


