Return-Path: <linux-kernel+bounces-67730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B808856FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249EF1F24FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08802145349;
	Thu, 15 Feb 2024 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrTVD4SX"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62351145343;
	Thu, 15 Feb 2024 22:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708034485; cv=none; b=S+RopS1caIP32QPlaemdrWd/A6Ae2poJh/LCrKMT9ShSkJpWx5n8e2sn0ZcudgsDtjQ3AEC+uDNaDfJaYiSSNI8r9nO521lIBTVDsTyUHM/z91NqyhIvwC/iiavzJ10lgNdbygcuXvNVrnTrSiSWJzWM6X5oFUvhrFatxak0Ers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708034485; c=relaxed/simple;
	bh=OcYqFODoDR5uTB4YAqC17ztNUWqOXrTuBR+Bfxt73ck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DSzG4NdyVBDSdWRZC4p7xbONuMhN8e/FnzWoeDHIpH6JMEpOUgWdQ//L7Hf7+qfkSy3yeIZPjjI8tCx5eUw4wCljh1xHYW0uAERcLr8jpdBuSdxgoilrU9fgoFzoCUc61hpJ18kSyhLku5u/VTgdf1PXfgmUR2BrgqSivkGex3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrTVD4SX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1db559a5e1fso12581545ad.1;
        Thu, 15 Feb 2024 14:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708034483; x=1708639283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7c5OHGhHTojwaEyoQ5DwBBrFP7ln6xQB8UIBfm95hg0=;
        b=mrTVD4SX0A6FsLnrXKz2dR2BZhgtmupj6N4nA9bLoLw/Gs72YKa7YNnjca4FZh2gzZ
         yEz7c5N3fuytyIBA8qw7ayZT+79QJdBR4r3IH013PdoQZEWM1GB5h9NdT7tgwPcG4NC8
         JX4g/jA/bWh6VxwHJ/YXvoC9mqaYIeE06Q+Z5AlKyTyqmKmXra2kl3Pn1ZHctzbXlP9l
         ns9MKO1cP4xSwCYL398dMmnRfZ3MhbfRG3OMfKoM41leMc4rEqC+UUZMae+gVMjtaO4d
         Y5iMe5OxCRMdHYBGhGR0j+QeKOlgFESYaqlt2Wby307LwkZFLDbInVYl0jsgn4/4B8Xg
         g1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708034483; x=1708639283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7c5OHGhHTojwaEyoQ5DwBBrFP7ln6xQB8UIBfm95hg0=;
        b=YsxiBEd1AfatAbbpm2UA7A61pYM7zYaa2ap6/lGTUyHHfY3ipSgtrJPuYrZdrPIr0o
         37e0eYYwSFD/AeWt414e7H/Z+mjvOaqsziLZFTJXKBIHhj1ev9+dCCACN2ta4EXq60y9
         4k8cjNcfYKEl+nimaEyj8H+ih94qQVIG6pPIcDUTgm7014NKKTaL5CdyKbTfQRyh+Mkv
         lwwVpn5m2Dfqstk7EXqGGg045J4trDiR5VTX3QXA9fQ3QggsabmblJJiz/3IUuxtE7d7
         MDI7uFDmNMVK9j8iAW9WCWM7c4MQIeHeF0iccjUK+indNboUgy7ZCSZ7uxv7hVmq+DMX
         SmmA==
X-Forwarded-Encrypted: i=1; AJvYcCV5E3FJnpjGmthmAvpcAOCTbb9hloJGoabqczNZD4ws5rnzOEVjMNg+b8oPDWBET8gqfQrg3Jotm9DrZMP7zl8YIH+cRJiMAXDNP/fXJFsQDx3riyjwyRGC7w9PC9Tknug6Ta+G
X-Gm-Message-State: AOJu0Yx4DpZltqT8E5Wslcx5avs6jfn9Xod/HvKL8TZflAIEJu5Nvzuk
	pfD5Cppv/k/GxsdboqO/FwR36ENAp7PEKa6cZpS5aqUJ/TYOmbPm
X-Google-Smtp-Source: AGHT+IEVOQzSdXmkeTX6ct0Ep/o6OLg+ixSVI4b7xrZU0uKBOwyKAaybdG1GxRqNVHW2h9rr6EqF0Q==
X-Received: by 2002:a17:903:2301:b0:1d9:7095:7e1f with SMTP id d1-20020a170903230100b001d970957e1fmr3998642plh.67.1708034483328;
        Thu, 15 Feb 2024 14:01:23 -0800 (PST)
Received: from jmaxwell.remote.csb ([203.220.178.35])
        by smtp.gmail.com with ESMTPSA id mm4-20020a1709030a0400b001d916995423sm1683384plb.99.2024.02.15.14.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 14:01:22 -0800 (PST)
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
Subject: [net-next v4] intel: make module parameters readable in sys filesystem
Date: Fri, 16 Feb 2024 09:01:01 +1100
Message-Id: <20240215220101.248023-1-jmaxwell37@gmail.com>
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
that. But don't make the "debug" module parameter visible as debugging is
enabled via ethtool msglvl.

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
---
V2: Remove the "debug" module parameter as per Andrew Lunns suggestion.
V3: Correctly format v2.
V4: Add ethtool msglvl to message. Remove deprecated ixgbe max_vfs
 drivers/net/ethernet/intel/e100.c             | 4 ++--
 drivers/net/ethernet/intel/igb/igb_main.c     | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 01f0f12035caeb7ca1657387538fcebf5c608322..3fcb8daaa2437fa3fe7b98ba9f606dbbb1844e58 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -171,8 +171,8 @@ static int debug = 3;
 static int eeprom_bad_csum_allow = 0;
 static int use_io = 0;
 module_param(debug, int, 0);
-module_param(eeprom_bad_csum_allow, int, 0);
-module_param(use_io, int, 0);
+module_param(eeprom_bad_csum_allow, int, 0444);
+module_param(use_io, int, 0444);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 MODULE_PARM_DESC(eeprom_bad_csum_allow, "Allow bad eeprom checksums");
 MODULE_PARM_DESC(use_io, "Force use of i/o access mode");
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 4df8d4153aa5f5ce7ac9dd566180d552be9f5b4f..31d0a43a908c0a4eab4fe1147064a5f5677c9f0b 100644
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
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index bd541527c8c74d6922e8683e2f4493d9b361f67b..7d09d89bb4c01d1d7b600724b6575892212b5e29 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -153,7 +153,7 @@ MODULE_PARM_DESC(max_vfs,
 #endif /* CONFIG_PCI_IOV */
 
 static bool allow_unsupported_sfp;
-module_param(allow_unsupported_sfp, bool, 0);
+module_param(allow_unsupported_sfp, bool, 0444);
 MODULE_PARM_DESC(allow_unsupported_sfp,
 		 "Allow unsupported and untested SFP+ modules on 82599-based adapters");
 
-- 
2.39.3


