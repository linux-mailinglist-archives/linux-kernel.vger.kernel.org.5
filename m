Return-Path: <linux-kernel+bounces-49367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61022846939
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169451F25C41
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C178D17BB5;
	Fri,  2 Feb 2024 07:26:10 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF681799D;
	Fri,  2 Feb 2024 07:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858770; cv=none; b=UQ9c570wBrBD9xTnZGK6QzlgUxc+bbZBwAxeH1/o2cjdJruryvWb3dxJg1dnk5xDYoEqHYLZzj/MJmi1ZlxuWcw6DE6ZWxc7QviDdZsNo/+ieeUeOWyXuv//ylAihJiUhG64u/T3dB5nrDni2iAei/TBzCla8269bksoIacrqfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858770; c=relaxed/simple;
	bh=lm9LwpnwHVLkoxdrAp2M03hn2nsbyzgQA6y9JS58UnU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PwvzKvw41oWUlaLdWr68CCIZINr8vSTinoxf1vhF5gGbZKMh/o6ma8vkRgPWPhmqyMJzfyLVpVQKZop6j3dWU23kWg27hk/KpBJujaQdHY89dFfzLcvoKcbN6Sk+QuhtuCg/hJBkW3cXn8q5xWyuL3ksqJrIMhVSICFvU2vFLzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TR6kP4Bthz1vssv;
	Fri,  2 Feb 2024 15:25:33 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (unknown [7.185.36.136])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CC081400CC;
	Fri,  2 Feb 2024 15:25:57 +0800 (CST)
Received: from localhost (10.174.242.157) by dggpemm500008.china.huawei.com
 (7.185.36.136) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 2 Feb
 2024 15:25:56 +0800
From: Yunjian Wang <wangyunjian@huawei.com>
To: <willemdebruijn.kernel@gmail.com>, <jasowang@redhat.com>,
	<kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<xudingke@huawei.com>, Yunjian Wang <wangyunjian@huawei.com>
Subject: [PATCH net-next v2] tun: Fix code style issues in <linux/if_tun.h>
Date: Fri, 2 Feb 2024 15:25:55 +0800
Message-ID: <1706858755-47204-1-git-send-email-wangyunjian@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500008.china.huawei.com (7.185.36.136)

This fixes the following code style problem:
- WARNING: please, no spaces at the start of a line
- CHECK: Please use a blank line after
         function/struct/union/enum declarations

Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
 include/linux/if_tun.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
index 2a7660843444..043d442994b0 100644
--- a/include/linux/if_tun.h
+++ b/include/linux/if_tun.h
@@ -27,44 +27,54 @@ struct tun_xdp_hdr {
 #if defined(CONFIG_TUN) || defined(CONFIG_TUN_MODULE)
 struct socket *tun_get_socket(struct file *);
 struct ptr_ring *tun_get_tx_ring(struct file *file);
+
 static inline bool tun_is_xdp_frame(void *ptr)
 {
-       return (unsigned long)ptr & TUN_XDP_FLAG;
+	return (unsigned long)ptr & TUN_XDP_FLAG;
 }
+
 static inline void *tun_xdp_to_ptr(struct xdp_frame *xdp)
 {
-       return (void *)((unsigned long)xdp | TUN_XDP_FLAG);
+	return (void *)((unsigned long)xdp | TUN_XDP_FLAG);
 }
+
 static inline struct xdp_frame *tun_ptr_to_xdp(void *ptr)
 {
-       return (void *)((unsigned long)ptr & ~TUN_XDP_FLAG);
+	return (void *)((unsigned long)ptr & ~TUN_XDP_FLAG);
 }
+
 void tun_ptr_free(void *ptr);
 #else
 #include <linux/err.h>
 #include <linux/errno.h>
 struct file;
 struct socket;
+
 static inline struct socket *tun_get_socket(struct file *f)
 {
 	return ERR_PTR(-EINVAL);
 }
+
 static inline struct ptr_ring *tun_get_tx_ring(struct file *f)
 {
 	return ERR_PTR(-EINVAL);
 }
+
 static inline bool tun_is_xdp_frame(void *ptr)
 {
 	return false;
 }
+
 static inline void *tun_xdp_to_ptr(struct xdp_frame *xdp)
 {
 	return NULL;
 }
+
 static inline struct xdp_frame *tun_ptr_to_xdp(void *ptr)
 {
 	return NULL;
 }
+
 static inline void tun_ptr_free(void *ptr)
 {
 }
-- 
2.33.0


