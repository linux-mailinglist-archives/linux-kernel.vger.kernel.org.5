Return-Path: <linux-kernel+bounces-118810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8677188BF9C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80671C3E594
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D03F28E6;
	Tue, 26 Mar 2024 10:35:36 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E58647
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449335; cv=none; b=HGsVYgvgZZ7iQUyUGJ0yl3NyiBxRYAwJtF9mdus3xaMIAUrRNtIpmg5ysp8wypDVVyYhWAoOTPQGVf6WN36OHohls2yiKjAjFfujgX+FLhWcfG8+EFvAm/WUKo9e8tjuPb/aUsS32vOunzGp27eSdbttJ0zT0MG0kjbKUS7odeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449335; c=relaxed/simple;
	bh=e3i1XSxEB59/oPiSAipZiYlrMWqskFmLSRLX9kjNrtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FlnSeh962bBoYi292IiezF6zPGaqi34EGP0r1X6uGa6bkSbnKD9GfhARwQ9JPWqZE/xtcvq3Go78R8SkHLse4pHL3Tw/fh4I2UhMj4T4gBK/ERKb9/N4mawOw5/J0owsel2KnJKuPhMoulUbL/sK/9F6t0cot5+DaGbO2FeWh6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42QAZSDQ090397;
	Tue, 26 Mar 2024 19:35:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Tue, 26 Mar 2024 19:35:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42QAZRh2090393
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 26 Mar 2024 19:35:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <21e3faba-ead0-448d-b835-0dd354bdeb08@I-love.SAKURA.ne.jp>
Date: Tue, 26 Mar 2024 19:35:27 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [virtualization?] KMSAN: uninit-value in virtqueue_add
 (4)
Content-Language: en-US
To: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000fd588e060de27ef4@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000fd588e060de27ef4@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: x86: call instrumentation hooks from copy_mc.c


