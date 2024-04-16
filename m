Return-Path: <linux-kernel+bounces-147612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CE98A7685
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7155C281565
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC5514BFBC;
	Tue, 16 Apr 2024 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/feUj0W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D11B14AD2C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302537; cv=none; b=l6VRXDOlYLM+o7b0IuFCwnzizoAF5lRvkmeFoGFj2q2BAI7oPyhVrTDl0dsegTPp7kA8nT0kf/Xw7WqYzUSl9XWfpBpwR6RagSrvhjGvC8g2mgN/oMsKgFHNUBEaNkPZ/ZAYNUEbkf/6mlAOKK9PysgA44GUXFrAY+RqFn9QyQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302537; c=relaxed/simple;
	bh=xK5hwg6ILPkC2v4d4nuHc6WucRElJH7HgJqquuK12yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PELgEEYK5EPYRl5ce7gHK0ei+PRsfnN4MRCn2APnPSS5WFysgaMIYj6CwoNAV/FgMzRTwaz5OuhR0EIPseA9UqG8kjdhuJgC/IYp1QOPZcDDZs57SAX4ZLCMxMnXJ5HkOyt7BOX7hnC9hZTO2qGVNSNESGfTXuP9BvwgkijBUfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L/feUj0W; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302537; x=1744838537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xK5hwg6ILPkC2v4d4nuHc6WucRElJH7HgJqquuK12yY=;
  b=L/feUj0WM8Zp80HCX1O5aBEr6gu1e1ndaDjKGLxm/kpZdAYdREo7git+
   B00Y0QrQvDoWhcWCATeEjLeaAHX3Ckl6wgL2zLCg6bW8qcP1wG0CJcz+s
   oHgpDz96DhZ2qC54gtZbSxlpn347lIBwquErt23WSD0bv9eaNV/hwPm9w
   RLQUM89LpKlWR+S5fqIVHre5G3DQwBGxdXbMpYlFaf5CaSdxWjBWrbFVK
   7FCtxLXsTyC+6knZGjyCV3X7xjfVC0ObLS1jtQT30TMi8bW2Uev8LZbxw
   Kmn0c44TfNM/vSSdMF/vnoRO9i5IJmnuhnip6FZYleXvHItp9dPmhAKLs
   w==;
X-CSE-ConnectionGUID: Cp99rpEuQCaZhSd9vW67CQ==
X-CSE-MsgGUID: BRx1kkzcTvKeeKyXwsHjCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26234906"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26234906"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:16 -0700
X-CSE-ConnectionGUID: +ndZgGKYQ0imf9VwF7ErZw==
X-CSE-MsgGUID: Oqq5z7szTvOQQYmf6H0VbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22267078"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:16 -0700
From: Tony Luck <tony.luck@intel.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Hans de Goede <hdegoede@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 49/74] x86/cpu/vfm: Update drivers/extcon/extcon-axp288.c
Date: Tue, 16 Apr 2024 14:22:14 -0700
Message-ID: <20240416212214.9586-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416211941.9369-1-tony.luck@intel.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
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
 drivers/extcon/extcon-axp288.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index a703a8315634..d3bcbe839c09 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -108,7 +108,7 @@ struct axp288_extcon_info {
 };
 
 static const struct x86_cpu_id cherry_trail_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	NULL),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	NULL),
 	{}
 };
 
-- 
2.44.0


