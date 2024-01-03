Return-Path: <linux-kernel+bounces-15460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBF7822C48
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B801C2309E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E76918EAA;
	Wed,  3 Jan 2024 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fMf0TWUK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F6918EA0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704281627; bh=2MNHxC3wITYem7LyRgLeAtKDXtj29s2JCw6FJPu2I/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fMf0TWUKJ7SPXQzJ8qvLAgTRY2BCQdBUJhOs0EqYDTvnaRhGTeQhSS7gCZGQdETUf
	 Jb5z4h2pf89cYg40pa+SwY0/MG7Dybm6v9XYHmWJH5rqq91/rTKak2TXGPs6mDwnjA
	 ELq8GUBOVPIkWa3aMrGuaPSMTwlpTHAtSSaYXnMo=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 86D9E2D6; Wed, 03 Jan 2024 19:33:45 +0800
X-QQ-mid: xmsmtpt1704281625t5ua0h9wy
Message-ID: <tencent_F3421B852547BA53BB2433EE9E461BBF4B08@qq.com>
X-QQ-XMAILINFO: N3l5ASPewLWqvQawp6YWevlEnPGkig8ccBv3AnSl0jMEpaeVUQ50gXhws9yBeU
	 W8RM21envX3RdHZTL/N+vPieTm60QzJuS/02ul//nQvATQ2T36ypYHT995KiwZFS2r3XmpJqm6wd
	 irUy1LlB1mtks+IFXdzuO4QHnfFPhgx967FCOJnGtTL4qWsXv05pi7uialv3yGnz9oJ23NWTYoeZ
	 W7dTMA+fLxI7se3OMTAzWN08mDarnlyU753r4k/DEqquFYqriK3Z3E5JE34kJh43ck2ER1cgg3Ur
	 PZnmVJW7yxGO7t+Iaz6z3tcZO9zQfCBb2taNyYWSeCnb2r+P+OMX+OM0D6l1hv9JGdrOS6YXUanL
	 PAPERHiZvNWEG9LJl1ZdHySO5treEpR/sx+mpjhLe30kTQqmP7OLQNGaN7OeRAxeGBzPENBMNjZp
	 /1VLIuNdouSVm9DgEixpNwBJMjm/p0CT46KhIhc+kuWBz5amaYmKmuqmjOHtGrTlA3WmHQXdlEph
	 6Pr+rTcjoGjQKoClZOf7juS9wGFvZe3rYYw6pHXIiYNumwym+h9AsV6IMCYfA+cVNrMuMZ7UJzQn
	 U98SXG9CHTyJS4XqssOzoVhopANLhwE3DPGdkbu1FhnmRtd1USDeAw6tdJ5xrKiU3MemIcT/zihv
	 gIilsT2Wy/SLWIOva/nR3rsHAtq/HS52pyQc6CcOPv4aDqTpE3Fs1nMIQCPFS7ojhA1GNtTEuuvj
	 hLChMMTK0gkzRQOnGFNlgIJpqePXBpy1EYBm42e6TIQH0rMHElNfD0g4TG3npet1/oVGChGLLqNL
	 gYXsttaMQKUSErj5U77cfAwgsOozcZU/wGDbK4G5KCnVkUvpPNkdX1daZt+F4vfTDbcc3dzXVF4Q
	 Vu/oc8kVoOTkH7y/PV7fU+LqrpoeJq2ThqqhuN7ush5EVLN9lZY6YG86S43zIg/A==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+864a269c27ee06b58374@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] WARNING: suspicious RCU usage in __cfg80211_bss_update
Date: Wed,  3 Jan 2024 19:33:46 +0800
X-OQ-MSGID: <20240103113345.2687039-2-eadavis@qq.com>
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

please test WARNING: suspicious RCU usage in __cfg80211_bss_update

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git 954fb2d2d49f

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index cf2131671eb6..7cb8ae87c369 100644
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


