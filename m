Return-Path: <linux-kernel+bounces-104168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6663287CA06
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAD31C2259D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C941757A;
	Fri, 15 Mar 2024 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v+A7hwAq"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306DA13FF6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710491761; cv=none; b=eRELmrDB4FV7uCk7vkWlnXmAYburR/iDNNwJUK9ti3erAh7IJiZiSG9My7tRsjrPRIYPsi4PbI4pOQb/DnDJ/kHQzt757VaDh3GmVqODzlspDkOTnsLAxW4a6JnWIEW0iMwOhYtO4qpYQshEV6eH3M5e10otImv2T7DP5qbcCH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710491761; c=relaxed/simple;
	bh=n4G4T8oSzvPqCykLFBPu7YRsZb7NCUXHPm7H7F+I6B8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W112VOypqpr8t4C538niiyKUPyMpE+oevN1NS/0UTq3uiXweIf93a9TcqzrI8HostNQdlDhMplOQP53nCyE3wehhqizzlpouNp7WvaFJ4VWweuGh3i3OrRlQt5XycqGcf1CXWcGhLTMrwm3IuWvvVaIuurjGNIK01JJ6OhWL+3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v+A7hwAq; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710491755; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OS1OAx3gqUeFAauhXemYnWq9aR/43E4kD1qguWWMjps=;
	b=v+A7hwAqGUA2h9WYP8LXt01nl8NTL3htt2v60MXqNfOJSDnO1gxtOttiTzXDrxhMiLR622HPCQqqzFAV+qHYefnOs48g5f7fUCbEJvC9Ll86IwD3QwC0xUsIF7bR+Fy7kdCC1hjXmKdP63SHEJreQGihBssqxge8vMhaJSUmtKk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W2Vhqfq_1710491754;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W2Vhqfq_1710491754)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 16:35:55 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] fs: Add kernel-doc comments to __gfs2_holder_init()
Date: Fri, 15 Mar 2024 16:35:51 +0800
Message-Id: <20240315083551.76624-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds kernel-doc style comments with complete parameter
descriptions for the function __gfs2_holder_init.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/gfs2/glock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 34540f9d011c..08e2fe282190 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1260,6 +1260,7 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
  * @state: the state we're requesting
  * @flags: the modifier flags
  * @gh: the holder structure
+ * @ip: an opaque identifier for the caller
  *
  */
 
-- 
2.20.1.7.g153144c


