Return-Path: <linux-kernel+bounces-11663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C90FE81E98D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84228282699
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08992523E;
	Tue, 26 Dec 2023 19:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P/F1XcCX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5961FA4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Rr4zZlZeeGcP+0FJ74qNZJLVzA73VMRgRJ8o8EqCzVc=; b=P/F1XcCXAwd3b4bw3Mr/MUXT2T
	3O9/8xY0wu0NlfzE/qJVusvjUWYE3KTZYVj1VnnHXMvKzrmmKzEILj09hftfpzlOSr0Daf/epeHTa
	X9Pr+zCXq2Eqh38mMbT65HuI5aCrk1JFx0wGLW9y0zTSbHgEDFNybxZWfUICYmZg3R1iKewvldvcN
	25mZ/jv6SU0IfcCgVRRPZNHMmKZHvzByutV8WR5aXRlRpiPVo2R8t3fuUd7EhWm8/XOxMAXw5SkNi
	e//MsNrqKKT0h7P2C7m7wneAu5drw+wCPpV1TNuHk/LM7hxjJ+bffGwus4yBElMzdyL0jx9QHmtl1
	/Hrv5kAw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIDVZ-00DT1I-17;
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
Subject: [PATCH v2 1/4] drm/i915/gem: reconcile Excess struct member kernel-doc warnings
Date: Tue, 26 Dec 2023 11:54:29 -0800
Message-ID: <20231226195432.10891-1-rdunlap@infradead.org>
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
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
v2: add Reviewed-by: Rodrigo
    rebase and resend due to (i915) patchwork being down

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

