Return-Path: <linux-kernel+bounces-19479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD9F826D88
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60AA2B22257
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9A044372;
	Mon,  8 Jan 2024 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="QBWWjpI/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC8A43168
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1D0A03F582
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704715822;
	bh=9iWRZnNscxr8QayhU5Rg4d2f++I0rJo2nyXgNTtGjkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=QBWWjpI/vwNsW4e0Nrk+uB+Vy7BEF1BBYekr4ch8hpXdEf+tBI07ypHOWmvEAzQFV
	 IxXgt+zcqBqp8YMqFIfBwRCh/2Vc0cB54tG0TY70Nat//xp0TxMfm5gybFOG8YFZTk
	 IIOukF4nmxFKpxiwaznrPJIoRIJZ5hn3pFkEwP4oXNGfoesPvA/qKAeBO87vjpn2qw
	 X+msdpS3rjQN0DWCEcDcnxlpHZAI0vsrNt6WduTr1cH2qFPjbafNeeg9r4rGxxK+3q
	 lp/cVpCo0Y7d6Gd6UnzSB0K3XG3v8kgLNO4BUbrqD70EeMYcUgUPyoqRNqVlm5H7NA
	 NPD/sISFG9lYg==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5551f8ec1c8so1104868a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 04:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704715821; x=1705320621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iWRZnNscxr8QayhU5Rg4d2f++I0rJo2nyXgNTtGjkw=;
        b=o+bSkU02q6HE4/Wijf8X8BQ0yZXy3KnBMDmryuMdTQshjwYW52pNPLILo8CqbvNb5H
         1zw8mZZLrCX0dnoftervP9goF44Ys5Tgmp1srslNJ9G41HwuUomgP14SLCdE13M67yWn
         rAM9pUb562+9uawHG80OT20d+Ox3PTVh67crp4PSbzBo1YBnV+3sUX0TUTWsOwM9ApD6
         2EyxNDC8QN59mYwAIwFjWbvEcdvky9idAYtUoY0qw70m3lnguA+8KGNY1BxXMpFb8bXC
         IDr1FexfW+Cwo3vP1ww2EJhtBok9pw8hTrZx7TDlrTGuTsX7pTucH6UmuzJ+keJk869J
         tnnQ==
X-Gm-Message-State: AOJu0Yx9GiQTQUKC+XUTDmoT0jvGXzqOMSW9wQicif+KfsnsX9kJJYmQ
	T4p6yJywPAXCawH9o4oFyRNVQKtFKcSdpSrR/ZFKpG+botF9h33NpeBu1MvvmaLtlhsVSGBRWyG
	cBqXv/kfomrxl1sEbNxFlpPf3SAWtBd3rEOgUxYUoBp5q2lnY
X-Received: by 2002:a50:f688:0:b0:557:8d37:2e8d with SMTP id d8-20020a50f688000000b005578d372e8dmr1279929edn.15.1704715821268;
        Mon, 08 Jan 2024 04:10:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkOLg4PdqdFQ702pfHBj3dKeidAQf6BOtGBbpwTprd9QoY0lj1ZgOD0aGwJAUpLDd3U2Afjw==
X-Received: by 2002:a50:f688:0:b0:557:8d37:2e8d with SMTP id d8-20020a50f688000000b005578d372e8dmr1279918edn.15.1704715821105;
        Mon, 08 Jan 2024 04:10:21 -0800 (PST)
Received: from localhost.localdomain ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id fi21-20020a056402551500b005578b816f20sm1767959edb.29.2024.01.08.04.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:10:20 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 8/9] fs/fuse: support idmapped ->set_acl
Date: Mon,  8 Jan 2024 13:08:23 +0100
Message-Id: <20240108120824.122178-9-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's just a matter of adjusting a permission check condition
for S_ISGID flag. All the rest is already handled in the generic
VFS code.

Notice that this permission check is the analog of what
we have in posix_acl_update_mode() generic helper, but
fuse doesn't use this helper as on the kernel side we don't
care about ensuring that POSIX ACL and CHMOD permissions are in sync
as it is a responsibility of a userspace daemon to handle that.
For the same reason we don't have a calls to posix_acl_chmod(),
while most of other filesystem do.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/acl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 3a3cd88bd3d7..727fe50e255e 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -144,8 +144,8 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * be stripped.
 		 */
 		if (fc->posix_acl &&
-		    !vfsgid_in_group_p(i_gid_into_vfsgid(&nop_mnt_idmap, inode)) &&
-		    !capable_wrt_inode_uidgid(&nop_mnt_idmap, inode, CAP_FSETID))
+		    !vfsgid_in_group_p(i_gid_into_vfsgid(idmap, inode)) &&
+		    !capable_wrt_inode_uidgid(idmap, inode, CAP_FSETID))
 			extra_flags |= FUSE_SETXATTR_ACL_KILL_SGID;
 
 		ret = fuse_setxattr(inode, name, value, size, 0, extra_flags);
-- 
2.34.1


