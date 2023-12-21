Return-Path: <linux-kernel+bounces-7804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D44D81AD36
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C3D2836C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB9413AD4;
	Thu, 21 Dec 2023 03:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d5zq35gg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9754EFBEA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Om7KGzS/g2Y7wQ9rvSrrGdz3FHj7wYsDCL1dsHV/Wu0=; b=d5zq35ggn427N91YatbcRRHKN0
	btcolbNdCwea4DDkcdb1wfpYKzT/VxA7xPTpjEl/a8QCUHr20uiNrTAUAmXc12Zvf3wEeKliw4oD2
	drCBHe+Kmkjwf4c7jLY4Qfm3hbHvq+jaglYk5prI062CenLStMBKcEjy/8QrLcwj2EGALGMcPiNsd
	W3hvUag1HDi8G/eQ5/REPo8QKGIgPGWSHT32TamJtNySJvbvH1fWe3m+BSHVVocY1wFExCXxI+Nah
	F1pYLuzY+kMSe5uYU7qaHs4gBdg96o/ckHNoWiWAwp57ZB7hvr9tBgfosWU3KPAIb2SUe2/+bfh4R
	NpQklf8A==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rG9br-001aN9-0c;
	Thu, 21 Dec 2023 03:20:31 +0000
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
Subject: [PATCH 4/4] drm/i915/perf: reconcile Excess struct member kernel-doc warnings
Date: Wed, 20 Dec 2023 19:20:29 -0800
Message-ID: <20231221032029.30942-4-rdunlap@infradead.org>
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
---
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

