Return-Path: <linux-kernel+bounces-7803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D839581AD37
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169731C2099F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBDA13AF4;
	Thu, 21 Dec 2023 03:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I1yRndFg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981BEFBFC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=LiVIYSg1d+XSLTzB95bVtSsjQGpYCfcFa5dzKpB5Uj4=; b=I1yRndFgN+zphoGvwhDB3IzZdG
	sembhqwncaGz6jTurdlnfvi9oMSUqRQ/0zY9uoQkzolU2ayQehNbqUf4tfwe85RTzI4tF+YhzNa3s
	QQSfCTGmTMMXyq++4G8pKEqbbBI0uI2MmDyIvvddCri2l9W99TnDUlchOB5bK02GgPZ5P0AGl8DrF
	2mf3rZJHisB/ZvV6yo5w4K+e4QtQoaD3rIa+D2AZJq3HS3dtNCs00Nmckkdf7qO0bvEzeB4Lxmmsx
	COkFYe10Un078vXDxMhzZ2eNrG8ZH4ZoxlvS3imTNTtOzCv2G6vJrpcl3ffoK2ZLJxC9e2Bp9CY5Q
	yVoBIE/w==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rG9bq-001aN9-0v;
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
Subject: [PATCH 1/4] drm/i915/gem: reconcile Excess struct member kernel-doc warnings
Date: Wed, 20 Dec 2023 19:20:26 -0800
Message-ID: <20231221032029.30942-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document nested struct members with full names as described in
Documentation/doc-guide/kernel-doc.rst.

i915_gem_context_types.h:420: warning: Excess struct member 'lock' description in 'i915_gem_context'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/i915/gem/i915_gem_context_types.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/drivers/gpu/drm/i915/gem/i915_gem_context_types.h b/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
--- a/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
@@ -412,9 +412,9 @@ struct i915_gem_context {
 
 	/** @stale: tracks stale engines to be destroyed */
 	struct {
-		/** @lock: guards engines */
+		/** @stale.lock: guards engines */
 		spinlock_t lock;
-		/** @engines: list of stale engines */
+		/** @stale.engines: list of stale engines */
 		struct list_head engines;
 	} stale;
 };

