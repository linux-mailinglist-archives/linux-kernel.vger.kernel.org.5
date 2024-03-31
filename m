Return-Path: <linux-kernel+bounces-125971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1245892EC0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 08:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03C51C20CB5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 06:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7EE79E1;
	Sun, 31 Mar 2024 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="dVcg7It3"
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053B763D5
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711867157; cv=none; b=Ch+geARt3RViVOawENw+WPGMGWnP0F6GC+Ypf6cgZbKuBeqLr8LeHsIoWGN3U8XElTCPnjSUgngmx6WD9koNJKxU8T5WBTdBUqeiBVMFItp2x3tQKw5dysrYd68RBBv0f60S2YgLuOlFQvxTz+BHM10LXo9RV/8oVjtfsoqEUF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711867157; c=relaxed/simple;
	bh=Ey555EEMs+1h+vBqhpfc5i5h9p+fEvPpnhL0KIaD+UM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=kasRnKQVb3eQD6lP0Z8DVwgQ5bGOiYPBk2O6EaLHZvU3GWRGsDtD5XpTli7iq9HY0BEyjeS/ahSefxy4P8am00vCvsKtVvYW24IAew13AcojjdcZbJ3gHzjpf66qK7l7DqLd8SuuAl6ZGCTCntMpANa+FVYzng/pRH1pHpNw+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=dVcg7It3; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711867144; bh=i7zPn4R9WxtVHSlD3ywJZJfLTSCZtrFE4P8zGgaB7LU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dVcg7It3OiwMmOnJiDDcGdKh11OiU2YCl93zJk2e/z+Cnxzr6xX+Mj0KySvUiP1jX
	 TbJD31iUOMeKhQ3S3y06n7+oYGgkw+vsjPCufeKs0Mixtuf2hOQs4poVAQZWF6QImE
	 q9/JVAd4tKKMgZA/YgTjDu33yVK5fzxjulYSRqOA=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 9C31D2B9; Sun, 31 Mar 2024 14:39:03 +0800
X-QQ-mid: xmsmtpt1711867143tegvgdelq
Message-ID: <tencent_C2874B621B52254CBA78BB3A336C9E3C1B08@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCIsCnlOnwJTTT2cevX7vA2YTMRy2L75DpI5uKlVBQNTRvJi2fpg
	 wTSkYn6W1Lq1T07TOy2xSGxrRAiqupgvzWQpSOudcYzuKgDaLcG6F5PRQulTACrxy2f6aT5JVlhy
	 qCH5sgG5Npf8pXvn0bzU02YA+LFTbBbu0CjOhUw6LrAYirvUmnIn3uLuKpM6Kib+F0a7VUBWxv85
	 DjHgv6DugnYpevEOX1jS2T9F+PhKdyaZgeYdFLpJnzmeRayC3TAGPzB6A39mufZUpQIdoFZyeILI
	 9npwtbeWpLz2pBorS31NLR3t6/6PWy1c2ni0zzKXpoeb4FQwZqF/k7TitginePAhTZXCvRl+7b0k
	 2/PMeESHwXlC2OOuWY0heO9Cq+OVM0VcBarzR12cPHR4ZD2ernw2kpsCBqWfxL077n/1XmLtPBM0
	 /Lz5nBdEKtV7PropsDWZ4gVSLMPdM295SULq4rf+ooSSUb/ymnO3UIG1O7ygXrW7HF3EJRibGQP/
	 WKCxQ+9vHlQVfO8/9zvjErgijEK3DfpHK8vViKL4jPWZOczBFLgDFmugk93sTV7ipMrKYCQorLxO
	 KiEZOOoiuoPmSWaHm+c0mw5ZW7+RRhm2frCXF/vp75gKdd+SCPxTi9O7Vz50Id1c7afcXkIysm+S
	 YLMRiThASoaA1dkvlnSDlcJDKSjqEZ8nXm39QCh9AWYzpPZq2CBF3DVlkUVoII0EB8xMXyZaSqBD
	 drEiERLOZWxwzSGpR7ChLv8eghx4LywK/kchEN787d24C9y69df4GGjCzw5q4uf55jRGMdtETGDY
	 Nav8vwQwkVR0BH3BEbzcxJm2g1VXPhHW/iCISTmAVT/YNm76CQkaVJDwxL3YXA0s1EOeTF/X4meq
	 /XjoK00BIP1Qtlb2Vz5+sbAws/7oUpmPQ/1EHhkLeKV3xZJ1JX/CZUqjk9dPpiRkMkfsdZF32m
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in p9_client_rpc (2)
Date: Sun, 31 Mar 2024 14:39:03 +0800
X-OQ-MSGID: <20240331063902.1017892-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000a77e580614ded85a@google.com>
References: <000000000000a77e580614ded85a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uv p9_client_rpc

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/net/9p/client.c b/net/9p/client.c
index e265a0ca6bdd..cb5cbb150dcd 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -977,7 +977,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	struct p9_client *clnt;
 	char *client_id;
 
-	clnt = kmalloc(sizeof(*clnt), GFP_KERNEL);
+	clnt = kzalloc(sizeof(*clnt), GFP_KERNEL);
 	if (!clnt)
 		return ERR_PTR(-ENOMEM);
 


