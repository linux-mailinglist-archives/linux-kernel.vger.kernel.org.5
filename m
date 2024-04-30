Return-Path: <linux-kernel+bounces-164447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237988B7DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA901F27ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18F91A38F3;
	Tue, 30 Apr 2024 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3VuNb8I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561B7199E92
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495902; cv=none; b=S+6Ys+MG5ZBiHBy/LJFcpY/nmgrQ/wZa9JgBZUx10e94uM7esG44OYi3X+E8AurDAXCzYXa2UUgFr98zSTLajB+Edi0WZ4My9TczN6grQVdR5ftS8KRBbTnW8svevukTYasjcJafyEnTOKG+OT3Ib+XNRd9HcX7vqbyolaRRCuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495902; c=relaxed/simple;
	bh=xbuIo3ZSM8pLcHYxBW35UJbdhVNAOT3WUu0lYAsB5RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfCssMoDUdK7XzKva9AxS3yD/jE3mnsulzAU7kULFUOR6h6MVuGI+dPOn3W50g4tuoxptb59fkt3c/bkqE84TrYcZBvaTCm4NeEzuzvuaHoq0UU/Y8z7Oz/D1yIqk7aHOKD0TW66vZDb/gl4KRrHNYBR3jbcnrgxVYGVYlIVU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3VuNb8I; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495900; x=1746031900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xbuIo3ZSM8pLcHYxBW35UJbdhVNAOT3WUu0lYAsB5RY=;
  b=D3VuNb8IJv0/CA80Pi9/DfviRK+CzVKLcIvJr4Ai9UgWTx6l/qVrNKot
   ozBPdm+IgmnzCTLCFLr6QcfucmckAilYFDuSiu/BYk0+SdD4Ayy+U+LNh
   lf/fQ9HZb0sOM8dxrhzoudpkZPukT3p4cQAaQgqhF1zfGWF37ykQrwyK4
   nERw1ZEdmLkfdzwkhvMEWzYtv4RRAvPU6wmG25a/i5bnCvk+wcCPwKzcS
   g4xOxxUSkRFbKKVW0yfuCUNBMXBKVJL+D6HhGB3rm2TV/L7zsk7irxmF+
   yK26VVlx4IkkJmpvnNlq7gTh/KtDzTEcfA2XYNaImDm/nz0tmRA3RNXks
   A==;
X-CSE-ConnectionGUID: NFea7/9iTNmLt+kiEznldQ==
X-CSE-MsgGUID: YgYrauDGSIurOy9gOpnV8Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075675"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075675"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:21 -0700
X-CSE-ConnectionGUID: bSEjbZabQuCp4NYJBO3W/g==
X-CSE-MsgGUID: 0AccD9TpSia46l0PuLmvxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515451"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:13 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 18/47] platform/x86: intel_telemetry: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:31 -0700
Message-ID: <20240430165100.73491-18-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430165100.73491-1-tony.luck@intel.com>
References: <20240430164913.73473-1-tony.luck@intel.com>
 <20240430165100.73491-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel/telemetry/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/telemetry/debugfs.c b/drivers/platform/x86/intel/telemetry/debugfs.c
index 1d4d0fbfd63c..70e5736c44c7 100644
--- a/drivers/platform/x86/intel/telemetry/debugfs.c
+++ b/drivers/platform/x86/intel/telemetry/debugfs.c
@@ -308,8 +308,8 @@ static struct telemetry_debugfs_conf telem_apl_debugfs_conf = {
 };
 
 static const struct x86_cpu_id telemetry_debugfs_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&telem_apl_debugfs_conf),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&telem_apl_debugfs_conf),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&telem_apl_debugfs_conf),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,	&telem_apl_debugfs_conf),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, telemetry_debugfs_cpu_ids);
-- 
2.44.0


