Return-Path: <linux-kernel+bounces-118866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0593188C070
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3696F1C37B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BA04C634;
	Tue, 26 Mar 2024 11:19:13 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B26482D7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451953; cv=none; b=P1NIFSvN/OF7MiW3fLrR686PrnBSsUQsjwMe5FCb4TH0xt334+mlbHXR4JtHq4jPAUcoVF9Meh7+gDG36L0CDOGPlk0+0nadnj6jiqUbZCY074feSIieRFYywCtYN8MqxK6r9QMosDtb2r0jO27E6iXYdjFF8Zeh8X2030xCRjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451953; c=relaxed/simple;
	bh=fYqDdIXapUBE0MxV0rIK+zXf297Qb+0D5VWup0Hvs9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=is2Y+oKAPmE6Jre/f2BnQqfJ29m1Ya0iA9kmmZTzCRHhG8NkeANYhrjmSQF39THm5v3OaZ9qfOI9xyUN2YllncJWRiGeIznRxC6K0pPtO9/prXPPGm8Ztq4xlBW81wdTD9GiBqErcp4LYSrxb0fm7WDNr7sgslavQrn/+qCK2fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42QBJ5Rp098565;
	Tue, 26 Mar 2024 20:19:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Tue, 26 Mar 2024 20:19:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42QBJ5Yh098562
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 26 Mar 2024 20:19:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <789a4e0e-d78d-4448-a568-bf3f21b9ab83@I-love.SAKURA.ne.jp>
Date: Tue, 26 Mar 2024 20:19:04 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [virtualization?] linux-next boot error: WARNING:
 refcount bug in __free_pages_ok
Content-Language: en-US
To: syzbot <syzbot+6f3c38e8a6a0297caa5a@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000d305050611b50d09@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000d305050611b50d09@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: mm,page_owner: Fix refcount imbalance


