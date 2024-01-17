Return-Path: <linux-kernel+bounces-28704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC11830212
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323651F21A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321EB1C6A8;
	Wed, 17 Jan 2024 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8pC7HNN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0000114AA2;
	Wed, 17 Jan 2024 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483059; cv=none; b=Ao0HKh3GH0JkQY5POe/VoMzJCPB1x288VAxoi9TBHYXyqPM9d8wvBRXQgOyJ2QlwxUlfeh0xPmoBsxxQyREH1PudxlKGkqULklVjC9SUJi6LIEdwM8QJ0e8TYanhSFZiT1YvdCASX+odVuQGSjuMCcKCZcX6kJJiDdtMV080Ias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483059; c=relaxed/simple;
	bh=Lc1n6rgNpLCMJjqUGlmbi1VYwF3HtfvxBPvsmFNRdu4=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=lE4vEPeVbqjR6Zewo0tUzB+t9vqfi2TbPBkKjw+sEQ7SiuFdxA6G5Ul26+lYetnwsnknD0jSfoMze6SSlQTck0nyV//ABUZMxtgEHb9sX8IRn1eCOHFR47bUHU5X8ofqDt02UBeg3083vt9cNnYeO3GSkxh7HJmJifVERAKfuLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8pC7HNN; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705483059; x=1737019059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lc1n6rgNpLCMJjqUGlmbi1VYwF3HtfvxBPvsmFNRdu4=;
  b=a8pC7HNNyaSTx5/2T8NJBX5Egx41q85Dx/XykBBB1dAkQP4H1G8sMyrX
   gGe9ix1XY927J28zNrHMw62wkA0F+02U1LrBB49TdPg8wdidmRDo2iN2l
   HsM/IzcpdHVeYlTE2c0ANf51zjepqjDkZq2G/7m5Z4jFTYAi43b3cEKZt
   MYbgmKWeu/+8dLAfJFUG9E8SJmF+IglSMjPJJwTrg8q/oYB/Lo2L9eHGM
   M79a1s1k0U8czNe553E38yQtSa+B7aq+nKzrNoD+5tlfXZP4cfDIUrK3H
   zEO+NkEXgOdnlAYnTrLp8FV7P7EwixdqoQlmhTdXzUP9zza0ezrAAzwPH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="13474557"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="13474557"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 01:17:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="957489822"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="957489822"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orsmga005.jf.intel.com with ESMTP; 17 Jan 2024 01:17:34 -0800
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
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jan Glaza <jan.glaza@intel.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net v4 3/4] dpll: fix register pin with unregistered parent pin
Date: Wed, 17 Jan 2024 10:14:15 +0100
Message-Id: <20240117091416.504096-4-arkadiusz.kubalewski@intel.com>
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

In case of multiple kernel module instances using the same dpll device:
if only one registers dpll device, then only that one can register
directly connected pins with a dpll device. When unregistered parent is
responsible for determining if the muxed pin can be registered with it
or not, the drivers need to be loaded in serialized order to work
correctly - first the driver instance which registers the direct pins
needs to be loaded, then the other instances could register muxed type
pins.

Allow registration of a pin with a parent even if the parent was not
yet registered, thus allow ability for unserialized driver instance
load order.
Do not WARN_ON notification for unregistered pin, which can be invoked
for described case, instead just return error.

Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
Reviewed-by: Jan Glaza <jan.glaza@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v4:
- make this patch third in the series, previously was second

 drivers/dpll/dpll_core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index b62cca4678e8..4ddb33462fff 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -29,8 +29,6 @@ static u32 dpll_pin_xa_id;
 	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
 #define ASSERT_DPLL_NOT_REGISTERED(d)	\
 	WARN_ON_ONCE(xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
-#define ASSERT_PIN_REGISTERED(p)	\
-	WARN_ON_ONCE(!xa_get_mark(&dpll_pin_xa, (p)->id, DPLL_REGISTERED))
 
 struct dpll_device_registration {
 	struct list_head list;
@@ -614,8 +612,6 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 	    WARN_ON(!ops->state_on_dpll_get) ||
 	    WARN_ON(!ops->direction_get))
 		return -EINVAL;
-	if (ASSERT_DPLL_REGISTERED(dpll))
-		return -EINVAL;
 
 	mutex_lock(&dpll_lock);
 	if (WARN_ON(!(dpll->module == pin->module &&
@@ -693,8 +689,6 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 	    WARN_ON(!ops->state_on_pin_get) ||
 	    WARN_ON(!ops->direction_get))
 		return -EINVAL;
-	if (ASSERT_PIN_REGISTERED(parent))
-		return -EINVAL;
 
 	mutex_lock(&dpll_lock);
 	ret = dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv);
-- 
2.38.1


