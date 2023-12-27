Return-Path: <linux-kernel+bounces-11792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF8781EBB8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 04:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763BC1F22C83
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3E53C2C;
	Wed, 27 Dec 2023 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="C8/tcH2w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0FE3C16
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703646218; bh=oUkaS1sJVaXK+BY4ope+OPz+sUYoqu2NxZWQgnK+Vvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C8/tcH2w+a4wBMBTRFzE9U053fdalr34NsmWMmaTmu5rE6sL5oPCDbcDOG2kXoo1R
	 8AHAZyz3Y7+S/RvCKQSF56glo5UP4TCsNzwIksg5SYCxBwKdRiNW9a6CkyTAb0hYW2
	 Axn7w05bOJfPQ679q9dXt6oaIORgZdB5IrwmKdMc=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 6C4B2A3E; Wed, 27 Dec 2023 10:27:04 +0800
X-QQ-mid: xmsmtpt1703644024ti5p1auwv
Message-ID: <tencent_FF866D3C2E416D7494ACE9BEED56CD88780A@qq.com>
X-QQ-XMAILINFO: NRN3UPsLzYKVVo5pFEUSl+h02cm1Oaxah5rMsx3/K126T6zN+PWs+uKOj8HQ/g
	 7oH+q9TVPUzXB4y9TStuFnEh4o7A7MzLtZ6b5+pnRytJzFsqKSQPELJ5vFP8FsF64BB6VHtLa1zp
	 3kLu8PTlyl7PLOLIhLfWK+iVLf81BhXmKOoiiMBKrsAHG1JtD6c/x8MIpnyNFQ5H3739jDPRc01P
	 hR21jzApjkgsXRQTw1+RkK8Vb7IVnjoEPO8AMDnrg7RWIKMQDmV6wp6aYy8FtOP6oU56xUDoIURp
	 2z1M7uA+8s6bo+QZ9bU1gjjSoYGsXgpJ+muta9rJTeap7dE09VLBLXFnVF4Qft/EII/ivohUQy9B
	 PTckkScbPLQWhVfYhcp8NvNbPrHA47deWuDNbLwBJokV8kEk3bqQ+mxlnyWgHkFiS9gftVSGfJpF
	 XlyStm6wdiProVoe1d6YOZx3MF408q+gwZ6whMVsP82NJzmcCILQ4t/EV2bEjVcyrn9e3wjcHPj/
	 pvg1ih8jp7erLKFLAAl5ZLgXqsdQ01vXkM74IXmIkq6hQozsxrrz29aTU2siQpaXAe+dchHM2fCd
	 MLgqjTm+9xGx7AIXBMQr4IyVcFa/l5hqGIZ5zBp4MgBgZGvF1hToOR5vTlr1lriYInXjcQvtMlNB
	 07G8ShoCJi4JjE50uhQ3mbpZpkiODTL+cBSi5/JFW4ufooCMOialGrw30rJoiZBcKkq0dC52UIL9
	 uNP7fC3K1J/IBcN96E/iv5ng07nw6ghtFg07H9A3H+a72MTmbf/zciCXVwN5oKxYPiPVBOphyeGe
	 2q6qFYRXqlWieJszRLGq9XHbAYxHXfjHQfbGksLOq2PYOdHbNbUVJ0MvJZ0Vp1FuF85Fe0Yd4yq1
	 X1U33xI/Rmaqblvf2P9D6iNWVb9oT8cTEqwgPwoHtHgGYLBqinRBOIjV7cjQS9jg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [perf?] WARNING in perf_event_open
Date: Wed, 27 Dec 2023 10:27:05 +0800
X-OQ-MSGID: <20231227022704.2089296-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <0000000000000b05cd060d6b5511@google.com>
References: <0000000000000b05cd060d6b5511@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test WARNING in perf_event_open

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 39676dfe5233

diff --git a/mm/madvise.c b/mm/madvise.c
index 912155a94ed5..8fd3e00af243 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1405,6 +1405,9 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 	if (!madvise_behavior_valid(behavior))
 		return -EINVAL;
 
+	if (!start)
+		return -EINVAL;
+
 	if (!PAGE_ALIGNED(start))
 		return -EINVAL;
 	len = PAGE_ALIGN(len_in);


