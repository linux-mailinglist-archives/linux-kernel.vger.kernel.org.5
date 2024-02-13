Return-Path: <linux-kernel+bounces-62631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DA58523D8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83191C21F48
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457B75EE76;
	Tue, 13 Feb 2024 00:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRRXB4xp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853E65E3D8;
	Tue, 13 Feb 2024 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783627; cv=none; b=mWoSm2lzfzut24fWQ+8GzJAihHSW1yvfDMsoafntKJvLPOpQCJZdOvmrQLDc/ZUOGfgB1AlDmLumWe1qe8L3Fi55j3YXZ3dF4svoZzP2kPvzQ1Oy09/cnPxn6Fono0OyPShKw5ifcJ3D2bKtQn2DhQkmPeeYoSmePsKgSszwXyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783627; c=relaxed/simple;
	bh=qIgkZEou6CY3oQ44pL6wtxoTEC5coA5fu972N8E9At0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+9X4itr/x1dA7GZp43zf+Eno/8TRMIYWsIMsTwBYyTjivyo50Z8/DhLTbwy7ZzHaT6dya9sM8l4D71Guk/U6nTe7xg6k/0g3hIm8bSXVJlufHS6o5JHsK0FOjk4sCvYfG3jgb9/kEKS2Qff+CfW1g719/LY+c7aqR6ZjZRiaXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRRXB4xp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227D3C433F1;
	Tue, 13 Feb 2024 00:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783627;
	bh=qIgkZEou6CY3oQ44pL6wtxoTEC5coA5fu972N8E9At0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GRRXB4xpxXKZzwj/xxpgeumzqZIqe1mgVdgr5ECTsUk5azyHvCmJCadpOlPwcnm1u
	 PVmnCqU6UbPUQHpZiwiXEAfEvGjsZHM6cA47mQ8RhQ9CgPWZm7FfHfKwulrb2i2+/I
	 /SM5qeFotA9eNW6/iTZkrSxld+6NKzFMByIfZj3FSvLf34b0kPi2V178PzVTmxYegV
	 FGbshCxUaraQkF1qye6ItTmrkf7UDaXAXlte43wsKL/VoZqvzZWaJBL7zIcJBXPBNV
	 +I0BTiLcWSMDpvvT47C2GfgfXJPepEF+D3N8+6zM8FQ3UvryB5DgGfSAndDNqBiZlO
	 RY1FYxVeU1ulQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Steve French <stfrench@microsoft.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.7 58/58] smb3: clarify mount warning
Date: Mon, 12 Feb 2024 19:18:04 -0500
Message-ID: <20240213001837.668862-58-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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


