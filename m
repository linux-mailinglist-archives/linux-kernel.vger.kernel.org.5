Return-Path: <linux-kernel+bounces-157513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C099B8B1241
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 030D21C22C7D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FB0200115;
	Wed, 24 Apr 2024 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWOA1poa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5328B1CB307;
	Wed, 24 Apr 2024 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982545; cv=none; b=rBFoGIsHTmErr1nqHkig0oQZ9oeXICMcZnr8g0jNn7Z/ydcibfXydJMGnt2sw+pIxLBsV0lkE6L5Es33hKNM54un8euFfhPDZdjsy4ymkZ9Zt2EtIttD9tbouK361XUx5NfE4NVsqkCGG0ZIMBARDyvpYZWwT3O13XrcD01zvI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982545; c=relaxed/simple;
	bh=UGEw2wLj1K8vQaWrX5dXU0U1OAJhcpCUAILxYE5zspA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1A3/Oz/XFrqRYlRSBnj8Q6vkM5yr3m4QI+WdqrYfdh1uZ3Nq296LUKD2/UBQ4wFJTeMHWxpHbdg+OCRZYWhmReTOMfe6iiRLHSEdSOWrM6nV5wN3pIUiNI72/8v4x7QJRYdbSCVYK1nXICMIxDi68VxKp8UadQ6fwk/jN2fBYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWOA1poa; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982544; x=1745518544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UGEw2wLj1K8vQaWrX5dXU0U1OAJhcpCUAILxYE5zspA=;
  b=lWOA1poaodkueGqKxqom+5jFzvxFPtKIW4TpriDMil46fd+WU4Y3CCiE
   /CvpMk2KID3V9HaCd3z4Buu9pOT2mGco9Ze+SwyQLP0J9Dn/77U1TycWh
   LvmJg6IZPHF76W844ZzNN8wwiPCjfqZhqhQNMfwMvGQL128W49ITyC2uw
   ZZjDgVcPUGLsTb62+NFFXVQbM7K5LfbdVMpB9MMNJOXfr6oZ6N4EYIZ9d
   rkJWQS6Y9GnPrYSwaQ6Xqp4IDZsFidCtMSbv54afybemsJ4qh6Idesbk6
   qBAHxihAPef3fjbhW0uzeEB0yokcCrrEBznG40IjuwTGrtBI7/lX3sioG
   g==;
X-CSE-ConnectionGUID: tMhfhN7dRruO7r+HrKkdvw==
X-CSE-MsgGUID: EK3BsloQS1+FSGmQlqz9fA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9503718"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9503718"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:44 -0700
X-CSE-ConnectionGUID: 2fZ4DXG3TNSfHvPL4RcxTA==
X-CSE-MsgGUID: DsC274P2QNG8L8Iv02HxVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55750343"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:43 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Tony Luck <tony.luck@intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v4 64/71] platform/x86: intel_turbo_max_3: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:43 -0700
Message-ID: <20240424181543.42388-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424181245.41141-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/turbo_max_3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/turbo_max_3.c b/drivers/platform/x86/intel/turbo_max_3.c
index 892140b62898..79a0bcdeffb8 100644
--- a/drivers/platform/x86/intel/turbo_max_3.c
+++ b/drivers/platform/x86/intel/turbo_max_3.c
@@ -114,8 +114,8 @@ static int itmt_legacy_cpu_online(unsigned int cpu)
 }
 
 static const struct x86_cpu_id itmt_legacy_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,	NULL),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,	NULL),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,	NULL),
 	{}
 };
 
-- 
2.44.0


