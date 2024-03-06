Return-Path: <linux-kernel+bounces-93720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61E78733BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6174A285D50
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9DE5F862;
	Wed,  6 Mar 2024 10:14:58 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id D84A95C911;
	Wed,  6 Mar 2024 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720098; cv=none; b=ks0wkqOie7edlIp75l5jTeU4aBvzHwk7uqIpF+MBqq1DfY4MFV2UUxvtT16WB8hCsinE4E3n1V/OeHZ/7M9YAgGdjiMj3dNPQ8pnZHQ1mNOxR22Xq+X6BHb9+DXlXxZ0rCTuB1dg5qd2kAm3OOI9fBqfnuCwodDzRsopKHODk/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720098; c=relaxed/simple;
	bh=UZ7/cWck2FA3uFUivhbIlq/keQvDrUcLIV3QGDzLZr0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=WWZ/8Z5jYcSokkVSzDPYhTTGiK8wwk2MMDxEI6RaO8AgMqkJ94bDgL1FBRucMJTEnQmPBLO/U2h+V+ageCjPyNssmHgZWsO7kIhXMC+l+RRvPdwPeAqkkRuPtY6I7Rm3o9xqtwh/HfA9zzVHAylq4ihRxbx7TwRqV678pr57MiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id D407E60303ED2;
	Wed,  6 Mar 2024 18:14:51 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li kunyu <kunyu@nfschina.com>
To: jonathan.derrick@linux.dev,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] sed-opal: Remove the ret variable from the function
Date: Wed,  6 Mar 2024 18:14:44 +0800
Message-Id: <20240306101444.1244-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The ret variable in the function has not yet been effective and can be
removed.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 block/sed-opal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index f62b7ee933f7f..25fdbb7e14ae9 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -3108,10 +3108,9 @@ static int opal_read_table(struct opal_dev *dev,
 		{ read_table_data, rw_tbl },
 		{ end_opal_session, }
 	};
-	int ret = 0;
 
 	if (!rw_tbl->size)
-		return ret;
+		return 0;
 
 	return execute_steps(dev, read_table_steps,
 			     ARRAY_SIZE(read_table_steps));
@@ -3125,10 +3124,9 @@ static int opal_write_table(struct opal_dev *dev,
 		{ write_table_data, rw_tbl },
 		{ end_opal_session, }
 	};
-	int ret = 0;
 
 	if (!rw_tbl->size)
-		return ret;
+		return 0;
 
 	return execute_steps(dev, write_table_steps,
 			     ARRAY_SIZE(write_table_steps));
-- 
2.18.2


