Return-Path: <linux-kernel+bounces-49449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFA9846A71
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E778A1F22CB2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7359040BF4;
	Fri,  2 Feb 2024 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TZNAUWqq"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0057042073;
	Fri,  2 Feb 2024 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861605; cv=none; b=pWzdEAmkH6f8l/0yxDLfqgmn//R+iUEQN2cOYEtpWXRU3+0hQkaPwgaDrbXuP6yQ6GJUvDj4XwcGxOnyb8OLLZqh6El1JLAhbhuvcX438B0EV81oxvGdk6yXK0Dbxalc3J6yBlTl1ubS/BkAfCj19ueDU1VtLwrx415W6GL+oy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861605; c=relaxed/simple;
	bh=qrUxpwVEvWbKMnTLIqyVsjTe+MTNfHvKhmmLvn0sdu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OHIt/opxDCfyawiBcPwetiNKYLXva+jbcZYvT6HTClvlzNmHWJrBmXij0wiiExf6wok6yLKrkwsQGoWh5y9eLiwkHD5wVGOhH8mBr3maYwmXej9yQZpSJb2UD/Sz9S23CxegyMcTfQYQeh/cZS07rWRQH9dlEJD3cMSk+biZPQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TZNAUWqq; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706861599; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=BA78W94TsX1NZo3/wDkJ/GmaTt/bWE4n+U2Ht/EEKi4=;
	b=TZNAUWqq/FpnqnePkkQAr+MtYVBSPTn8ux9cb+S0b1W+bW1wQbvINAn9ihg91FzKqRxUt/bPsgfJmVCxgHLOuHUeYroLs0GwdlvRtYB4A7v4DVfxXYPXo4ZyUdoBCNh376ostJhkm7/4zoL3/h+q2xi1qNerJMEl47GhKlhK2w4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W.wLjLr_1706861598;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W.wLjLr_1706861598)
          by smtp.aliyun-inc.com;
          Fri, 02 Feb 2024 16:13:19 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: linkinjeon@kernel.org,
	sfrench@samba.org
Cc: senozhatsky@chromium.org,
	tom@talpey.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] ksmbd: Add kernel-doc for ksmbd_extract_sharename() function
Date: Fri,  2 Feb 2024 16:13:17 +0800
Message-Id: <20240202081317.128980-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ksmbd_extract_sharename() function lacked a complete kernel-doc
comment. This patch adds parameter descriptions and detailed function
behavior to improve code readability and maintainability.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/smb/server/misc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/server/misc.c b/fs/smb/server/misc.c
index 9e8afaa686e3..1a5faa6f6e7b 100644
--- a/fs/smb/server/misc.c
+++ b/fs/smb/server/misc.c
@@ -261,6 +261,7 @@ char *ksmbd_casefold_sharename(struct unicode_map *um, const char *name)
 
 /**
  * ksmbd_extract_sharename() - get share name from tree connect request
+ * @um: pointer to a unicode_map structure for character encoding handling
  * @treename:	buffer containing tree name and share name
  *
  * Return:      share name on success, otherwise error
-- 
2.20.1.7.g153144c


