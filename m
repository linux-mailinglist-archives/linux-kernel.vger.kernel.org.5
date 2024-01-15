Return-Path: <linux-kernel+bounces-25559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B2A82D2A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFB11C209AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 00:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735B8AD37;
	Mon, 15 Jan 2024 00:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HJwtZrB1"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2BBAD23
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 00:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=w9mQE91/CGjocjaMPaBX7bxqNyatmpdvfmiYVDFoiVs=; b=HJwtZrB1p0Ztn7bKM7OXRjo1yL
	3z0b30Wkrg5qa7izdnLJMQVh2CMMdV/EXifagpl++NKgVlyNOvDuE44vRc0cK0luZC0U1VLtAhnvK
	5eH2HAC7sm9IkTxuelyo+e43H4X68kj+wksViU/XM3uvZ0JfCzOFrVOtnEMfu6+/5x0EtQsalfd9j
	yapmABX0SGR0N5AE0v63sbf0pIdsHZAWsxc9uPanPC7nwUSWgGImVG1M2ECnnj9oTeMx2UQ7gL0I+
	1d1tPs41z9i456h9garrPLrC7p2gx3p3Qyjn57WdgyGjQqO2mQZV6d+R9O242BWZ7omNqJm+yytES
	TLRbe8vQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPAQr-007Wp7-08;
	Mon, 15 Jan 2024 00:02:25 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Feng Kan <fkan@apm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH] mailbox: xgene-slimpro: fix kernel-doc warnings
Date: Sun, 14 Jan 2024 16:02:24 -0800
Message-ID: <20240115000224.2854-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert struct comments to kernel-doc format to avoid warnings
from scripts/kernel-doc:

mailbox-xgene-slimpro.c:3: warning: cannot understand function prototype: 'struct slimpro_mbox_chan '
mailbox-xgene-slimpro.c:57: warning: contents before sections
mailbox-xgene-slimpro.c:62: warning: cannot understand function prototype: 'struct slimpro_mbox '

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Feng Kan <fkan@apm.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>
---
 drivers/mailbox/mailbox-xgene-slimpro.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff -- a/drivers/mailbox/mailbox-xgene-slimpro.c b/drivers/mailbox/mailbox-xgene-slimpro.c
--- a/drivers/mailbox/mailbox-xgene-slimpro.c
+++ b/drivers/mailbox/mailbox-xgene-slimpro.c
@@ -32,7 +32,7 @@
 #define REG_DB_STATMASK		0x24
 
 /**
- * X-Gene SlimPRO mailbox channel information
+ * struct slimpro_mbox_chan - X-Gene SlimPRO mailbox channel information
  *
  * @dev:	Device to which it is attached
  * @chan:	Pointer to mailbox communication channel
@@ -49,15 +49,14 @@ struct slimpro_mbox_chan {
 };
 
 /**
- * X-Gene SlimPRO Mailbox controller data
- *
- * X-Gene SlimPRO Mailbox controller has 8 communication channels.
- * Each channel has a separate IRQ number assigned to it.
+ * struct slimpro_mbox - X-Gene SlimPRO Mailbox controller data
  *
  * @mb_ctrl:	Representation of the communication channel controller
  * @mc:		Array of SlimPRO mailbox channels of the controller
  * @chans:	Array of mailbox communication channels
  *
+ * X-Gene SlimPRO Mailbox controller has 8 communication channels.
+ * Each channel has a separate IRQ number assigned to it.
  */
 struct slimpro_mbox {
 	struct mbox_controller		mb_ctrl;

