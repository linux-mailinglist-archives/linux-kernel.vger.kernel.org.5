Return-Path: <linux-kernel+bounces-155473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EDD8AEB01
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4669CB21AE1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5194113C3E3;
	Tue, 23 Apr 2024 15:27:22 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913855FDA6;
	Tue, 23 Apr 2024 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886041; cv=none; b=ekKg7wh+X+G6v7J1goi6ejO+I43k3Fg54InkNtjkYNtacq1sfjnZC2amYaFaYRrV9pcL9+FQE2aS6Z4sEnjiIZlvAQi3VMzE+Js1B/pZYv/sidBK0VdZYSUM4n00lkWbYqEVXWeRjNo8SOI00I8dOLyRcO9/JtDHiD/NkaFsPdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886041; c=relaxed/simple;
	bh=60Zp/ibynXRNPZ4CWH9Dw8Mps9vbwWnEax5EHe6s0w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixRe6GADjDFcyckCxZZdNvpsZTWMlEANeMgu5dvbx00BzSLxGWbhRoT2JSUuecIcZP0Yhk6PS3GjhhhTjRxkkBx7pa7qjPSkxjv5LMp0NRZbifzH56ABfCV+T9hoLqrgzOBv4pPET/pqiBYe1+MpQlssca/mVoa18a+yI8eK16Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 43NFQsgp083980;
	Wed, 24 Apr 2024 00:26:54 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Wed, 24 Apr 2024 00:26:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 43NFQsoT083976
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 24 Apr 2024 00:26:54 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <563ec0ed-a851-450b-aed6-986f6ea324ca@I-love.SAKURA.ne.jp>
Date: Wed, 24 Apr 2024 00:26:53 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tty: n_gsm: restrict tty devices to attach
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        "Starke, Daniel" <daniel.starke@siemens.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <e696e720-0cd3-4505-8469-a94815b39467@I-love.SAKURA.ne.jp>
 <CAHk-=wjEZvnn51dhhLqBKUd=cuFhbYA47_OyfUOPB-0zKToL7Q@mail.gmail.com>
 <CAHk-=wjzqaqcicTtWfBtXyytJs1nqjJNved2JFsLVsVLYgVkuQ@mail.gmail.com>
 <CAHk-=wjW3PdOZ7PJ+RHUKRc8SqQhcWXCACOvmwBkKUKABHKqwg@mail.gmail.com>
 <6103a212-f84f-4dad-9d33-a18235bd970a@I-love.SAKURA.ne.jp>
 <CAHk-=wgjZ0DJgeo5Sk-Kc5vw8TXGuxXftPV79Wv221ncstk1tA@mail.gmail.com>
 <CAHk-=wg+hJ9Y8AKjp9qD7E_-pgBFdWGLiqzi1qth8LNpuST1cA@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=wg+hJ9Y8AKjp9qD7E_-pgBFdWGLiqzi1qth8LNpuST1cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/04/22 1:04, Linus Torvalds wrote:
>> Now, your 'struct tty_operations' flag saying 'my ->write() function is OK with
>> atomic context' is expected to be set to all drivers.
> 
> I'm not convinced. The only thing I know is that the comment in
> question is wrong, and has been wrong for over a decade (and honestly,
> probably pretty much forever).
> 
> So how confident are we that other tty write functions are ok?
> 
> Also, since you think that only con_write() has a problem, why the
> heck are you then testing for ptys etc? From a quick check, the
> pty->ops->write() function is fine.

I tried to make deny-listing as close as allow-listing. But it seems that
ipw_write() in drivers/tty/ipwireless/tty.c (e.g. /dev/ttyIPWp0 ) does
sleep as well as con_write() in drivers/tty/vt/vt.c .

I couldn't judge serial_write() in drivers/usb/serial/usb-serial.c (e.g.
/dev/ttyUSB0 ). But since device number for /dev/ttyIPWp0 is assigned
dynamically, we can't rely on major/minor for detecting /dev/ttyIPWp0 from
gsmld_open() side.

That is, we need to handle this problem from "struct tty_operations" side
(like I initially tried).



On 2024/04/22 2:18, Linus Torvalds wrote:
> On Sun, 21 Apr 2024 at 09:04, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> The only option is to *mark* the ones that are atomic. Which was my suggestion.

Since majority of "struct tty_operations"->write() seems to be atomic,
I prefer updating only ones which cannot be atomic.

> 
> Actually, another option would be to just return an error at 'set_ldisc()' time.
> 
> Sadly, the actual "tty->ops->set_ldisc()" function not only returns
> 'void' (easy enough to change - there aren't that many of them), but
> it's called too late after the old ldisc has already been dropped.
> It's basically a "inform tty about new ldisc" and is not useful for a
> "is this ok"?
> 
> But we could trivially add a "ldisc_ok()" function, and have the vt
> driver say "I only accept N_TTY".
> 
> Something like this ENTIRELY UNTESTED patch.
> 
> Again - this is untested, and maybe there are other tty drivers that
> have issues with the stranger line disciplines, but this at least
> seems simple and fairly easy to explain why we do what we do..

This patch works for me. You can propose a formal patch.


