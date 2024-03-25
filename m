Return-Path: <linux-kernel+bounces-117559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCDD88ADE0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FEEEBE50F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD3E13D605;
	Mon, 25 Mar 2024 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNb+/ZxD"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D977613D527
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386860; cv=none; b=cFLy/BrcJL5tcsYMZYqvBrefWKlybpVmYivfBv4kzdV0dqiVD5SUmWmQnisC21W0ISNzi7XwJZyEzTNNHvEhbR77j3Hp1OgDwstAfAca6PM78a+PTllVA4lOubNPx2uq3ChRFqayYjbYQyt8Ch8N7aeI8+03Fc/Nka0yYLNhlK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386860; c=relaxed/simple;
	bh=4PYRdPCYyOAk+cgs0UXWoGo/KtFhnlDPC531UHMVdfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpaJkmxQZrfF0J9wWcMNUIeZ8HuVsJ8MfuJZjE2BjhMQc6U/4vGoVsq7jcEeMXAmHyrVGgj5cJIX2hDdKC/03iT8x9awcXBmXD+jO5TCm4Z2cCCBNSvoJhvnI4ADWyIkS9sGQPkJTUouAL1ofAWK+az/swRlbQD+q6mSsjMqLJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNb+/ZxD; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a480985625so2524211eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711386858; x=1711991658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6sDmtk9HBtK4D63m2Orr58T2syAmM3af2Tjjpj9AWXM=;
        b=eNb+/ZxDid90Kj5mUDd2MqFSpSG7NDIb3ggBlmRFc7An4iwlgeZn84SgQKbeqtaZdJ
         hNM+rUOnvXsgxsGtmNJnY7iiog2dpkGy2oo9qgzdHYGJefLxW1RGROeeMUAeT0J8/9SU
         3xiKbejEliAHcgbo8+E2xJyBrmkSKOv0qGdyAUj5DdkcW2JU/V9VWzf3vzQ3EsM6paoE
         xV8vNIGyXjmLR9koJeaE7qJktHl2pgqnMw1O9idAci1ERb83F798iB+sgo739exH6oPx
         LsPDZxIjLl/h/8vccJnLxGsKnVuzxdu2w7YMgwc7g+BIkQU3NttYo8ImvNt2viQo2Dyg
         dFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711386858; x=1711991658;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6sDmtk9HBtK4D63m2Orr58T2syAmM3af2Tjjpj9AWXM=;
        b=oAcxEZd9XKxBbFAH9LEchfqnuVf/j8rqMhpvKzbrMoJ1/ZUTs4ssiC27tUoxNBHIC5
         YqqKfVRTI/O1Y9ulorwJUg4UAp8Ly7EvZkTeYaZtdRHn/U+cnxfQrCN2i9+zzRyxE/IH
         qh2UbQyA75Owo2GXAvuZhgu8YHSUk8wGMGeWzHXCWq0rYAzwdXFobhraTCqxADAO3Ka5
         7LELDR0NiEP4HoCQ3rzxKwpuGigaSkxhaHU0hoP1wqAhFeYmka7aXNPni4H8KuEPbq7C
         D6CA6MwPKdKsyMGMHcVXdGzgETqaaqcCgpTQKKJQNTm5VRhvxl3OHr1ThIOW0Yu7O/WT
         qF+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWmm08FFmoJxJi8YkBpFhGk9erACDzQYJIOTT0noxKF40T4/b+Y6hE30F4mdaYwlSCyEkp4+egdWklfXM9BUJz36bQMJOfJHAGo/HA
X-Gm-Message-State: AOJu0YwBhvizw34F516WsUcK6pqX5hLkGF1ZwLgnep41Xf+b9j+8OG9f
	h92bxTUDxRO6+NLbt1tsKImNrw9bH1+KzX7lgIy1yk2dYK8fUqjKuqmSPaFJ6apK7oSb
X-Google-Smtp-Source: AGHT+IH812g8lEhOIH3UUXbXCSKLPkSjpe82QohMIQkOyOH031CL/t5qi83Q7yr/40ax5hVVYS2Ijg==
X-Received: by 2002:a05:6358:3996:b0:17e:9ca7:c3a2 with SMTP id b22-20020a056358399600b0017e9ca7c3a2mr9245069rwe.21.1711386857956;
        Mon, 25 Mar 2024 10:14:17 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id r16-20020a63d910000000b005dc5129ba9dsm6001812pgg.72.2024.03.25.10.14.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Mar 2024 10:14:17 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 3/4] lib/xarray: introduce a new helper xas_get_order
Date: Tue, 26 Mar 2024 01:14:04 +0800
Message-ID: <20240325171405.99971-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325171405.99971-1-ryncsn@gmail.com>
References: <20240325171405.99971-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

It can be used after xas_load to check the order of loaded entries.
Compared to xa_get_order, it saves an XA_STATE and avoid a rewalk.

Also add new test for xas_get_order, to make the test work we have to
export xas_get_order with EXPORT_SYMBOL_GPL.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/xarray.h |  6 ++++++
 lib/test_xarray.c      | 32 +++++++++++++++++++++++++++
 lib/xarray.c           | 49 ++++++++++++++++++++++++++----------------
 3 files changed, 69 insertions(+), 18 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index cb571dfcf4b1..d9d479334c9e 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1548,6 +1548,7 @@ void xas_create_range(struct xa_state *);
 
 #ifdef CONFIG_XARRAY_MULTI
 int xa_get_order(struct xarray *, unsigned long index);
+int xas_get_order(struct xa_state *xas);
 void xas_split(struct xa_state *, void *entry, unsigned int order);
 void xas_split_alloc(struct xa_state *, void *entry, unsigned int order, gfp_t);
 #else
@@ -1556,6 +1557,11 @@ static inline int xa_get_order(struct xarray *xa, unsigned long index)
 	return 0;
 }
 
+static inline int xas_get_order(struct xa_state *xas)
+{
+	return 0;
+}
+
 static inline void xas_split(struct xa_state *xas, void *entry,
 		unsigned int order)
 {
diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index ebe2af2e072d..26e28b65d60a 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1984,6 +1984,37 @@ static noinline void check_get_order(struct xarray *xa)
 	}
 }
 
+static noinline void check_xas_get_order(struct xarray *xa)
+{
+	XA_STATE(xas, xa, 0);
+
+	unsigned int max_order = IS_ENABLED(CONFIG_XARRAY_MULTI) ? 20 : 1;
+	unsigned int order;
+	unsigned long i, j;
+
+	for (order = 0; order < max_order; order++) {
+		for (i = 0; i < 10; i++) {
+			xas_set_order(&xas, i << order, order);
+			do {
+				xas_lock(&xas);
+				xas_store(&xas, xa_mk_value(i));
+				xas_unlock(&xas);
+			} while (xas_nomem(&xas, GFP_KERNEL));
+
+			xas_lock(&xas);
+			for (j = i << order; j < (i + 1) << order; j++) {
+				xas_set_order(&xas, j, 0);
+				xas_load(&xas);
+				XA_BUG_ON(xa, xas_get_order(&xas) != order);
+			}
+			xas_unlock(&xas);
+
+			xas_set_order(&xas, i << order, order);
+			xas_store(&xas, NULL);
+		}
+	}
+}
+
 static noinline void check_destroy(struct xarray *xa)
 {
 	unsigned long index;
@@ -2035,6 +2066,7 @@ static int xarray_checks(void)
 	check_multi_store(&array);
 	check_multi_store_advanced(&array);
 	check_get_order(&array);
+	check_xas_get_order(&array);
 	check_xa_alloc();
 	check_find(&array);
 	check_find_entry(&array);
diff --git a/lib/xarray.c b/lib/xarray.c
index 39f07bfc4dcc..fbf1d1dd83bc 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1750,39 +1750,52 @@ void *xa_store_range(struct xarray *xa, unsigned long first,
 EXPORT_SYMBOL(xa_store_range);
 
 /**
- * xa_get_order() - Get the order of an entry.
- * @xa: XArray.
- * @index: Index of the entry.
+ * xas_get_order() - Get the order of an loaded entry after xas_load.
+ * @xas: XArray operation state.
+ *
+ * Called after xas_load, the xas should not be in an error state.
  *
  * Return: A number between 0 and 63 indicating the order of the entry.
  */
-int xa_get_order(struct xarray *xa, unsigned long index)
+int xas_get_order(struct xa_state *xas)
 {
-	XA_STATE(xas, xa, index);
-	void *entry;
 	int order = 0;
 
-	rcu_read_lock();
-	entry = xas_load(&xas);
-
-	if (!entry)
-		goto unlock;
-
-	if (!xas.xa_node)
-		goto unlock;
+	if (!xas->xa_node)
+		return 0;
 
 	for (;;) {
-		unsigned int slot = xas.xa_offset + (1 << order);
+		unsigned int slot = xas->xa_offset + (1 << order);
 
 		if (slot >= XA_CHUNK_SIZE)
 			break;
-		if (!xa_is_sibling(xas.xa_node->slots[slot]))
+		if (!xa_is_sibling(xas->xa_node->slots[slot]))
 			break;
 		order++;
 	}
 
-	order += xas.xa_node->shift;
-unlock:
+	order += xas->xa_node->shift;
+	return order;
+}
+EXPORT_SYMBOL_GPL(xas_get_order);
+
+/**
+ * xa_get_order() - Get the order of an entry.
+ * @xa: XArray.
+ * @index: Index of the entry.
+ *
+ * Return: A number between 0 and 63 indicating the order of the entry.
+ */
+int xa_get_order(struct xarray *xa, unsigned long index)
+{
+	XA_STATE(xas, xa, index);
+	int order = 0;
+	void *entry;
+
+	rcu_read_lock();
+	entry = xas_load(&xas);
+	if (entry)
+		order = xas_get_order(&xas);
 	rcu_read_unlock();
 
 	return order;
-- 
2.43.0


