Return-Path: <linux-kernel+bounces-24295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB3082BA8C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962111C25289
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521FD5B5C0;
	Fri, 12 Jan 2024 05:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UxrURFed"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF96E5B5B3;
	Fri, 12 Jan 2024 05:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=vgJoxByM6oiQwE5/ygczGmqmO8QxfCFpN0WkRcWZdaI=; b=UxrURFedLIFFev9h7SzxjxxSkP
	ZdSRg+Bf00xFEa/Ui5X3S9ZM6KCAK4it19SE97RrMyyzB4B3OVkA55kmH7AGoBheJOlsAqsMRru1M
	Xoq74z38STTsPniQ4RTMMMXv1njlBPwizQNCqCEtXCbtZyL1DSehvOBas1PZ6rdlwjTV3to3UN+Hq
	DGgXeKt/UnPnbhierGwrRpsqvvGbFviUDYtKOq9Ojzlhx/Ty8l65n04//4Xp0YP0hCeUQqsv/ZEEu
	32Bp1S4AyyM3kIWGcXst+7G3YQgzooHuLk+AGnS0a2fZSomE5p+BKoLyxeH51p0ga30j8gpnQ9Zwa
	B0Cb4ylg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rO9eM-001tOt-2V;
	Fri, 12 Jan 2024 05:00:10 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] tipc: node: remove Excess struct member kernel-doc warnings
Date: Thu, 11 Jan 2024 21:00:10 -0800
Message-ID: <20240112050010.25626-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove 2 kernel-doc descriptions to squelch warnings:

node.c:150: warning: Excess struct member 'inputq' description in 'tipc_node'
node.c:150: warning: Excess struct member 'namedq' description in 'tipc_node'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jon Maloy <jmaloy@redhat.com>
Cc: Ying Xue <ying.xue@windriver.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
---
 net/tipc/node.c |    2 --
 1 file changed, 2 deletions(-)

diff -- a/net/tipc/node.c b/net/tipc/node.c
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -86,8 +86,6 @@ struct tipc_bclink_entry {
  * @lock: rwlock governing access to structure
  * @net: the applicable net namespace
  * @hash: links to adjacent nodes in unsorted hash chain
- * @inputq: pointer to input queue containing messages for msg event
- * @namedq: pointer to name table input queue with name table messages
  * @active_links: bearer ids of active links, used as index into links[] array
  * @links: array containing references to all links to node
  * @bc_entry: broadcast link entry

