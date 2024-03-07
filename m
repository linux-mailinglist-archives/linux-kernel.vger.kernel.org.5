Return-Path: <linux-kernel+bounces-95223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E253874AE1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC083287F4E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2899383A0B;
	Thu,  7 Mar 2024 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="sTJtoRut"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2BD83A14
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803887; cv=none; b=Ff4dkwP+pdmJ4IUsXOWWa1ZnqrEJWOjCsHd4s6NtLNOOMGmjy4hNFo+nD3gSBXjIc+36+40HzF1vlNvXTZlMADnF48idu1KPDVKu+xV23P5zXn1nVMn2OenRuUZ3heTTvm/OabCQDP+dapZFny6jBLKAQACX0HS841ducnRyPsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803887; c=relaxed/simple;
	bh=CYHiZKkDoPsJzfs65WAiQvs1WtzRsSvj65+4bNbaALQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=c/ccaXVOE5qbUN7iVdkzydIKonl9FyCjGUgRqJJje1v0f8+ZGmW7p485ufbmXJohDYQ9JgkyZRcnTmbYFtT2Uc4cVKbj6BDg8VkqpmupB6GANyxdaGMNQpWOIMdf42H3ST9J2Bvfubx0/7BE+Xj1J7wcWb/6a/57hZAcs12tuJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=sTJtoRut; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709803579; bh=rr/tMbcEktlPmy+7OAbx4X+bXXLxmest/fGA0BS7Zes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sTJtoRutQLgxvEeC3Bq5RtQdk2Cs7wKJg7WhF7WuxVRE7J01QKGs+M/okccGOi79z
	 mFQyb5jKCDOMj2liOaZ+KSjMZZeMSJnCdmKFdJj1W4sP+vVL41y53eki6n6VvSiGnD
	 Ez00ZraX7vjotsEi2PVl2Oe9a5tJyw9toxU2AJ1o=
Received: from pek-lxu-l1.wrs.com ([2408:8409:c90:315:7d1b:6e30:5639:5d6c])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 69107A41; Thu, 07 Mar 2024 17:26:17 +0800
X-QQ-mid: xmsmtpt1709803577t0cy356vf
Message-ID: <tencent_11DF52D0864289AB2EC56EE80C82E7EA0606@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQhx4bsLYeD9MBjvMm1UoM4n3alo0EHfscbFc7v12R8Z2U42hHT/
	 gjeV9TLr6T72cS//4xYR/EtOp9c2761ZeZuZHVR8zwPtPSVxSDHywL4vMB06z/YMYCTshVN2O8Xd
	 qw8comxCdgYLZ1YOnvO61Br0/I9j/ju4FPZwFKekG1NI1wzCuLP7JLmQ+D1YhY0Vttr2S03aIEME
	 b1okn3dXog/rsJn64Grkgck+/GSDBpX0RhlULllpjVQiSzZkoidkap/hkWY3wjT24bl7SY0YIhDE
	 8xyk5I4RXX6xI7n3I9TBGYLZ3+EYe/BZFSZoxoc2rwb3RF0fhU0dA46ICSn5RcqNaQ9DtTmJwgWD
	 goAkAU5kPRQsXX0oOcqPfUoh9mMbXwm7+673OuSK1m+3tKoSX6otIhh3eD8QBukCNEcMVc7f1lbg
	 3CN51bojOKBUbbrbCxfMyOt65p/XbBCVxfr8axZ4LQWIiWUoAaz70DABnkh3cY3NUudnf0mrxmof
	 C3/Ivz0xn4Sk1ZcaW2JfXDFQbwV73b1JVP0I9w3IcbmDM9VRDFpOwRP1tQD+z0JfcHAXp5gKj92A
	 vE11dxhZLJ6PjSaxCjcl6ospDY2yTs+hS11bZoN60r2AprJmHuTzACL30SfTbQelPbm1aXxRBq0Z
	 CB8k8YwiX+pmOrPS3uM3LunlXMsKeTarfEp9kPFUyNm9hjx2dJkD+iQNnnXgGLkjhCpzZ/m4bG1e
	 rUmcMf0SyrtpOe/+am6seSvvvgIyAAZEckqTceLctGHEmn3wcLjQMpIYSQ4A+KFYZgIyf/kH5mp4
	 JhKD3gTaaN38l6XIziGFZ/5VGI+VgzBipdsUiS6butIPLTUK6yxhQEhC99JYpud0eEEz9jvLLBNb
	 FUnnbSkaaS/nV04in87ramuZoMzmiKmu9W9c0fQty60B8ncLq9wFJUfazWA3Qyj0mM9tNnVaZc
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in team_port_change_check (2)
Date: Thu,  7 Mar 2024 17:26:17 +0800
X-OQ-MSGID: <20240307092616.940471-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000004af86e0612f195c7@google.com>
References: <0000000000004af86e0612f195c7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test dl in team_port_change_check

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index f575f225d417..ecce44b16e4f 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1212,7 +1212,9 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		goto err_port_enter;
 	}
 
+	mutex_unlock(&team->lock);
 	err = dev_open(port_dev, extack);
+	mutex_lock(&team->lock);
 	if (err) {
 		netdev_dbg(dev, "Device %s opening failed\n",
 			   portname);


