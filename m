Return-Path: <linux-kernel+bounces-58770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB42C84EB80
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3628A1F2D97B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692924F894;
	Thu,  8 Feb 2024 22:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUccSAqf"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B2E4F60B;
	Thu,  8 Feb 2024 22:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430695; cv=none; b=rNUX2ULDMuC8Da38YxYud/6qMUnNKFv6CMG73DBYmaajPfCy5qZElwZlwKzICggX3FNahJApGog5+x8IzDNA8lKNW3KDuJcNsiP88IDL20UyTwWKsp0SEa1US5zgmR5FGdGdzOWdCv2JYnnXgsyKld1pWRFofLEdWYO87p5HrlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430695; c=relaxed/simple;
	bh=eZfOaA18/gD76auvKG0RWees9lys9unypghBGicS/4g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=McDnXFEuoCCEhASz6nHWszJMHwEKsWQtCiB0HmKk2wBjhpI3PTB/ewdWCJf5Pd9MUIQy/FqjSRa6Kndfpq8kVIPUM7BRcyceVElLpct1LpYjHMYP/Rqm0JYXNsVJnqyuvFAi/kI3X1jOLaEz+YlAopdpLZZxtXSQAKW8G48Q43w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUccSAqf; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-58e256505f7so162441eaf.3;
        Thu, 08 Feb 2024 14:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707430693; x=1708035493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iwUfftNo0NrpRr9BW99q1MRWWjsnNNeYwX3VFPATbF0=;
        b=TUccSAqfDKqhq3xDnq9I9pBWBaDlEPyBRfYiGhqVxe+hLsarmKmNgx/TjOCL84RBO5
         t8iXF+QqM85VbG/cXn2lUFHoOjxakg8Y4XouzEojHlkVoCGXClU9rcNBmF28KOhxI3uX
         gN9aOZtrMbAeZpJ5BXzy/m2+GqGefyYMgfxZoTBhoQsqsMOt463/Bw+eY/xMWuUMMJ0J
         8F70BJQ19iN09Ado5lDvbw/kHzu1JjRZKyqorZuELcluY6ElTxW5BAado0zHD6QpltAY
         SU5CrRZ+64QS/jWUanwslRxlMV1AXs3yYZpyJBvjsM4Oe2wEv7v947LV3UqV7n0FOaFR
         vT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707430693; x=1708035493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iwUfftNo0NrpRr9BW99q1MRWWjsnNNeYwX3VFPATbF0=;
        b=CaYf+dQUy32L47iidHQCEBdXhux4epeZ2U88clIMm4cTnwfMP9dCgzyVDTZF3aVlI8
         3HtL650jv4wkN3ZefVQDXUHqWjqhE5drYjOME+HzoOE/P94plQnlPrtn2+zCSIXoV2pw
         xzRewahKPQrDl1jnLRznBU0HGZOWs+9fOUHRIWNaRKbb3n6CZF8CdTDJd6IxgEaafds5
         OPoR+/c3ZaBZLNf3TYqoH2LSd01OdpSqO/2Hr7aMAO3xTV4ITGcR7YB6hb3IaDYLBAWO
         R3GsglYNdMZs3ln7ZiQZ0SYjafkG/SVaoqwEGY/ABetoqT+BMlYVaiezLmRnTRwcxHd5
         iHIg==
X-Gm-Message-State: AOJu0Yzm1WH3i6/JyxxWOb8fQ0bECQub8jLSdewBHbHuPre6bB9E5ZDg
	MzqtP9RiwIL7TYCoW9COgFbFuL7qrQzVYnId8Us9XvSvCWl3Y3vT
X-Google-Smtp-Source: AGHT+IGovOFvgiQsPwGM1GJYGbGKM27WNGk1gOLj/ukbEzVwJHHxBH7uxYyFgnLS9+YFj99snvKS7w==
X-Received: by 2002:a05:6358:705:b0:176:4aae:515c with SMTP id e5-20020a056358070500b001764aae515cmr537147rwj.17.1707430693047;
        Thu, 08 Feb 2024 14:18:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWuaCC7NasFoFwnfc5VwhJsaN7nRE6k6KcjVXTXpE6c3TgL6v+X4baYfhWT7R5qD+JOUmHQ/q8eCaTKTWmD50Tekw2zXXxSfJeUBJ4ruZ1xbreiWyAndHTP0ZrEwDqrJHRxbT3p0JhmiFuWKDg08OO7ziS6I6u6tgXhPA1qX7+ak7YGiMn6ULYveUAnt0/VqNzOILiR6jtSAa+Z+/mUsViAI6oyPvgrUSHHJ16JJLLV6Pg4OZ8+A2bexRKavVABOOv1NrGbkrb070kW90QIIifg6BGhSTX5FxdTw9pMhWj925aOwEQRBgYgJj0=
Received: from jmaxwell.com ([203.220.178.35])
        by smtp.gmail.com with ESMTPSA id x37-20020a056a000be500b006e06e418c88sm253752pfu.216.2024.02.08.14.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 14:18:12 -0800 (PST)
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
Subject: [net-next v2] intel: make module parameters readable in sys filesystem
Date: Fri,  9 Feb 2024 09:18:02 +1100
Message-Id: <20240208221802.131087-1-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: Remove the "debug" module parameter as per Andrew Lunns suggestion.
    It's not really needed as ethtool msglvl can control that.

Linux users sometimes need an easy way to check current values of module
parameters. For example the module may be manually reloaded with different
parameters. Make these visible and readable in the /sys filesystem to allow
that.

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
---
 drivers/net/ethernet/intel/e100.c             | 4 ++--
 drivers/net/ethernet/intel/igb/igb_main.c     | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

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
index bd541527c8c74d6922e8683e2f4493d9b361f67b..9d26ff82a397d4939cf7adea78c217e4071aa166 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -147,13 +147,13 @@ static struct notifier_block dca_notifier = {
 
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
 
-- 
2.39.3


