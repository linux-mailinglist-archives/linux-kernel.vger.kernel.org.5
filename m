Return-Path: <linux-kernel+bounces-151052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268B18AA863
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A621C20B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526A1182C5;
	Fri, 19 Apr 2024 06:22:13 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA284D515;
	Fri, 19 Apr 2024 06:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713507732; cv=none; b=bVOtLATh29SBy3CiDtePkHjfJN7eonkkiwY4N6TVvlHGB7eQ6/OCbH+oCU7ZPGCNOUA3RkVDGt9QOvNN+ZfL9Y6WYoBUkQVhCuBvEJztS55kLtc9HuvRVfvuKS8fVp7iCtcU9x7KUAODbI6BBsJSRRnITa5Hiw8AV6Maczam1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713507732; c=relaxed/simple;
	bh=gw642tX2UMxYZ0kju62sZCES2c1hxstbaHoRke+U3yo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DsYsmDKAoh+Q8P38+90fE3oSWBZjZ4t0U5SAUPzE3zx0zsdRor8dk8Wt8yvHhqetg2d6o/XZ75DnXMhiPqf0YNfZpxmdQDhMgzhbc/5Z43WsLwgr8bwCGW9rIcrCrcDAdwgngtWw5ej2R1OFE4S4Qj9SmZIcULeUOCVCYuojT0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VLPc52dwRzwSwh;
	Fri, 19 Apr 2024 14:19:01 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 695E318006D;
	Fri, 19 Apr 2024 14:22:06 +0800 (CST)
Received: from huawei.com (10.175.101.107) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Apr
 2024 14:22:05 +0800
From: Ye Bin <yebin10@huawei.com>
To: <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
	<chandan.babu@oracle.com>, <dchinner@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH RFC 0/2] xfs: fix potential create file failed
Date: Fri, 19 Apr 2024 14:18:46 +0800
Message-ID: <20240419061848.1032366-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)

This patch set fixes two potential issues that could cause failure to
create files.

Ye Bin (2):
  xfs: fix potential create file failed
  xfs: avoid potenial alloc inode failed

 fs/xfs/libxfs/xfs_alloc.c  | 32 ++++++++++----------------------
 fs/xfs/libxfs/xfs_ialloc.c | 13 ++-----------
 2 files changed, 12 insertions(+), 33 deletions(-)

-- 
2.34.1


