Return-Path: <linux-kernel+bounces-14857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CFA822342
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8986F1C2174E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48D4171B5;
	Tue,  2 Jan 2024 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MNL4EceK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A990B168D2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e898eb4432so132116677b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 13:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704230842; x=1704835642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ua1kNBJ+w+Y3Am0MQe4kWPDeg8Cx+E0rh5th4nzq7c=;
        b=MNL4EceK0xE1DtiTd6UXEb+JAYB1pom/TSH9H1tgEXHrOvUweoBtJhNVXDoxkFUXom
         sTPXfZB4P7UweEJMp7oLfNyHlww2pRRUKZ14Sa24LAIqHszarlAanMXnP1Umg/YYvwAX
         /www+Dt7sUoO1uQfppmZv/3C5Q9NT0eiQLDZJEJ938scB2cueT0wF2hGF3XvFkLMgn0h
         mYLHMDsOz6F0wdXb0LPSVs0DV0fxrRZQLxjJEDpc85JobdJ15pJ0y7qQnJ9jR4zu0Chy
         YNi0YvsXvHcLvuaTkdmdODvfyoaNi5Dn0lOTbjGBWeqCpOtfg89o2Vk43jsU1T/CnuwA
         Yy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704230842; x=1704835642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ua1kNBJ+w+Y3Am0MQe4kWPDeg8Cx+E0rh5th4nzq7c=;
        b=oaB5CGsEy8Jc5iknPKB2mhOsylnb71XEexY3wK1hCYGbMa+LeIqWRzzJ2/0sqMLJPQ
         CQ5chmOVh7dA4658uQme/K0KKVkkFyWZ19C17Ea+KbBvJ18MyjpgITe+ThNCYt/CDWo/
         1LHkvKnrS7UYxGWr0pzIPTHCfUzKWcRhltTfI4Jh+OIB6Ajv3vp1gCM39rIubhEF6b1o
         1lp/0gJcer4SFYPQzhEcYcPi2Lc0yi5Ki2pe1ogqjyDTwQxKe/m2I0Nz3VtL+Kr411Qs
         +C7WkvolMnUjqyzqg7ZTMLQ1q1HfOTwM+2ii4fQgJwlk0WqFJE9DYnytF6oX+PD9wO71
         93Dg==
X-Gm-Message-State: AOJu0YwVeJ6jDRFU6xwbsFH7MkInyC6/h4jwUEqgmz7gUZqDC6Q4ov6T
	1+m46rSBmK2N8kOFxcMoJuxAXH6rk74XKUzogkFmAZLph/m01cEQWpZiADqUhrjZ6j28goHnx/H
	FbA0SK/AAIF9EhDXkQ5tLuuETTJ5K7nImx1NY6NpFEJBswQYh390+14n4tuvyFnlY4wI4h7AT4g
	eyM1mRX7biqqUeOw==
X-Google-Smtp-Source: AGHT+IFfsq9rzU5qbwwpNbrjG4PnHnpfMmz0iSjvUCZ3agkQwNiVtOi+CeRAKraq69yDp7uCH/p+XQ2tyujR5vbThQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:9a04:c262:c978:d762])
 (user=almasrymina job=sendgmr) by 2002:a81:4c04:0:b0:5f4:393:2a46 with SMTP
 id z4-20020a814c04000000b005f403932a46mr314782ywa.10.1704230842596; Tue, 02
 Jan 2024 13:27:22 -0800 (PST)
Date: Tue,  2 Jan 2024 13:27:14 -0800
In-Reply-To: <20240102212716.810731-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240102212716.810731-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240102212716.810731-2-almasrymina@google.com>
Subject: [RFC PATCH net-next v4 1/2] net: introduce abstraction for network memory
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

netmem_ref is introduced to abstract the underlying memory type. Currently
it's a no-op abstraction that is always a struct page underneath. In
parallel there is an undergoing effort to add support for devmem to the
net stack:

https://lore.kernel.org/netdev/20231208005250.2910004-1-almasrymina@google.com/

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

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
index 000000000000..d821fe0f8147
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
+ * struct netmem - a nonexistent type marking a reference to generic network
+ * memory.
+ *
+ * A struct netmem* currently is always a reference to a struct page. This
+ * abstraction is introduced so support for new memory types can be added.
+ *
+ * Use the supplied helpers to obtain the underlying memory pointer and fields.
+ */
+struct netmem;
+
+/* This conversion fails (returns NULL) if the struct netmem* is not struct page
+ * backed.
+ *
+ * Currently struct page is the only possible netmem, and this helper never
+ * fails.
+ */
+static inline struct page *netmem_to_page(struct netmem *netmem)
+{
+	return (struct page *)netmem;
+}
+
+/* Converting from page to netmem is always safe, because a page can always be
+ * a netmem.
+ */
+static inline struct netmem *page_to_netmem(struct page *page)
+{
+	return (struct netmem *)page;
+}
+
+#endif /* _NET_NETMEM_H */
-- 
2.43.0.472.g3155946c3a-goog


