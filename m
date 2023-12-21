Return-Path: <linux-kernel+bounces-7805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652B181AD3E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96FCD1C2234B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3862156CE;
	Thu, 21 Dec 2023 03:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cxGL4qZq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9750CF9FC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uNEK+CxMh6qX0p3sx3zeo+Q9G/JTi2IoSv3JGx0Jd68=; b=cxGL4qZqLeAlP/OS3/K0PMWu8U
	ihlfoW83p4bpMZXxN9rTJNV6u9n/gqDJJIqYwZ0xhE57Ie5LoIeWIaOG34Fj+j6cuUSFpe9TWPhRP
	RCZAWKt4YI4okiwzLMAN5JNQb6e8vPtipWUnHALzp0xovTPQECwfp2nONK/nluzCb5p61RMCJyO/E
	cT3f4v9wgUVswQYksIdB+nfyTOrx8jWzoA6b5ji52Yq73+ViKIGbAhgVAIarA/vRj0z3B1aj0vT7E
	3FIkVqJYx7C9lRL5FrtFrrqtLN1shofpe0mZRv3DDsECYvO/vQ0dtaWHRPcvVdma+YWG7rn2H6v/7
	OQ8whw0A==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rG9bq-001aN9-1s;
	Thu, 21 Dec 2023 03:20:30 +0000
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
Subject: [PATCH 2/4] drm/i915/gt: reconcile Excess struct member kernel-doc warnings
Date: Wed, 20 Dec 2023 19:20:27 -0800
Message-ID: <20231221032029.30942-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221032029.30942-1-rdunlap@infradead.org>
References: <20231221032029.30942-1-rdunlap@infradead.org>
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
---
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

