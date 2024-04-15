Return-Path: <linux-kernel+bounces-144903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9318A4C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144B4281461
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4104D133;
	Mon, 15 Apr 2024 10:20:29 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id C18A247A7F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713176429; cv=none; b=d76hehkBBMnjQdA11BhtMrbq/CtacsyGvlnS2SMEopKPghnXuKATwhi5aawnCGMSOiOpzVyvFaJyMzZrMrXXETneRPtBzP6Ov1mlC3WfDF6UIpIIgHHpQbl8rQHwnSi0HSTJrNTvuKorG3+bN9hNPD8rQpKyXoo1tISPT0eU2a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713176429; c=relaxed/simple;
	bh=3yLCoqFgS93V9qcg7dJGqj52LfDzK5camlXV1LZWd6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Zd8Z3kFogPjC1ZHDKrz6Hh/iAPXZNNwGkxOmsSV+qkqbxDYgFEvFEm/qfba1J/WetgvT0V4rMQ8KRMevj4fQRHQ69weyTrDth/cIeyhHfVAZu2BUge7HvT4T5KPDS8a/l6R+i4FRPok0snmL2E7mdokEg6b+ZfHzyOBTG10NB0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 75A91601A216C;
	Mon, 15 Apr 2024 18:20:16 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: gregkh@linuxfoundation.org,
	tj@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?kernfs:=20mount:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=98NULL=E2=80=99=20values=20from=20knparent?=
Date: Mon, 15 Apr 2024 18:20:09 +0800
Message-Id: <20240415102009.9926-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

knparent is assigned first, so it does not need to initialize the
assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 fs/kernfs/mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 0c93cad0f0aca..d38bc7aeb598c 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -206,7 +206,7 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 				  struct super_block *sb)
 {
 	struct dentry *dentry;
-	struct kernfs_node *knparent = NULL;
+	struct kernfs_node *knparent;
 
 	BUG_ON(sb->s_op != &kernfs_sops);
 
-- 
2.18.2


