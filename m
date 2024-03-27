Return-Path: <linux-kernel+bounces-120934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4EA88E0AB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91AE29A7D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8184512EBF5;
	Wed, 27 Mar 2024 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzgxrGEK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BDC36AF8;
	Wed, 27 Mar 2024 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541625; cv=none; b=CU6vMHWHnJKd1uIniHoU2dtD7I+B+QSVRBkoEUPQcgVo45UqLcfij4yo9ONWX+VXYAYCdQk8+Itn6kTKZebkCRbdXVqeo9w7vZzwBCHi4V6Hp57LQi+R5Pso0CuHLSND113azFpvkG7B9HIItp8I3J6M/hFlUw24K7O+5jPK1HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541625; c=relaxed/simple;
	bh=On2MCpUUnLSI9BmJ15SkLbGcO0qJ/1Xa/T02rkNp/n0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=po7TbTG04hgokedHKSt0jbexvxVlynFO60pqIT7VQ1NMGB6FF2gTGDwRGCbg15k1VanuXycpQIFxEok24ZFGpTadvYgaLjvcCcc+qUq8RqcHB4DWPsCm2Nq+7b1j2Jn7PxWmsAi4pYbTGSO2n6cZNJjqaGN15+zXoRVz4yohBSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzgxrGEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4902C433F1;
	Wed, 27 Mar 2024 12:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541625;
	bh=On2MCpUUnLSI9BmJ15SkLbGcO0qJ/1Xa/T02rkNp/n0=;
	h=From:To:Cc:Subject:Date:From;
	b=KzgxrGEKVNsC+2rGzxEvIpmQNTbXxCDvGjP3OQ4KWadloJOEaI67qCgaho99CFrU7
	 eRwnIRo0fQ3pEBJMkT+TU2PKrMpoNvCgAWHt1uJvtnsAB7is9xg1UoVY8dJpCI6MrQ
	 8GpS76l2bR4+HYmr7pk/17eYHkxMNvhyjMbYA3cB4weNTucERyuyJtWXzCo+ATvZPz
	 8el9OgcYQWyKWZFvbhGsd1VDkZiYxJg6vtKaESjWvy87mNRUj5UeSKqeeK4Z0GihZs
	 qsmppYTYO1GcDm8m/ljmRn+rTHaU10WT2NH7kS1Wceorh40kGxoPTnYusdPuN+rDXP
	 r0fKL370HU28w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sprasad@microsoft.com
Cc: =?UTF-8?q?Jan=20=C4=8Cerm=C3=A1k?= <sairon@sairon.cz>,
	Steve French <stfrench@microsoft.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "cifs: reduce warning log level for server not advertising interfaces" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:13:43 -0400
Message-ID: <20240327121343.2830583-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 16a57d7681110b25708c7042688412238e6f73a9 Mon Sep 17 00:00:00 2001
From: Shyam Prasad N <sprasad@microsoft.com>
Date: Wed, 13 Mar 2024 10:40:40 +0000
Subject: [PATCH] cifs: reduce warning log level for server not advertising
 interfaces
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Several users have reported this log getting dumped too regularly to
kernel log. The likely root cause has been identified, and it suggests
that this situation is expected for some configurations
(for example SMB2.1).

Since the function returns appropriately even for such cases, it is
fairly harmless to make this a debug log. When needed, the verbosity
can be increased to capture this log.

Cc: stable@vger.kernel.org
Reported-by: Jan Čermák <sairon@sairon.cz>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/client/sess.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 8f37373fd3334..3216f786908fb 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -230,7 +230,7 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 		spin_lock(&ses->iface_lock);
 		if (!ses->iface_count) {
 			spin_unlock(&ses->iface_lock);
-			cifs_dbg(VFS, "server %s does not advertise interfaces\n",
+			cifs_dbg(ONCE, "server %s does not advertise interfaces\n",
 				      ses->server->hostname);
 			break;
 		}
@@ -396,7 +396,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	spin_lock(&ses->iface_lock);
 	if (!ses->iface_count) {
 		spin_unlock(&ses->iface_lock);
-		cifs_dbg(VFS, "server %s does not advertise interfaces\n", ses->server->hostname);
+		cifs_dbg(ONCE, "server %s does not advertise interfaces\n", ses->server->hostname);
 		return;
 	}
 
-- 
2.43.0





