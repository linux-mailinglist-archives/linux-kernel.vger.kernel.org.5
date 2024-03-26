Return-Path: <linux-kernel+bounces-118856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BA288C058
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304D81C38D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229B754747;
	Tue, 26 Mar 2024 11:14:31 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC950A98
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451670; cv=none; b=sGsTKBJDSojgaAbk1KEzMlnOy2dc7wzrwxe5Ho+oWgfEZFgBU2kpSjRZIPTDzAU+wFe/bynWMk3R3U/gc3ZsF0BIqlP8KJ+Z1V4y6NiO/mdgY0MDsQufhklmIcA0y0suL1PqAlbrDY3RHKMy/a2rfYNNyZVB/DlpqeC8QhwJSA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451670; c=relaxed/simple;
	bh=fYqDdIXapUBE0MxV0rIK+zXf297Qb+0D5VWup0Hvs9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZDGyNrMjfMj+lg08mV4JgdcOv4G5KN7e1ztk0ZVzYWeM5EqoBKxyZFLvhxDWCgKNATOUJo/gi4XgUFN+ELju6yYhSpGZ7vOWZzia/i8amcWtM/qqIGRDZehfCZbnJZfloRhYzZ72Uy9WoEpwvMuJqAsew0Q+eWMEwnm0bibz5uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42QBEJM7097615;
	Tue, 26 Mar 2024 20:14:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Tue, 26 Mar 2024 20:14:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42QBEJLm097612
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 26 Mar 2024 20:14:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1533d619-20c4-4f0d-a29e-7342d8f54c9c@I-love.SAKURA.ne.jp>
Date: Tue, 26 Mar 2024 20:14:19 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [virtualization?] upstream boot error: WARNING: refcount
 bug in __free_pages_ok
Content-Language: en-US
To: syzbot <syzbot+70f57d8a3ae84934c003@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000cfd4800613fe79b1@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000cfd4800613fe79b1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: mm,page_owner: Fix refcount imbalance


