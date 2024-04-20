Return-Path: <linux-kernel+bounces-152288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3392B8ABBEC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 16:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64DF01C209B7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 14:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B6C22091;
	Sat, 20 Apr 2024 14:03:40 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188C62375F
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713621820; cv=none; b=p3qy6PCq8HKkkXoFh2R+jqppclaQ8a2qD1cKJc3tzAJHsGhefQaYQmcXzB1TXGYfvXqF3OoD4wD5DZCQjzNPkMadjnnxFLkB4/GH+yPTzLtCwCjI24LbWoU+Rp16pk0PXAnFOA8Uz2R+9HyhMrCmiqnxy2YDDHzoRCcUyACPHig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713621820; c=relaxed/simple;
	bh=MrauLE7vTIJ56o0G5yI1/rmSGSVS4GvOYwtIC8oySNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JspGBanxAArVW6J9IFKo4uxRIBAs7zcYFAkxXKAfWub1DmMsmRP2+gskevGg7QpfJ0mW5Nr+oUhNKyiPPWS0ieyZSw0Fi31dNASi31E+ByITz0qT1NaDWnmQsBgMSIo3oSow9W7s4UycOWZjson5mv7cfl5iCsybXNxllPGiJqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 43KE3SLj024714;
	Sat, 20 Apr 2024 23:03:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Sat, 20 Apr 2024 23:03:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 43KE3SAM024705
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 20 Apr 2024 23:03:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1031889c-a474-4797-8482-1651baa5ba57@I-love.SAKURA.ne.jp>
Date: Sat, 20 Apr 2024 23:03:27 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in tty_port_tty_get (2)
To: syzbot <syzbot+afcf1c450aca9ec1b5f1@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000e82df406143872eb@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000e82df406143872eb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: bpf, sockmap: Prevent lock inversion deadlock in map delete elem


