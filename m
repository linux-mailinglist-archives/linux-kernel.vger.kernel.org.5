Return-Path: <linux-kernel+bounces-121007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F22888E183
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50D33B2DDE0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D66158A08;
	Wed, 27 Mar 2024 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8s3WCjk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50401158878;
	Wed, 27 Mar 2024 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541823; cv=none; b=oJVpmx3nVoDZ5XQbOdMV7u7Vsh0OU1AZd9hx0pg8pY/f8PZocHamdVNkK7qwdakCQWd5OWFD5nbaMtkfccs93vfgWydRftDd/mJl0GNI3nNAKCPDiItcZRYSqqd9Z5aYaOZE9ZyYgfzJlumOrCnO01+k9S8ofrTWL81U51pQMRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541823; c=relaxed/simple;
	bh=1DASy7axL7AEYovmREkmlZOUWT3RSUFBIs65kyk8KbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gDKDxFag9Jx3qapoHk3z5YDX0lOB6kkW7tV1dYEYBum5fEpkwwEV01Pny+EYofhVAuQKYwJIBaxrN/8xrUJa5irISZqEkFXNpcTno8x0nALRg10Co+zdapKQROt4ce6bbvqMR3ERupXjJjEOz0J/9u8LWM0C0m7wgfOz1VQkFuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8s3WCjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4D9C43390;
	Wed, 27 Mar 2024 12:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541822;
	bh=1DASy7axL7AEYovmREkmlZOUWT3RSUFBIs65kyk8KbQ=;
	h=From:To:Cc:Subject:Date:From;
	b=i8s3WCjk5Gw9CJHbHqhKC8DYYCZsxwskXgQKwgya4rSu63dP12RUcRY5od/7+N7Dr
	 CrshJ1drBJ1jNgUUX7WJX3yVXjid//meT5Jo3z37VxavZhYcYOseI9g97M+yzj44JB
	 f2pZHQVtCBzmys2cRVBCSf4HdU1jQvIE7yjA+sfnD9DYU44X6f4y7pVadcJF1bNG8+
	 ByU+JbW80VHMIzdOW3IjS+qfCG4G2sUODPc5WmWZD82iYZXKF+RiWWdrO3976aBYcM
	 HOgU1lQWRKMs/lyuTtsqGUIwWqFbGVlnpDMt2a2iEeIAU1R8CJeLWZiwND8/kTQhXL
	 Tygnc9jM3PTEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sprasad@microsoft.com
Cc: =?UTF-8?q?Jan=20=C4=8Cerm=C3=A1k?= <sairon@sairon.cz>,
	Steve French <stfrench@microsoft.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "cifs: reduce warning log level for server not advertising interfaces" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:17:00 -0400
Message-ID: <20240327121701.2833201-1-sashal@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
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





