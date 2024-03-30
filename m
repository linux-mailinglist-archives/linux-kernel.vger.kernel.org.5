Return-Path: <linux-kernel+bounces-125604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A72892985
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 06:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29242B21FA4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 05:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545698C04;
	Sat, 30 Mar 2024 05:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="v2bsJ3WX"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A778820
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 05:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711777997; cv=none; b=uXJo6LkA2rDYosi0s9eyoXJC1xO8de6I50PAE/AKEzpbAv3RY/u61bAHIOP+v+DBbd482/BDjy4Ge6xyYKxA/oDF+TyQSH9I/xZzf/dklGQ5sg+yl1kbc3nZ5HXhp6OGjakg0t1ylqJ8Xw11MUUZI1p0nQm0ltSXPxzf3Wh9U2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711777997; c=relaxed/simple;
	bh=az+3kN5iGihIcyQyOdKrdi/NjUoZI9GXUniqVpy4vaE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hVLcvypZkl8LFGgcQ2t2/kbpy+R2nEnp1/A/acSgL9n2MiTVdrhL4ueTWtDrTRC92Rf29nNfceAxgdkreSGFKuhBt6Jv0qn/6Ce72bXgZlpgDv+B2yJ3F5VreF+bYKhVEaRiDOX6mF4kZX86UWcrCuBYHXnQBpidHjdGnHEhDRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=v2bsJ3WX; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711777991; bh=qdTY6Ko7k/74y6NFxMJ3ypox/Ty3LMxTTEkEquK+GJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=v2bsJ3WXQ2IAPrpFo8HHn0uqhUup90BDHFEeTbpeNcHoiA4Jz91viNaKnt4HCn+be
	 4O4hAmtd76nsv90QAlUewsEOpnQUxIJ7EvRU09vvdsuEQg4gDXOadZ4f5gkc19i/Zs
	 b3TsRy6tYWm1JScIqPZS1iRUiGijV/cS/ty10uhE=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id D4A170A8; Sat, 30 Mar 2024 13:53:10 +0800
X-QQ-mid: xmsmtpt1711777990t4r98qeur
Message-ID: <tencent_BC992D4F930DA4A5930D8E92215DF05D8A07@qq.com>
X-QQ-XMAILINFO: OKKHiI6c9SH3spKhFCNqkmqxaaLSPzKGqqjxM22I5AaloE6ICfERdEhJ0nOZFE
	 XuqiGP1jFtte69VTGR6fDcJ0rFNjGnXviJ2I5T8uuS8BlXMJdk/X13WFrmlnWpOgd9ZnmSxmeMnH
	 kIzp7G2tR23xvN33BpEPhuUciV0RjPB5YFwiPNsJPzyVkHb4LtS9N7srId44VvyFeTz+HcLHIxXE
	 ak0y9mg7q34i/xazddlr34aDYNUAw3K3cFqHG7ISBPUba9ablf0yonYUCuoreonVHtxvGUQUlzIW
	 UT82Rci85b5xXZU/g2ZtKJ7TfBahY1R7aQHPRziyk+MgjHQwhb4ZtE+5HwitiZcEioVxsxecTXiA
	 MDAQlV0A6WORm2s7S4EspYI72FWD0cwE9JqhHkT/FcgHvT2bpBxN+Q3iVdOKOxnuegZhlQl2IL0Y
	 wx+/qAv9e5mms/HUsXpwrBFCUIK1kEam2uFZ5Y6B8TLC7G3seb82vBHrvXzxmBJ56JMZnOngCLrr
	 ri9CW6K7AmaCr+TAy/L82aL5AFXr+ZNMw+D2UdQOJd+pty4euxhC2JFpKH1dqHRH36QVmGL+CHEL
	 fmWoz+VI7+8Ovz8MzizzHYmqe2n5Vl1BQf/LBlKRGc7xJ6Wi607bb5usUNOIvWXvKGS9dWl0n1mN
	 myuiwMEWlSbWY6eQlSytB5KScwdj/O9EfDw1yPmkLUCpDPWSzpqqCu0XlusbRcGUQhsZFS6vBCYF
	 pIBH+Uq8VT+T9/fOQIseZP9R2TNEgQGm6reXEG7/8r0cw3QT3KYauDJoW9/+aiNqRD3PyWofFSDV
	 ZvTgRbX+ykOD4dxZkWz5kCmH+vSjwkUUiejB2JrykiXH3FR0nmVm/yU00+frK5xdyT92Yjxymv63
	 6wMHTfgg4HJ0n/rKGS+6D9hgOQevFIfxq6dNnx2fYxJe0uzAPiuHGDHl3HW2R5V3o4DQUf/RDr
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue
Date: Sat, 30 Mar 2024 13:53:10 +0800
X-OQ-MSGID: <20240330055309.4158214-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000069ee1a06149ff00c@google.com>
References: <00000000000069ee1a06149ff00c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test null ptr deref in dev_map_enqueue

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 443574b03387

diff --git a/net/core/filter.c b/net/core/filter.c
index 8adf95765cdd..721b85aebf58 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4381,6 +4381,10 @@ static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
 			err = dev_map_enqueue_multi(xdpf, dev, map,
 						    ri->flags & BPF_F_EXCLUDE_INGRESS);
 		} else {
+			if (unlikely(!fwd)) {
+				err = -EINVAL;
+				break;
+			}
 			err = dev_map_enqueue(fwd, xdpf, dev);
 		}
 		break;


