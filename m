Return-Path: <linux-kernel+bounces-30986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D2983271E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C66B1C2187A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1184C3C46D;
	Fri, 19 Jan 2024 09:57:18 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9986A3C463;
	Fri, 19 Jan 2024 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705658237; cv=none; b=nZ+tRwfhufwz5CJFU2Jx3SJm/9dSj+g5Vr7hJbt65SupSYWkJbfoASbhmcJ8txfn24QBJ8Yq8pSpJd0evtQiZziN0Z25v6ELEtbBhCOSsL16oH0lZgRwuWtNutP7JAYF6QI/M0xO6FvCIubuW2a4h8L3m2V8G5pYoE7XMIY7V5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705658237; c=relaxed/simple;
	bh=ugcIKYXuuIIdvqm9fPsjbcKxZwNOl92EzCsZNTFQ/Yw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Raypc0yiL9AXWsNOjAhz563NoXq0EVgGESTONKfZT4dKEO2EmWS2jaldSbQVPdZ5+Ui/a+561hGqiUd0oc23bEzkOJgdAKgsBk+yKrTG2NeBahPIoVh2uyF47JggsquMglzQo2lASDzbCIFOxdr8rdFEKCH9nUeiN+Y53rMkELk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W-viV-._1705658228;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W-viV-._1705658228)
          by smtp.aliyun-inc.com;
          Fri, 19 Jan 2024 17:57:09 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: linkinjeon@kernel.org,
	sfrench@samba.org,
	senozhatsky@chromium.org,
	tom@talpey.com
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] smb: Fix some kernel-doc comments
Date: Fri, 19 Jan 2024 17:57:07 +0800
Message-Id: <20240119095707.120338-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some kernel-doc comments to silence the warnings:
fs/smb/server/transport_tcp.c:374: warning: Function parameter or struct member 'max_retries' not described in 'ksmbd_tcp_read'
fs/smb/server/transport_tcp.c:423: warning: Function parameter or struct member 'iface' not described in 'create_socket'

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/smb/server/transport_tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 9d4222154dcc..002a3f0dc7c5 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -365,6 +365,7 @@ static int ksmbd_tcp_readv(struct tcp_transport *t, struct kvec *iov_orig,
  * @t:		TCP transport instance
  * @buf:	buffer to store read data from socket
  * @to_read:	number of bytes to read from socket
+ * @max_retries: number of retries if reading from socket fails
  *
  * Return:	on success return number of bytes read from socket,
  *		otherwise return error number
@@ -416,6 +417,7 @@ static void tcp_destroy_socket(struct socket *ksmbd_socket)
 
 /**
  * create_socket - create socket for ksmbd/0
+ * @iface:      interface to bind the created socket to
  *
  * Return:	0 on success, error number otherwise
  */
-- 
2.20.1.7.g153144c


