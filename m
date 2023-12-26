Return-Path: <linux-kernel+bounces-11662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDC281E98C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F0B1F218E2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0973522A;
	Tue, 26 Dec 2023 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L7A01Hb4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFD31FC1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kbak+tkdOphm7pOnXQJacjOhwbUh9eBNBikt9IYgrdA=; b=L7A01Hb4nszrlt9e32q1vX+Lc8
	/1U28L4lMov1uE+rN+fF9U2UIAif0C/8LHPE4e45CMcsGfNR6mjUuBw7Us/c32yCzsHFzdHBbvGf+
	5iCg/Q7aCoR6EkgG6xa0ZSbHYZps6DJLzOXUnqMbU87VFkhHURQUTWSjM+U7YjpCcFFiq2v7JYAm/
	YUakzvoPYkLc9DSfWbm9K2VLqcb87cZ5S7cdaRq23w7OaM6aCjq/q3n+Yz1lfjexQ3URhU0qgq/+H
	EmJSCF17+XhHjBtf0j8yG+fTgf1o3J6srSaVrPeTMClOgDvweZpuYufimbtHKJPY8ca9E7kn1P5IW
	ywxC0jFw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIDVa-00DT1I-1H;
	Tue, 26 Dec 2023 19:54:34 +0000
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
Subject: [PATCH v2 4/4] drm/i915/perf: reconcile Excess struct member kernel-doc warnings
Date: Tue, 26 Dec 2023 11:54:32 -0800
Message-ID: <20231226195432.10891-4-rdunlap@infradead.org>
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

i915_perf_types.h:341: warning: Excess struct member 'ptr_lock' description in 'i915_perf_stream'
i915_perf_types.h:341: warning: Excess struct member 'head' description in 'i915_perf_stream'
i915_perf_types.h:341: warning: Excess struct member 'tail' description in 'i915_perf_stream'
3 warnings as Errors

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

 drivers/gpu/drm/i915/i915_perf_types.h |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff -- a/drivers/gpu/drm/i915/i915_perf_types.h b/drivers/gpu/drm/i915/i915_perf_types.h
--- a/drivers/gpu/drm/i915/i915_perf_types.h
+++ b/drivers/gpu/drm/i915/i915_perf_types.h
@@ -291,7 +291,8 @@ struct i915_perf_stream {
 		int size_exponent;
 
 		/**
-		 * @ptr_lock: Locks reads and writes to all head/tail state
+		 * @oa_buffer.ptr_lock: Locks reads and writes to all
+		 * head/tail state
 		 *
 		 * Consider: the head and tail pointer state needs to be read
 		 * consistently from a hrtimer callback (atomic context) and
@@ -313,7 +314,8 @@ struct i915_perf_stream {
 		spinlock_t ptr_lock;
 
 		/**
-		 * @head: Although we can always read back the head pointer register,
+		 * @oa_buffer.head: Although we can always read back
+		 * the head pointer register,
 		 * we prefer to avoid trusting the HW state, just to avoid any
 		 * risk that some hardware condition could * somehow bump the
 		 * head pointer unpredictably and cause us to forward the wrong
@@ -322,7 +324,8 @@ struct i915_perf_stream {
 		u32 head;
 
 		/**
-		 * @tail: The last verified tail that can be read by userspace.
+		 * @oa_buffer.tail: The last verified tail that can be
+		 * read by userspace.
 		 */
 		u32 tail;
 	} oa_buffer;

