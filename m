Return-Path: <linux-kernel+bounces-20675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FD6828359
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106BA28AA23
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7AA35887;
	Tue,  9 Jan 2024 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JYu9tX9H"
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C6733CED;
	Tue,  9 Jan 2024 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704793121; bh=AzERsTe4iifZ3yUxSLa14M3+lHAO7HrXuc1YkqElR1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JYu9tX9HyQ6ZzgNrIz1+4dLBY7BdEZvoAKZg+mBz3Li748ZbeSI8mIUrSyx1PDODp
	 dkgXAN5H/oMOMxuZo/5wI5pF+WH4N8m++DkOVNwPQzFBZl/Myixc/VytEjMlI3jchm
	 6o0P9fwk26UCXsSB3ZeKOL5aodC01ICtc4DDnG6w=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 82294E65; Tue, 09 Jan 2024 17:32:34 +0800
X-QQ-mid: xmsmtpt1704792754tcw7rzjbi
Message-ID: <tencent_146C309740E8F6ECD2CC5C7ADA6E202D450A@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+zj8Otn7YvBohfHC0fy23kZUcjScuxcWltv+1S+IIhq/kbnNDf5T
	 GhanIkVQQJXJU7tPy0AJTngditIH2sJHKy7HQHmHrLAyqdBL5AHzgc+q6Uu0GYF1pIfJQdkv2U50
	 UcbVHHEX6hYCV2MOLUOI8XoJDISPmYBW9423K3jiIfEW0hEu9I9c0XzwC38f9F2x9Jvlq0OXzuby
	 egR29jdSZBvqh6tnEyHTW7AFUfcAzT5Y1dqmZTXgXvSmxf6cwMgYtVXHJNr9zYcY7mICncpeG9aY
	 6mc2Ez0iql9DxmacuRJih9b/ysD3o3hl04EJRkG4GOxbPG0U4sup8ImCDplbnmbqhOnAWfCzNr/e
	 0RFsAI0Mo/TdMN04/4UXm0Tgv7KbvqEMjsI/y7qtoAd/cPlT2hLcOIhiFUbOpCr1IqXRYds97Dch
	 qDSnD/62T2VoGE49XJzDaYJa4vbCD27EZFV7PqugTXb166AOEJYJLRD4d7YqtGv0AcdQ8ZnjL+cC
	 iY93pghBzpGkYyOBa0j6D7Voq1j4RVI9SV1JS0vucBnvTp5Sj9MpHHEPykOGvpAN8UNVueek6IHc
	 vXitgVbHJOeMFklNkzDeov/fZqpWdpxuHThmFdfWrF4PXzAtyvDUlzQ9W5Tm2edhYyCC5awAvPZs
	 GJmRqvoX32loEPDTBCm0w5oJh7As4Lzn6WlI9ATzhyUbAN5stO+/o7q8JB/Cdt0UjCm9iF+nzK5p
	 0QT0fKlXprk17TJ0Y9b7gYHGhPMbp7PxZmhHBY85OFNPw7jK+RAbTwI9HJLm5w5+kqNi5KfyVTp6
	 kKX6DUM4pqobwatVJFGEve0JP/GU0Qj/I3eNH+rUukLc6V3SjAc/e2N3eno0rHuki3yqGzBrEQ7G
	 jc9NQda98nQ7TnPQHZLaw0hYFIikBZH+GtZS3a38LYwSxfzAMRDSWexgE4Lj1LoLzIyslX/f0F
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f2977222e0e95cec15c8@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	borisp@nvidia.com,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	dhowells@redhat.com,
	edumazet@google.com,
	jakub@cloudflare.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] tls: fix WARNING in __sk_msg_free
Date: Tue,  9 Jan 2024 17:32:35 +0800
X-OQ-MSGID: <20240109093234.561184-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000aa2f41060e363b2b@google.com>
References: <000000000000aa2f41060e363b2b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot constructed 32 scatterlists, and the data members in struct sk_msg_sg 
can only store a maximum of MAX_MSG_FRAGS scatterlists.
However, the value of MAX_MSG_FRAGS=CONFIG_MAX_SKB_FRAG is less than 32, which
leads to the warning reported here.

Prevent similar issues from occurring by checking whether sg.end is greater 
than MAX_MSG_FRAGS.

Reported-and-tested-by: syzbot+f2977222e0e95cec15c8@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/tls/tls_sw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index e37b4d2e2acd..68dbe821f61d 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1016,6 +1016,8 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 
 		msg_pl = &rec->msg_plaintext;
 		msg_en = &rec->msg_encrypted;
+		if (msg_pl->sg.end >= MAX_MSG_FRAGS)
+			return -EINVAL;
 
 		orig_size = msg_pl->sg.size;
 		full_record = false;
-- 
2.43.0


