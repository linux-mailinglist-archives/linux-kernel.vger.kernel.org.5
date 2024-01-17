Return-Path: <linux-kernel+bounces-28705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D9B830216
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702081C248AF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE91F1DDC3;
	Wed, 17 Jan 2024 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBBcy6wn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCA21D552;
	Wed, 17 Jan 2024 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483062; cv=none; b=iKe3k3hGyPMKBbgTH+4BGoHut02lNGJBg/LdaO/evh4uR7zISdXFOv8ZgWvzRwuOPZRJ2vIXxC26fAtQikVuqHu2CR4RzFehXZeJuNxsEzM7su+M/3eKYgAI61PrCXabn4ptQ3BBBDjFHsI8enaRRWzmpzZn+8NN+CBHtmjjG4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483062; c=relaxed/simple;
	bh=fDdyhPSiCGUYtF8wAWV+g2nVIffg0T992GjChQ9yGQs=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=NX2vaBby0Xwu0nXCZq/5EDbzgToxy/8QD9BggDuWQcYrugeQtPi/QO/Jf61Hef20e1BnshtAQkMmI6+1HcEPl29nJSc9WLRH7NEDgBATe8PNL7yeXHPSR1JH37ncnYzlqdx2tRiIWrTqRex/tGC3GlKtdWBC7D67BsysBOOsDa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZBBcy6wn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705483061; x=1737019061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fDdyhPSiCGUYtF8wAWV+g2nVIffg0T992GjChQ9yGQs=;
  b=ZBBcy6wn/3WAKvmuMhSXEutFJO+fDXAoe7gQYYBqbffRi9Y7AzvQGzRE
   Bh7TRnCHl5cXYQ22+dJyD0WTyAuSx3M9kNXzJtp5GqvwKc8uaS4f7A00f
   qaMIxC8x1zVCET93rGPxnB9zgMMaB/FgLJMtNGDk21BXmViTaQIREXOqo
   VZOKZcfIRFjbtvbjCsuzoYSOwyMdOJgIPPLjOOVJe+ewZ0cbtsN48XdBC
   9BdrZS1Q0uN+f39Vz/YDjmJ3cU0AxGtozhw9LiS50153SCWQSHzSB2rMf
   U5MFxCzdsZ72YeS7LQtGzI3XS+jv0ydGMg+GPIFN6ZskY9icgbSsSFuit
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="13474586"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="13474586"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 01:17:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="957489837"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="957489837"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orsmga005.jf.intel.com with ESMTP; 17 Jan 2024 01:17:37 -0800
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	davem@davemloft.net,
	milena.olech@intel.com,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	mschmidt@redhat.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net v4 4/4] dpll: fix broken error path in dpll_pin_alloc(..)
Date: Wed, 17 Jan 2024 10:14:16 +0100
Message-Id: <20240117091416.504096-5-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240117091416.504096-1-arkadiusz.kubalewski@intel.com>
References: <20240117091416.504096-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If pin type is not expected, or dpll_pin_prop_dup(..) failed to
allocate memory, the unwind error path shall not destroy pin's xarrays,
which were not yet initialized.
Add new goto label and use it to fix broken error path.

Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v4:
- this change was part of [v3 1/3], separate it

 drivers/dpll/dpll_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 4ddb33462fff..ac426a9be072 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -486,22 +486,23 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	if (WARN_ON(prop->type < DPLL_PIN_TYPE_MUX ||
 		    prop->type > DPLL_PIN_TYPE_MAX)) {
 		ret = -EINVAL;
-		goto err;
+		goto err_pin_prop;
 	}
 	ret = dpll_pin_prop_dup(prop, &pin->prop);
 	if (ret)
-		goto pin_free;
+		goto err_pin_prop;
 	refcount_set(&pin->refcount, 1);
 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
 	ret = xa_alloc_cyclic(&dpll_pin_xa, &pin->id, pin, xa_limit_32b,
 			      &dpll_pin_xa_id, GFP_KERNEL);
 	if (ret)
-		goto err;
+		goto err_xa_alloc;
 	return pin;
-err:
+err_xa_alloc:
 	xa_destroy(&pin->dpll_refs);
 	xa_destroy(&pin->parent_refs);
+err_pin_prop:
 	kfree(pin);
 	return ERR_PTR(ret);
 }
-- 
2.38.1


