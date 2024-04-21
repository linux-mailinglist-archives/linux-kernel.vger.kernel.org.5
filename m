Return-Path: <linux-kernel+bounces-152496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B168ABF50
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 15:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45DF0B216B1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 13:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C21168A9;
	Sun, 21 Apr 2024 13:28:52 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D60C125BA;
	Sun, 21 Apr 2024 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713706132; cv=none; b=KFiqTxi3zKNiQflQK7noceG2RE1OFeEyS7AnWtVjq/JgqTaRrJzT/hdAfGvpuwJOwg3xyjEJ+HU0YAriEj/A4hi+HonTljX/V9rgK4Z7BbfnP3OoPsyjSwCokFmwQE5s2rgSxj+8PCcdkevOgM1sVGsdP07mKAKDUM4HGjWU3xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713706132; c=relaxed/simple;
	bh=VbnjO6uMvxGBr8zdSDJuHosNBKdVUrNJcXbHEr2TrU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwAA7dfxmxMXpR3fKX+W3ceLVKaJqbfz8IXurvMONlKuslnk3fcuIN3nzOjVDA1K2iG9WJV/o939Z9U+mvXC7xbjLJqPmeteMInJiRBZqqwHTu+XLwFWkWgDrbfQIvtfBTpx3l15PWBsG76Iaj8NvR9o8XNgSJbMzXy8D38KYwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 43LDSMOm097707;
	Sun, 21 Apr 2024 22:28:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Sun, 21 Apr 2024 22:28:22 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 43LDSMrA097702
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 21 Apr 2024 22:28:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6103a212-f84f-4dad-9d33-a18235bd970a@I-love.SAKURA.ne.jp>
Date: Sun, 21 Apr 2024 22:28:19 +0900
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
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=wjW3PdOZ7PJ+RHUKRc8SqQhcWXCACOvmwBkKUKABHKqwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/04/21 3:05, Linus Torvalds wrote:
> On Sat, 20 Apr 2024 at 11:02, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Most other normal tty devices just expect ->write() to be called in
>> normal process context, so if we do a line discipline flag, it would
>                                         ^^^^^^^^^^^^^^^^^^^^
>> have to be something like "I'm ok with being called with interrupts
>> disabled", and then the n_gsm ->open function would just check that.
> 
> Not line discipline - it would be a 'struct tty_operations' flag
> saying 'my ->write() function is ok with atomic context".

"struct tty_ldisc_ops" says that ->write() function (e.g. gsmld_write())
is allowed to sleep and "struct tty_operations" says that ->write() function
(e.g. con_write()) is not allowed to sleep. Thus, I initially proposed
https://lkml.kernel.org/r/9cd9d3eb-418f-44cc-afcf-7283d51252d6@I-love.SAKURA.ne.jp
which makes con_write() no-op when called with IRQs disabled.

My major/minor approach is based on a suggestion from Jiri that we just somehow
disallow attaching this line discipline to a console, with a concern from Starke
that introducing cross references is hard to maintain taken into account.
https://lkml.kernel.org/r/DB9PR10MB5881526A2B8F27FE36C49134E0CBA@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM

Now, your 'struct tty_operations' flag saying 'my ->write() function is OK with
atomic context' is expected to be set to all drivers.

Do we instead want to add 'struct tty_operations' flag saying 'my ->write() function
is NOT OK with atomic context' and turn on the flag for the console driver?


