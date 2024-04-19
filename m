Return-Path: <linux-kernel+bounces-151919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564C28AB5C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D5C283678
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9641813C9C3;
	Fri, 19 Apr 2024 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="no/tkbmQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5BA131188;
	Fri, 19 Apr 2024 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713556270; cv=none; b=f6CbEJRv5DfKmFu0RDLmMRSCKw6UyHw3woocBuT5XpbpcyQQVZWLSxtyW9lpC1Gv6zdwAMg3BRhs/Rijo4qEnlWOttegtFMWw6WCPtjQuinAEqz6tVedEExKoZ2JlJlPcnTIwiXVthzvu/uol37Pw1mMwtUYqs7XpqJg/qXfDrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713556270; c=relaxed/simple;
	bh=I+KaRSuYYHq33wzOX7I6A8aqVWCW9ldBZFg7/uknzuA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gwBkPmT/+2hAlzX5xkp342kY4qMHWrA4v0VtYNGrJYjrbhjUWfQjt4VJlarW6++7DNwrols26Tk+dcCE+N6tfJCJHTS2djnfnQjsxEjqSsN/VCZfcmQC6Bq9YSbEfE49C9iLqEk2oIvB/WD5ZGEo64i9bzNZB3cGnuL9YqrfclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=no/tkbmQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713556269; x=1745092269;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I+KaRSuYYHq33wzOX7I6A8aqVWCW9ldBZFg7/uknzuA=;
  b=no/tkbmQhuHqWNGiTmyi1SeRcFY3VOVMhTwqXLiUNIxwi7NY62vpYhpb
   HOJ16Y8tK4HqzBMocFVcL5W4UmK+liUgWdlmy8yjBNuzmM3oZ0lOdHPsp
   MMWi9vvYCwmdi9TIIg4dqwNNaUnHmPVkgdczf51J7kajz/hLF03K1ux2R
   KdisCNMRJXHDRJ1HktA7w4lnCOZB0YeHkH8r4ChVScU2jHtNpDjxxpDOZ
   a5pC6BjJ9qGMXg8Hjsv1DeTTzWRyIMLOWZ6Y0bzfXizQ1Dnd6P4RRzRId
   8FRI36yfeAO4RXpMmJSQchIUXva3n+FpsIvjw+5yR/gfe7JgOo6pnfJba
   Q==;
X-CSE-ConnectionGUID: ClTWVIqbQ7KhaG7fr6gd8g==
X-CSE-MsgGUID: GSGavcpDTxaDsROCsUY8wg==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9046272"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="9046272"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 12:51:08 -0700
X-CSE-ConnectionGUID: Xe14cQuhRnyFFqD/ir7/JA==
X-CSE-MsgGUID: lljCEdhZS5OOh17gqeJo+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="46723350"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa002.fm.intel.com with ESMTP; 19 Apr 2024 12:51:05 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	davem@davemloft.net,
	rrameshbabu@nvidia.com,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	mschmidt@redhat.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net] dpll: fix dpll_pin_registration missing refcount
Date: Fri, 19 Apr 2024 21:47:11 +0200
Message-Id: <20240419194711.1075349-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In scenario where pin is registered with multiple parent pins via
dpll_pin_on_pin_register(..), belonging to the same dpll device,
and each time with the same set of ops/priv data, a reference
between a pin and dpll is created once and then refcounted, at the same
time the dpll_pin_registration is only checked for existence and created
if does not exist. This is wrong, as for the same ops/priv data a
registration shall be also refcounted, a child pin is also registered
with dpll device, until each child is unregistered the registration data
shall exist.

Add refcount and check if all registrations are dropped before releasing
dpll_pin_registration resources.

Currently, the following crash/call trace is produced when ice driver is
removed on the system with installed NIC which includes dpll device:

WARNING: CPU: 51 PID: 9155 at drivers/dpll/dpll_core.c:809 dpll_pin_ops+0x20/0x30
Call Trace:
 dpll_msg_add_pin_freq+0x37/0x1d0
 dpll_cmd_pin_get_one+0x1c0/0x400
 ? __nlmsg_put+0x63/0x80
 dpll_pin_event_send+0x93/0x140
 dpll_pin_on_pin_unregister+0x3f/0x100
 ice_dpll_deinit_pins+0xa1/0x230 [ice]
 ice_remove+0xf1/0x210 [ice]

Fixes: b446631f355e ("dpll: fix dpll_xa_ref_*_del() for multiple registrations")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/dpll/dpll_core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 64eaca80d736..7ababa327c0c 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -40,6 +40,7 @@ struct dpll_device_registration {
 
 struct dpll_pin_registration {
 	struct list_head list;
+	refcount_t refcount;
 	const struct dpll_pin_ops *ops;
 	void *priv;
 };
@@ -81,6 +82,7 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct dpll_pin *pin,
 		reg = dpll_pin_registration_find(ref, ops, priv);
 		if (reg) {
 			refcount_inc(&ref->refcount);
+			refcount_inc(&reg->refcount);
 			return 0;
 		}
 		ref_exists = true;
@@ -113,6 +115,7 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct dpll_pin *pin,
 	reg->priv = priv;
 	if (ref_exists)
 		refcount_inc(&ref->refcount);
+	refcount_set(&reg->refcount, 1);
 	list_add_tail(&reg->list, &ref->registration_list);
 
 	return 0;
@@ -131,8 +134,10 @@ static int dpll_xa_ref_pin_del(struct xarray *xa_pins, struct dpll_pin *pin,
 		reg = dpll_pin_registration_find(ref, ops, priv);
 		if (WARN_ON(!reg))
 			return -EINVAL;
-		list_del(&reg->list);
-		kfree(reg);
+		if (refcount_dec_and_test(&reg->refcount)) {
+			list_del(&reg->list);
+			kfree(reg);
+		}
 		if (refcount_dec_and_test(&ref->refcount)) {
 			xa_erase(xa_pins, i);
 			WARN_ON(!list_empty(&ref->registration_list));
@@ -160,6 +165,7 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct dpll_device *dpll,
 		reg = dpll_pin_registration_find(ref, ops, priv);
 		if (reg) {
 			refcount_inc(&ref->refcount);
+			refcount_inc(&reg->refcount);
 			return 0;
 		}
 		ref_exists = true;
@@ -192,6 +198,7 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct dpll_device *dpll,
 	reg->priv = priv;
 	if (ref_exists)
 		refcount_inc(&ref->refcount);
+	refcount_set(&reg->refcount, 1);
 	list_add_tail(&reg->list, &ref->registration_list);
 
 	return 0;
@@ -211,8 +218,10 @@ dpll_xa_ref_dpll_del(struct xarray *xa_dplls, struct dpll_device *dpll,
 		reg = dpll_pin_registration_find(ref, ops, priv);
 		if (WARN_ON(!reg))
 			return;
-		list_del(&reg->list);
-		kfree(reg);
+		if (refcount_dec_and_test(&reg->refcount)) {
+			list_del(&reg->list);
+			kfree(reg);
+		}
 		if (refcount_dec_and_test(&ref->refcount)) {
 			xa_erase(xa_dplls, i);
 			WARN_ON(!list_empty(&ref->registration_list));

base-commit: ac1a21db32eda8a09076bad025d7b848dd086d28
-- 
2.38.1


