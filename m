Return-Path: <linux-kernel+bounces-50081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7744F847401
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 165C8B21455
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022AB151451;
	Fri,  2 Feb 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/EWCSl2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED01509B6;
	Fri,  2 Feb 2024 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889534; cv=none; b=WJjUxp7D6m73b3lTXrqQatYbT2IarpHN06FwMaTys1ZDRdjxBnP1g5efcN6Y4qJP0IF7ZGPWvHBzbNMMh4tbEVgBuEJ4eKTl0PIIe+yaS1NWrSOu3Yf6F1SbZ5VkYLMFLROKy0N7ZUUcbsUcb6BC+2rvSOm9EO6/NGKSxaPk1Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889534; c=relaxed/simple;
	bh=2A96WogbH0kuSA8JLvJzBsQjD8uKlSboQJQx9UBHSVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dwLW0oOugQKEeqTizwTgdNEsganYYeljTxjHshNnxpJFebweGUEoGB6feo636GNczjbR/W49urSaOQwPk5F60N1tAR+15eUKNGOiWG/po8cRRptUs0MEb4mRbEQXNWKTkXO/N1zaf9Jg1WWyWyPv5gh37cZs0N0Qfu2tecofvVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/EWCSl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2571CC43394;
	Fri,  2 Feb 2024 15:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889533;
	bh=2A96WogbH0kuSA8JLvJzBsQjD8uKlSboQJQx9UBHSVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z/EWCSl2wBAICpgIpF3Sra8aDM769fUjPgXy22zP6Hnk9+HH6P6Em6GY9UF0trg1q
	 REgk3P9wJ50M51fGTYcDUurjxWqD1JSZNM/yvU816xfS5+hrdnE3mPWZlnGwa3AjUo
	 Kg/nybbp39tKyCbUUUX+L+6G2nfFbpZ+wbtDiUzXRgRu7QsgInG/eqxulvFbgQlmuF
	 lvFy6cITEHYpaI61fN5F7FY+KTbUDpEItD0mdzs9DX2nkSNOF44+AwMMuYunEYdP3l
	 oStfxAitf73WOmLaV/tL+jlkDf0s4brhojGMpbAVtBh3vsAW6VlIq8QVGYqoTGl+MG
	 IpO7Hui4vz1Xw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 21/27] kconfig: import more list macros and inline functions
Date: Sat,  3 Feb 2024 00:58:19 +0900
Message-Id: <20240202155825.314567-22-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240202155825.314567-1-masahiroy@kernel.org>
References: <20240202155825.314567-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Import more macros and inline functions from include/linux/list.h
and include/linux/types.h.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/list.h       | 69 ++++++++++++++++++++++++++++++++++++
 scripts/kconfig/list_types.h |  8 +++++
 2 files changed, 77 insertions(+)

diff --git a/scripts/kconfig/list.h b/scripts/kconfig/list.h
index 2bce2b8f21d1..882859ddf9f4 100644
--- a/scripts/kconfig/list.h
+++ b/scripts/kconfig/list.h
@@ -70,6 +70,19 @@ static inline void __list_add(struct list_head *new,
 	prev->next = new;
 }
 
+/**
+ * list_add - add a new entry
+ * @new: new entry to be added
+ * @head: list head to add it after
+ *
+ * Insert a new entry after the specified head.
+ * This is good for implementing stacks.
+ */
+static inline void list_add(struct list_head *new, struct list_head *head)
+{
+	__list_add(new, head, head->next);
+}
+
 /**
  * list_add_tail - add a new entry
  * @new: new entry to be added
@@ -114,6 +127,16 @@ static inline void list_del(struct list_head *entry)
 	entry->prev = LIST_POISON2;
 }
 
+/**
+ * list_is_head - tests whether @list is the list @head
+ * @list: the entry to test
+ * @head: the head of the list
+ */
+static inline int list_is_head(const struct list_head *list, const struct list_head *head)
+{
+	return list == head;
+}
+
 /**
  * list_empty - tests whether a list is empty
  * @head: the list to test.
@@ -184,4 +207,50 @@ static inline int list_empty(const struct list_head *head)
 	     !list_entry_is_head(pos, head, member);			\
 	     pos = n, n = list_next_entry(n, member))
 
+/*
+ * Double linked lists with a single pointer list head.
+ * Mostly useful for hash tables where the two pointer list head is
+ * too wasteful.
+ * You lose the ability to access the tail in O(1).
+ */
+
+#define HLIST_HEAD_INIT { .first = NULL }
+
+/**
+ * hlist_add_head - add a new entry at the beginning of the hlist
+ * @n: new entry to be added
+ * @h: hlist head to add it after
+ *
+ * Insert a new entry after the specified head.
+ * This is good for implementing stacks.
+ */
+static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
+{
+	struct hlist_node *first = h->first;
+
+	n->next = first;
+	if (first)
+		first->pprev = &n->next;
+	h->first = n;
+	n->pprev = &h->first;
+}
+
+#define hlist_entry(ptr, type, member) container_of(ptr, type, member)
+
+#define hlist_entry_safe(ptr, type, member) \
+	({ typeof(ptr) ____ptr = (ptr); \
+	   ____ptr ? hlist_entry(____ptr, type, member) : NULL; \
+	})
+
+/**
+ * hlist_for_each_entry	- iterate over list of given type
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the hlist_node within the struct.
+ */
+#define hlist_for_each_entry(pos, head, member)				\
+	for (pos = hlist_entry_safe((head)->first, typeof(*(pos)), member);\
+	     pos;							\
+	     pos = hlist_entry_safe((pos)->member.next, typeof(*(pos)), member))
+
 #endif /* LIST_H */
diff --git a/scripts/kconfig/list_types.h b/scripts/kconfig/list_types.h
index 32899f424983..d935b7c5aa81 100644
--- a/scripts/kconfig/list_types.h
+++ b/scripts/kconfig/list_types.h
@@ -6,4 +6,12 @@ struct list_head {
 	struct list_head *next, *prev;
 };
 
+struct hlist_head {
+	struct hlist_node *first;
+};
+
+struct hlist_node {
+	struct hlist_node *next, **pprev;
+};
+
 #endif /* LIST_TYPES_H */
-- 
2.40.1


