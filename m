Return-Path: <linux-kernel+bounces-142693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872D88A2EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D22F1F2152C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4635F873;
	Fri, 12 Apr 2024 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OIYowc/D"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAC13EA83;
	Fri, 12 Apr 2024 13:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927356; cv=none; b=AMDZYOBB4iqKuvK0z967aFdnVURX+Zrs+02UPd7o8qmt7kZ9gMY45rgZ5PRakxsMLdymluQfxvjI+BBp6kXKdigJ52CShQBVSiniI7WfBGwcDzy+4hwsmIFi7mQQND11FTzQDSX1cHRD1CxCUS8gll4/EvAPEswdrm8Sy1JfiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927356; c=relaxed/simple;
	bh=gY/J7/J1lZWqmcEQqo/U8q+U1/cFFpdrPaU/Htjfo/o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DfAueNbdqaRUVSKBWx9Kq7Y830gfHL4aEb8KnT0CVHBDX84Z3LMNqgJvHotrfhP979SAxuDaBFfV/6QPacBeepFDCN4G3u6ILhv1iofd8wr96AUZlSaURuM9cOEWdUdWv5Aav8hzvgrVImkTzWLivz6c/eiA0b3nZutGee+OPJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OIYowc/D; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712927355; x=1744463355;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gY/J7/J1lZWqmcEQqo/U8q+U1/cFFpdrPaU/Htjfo/o=;
  b=OIYowc/Dq9rw6HOZxlpc+7ZDkBn4SAKBtWM4SoBScnEC55uWYCe4NjgF
   6wxuClXnmEHxcMQsbCD6DqAcUrNejYhb+1FbcMydzai1xB5O3yGMy/g3x
   N2YIdpwX8puYdLYOK+P488M+d7cg6nlqoDOq5iF90yX9h8QxI/3oDZrnM
   ph9/bHpsIOFDnCZ1zXGTKPJWMXXr5MFnSIjFhDzbq70QpJkWtOApRmWAT
   jfzDc9lmvDs2N571KnCs/2RN57cd3Csv+ltPBQyheUWFqtcZ526+ACyA5
   HaYUhabtVRJhiS+Px0oEXWRsyKBQNRwlq0rP6Jn77dO/u5fZs6+WuxMEo
   A==;
X-CSE-ConnectionGUID: VeOK2D+rTx2f3SFoCdlHXA==
X-CSE-MsgGUID: MwaEW81oQ+WR3jYN0HOmfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="33775310"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="33775310"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 06:09:14 -0700
X-CSE-ConnectionGUID: pVgmtzzERDCx+hYK6w0hXQ==
X-CSE-MsgGUID: F0BalwvfST2fymMA5qpojA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21293123"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.32])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 06:09:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Mark Pearson <markpearson@lenovo.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] platform/x86: think-lmi: Convert container_of() macros to static inline
Date: Fri, 12 Apr 2024 16:09:03 +0300
Message-Id: <20240412130903.2836-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The macros to_tlmi_pwd_setting() and to_tlmi_attr_setting() are fragile
because they expect the variable name to be 'kobj', otherwise the build
will fail because container_of()'s 3rd parameter (member) is taken from
the parameter given to the macro.

While at it, move them into a more logical place.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/think-lmi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 9345316b45db..0f2264bb7577 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -175,9 +175,6 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
 #define TLMI_SMP_PWD BIT(6) /* System Management */
 #define TLMI_CERT    BIT(7) /* Certificate Based */
 
-#define to_tlmi_pwd_setting(kobj)  container_of(kobj, struct tlmi_pwd_setting, kobj)
-#define to_tlmi_attr_setting(kobj)  container_of(kobj, struct tlmi_attr_setting, kobj)
-
 static const struct tlmi_err_codes tlmi_errs[] = {
 	{"Success", 0},
 	{"Not Supported", -EOPNOTSUPP},
@@ -198,6 +195,16 @@ static struct think_lmi tlmi_priv;
 static const struct class *fw_attr_class;
 static DEFINE_MUTEX(tlmi_mutex);
 
+static inline struct tlmi_pwd_setting *to_tlmi_pwd_setting(struct kobject *kobj)
+{
+	return container_of(kobj, struct tlmi_pwd_setting, kobj);
+}
+
+static inline struct tlmi_attr_setting *to_tlmi_attr_setting(struct kobject *kobj)
+{
+	return container_of(kobj, struct tlmi_attr_setting, kobj);
+}
+
 /* Convert BIOS WMI error string to suitable error code */
 static int tlmi_errstr_to_err(const char *errstr)
 {
-- 
2.39.2


