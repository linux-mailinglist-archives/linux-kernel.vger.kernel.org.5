Return-Path: <linux-kernel+bounces-27859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B954482F6DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8C2282766
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7166A5FF10;
	Tue, 16 Jan 2024 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5qvUsDm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F135FEF6;
	Tue, 16 Jan 2024 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434384; cv=none; b=DVJGGVkGulfxGZ10u7tiavMp3sZx+ndWyYPQQikdReevtFvyI/set/fcTX5bIZQAEQsFYpf97n+KEIP3/pXLxV7zMnhdipZfErReoYWSEddSzlrlFi9gfr1mr6YfNN+OgygmmWVq6m/Kt578U5Qkt87c8Ei2dLy3SNEyPPLjsyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434384; c=relaxed/simple;
	bh=dUToqKRZwM7w510wzCnyrPA0F2UXZA62+0hG52flM3Y=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=depcn5WvNjkz5kJ+olI/Ww8R/l2VBrHmNLCY8FL8TsP/oo5HOePol7LcraqEFW8vorOEXe2yF8dm3pmcYWmhRuVACW/L8ctsVUHRSyk+Ira3hOskGKXLhlH+o/L0tuiU4PURLZUVBpUB7ZWFgyYL6btJ8Sgw04Z71n0L8owQps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5qvUsDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5084C43394;
	Tue, 16 Jan 2024 19:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434384;
	bh=dUToqKRZwM7w510wzCnyrPA0F2UXZA62+0hG52flM3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5qvUsDmDDKyTm4uRfbGM41tqFyQW6FEk2iuwTphJ8Uskt3i3wNj0dDosYarKQQa3
	 UT1s2dv23Zpec+qCrcbfco1Gv0GQPsV47XOuozIoMOT5Wb+IggQMhYg2AEOLphnKqL
	 NkU0l7o2WHQJ6nto+UA+1lYjyVCry8Cpdo5Py092ABkPnFsnwCqkpn+y7cWH8HpU0o
	 VuBr77uPB3Mfh9TNsFqbp2KvdkY0pjvfmCpgCjDFJhgqSRGqvrKVQV20NM3dz4MNpv
	 YOxir0DDrnlKwyu/QvIEkjOC2eqMDuHxjqgMsALdtme7mzVEWwEQHKe3Qj+ajGi5rx
	 GqfNdkyDP2CKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 087/108] intel: add bit macro includes where needed
Date: Tue, 16 Jan 2024 14:39:53 -0500
Message-ID: <20240116194225.250921-87-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

[ Upstream commit 3314f2097dee43defc20554f961a8b17f4787e2d ]

This series is introducing the use of FIELD_GET and FIELD_PREP which
requires bitfield.h to be included. Fix all the includes in this one
change, and rearrange includes into alphabetical order to ease
readability and future maintenance.

virtchnl.h and it's usage was modified to have it's own includes as it
should. This required including bits.h for virtchnl.h.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/e1000/e1000_hw.c   |  1 +
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c   |  1 +
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c   |  1 +
 drivers/net/ethernet/intel/i40e/i40e_common.c |  1 +
 drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_nvm.c    |  1 +
 drivers/net/ethernet/intel/iavf/iavf_common.c |  3 +-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  5 ++--
 drivers/net/ethernet/intel/iavf/iavf_fdir.c   |  1 +
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |  1 +
 drivers/net/ethernet/intel/igb/e1000_i210.c   |  4 +--
 drivers/net/ethernet/intel/igb/e1000_nvm.c    |  4 +--
 drivers/net/ethernet/intel/igb/e1000_phy.c    |  4 +--
 drivers/net/ethernet/intel/igbvf/netdev.c     | 28 +++++++++----------
 drivers/net/ethernet/intel/igc/igc_i225.c     |  1 +
 drivers/net/ethernet/intel/igc/igc_phy.c      |  1 +
 include/linux/avf/virtchnl.h                  |  1 +
 17 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index 4542e2bc28e8..4576511c99f5 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -5,6 +5,7 @@
  * Shared functions for accessing and configuring the MAC
  */
 
+#include <linux/bitfield.h>
 #include "e1000.h"
 
 static s32 e1000_check_downshift(struct e1000_hw *hw);
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index af1b0cde3670..ae700a1807c6 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2019 Intel Corporation. */
 
+#include <linux/bitfield.h>
 #include "fm10k_pf.h"
 #include "fm10k_vf.h"
 
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
index dc8ccd378ec9..c50928ec14ff 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2019 Intel Corporation. */
 
+#include <linux/bitfield.h>
 #include "fm10k_vf.h"
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index d7e24d661724..3eb6564c1cbc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2013 - 2021 Intel Corporation. */
 
 #include <linux/avf/virtchnl.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/etherdevice.h>
 #include <linux/pci.h>
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index 68602fc375f6..d57dd30b024f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2021 Intel Corporation. */
 
+#include <linux/bitfield.h>
+#include "i40e_adminq.h"
 #include "i40e_alloc.h"
 #include "i40e_dcb.h"
 #include "i40e_prototype.h"
diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 77cdbfc19d47..e5aec09d58e2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include "i40e_alloc.h"
 #include "i40e_prototype.h"
diff --git a/drivers/net/ethernet/intel/iavf/iavf_common.c b/drivers/net/ethernet/intel/iavf/iavf_common.c
index 8091e6feca01..6a10c0ecf2b5 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_common.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_common.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
+#include <linux/avf/virtchnl.h>
+#include <linux/bitfield.h>
 #include "iavf_type.h"
 #include "iavf_adminq.h"
 #include "iavf_prototype.h"
-#include <linux/avf/virtchnl.h>
 
 /**
  * iavf_aq_str - convert AQ err code to a string
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index dc499fe7734e..25ba5653ac6b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
+#include <linux/bitfield.h>
+#include <linux/uaccess.h>
+
 /* ethtool support for iavf */
 #include "iavf.h"
 
-#include <linux/uaccess.h>
-
 /* ethtool statistics helpers */
 
 /**
diff --git a/drivers/net/ethernet/intel/iavf/iavf_fdir.c b/drivers/net/ethernet/intel/iavf/iavf_fdir.c
index 03e774bd2a5b..65ddcd81c993 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_fdir.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_fdir.c
@@ -3,6 +3,7 @@
 
 /* flow director ethtool support for iavf */
 
+#include <linux/bitfield.h>
 #include "iavf.h"
 
 #define GTPU_PORT	2152
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index d64c4997136b..fb7edba9c2f8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
+#include <linux/bitfield.h>
 #include <linux/prefetch.h>
 
 #include "iavf.h"
diff --git a/drivers/net/ethernet/intel/igb/e1000_i210.c b/drivers/net/ethernet/intel/igb/e1000_i210.c
index b9b9d35494d2..53b396fd194a 100644
--- a/drivers/net/ethernet/intel/igb/e1000_i210.c
+++ b/drivers/net/ethernet/intel/igb/e1000_i210.c
@@ -5,9 +5,9 @@
  * e1000_i211
  */
 
-#include <linux/types.h>
+#include <linux/bitfield.h>
 #include <linux/if_ether.h>
-
+#include <linux/types.h>
 #include "e1000_hw.h"
 #include "e1000_i210.h"
 
diff --git a/drivers/net/ethernet/intel/igb/e1000_nvm.c b/drivers/net/ethernet/intel/igb/e1000_nvm.c
index fa136e6e9328..0da57e89593a 100644
--- a/drivers/net/ethernet/intel/igb/e1000_nvm.c
+++ b/drivers/net/ethernet/intel/igb/e1000_nvm.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2007 - 2018 Intel Corporation. */
 
-#include <linux/if_ether.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
-
+#include <linux/if_ether.h>
 #include "e1000_mac.h"
 #include "e1000_nvm.h"
 
diff --git a/drivers/net/ethernet/intel/igb/e1000_phy.c b/drivers/net/ethernet/intel/igb/e1000_phy.c
index a018000f7db9..3c1b562a3271 100644
--- a/drivers/net/ethernet/intel/igb/e1000_phy.c
+++ b/drivers/net/ethernet/intel/igb/e1000_phy.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2007 - 2018 Intel Corporation. */
 
-#include <linux/if_ether.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
-
+#include <linux/if_ether.h>
 #include "e1000_mac.h"
 #include "e1000_phy.h"
 
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index fd712585af27..e6c1fbee049e 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -3,25 +3,25 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/vmalloc.h>
-#include <linux/pagemap.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
-#include <linux/netdevice.h>
-#include <linux/tcp.h>
-#include <linux/ipv6.h>
-#include <linux/slab.h>
-#include <net/checksum.h>
-#include <net/ip6_checksum.h>
-#include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/if_vlan.h>
+#include <linux/init.h>
+#include <linux/ipv6.h>
+#include <linux/mii.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/pagemap.h>
+#include <linux/pci.h>
 #include <linux/prefetch.h>
 #include <linux/sctp.h>
-
+#include <linux/slab.h>
+#include <linux/tcp.h>
+#include <linux/types.h>
+#include <linux/vmalloc.h>
+#include <net/checksum.h>
+#include <net/ip6_checksum.h>
 #include "igbvf.h"
 
 char igbvf_driver_name[] = "igbvf";
diff --git a/drivers/net/ethernet/intel/igc/igc_i225.c b/drivers/net/ethernet/intel/igc/igc_i225.c
index 17546a035ab1..d2562c8e8015 100644
--- a/drivers/net/ethernet/intel/igc/igc_i225.c
+++ b/drivers/net/ethernet/intel/igc/igc_i225.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c)  2018 Intel Corporation */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 
 #include "igc_hw.h"
diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
index 53b77c969c85..d0d9e7170154 100644
--- a/drivers/net/ethernet/intel/igc/igc_phy.c
+++ b/drivers/net/ethernet/intel/igc/igc_phy.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c)  2018 Intel Corporation */
 
+#include <linux/bitfield.h>
 #include "igc_phy.h"
 
 /**
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 6b3acf15be5c..99ae7960a8d1 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -5,6 +5,7 @@
 #define _VIRTCHNL_H_
 
 #include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/overflow.h>
 #include <uapi/linux/if_ether.h>
 
-- 
2.43.0


