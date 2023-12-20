Return-Path: <linux-kernel+bounces-6432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A5E8198C0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4213F2861A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80915199AB;
	Wed, 20 Dec 2023 06:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e72hiog8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9222418E02;
	Wed, 20 Dec 2023 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=yJ+oDqG2zmO444SiJyKceB+qxN8npAMGhcgnHq7cw2A=; b=e72hiog84p+r45gw6hgXKxK5sH
	4rwkXx/QGErqNyZsbKkY5fYwF05//8+VeIGIetiChkvfb4WY8YOZIlEma7tMCkAMAxJdd162Nmfp+
	MXB/qa6/HjHEXUsabbN9cTDowt5FkkYJA7PmKh/fz2qkynmhgfZDVh2MnH4yBAfiTGGv6oW4G7Td8
	4pirO8A/FzsIaLfiGWx0Xc8AopRIDhdoaK6r3gCSr0z2UMPF2sX/Nh/50V9xtBxFkbUZRMWqsC2yE
	/7gQPAo4oSczBCfrll2nmb32pj/5+LCOUvILTeWBeMJlyEP0c+Cx2KxhnL3/ri/2hmrrKcdnEF5Ds
	POslinEQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFqJN-00GKFj-1v;
	Wed, 20 Dec 2023 06:44:09 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH] bcachefs: mean and variance: fix kernel-doc for function params
Date: Tue, 19 Dec 2023 22:44:09 -0800
Message-ID: <20231220064409.12161-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing function parameter descriptions in mean_and_variance.c.
The also eliminates the "Excess function parameter" warnings.

Prevents these kernel-doc warnings:

mean_and_variance.c:67: warning: Function parameter or member 's' not described in 'mean_and_variance_get_mean'
mean_and_variance.c:78: warning: Function parameter or member 's1' not described in 'mean_and_variance_get_variance'
mean_and_variance.c:94: warning: Function parameter or member 's' not described in 'mean_and_variance_get_stddev'
mean_and_variance.c:108: warning: Function parameter or member 's' not described in 'mean_and_variance_weighted_update'
mean_and_variance.c:108: warning: Function parameter or member 'x' not described in 'mean_and_variance_weighted_update'
mean_and_variance.c:108: warning: Excess function parameter 's1' description in 'mean_and_variance_weighted_update'
mean_and_variance.c:108: warning: Excess function parameter 's2' description in 'mean_and_variance_weighted_update'
mean_and_variance.c:134: warning: Function parameter or member 's' not described in 'mean_and_variance_weighted_get_mean'
mean_and_variance.c:143: warning: Function parameter or member 's' not described in 'mean_and_variance_weighted_get_variance'
mean_and_variance.c:153: warning: Function parameter or member 's' not described in 'mean_and_variance_weighted_get_stddev'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org
---
 fs/bcachefs/mean_and_variance.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff -- a/fs/bcachefs/mean_and_variance.c b/fs/bcachefs/mean_and_variance.c
--- a/fs/bcachefs/mean_and_variance.c
+++ b/fs/bcachefs/mean_and_variance.c
@@ -62,6 +62,7 @@ EXPORT_SYMBOL_GPL(u128_div);
 
 /**
  * mean_and_variance_get_mean() - get mean from @s
+ * @s: mean and variance number of samples and their sums
  */
 s64 mean_and_variance_get_mean(struct mean_and_variance s)
 {
@@ -71,6 +72,7 @@ EXPORT_SYMBOL_GPL(mean_and_variance_get_
 
 /**
  * mean_and_variance_get_variance() -  get variance from @s1
+ * @s1: mean and variance number of samples and sums
  *
  * see linked pdf equation 12.
  */
@@ -89,6 +91,7 @@ EXPORT_SYMBOL_GPL(mean_and_variance_get_
 
 /**
  * mean_and_variance_get_stddev() - get standard deviation from @s
+ * @s: mean and variance number of samples and their sums
  */
 u32 mean_and_variance_get_stddev(struct mean_and_variance s)
 {
@@ -98,8 +101,8 @@ EXPORT_SYMBOL_GPL(mean_and_variance_get_
 
 /**
  * mean_and_variance_weighted_update() - exponentially weighted variant of mean_and_variance_update()
- * @s1: ..
- * @s2: ..
+ * @s: mean and variance number of samples and their sums
+ * @x: new value to include in the &mean_and_variance_weighted
  *
  * see linked pdf: function derived from equations 140-143 where alpha = 2^w.
  * values are stored bitshifted for performance and added precision.
@@ -129,6 +132,7 @@ EXPORT_SYMBOL_GPL(mean_and_variance_weig
 
 /**
  * mean_and_variance_weighted_get_mean() - get mean from @s
+ * @s: mean and variance number of samples and their sums
  */
 s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_weighted s)
 {
@@ -138,6 +142,7 @@ EXPORT_SYMBOL_GPL(mean_and_variance_weig
 
 /**
  * mean_and_variance_weighted_get_variance() -- get variance from @s
+ * @s: mean and variance number of samples and their sums
  */
 u64 mean_and_variance_weighted_get_variance(struct mean_and_variance_weighted s)
 {
@@ -148,6 +153,7 @@ EXPORT_SYMBOL_GPL(mean_and_variance_weig
 
 /**
  * mean_and_variance_weighted_get_stddev() - get standard deviation from @s
+ * @s: mean and variance number of samples and their sums
  */
 u32 mean_and_variance_weighted_get_stddev(struct mean_and_variance_weighted s)
 {

