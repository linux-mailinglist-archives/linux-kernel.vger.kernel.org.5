Return-Path: <linux-kernel+bounces-138102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB9989ECA3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC311C2133D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3EA13D531;
	Wed, 10 Apr 2024 07:49:15 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C2013D521
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735354; cv=none; b=bhVqzo42utSlS3JOWWYdMszr9+Ixe/V7u83puk07vdwbWscRNFWCl27Xf4TbUAPhAv5iKb+ucSI0JvftHV17OR1NVl3+Thdc2mdqnt+laFe0AXXQh+BkSFfXzKtC2M8yIdAagE4eWkA+burSzpWKKBrfdFMHIQFAr3m+5CHVUYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735354; c=relaxed/simple;
	bh=tCAYH8SttXspLQuOho8vf/6RSFBLhheQNq/XMrpHCIw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Of7657/mUHrzAgZTezAOqRxJIRcRnHdB+H87wKSYqURKxkNWc9hih3TV5ZHmcinGimszKpIMaJSXZG1zKXwpZmYO9oHtMHy1UXWYFOC/uslNxF+yuMI3vh97+9DymGeUA/qu1oz70O9o6xhU9LB6qVISJgLGz/6eGqc2OGo5CSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VDvz164k0z1R5TK;
	Wed, 10 Apr 2024 15:46:21 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id DF3741403D5;
	Wed, 10 Apr 2024 15:49:04 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 15:49:04 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <daniel@makrotopia.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] ubi: Fix resource leaking in error handling path of ubi_init
Date: Wed, 10 Apr 2024 15:40:31 +0800
Message-ID: <20240410074033.2523399-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)


Zhihao Cheng (2):
  ubi: ubi_init: Fix missed debugfs cleanup in error handling path
  ubi: ubi_init: Fix missed ubiblock cleanup in error handling path

 drivers/mtd/ubi/build.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.39.2


