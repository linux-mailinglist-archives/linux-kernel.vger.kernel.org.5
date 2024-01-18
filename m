Return-Path: <linux-kernel+bounces-29713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3609F83123D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 05:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8351F22F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 04:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9568BED;
	Thu, 18 Jan 2024 04:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="a8hAjkVp"
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4F03D6C;
	Thu, 18 Jan 2024 04:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705553896; cv=none; b=Rq+Eeg9he5ZUNJM1KwLAQqmMMT7gNkJgz6PxGCmeUBCefdXeAyEzTuTTB1towGwh5y9CGtjCzt9Zn13LktKHpW5bZzowHS/L1+3H35ZTifw33Cp9EmkEGdWu/ty0oBH6e5B0WpSbtbNwflk68LhZLffdF3AjU3LmqzQtkLphvLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705553896; c=relaxed/simple;
	bh=Enl4F/akVXu5Cq2ueP176UiXDsjrybD4PWXMg0yfJ4Y=;
	h=DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=YYFZmAALzgJ3TW4LY2AmGR/oYQ3RXi6ccVILQ+PEuXeFNcNxezKYXyo2yST9vuv0ahruJTYNRzbz9tB7b2XoiNDmhASNzdov0KbUdYagzLMgX+pcfELqXy8mhVg2WPNK1EiFwhli2OQlIFMJOIHdKuKFVfzNnnv7+CfMiK0egaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=a8hAjkVp; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705553884; bh=RAcCICA1Zz6E2TBNavQSqyXxNAe1IfYeVh+Uvv0M0Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a8hAjkVpw7muk2ucVJs65RnTdWM6kqFuMUDeJJIWlpeYh8Cr3BfOT1aK/oQ7JWDl4
	 eVsseptnVue1csEz8ECyrKTmzzZUNoFIY/MxJD2qOK43FmvpTJ2md41hHfN4xfnFpk
	 XzXCMwMtdfIT3i8bNZxufKI6gZRFeCdJEKoFIp/w=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id A218DC1C; Thu, 18 Jan 2024 12:40:33 +0800
X-QQ-mid: xmsmtpt1705552833tcwpxxo9g
Message-ID: <tencent_E60894D8E85AEEF2CD9C787A6CA82F656C0A@qq.com>
X-QQ-XMAILINFO: MZ4XH1L85f1rlctwBaD/nu/jdJXs1x///trxCnpkc7YEFIa28ZB3LXM8oQfCay
	 XAPeHFddTXlV4E+UD+92hGm2/h0GNdeHJ3zsZd12OLWYU+QU8A78QHyrN53pRMq4ND3GvtNcbRoS
	 YfvTH8+nsvKLo3Y3kFTYRnYOk6xQl8vxfjf41nqmWPIUALgkus5noCMBULsdM6a3flnQgepzqgIm
	 Nf5g0/j0aRRkTKN1sdrJ8/VREgoqvx2ckWxziXGMNvlnVH+F5DB914IdGoYqt7fkonXU4FBwaMle
	 1YU6AZR3fpng+ABhmB1TcEd0UTTTXE+PymvnKX4vAjTECvd6ww1Xe9hRHnMEcF/MhHIIjoJ4GiSn
	 Cady/+i4CmeakJ0gMmvpK/0b02XF0bJfNIU5IcwSQJbuNeS2ksiZtLW35vfwFhi27Nf4vapddic3
	 7c4JuUAtEJFteul1T1Bit40MqUihg/JKGvf+D8ahhtjJTQt2mxlwOtE5VDbtG2laGYh/2w8OaC4N
	 Hm+zJbJuR529UQInC1aVdUCZ4zp26KL5QulSscURrc72MtEoeKZrAt8Nw+bBlB/ML5/jHi5UYDzp
	 uRZxEb3BX+GiW1O/gv6njz927vAriNHCihL84HaW74pnSXIb4Y6rMAakwrV5bNrDTq//kuCo7hsC
	 22AMz/d5YYKfnjLadRg+0krJhDxzx1JbzOnkEzIjpnBtku8o5EQ3bgnvoXvZ16c4+s/G+ngXsD4c
	 qD5opnOurJ8A6Buo7JnnlpONvntGwzHejB2iuHxlRAlArssrdJcFuaOZphhd3qKBQZWRCiWELkTV
	 bh/3TIQBg0kRQnUiyw59wKz4LdRmM0tbzNPRTpnc+e3DMOUpPeP8FITzYC0vKWYyc8RvvYbOuofB
	 8UbISZAGUTUj8ECWEB3uKUoasX7MbVZvEWBsh9w93GdVz60p98B5enWKo3C12vSRtU7Fs5fZk5
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+830d9e3fa61968246abd@syzkaller.appspotmail.com
Cc: johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH next] bluetooth/btintel: fix null ptr deref in btintel_read_version
Date: Thu, 18 Jan 2024 12:40:34 +0800
X-OQ-MSGID: <20240118044033.2908229-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000cde441060f230f4f@google.com>
References: <000000000000cde441060f230f4f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If hci_cmd_sync_complete() is triggered and skb is NULL, then hdev->req_skb is NULL,
which will cause this issue.

Reported-and-tested-by: syzbot+830d9e3fa61968246abd@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index cdc5c08824a0..e5b043d96207 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -435,7 +435,7 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 	struct sk_buff *skb;
 
 	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb)) {
+	if (IS_ERR_OR_NULL(skb)) {
 		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);
-- 
2.43.0


