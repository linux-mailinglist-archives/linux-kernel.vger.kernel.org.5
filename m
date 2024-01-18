Return-Path: <linux-kernel+bounces-30080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587F38318E6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D36B2421B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E46D24A06;
	Thu, 18 Jan 2024 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9TpMPGx"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A2E241E9;
	Thu, 18 Jan 2024 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705579670; cv=none; b=k8QYr6KDI6QYhRRVTHDrc01W7JNtNEml5id5JbYfH1b+efOb9qM+EGU8mwCOF3otcqqBFQG3z6nh2icQCYuNWhB1arYKiGMRYH7nqI/Sg7h7gyVjKpQLXkCejst296OevgQZCTphTKv5avS8SLBKB1Z8sLui+0sy9G4f+onGVjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705579670; c=relaxed/simple;
	bh=Sfs0grAFRkw/zBunrBwd566BmWSyT4Zsgtf43ksD36A=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=DYD7u/AyloGnz+F+LPNOxS7XFqOaMzlw24vzTUUc21xdoMvO0wwZMFBX+PijkkKavJzglAZ7ByAmOttd8iEzdS9w3vNKpMMrJZ+DOB2h1xDWv0FZZRRDC1fnORPSsbKoFs5XIrIFQswqmEP4N4vyMchgRk/WRxNRvbDyauASIAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9TpMPGx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e9101b5f9so5307365e9.3;
        Thu, 18 Jan 2024 04:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705579667; x=1706184467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4sCmIQx6AGFYTpS8ooyJWTqHb26hOTFWBxgbo7T6WeI=;
        b=b9TpMPGx/D8lYaZULgH3H/42cag8rzICRRg405HlqfdlJPP1304dZUfxLbbTHxXeor
         saOqERPhVxUBTA/oVu4ZUv8Y9ExcsMlo77NaKGPYWuIbdMPmNVEd9wifxwMRlWEngr+P
         j5D8MRsiiCdPB+dPYo234Ed2PikbzfZHtp8wXld/VlOdl3gEoJBabqMCE7INLP/7Aqql
         YTwkP0bZgJbreoiTxXYkanbfVpOntCbwdGOoBSY6cpBhVcRM7CtG97230ZqrbfdAL3MY
         kIgFHtMd6y+U+fAe9BBwytVIWLb0hpfXKd0GC+h58UmjaGuvxbWdBZSLp1e3LXrcreGk
         0miA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705579667; x=1706184467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4sCmIQx6AGFYTpS8ooyJWTqHb26hOTFWBxgbo7T6WeI=;
        b=xQlDqCb3veptKsnGKPFgLrsRlTJHOyUFRwQlbWiwPxhh4qrUlR5YJ30Krgy1mDuDmn
         +AvC0q0JgR/XiKVPsUbIWJ8kVX4hibnq0XiRLQoXvrnXpFwXRFDqBj0M9muPPcuPxE1Z
         deXPZeho39JPf0eQlck6MtUUiunq9HWOdVu9gIvUI9C/qGGi5FeC/jHSgE4xPNvAsZFL
         Yf6dGu6+BZZEkfO9rsFKngX+Nu8gP+2hZ2Wrf60oK56tjioMZW2w5Tn7Kdzz7B5y0TfI
         wqw0AfpUNbuIGwZo8DdjFMcWBZ1c52VBfseYk32sh/Uto5T4Enc28IYAW51jvti8WJXn
         Db9Q==
X-Gm-Message-State: AOJu0YwtgbCuLEL919h/FKhimInenbCHaSCuPOxVrJmEz8Pz/A1pwxEq
	JLAJ4CKbVMsZTCkeTjRHMby+9ALLJR98SVb0E8ALHQFMank/N+VlnoOJ3X1n
X-Google-Smtp-Source: AGHT+IFI2KpYg6ESmlPKx7B/dBNMJwuHYhi+S0sXgWlbDOeT1O2++W7P4U8MGNKxKy0yjsOLU4Cjsg==
X-Received: by 2002:a05:600c:754:b0:40d:492d:c376 with SMTP id j20-20020a05600c075400b0040d492dc376mr449796wmn.114.1705579667210;
        Thu, 18 Jan 2024 04:07:47 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a12-20020a5d508c000000b0033763a9ea2dsm3908725wrt.63.2024.01.18.04.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 04:07:46 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] crypto: asymmetric_keys: remove redundant pointer secs
Date: Thu, 18 Jan 2024 12:07:45 +0000
Message-Id: <20240118120745.2519762-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The pointer secs is being assigned a value however secs is never
read afterwards. The pointer secs is redundant and can be removed.

Cleans up clang scan build warning:
warning: Although the value stored to 'secs' is used in the enclosing
expression, the value is never actually read from 'secs'
[deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 crypto/asymmetric_keys/verify_pefile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index f440767bd727..2863984b6700 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -28,7 +28,7 @@ static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
 	const struct pe32plus_opt_hdr *pe64;
 	const struct data_directory *ddir;
 	const struct data_dirent *dde;
-	const struct section_header *secs, *sec;
+	const struct section_header *sec;
 	size_t cursor, datalen = pelen;
 
 	kenter("");
@@ -110,7 +110,7 @@ static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
 	ctx->n_sections = pe->sections;
 	if (ctx->n_sections > (ctx->header_size - cursor) / sizeof(*sec))
 		return -ELIBBAD;
-	ctx->secs = secs = pebuf + cursor;
+	ctx->secs = pebuf + cursor;
 
 	return 0;
 }
-- 
2.39.2


