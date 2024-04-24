Return-Path: <linux-kernel+bounces-157508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773978B1237
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E9D28CB4D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1573116EC1E;
	Wed, 24 Apr 2024 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ad6zUTS+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105EC1C689D;
	Wed, 24 Apr 2024 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982540; cv=none; b=M8Ca0uOoUSjTq2B6s1/Rg1b2RNsoXKHTfEPNx1wLoiF3FgY8m8beqkqMYuwfEiecXklP6RKZelUGy0qj/xw524sdQ3A4L2H5eCjKDF0ivWv/36Acg1EJ/jtxft/VyRhudEy/RDWeManSgVmNJ5WROuttHnOvOw+NxumxcMEFb7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982540; c=relaxed/simple;
	bh=WDk3Nytz3rdQKdrZoCkbG+T02Itdm5c/GxoSZ2n45IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bm6r+FMANisNa0yeQXzmRhVMs3jwu+2yx+FUo0wuKXlGSl8Dn7F8Qdfns/K6UQk3pjP5foIBLoeGQOfs3NmePBgAq2uvVTlkmuUke1OYZzo97WId66EVHm+C9UAjvYKMIeyZARQMjP+NZAs0fD4iEs0RfvB+CtgBr46S9vvXUNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ad6zUTS+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982539; x=1745518539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WDk3Nytz3rdQKdrZoCkbG+T02Itdm5c/GxoSZ2n45IU=;
  b=Ad6zUTS+N1H3WIWlBZ8ijcmN3ndTpWBWMnhpFvKYgPeXFVgkkjOJlCO8
   Kvoo9dVv9G4p34H8xsAmqG1AGOaWiXBwoOOk/xJ5+l55EzCQNYF05TPwT
   SoBBupFAgG6x7SnOZEEnzcRNIZQKZrvQBqsR9ZouDN0UR8UjS+ah0SGXY
   Bc+7Q9xwWWjAwe5TjA5zWkcZ4rsABmWgQoTV2MLFnQpD3qRWPKTN2xMuN
   ezFjbSbsAy1XCUdO3SxHjGTYlRcUigvQk0hVQ9tQpvB1z8j85vVB5GDXK
   TzkAZmpiusZyRuFEJ13q53SfltOtvlwsALPnm72JJwIgwV963Xl7wpn52
   A==;
X-CSE-ConnectionGUID: dfJRNtIlS0C+wx+WdSSKBA==
X-CSE-MsgGUID: kEtqkbaARriqT7FHLVLmrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9503679"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9503679"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:38 -0700
X-CSE-ConnectionGUID: eYYxRhxXS5eZvp1tM9t8tw==
X-CSE-MsgGUID: /Pcz3vEuSeGMbovUk5PfpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55750299"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:38 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 59/71] platform/x86: intel_scu_wdt: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:38 -0700
Message-ID: <20240424181538.42292-1-tony.luck@intel.com>
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
 drivers/platform/x86/intel_scu_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_scu_wdt.c b/drivers/platform/x86/intel_scu_wdt.c
index a5031a25632e..d0b6637861d3 100644
--- a/drivers/platform/x86/intel_scu_wdt.c
+++ b/drivers/platform/x86/intel_scu_wdt.c
@@ -50,7 +50,7 @@ static struct intel_mid_wdt_pdata tangier_pdata = {
 };
 
 static const struct x86_cpu_id intel_mid_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, &tangier_pdata),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, &tangier_pdata),
 	{}
 };
 
-- 
2.44.0


