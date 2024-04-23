Return-Path: <linux-kernel+bounces-155870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD4D8AF83D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CEDF1C23BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547EF14533E;
	Tue, 23 Apr 2024 20:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IvvqVXpw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40B0143C4C;
	Tue, 23 Apr 2024 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905189; cv=none; b=u44C9bUj5SHI+QP08AsmitWmMTJLPZkcPT+jSl6Q8XnuPuZtfLBpjY1Qe6vr2gEjMgWaaF/JqmlYXLpccbGC8obaovQ+P7WaJOtptfBkoaN0xBIDNhQqSUg7I++Smsy1wIcdCxGgV1D1pyxQFhtlziJUV9a3U5vWTCPfpxSryl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905189; c=relaxed/simple;
	bh=x7LTlF5XkLbTPTT1wT/DnKTwiuY41wSfOL0aEEgXqxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DK5beLnm4cBzlVxHVM/MOf4OJZ2suJRV4cHLy43f379ViLt/kZAx27+p8DN3jAQoPHzbA5p59aDX8MfQWfzfCIaveYW+0Lo6d2gXkJLg1EiTXc4QEVGRlmn5235bscuF11II4l+dye46PqIRrXsFn86hUfItzfrRe+q8lMGzxwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IvvqVXpw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713905188; x=1745441188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x7LTlF5XkLbTPTT1wT/DnKTwiuY41wSfOL0aEEgXqxE=;
  b=IvvqVXpwNo4QFTUHJmSEXGokRuTeB8b7vf4eC5xgZIoFF9+TDasYGe7g
   flPaZhy5v1F6XIyecfucFUqrJOrDJjbtABtb/0wyg3lueJSF1rLbhgHa8
   oORTddTbzqfQzWE8tErr558wCOMzSwOSYS4R6hln8oodlVv8M29MO88Q7
   ron8L4hopludB9C7KqUXjGysjryGlsCAP6LUS4GlJGuHTqnzsHhcJGNIw
   k5JrbVmtOr7k8BQ3fIaahYZhPJfUFJSbVtgqZbZLCBITqYtFVpi/Zq9ic
   ciSStCTv7sHI22k9b2LjFsQJCeJ6iveyYMKH+OZUDmzbyFeW3bAcsemUo
   Q==;
X-CSE-ConnectionGUID: 10NWzpjLR6yABYBpXLY49A==
X-CSE-MsgGUID: ucVDkt9bR7+/7cko9OL10A==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="34912330"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="34912330"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:46:24 -0700
X-CSE-ConnectionGUID: 6A3/4SgjQL+r/3VERidikg==
X-CSE-MsgGUID: fCJlomLeSq+XcAmYs9BQKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24533090"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa010.fm.intel.com with ESMTP; 23 Apr 2024 13:46:24 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 07/10] platform/x86: ISST: Support partitioned systems
Date: Tue, 23 Apr 2024 13:46:16 -0700
Message-Id: <20240423204619.3946901-8-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240423204619.3946901-1-srinivas.pandruvada@linux.intel.com>
References: <20240423204619.3946901-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A partitioned system has two different PCI VSEC devices per package.
A non-partitioned device has only one PCI VSEC device per package.
The current implementation only supports non partitioned systems.

Each partition maps a set of power domains. Other than reading from
different MMIO regions, there is no change in the SST functionality.
The scope of SST control is still per power domain. Hence user space
does not need to be aware of existence of partitions.

With partitions, existing per package information defined using struct
tpmi_sst_struct is enhanced to store information for both partitions. A
mapping function map_partition_power_domain_id() is introduced, which
maps to correct partition and index. This mapping function is called
in get_instance() and isst_if_clos_assoc(), before indexing into
tpmi_sst_struct->power_domain_info[].

The TPMI core platform info provides partition id and compute die ID
mask for each partition. Use this information to order power domains,
so that compute dies are presented before IO dies to match hardware
defined compute die ID for each CPU.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 .../intel/speed_select_if/isst_tpmi_core.c    | 299 ++++++++++++++++--
 1 file changed, 267 insertions(+), 32 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 49d573fcbd72..b8da6847622b 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -23,6 +23,7 @@
 #include <linux/fs.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <uapi/linux/isst_if.h>
 
@@ -263,20 +264,33 @@ struct tpmi_per_power_domain_info {
 	bool write_blocked;
 };
 
+/* Supported maximum partitions */
+#define SST_MAX_PARTITIONS	2
+
 /**
  * struct tpmi_sst_struct -	Store sst info for a package
  * @package_id:			Package id for this aux device instance
  * @number_of_power_domains:	Number of power_domains pointed by power_domain_info pointer
  * @power_domain_info:		Pointer to power domains information
+ * @cdie_mask:			Mask of compute dies present in a partition from hardware.
+ *				This mask is not present in the version 1 information header.
+ * @io_dies:			Number of IO dies in a partition. This will be 0 for TPMI
+ *				version 1 information header.
+ * @partition_mask:		Mask of all partitions.
+ * @partition_mask_current:	Current partition mask as some may have been unbound.
  *
  * This structure is used store full SST information for a package.
- * Each package has a unique OOB PCI device, which enumerates TPMI.
- * Each Package will have multiple power_domains.
+ * Each package has one or multiple OOB PCI devices. Each package can contain multiple
+ * power domains.
  */
 struct tpmi_sst_struct {
 	int package_id;
-	int number_of_power_domains;
-	struct tpmi_per_power_domain_info *power_domain_info;
+	struct tpmi_per_power_domain_info *power_domain_info[SST_MAX_PARTITIONS];
+	u16 cdie_mask[SST_MAX_PARTITIONS];
+	u8 number_of_power_domains[SST_MAX_PARTITIONS];
+	u8 io_dies[SST_MAX_PARTITIONS];
+	u8 partition_mask;
+	u8 partition_mask_current;
 };
 
 /**
@@ -387,6 +401,126 @@ static int sst_main(struct auxiliary_device *auxdev, struct tpmi_per_power_domai
 	return 0;
 }
 
+static u8 isst_instance_count(struct tpmi_sst_struct *sst_inst)
+{
+	u8 i, max_part, count = 0;
+
+	/* Partition mask starts from bit 0 and contains 1s only */
+	max_part = hweight8(sst_inst->partition_mask);
+	for (i = 0; i < max_part; i++)
+		count += sst_inst->number_of_power_domains[i];
+
+	return count;
+}
+
+/**
+ * map_cdies() - Map user domain ID to compute domain ID
+ * @sst_inst: TPMI Instance
+ * @id: User domain ID
+ * @partition: Resolved partition
+ *
+ * Helper function to map_partition_power_domain_id() to resolve compute
+ * domain ID and partition. Use hardware provided cdie_mask for a partition
+ * as is to resolve a compute domain ID.
+ *
+ * Return: %-EINVAL on error, otherwise mapped domain ID >= 0.
+ */
+static int map_cdies(struct tpmi_sst_struct *sst_inst, u8 id, u8 *partition)
+{
+	u8 i, max_part;
+
+	max_part = hweight8(sst_inst->partition_mask);
+	for (i = 0; i < max_part; i++) {
+		if (!(sst_inst->cdie_mask[i] & BIT(id)))
+			continue;
+
+		*partition = i;
+		return id - ffs(sst_inst->cdie_mask[i]) + 1;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * map_partition_power_domain_id() - Map user domain ID to partition domain ID
+ * @sst_inst: TPMI Instance
+ * @id: User domain ID
+ * @partition: Resolved partition
+ *
+ * In a partitioned system a CPU package has two separate MMIO ranges (Under
+ * two PCI devices). But the CPU package compute die/power domain IDs are
+ * unique in a package. User space can get compute die/power domain ID from
+ * CPUID and MSR 0x54 for a CPU. So, those IDs need to be preserved even if
+ * they are present in two different partitions with its own order.
+ *
+ * For example for command ISST_IF_COUNT_TPMI_INSTANCES, the valid_mask
+ * is 111111b for a 4 compute and 2 IO dies system. This is presented as
+ * provided by the hardware in a non-partitioned system with the following
+ * order:
+ *	I1-I0-C3-C2-C1-C0
+ * Here: "C": for compute and "I" for IO die.
+ * Compute dies are always present first in TPMI instances, as they have
+ * to map to the real power domain/die ID of a system. In a non-partitioned
+ * system there is no way to identify compute and IO die boundaries from
+ * this driver without reading each CPU's mapping.
+ *
+ * The same order needs to be preserved, even if those compute dies are
+ * distributed among multiple partitions. For example:
+ * Partition 1 can contain: I1-C1-C0
+ * Partition 2 can contain: I2-C3-C2
+ *
+ * This will require a conversion of user space IDs to the actual index into
+ * array of stored power domains for each partition. For the above example
+ * this function will return partition and index as follows:
+ *
+ * =============	=========	=====	========
+ * User space ID	Partition	Index	Die type
+ * =============	=========	=====	========
+ * 0			0		0	Compute
+ * 1			0		1	Compute
+ * 2			1		0	Compute
+ * 3			1		1	Compute
+ * 4			0		2	IO
+ * 5			1		2	IO
+ * =============	=========	=====	========
+ *
+ * Return: %-EINVAL on error, otherwise mapped domain ID >= 0.
+ */
+static int map_partition_power_domain_id(struct tpmi_sst_struct *sst_inst, u8 id, u8 *partition)
+{
+	u8 i, io_start_id, max_part;
+
+	*partition = 0;
+
+	/* If any PCI device for partition is unbound, treat this as failure */
+	if (sst_inst->partition_mask != sst_inst->partition_mask_current)
+		return -EINVAL;
+
+	max_part = hweight8(sst_inst->partition_mask);
+
+	/* IO Index begin here */
+	io_start_id = fls(sst_inst->cdie_mask[max_part - 1]);
+
+	if (id < io_start_id)
+		return map_cdies(sst_inst, id, partition);
+
+	for (i = 0; i < max_part; i++) {
+		u8 io_id;
+
+		io_id = id - io_start_id;
+		if (io_id < sst_inst->io_dies[i]) {
+			u8 cdie_range;
+
+			cdie_range = fls(sst_inst->cdie_mask[i]) - ffs(sst_inst->cdie_mask[i]) + 1;
+			*partition = i;
+			return cdie_range + io_id;
+		}
+		io_start_id += sst_inst->io_dies[i];
+	}
+
+	return -EINVAL;
+}
+
 /*
  * Map a package and power_domain id to SST information structure unique for a power_domain.
  * The caller should call under isst_tpmi_dev_lock.
@@ -395,6 +529,7 @@ static struct tpmi_per_power_domain_info *get_instance(int pkg_id, int power_dom
 {
 	struct tpmi_per_power_domain_info *power_domain_info;
 	struct tpmi_sst_struct *sst_inst;
+	u8 part;
 
 	if (pkg_id < 0 || pkg_id > isst_common.max_index ||
 	    pkg_id >= topology_max_packages())
@@ -404,10 +539,11 @@ static struct tpmi_per_power_domain_info *get_instance(int pkg_id, int power_dom
 	if (!sst_inst)
 		return NULL;
 
-	if (power_domain_id < 0 || power_domain_id >= sst_inst->number_of_power_domains)
+	power_domain_id = map_partition_power_domain_id(sst_inst, power_domain_id, &part);
+	if (power_domain_id < 0)
 		return NULL;
 
-	power_domain_info = &sst_inst->power_domain_info[power_domain_id];
+	power_domain_info = &sst_inst->power_domain_info[part][power_domain_id];
 
 	if (power_domain_info && !power_domain_info->sst_base)
 		return NULL;
@@ -579,6 +715,7 @@ static long isst_if_clos_assoc(void __user *argp)
 		struct tpmi_sst_struct *sst_inst;
 		int offset, shift, cpu;
 		u64 val, mask, clos;
+		u8 part;
 
 		if (copy_from_user(&clos_assoc, ptr, sizeof(clos_assoc)))
 			return -EFAULT;
@@ -602,10 +739,11 @@ static long isst_if_clos_assoc(void __user *argp)
 
 		sst_inst = isst_common.sst_inst[pkg_id];
 
-		if (clos_assoc.power_domain_id > sst_inst->number_of_power_domains)
+		punit_id = map_partition_power_domain_id(sst_inst, punit_id, &part);
+		if (punit_id < 0)
 			return -EINVAL;
 
-		power_domain_info = &sst_inst->power_domain_info[punit_id];
+		power_domain_info = &sst_inst->power_domain_info[part][punit_id];
 
 		if (assoc_cmds.get_set && power_domain_info->write_blocked)
 			return -EPERM;
@@ -1134,18 +1272,28 @@ static int isst_if_get_tpmi_instance_count(void __user *argp)
 	if (tpmi_inst.socket_id >= topology_max_packages())
 		return -EINVAL;
 
-	tpmi_inst.count = isst_common.sst_inst[tpmi_inst.socket_id]->number_of_power_domains;
-
 	sst_inst = isst_common.sst_inst[tpmi_inst.socket_id];
+
+	tpmi_inst.count = isst_instance_count(sst_inst);
+
 	tpmi_inst.valid_mask = 0;
-	for (i = 0; i < sst_inst->number_of_power_domains; ++i) {
+	for (i = 0; i < tpmi_inst.count; i++) {
 		struct tpmi_per_power_domain_info *pd_info;
+		u8 part;
+		int pd;
+
+		pd = map_partition_power_domain_id(sst_inst, i, &part);
+		if (pd < 0)
+			continue;
 
-		pd_info = &sst_inst->power_domain_info[i];
+		pd_info = &sst_inst->power_domain_info[part][pd];
 		if (pd_info->sst_base)
 			tpmi_inst.valid_mask |= BIT(i);
 	}
 
+	if (!tpmi_inst.valid_mask)
+		tpmi_inst.count = 0;
+
 	if (copy_to_user(argp, &tpmi_inst, sizeof(tpmi_inst)))
 		return -EFAULT;
 
@@ -1276,8 +1424,11 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 	struct intel_tpmi_plat_info *plat_info;
 	struct device *dev = &auxdev->dev;
 	struct tpmi_sst_struct *tpmi_sst;
-	int i, ret, pkg = 0, inst = 0;
-	int num_resources;
+	u8 i, num_resources, io_die_cnt;
+	int ret, pkg = 0, inst = 0;
+	bool first_enum = false;
+	u16 cdie_mask;
+	u8 partition;
 
 	ret = tpmi_get_feature_status(auxdev, TPMI_ID_SST, &read_blocked, &write_blocked);
 	if (ret)
@@ -1300,21 +1451,59 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 		return -EINVAL;
 	}
 
-	if (isst_common.sst_inst[pkg])
-		return -EEXIST;
+	partition = plat_info->partition;
+	if (partition >= SST_MAX_PARTITIONS) {
+		dev_err(&auxdev->dev, "Invalid partition :%x\n", partition);
+		return -EINVAL;
+	}
 
 	num_resources = tpmi_get_resource_count(auxdev);
 
 	if (!num_resources)
 		return -EINVAL;
 
-	tpmi_sst = devm_kzalloc(dev, sizeof(*tpmi_sst), GFP_KERNEL);
-	if (!tpmi_sst)
-		return -ENOMEM;
+	mutex_lock(&isst_tpmi_dev_lock);
+
+	if (isst_common.sst_inst[pkg]) {
+		tpmi_sst = isst_common.sst_inst[pkg];
+	} else {
+		/*
+		 * tpmi_sst instance is for a package. So needs to be
+		 * allocated only once for both partitions. We can't use
+		 * devm_* allocation here as each partition is a
+		 * different device, which can be unbound.
+		 */
+		tpmi_sst = kzalloc(sizeof(*tpmi_sst), GFP_KERNEL);
+		if (!tpmi_sst) {
+			ret = -ENOMEM;
+			goto unlock_exit;
+		}
+		first_enum = true;
+	}
+
+	ret = 0;
 
 	pd_info = devm_kcalloc(dev, num_resources, sizeof(*pd_info), GFP_KERNEL);
-	if (!pd_info)
-		return -ENOMEM;
+	if (!pd_info) {
+		ret = -ENOMEM;
+		goto unlock_free;
+	}
+
+	/* Get the IO die count, if cdie_mask is present */
+	if (plat_info->cdie_mask) {
+		u8 cdie_range;
+
+		cdie_mask = plat_info->cdie_mask;
+		cdie_range = fls(cdie_mask) - ffs(cdie_mask) + 1;
+		io_die_cnt = num_resources - cdie_range;
+	} else {
+		/*
+		 * This is a synthetic mask, careful when assuming that
+		 * they are compute dies only.
+		 */
+		cdie_mask = (1 << num_resources) - 1;
+		io_die_cnt = 0;
+	}
 
 	for (i = 0; i < num_resources; ++i) {
 		struct resource *res;
@@ -1330,11 +1519,20 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 		pd_info[i].auxdev = auxdev;
 		pd_info[i].write_blocked = write_blocked;
 		pd_info[i].sst_base = devm_ioremap_resource(dev, res);
-		if (IS_ERR(pd_info[i].sst_base))
-			return PTR_ERR(pd_info[i].sst_base);
+		if (IS_ERR(pd_info[i].sst_base)) {
+			ret = PTR_ERR(pd_info[i].sst_base);
+			goto unlock_free;
+		}
 
 		ret = sst_main(auxdev, &pd_info[i]);
 		if (ret) {
+			/*
+			 * This entry is not valid, hardware can partially
+			 * populate dies. In this case MMIO will have 0xFFs.
+			 * Also possible some pre-production hardware has
+			 * invalid data. But don't fail and continue to use
+			 * other dies with valid data.
+			 */
 			devm_iounmap(dev, pd_info[i].sst_base);
 			pd_info[i].sst_base = NULL;
 			continue;
@@ -1343,30 +1541,53 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 		++inst;
 	}
 
-	if (!inst)
-		return -ENODEV;
+	if (!inst) {
+		ret = -ENODEV;
+		goto unlock_free;
+	}
 
 	tpmi_sst->package_id = pkg;
-	tpmi_sst->power_domain_info = pd_info;
-	tpmi_sst->number_of_power_domains = num_resources;
+
+	tpmi_sst->power_domain_info[partition] = pd_info;
+	tpmi_sst->number_of_power_domains[partition] = num_resources;
+	tpmi_sst->cdie_mask[partition] = cdie_mask;
+	tpmi_sst->io_dies[partition] = io_die_cnt;
+	tpmi_sst->partition_mask |= BIT(partition);
+	tpmi_sst->partition_mask_current |= BIT(partition);
+
 	auxiliary_set_drvdata(auxdev, tpmi_sst);
 
-	mutex_lock(&isst_tpmi_dev_lock);
 	if (isst_common.max_index < pkg)
 		isst_common.max_index = pkg;
 	isst_common.sst_inst[pkg] = tpmi_sst;
+
+unlock_free:
+	if (ret && first_enum)
+		kfree(tpmi_sst);
+unlock_exit:
 	mutex_unlock(&isst_tpmi_dev_lock);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_add, INTEL_TPMI_SST);
 
 void tpmi_sst_dev_remove(struct auxiliary_device *auxdev)
 {
 	struct tpmi_sst_struct *tpmi_sst = auxiliary_get_drvdata(auxdev);
+	struct intel_tpmi_plat_info *plat_info;
+
+	plat_info = tpmi_get_platform_data(auxdev);
+	if (!plat_info)
+		return;
 
 	mutex_lock(&isst_tpmi_dev_lock);
-	isst_common.sst_inst[tpmi_sst->package_id] = NULL;
+	tpmi_sst->power_domain_info[plat_info->partition] = NULL;
+	tpmi_sst->partition_mask_current &= ~BIT(plat_info->partition);
+	/* Free the package instance when the all partitions are removed */
+	if (!tpmi_sst->partition_mask_current) {
+		kfree(tpmi_sst);
+		isst_common.sst_inst[tpmi_sst->package_id] = NULL;
+	}
 	mutex_unlock(&isst_tpmi_dev_lock);
 }
 EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_remove, INTEL_TPMI_SST);
@@ -1374,9 +1595,16 @@ EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_remove, INTEL_TPMI_SST);
 void tpmi_sst_dev_suspend(struct auxiliary_device *auxdev)
 {
 	struct tpmi_sst_struct *tpmi_sst = auxiliary_get_drvdata(auxdev);
-	struct tpmi_per_power_domain_info *power_domain_info = tpmi_sst->power_domain_info;
+	struct tpmi_per_power_domain_info *power_domain_info;
+	struct intel_tpmi_plat_info *plat_info;
 	void __iomem *cp_base;
 
+	plat_info = tpmi_get_platform_data(auxdev);
+	if (!plat_info)
+		return;
+
+	power_domain_info = tpmi_sst->power_domain_info[plat_info->partition];
+
 	cp_base = power_domain_info->sst_base + power_domain_info->sst_header.cp_offset;
 	power_domain_info->saved_sst_cp_control = readq(cp_base + SST_CP_CONTROL_OFFSET);
 
@@ -1395,9 +1623,16 @@ EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_suspend, INTEL_TPMI_SST);
 void tpmi_sst_dev_resume(struct auxiliary_device *auxdev)
 {
 	struct tpmi_sst_struct *tpmi_sst = auxiliary_get_drvdata(auxdev);
-	struct tpmi_per_power_domain_info *power_domain_info = tpmi_sst->power_domain_info;
+	struct tpmi_per_power_domain_info *power_domain_info;
+	struct intel_tpmi_plat_info *plat_info;
 	void __iomem *cp_base;
 
+	plat_info = tpmi_get_platform_data(auxdev);
+	if (!plat_info)
+		return;
+
+	power_domain_info = tpmi_sst->power_domain_info[plat_info->partition];
+
 	cp_base = power_domain_info->sst_base + power_domain_info->sst_header.cp_offset;
 	writeq(power_domain_info->saved_sst_cp_control, cp_base + SST_CP_CONTROL_OFFSET);
 
-- 
2.40.1


