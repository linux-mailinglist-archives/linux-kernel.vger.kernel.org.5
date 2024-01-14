Return-Path: <linux-kernel+bounces-25420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDD482D002
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 09:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26532827EB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 08:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA171FA3;
	Sun, 14 Jan 2024 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="WRMCFOOo"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2141C10;
	Sun, 14 Jan 2024 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705220786; bh=6l6JvDwd17xpT/30vUVk4iwVg5zDBrtqmrHHKrRXSeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WRMCFOOoNf2M2/tP5mq3w64wXHuwvEfnPAEgx3ckWkKrvLJ8aW+DeOSlBEjanDvnJ
	 nV+Khh4vuj9a4CyL4Ev6Gu0mBqlTTzhP2Nc7n9vG70X99aOTXeX4tHJPWDMI2YWlpE
	 p54Xv0Dfv6mcIzuNVZZipyBH7f4J8UOrvEGMRxYU=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 51082085; Sun, 14 Jan 2024 16:20:16 +0800
X-QQ-mid: xmsmtpt1705220416to8sr3orf
Message-ID: <tencent_E44436084AA874977705670A3CDD37BE9609@qq.com>
X-QQ-XMAILINFO: MesT5uKpDagV9MmQ/1zIYMlQihmgFDb6NPm/p2dK3LPZqNPQPXyxrvYorzNEmh
	 iSRVPydy+NRalogH+GW/L6dugwRt805aTGNet3+JkuG8E8etlaPqpDs5biStfRW5D4I5pbpLPWf0
	 VD+AO3gKt297ZKwTRa39UBBT9u0rCfcHnl582scB7hTYe+WTe0rCLHlGzGzWUoOU6wTPNyqqDMzb
	 RgHDB64p9z/tJ3joGPSTkegTrCdvLjTGh8g0QKK4INpapWzWavyKUTpwSXWQSy5GeSYpyIJF01o7
	 CSRuW8U9CU14oYCWxdMRlixhKJ0VuHI34QTs90aVaPD2uH0CuSmO8liathxhAQ/eyq21ntkqDvmD
	 JWW640uC5ID0fxWpxOTj9SfX4nXwqDuNkeDrmfUGTDpVm1UnWFITyKu52cbszEy7RaSFv+btHw5+
	 GAO4S3sOwqhaViOt/ctZw98hqQ3JLVme7+v5+52KhUZViNbpMnCldN5wBMG8+AkDaqlvQyVaf7Cq
	 lbCumJO59/mLmPJ1o8IAXit4srKhkvonCqf+sbO15ov1wwPtiBZ8yg9c4RLJue4+m8rA1a06pCvN
	 OI5jhOuOjTGuVmsOYISiLDOdls725u95RYPdak7KO1nv3+ZOzrdwMqvRuniA7CUYMGJG2EFGJ5BO
	 ss00bZchAuNakLZN74bkLMJUbsuoK0IQGbigIV7hESAfN3R6vpEsZ0H/TVPJGTTkxcXelPPxWYNw
	 mV5o64kk2ZVgnabo/iYDvIC02dFlgPE1eJw6y+04XO7UwsXvE3v10x5w3SdsUhcbMZhgj+sA97pR
	 vzn1Y+7v7fDLCFb9QCgV1E9WbVTZtDk8fJ/605zfTtDZOtWNxtBWtapM+WUl3Cio0ReF0qheOcB8
	 RxKZNKuv32+0UDABngyHtWUYUNExO4Nhs2yPbzZPwnFwc2icHvO5saNBzdP9EgpDdx7rjMm7xYw/
	 y2FY2IxaU=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2b131f51bb4af224ab40@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	gregkh@linuxfoundation.org,
	hdanton@sina.com,
	krzysztof.kozlowski@linaro.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stern@rowland.harvard.edu,
	syzkaller-bugs@googlegroups.com,
	torvalds@linux-foundation.org
Subject: [PATCH] nfc/nci: fix task hung in nfc_targets_found
Date: Sun, 14 Jan 2024 16:20:17 +0800
X-OQ-MSGID: <20240114082016.2664478-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000a041b0060eb045ec@google.com>
References: <000000000000a041b0060eb045ec@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nci_start_poll() holds the dev->mutex required by the kworker of nci_close_device(),
and the related tasks are as follows:
|cpu0                          |cpu1                                           |cpu2                      |
|nci_close_device()            |                                               |                          |
|mutex_lock(&ndev->req_lock);  |                                               |                          |
|...                           |nfc_genl_start_poll()                          |                          |
|flush_workqueue(ndev->rx_wq)  |mutex_lock(&dev->genl_data.genl_data_mutex);   |                          |
|                              |nfc_start_poll()                               |                          |
|              	               |device_lock(&dev->dev);                        |process_one_work()        |
|                              |nci_start_poll()                               |nfc_targets_found()       |
|                              |nci_request()                                  |device_lock(&dev->dev);   |
|                              |mutex_lock(&ndev->req_lock);                   |                          |

Therefore, before applying for req_lock in nci_request(), it should be determined
whether the execution of nci_close_device() has already begun.

Reported-and-tested-by: syzbot+2b131f51bb4af224ab40@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/nfc/nci/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 6c9592d05120..9a277228a875 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -145,6 +145,8 @@ inline int nci_request(struct nci_dev *ndev,
 {
 	int rc;
 
+	if (test_bit(NCI_UNREG, &ndev->flags))
+		return -ENODEV;
 	/* Serialize all requests */
 	mutex_lock(&ndev->req_lock);
 	/* check the state after obtaing the lock against any races
-- 
2.43.0


