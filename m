Return-Path: <linux-kernel+bounces-109552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B84E881AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3557E282F72
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1E31C17;
	Thu, 21 Mar 2024 01:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="meMuQzjL"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90339AD32
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710985858; cv=none; b=bRcxFtQZVZrJaHxrv5cJswk84Be+2BRuRAK13EBqp4ObpcpVHVFQUaGZ0e7/R/4P/XexxosUuRKSVK7rqJcFxAh4Gd5qI3sdZt5LaN2cpAK3cvsD85pLe4ECTLVnOvxv23+VMH0GAZe4wzxnH/luH2x6UxTKBPXBH9hf/m3lkGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710985858; c=relaxed/simple;
	bh=/sHlsPSnOZc0LfxrgrKONDIB2LMzGmk216AHR8Om51Y=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=HM3cYfR1qh+AYdFRRulsfLHWE2lUpC1Gm/DFhwvuVf2NFjogF6nIUTzAtAG7nWiJkXqGHAr6u7q/JNQqYR5JURQb/BVjB35m3ajpp2qvZkC9kUTMVfK7pJOZUBG9iBaqREbB0l/qVgP3udqv33clbzQhWeuEs0pzCgjSKrPSxLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=meMuQzjL; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710985554; bh=YDTkjNP0OTljJ09a+6XSTbShy94/N4fLanURXVYYMss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=meMuQzjLfNCyUcP9QlVXXAHvY2HApDUn4W7kNnCOuViDtvGwCIIZSrw4rGExpnRzH
	 1fGWLM14tPRLQhvb8ZYr5/JwgSK2s/M/Mxfi248uA4JmnVf4R1Mi7vj1Ev8HkQMpsw
	 dw6wCSdJu5wmT+XW/EXrEzDDnaJQgRgr8mFBIvWw=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 9E9018E3; Thu, 21 Mar 2024 09:39:41 +0800
X-QQ-mid: xmsmtpt1710985181t4b31hzpn
Message-ID: <tencent_38BA83BB7233789ED71B8B4B181BD325F208@qq.com>
X-QQ-XMAILINFO: NSTsyPg8kQQYTg96rLLlKoXINR2DVOWpQE8H77w3aZgka0iELJVy05LsYD/H10
	 CcriQ7mUMCkoDBuZBNEsvmNcNF0yuN4BqkXW8yzPsfAtRDvLXTVtqeMyCw9mexH9NchXCrE4DB3R
	 HHq7ZbhrmEfUB0QV6C6Bb74Uin/eCVQtF0Dq42g41au1jXhsOLoIuKvZx2PijBvud20hBmPd8UC8
	 myB/ymIrDkFt1xqc86IdBnzmxueRqAaFBiXGQIRIVDhcYOuT70noLtkrwJzi/nQruaa4+gWdLVW+
	 M3FPmD4ORCKG3T9IyqmtrM5HBl5dciYP5TCUUGMfgeTsElWZp0NZoSavt/+ai1u7oExtDuqvr9ct
	 hncit6t8DVNmclU5oDYSk0yonwOIJa8aQULHc78VWAtPLdMv6jpQNV/bggnOxSuPKdzTh2HQ4gnc
	 uYTcHvxdhh/7x9th+w8V+6YK86naofTtPeqA6kNJLDZDKi08ove70LFwIYkKZ6fuO6a5rZvhntyr
	 VVMmuKuUZf9e9Y1NhiJu/8lGLGcOucd5CxnkVxVdVK4kUsz+CZKEYGuqqQOnEsHKQj8pqYP3z+Yv
	 8GcBtgJJutvryRoJGZmuT56eDqizeKzhLkHkpWa3WS84S492mlvCyT5vU4YOc4p+eKXGmn0iqG8l
	 GHj362UsqETGroPFxZXqYfgoRe0HnYcb2fo+DoeQVhLsw/c1g/KiGGWEhFahQywRcPymwXPCKTRE
	 0bqwLIxp1wX0MYoN/1Opd5qxes22QuCC4wgg6pr/+cd8vy2DobH6VAvZjMp2m0u+kUANUr8+CNDg
	 KkUvLzuaupRqXRGOMcgU9S+AOyo68k43PAcpsT29hE6M9kAzAOmakxPPoXwzIDg8SsmfBNWq2qsz
	 pkJjLTZlIZZeYwxBo024yGKabADKf8GmyKS6myDqvoCWSdEvPO2Y9Bm8qJF6ePe+oIajQCT/Z4gT
	 YpNIcpSNokZrDdVxc8O2x9KL0FnS9oWiGBx3gDmO9hiVvMFqwTH1rXFbNiczyhDBS70+yVZWHklh
	 pWPbhPyaH4ZCiXU4Mk
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] [usb?] UBSAN: array-index-out-of-bounds in htc_issue_send
Date: Thu, 21 Mar 2024 09:39:41 +0800
X-OQ-MSGID: <20240321013940.1784691-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000004e41110614187d35@google.com>
References: <0000000000004e41110614187d35@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test oob in htc_issue_send

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing

diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index 805ad31edba2..5d531aacedbc 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -275,6 +275,7 @@ int ath9k_wmi_connect(struct htc_target *htc, struct wmi *wmi,
 	connect.service_id = WMI_CONTROL_SVC;
 
 	ret = htc_connect_service(htc, &connect, &wmi->ctrl_epid);
+	printk("ret: %d, wmi: %p, epid: %d, %s\n", ret, wmi, wmi->ctrl_epid, __func__);
 	if (ret)
 		return ret;
 
@@ -304,6 +305,9 @@ static int ath9k_wmi_cmd_issue(struct wmi *wmi,
 	wmi->last_seq_id = wmi->tx_seq_id;
 	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
+	printk("wmi: %p, epid: %d, %s\n", wmi, wmi->ctrl_epid, __func__);
+	if (wmi->ctrl_epid < 0 || wmi->ctrl_epid > ENDPOINT_MAX)
+		return -EINVAL;
 	return htc_send_epid(wmi->htc, skb, wmi->ctrl_epid);
 }
 


