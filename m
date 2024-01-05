Return-Path: <linux-kernel+bounces-17991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CD7825681
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C490E1F22E00
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADE431A8E;
	Fri,  5 Jan 2024 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="UE8vaO1I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85083173E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F32EF3F468
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 15:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704468121;
	bh=3ehRu/Zuzjv9SF1nMloRA0oZhzJAyfoaCoaYcJRfDMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=UE8vaO1Ix0h0HypNFxX3xnrcJENd2rJTrb8XVFzVrxiuDQKZqr/t6KO/eCv/49seL
	 gD2zmqSJXsRDDZU5dbx9zVJRMD6mK6eNFBa5pUO5Q7Sx45Zle0TeF1RYRo3APFRe1P
	 zXa2cX2I5tSw09U7ZSzhYj7xrUtYhxMT3l07dpcYBGTJIpU8xsqcScIp4OIDUr3+Tt
	 lKKZf8OC2oWvw67tQsakjKfZwhBRC3Tq5HgOiKKMTZtsvQPLM9R5oCdCA/DlbhA0nQ
	 knrq4Gn1MJSz6OeuagpPjszITc3XAJx1Xg7aDWr/UkAOwBT5tnWRFbbINfXLWwwXSD
	 51u4bgTrRtHCg==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-556415459d2so983322a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 07:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704468120; x=1705072920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ehRu/Zuzjv9SF1nMloRA0oZhzJAyfoaCoaYcJRfDMg=;
        b=d+VQYJlbbB2RJwOjLsUhFMQuVnb1SbX2yCc3QJcOkKJPHvqRaewlDLKRkCqyXosqKx
         LtzaiZijK9xm1T3qBP+s5zXUnM0iDvm/flD1Bci2ZS/G4KbOZn0oYag58xgWvrnfK6Y6
         751pMxBLYT8axQjLRHFCXcP29y2npbDhPIb/+1LM28kWu4G6PueZNK8coLAK+Lh/0fXL
         p2rEoZF8areEeh/4DcxOaF27zkgy2eSltQ7VTjX+TjdwkyDIQ1mWTYFlSBMVMF/5S4Ku
         Onx4FWT0wUUGzMtMN9yen1RwBJhWJvRinAQvfiNWG4xHpfDDo+u5yTKO5i1lSVG6oGbM
         gu4Q==
X-Gm-Message-State: AOJu0YwYyPNzaAf66U+e37KtXvq0UebwdfYvQ6FTuj1J27s8ONOSgIVG
	ZNhg1Y2wIiTo1RD628+TunA3gTn7DaY5IEXEwYpHPDMUmQUMNPBT2GeMCrnr1jS2Of3hNMgStw6
	h1HuRKxkNv6/j515D2jz7oR1Wh9NC6XWPA5HEgA/jsz48nTxcR3x1Mpgy
X-Received: by 2002:a17:906:e0d8:b0:a27:6e73:a248 with SMTP id gl24-20020a170906e0d800b00a276e73a248mr773799ejb.68.1704468120505;
        Fri, 05 Jan 2024 07:22:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1Qf95Xc1DtQrvYbmkcZs/ajyvnuK5OKpFVhctUoOgo9efyvmBIthHb9SYj+TsVGtv7sYLnA==
X-Received: by 2002:a17:906:e0d8:b0:a27:6e73:a248 with SMTP id gl24-20020a170906e0d800b00a276e73a248mr773791ejb.68.1704468120298;
        Fri, 05 Jan 2024 07:22:00 -0800 (PST)
Received: from amikhalitsyn.lan ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id i23-20020a170906115700b00a298adde5a1sm345630eja.189.2024.01.05.07.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 07:21:59 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] fuse: __kuid_val/__kgid_val helpers in fuse_fill_attr_from_inode()
Date: Fri,  5 Jan 2024 16:21:29 +0100
Message-Id: <20240105152129.196824-4-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the sake of consistency, let's use these helpers to extract
{u,g}id_t values from k{u,g}id_t ones.

There are no functional changes, just to make code cleaner.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b8636b5e79dc..ab824a8908b7 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1489,8 +1489,8 @@ static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
 		.ctimensec	= ctime.tv_nsec,
 		.mode		= fi->inode.i_mode,
 		.nlink		= fi->inode.i_nlink,
-		.uid		= fi->inode.i_uid.val,
-		.gid		= fi->inode.i_gid.val,
+		.uid		= __kuid_val(fi->inode.i_uid),
+		.gid		= __kgid_val(fi->inode.i_gid),
 		.rdev		= fi->inode.i_rdev,
 		.blksize	= 1u << fi->inode.i_blkbits,
 	};
-- 
2.34.1


