Return-Path: <linux-kernel+bounces-93698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E57873378
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42941F22D62
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BE45F554;
	Wed,  6 Mar 2024 10:02:30 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 7B85D23772;
	Wed,  6 Mar 2024 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719349; cv=none; b=R5zXv9Dz+dwrd+sfnwIqXZyMBeS54+HuFbgtr1Ds5IuDmnIs69Hxhm5q/QBNFcfjBbKU9PDonn7rkVspRRYPmtnL2jTS7eedDzCp7/EVztF1idmF18vgpYpfg0EBeB1mA7GzCBq4B+eYPBC549U9/yFKbgje8cvCcHGF9GjB3HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719349; c=relaxed/simple;
	bh=Y/vw2m0mqKjUysumAhyd8tDimnylKASFxMqN+1uA76s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lUa6i33Usd13nY+/xkUdjnHgW4xHojVevLPUxNMenswXl4PqP81hX70gwxhD2qZUSTI8NO/OWakavtUVrpuxouBvThvu1ydUo975qXQMmVSv8fYVfOurqbp7Ju2sQuvSW32JLQ9No1ZPj91fTeJvSJzsAdiuM5K3wFnx4G0EUpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 21F12602FFF41;
	Wed,  6 Mar 2024 18:02:23 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: jonathan.derrick@linux.dev,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?sed-opal:=20Remove=20unnecessary=20=E2=80=980?= =?UTF-8?q?=E2=80=99=20values=20from=20err?=
Date: Wed,  6 Mar 2024 18:02:16 +0800
Message-Id: <20240306100216.69340-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

err is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 block/sed-opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index e5b069dde905e..b6887920a84e9 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -2153,7 +2153,7 @@ static int lock_unlock_locking_range(struct opal_dev *dev, void *data)
 	u8 lr_buffer[OPAL_UID_LENGTH];
 	struct opal_lock_unlock *lkul = data;
 	u8 read_locked = 1, write_locked = 1;
-	int err = 0;
+	int err;
 
 	if (build_locking_range(lr_buffer, sizeof(lr_buffer),
 				lkul->session.opal_key.lr) < 0)
-- 
2.18.2


