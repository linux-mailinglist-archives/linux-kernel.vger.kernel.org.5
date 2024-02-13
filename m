Return-Path: <linux-kernel+bounces-62683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3894485245C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E891D2853DD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B1B6DD0B;
	Tue, 13 Feb 2024 00:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5ToMkQV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296346A8A2;
	Tue, 13 Feb 2024 00:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783746; cv=none; b=d04MlNg75GHvvLSuBjXqXLtTVzK1wQGhiye9/lRPccFbrreqLaN5+dJ7F3kTaPLmgjB+V8n9qGlOBBqakZvdhfETdvCUbBjb+xpvBdjC1+ldQCKlzRRH6jA0CtWJ/z0U6549vltrsryYdGJieMSiIFiFdQf+iudgq+53GQQJ+Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783746; c=relaxed/simple;
	bh=qIgkZEou6CY3oQ44pL6wtxoTEC5coA5fu972N8E9At0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hcb93e0j/S2MTCD+VDzlaeEvu+EiO9wBOw6o3Lk65KtO/Hr3EiBaEOeC9j/1ZR7UHwS1ehM3PatwSlNlXbHgLNqUMnHujrhOaNmrDKvdRDp5PztEB5M4A3P71YcXI1/pAj2Es4jWohTIgPKEfpWil2axdDrCyeZbchbvrZ2hQC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5ToMkQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B9CC43390;
	Tue, 13 Feb 2024 00:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783745;
	bh=qIgkZEou6CY3oQ44pL6wtxoTEC5coA5fu972N8E9At0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X5ToMkQVYfadZnTel+dkf4r7hr/+WjuRojNz4Sv8HUb8Ty/ywrFKcFxEAeDnrgTyi
	 u39NvLto2Umx2S5GdVV0VFcH+tPvUQK3g+pf+UdwYBnurejDbRmShQqgeY8kiMGYZu
	 kL38GlctYIXJg+ARAqS8wGWgDEXHpdK0uVgLz46lyjBZc9qr/m9/Xv+BWt53O+cMcU
	 KLb8iBKAzdByamZ5ueigXujnjCTAWPugJXTLDXN4WX/DWbR0ufyjAv4Z9+383EYjjo
	 0Wtoonjb6VyZaGmzcwhAuRB6JAt/oG0GB+V8QmBi0LAcKu+iIap0L02jFdve4qPEu2
	 9XC7P2ebjb59A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Steve French <stfrench@microsoft.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.6 51/51] smb3: clarify mount warning
Date: Mon, 12 Feb 2024 19:20:28 -0500
Message-ID: <20240213002052.670571-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Steve French <stfrench@microsoft.com>

[ Upstream commit a5cc98eba2592d6e3c5a4351319595ddde2a5901 ]

When a user tries to use the "sec=krb5p" mount parameter to encrypt
data on connection to a server (when authenticating with Kerberos), we
indicate that it is not supported, but do not note the equivalent
recommended mount parameter ("sec=krb5,seal") which turns on encryption
for that mount (and uses Kerberos for auth).  Update the warning message.

Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/fs_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index a3493da12ad1..86de889bd8b2 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -210,7 +210,7 @@ cifs_parse_security_flavors(struct fs_context *fc, char *value, struct smb3_fs_c
 
 	switch (match_token(value, cifs_secflavor_tokens, args)) {
 	case Opt_sec_krb5p:
-		cifs_errorf(fc, "sec=krb5p is not supported!\n");
+		cifs_errorf(fc, "sec=krb5p is not supported. Use sec=krb5,seal instead\n");
 		return 1;
 	case Opt_sec_krb5i:
 		ctx->sign = true;
-- 
2.43.0


