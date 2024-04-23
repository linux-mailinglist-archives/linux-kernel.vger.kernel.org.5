Return-Path: <linux-kernel+bounces-155516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC958AF376
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A432815B7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD3E13CA99;
	Tue, 23 Apr 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bmhJjkWF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBFB13CA85
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888398; cv=none; b=rOBeTHtgtE7QOPFFoaN7scM9NljJpgzKMPO/n6Q7K8BONiiBsTdvbW8FiGwp7jq/CRbgigjLFSWTOZiKxFLi/+DIzfLq6Jpzhbs+ybJDq3h8aAhwCJTKf+DOgexndPE2JdDjQFrHNF9UoH1i9jAFZwZswEXzHF9NjgL9i+16jhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888398; c=relaxed/simple;
	bh=rz8v7GIZzAfZBSS+u7zhv0RpH1opYCbH7jQyaPOBrDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BJ/kyRTf6TJRwqaua3qkUV/hWLW68x67Mbx5kFF/3CXT6LbL/OpefdiC2s1Gc8/U66HcuXMZIczYacCJ6woaxWzDBDjHpNnSeXErl2F1Sr+YzevtgFFew0J0r/9yPakh5q3UUjIEBAXgCFQAVlaYTgHi7DCY60/vZrwL8uLakCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bmhJjkWF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713888396; x=1745424396;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rz8v7GIZzAfZBSS+u7zhv0RpH1opYCbH7jQyaPOBrDk=;
  b=bmhJjkWFsEr2+9Ai6JdbJrsiZQylorV6DqL6nODBwqqjle3Kygso3TcA
   x8A9M7qqE9Um8nvFIQ5S2LN4dZk95wFMEpmvU+CJipdsLlmO/HaGW/peA
   DsUnRhXJCnCvtPz8sMhRy0c36DIAKw1T5WPl/LT2orOQc4U93JG6UYYBw
   Zx+/FnuHWTc4zZgZEbSkbQwyTaDc/TK3m/vo1hM2q2B2FtBdardXqhST+
   mr3gke3/VQ36CyxiArBc8fivVrYFNo7riFRfvjLNxXqkj1/Eu+gm5our3
   XoygOYKP61MNw9dc87lOGb/sBVuXu9Yknjq4sDmNOzsDN7dTBqCtWffc+
   A==;
X-CSE-ConnectionGUID: f/fPf4L9Qr6sDbcfqaCUog==
X-CSE-MsgGUID: XreGWFB+QTCJ1HYz83cisA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="26998814"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26998814"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:06:36 -0700
X-CSE-ConnectionGUID: qDtkmvRNSd2lTeZuZ+gmgQ==
X-CSE-MsgGUID: I6NKywfHQgq2h0ztgUKHHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24462354"
Received: from josouza-mobl2.bz.intel.com ([10.87.243.88])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:06:34 -0700
From: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Zhanjun Dong <zhanjun.dong@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH CI 1/3] drm/xe: Store xe_he_engine in xe_hw_engine_snapshot
Date: Tue, 23 Apr 2024 09:05:48 -0700
Message-ID: <20240423160626.77110-1-jose.souza@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A future patch will require gt and xe device structs, so here
replacing class by hwe.

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Zhanjun Dong <zhanjun.dong@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
---
 drivers/gpu/drm/xe/xe_hw_engine.c       | 6 +++---
 drivers/gpu/drm/xe/xe_hw_engine_types.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
index 455f375c1cbd6..c84dbe8a8ed1d 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine.c
@@ -791,7 +791,7 @@ xe_hw_engine_snapshot_capture(struct xe_hw_engine *hwe)
 		return NULL;
 
 	snapshot->name = kstrdup(hwe->name, GFP_ATOMIC);
-	snapshot->class = hwe->class;
+	snapshot->hwe = hwe;
 	snapshot->logical_instance = hwe->logical_instance;
 	snapshot->forcewake.domain = hwe->domain;
 	snapshot->forcewake.ref = xe_force_wake_ref(gt_to_fw(hwe->gt),
@@ -842,7 +842,7 @@ xe_hw_engine_snapshot_capture(struct xe_hw_engine *hwe)
 	snapshot->reg.ring_eir = hw_engine_mmio_read32(hwe, RING_EIR(0));
 	snapshot->reg.ipehr = hw_engine_mmio_read32(hwe, RING_IPEHR(0));
 
-	if (snapshot->class == XE_ENGINE_CLASS_COMPUTE)
+	if (snapshot->hwe->class == XE_ENGINE_CLASS_COMPUTE)
 		snapshot->reg.rcu_mode = xe_mmio_read32(hwe->gt, RCU_MODE);
 
 	return snapshot;
@@ -887,7 +887,7 @@ void xe_hw_engine_snapshot_print(struct xe_hw_engine_snapshot *snapshot,
 	drm_printf(p, "\tBBADDR: 0x%016llx\n", snapshot->reg.ring_bbaddr);
 	drm_printf(p, "\tDMA_FADDR: 0x%016llx\n", snapshot->reg.ring_dma_fadd);
 	drm_printf(p, "\tIPEHR: 0x%08x\n", snapshot->reg.ipehr);
-	if (snapshot->class == XE_ENGINE_CLASS_COMPUTE)
+	if (snapshot->hwe->class == XE_ENGINE_CLASS_COMPUTE)
 		drm_printf(p, "\tRCU_MODE: 0x%08x\n",
 			   snapshot->reg.rcu_mode);
 }
diff --git a/drivers/gpu/drm/xe/xe_hw_engine_types.h b/drivers/gpu/drm/xe/xe_hw_engine_types.h
index d7f828c76cc5f..27deaa31efd31 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine_types.h
+++ b/drivers/gpu/drm/xe/xe_hw_engine_types.h
@@ -158,8 +158,8 @@ struct xe_hw_engine {
 struct xe_hw_engine_snapshot {
 	/** @name: name of the hw engine */
 	char *name;
-	/** @class: class of this hw engine */
-	enum xe_engine_class class;
+	/** @hwe: hw engine */
+	struct xe_hw_engine *hwe;
 	/** @logical_instance: logical instance of this hw engine */
 	u16 logical_instance;
 	/** @forcewake: Force Wake information snapshot */
-- 
2.44.0


