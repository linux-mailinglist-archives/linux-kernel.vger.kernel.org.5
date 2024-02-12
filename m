Return-Path: <linux-kernel+bounces-61092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF0D850D27
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 05:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF721F24129
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 04:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158F25396;
	Mon, 12 Feb 2024 04:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S1j14499"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269174694
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 04:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707712120; cv=none; b=THMhUcx7Ef3D7MqBdrVU2+KK3f4kw1ipIleaUqA9W32NBZdKxfr38mcCGQJrXUHkV+T8UnkOYAZK11MoaxpTZ8C5qs7SrNMTbw+j02nFTeqds4aNazk8A7CDFsFrJsLV1Md6/LGxi6LZfr82JpgjKGFNw8DatzBEVhSDUuiHlVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707712120; c=relaxed/simple;
	bh=bd6yJxMcNOgz/8tJXNdeyMpl5daoRnonFofpJ2tgvzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TEe5HW7FmIFvTtjmGZ/x0jCm0xzg6/nhUGW4KFYMo0CcE0n4ANTcDEh7PDcPciNxQFH3th+qNqBEGzk4kc6DNy71eqvwbqIv0HWgd/8xJN7HWharkB9/JFY14gJKXEXP3eOOv9wdO6T+7PNa7BtxJGaXQS3ywmafs/aL6rG2UD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S1j14499; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=79tMagtsx8zWFd0gwV9uxN+xp9p3j086sCtxdA2GSnk=; b=S1j14499hTlFQh4PjQdIe5aq1V
	Yzq4+AHFjY13dZpmxeO8cgp2BIrgk5/6DtVUybA+cU8V7QZzspwdwFy3L+J1BTAjIdEjqQpC5VG5R
	Z0WxNRTokWO5Zihd3TQ8sAm0XYjpOxWVltOS4uK5z1NZw+bvwkfmIkXwLrupuAcodxEgGMpyEcpxP
	WWzAixZpddqKEPv/J/UUJ3olp0QZ0CAew4TE6hAxAww7PPyauYdh9YaRtsYl9vC1vCxED6fySbE6l
	Kv5MowAhPDXBDNcwdTzrKYqXxKXsGm45YTYX4RE2+nSFKlVdhg3XGTwwmFqBGUxfvvomBArTsCLeu
	RCDizLXQ==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZNvq-00000004Iou-1Cay;
	Mon, 12 Feb 2024 04:28:38 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH RESEND] iosys-map: fix typos
Date: Sun, 11 Feb 2024 20:28:37 -0800
Message-ID: <20240212042837.21071-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct spellos/typos in comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
---
 include/linux/iosys-map.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
@@ -85,7 +85,7 @@
  *	if (iosys_map_is_equal(&sys_map, &io_map))
  *		// always false
  *
- * A set up instance of struct iosys_map can be used to access or manipulate the
+ * A setup instance of struct iosys_map can be used to access or manipulate the
  * buffer memory. Depending on the location of the memory, the provided helpers
  * will pick the correct operations. Data can be copied into the memory with
  * iosys_map_memcpy_to(). The address can be manipulated with iosys_map_incr().

