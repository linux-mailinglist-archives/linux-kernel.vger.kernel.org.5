Return-Path: <linux-kernel+bounces-18997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF161826646
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 23:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54708B2104F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9BA11C81;
	Sun,  7 Jan 2024 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j+t37nJf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D835811717
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=HvQs57VQ1CytAXIK/TuZw2SubdKd9ZHk3DCTT/R+0Bc=; b=j+t37nJfPtIjAofImgOD6vbvoL
	7D5RMKoXQdmp9+OVztMrcAWLWoxa2n955EEyKNu00+D3+CuSsv8LpvpCmBh5FFLqekrPRTzvs7CNR
	ozseYEO2fwnotTkqeLjmqxUEzPdrN2wp6q4n8dW7nFyffG9pZISmRjN9cY072ka+J8V3saf3XE4qQ
	jrxIb11Pnsvp93NJfnOqCghUImAaStZeqJfhaQYoQAV+ZpXIutt2ZLGkfDHGzsdAjG1o784qSfZhx
	xqAM8t69x1Uqs3WfgUbSbYeV8O6YHAQ+Oz8zPOgUhGWgyQDxfCwDHOA2q9mSwceTdfgffWryv4/Yp
	lN3e1nNg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rMbDP-003dx7-39;
	Sun, 07 Jan 2024 22:01:56 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] lib/win_minmax: fix header comments
Date: Sun,  7 Jan 2024 14:01:55 -0800
Message-ID: <20240107220155.29013-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't use "/**" kernel-doc comment marker for non-kernel-doc
comment.

Correct the filename but omit the path since we know where it is
and it could change (but not likely).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/win_minmax.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/include/linux/win_minmax.h b/include/linux/win_minmax.h
--- a/include/linux/win_minmax.h
+++ b/include/linux/win_minmax.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
- * lib/minmax.c: windowed min/max tracker by Kathleen Nichols.
+/*
+ * win_minmax.h: windowed min/max tracker by Kathleen Nichols.
  *
  */
 #ifndef MINMAX_H

