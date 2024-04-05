Return-Path: <linux-kernel+bounces-132738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9B4899976
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6586EB217F9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032A415FD17;
	Fri,  5 Apr 2024 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="D/ufva2J"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA0615FCE2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309454; cv=none; b=PdLt9dqm1MzOMlcorwKmTuc+63Eu8uamMBJPlMbCcxgm2XCj/slGAR0N/EubE6rrqRaaIEj4J8sqTw8ksB99E9MqoSM8eW1Ze7zd3BfIMQ30SfEzfk9oleF9OrOlxLVqlb/wqOrDf21/B9x3iGhpeGd/3wcFOXvdJNZ2afOLGfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309454; c=relaxed/simple;
	bh=ZjqWxZw0CpXAMF92F46qs89BsptssQuf3V8Ss6R76y4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=lmWDz00KBCHAP5hFh4NPJQ/OJsHOp6JW4vrjlwCKfnA7Rviw/NbWRhWIFaksKEamwU+jBVpHn8Le2GhiD2/8gvYoqm8Y7lJG1VF31hfOZ5S6RW4OFk6PdUET7lFDJgl5MMy4rjZ+v6gujJFxUKhWVEpjjrb540pzhwFFHXTcrxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=D/ufva2J; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712309447; bh=ByF400UQhr8ehKCqeLooARmm/A8Q6UaeBuIDAMycFTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D/ufva2JAUKGc0lpOVmFwsias7wuknIu9RHdICnGKeKbuperR9aQo2Yy/2gQ+UXf9
	 X35Iq/BrW2QgSQMgzraH3trk5JECCkyOLYm7M1gTegdIK+a5rohk5bmCA6QhHkZurO
	 A01HgZmM2LzuCk/V1zYkEkg1u3/5IgXRQnR0TnTs=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 7AE114C6; Fri, 05 Apr 2024 17:30:46 +0800
X-QQ-mid: xmsmtpt1712309446td1n5rfli
Message-ID: <tencent_53918DA792625DBADD92991DCFD98DDF2507@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uT6SfvEicVD2L0azpIUZsry5UZlZ/RieIYOCWufmbvfBoj3qo0pF
	 R4JEHDx4TohK6Rn1CFs+i8hWfV6gY7azQT+PTT/HJ56WKvfbYJpeWwNFEqMNflL2Aa2TQ4DjMUA5
	 k8fjry3WBHuVo6FPenVaXnidy7g/Q1mGl0KSHJjE6GQC61A2hQZMsQbAvpT1I+GdCDHD/FCXWQRe
	 Ha4uAiP3OAPGEwNM9P9fiHhb8KPh+PHBB8cAYLw655RG3Y7xdjhs7eihaGv3GH7DdLRvx+WZhqMY
	 m4yOpxLTkjjlGXjrYqh/oDzNTu4tLlQMkY3tJtPqgqw13OAH6w9k4QZVPM/FRGASnWdxLDrPHmSM
	 tgZbmWhtS6aP/je+0va+8YGhQ61HYMmLtzZj8vSAJdF7LlCnb3xkaVQasdR99r29Irs3HI4mGENL
	 SZPH8y1nU0Fm06sl2R3hZdDpCgV+daV8vAm8j7i7c9IySTwxGVnkwwe2/DccVQwU1e+HCL+kqn9I
	 jsPP/65jg66uIIK+WahvVjEC6kZN0NyeXQHoSZgj7j8/IrpudUyPgTsEEz8SNBKTnf53zaA0OO3E
	 znBtsB0kgTb8S/M8jBt28IvgPVYmmY3eh4Kc99/WopFkNVMjAc9hyGEj9p2Sd+DNNBlHaKsNsU8k
	 9e6uDWSiDXf5AywiIuDGSt4+bwcZ+zmzf2J6Mt7aK8SkxHqqcgyFsK3r/LXfEzFs07R5HMgJcVwx
	 yc/ZoBkEHNBC2FoF6H/R7vy9+XZtnbiAKxRlMoLnFRKc4XE1AX2v1Qew6Mz0V6iAvXM0fC+sEZeH
	 cMvcO86zcMv8RgEeLrWBhIoK7dRuoNOVfr6NmdUQbNDAN6TvHee/gqV7zTnBYMqZ3r66UlYcfaB6
	 rVq2mB2paHOSBAAp1FJejkWagbD4dzz5++n0ukykcll9PXbtNY4IPsb/JPp2ke5Zd3ZYpSVe7cht
	 qOVvsniFn8QO7SdIK8eA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Read in rfcomm_sock_setsockopt
Date: Fri,  5 Apr 2024 17:30:46 +0800
X-OQ-MSGID: <20240405093045.520623-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000b9b20e061553f06e@google.com>
References: <000000000000b9b20e061553f06e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test oob in rfcomm_sock_setsockopt

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fe46a7dd189e

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index b54e8a530f55..42c55c756b51 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -629,7 +629,7 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
 
 	switch (optname) {
 	case RFCOMM_LM:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
+		if (copy_from_sockptr(&opt, optval, min_t(int, sizeof(u32), optlen))) {
 			err = -EFAULT;
 			break;
 		}


