Return-Path: <linux-kernel+bounces-106069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA0087E893
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A021C201EE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A00364CD;
	Mon, 18 Mar 2024 11:28:12 +0000 (UTC)
Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A498364A1;
	Mon, 18 Mar 2024 11:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761292; cv=none; b=uAKCMi/8p7LOqa7Ih2+hutgVaS+BtiAhfLzpJnOSAshGjpvJgiugn11zFrdT5wMFv3ChVC7hns52WLoU2XpPAacopkU/Nd4t5lZ2Pjygk+CLaikVJxQcqNflQ4Mztjoxph5SyQLfnGmGr2iO3kzQjYUqY/3M8iF0+LJy3qS2NEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761292; c=relaxed/simple;
	bh=oYKwQDdxQkJOTTN7jCxBVyN1NhP10eC12ahYUEJkMDU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=li34hpfLptcan0lYONdYOr4v7H+eisR549+rFlxAkqrHZSLyHJ+0ZZ5upZSHye4LfwUwplwcA+zg7nWyZ2689cXkiapQMj7puY5C0DnSO82+GgkSq0ovdpPnvW50XyfKKfbB/nIaw2lX6bleWetY19iHfdQL/LIQBQEqxjBLT2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from localhost.localdomain (unknown [192.168.32.67])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4TyszK5nf9zyNX;
	Mon, 18 Mar 2024 14:27:57 +0300 (MSK)
From: Dmitry Mastykin <dmastykin@astralinux.ru>
To: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thellstrom@vmware.com
Cc: mastichi@gmail.com,
	Dmitry Mastykin <dmastykin@astralinux.ru>
Subject: docs: bug in "Krefs and RCU" example
Date: Mon, 18 Mar 2024 14:27:44 +0300
Message-Id: <20240318112744.12400-1-dmastykin@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffhmihhtrhihucforghsthihkhhinhcuoegumhgrshhthihkihhnsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeeuhfeugfevvdeigeduleeuieetleeftdejieduffffkedtvdevhffghfffieelgeenucfkphepudelvddrudeikedrfedvrdeijeenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeduledvrdduieekrdefvddrieejmeegkedvledvpdhmrghilhhfrhhomhepughmrghsthihkhhinhesrghsthhrrghlihhnuhigrdhruhdpnhgspghrtghpthhtohepiedprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhvghllhhsthhrohhmsehvmhifrghrvgdrtghomhdprhgtphhtthhopehmrghsthhitghhihesghhmrghilhdrtghomhdprhgtphhtthhopegumhgrshhthihkihhnsegrshhtrhgrlhhinhhugidrrhhu
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.62.01180, Virus records: 12516250, Updated: 2024-Mar-18 09:41:37 UTC]

Hello all,
It seems there is a problem in "Krefs and RCU" example, that may cause
a crash.
I marked the place between two problem lines with "problem is here" comment.
If list_del_rcu() will be called between these lines, and list will become
empty, then q.next will not point to a valid struct my_data.
entry->refcount will also be invalid.
Instead, q.next must be read first, and then compared with q to check
list's emptiness (for example like in list_for_each_entry_rcu macro).

Signed-off-by: Dmitry Mastykin <dmastykin@astralinux.ru>

diff --git a/Documentation/core-api/kref.rst b/Documentation/core-api/kref.rst
index c61eea6f1bf2..b76d71d9c9a0 100644
--- a/Documentation/core-api/kref.rst
+++ b/Documentation/core-api/kref.rst
@@ -274,44 +274,45 @@ return value. If you are sure (by already having a valid pointer) that
 kref_get_unless_zero() will return true, then use kref_get() instead.
 
 Krefs and RCU
 =============
 
 The function kref_get_unless_zero also makes it possible to use rcu
 locking for lookups in the above example::
 
 	struct my_data
 	{
 		struct rcu_head rhead;
 		.
 		struct kref refcount;
 		.
 		.
 	};
 
 	static struct my_data *get_entry_rcu()
 	{
 		struct my_data *entry = NULL;
 		rcu_read_lock();
 		if (!list_empty(&q)) {
+			// problem is here
 			entry = container_of(q.next, struct my_data, link);
 			if (!kref_get_unless_zero(&entry->refcount))
 				entry = NULL;
 		}
 		rcu_read_unlock();
 		return entry;
 	}
 
 	static void release_entry_rcu(struct kref *ref)
 	{
 		struct my_data *entry = container_of(ref, struct my_data, refcount);
 
 		mutex_lock(&mutex);
 		list_del_rcu(&entry->link);
 		mutex_unlock(&mutex);
 		kfree_rcu(entry, rhead);
 	}
 
 	static void put_entry(struct my_data *entry)
 	{
 		kref_put(&entry->refcount, release_entry_rcu);
 	}

