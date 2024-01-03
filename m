Return-Path: <linux-kernel+bounces-15504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BF2822CDA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167F1282EC8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420851946C;
	Wed,  3 Jan 2024 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="oX6ZihZ4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A3F18ECD;
	Wed,  3 Jan 2024 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704284404; bh=hsWvIYTjGOuzkSHY0cRhuMQ9nYrh1dhhCxx/OjJphEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oX6ZihZ4T4XuarlFE0ha55Wc7LoMXc83phzHQ1CcTHsNY2ZvCq79l+NkrA73F6/XO
	 Y9pjC507eoK0hUylolKltPJoNMvjIctpewNlZDzxRjQ6yWzzg4LdCc7GAxdlYZrfT2
	 X9ZqaaAWCib0Uu2IjJFUitl4dOUm/U1NIxDZsPiE=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 3721BE1A; Wed, 03 Jan 2024 20:13:50 +0800
X-QQ-mid: xmsmtpt1704284030t5lk8klny
Message-ID: <tencent_BF8F0DF0258C8DBF124CDDE4DD8D992DCF07@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQx1ZWRYQcqrrru8adTGjx2DK1zZieGMM5Y/1cc8/R+Ey5dg6t3b
	 gz93V4CrPQDU+BFuJzi3BlheLDoS5kXDJ51uNlcEUX5iGsPdruRlZwXhieqrjGDf6Gg/Dbnuv4OF
	 vgihRqlzDkquI9+ef1p+WCDI12EF634TMfKkWQbw3nzkseFvplzB2uctkUTD0xnmCqrehHPIeG5k
	 0JDJ/rS655z+U3JUZUEmzTfMDsdAa4tOwp8yLXO8Y4zqUNXwbrGFCPfoYrvuRxdllOf1tB/h7tBP
	 vk1H05stOWsAFPMar1bLL1LZRuNZzu3eMORR8vzJsU/iCmz3ZSJr8YkLawH6cxZrI4EmLs7+xkgV
	 IquvIwjLDyi7hKFpDXqBb1cCzNHzUNHNVPdxnmnVHf53S41t0I16aAXzVKL1bJovnUB4BD7t+QWA
	 TOQ9K3OHVXDwsELv22PSv2Dov5IP9PHU9Uj9rsIikv34IqTAYl5Hg9lvdBTdAn+7CS/6Hf1UPq2K
	 vayA+0WyzvOUySvq0QxsyIPxeZ1gUtOpSW8JXBYLzGqOYcOGj1mPmQ6Oua1EH8c4JSlc1M1+CiAO
	 +V3u+W3E1vgv1o8kKG45HG46A1S4wu0JF4i4e8qUSGYaP4677BL3cZ1KANKiWJB076GUwog6c/fU
	 WbqsZDuoebMfU/5iwuguhcW/ED+3d7BujXalYnJaMO2tnjEjqNtcXvjTd1+DGxSi2a7Rhx3Q/pwR
	 wXNWnzboVOkELgL6oJCePZ8eajmYLwRVEtYkGPYQnVbfmxZYFuqMLMOO7QLnPd+FJqHsnICMQgAC
	 mG70DP2IrSK1KdtMnWwa5zze18Wnt8R9UiG7864zddXfDEQsAXpM3l0+EjqHne7skv5HtJo+XFJt
	 qUmAaBqfLXBn9WlAAwbcu6/gpOwErsnP1UaBqGnicQa+hyCXoM0tQqj9+R8eRse7ANkb/cuSa7
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+864a269c27ee06b58374@syzkaller.appspotmail.com
Cc: benjamin.berg@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	johannes.berg@intel.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	miriam.rachel.korenblit@intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH net-next] wifi: fix warning in __cfg80211_bss_update
Date: Wed,  3 Jan 2024 20:13:51 +0800
X-OQ-MSGID: <20240103121350.2734479-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000009fa770060e089409@google.com>
References: <0000000000009fa770060e089409@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace rcu_dereference() with rcu_access_pointer() to avoid warnings. 

Fixes: 32af9a9e1069 ("wifi: cfg80211: free beacon_ies when overridden from hidden BSS")
Reported-and-tested-by: syzbot+864a269c27ee06b58374@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/wireless/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index cf2131671..7cb8ae87c 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1864,7 +1864,7 @@ __cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 					 &hidden->hidden_list);
 				hidden->refcount++;
 
-				ies = (void *)rcu_dereference(new->pub.beacon_ies);
+				ies = (void *)rcu_access_pointer(new->pub.beacon_ies);
 				rcu_assign_pointer(new->pub.beacon_ies,
 						   hidden->pub.beacon_ies);
 				if (ies)
-- 
2.43.0


