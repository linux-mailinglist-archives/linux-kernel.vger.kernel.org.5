Return-Path: <linux-kernel+bounces-51512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4004848C0F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645F41F228C8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6920712B8C;
	Sun,  4 Feb 2024 08:02:57 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991D912B6C
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707033777; cv=none; b=BEKAFol/QM5SZi/aanhIB1iOqpx08ldl1/HMcBItHIwx0eH50z9aE3+nZ16g0wTQwseHFgJsYlmNRqbhMm9KlDmrJ2ytLLRjGezlx0l3SV50kQCfGdz4TSm4Rh7q7ml9mEz8tQGXUy/QBGIK2q6Ysv3FAE8OxhtoA4005178LqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707033777; c=relaxed/simple;
	bh=g26HPNnhers94BDCaq62vDd7rhr2utULjOvA3mEsaFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nTX3vdpcaLZyTYyVWyfFfZcq2ugAPi3EVov9ccqRdi6Mw6Y18fszP0lhoU2gjLEoe3VE3wShw6urtInLjdyzktLnsmrFDLi0L9ukeLiFfIQ5573Y6J/HvjoDi28tGx58BaQ06HuK1839A+eyFlDWLE3usRdPQtFmNXmrGkiizHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.53])
	by sina.com (172.16.235.24) with ESMTP
	id 65BF44A0000073C3; Sun, 4 Feb 2024 16:02:42 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 97654945089175
X-SMAIL-UIID: 2A27C2F174C6479BB7FF77A72CB2D057-20240204-160242-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+6b1634ec78e55df41793@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [afs?] [net?] INFO: task hung in rxrpc_release (3)
Date: Sun,  4 Feb 2024 16:02:30 +0800
Message-Id: <20240204080230.540-1-hdanton@sina.com>
In-Reply-To: <0000000000007e79b806107c054a@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 03 Feb 2024 07:38:34 -0800
> HEAD commit:    076d56d74f17 Add linux-next specific files for 20240202
> git tree:       linux-next
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1562f5b0180000

#syz test https://github.com/fbq/linux.git  rcu-exp.2024.01.29b

