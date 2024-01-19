Return-Path: <linux-kernel+bounces-31180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B084832A2D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF7F1C209CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A206524AC;
	Fri, 19 Jan 2024 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hBKAVmmY"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3614BABE
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670153; cv=none; b=AsPbli3KJ2SiFieu13dGLWPUYqTghXcAOC6d7QX022m9xiysVWGRx7QpD6eEO2APWkWw+meioYZ5pgMlJ5qkvmKQ/fcq60XfCOOhTEH7XRu1+6rvoH2m1OijakoC3/ltby3A1tTVGejB7/krs2jcv8A0QAUb7TJKZIsoQ/BIMCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670153; c=relaxed/simple;
	bh=mQu7VFU9CxPqyz6wCupXIRHUakQGJVV4lMuxaSWZRms=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=O65eW1IObbmUcAuWHiUTo0m80rxBNmvi3spq3JtYN4zjutjYHPQ68bng1UM/3qpjdp4k9jgoeA06tKa6FHC7Xcd008dkFZu2364kIkXSipP5X6GPTwc1RiOCB3fBvcUjqceyftC6Ge2fSMCTKfNQfSj8qF2vbg9+Gk4lZPXa8vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hBKAVmmY; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705669841; bh=Qf6O6gZtpKNKA3Z/+/mENSUoHv6lfarprGF7mIZk6JY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hBKAVmmYtUljJrODw/V5NV0tBaHvdvPvVq/o4GkszBj7n2XXAqkb7SR36nVEzDNUZ
	 A3ukDMI4+mZJwAxKG3eDhaYA9hq3s4ckKEvIg63WJjM6hrAkdMfM9lt7N5ktaWYa1J
	 xPWIQ63MdDwrgP0x7z7sWjdLnFSOqbRfcWs/uVcE=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 2A78DEBD; Fri, 19 Jan 2024 21:10:39 +0800
X-QQ-mid: xmsmtpt1705669839t5ja6sp2c
Message-ID: <tencent_A4341BF325BBBA35BBFA336B9E701B144B08@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/OQ2aS0u1J2T2zjGZvI780kJo4h2jfiqHPa0ZTW4qpZNFWBDEEX
	 WAuEIf7xvWoxp/wJz5/RwEBtoei8Fp091DWpFsGVBQql0MDsejb8korljqZ5kLy1bvmrsVrd/wnF
	 hx+GCXD+WaNc6SAL0itlpEAUTuInS9j5+5S/ENiChcNWSi6zUPwBzUW1Z6Ft29W2GarWLi0IGsWh
	 dbff1BG6LfcHuAMujzjkIYju3L+ndkwnGdveWG49EXgUbMHBagC8aLl6anmlQoEUgk6232MVK5KC
	 YBVlLMmB/OmadRKfwOkUqOGowaoCLj34j5OrgJOAGyTuGa5pkMQpdhH03mEU7J7DrTbgLnsyo6IE
	 pSDM9clVeKucKhqYqLWzu9jHN0N8TFFA/B52gkIpzZK5ZSfonlAXeH2ZJJRni+7suywYSn39XEKr
	 MG3W5CVnKdMkh8v4m6Tj2ddGac/jQTXadCmaxEpJ5HF+tTTtuJF/w/b7hahb/gJlQF81BAx5G1Tz
	 om/NE1sB1vyf9N0ECByf3+rzumy0np7Os5F47rlMMAindLU1d7H4LHyX7/RR64b0WD1/vUhVTUeN
	 lFz4214ErzzJyy371FWqp4ompJjW/JNmnRYI9GBPU69yYAb4NuVXaUgI+ux/YnYUM2gA78XBx/zv
	 PaWB5WYscVQ98Mis/FZa/lVIJB4Sp69WHsNiXDI7KM7qZh1qYyjZvs5CJ+BhJKIT6VtGm+qdC6Rq
	 8TNvkVtJT/yJtaW4H+AjI/HUWIWwKbrwd6yYFICTvmVekpPUkNrYwM2xcZp4JXEFpo0Mf0Lk8VFO
	 YvQWgwSvbi6/4e4xuNSjSTmlqBm91eGcMmjKNco1EvZf8PmPsZwX9UkStkiXNXCxiM4ucyj/JasB
	 EdkUbULdZD+j/Ysp9mYcUngT6onb0EJfcB0uz/QlAiF0eJsSDNiPm1K8tz3quxKQ+S4vgkH9wW9v
	 ZsIRrqiFkwjW616AzfMjRaXaTR2tF7cp+N+nbzRYlZ3XCTrd3ePA==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+fd404f6b03a58e8bc403@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [exfat?] kernel BUG in iov_iter_revert
Date: Fri, 19 Jan 2024 21:10:40 +0800
X-OQ-MSGID: <20240119131039.899367-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000007728e060f127eaf@google.com>
References: <00000000000007728e060f127eaf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test kernel BUG in iov_iter_revert

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 522edcbb2ce4..af8870145f67 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -534,7 +534,8 @@ static ssize_t exfat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		size = pos + ret;
 
 	/* zero the unwritten part in the partially written block */
-	if (rw == READ && pos < ei->valid_size && ei->valid_size < size) {
+	if (ret == -EIOCBQUEUED && rw == READ && pos < ei->valid_size && 
+			ei->valid_size < size) {
 		iov_iter_revert(iter, size - ei->valid_size);
 		iov_iter_zero(size - ei->valid_size, iter);
 	}


