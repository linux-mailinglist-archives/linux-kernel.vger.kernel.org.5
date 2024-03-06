Return-Path: <linux-kernel+bounces-93682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC661873333
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9441F25991
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A7E5F47C;
	Wed,  6 Mar 2024 09:56:29 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 9F4805F463;
	Wed,  6 Mar 2024 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718989; cv=none; b=PemhUTDOOurL2+2x/pw0wA3y6xmo+/JFW8Sckak49dI1gfNFPt3DQpwtuTjBH/szohQUy11rQeyWGxndaAR2QwTQC+flG+hrAR73lvuo/9hLLXIoJEdvxtxivT+MHgAxq8X7QcP5mTHppuAs95YBRc6vozn3+QmoKoAGs7mdcXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718989; c=relaxed/simple;
	bh=kXcsJDRnqE5dzKxi4skdQGwygZ46Qqo8ANVh1AtI8a0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nigEpDWvnudMPK2U7JMnXpmQ0ayQKRTAnlOkQqa+A5VeyanrNDaSpQQhHKPe474vnIailWYFi79/GEO6dTiJTe4YD/UGLPhC3ZFMyWzMnDE2rsdH02NTG+bsOn9pWqpNvZpxauLg4pvwS/Ej9Jm7+uqZrJgPdoBB8J3UsiQ/DFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 884D2602FFF5C;
	Wed,  6 Mar 2024 17:56:19 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: jonathan.derrick@linux.dev,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?sed-opal:=20Remove=20unnecessary=20=E2=80=980?= =?UTF-8?q?=E2=80=99=20values=20from=20error?=
Date: Wed,  6 Mar 2024 17:56:08 +0800
Message-Id: <20240306095608.26839-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

error is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 block/sed-opal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 3d9e9cd250bd5..e5b069dde905e 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1208,7 +1208,7 @@ static int cmd_start(struct opal_dev *dev, const u8 *uid, const u8 *method)
 static int start_opal_session_cont(struct opal_dev *dev)
 {
 	u32 hsn, tsn;
-	int error = 0;
+	int error;
 
 	error = parse_and_check_status(dev);
 	if (error)
@@ -1350,7 +1350,7 @@ static int get_active_key_cont(struct opal_dev *dev)
 {
 	const char *activekey;
 	size_t keylen;
-	int error = 0;
+	int error;
 
 	error = parse_and_check_status(dev);
 	if (error)
-- 
2.18.2


