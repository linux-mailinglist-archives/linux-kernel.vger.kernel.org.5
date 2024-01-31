Return-Path: <linux-kernel+bounces-46230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3524843C9E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BE11F30DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B3169DFB;
	Wed, 31 Jan 2024 10:27:51 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E673569DFA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696871; cv=none; b=LdPS0UjaV07eHSpiXjQFzsLwwvNBLWKP7FENfKLDuKrJuPtqVn5t1EwlTNgIkKbUMwoIs0wwsHT+agO5lW3+gM7M1zR+OZ5tG+FBSdtlXW6GKF4wc692tQktPmZtftUaH8cBZqscqllNOGSKmGEzrUGPaSL8+ml7QadlGxGxlss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696871; c=relaxed/simple;
	bh=n8JYSWgReCD6C48YOR5TW/4+19o2TTZ0oplZ6RW/7Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tl1SMQb1VKH/PH4Z0NIBdM2UwOE2zbV0q08lltHhQQ6VscRu77WBsXgQic5rGuyLB3TuOAc1slL6NmjFuE1bifspZN7C3YEDp45glB92sQ7Sfkt1YYDT9SN5+0Ss4hSpTCfVd2lPkP+IUf9n7GwIamQ7kBTJF4XxPb1BTNwbyVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.172])
	by sina.com (10.75.12.45) with ESMTP
	id 65BA209C00009EC3; Wed, 31 Jan 2024 18:27:42 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 90201231457888
X-SMAIL-UIID: EA203CFCF5FA4AC89772E469D20C8742-20240131-182742-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a984066a63e9c1e62662@syzkaller.appspotmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] INFO: task hung in hci_conn_failed
Date: Wed, 31 Jan 2024 18:27:31 +0800
Message-Id: <20240131102731.1550-1-hdanton@sina.com>
In-Reply-To: <Zbnq5o_HJOMIIK-c@Boquns-Mac-mini.home>
References: <20240130113037.1390-1-hdanton@sina.com> <00000000000082e8ba06102ba5f1@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[cut cc list short to walk around spam detector]

On Tue, 30 Jan 2024 22:38:30 -0800 Boqun Feng <boqun.feng@gmail.com>
> 
> This looks like the case which Frederic recently fixed:
> 
> 	https://lore.kernel.org/lkml/20240129232349.3170819-9-boqun.feng@gmail.com/
> 
> , which is currently queued in my tree for v6.9 PR:
> 
> 	https://github.com/fbq/linux.git rcu-exp.2024.01.29b
> 
> can we give it a spin?

#syz test https://github.com/fbq/linux.git  rcu-exp.2024.01.29b

