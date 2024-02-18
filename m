Return-Path: <linux-kernel+bounces-70465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6BB859842
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C5A2816F9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA1A6EB7E;
	Sun, 18 Feb 2024 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="SD9wlefO"
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C5B6E2C3
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278428; cv=none; b=VJD0lVhhk5tcvhCsWYJ0jz/ej0+iStok+n8iEGd6zWyx0MfIU9dKG0pb85KpwHcP5kd0xsdRlHr0Dk67vpucue4R7R5JhE/7H3XP+t+2qDxTl8OoF1yUy9N0fDxXKx9LnZZhwNBJwAaoD+LgzSusUr70Z2056TV0Ayf9UXxWPnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278428; c=relaxed/simple;
	bh=72fk0PVXRZ8Q4JWxUxUYDfHppG9f2BAjRRu5pbDdVro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iiM6+p3ffeFXxnU8XQFXg3d2bgfouig1T3x5A13/OyvxD43KMGjramhIdLvBkHPFV/I4uqjS9RqXPLGf6oFt88gMie6hQ1WsVb1FG1w6ZM5LHSz5kBgW+mnysvq268zCO2CuF4zELyksTKBRQMXGl4mDS0FzVqhhzpPcoOQwWXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=SD9wlefO; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id blFbr8qYHiCLsblFer7StJ; Sun, 18 Feb 2024 18:46:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1708278417;
	bh=y2+kKbrWEFY2/pmLK9szqs3+euOSxAcesJDdReAip00=;
	h=From:To:Cc:Subject:Date;
	b=SD9wlefOwXg6avVhwSrVQdg+pRLNLNGc+ZUkn8lC/1XFjrHZc30uIj2jPvkEWP5cb
	 wiHSjYsY5V2op+Ln67qbUlLXw/7k3gDzmSapsEgNjU2FE7ZQFZeRAuDAkPHNJi0+9i
	 3O0ClCSTsfy7DletOKheud1v1mlIm1LkH2827FumbJLNPbd7ozcZdiM34zTIQM6eIp
	 iFy+zsBoGPfT58YXmqfV0/faepuFDWLu0whT+sljy78xCEZdC8SGTXALv3bim/xS+r
	 z6Hjxmm8jvIpbKthLpg3OcdQEbqDKstm8BPQdu3EnvoPuV1rqWapIbUpBqLWwioruD
	 Hs+GmnM6RYFgQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 18 Feb 2024 18:46:57 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: gustavo@embeddedor.com,
	keescook@chromium.org,
	Gerd Hoffmann <kraxel@redhat.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org
Subject: [PATCH v2] udmabuf: Fix a potential (and unlikely) access to unallocated memory
Date: Sun, 18 Feb 2024 18:46:44 +0100
Message-ID: <f75d0426a17b57dbddacd7da345c1c62a3dbb7ce.1708278363.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If 'list_limit' is set to a very high value, 'lsize' computation could
overflow if 'head.count' is big enough.

In such a case, udmabuf_create() would access to memory beyond 'list'.

Use memdup_array_user() which checks for overflow.

While at it, include <linux/string.h>.

Fixes: fbb0de795078 ("Add udmabuf misc device")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: - Use memdup_array_user()   [Kees Cook]
    - Use sizeof(*list)   [Gustavo A. R. Silva]
    - Add include <linux/string.h>

v1: https://lore.kernel.org/all/3e37f05c7593f1016f0a46de188b3357cbbd0c0b.1695060389.git.christophe.jaillet@wanadoo.fr/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma-buf/udmabuf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index c40645999648..5728948ea6f2 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/shmem_fs.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/udmabuf.h>
 #include <linux/vmalloc.h>
 #include <linux/iosys-map.h>
@@ -314,14 +315,13 @@ static long udmabuf_ioctl_create_list(struct file *filp, unsigned long arg)
 	struct udmabuf_create_list head;
 	struct udmabuf_create_item *list;
 	int ret = -EINVAL;
-	u32 lsize;
 
 	if (copy_from_user(&head, (void __user *)arg, sizeof(head)))
 		return -EFAULT;
 	if (head.count > list_limit)
 		return -EINVAL;
-	lsize = sizeof(struct udmabuf_create_item) * head.count;
-	list = memdup_user((void __user *)(arg + sizeof(head)), lsize);
+	list = memdup_array_user((void __user *)(arg + sizeof(head)),
+				 sizeof(*list), head.count);
 	if (IS_ERR(list))
 		return PTR_ERR(list);
 
-- 
2.43.2


