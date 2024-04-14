Return-Path: <linux-kernel+bounces-144079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0638A4191
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5D41C20E51
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D397123748;
	Sun, 14 Apr 2024 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pFLfq+Fc"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1CE17565
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713087837; cv=none; b=DaAgCybaeYLonn19C33iMTqLYckoyfXrKbWA/yiLZaqy7ZzS08DbjrWEf9aQK7XejBlJzfTHtXJBXAozXlvgS54Ka+pZR6HSi4ift85DMlkgNKYCA5fMwauNsW0e9mwjGAls9qcLWx1fOGYngIavDzPx36qiUSldLPwFUW4Gk9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713087837; c=relaxed/simple;
	bh=1YttCzjE6mOrF3+LP/4DSNa0r7I7TpydBBW2aaDUmpY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=bc6iIh8SfML841TRpX4G3PumStjvZzyqt5ZLeSekCjiLjZ4FepjHgYd0LxwkPdGeIje7oan9U2p+JDUgBKc8kMt4JGFw6lTFU6ZL3xi6kfxgxSQT+3OxurCZMlY4PsVRfaSlhtO1iK/T/P/iPDBGmWnO5yd1J0eFpiJr70DODYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pFLfq+Fc; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1713087830; bh=KM/2SxIvi3sdxAANb2LES0IEDaLLu1dAqWsSF6vtL10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pFLfq+Fc+NJm7rZcphjDJ4MMNfFZOwetAv3s+8LTng+k8+5vV0LC4oSRSAC38V82W
	 3rKbBIDb2vfTfhsA3dqeJ/3M+X91Ff//HwBjdZJ4CB7OD6GkddAJsFZf+aXWJVSfUT
	 7epUFDHXvU2kFmZwfiVWUsn6QrbzgVVQMQebuxGU=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc6-0.qq.com (NewEsmtp) with SMTP
	id 967088B1; Sun, 14 Apr 2024 17:37:39 +0800
X-QQ-mid: xmsmtpt1713087459t22cnunw2
Message-ID: <tencent_6C9ECE2079B26EC02F4D6CC095D8EA56ED0A@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/VlmtfTzmjpgst3Gs1GO3soK4zOJa5yWrtzS3BiaHdUzCR66Okx
	 vJk26kzJqJR0WX+5QNDMwLqlmoJUyrlWRN8jgNpNV3/+2WVDNCJPYEGmBPaqMjay+WcVAl+bxSON
	 I0hMrU3tyX4rf6LsXoQu7Tkw4ShiAIYikzZdNQ6bYWFIX93jsD85wPtptKTAR9J7gtyecJpURotw
	 1dLnT1b1VyGNQA/MRRV/UXfSuZooA5ruKtzkMbesi1enYX1zfORvp6BYeDGhzLgavtG04PiI+jfx
	 XyaYwcLOLhU2Yz6IULRw7xAXeJZNw9wmAArdmtPz7ZBKb/jv4fopt0hH3KMvsEA/Siroe7PXWaFg
	 1jhllSS0k49sbaEvIDhcd0/ofx34Q8Aq724WrLCEZDUFdOYoOgu/FA41sCYPQuvXOB1ZoUs3fXFk
	 QJEVIaELAeSot/awDK45KwRHlP3lZq33vg2HtxYN5ROuGUMZXoOa5TjJSrZm4/xv1BNNFeyB6k6O
	 39OkFpicMgL8dQEg5Dfo+w06M7bU7QXIV15Ki9Vc8Pz2Lr1+vplGZP9mWFSH6diMp0pRw/XQJuTe
	 80WMEdWRtMUHKBSZI6uQcFyEdv5RcTMB+BoPfviN7RElGc5RQ+CIqtOONevrfv3mh6jGMzBkWtDT
	 bXQ0krsrtgNRqECIFa8SsmMffeX8MQD2qnvofFEqcTn7b+RmnXccFEji9+f6VMklmyR3m1Qho/AU
	 2O4v7pMiugB92hvkUueRd96L9L8AQjjBonKKTAWrNcYqgQ667T9NzVhSt/JLV4oVxnFuPZM6XFtI
	 ToQvN0yRHjBkjZupEBM6BuyVuiD4JGzP+vkdP1zWPQGUZm6nfSeRRSAb+wlHQeIsoW2meAmDkade
	 14JYeQwTD7Mj3fCgzAkJ9gBDqaNlyGhuXHvabCsb9gxTdNbi9Y1bDdG2CKnourSFyvbx8SMfy0us
	 0dWu2NQ6xUm1JfugDFCg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d0f14b2d5a3d1587fbe7@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [pvrusb2?] KASAN: slab-use-after-free Read in pvr2_context_set_notify (2)
Date: Sun, 14 Apr 2024 17:37:40 +0800
X-OQ-MSGID: <20240414093739.3483705-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000bb465d061606e827@google.com>
References: <000000000000bb465d061606e827@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uaf in pvr2_context_set_notify

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-context.c b/drivers/media/usb/pvrusb2/pvrusb2-context.c
index 1764674de98b..e93bca93ce4c 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-context.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-context.c
@@ -267,9 +267,9 @@ static void pvr2_context_exit(struct pvr2_context *mp)
 void pvr2_context_disconnect(struct pvr2_context *mp)
 {
 	pvr2_hdw_disconnect(mp->hdw);
-	mp->disconnect_flag = !0;
 	if (!pvr2_context_shutok())
 		pvr2_context_notify(mp);
+	mp->disconnect_flag = !0;
 }
 
 


