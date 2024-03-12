Return-Path: <linux-kernel+bounces-100851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C80B9879E2A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB51B1C20DED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75201143C50;
	Tue, 12 Mar 2024 22:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hi/htTON"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D7143732;
	Tue, 12 Mar 2024 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281143; cv=none; b=crbhxX/+i3hqgIRojH5qAz8Ha/cWjTdzaXmxwB0hBdY8mVeOih7OjzHCR0LpUVab6PNE80vlYme4VwIqD1DdgDj9yaHo2YN8Ppi+uOc2YLnykUnLPurw08yrV0+1rIt0KqNzCs2VJRKkndveeB6NDi+RpJyRbQS3ixGPefjF/wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281143; c=relaxed/simple;
	bh=0uFWXlq/bPkrLYF9MHYq3kxPJG51I/NUMGv7dd4/IPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=soUZLUyvrv1Oc9yXUjT6SLN3z+QYttW4XutWL9vzhmSfQdaHJMvxHZVNlTPfI2rgafVTs1P+Lt/XEmVKt00zWdNzJmxtUJuyQd1/h3M/cwdiYFuEWrdIKaYnr25X6N0EgfIFVfqKKdp6X2RqrvkErG9o4EGNxE7+hC9QJVV0I8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hi/htTON; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-788412a4b2eso216000485a.1;
        Tue, 12 Mar 2024 15:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710281141; x=1710885941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EFwEP3ZSIH+k5Tq40d0y8R8so/J7WJ6iWYCwKAvVNhE=;
        b=hi/htTONHJNN5uDoRAMR6byLUgrnGMiXpdPkv4Z/2VtxbgxJ/Rk99qEOPvNTUAdmtW
         EaQAuAO+oMqLPGGaCiqzYSK2OxBa43d+8feMJwTPY1eosfj9R5+HFFVIbTdt90tSi3Rr
         qRXJ92z/ls4IUOOVynReqPBn9pXRLVz6delkLxZpXnZhZATYYy+whQEagtHJzMOhIVNg
         DHuZydW0sB3xKpkjagiuQmMkCyoo7OeE1CKG0KgEhmXBXPyTigdWLg7BBzpe8JHnvwUN
         ypEKB4TumjzLzzUSnhtn5FEgBDoUhqdq/f6pArXv/3aUigKMaR7Fjy3GBxL//LsrTw8Q
         N1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710281141; x=1710885941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EFwEP3ZSIH+k5Tq40d0y8R8so/J7WJ6iWYCwKAvVNhE=;
        b=bP/PHgAxGifkf7LfYvA7eEA/rF9UHFDn9ThWOCQ8QOrFHOXlvMjIT9JFlC8HBhUhUT
         XfU+o6dkwPSr22xDksfOX9q/U5YEBueS6Vz0b2RfTg4I08acce3ihRsTOakVePhVl+iX
         m3kQKigHKtUz4yF0MPfMCkuaQusJmzRqHspdCJe364MkOfvKIfxhR6WrXxG1RlnZEAiq
         koayXV3KwCr0tDQNKLzGblYtJRb5EsDIyEWycpSpks689flF0iY71LloZ9W/M74FJjGL
         ktxEj+SRg4DAMXMRa5IodHcydDswDs294lEbqgX6Dd4vKABEg76aKW36HFvCkkRNNJRs
         rygw==
X-Forwarded-Encrypted: i=1; AJvYcCVUrUUuZyeIac2NsLOK77Cl71HXU0KF/slw9wX4APPgwjSGI8CWNM9+og0IeIegY2uoSyIF2XVCatgXYozcy0d9q69y0WsI3VVFp4pCfYjfqPT5kc8P1Gm1nL7r8fx2hj5r
X-Gm-Message-State: AOJu0Yy8d0L9PMUmgwZAZp4qyL+O1syKuW7E6QmZriD7ttvIdi4agVlt
	GJvMVJ2rAR48LaQSXfym5mZL6IJTzqnXxZ0537JOirG6D2ysckQP
X-Google-Smtp-Source: AGHT+IFm2bZH2s6BLeXvkZG2NAUvr59G8hwxJAq0jiQrOZyzOkVsxnmU1qt++9YFuIIpSwRFSRnrTw==
X-Received: by 2002:a05:620a:1196:b0:788:41d6:14cb with SMTP id b22-20020a05620a119600b0078841d614cbmr1590529qkk.24.1710281140826;
        Tue, 12 Mar 2024 15:05:40 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h25-20020a05620a21d900b00788577fcee4sm4085454qka.91.2024.03.12.15.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 15:05:40 -0700 (PDT)
Message-ID: <95467e67-16f1-4c75-a609-0295ac45db43@gmail.com>
Date: Tue, 12 Mar 2024 15:05:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes for
 v6.9]
Content-Language: en-US
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org,
 mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org,
 joel@joelfernandes.org, neeraj.upadhyay@amd.com, urezki@gmail.com,
 qiang.zhang1211@gmail.com, bigeasy@linutronix.de, anna-maria@linutronix.de,
 chenzhongjin@huawei.com, yangjihong1@huawei.com, rostedt@goodmis.org
References: <ZetHwrCb0KXE0xFI@tardis>
 <4274be61-60bd-4e1e-9c16-26e6e5e06f65@gmail.com>
 <ZfDCjBFfyWpTK-I1@pavilion.home>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <ZfDCjBFfyWpTK-I1@pavilion.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/12/24 14:01, Frederic Weisbecker wrote:
> Le Tue, Mar 12, 2024 at 01:32:03PM -0700, Florian Fainelli a écrit :
>> Hi Boqun,
>>
>> On 3/8/24 09:15, Boqun Feng wrote:
>>> Hi Linus,
>>>
>>> Please pull this for the RCU changes of v6.9:
>>>
>>> The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:
>>>
>>>     Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)
>>>
>>> are available in the Git repository at:
>>>
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git tags/rcu.next.v6.9
>>>
>>> for you to fetch changes up to 3add00be5fe5810d7aa5ec3af8b6a245ef33144b:
>>>
>>>     Merge branches 'rcu-doc.2024.02.14a', 'rcu-nocb.2024.02.14a', 'rcu-exp.2024.02.14a', 'rcu-tasks.2024.02.26a' and 'rcu-misc.2024.02.14a' into rcu.2024.02.26a (2024-02-26 17:37:25 -0800)
>>>
>>>
>>> Two merge conflicts were detected by linux-next:
>>>
>>> * https://lore.kernel.org/lkml/20240226135745.12ac854d@canb.auug.org.au/
>>> * https://lore.kernel.org/lkml/20240227125522.2bdbe6be@canb.auug.org.au/
>>>
>>> These conflict resolutions from linux-next look good to me, plus I made
>>> my own resolutions at branch merge/rcu.2024.02.27a for your reference.
>>>
>>>
>>> Some highlights of the changes:
>>>
>>> * Eliminates deadlocks involving do_exit() and RCU tasks, by Paul:
>>>     Instead of SRCU read side critical sections, now a percpu list is used
>>>     in do_exit() for scaning yet-to-exit tasks.
>>>
>>> * Fixes a deadlock due to the dependency between workqueue and RCU
>>>     expedited grace period, reported by Anna-Maria Behnsen and Thomas
>>>     Gleixner and fixed by Frederic: Now RCU expedited always uses its own
>>>     kthread worker instead of a workqueue.
>>
>> At least one device in my test farm (ARM 32-bit) has consistently shown a
>> very long boot, and some others are intermittently affected. This
>> consistently looks like this on most of my devices:
>>
>> [    2.450351] bcmgenet f0480000.ethernet: GENET 5.0 EPHY: 0x0000
>> [    2.547562] ata1: SATA link down (SStatus 0 SControl 300)
>> [  162.107264] unimac-mdio unimac-mdio.0: Broadcom UniMAC MDIO bus
>>
>> this gets flagged by my boot script as a boot failure since we exceeded the
>> 30 seconds timeout given to boot a kernel to a prompt.
>>
>> It has been somewhat difficult to get a reliable bisection going on, but
>> what I am sure of is that e5a3878c947ceef7b6ab68fdc093f3848059842c~1 does
>> not expose the problem for 10 consecutive boots, while I *might* see it at
>> e5a3878c947ceef7b6ab68fdc093f3848059842c and beyond.
>>
>> Any clues what is going on here?
> 
> I understand it doesn't reliably reproduce. But is there any chance you could
> test that alone?
> 
>       0bb11a372fc8 (rcu-tasks: Maintain real-time response in rcu_tasks_postscan())
> 
> And if it reproduces there try a bisection?
> 
> git bisect bad 0bb11a372fc8d7006b4d0f42a2882939747bdbff
> git bisect good 41bccc98fb7931d63d03f326a746ac4d429c1dd3

None of them failed unfortunately, I need to narrow down the window 
between v6.8 and 65d287c7eb1d14e0f4d56f19cec30d97fc7e8f66.

Thanks!
-- 
Florian


