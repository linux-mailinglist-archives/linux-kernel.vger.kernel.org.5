Return-Path: <linux-kernel+bounces-64475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2F8853EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B09E1C247F8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB9A626C4;
	Tue, 13 Feb 2024 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="maguQthq"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11B2605BA
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864141; cv=none; b=i1A7umO9N1GsJI4vuIPTqjpfvdTFj6xBiw0P+PMI4UrbkmUJxDk2KbqGiS9eHYs+RL61MhIkouBkw2hKBDRc/6mABx+GvLH3NBVgVKjIEx0xgQES03Idc/ldc3l4e4R5jsRvlD0p9J5hDINOuJVGsyonapgAYpVrTzxv/Xj1n0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864141; c=relaxed/simple;
	bh=plN2lw9exTbmCCxf4QgVGiGZotU7ZeBqaw5ybkD7lLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YehDV3f3MUVi3auVTqAMD285s/pzo79+QlPM5ka6wTgRw7/qpFvGWHyQqvZZndLsc8Q+wrOCyXm0LrF1G5EDCT6hNx5B2Mg31B+YoHhjfgyGkPFGRW2tLZC+2SUNT+Dd5ijwwx2BqhfGhb5eUJoNbwiL+ewt7zp3aENJ7taasZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=maguQthq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=LlmxAiz2w1clOqh/oi3Em9gmhYSqMdjJu/XRaQqN+Ro=; b=maguQthqS7PI7tg7IGQ4SIH/ZN
	NnSS/TOp3+Ap5Ie3cTAhut67h5NN5N177J1c7VUEBCTSfzSWDgmFz4Mx+xkvkgWHiIodcFXlb7tm3
	OBYRc3MJfEU2o5ywuMz/1EY5AEZnw2OfndZWMLSGQwzpLfdmXiVrURoXn6WtoRkobb5Yn9rCor+6N
	nGNvXG8bXnawfBd1+pHXDn7oY3zaUqLJTdc+mwQOM7bCHb3Qb8h3pWyj5KIlvSJofO7N45jb/oQTK
	QZjhVgzeb7jbijydcyvpYTJNgNVMdAiihp/KQ3UpjFqR9OYPYpyHm9Qr5enTTk2jPk6Z9QWL37FFW
	cXhjZ2cw==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ra1Tn-0000000B7EW-2Ckt;
	Tue, 13 Feb 2024 22:42:19 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2] iosys-map: fix typo
Date: Tue, 13 Feb 2024 14:42:19 -0800
Message-ID: <20240213224219.10644-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct a spello/typo in comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
---
v2: don't change "set up" to "setup" (Thomas)

 include/linux/iosys-map.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/include/linux/iosys-map.h b/include/linux/iosys-map.h
--- a/include/linux/iosys-map.h
+++ b/include/linux/iosys-map.h
@@ -34,7 +34,7 @@
  * the same driver for allocation, read and write operations.
  *
  * Open-coding access to :c:type:`struct iosys_map <iosys_map>` is considered
- * bad style. Rather then accessing its fields directly, use one of the provided
+ * bad style. Rather than accessing its fields directly, use one of the provided
  * helper functions, or implement your own. For example, instances of
  * :c:type:`struct iosys_map <iosys_map>` can be initialized statically with
  * IOSYS_MAP_INIT_VADDR(), or at runtime with iosys_map_set_vaddr(). These

