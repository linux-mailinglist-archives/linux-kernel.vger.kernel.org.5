Return-Path: <linux-kernel+bounces-98062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC35C87749F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 01:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198241C2097B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 00:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939F2ED8;
	Sun, 10 Mar 2024 00:54:49 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DD81FA0;
	Sun, 10 Mar 2024 00:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710032089; cv=none; b=JjbI/FawwkcFIUinEV/RnDiRTlFAdsXyAVhhgwptGnUu+WZO274n6uXhb9Uz66wb5B76P/6j7UxwAul6XJ78SsL4zRoqTu1mQbgwqIRiZ3D7QjH7YYh7bspyE6IURAQCUq6J17jJBMbFEUVLB53T2GYdeu7DRQsGM5fV31wiPNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710032089; c=relaxed/simple;
	bh=G/6KdXu31T1VAui/RJwqf6i/24VbdcZQazuZ9wjU2fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IVbHGCn0fC0mUZ+GbNTIvps1XZm5+OmcDYTMu7+9xp6eKLJ0y/LGOW5DG5CbRpZeQhl0WNt3d9D6Sy910n8d/rqPm6Esy4eU20f9nxWe8ZZWV1+o+SWJTLNWHioUkB421Dk0B3FJfWAbMEsxpzJXdRW2b1FBJHN4FjqtqP3FLEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42A0s5Sp087296;
	Sun, 10 Mar 2024 09:54:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Sun, 10 Mar 2024 09:54:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42A0s4lc087293
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 10 Mar 2024 09:54:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f2a9b546-433e-4661-aca9-8c58fdfc5be7@I-love.SAKURA.ne.jp>
Date: Sun, 10 Mar 2024 09:54:03 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [reiserfs?] possible deadlock in reiserfs_dirty_inode
Content-Language: en-US
To: syzbot <syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com>,
        axboe@kernel.dk, brauner@kernel.org, hdanton@sina.com, jack@suse.cz,
        jeffm@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        paul@paul-moore.com, reiserfs-devel@vger.kernel.org,
        roberto.sassu@huawei.com, roberto.sassu@huaweicloud.com,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
References: <000000000000b6989a0613375b88@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000b6989a0613375b88@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: fs: Block writes to mounted block devices


