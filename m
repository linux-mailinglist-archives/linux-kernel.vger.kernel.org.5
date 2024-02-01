Return-Path: <linux-kernel+bounces-48881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC6F8462AD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1691F24D0B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E380A3FB19;
	Thu,  1 Feb 2024 21:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBYOicDO"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9097E3E491
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706823278; cv=none; b=fxEq6pwfF3zINaPzGYaGJMdLS+g9r8aEH7P2LjXw3GqFhEP3Z+rRs0mGRofMs2bkNIDD/AQVEI+R8tZyXH6edNbwKjCBrC3t0KgoBs3D4F9oyyt1Jgq2a7iDCuJtWpqzAPf2y0l1MjHUGWf29H/2pF+gqW0kcOLKyTMHbwcQ/s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706823278; c=relaxed/simple;
	bh=rZrTvmLO32ue83Wuz3xqEY+uT6j76FWBRjAdq8bhOuk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TxLkTLEoigEFsGnE1hxY19a3iLeBHPc8IPpjGiyoq26RhsAelzcnp18mxhRVtU9TJlTIpwoYjvCqxVvnD9wseklTZi767yiOZBKr/AS+u05jLqHAM/m7kdF8UbPfATsmJ/rE7yrEHOPS3t1wKZifad9wPfgpgOPrba4kA1Z2YpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EBYOicDO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60406626b50so30953127b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 13:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706823275; x=1707428075; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p/ZSORHpensQ8OOs9+q/lB48Cp/PdVGCaffXK4MOExw=;
        b=EBYOicDOkYD9Zr6NiY9Owzl3mJWl1+hn97ADfF1G6SNR6FHi65plCuKGvH3S5l/D9t
         UsYL3HvCdtLB5CzoW82EmFRf5KYLOpQnRvSJrLkBlbEmX89NBggTiXtMzPuOr0G2j402
         jfsaEeIPgKaAWTbarh+m+GSkeu71UbgajsZLlw29dB/9V7tiWtKtA/XCYffmmpERR+k0
         MFoLt0TTHLbN5mKba/sJq/DtKuBf9MAHM5RxasNL0zm5Gaz1Q77jinlno2tLU+qtJ6ry
         i5d7wuS8KcsxwVu0ZNNqlDpTiwgWTXlUnIosHbpyG/5pv95tcFGWmi27Z1d8a8Fs2ajd
         XgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706823275; x=1707428075;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/ZSORHpensQ8OOs9+q/lB48Cp/PdVGCaffXK4MOExw=;
        b=hsaSyUUZakV5hDjXIwUEmUr7vWNaFR5dcXG7htnKN6YPsYIKvBItX9jBKANxgZjSxG
         jy8A3OdA8A9TTT5LcFUw/7QOt9hV5ooFfyA16FQwnLmh0FiEL3dxUlOsMg4eKayNcQ0g
         ixIRAkprrfVF8OeEEPvyHdNwApDkWpER8S6B/Sx89M7RpAq+AETTpq9KzT3lQ0AjaBQZ
         9EprcXK71wciswKJ7L5ewDIjEVTebzByucalx/YTYIl5oCq28CUuzWTrjS15eRTrpCpe
         NW0OhppE9rxWX6BMNhKEMepXwS+0va8KBtnSxtaM66F6tFAV4SPpKcldO1SKuXUNKne9
         JL4g==
X-Gm-Message-State: AOJu0YxmH02lrXf/du0jVbc6DFK34rnrv2m8rdCo3+erTJzFXQHSlARQ
	t20qUMN8h2GC2SnNwD+JCVmE/doYfrakaIt5d/GvNWa1flVJMbk8ez0a63IAH7NEj9diywSy6es
	jxZPFAtyQL1E3DUn2Uov7q71p4UyXgfPqTJmxnfdl9nENBx8B7MsF3QVQSPZ6/7eFe8cFCNtjCq
	gHWZvVChJlMQhve+r4dGfhJCBqgxkLHa7j3sLVaLgDKEraylIhCxwDRjTAj+aOWLiyZd4=
X-Google-Smtp-Source: AGHT+IGjH1o8u1o0qhoc80xgcmS1fcTFWe53VpvLZW0tNgnNBO3CAvd1WPlGyi/zrkiMevhXYkAe9lTYX3kMISTIzQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:4c26:ae83:34fc:80a5])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:108e:b0:dbd:b165:441 with
 SMTP id v14-20020a056902108e00b00dbdb1650441mr80976ybu.0.1706823275454; Thu,
 01 Feb 2024 13:34:35 -0800 (PST)
Date: Thu,  1 Feb 2024 13:34:25 -0800
In-Reply-To: <20240201213429.4120839-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201213429.4120839-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240201213429.4120839-2-almasrymina@google.com>
Subject: [PATCH net-next v7 1/2] net: introduce abstraction for network memory
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add the netmem_ref type, an abstraction for network memory.

To add support for new memory types to the net stack, we must first
abstract the current memory type. Currently parts of the net stack
use struct page directly:

- page_pool
- drivers
- skb_frag_t

Originally the plan was to reuse struct page* for the new memory types,
and to set the LSB on the page* to indicate it's not really a page.
However, for compiler type checking we need to introduce a new type.

netmem_ref is introduced to abstract the underlying memory type.
Currently it's a no-op abstraction that is always a struct page
underneath. In parallel there is an undergoing effort to add support
for devmem to the net stack:

https://lore.kernel.org/netdev/20231208005250.2910004-1-almasrymina@google.com/

netmem_ref can be pointers to different underlying memory types, and the
low bits are set to indicate the memory type. Helpers are provided
to convert netmem pointers to the underlying memory type (currently only
struct page). In the devmem series helpers are provided so that calling
code can use netmem without worrying about the underlying memory type
unless absolutely necessary.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v7:
- Fix netmem_ref kdoc.

v6:
- Applied Reviewed-by from Shakeel.

rfc v5:
- RFC due to merge window.
- Change to 'typedef unsigned long __bitwise netmem_ref;'
- Fixed commit message (Shakeel).
- Did not apply Shakeel's reviewed-by since the code changed
  significantly.

v4:
- use 'struct netmem;' instead of 'typedef void *__bitwise netmem_ref;'

  Using __bitwise with a non-integer type was wrong and triggered many
  patchwork bot errors/warnings.

  Using an integer type causes the compiler to warn when casting NULL to
  the integer type.

  Attempt to use an empty struct for our opaque network memory.

v3:

- Modify struct netmem from a union of struct page + new types to an opaque
  netmem_ref type.  I went with:

  +typedef void *__bitwise netmem_ref;

  rather than this that Jakub recommended:

  +typedef unsigned long __bitwise netmem_ref;

  Because with the latter the compiler issues warnings to cast NULL to
  netmem_ref. I hope that's ok.

- Add some function docs.

v2:

- Use container_of instead of a type cast (David).
---
 include/net/netmem.h | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 include/net/netmem.h

diff --git a/include/net/netmem.h b/include/net/netmem.h
new file mode 100644
index 000000000000..d8b810245c1d
--- /dev/null
+++ b/include/net/netmem.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ *	Network memory
+ *
+ *	Author:	Mina Almasry <almasrymina@google.com>
+ */
+
+#ifndef _NET_NETMEM_H
+#define _NET_NETMEM_H
+
+/**
+ * typedef netmem_ref - a nonexistent type marking a reference to generic
+ * network memory.
+ *
+ * A netmem_ref currently is always a reference to a struct page. This
+ * abstraction is introduced so support for new memory types can be added.
+ *
+ * Use the supplied helpers to obtain the underlying memory pointer and fields.
+ */
+typedef unsigned long __bitwise netmem_ref;
+
+/* This conversion fails (returns NULL) if the netmem_ref is not struct page
+ * backed.
+ *
+ * Currently struct page is the only possible netmem, and this helper never
+ * fails.
+ */
+static inline struct page *netmem_to_page(netmem_ref netmem)
+{
+	return (__force struct page *)netmem;
+}
+
+/* Converting from page to netmem is always safe, because a page can always be
+ * a netmem.
+ */
+static inline netmem_ref page_to_netmem(struct page *page)
+{
+	return (__force netmem_ref)page;
+}
+
+#endif /* _NET_NETMEM_H */
-- 
2.43.0.594.gd9cf4e227d-goog


