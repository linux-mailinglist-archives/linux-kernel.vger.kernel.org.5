Return-Path: <linux-kernel+bounces-107162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842F687F85A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112FF282A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8455535C2;
	Tue, 19 Mar 2024 07:27:24 +0000 (UTC)
Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD6A51C55;
	Tue, 19 Mar 2024 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710833244; cv=none; b=J6VL+JfzyqZ6YHQQqb18BlNY4/8E05x4tDLrZbbBqOHjfsmhJrcPNHMTp4HWjApLI/R69ymzdLJDUyFWCLfwNvkLtID7ZCl7oaCh2PZ3RzJ65i7l5qVXPCGfxKv1HAgPdNZfnew4f/kly9eRNmkVy87KYT18hGhrexy/ChXwd28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710833244; c=relaxed/simple;
	bh=n+M0ANagwZRoGkTzJlKYUP8aZ2hnHr8+W5VsznJLeb0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZwbeQ6KB/8td7w6J0Bx7xMCyNWRs9fY/ra5pQLz3zRC5iCo6txeyziuKlinvzCtLQRr+uEkxAuXYdJvLWP2Wdc5Q1up0ceHag+20hPqKBLYzJ7apH9RVX+C8k8iIEN37U2qu/Az2b/1m9jV7sXbZ8S4vs2BZ61sHIuvv6XRVBck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from localhost.localdomain (unknown [192.168.32.67])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4TzNb62xBbzlVsJ;
	Tue, 19 Mar 2024 10:27:14 +0300 (MSK)
From: Dmitry Mastykin <dmastykin@astralinux.ru>
To: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willy@infradead.org
Cc: mastichi@gmail.com,
	Dmitry Mastykin <dmastykin@astralinux.ru>
Subject: [PATCH] docs: fix bug in "Krefs and RCU" example
Date: Tue, 19 Mar 2024 10:26:45 +0300
Message-Id: <20240319072645.18194-1-dmastykin@astralinux.ru>
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
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffhmihhtrhihucforghsthihkhhinhcuoegumhgrshhthihkihhnsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeeuhfeugfevvdeigeduleeuieetleeftdejieduffffkedtvdevhffghfffieelgeenucfkphepudelvddrudeikedrfedvrdeijeenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeduledvrdduieekrdefvddrieejmeefjeehtdekpdhmrghilhhfrhhomhepughmrghsthihkhhinhesrghsthhrrghlihhnuhigrdhruhdpnhgspghrtghpthhtohepiedprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmrghsthhitghhihesghhmrghilhdrtghomhdprhgtphhtthhopegumhgrshhthihkihhnsegrshhtrhgrlhhinhhugidrrhhu
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.62.01180, Virus records: 12519281, Updated: 2024-Mar-19 04:48:42 UTC]

There is a problem in "Krefs and RCU" example, that may cause a crash.
If list_del_rcu() will be called between these lines, and list will become
empty, then q.next will not point to a valid struct my_data.
entry->refcount will also be invalid.
Instead, q.next must be read first, and then compared with q to check
list's emptiness, like in list_first_or_null_rcu() macro.

Signed-off-by: Dmitry Mastykin <dmastykin@astralinux.ru>
---
 Documentation/core-api/kref.rst | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/kref.rst b/Documentation/core-api/kref.rst
index c61eea6f1bf2..022bb1d1b968 100644
--- a/Documentation/core-api/kref.rst
+++ b/Documentation/core-api/kref.rst
@@ -290,13 +290,11 @@ locking for lookups in the above example::
 
 	static struct my_data *get_entry_rcu()
 	{
-		struct my_data *entry = NULL;
+		struct my_data *entry;
 		rcu_read_lock();
-		if (!list_empty(&q)) {
-			entry = container_of(q.next, struct my_data, link);
-			if (!kref_get_unless_zero(&entry->refcount))
-				entry = NULL;
-		}
+		entry = list_first_or_null_rcu(&q, struct my_data, link);
+		if (entry && !kref_get_unless_zero(&entry->refcount))
+			entry = NULL;
 		rcu_read_unlock();
 		return entry;
 	}
-- 
2.30.2


