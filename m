Return-Path: <linux-kernel+bounces-159815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F72F8B3476
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94161F22068
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2B813FD6F;
	Fri, 26 Apr 2024 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLR+h94H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418C213EFEC;
	Fri, 26 Apr 2024 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714125010; cv=none; b=fnL/4uOT1aPoCPyyz/TqUtbX9M0qN206iof3UOJMxXtT8NFThk3kZhKZ7QOwXWFl1HxQgTZCmdWv6pUoLSVWYPoLL7cXVtVADaELSeodIK4tThhHyqXpl1dPw8qdyz+e19TsMpJpseSoiLccmKX5g0BTjZA2riJrIoXFko6kYlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714125010; c=relaxed/simple;
	bh=FtpE1Uh4JuqRnIuNg/8Z/NqWAXYxZcRvxnt2JNu7LB8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aIpNd4+Y9mrxA7Ez6MajqrHsuqK4RvXZok7zrHcHP4kFJ6lRKxj3VIrq8mrdxjuO+UaI3iC/zINkY33BMw5BkycJtn3LwTqFCmi1IjoBaV/+duxhs4PVUilKnFN5PxpLT5+uZtMR118iwzbPY/E/0EsI3jve1YfdFa+cvKDQf70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BLR+h94H; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714125008; x=1745661008;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FtpE1Uh4JuqRnIuNg/8Z/NqWAXYxZcRvxnt2JNu7LB8=;
  b=BLR+h94H8tpd8U5Cih1FVcIj/ooUXhIF5dDT89F2TpF6d+06ZduGwMcj
   KWdCX8rflvoiiKMhrVFfEUrVSbQDbn1+Mb07ztFsU+eUbBs0CFGxv9rII
   U+IMiGdNp4odk2+/v8HlRe7RZqvIq39UNUbDscG6zkbQj0Ds70zDaNl/+
   BAXO2cZd0fkuyq7IUR3TCOwG0CW/1pVk5bqfm1XcGeh9WpdLOZyhoADG7
   7Q7mmmkZJ9AqObivxQxKE0380D9MUU5mgJh2wUf7ZFxhCR6aIZ8d10YjP
   QTxSbJQEBwZ9heWuNc2M0buuRf1uJ3CZxYh2SXGEx+pQ4pCOIjZbxUjov
   g==;
X-CSE-ConnectionGUID: X+kXbLhUT/u48r20iAstsA==
X-CSE-MsgGUID: piOCbI5/QV29JS3gHlAgSw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9707094"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="9707094"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 02:50:08 -0700
X-CSE-ConnectionGUID: MnRxalWPQCeHaUnLU6sE2A==
X-CSE-MsgGUID: pqasDcjXRn+1m7KE3wAs2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="25411412"
Received: from unknown (HELO chenyu-dev.sh.intel.com) ([10.239.62.107])
  by fmviesa008.fm.intel.com with ESMTP; 26 Apr 2024 02:50:06 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] ACPI: tools: pfrut: Print the update_cap field during capability query
Date: Fri, 26 Apr 2024 17:48:50 +0800
Message-Id: <20240426094850.757123-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is request from the end user to print this field to better
query what type of update capability is supported on this platform.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/acpi/tools/pfrut/pfrut.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/power/acpi/tools/pfrut/pfrut.c b/tools/power/acpi/tools/pfrut/pfrut.c
index 388c9e3ad040..44a9ecbd91e8 100644
--- a/tools/power/acpi/tools/pfrut/pfrut.c
+++ b/tools/power/acpi/tools/pfrut/pfrut.c
@@ -174,6 +174,8 @@ void print_cap(struct pfru_update_cap_info *cap)
 		exit(1);
 	}
 
+	printf("update capability:%d\n", cap->update_cap);
+
 	uuid_unparse(cap->code_type, uuid);
 	printf("code injection image type:%s\n", uuid);
 	printf("fw_version:%d\n", cap->fw_version);
-- 
2.25.1


