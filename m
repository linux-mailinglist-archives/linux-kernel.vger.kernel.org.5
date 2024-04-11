Return-Path: <linux-kernel+bounces-140184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C52418A0C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51329B22216
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CD4145323;
	Thu, 11 Apr 2024 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUk1gb38"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F3313DDDD;
	Thu, 11 Apr 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828087; cv=none; b=tbQ4cMW9p75MBLXHQqydwiW/FxU2c4SIJfJ6JVFypOK4SGoPyD4FPTcqrqFJOFmrdQoOhsQAYozC35v+xtJ609y3IvhN6jsVTgY7DbfXVMZcyY6FjzD25YqbeIM5eZh1lu6XpwvJnT7RrCwCGhZMu/oxLlvcLm3S96XS6QOR1vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828087; c=relaxed/simple;
	bh=d4DJAMB2M6nuUOPlE0e/QGcAkAWTG5ugPMVGt1FMlDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DQPgPXyc00dUuCy/x3AGYM5DWGEnvL4FOCgLi2Te7fYx9ZPd9cpnHlHH/6xxIhW0bEATCuEojdOTWHR6mViEsLvGcqKv8O462EDybKq8+JwMy4CKJIh6ioOFeDnHgdddjUm2V2Vj58Z6fLQzsnZ6ePS8Er2UJnRINPGSsLAKgww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUk1gb38; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712828086; x=1744364086;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d4DJAMB2M6nuUOPlE0e/QGcAkAWTG5ugPMVGt1FMlDs=;
  b=lUk1gb387uTLXpPiNKr15BtSWozpUqtCKM5KKJrWdqe7M8mIz0vAgufd
   qV4z0mwnahUoYBo/75lWwOwXDA6EObQx2t+QWUo00GoIDMljudiGGSsLY
   YXVMoY0J5rfhOl2Z5ZPIA5UuUPBaHFAcrIFgS/n7zqk3ToKE/bPRV4Yan
   987UP5k86D7q8F47xDfMU8dSOcA2Htbz4OYaFDs0ClOgcyWZeJ+LNLoWU
   0sx9cxQda5J56QF241n3XUAKASIRKcCITrM19xn97Vv02yuXc2z7nOL/2
   Qivd322YFKGv+IxfAZMTD99hakT9US1GRwtkB5ok9sXxm3e6FTjKRd8lm
   w==;
X-CSE-ConnectionGUID: bXCkCXL1TzC0I0cBJzS3UQ==
X-CSE-MsgGUID: hFhntNcTR9ufj5NOyRPPpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11189079"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="11189079"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 02:34:44 -0700
X-CSE-ConnectionGUID: j43tVAdVSSmouSLq97QRXw==
X-CSE-MsgGUID: r00DMd+GSViHjzMbZr25ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20823130"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa010.fm.intel.com with ESMTP; 11 Apr 2024 02:34:42 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Keith Packard <keithp@keithp.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kernel-doc: fix struct_group_tagged() parsing
Date: Thu, 11 Apr 2024 11:32:08 +0200
Message-ID: <20240411093208.2483580-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

kernel-doc emits a warning on struct_group_tagged() if you describe your
struct group member:

include/net/libeth/rx.h:69: warning: Excess struct member 'fp' description in 'libeth_fq'

The code:

/**
 * struct libeth_fq - structure representing a buffer queue
 * @fp: hotpath part of the structure
 * @pp: &page_pool for buffer management
[...]
 */
struct libeth_fq {
	struct_group_tagged(libeth_fq_fp, fp,
		struct page_pool	*pp;
[...]
	);

When a struct_group_tagged() is encountered, we need to build a
`struct TAG NAME;` from it, so that it will be treated as a valid
embedded struct.
Decouple the regex and do the replacement there. As far as I can see,
this doesn't produce any new warnings on the current mainline tree.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20240405212513.0d189968@kernel.org
Fixes: 50d7bd38c3aa ("stddef: Introduce struct_group() helper macro")
Signed-off-by: Kees Cook <keescook@chromium.org>
Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 scripts/kernel-doc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 43a30f2de513..01ac8f794b30 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1152,7 +1152,8 @@ sub dump_struct($$) {
         # - first eat non-declaration parameters and rewrite for final match
         # - then remove macro, outer parens, and trailing semicolon
         $members =~ s/\bstruct_group\s*\(([^,]*,)/STRUCT_GROUP(/gos;
-        $members =~ s/\bstruct_group_(attr|tagged)\s*\(([^,]*,){2}/STRUCT_GROUP(/gos;
+        $members =~ s/\bstruct_group_attr\s*\(([^,]*,){2}/STRUCT_GROUP(/gos;
+        $members =~ s/\bstruct_group_tagged\s*\(([^,]*),([^,]*),/struct $1 $2; STRUCT_GROUP(/gos;
         $members =~ s/\b__struct_group\s*\(([^,]*,){3}/STRUCT_GROUP(/gos;
         $members =~ s/\bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;/$2/gos;
 
-- 
2.44.0


