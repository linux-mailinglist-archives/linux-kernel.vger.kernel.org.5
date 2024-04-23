Return-Path: <linux-kernel+bounces-154950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B111C8AE374
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EDB31F22638
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4867BB19;
	Tue, 23 Apr 2024 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="nfHFRdtJ"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5FA76048;
	Tue, 23 Apr 2024 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870547; cv=none; b=L2Ft3LIV0EgVScp9SVUomvdcPoll2AxGyMtfcPeDfVEhI/4Fhp/qTISFfvwOFPJFxZwdM3E2snkn4e/x4TcoR2z/zFcJ5/wqQvq5ZRjZc5kX/dJd7L39Pm8/6AT3mtcNtBr2kMZSpfYI40R4DzLhfqovMKgQ5njBRNoUjzChAKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870547; c=relaxed/simple;
	bh=LfagOb0pRvs+Yqv+NkD/D22iemaPJwNTcBbHuXvf4k8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=FTgR9GueejXSJ712INkWguzjiENgwCJdnd97kYWXGkMkm4XbeCWM/7rdt2JdmP5SqsF65php8/3TD2fsH6StVNgy403ocku2OvULmFyM5IKcfQcqjjFJMLBvwgBDrodjuJozDw6VjoaikivqpwJjfb/9124yWs+P173dt8xIBsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=nfHFRdtJ; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1713870233; bh=/w5cKHDs6QXVwx078jjgBY94FORPbibvpuN7BzjxfHo=;
	h=From:To:Cc:Subject:Date;
	b=nfHFRdtJIDZZysAEwxArx8CdIdOlxrrmpz1oQUIXa663cYBEn3NcnFna6CMAxT/6X
	 B7x49Dloxp5tYxw4V1yZS4dRrHVBij57zqxq6BrBCi6EuQsNPtmScsrtF5TgYOfstw
	 tx4iIqRuDwFQjY0G5LJEyvCe9DvUsP4D5zsvekWU=
Received: from localhost.localdomain ([58.213.8.145])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id D5F99E4A; Tue, 23 Apr 2024 18:53:31 +0800
X-QQ-mid: xmsmtpt1713869611tckeqekqp
Message-ID: <tencent_616D84217798828E5D1021857C528B713406@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjxGKrQADUKsNLsZYDLsH2pHwDVVd/MVCsWEdnuuflZeC7gLw1qk
	 bh1E8dear7oI7v3YY95BAz0ITzjU+ytVfSNrFpVo09c8KyR1wxu6L+00AK24qauoVnxdmC3SEphz
	 ssYhtuW82bzVRyFy6Wkd/qkqeQJVXwx54roBdDIG1CxSVSMFnRmhdcxxeqYvOzBJD8WM65w5bEgx
	 TfbkF72SjJsR/CQYhO8VHnGuch0c0WX3jyVFx5gVJR1Hlp1lBJJpsipJh+WFyFQNj6zilqU0LiAc
	 Ya47AVX6l6B85is1Vu7A7Ga9WHoEh2D3XAJUGh3y7H6PdM1o1y9Ai1MdHwep9nV8+g5qKJzPWmUg
	 KuGXepA2eXIydEHj5PuU0/Ify+yzGLfH/VKsWFmKL/FxgKHIS0nSTJVmjfXb1KNWHBSTdDB1UnCv
	 8DtFwkGSdXG5WPnJCrjRho21RkeRyFuH7l9VddJDz+Ua41wjIXgKxmXHbkRK8h86bbWxTIz4sjlF
	 1D+ig5Cs6lfNdMJmyWgqX/mI2gjtxr/XI0/7/dcnurW0ksOJuAocwdAO8avU7RQETk62EatJtsBX
	 Y6uzQoaWa1fDWUaGvq4oZS8JMRMUsOy3gRkX1MtkNG5wK0zNibjznQkBRafeZW71UP1Hh9jZ6NBa
	 CkVOLR5qgd0hqq038rSUof3IaItQHPmwN6pGqYkzUgPugER0+rx0LQPlLo2qt+6NCivU2F36ZtTO
	 TyOjsud+Bpqqw9NT5mHcRubbU9sEP3yZD8x0psLXqJ1VI2JqGSIpM1GtNbLTcgPM9ZSCgQYViTa2
	 vl1uKfccz13JKq1BxZX/cJ1gIRVTBq0/YgCTFglc9m6LY/EFfHZht7yH37VbpKmgcyO0p/fgLVGa
	 PgSFmXNkcT3cQQ2JPMMgeWI5EgOwsDYnPbQuXBMV6KXAin2qjaDFsi/JCWCkNR49xP6KYKfaowzI
	 kKo9rKmVkY6rBIber1gVOTpf48EmszZbeN2u6KXZSc0Q/6SeiVZgu0oYM/LO4lpLgA6SpNTPdrCt
	 vc8GfBMg==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: linke li <lilinke99@qq.com>
To: 
Cc: xujianhao01@gmail.com,
	linke li <lilinke99@qq.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: bridge: remove redundant check of f->dst
Date: Tue, 23 Apr 2024 18:53:26 +0800
X-OQ-MSGID: <20240423105327.77484-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In br_fill_forward_path(), f->dst is checked not to be NULL, then
immediately read using READ_ONCE and checked again. The first check is
useless, so this patch aims to remove the redundant check of f->dst.

Signed-off-by: linke li <lilinke99@qq.com>
---
 net/bridge/br_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 65cee0ad3c1b..ae33b30ff87c 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -405,7 +405,7 @@ static int br_fill_forward_path(struct net_device_path_ctx *ctx,
 	br_vlan_fill_forward_path_pvid(br, ctx, path);
 
 	f = br_fdb_find_rcu(br, ctx->daddr, path->bridge.vlan_id);
-	if (!f || !f->dst)
+	if (!f)
 		return -1;
 
 	dst = READ_ONCE(f->dst);
-- 
2.39.3 (Apple Git-146)


