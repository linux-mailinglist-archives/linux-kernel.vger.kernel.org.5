Return-Path: <linux-kernel+bounces-28440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CC382FE89
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF78E1F24E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0117917E9;
	Wed, 17 Jan 2024 01:46:05 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9081864;
	Wed, 17 Jan 2024 01:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705455964; cv=none; b=AetgyY0t5dXtJKL3zqw/blDihMWkB+G1ZEBaKNT9gkX6gvYzQTbjHE65FWNcSaXz1ceonvhrk+OOkn7gmEGsGrmOB3C8OInC3yftU9klf6804yWnmbnJ+Z4z5dpIRhnm9GUrYI+w5+35gPGMUthlChFinDLSmk78sTmrNpaJEdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705455964; c=relaxed/simple;
	bh=fgPwF9xhCsHvun6QMTgmDHGlC69r9M6BgvAyZFblfY0=;
	h=X-UUID:X-CID-O-RULE:X-CID-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:
	 X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=PR8HAIYk76xkzgZSgTwbwKg1Nzv9Ap2y2z54sM6KvRJOfvqkydPwGp8RN11gIw7YdkzW9SjsQL0g365WXzXANWdJf9EZ7q6JlZKFAF52ggRZEWI9KT5DT7rB0JFOr04n7gck1H8bnoCaBIIYGkc+6q8Zk5+2Bt6Rq5EEbK4aJ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 711b0d93f1fa43b4b0a2a28e58723e95-20240117
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:003e1394-ef5b-4aef-aabe-c69c16c4d8b7,IP:5,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-INFO: VERSION:1.1.35,REQID:003e1394-ef5b-4aef-aabe-c69c16c4d8b7,IP:5,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-10
X-CID-META: VersionHash:5d391d7,CLOUDID:00573e2f-1ab8-4133-9780-81938111c800,B
	ulkID:240117094108WJOCVTCR,BulkQuantity:1,Recheck:0,SF:38|24|17|19|44|66|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:41,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 711b0d93f1fa43b4b0a2a28e58723e95-20240117
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
	(envelope-from <yaolu@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 298752770; Wed, 17 Jan 2024 09:45:49 +0800
From: Lu Yao <yaolu@kylinos.cn>
To: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Yao <yaolu@kylinos.cn>
Subject: [PATCH] lsm: Resolve compiling 'security.c' error
Date: Wed, 17 Jan 2024 09:45:41 +0800
Message-Id: <20240117014541.8887-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following error log is displayed during the current compilation
  > 'security/security.c:810:2: error: ‘memcpy’ offset 32 is
  > out of the bounds [0, 0] [-Werror=array-bounds]'

GCC version is '10.3.0 (Ubuntu 10.3.0-1ubuntu1~18.04~1)'

Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
 security/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 0144a98d3712..37168f6bee25 100644
--- a/security/security.c
+++ b/security/security.c
@@ -792,7 +792,7 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
 	size_t nctx_len;
 	int rc = 0;
 
-	nctx_len = ALIGN(struct_size(nctx, ctx, val_len), sizeof(void *));
+	nctx_len = ALIGN(sizeof(struct lsm_ctx) + val_len, sizeof(void *));
 	if (nctx_len > *uctx_len) {
 		rc = -E2BIG;
 		goto out;
-- 
2.25.1


