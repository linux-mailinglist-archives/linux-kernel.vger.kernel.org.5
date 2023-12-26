Return-Path: <linux-kernel+bounces-11660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1EF81E984
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4A21C2105B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C7E29B4;
	Tue, 26 Dec 2023 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XpLq3aLs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104CC1FAD
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=21wQk0jscaODvVpni8xGD2rI9Yw0sdDCJDIjv7Nhv4I=; b=XpLq3aLsCCrZgGbZlZvPF1X29W
	+mNLf0pIpRdl9uXlg5v2B4xunqNfItuRfvYHwuJ3QlDjBW4Dre5/37V49wEqp6OapAtv0ckX4qauh
	53h/0Sbl5uk7e3n7zkFjeBeG/ieSwEr7tW4Vz8PdCe68Oq7BxQEjxxYJxwB0xI2z9gqd9YG1ZOS1B
	45Kwgx8DMQ6mQ4QJhMNVCnmZS3kbAgmRfPge80uVU3vwemz6ErFonguSqjaowmB4SQZza0ZGNnqxX
	VxqM3nRB9F5sSdL3g+lJCcLYLJlOBrFEEweINTDDJZV00m4qaLhRSIPjvmZP5/VA4ZVy2tyY0HRNw
	QzNr26fA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIDVZ-00DT1I-2F;
	Tue, 26 Dec 2023 19:54:33 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	Jonathan Corbet <corbet@lwn.net>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/4] drm/i915/gt: reconcile Excess struct member kernel-doc warnings
Date: Tue, 26 Dec 2023 11:54:30 -0800
Message-ID: <20231226195432.10891-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226195432.10891-1-rdunlap@infradead.org>
References: <20231226195432.10891-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document nested struct members with full names as described in
Documentation/doc-guide/kernel-doc.rst.

intel_gsc.h:34: warning: Excess struct member 'gem_obj' description in 'intel_gsc'

Also add missing field member descriptions.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
v2: add Reviewed-by: Rodrigo
    rebase and resend due to (i915) patchwork being down

 drivers/gpu/drm/i915/gt/intel_gsc.h |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff -- a/drivers/gpu/drm/i915/gt/intel_gsc.h b/drivers/gpu/drm/i915/gt/intel_gsc.h
--- a/drivers/gpu/drm/i915/gt/intel_gsc.h
+++ b/drivers/gpu/drm/i915/gt/intel_gsc.h
@@ -21,8 +21,11 @@ struct mei_aux_device;
 /**
  * struct intel_gsc - graphics security controller
  *
- * @gem_obj: scratch memory GSC operations
- * @intf : gsc interface
+ * @intf :	gsc interface
+ * @intf.adev :	MEI aux. device for this @intf
+ * @intf.gem_obj : scratch memory GSC operations
+ * @intf.irq :	IRQ for this device (%-1 for no IRQ)
+ * @intf.id :	this interface's id number/index
  */
 struct intel_gsc {
 	struct intel_gsc_intf {

