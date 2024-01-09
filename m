Return-Path: <linux-kernel+bounces-20250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D566C827C6E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B4D1C22E70
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047DB4418;
	Tue,  9 Jan 2024 01:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KxrhJOEC"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021AC15A4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 01:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbeac1f5045so3098944276.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 17:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704762900; x=1705367700; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iiR5N2IDxIjhT8/ImfsmGNpE4EHm5swVTh/rfapPQuI=;
        b=KxrhJOECZVq0swda5+Awr1AC+TOrrHUgwnHAmKXYyPk1IpO4I4qda3IisDOwDaVNlj
         0YNJ2iD5w7uN/kyOB8r0P7ePgADInBANgbvaoIFr8qcgs2s10ciq+06x4pZmVS6vVN45
         QpBvYjZ0Km6rD4Zs8umqodFSPJ/JMB0Gw2lw3nWGDJ7jc6M/4HNXw5c6AJc/3zcX/gSF
         w5uJyBmKspQL2qLc2Y9nE1jcztfoaZIK5YPl00GR8qGJQzz4KbqDG8iTXy5JyGVckbKp
         J06uplp/yiXJWBQKttJ/F5cQHujoh3Ik++CZMymVmVo0obZTPZQg/FKTpPkoeBFQt2nw
         FqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704762900; x=1705367700;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iiR5N2IDxIjhT8/ImfsmGNpE4EHm5swVTh/rfapPQuI=;
        b=tViCUELeF1DXizJtMO5UFnKmizvMufbC61qIrnw82akhks3XRwrbZEM/i/d4rHJc+C
         9ULk277V49Gbblj6WA5zA08FT36FO9VkCO3C9qv3ywdHAxOlQcAs2VHia+mGcTzfo6FD
         ZncRL3I7gqKS4wgBgp1cSYBb2AaHJLOMDZAC0kPLQB+/AY9zvMammiaFdTAKac6Us8v/
         0yZivKJ6XFLwDt2pMdPepo7pfz53octHnz0vuxr9pq1KyDKrGxNLMy9fZwLGgIShwV1S
         UPIMLHx+qEKrPfHFb4PuES0RUyUXuvUbuRkaJzTPFK/ZPGEvh/MmqVo4SYqXbwh1ZJEC
         GHbg==
X-Gm-Message-State: AOJu0YyibXDXQruptyfoCZ11nuMHMbyZLq25Zqs/dMNol8bzpv0qxFZD
	/FEyxE5dRA+Gz/YOzeQ7+6iiVonWkfERTInPkFB/Jf62zEhv4s8wJEropou6YT8Ytj2nriBnwAc
	XjPuSdDIbv9psdBgnhPV/xnMuKNIBKj3atWYCqj6G4x4jRhPv+ejHdqTqD2hAeZN/n2fL7v4K8n
	qpHzkgOioACrq1zg==
X-Google-Smtp-Source: AGHT+IGxkvzCYnhf9wFca2+dp8mcCWrrMgZHuBUIw5hZRfjJeUDRtokP7+RnrrYFTOWxFU7NF8ERhEFW+QCMhpP48Q==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:23bb:bfcc:9879:32e2])
 (user=almasrymina job=sendgmr) by 2002:a25:b281:0:b0:dbd:c21f:eb89 with SMTP
 id k1-20020a25b281000000b00dbdc21feb89mr221517ybj.1.1704762899931; Mon, 08
 Jan 2024 17:14:59 -0800 (PST)
Date: Mon,  8 Jan 2024 17:14:51 -0800
In-Reply-To: <20240109011455.1061529-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240109011455.1061529-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240109011455.1061529-2-almasrymina@google.com>
Subject: [RFC PATCH net-next v5 1/2] net: introduce abstraction for network memory
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

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

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
index 000000000000..9f327d964782
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
+ * netmem_ref - a nonexistent type marking a reference to generic network
+ * memory.
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
2.43.0.472.g3155946c3a-goog


