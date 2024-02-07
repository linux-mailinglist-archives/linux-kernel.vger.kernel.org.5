Return-Path: <linux-kernel+bounces-57290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF03F84D678
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4985D1F227AE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E7B2030D;
	Wed,  7 Feb 2024 23:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drqnRRuc"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5C11EB23;
	Wed,  7 Feb 2024 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707347082; cv=none; b=taVBRBoLwuypCtRMV0n3jSLWixWfeM8/XpGgVRdlLgTHtIjTTRWv8nzWnqrEfUqCLTXg54LJAeaBVyjtg/V4bGZtaFYbfJcRkeSftmnqmXm2fXDoldbI4NraezruVIbqQj8bwviZRl8gv2LlyKZ7iHhVcZr1EKMmSVRetY6Y4i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707347082; c=relaxed/simple;
	bh=zD6RvdgIAbvhbVK956VN9vdAKdMHzQfYK+RR/ObYl/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lsfJ0n0oOWJp4AqdMI/Q5Wv28pEvPENfFbsQ8ABH9QRQZ3KVEKXiYGM954qpkGpJv0xA+rzHiOwOCfpHW4JC74+1WRhLSCdC0KoWEw+fUsuiN7zrx1ztKHw3ZMvb3tLwhGn6xaUEU/Xib1H7kdeIT9ViGxEO3ONzOZaqKuAPo1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drqnRRuc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d911c2103aso7972305ad.0;
        Wed, 07 Feb 2024 15:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707347080; x=1707951880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7aLthinSDbfqOxm/qwgXXi45DFGsKwn+jlZHtBC4Jjo=;
        b=drqnRRucUlhu8dYNt/fXTZCU9HkmUb76GEeVGfC7XNQwdpmvCqhlsdWiGpesbGJCjf
         eUxbi1DGV+pIEqI6SfeMWPm1zBuEd1g7TjNtWsfxPpPYkxTSYDT1C/6HDF3Z3ss4XjcD
         WmoHCsn8HFwo0nx1sXtbGWX0uZcoLdVAeme4yhtL5uuh4NoA+ULbWzhSUQrTY3/j0ai+
         BMuJ/BgfSgRo/pU3bsjnmKbXIQ6H7gXLRVncPCbr6+ua3VRHNrOZ4PeRnmZnpGFRScE5
         byiPs6J2jGDw9h5AfLt4fA+GBAyOXOyiQ8ASiWrHvjoeapIoJhKI0skb+RG2NbiE2oKF
         Qtfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707347080; x=1707951880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aLthinSDbfqOxm/qwgXXi45DFGsKwn+jlZHtBC4Jjo=;
        b=C+wqdDPVDJGgoxZ9iALCkf2E5cst0pODVTYstbVk5/EZlXZ8y9iIUPkOHfxXW2F+3M
         hDzx1Hpypcg0/uJk07ft8hDuIyaO3JjDiim5FkznZ+FTWyga69pCgtwC0UyetKmYnfcn
         BKFcBWacdj1NPI4taueRZklGNYuXdXMZueT2wnkd5o2g3yjqHvxGHHA3TjK7PY2BpMnr
         loVHjq1mLiG9i2W2v6qHpSwJ+aKRokq4PmPwVUvpe1JGYjc79ACV3PwFlRWHAHDda7LQ
         HhuL1BIzngLoVyT/xrU0eUfSqwVJsKtGpi0ReJRJSxNG5Jo5mWV9n57uInAs/mYoPMjq
         z6tQ==
X-Gm-Message-State: AOJu0YyviW/sX4Qo2Fflz4/0iwSIBg6X3tZxZBCtMsEJBddhlAgpyNrZ
	XKfC7IeDVJXrK/MNzTYBuAZRhW0dg/yxgenqZO0zhV4EoxwCPUmv
X-Google-Smtp-Source: AGHT+IGrWxgjE/tlbQm7JxTpNgXkvtA3tKPX9j970UvRHJ0jYkBuv6PnESI3VslLcyYS8rFPu+TD/Q==
X-Received: by 2002:a17:902:d54b:b0:1d9:7c1e:2f33 with SMTP id z11-20020a170902d54b00b001d97c1e2f33mr9392524plf.39.1707347079609;
        Wed, 07 Feb 2024 15:04:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWO3Ev9a+oA+EkSFoR7mvytaYy+pidk3t2RhAlUuxJ/LK2zIyS4TfNPIqlTwZ30/h6pZGRi8tiI5g5Wbu/cvhmv20zkLHhaQ4V/iidCvJq1kuHnIgcMNHfi+qP3cGlAXr6r7Vmdp1b0PqbD9+BGRSn9coWzxb+8XnZ6vAG1eBVckXN2waLqE/KlhUS0rhBOGjAUDdpBXPU+0Aiu5CEvS23pqazUhOeqfRB10CJiH+40hAJd24ibF+EzlR1GrtrC4YjgaWdlO1qKrEhylyEIQYgoe3Nvlc5rIUihVzWWqUjQROXhPq9tPoOdPTE=
Received: from jmaxwell.com ([203.220.178.35])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090332cc00b001d6f7875f57sm2003695plr.162.2024.02.07.15.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 15:04:39 -0800 (PST)
From: Jon Maxwell <jmaxwell37@gmail.com>
To: jesse.brandeburg@intel.com
Cc: anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jmaxwell37@gmail.com
Subject: [net-next] intel: make module parameters readable in sys filesystem
Date: Thu,  8 Feb 2024 10:04:30 +1100
Message-Id: <20240207230430.82801-1-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linux users sometimes need an easy way to check current values of module
parameters. For example the module may be manually reloaded with different
parameters. Make these visible and readable in the /sys filesystem to allow
that.

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
---
 drivers/net/ethernet/intel/e100.c                 | 6 +++---
 drivers/net/ethernet/intel/e1000/e1000_main.c     | 2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c        | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c       | 2 +-
 drivers/net/ethernet/intel/igb/igb_main.c         | 4 ++--
 drivers/net/ethernet/intel/igbvf/netdev.c         | 2 +-
 drivers/net/ethernet/intel/igc/igc_main.c         | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 6 +++---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 9 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 01f0f12035caeb7ca1657387538fcebf5c608322..2d879579fc888abda880e7105304941db5d4e263 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -170,9 +170,9 @@ MODULE_FIRMWARE(FIRMWARE_D102E);
 static int debug = 3;
 static int eeprom_bad_csum_allow = 0;
 static int use_io = 0;
-module_param(debug, int, 0);
-module_param(eeprom_bad_csum_allow, int, 0);
-module_param(use_io, int, 0);
+module_param(debug, int, 0444);
+module_param(eeprom_bad_csum_allow, int, 0444);
+module_param(use_io, int, 0444);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 MODULE_PARM_DESC(eeprom_bad_csum_allow, "Allow bad eeprom checksums");
 MODULE_PARM_DESC(use_io, "Force use of i/o access mode");
diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 1d1e93686af2bc44c9d9330cc12096c88895339b..a20f23f36eb0acb26dfaffe30c6dc3cb88d9e1b0 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -195,7 +195,7 @@ MODULE_LICENSE("GPL v2");
 
 #define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV|NETIF_MSG_PROBE|NETIF_MSG_LINK)
 static int debug = -1;
-module_param(debug, int, 0);
+module_param(debug, int, 0444);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
 /**
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index af5d9d97a0d6cb93d18cc8e6c5ea54a1bafe46ea..231dbb02c70a5abe79148bc4f4d62dc4ab33e3e0 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -34,7 +34,7 @@ char e1000e_driver_name[] = "e1000e";
 
 #define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV|NETIF_MSG_PROBE|NETIF_MSG_LINK)
 static int debug = -1;
-module_param(debug, int, 0);
+module_param(debug, int, 0444);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
 static const struct e1000_info *e1000_info_tbl[] = {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6e7fd473abfd001eb45e8b5bda8978fff9eec26b..0abe169df7ff6e9e381e47657f377e3afeca6ff7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -95,7 +95,7 @@ MODULE_DEVICE_TABLE(pci, i40e_pci_tbl);
 
 #define I40E_MAX_VF_COUNT 128
 static int debug = -1;
-module_param(debug, uint, 0);
+module_param(debug, uint, 0444);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all), Debug mask (0x8XXXXXXX)");
 
 MODULE_AUTHOR("Intel Corporation, <e1000-devel@lists.sourceforge.net>");
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 4df8d4153aa5f5ce7ac9dd566180d552be9f5b4f..1e8dbf9b700ba71f25a6c8c906633a4baa88941d 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -202,7 +202,7 @@ static struct notifier_block dca_notifier = {
 #endif
 #ifdef CONFIG_PCI_IOV
 static unsigned int max_vfs;
-module_param(max_vfs, uint, 0);
+module_param(max_vfs, uint, 0444);
 MODULE_PARM_DESC(max_vfs, "Maximum number of virtual functions to allocate per physical function");
 #endif /* CONFIG_PCI_IOV */
 
@@ -238,7 +238,7 @@ MODULE_LICENSE("GPL v2");
 
 #define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV|NETIF_MSG_PROBE|NETIF_MSG_LINK)
 static int debug = -1;
-module_param(debug, int, 0);
+module_param(debug, int, 0444);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
 struct igb_reg_info {
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index a4d4f00e6a8761673857feb019de7ebaf34900ef..dc6a4f14cc28db60e849e674cda89118041245e3 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -32,7 +32,7 @@ static const char igbvf_copyright[] =
 
 #define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV|NETIF_MSG_PROBE|NETIF_MSG_LINK)
 static int debug = -1;
-module_param(debug, int, 0);
+module_param(debug, int, 0444);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
 static int igbvf_poll(struct napi_struct *napi, int budget);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index ba8d3fe186aedacd5a7959e6fd9da3408fe71843..704bb8f830df5ea7be733c529990f8fa891942c3 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -34,7 +34,7 @@ static int debug = -1;
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION(DRV_SUMMARY);
 MODULE_LICENSE("GPL v2");
-module_param(debug, int, 0);
+module_param(debug, int, 0444);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
 char igc_driver_name[] = "igc";
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index bd541527c8c74d6922e8683e2f4493d9b361f67b..296baa10cb21e02252080f951f82d83774088719 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -147,19 +147,19 @@ static struct notifier_block dca_notifier = {
 
 #ifdef CONFIG_PCI_IOV
 static unsigned int max_vfs;
-module_param(max_vfs, uint, 0);
+module_param(max_vfs, uint, 0444);
 MODULE_PARM_DESC(max_vfs,
 		 "Maximum number of virtual functions to allocate per physical function - default is zero and maximum value is 63. (Deprecated)");
 #endif /* CONFIG_PCI_IOV */
 
 static bool allow_unsupported_sfp;
-module_param(allow_unsupported_sfp, bool, 0);
+module_param(allow_unsupported_sfp, bool, 0444);
 MODULE_PARM_DESC(allow_unsupported_sfp,
 		 "Allow unsupported and untested SFP+ modules on 82599-based adapters");
 
 #define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV|NETIF_MSG_PROBE|NETIF_MSG_LINK)
 static int debug = -1;
-module_param(debug, int, 0);
+module_param(debug, int, 0444);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index a44e4bd561421a5ee398f29464ec591af32c8857..fc82d0914bdbb96c9548d17b3de47d064308a95c 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -82,7 +82,7 @@ MODULE_LICENSE("GPL v2");
 
 #define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV|NETIF_MSG_PROBE|NETIF_MSG_LINK)
 static int debug = -1;
-module_param(debug, int, 0);
+module_param(debug, int, 0444);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
 static struct workqueue_struct *ixgbevf_wq;
-- 
2.39.3


