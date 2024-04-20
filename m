Return-Path: <linux-kernel+bounces-152207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515DF8ABAC0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E497A1F21270
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 09:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765B1175A9;
	Sat, 20 Apr 2024 09:22:10 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8207C17559
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604930; cv=none; b=fKZM6mMc62BYBCufjaomU+SbgLx5ObETli6nAQaJnxwYLg5VdkMD7YKbXGt162IvEKGdS6QUFCdoA8dEPUY43YNXgweGYmFA2ezNpIXSiH7iOyIbPqZx1Dy0C26ga5uj4D0TsdnDm5MV8B78yJaSafhN6X7t3gy1B+DdTvuYQ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604930; c=relaxed/simple;
	bh=HmvUXRk6KWF8pkj/3bMmqxGVWO5zIq4abz7LDPgnwg8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=OZyap28rFciXJj9VlH1w733JcqX82mzJgXl/1+Z35uQTLBOa3fmMhaWHER63CF7VAfIwPDnMr26HtweGn4z5R0rUWOLGS94b4KXXdfmmjSz5uaj4xM0X2G3IdXImFESVpWZ1yWxxoJMCEKe1bchXK24PGs++2pGG2VLqnc12cNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 43K9M1qr049580;
	Sat, 20 Apr 2024 18:22:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Sat, 20 Apr 2024 18:22:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 43K9M15h049510
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 20 Apr 2024 18:22:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f46802b7-34a3-4218-ad25-7dddbbfec2e6@I-love.SAKURA.ne.jp>
Date: Sat, 20 Apr 2024 18:22:01 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [virtualization?] net-next boot error: WARNING: refcount
 bug in __free_pages_ok
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: syzbot <syzbot+e58465c446f16bd6191a@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000008d4beb06143d8165@google.com>
 <81e0cf26-21de-4f75-9b20-3c4f4b0f6ad8@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <81e0cf26-21de-4f75-9b20-3c4f4b0f6ad8@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: mm,page_owner: fix refcount imbalance


