Return-Path: <linux-kernel+bounces-28702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F0D83020F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5405C1F24351
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC5314A90;
	Wed, 17 Jan 2024 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNgYTaKa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1C614277;
	Wed, 17 Jan 2024 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483056; cv=none; b=nFGpsAj7WWoepzZ+XdYPTebjD1SoPMd8wX2tRIegIZq8dkwjXA1TXpme+sNE3kTQEmmCEScMGWzLpNoolwmjqrngp01U5OQdIZ9fCBALljSWC78uHhEpUH5VNxefCly7ZZjYW83WBwokjxEBpgeFSi0PBiprVfR43OG3V8ypbYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483056; c=relaxed/simple;
	bh=JfszDlRXPK2fR5IIAOPkEcMe+ndIKpxwfjenwueMKPs=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=CrjbGsz7toTDu05pVTERoccyRBW0kv0L+VzOleBCYB8SomeXuiX9BWrDrMKATxni5BF8h/4nHdbd78zRGmIqco1c4TsxR2/XGS+bp0ofvMZ1A3o3Hs6eb2wQTHqjuL1CliNzKBXWp4VYdPA4fANKmg8iQA6TzkA9P/uIFGEmf/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNgYTaKa; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705483056; x=1737019056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JfszDlRXPK2fR5IIAOPkEcMe+ndIKpxwfjenwueMKPs=;
  b=NNgYTaKaBy97PoS+xSPzf0dYOiqKZnsDUoKTm3Y+52ZSZSS7NF8YGwRZ
   lgnST67ppAN97hCvOXv6ec8PUz2cuSlo03I6Toj+WZ1/59Mu09zcPChet
   rr2ol3CDDkgTDcrXnHrN9impdxL980fhXgxY6unGSfzTX7qZXZQ1p1P5c
   hXbW7PnFIc7ubmLmO2Iw2ZLAP+Cnn8LQqxobJlBq1XLu9kDfCI3cQhxUj
   wynp0gXhZ8n3paAiObnCepKsjxL0TKA7uOxlsrI9bB8dBfIIJdExcnMBN
   v3QjBf/ldM98G5b9dzr0z76RRNLe3Bhtkofxxjc14YBYxyjeZGnt96VUo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="13474521"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="13474521"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 01:17:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="957489775"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="957489775"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orsmga005.jf.intel.com with ESMTP; 17 Jan 2024 01:17:26 -0800
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
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v4 1/4] dpll: fix pin dump crash for rebound module
Date: Wed, 17 Jan 2024 10:14:13 +0100
Message-Id: <20240117091416.504096-2-arkadiusz.kubalewski@intel.com>
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

When a kernel module is unbound but the pin resources were not entirely
freed (other kernel module instance of the same PCI device have had kept
the reference to that pin), and kernel module is again bound, the pin
properties would not be updated (the properties are only assigned when
memory for the pin is allocated), prop pointer still points to the
kernel module memory of the kernel module which was deallocated on the
unbind.

If the pin dump is invoked in this state, the result is a kernel crash.
Prevent the crash by storing persistent pin properties in dpll subsystem,
copy the content from the kernel module when pin is allocated, instead of
using memory of the kernel module.

Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
Reviewed-by: Jan Glaza <jan.glaza@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v4:
- remove unrelated error unwind error path fix -> prepare separated patch
- rename goto labels to: err_<reason>

 drivers/dpll/dpll_core.c    | 54 +++++++++++++++++++++++++++++++++++--
 drivers/dpll/dpll_core.h    |  4 +--
 drivers/dpll/dpll_netlink.c | 28 +++++++++----------
 3 files changed, 68 insertions(+), 18 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 1eca8cc271f8..b62cca4678e8 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -425,6 +425,53 @@ void dpll_device_unregister(struct dpll_device *dpll,
 }
 EXPORT_SYMBOL_GPL(dpll_device_unregister);
 
+static void dpll_pin_prop_free(struct dpll_pin_properties *prop)
+{
+	kfree(prop->package_label);
+	kfree(prop->panel_label);
+	kfree(prop->board_label);
+	kfree(prop->freq_supported);
+}
+
+static int dpll_pin_prop_dup(const struct dpll_pin_properties *src,
+			     struct dpll_pin_properties *dst)
+{
+	memcpy(dst, src, sizeof(*dst));
+	if (src->freq_supported && src->freq_supported_num) {
+		size_t freq_size = src->freq_supported_num *
+				   sizeof(*src->freq_supported);
+		dst->freq_supported = kmemdup(src->freq_supported,
+					      freq_size, GFP_KERNEL);
+		if (!src->freq_supported)
+			return -ENOMEM;
+	}
+	if (src->board_label) {
+		dst->board_label = kstrdup(src->board_label, GFP_KERNEL);
+		if (!dst->board_label)
+			goto err_board_label;
+	}
+	if (src->panel_label) {
+		dst->panel_label = kstrdup(src->panel_label, GFP_KERNEL);
+		if (!dst->panel_label)
+			goto err_panel_label;
+	}
+	if (src->package_label) {
+		dst->package_label = kstrdup(src->package_label, GFP_KERNEL);
+		if (!dst->package_label)
+			goto err_package_label;
+	}
+
+	return 0;
+
+err_package_label:
+	kfree(dst->panel_label);
+err_panel_label:
+	kfree(dst->board_label);
+err_board_label:
+	kfree(dst->freq_supported);
+	return -ENOMEM;
+}
+
 static struct dpll_pin *
 dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	       const struct dpll_pin_properties *prop)
@@ -443,7 +490,9 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 		ret = -EINVAL;
 		goto err;
 	}
-	pin->prop = prop;
+	ret = dpll_pin_prop_dup(prop, &pin->prop);
+	if (ret)
+		goto pin_free;
 	refcount_set(&pin->refcount, 1);
 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
@@ -514,6 +563,7 @@ void dpll_pin_put(struct dpll_pin *pin)
 		xa_destroy(&pin->dpll_refs);
 		xa_destroy(&pin->parent_refs);
 		xa_erase(&dpll_pin_xa, pin->id);
+		dpll_pin_prop_free(&pin->prop);
 		kfree(pin);
 	}
 	mutex_unlock(&dpll_lock);
@@ -636,7 +686,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 	unsigned long i, stop;
 	int ret;
 
-	if (WARN_ON(parent->prop->type != DPLL_PIN_TYPE_MUX))
+	if (WARN_ON(parent->prop.type != DPLL_PIN_TYPE_MUX))
 		return -EINVAL;
 
 	if (WARN_ON(!ops) ||
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index 5585873c5c1b..717f715015c7 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -44,7 +44,7 @@ struct dpll_device {
  * @module:		module of creator
  * @dpll_refs:		hold referencees to dplls pin was registered with
  * @parent_refs:	hold references to parent pins pin was registered with
- * @prop:		pointer to pin properties given by registerer
+ * @prop:		pin properties copied from the registerer
  * @rclk_dev_name:	holds name of device when pin can recover clock from it
  * @refcount:		refcount
  **/
@@ -55,7 +55,7 @@ struct dpll_pin {
 	struct module *module;
 	struct xarray dpll_refs;
 	struct xarray parent_refs;
-	const struct dpll_pin_properties *prop;
+	struct dpll_pin_properties prop;
 	refcount_t refcount;
 };
 
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 3370dbddb86b..30f5be020862 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -303,17 +303,17 @@ dpll_msg_add_pin_freq(struct sk_buff *msg, struct dpll_pin *pin,
 	if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY, sizeof(freq), &freq,
 			  DPLL_A_PIN_PAD))
 		return -EMSGSIZE;
-	for (fs = 0; fs < pin->prop->freq_supported_num; fs++) {
+	for (fs = 0; fs < pin->prop.freq_supported_num; fs++) {
 		nest = nla_nest_start(msg, DPLL_A_PIN_FREQUENCY_SUPPORTED);
 		if (!nest)
 			return -EMSGSIZE;
-		freq = pin->prop->freq_supported[fs].min;
+		freq = pin->prop.freq_supported[fs].min;
 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MIN, sizeof(freq),
 				  &freq, DPLL_A_PIN_PAD)) {
 			nla_nest_cancel(msg, nest);
 			return -EMSGSIZE;
 		}
-		freq = pin->prop->freq_supported[fs].max;
+		freq = pin->prop.freq_supported[fs].max;
 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MAX, sizeof(freq),
 				  &freq, DPLL_A_PIN_PAD)) {
 			nla_nest_cancel(msg, nest);
@@ -329,9 +329,9 @@ static bool dpll_pin_is_freq_supported(struct dpll_pin *pin, u32 freq)
 {
 	int fs;
 
-	for (fs = 0; fs < pin->prop->freq_supported_num; fs++)
-		if (freq >= pin->prop->freq_supported[fs].min &&
-		    freq <= pin->prop->freq_supported[fs].max)
+	for (fs = 0; fs < pin->prop.freq_supported_num; fs++)
+		if (freq >= pin->prop.freq_supported[fs].min &&
+		    freq <= pin->prop.freq_supported[fs].max)
 			return true;
 	return false;
 }
@@ -421,7 +421,7 @@ static int
 dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
 		     struct netlink_ext_ack *extack)
 {
-	const struct dpll_pin_properties *prop = pin->prop;
+	const struct dpll_pin_properties *prop = &pin->prop;
 	struct dpll_pin_ref *ref;
 	int ret;
 
@@ -717,7 +717,7 @@ dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32 parent_idx,
 	int ret;
 
 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
-	      pin->prop->capabilities)) {
+	      pin->prop.capabilities)) {
 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
 		return -EOPNOTSUPP;
 	}
@@ -753,7 +753,7 @@ dpll_pin_state_set(struct dpll_device *dpll, struct dpll_pin *pin,
 	int ret;
 
 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
-	      pin->prop->capabilities)) {
+	      pin->prop.capabilities)) {
 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
 		return -EOPNOTSUPP;
 	}
@@ -780,7 +780,7 @@ dpll_pin_prio_set(struct dpll_device *dpll, struct dpll_pin *pin,
 	int ret;
 
 	if (!(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE &
-	      pin->prop->capabilities)) {
+	      pin->prop.capabilities)) {
 		NL_SET_ERR_MSG(extack, "prio changing is not allowed");
 		return -EOPNOTSUPP;
 	}
@@ -808,7 +808,7 @@ dpll_pin_direction_set(struct dpll_pin *pin, struct dpll_device *dpll,
 	int ret;
 
 	if (!(DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE &
-	      pin->prop->capabilities)) {
+	      pin->prop.capabilities)) {
 		NL_SET_ERR_MSG(extack, "direction changing is not allowed");
 		return -EOPNOTSUPP;
 	}
@@ -838,8 +838,8 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
 	int ret;
 
 	phase_adj = nla_get_s32(phase_adj_attr);
-	if (phase_adj > pin->prop->phase_range.max ||
-	    phase_adj < pin->prop->phase_range.min) {
+	if (phase_adj > pin->prop.phase_range.max ||
+	    phase_adj < pin->prop.phase_range.min) {
 		NL_SET_ERR_MSG_ATTR(extack, phase_adj_attr,
 				    "phase adjust value not supported");
 		return -EINVAL;
@@ -1023,7 +1023,7 @@ dpll_pin_find(u64 clock_id, struct nlattr *mod_name_attr,
 	unsigned long i;
 
 	xa_for_each_marked(&dpll_pin_xa, i, pin, DPLL_REGISTERED) {
-		prop = pin->prop;
+		prop = &pin->prop;
 		cid_match = clock_id ? pin->clock_id == clock_id : true;
 		mod_match = mod_name_attr && module_name(pin->module) ?
 			!nla_strcmp(mod_name_attr,
-- 
2.38.1


