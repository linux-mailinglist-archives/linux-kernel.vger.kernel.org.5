Return-Path: <linux-kernel+bounces-126503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2000F8938BE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64681F2167D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 07:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8017FBA3F;
	Mon,  1 Apr 2024 07:54:38 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6560415A4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711958078; cv=none; b=bcYJJqsuSfb8ElC+y3lOueH2Zs2cCkmEdVBGgWWPoEpEfEJ8KwAACBsH7/B2DL+A/F9XnqdW9WdoIP+YEiE7KODINCFqoxeDN+IZYxWtVcThpINaK3Kb0axVZ2foDRLAyqb6qO+ed2fofQinBq39x+sscrBAFWUHj6o0Iv1LAVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711958078; c=relaxed/simple;
	bh=HmvUXRk6KWF8pkj/3bMmqxGVWO5zIq4abz7LDPgnwg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fmTGHr2iPKNTn0LxQYbLtisIbpXyKrS9/r3ekK9igaZHqh3mTpzXF9RgIZwNXL4hCVbkOJSNLzKF3PiQBp8/zXbSR6iq21NzvtJAng6tVVgvdo+NNuOHVBPUAaGtPU/bDQZO5YoRABFmJpBmftxafHf0UhJI0UnPtPJwTzyk1C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4317sLIn059264;
	Mon, 1 Apr 2024 16:54:21 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Mon, 01 Apr 2024 16:54:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4317sLfO059260
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 1 Apr 2024 16:54:21 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d1ef222f-aab1-4ab9-8507-f547c2f5e6ed@I-love.SAKURA.ne.jp>
Date: Mon, 1 Apr 2024 16:54:20 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [virtualization?] bpf-next boot error: WARNING: refcount
 bug in __free_pages_ok
Content-Language: en-US
To: syzbot <syzbot+1f345d82b7f611cbcc66@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000877f3c0614f7efa4@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000877f3c0614f7efa4@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: mm,page_owner: fix refcount imbalance


