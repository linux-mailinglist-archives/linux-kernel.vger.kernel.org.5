Return-Path: <linux-kernel+bounces-152208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E038ABAC1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50111C20B39
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 09:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA3D17C67;
	Sat, 20 Apr 2024 09:22:19 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BF217BD8
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604938; cv=none; b=bSGcyxD6RcYFM5qF50ZUxCAuTyblksl/3D7EcxZUT+TmkKrxTqgTuE7Rh0fXTfGKMLS/wGnDi+O+fFul8f0mS191Z1jfnH/+GhEwQT5LmkmdXwHfsO4UDdJqF/WZYlggqJd/ZBcf1CT0VQZ6CjKq2KMh90EwZ11fCwcFmZrfNu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604938; c=relaxed/simple;
	bh=HmvUXRk6KWF8pkj/3bMmqxGVWO5zIq4abz7LDPgnwg8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=B8hnWReB7XCzsrH+YPZx3a19PmHMM5FKFth0UbWX2/Ou3ZBnr7lA1FnP8BsEG4wppvlnLSegDo0yzzyviARF8szwUhT5EzFK3e+vsqj6Zqz5+F8iF69B0Um4LNh3cZyNj0g0siHsr1kTx7TaHiVVtA7U8c11W/WoiYbKZdDzkdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 43K9MAAJ049708;
	Sat, 20 Apr 2024 18:22:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Sat, 20 Apr 2024 18:22:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 43K9MAAr049703
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 20 Apr 2024 18:22:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6585d53b-106a-4673-beb6-1888567fd695@I-love.SAKURA.ne.jp>
Date: Sat, 20 Apr 2024 18:22:10 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [virtualization?] upstream boot error: WARNING: refcount
 bug in __free_pages_ok
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: syzbot <syzbot+70f57d8a3ae84934c003@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000cfd4800613fe79b1@google.com>
 <1533d619-20c4-4f0d-a29e-7342d8f54c9c@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <1533d619-20c4-4f0d-a29e-7342d8f54c9c@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: mm,page_owner: fix refcount imbalance


