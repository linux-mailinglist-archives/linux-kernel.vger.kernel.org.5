Return-Path: <linux-kernel+bounces-98064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 427DB8774A9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 01:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A561F212F8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 00:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62F3EC5;
	Sun, 10 Mar 2024 00:58:24 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73007FB;
	Sun, 10 Mar 2024 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710032304; cv=none; b=UN4V6oSQkA9hMbioP6Ao0B7e3hMNgGM1tCuQPw03b8PTTq08kmLAH+OtSQ6o5Um6bCj19Bpa/8xuC6vLTm0vHXJ6svf0jqGWM6j9nI5bKpO3gapua1vbGhHQgril5EMUVXETVA5Aq2ItRvnpATTn3i9YsIjEiUA8JHEtYakMojk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710032304; c=relaxed/simple;
	bh=G/6KdXu31T1VAui/RJwqf6i/24VbdcZQazuZ9wjU2fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fAtCiS2+3KTUfV44pWkdGghgCJnpMYTR3sda+19MXjjFaUM8voD7cW9uIC0YQKtpPCjwF7NfhfONcwSob72kWW3C18VUOc0I1nG3tdjYvzmK9uJfVezASTB/7Fk+Mpoprwh7qWda1MH8HA8G5gmDp5j2439ecJPoTzneYurr1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42A0vvba088365;
	Sun, 10 Mar 2024 09:57:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Sun, 10 Mar 2024 09:57:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42A0vuHI088361
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 10 Mar 2024 09:57:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <64eb9c69-fb01-4451-83f7-0e7acf4fa1b6@I-love.SAKURA.ne.jp>
Date: Sun, 10 Mar 2024 09:57:55 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [reiserfs?] INFO: task hung in reiserfs_sync_fs
Content-Language: en-US
To: syzbot <syzbot+4dadbee41d087d9c6234@syzkaller.appspotmail.com>,
        axboe@kernel.dk, brauner@kernel.org, hdanton@sina.com, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        longman@redhat.com, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000a7bb7506124edb52@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000a7bb7506124edb52@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: fs: Block writes to mounted block devices


