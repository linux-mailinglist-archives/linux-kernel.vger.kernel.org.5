Return-Path: <linux-kernel+bounces-100810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDDF879D86
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3F01C2133C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E702143738;
	Tue, 12 Mar 2024 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBQLXa6B"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1C4142636;
	Tue, 12 Mar 2024 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279275; cv=none; b=sMlQL+6FsBLLQdc7QiW/bCRhSXcWsePHrWy1RCH6QBydTB5RNoSZfkRInk28KhQPbfb8KXVWucASWR4tO+UGMhfiTyURM+JW+9J3ksfF/3VkOXz9lzjdThdDwpxzmEvisaUKOdz2R2qAWSMjkzD0TvxoZfi55HhFH/4KTyGi/2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279275; c=relaxed/simple;
	bh=5/wmLAHrNeE9hx434xthwOeHWChqxB0kDiERSOp8o0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cK1/0yYBsLFzNS4PmtdbQmD6I9HnVGOvllqnuAQ51gY1vvruoCUajMYZWLgkmCSxyYBTAYqqajWJSR4R+3VNA79N3O4Zt6EhCYrCaNF0ggcHgdiqRJHWwxyBZ1uD45mm6z/NaFs/O76KZssgmBvwGx3OVuyTJTS2GWn/iVOOVn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBQLXa6B; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-788598094c4so18957285a.0;
        Tue, 12 Mar 2024 14:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710279273; x=1710884073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GCudM8ZtMIW67UvoP6AuDrXeLE5sRAx6WLMUwr1J0BE=;
        b=NBQLXa6B2/uksXznlJmuZvLPXqYyGIrHA76G4zDsEtwJ//aIGZ5iSqOOX3SDemLdmk
         NJcaOVFqVtJBsB6bgS7LccWqzBYeNlW8ZnAItrgfQgIZCxktd0PBvh1xNfKyAVY6qwx5
         FtDGwdPMxbFRccLSytRefiAEzfbFlW8Q4nteSj2mRqYA/2Lui58Zm2jEFYtUfJv2vbx0
         oa4Jel3TAclSo2apzckvIwmqwreBbyb+rNeKzFo3/sUc4qtDlpyQg2qvTU33xur4aOJX
         M3XxlkIqoGh+FteNTm94bg9rKoVVds3glJlx/jeUuMxlvmXobLEXatSbzkYMsSllisck
         E4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710279273; x=1710884073;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GCudM8ZtMIW67UvoP6AuDrXeLE5sRAx6WLMUwr1J0BE=;
        b=A3RxGOyajktTC8T3A62YUakIhn8GAM1fCGP9wNZJhOWSGeBaRD1cuvmdcrN/JwFzqn
         /zaqmHOyDapY0MV4qw7Ck2+t2tUxeYLQ6vZFkkZPGirJzl3pLwRIVVp4VloBfBNsLapT
         SZnaLDqtV6vcqx8Q4xD+WAvjCNOPlWxJ6mBOOPKizCUKjP3P5OqtSf1oFyRKRaIfIb4b
         RasmQJxNGaxq/QiyVzPt/LMoTjaKRDzGjvDnyNU5dZcnMBLT5qAlLogRV14gOpEsWaVT
         tKJb1INQV2mjgaTHViVxRqTru+Zwdd9uc+fC158v590kevg4esI6vByQc9occLc6a8M9
         zkwg==
X-Forwarded-Encrypted: i=1; AJvYcCV9jRadppoI9mzgN+mxG8SoO22vuMm4l61S9x5U+Y7tdA9lRvmZTsDSKhpc7rMAKfUnTyIjkt0icFyFOXXr1KoV21dhaN1+szpMWsWStpdm6US3fhxVgKRIU7h+p+GwiBhb
X-Gm-Message-State: AOJu0YwDxkRdmBpOpyfljCXsv5S9tJQQ4fMd8APDipX/cAZpyiibixJM
	cgmVwnPsDU/2y1T13WW7S5RXpjsA+Ma7a8qXwVCjF9M8w9mOXZ45
X-Google-Smtp-Source: AGHT+IHXID+7gP2sUx4phBx3tc2k2/yc2yFFNeZTDEoMW36oB5Av/N49JY+JkO7hVi8AiTpMnfhXKQ==
X-Received: by 2002:a05:620a:a43:b0:788:6221:85c4 with SMTP id j3-20020a05620a0a4300b00788622185c4mr4498433qka.20.1710279273092;
        Tue, 12 Mar 2024 14:34:33 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id q6-20020a05620a0c8600b00787f42e6299sm4042468qki.113.2024.03.12.14.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 14:34:32 -0700 (PDT)
Message-ID: <c5f9c640-4c06-495e-9c7e-0c208b914fa7@gmail.com>
Date: Tue, 12 Mar 2024 14:34:29 -0700
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
To: Boqun Feng <boqun.feng@gmail.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, paulmck@kernel.org, mingo@kernel.org,
 tglx@linutronix.de, rcu@vger.kernel.org, joel@joelfernandes.org,
 neeraj.upadhyay@amd.com, urezki@gmail.com, qiang.zhang1211@gmail.com,
 frederic@kernel.org, bigeasy@linutronix.de, anna-maria@linutronix.de,
 chenzhongjin@huawei.com, yangjihong1@huawei.com, rostedt@goodmis.org
References: <ZetHwrCb0KXE0xFI@tardis>
 <4274be61-60bd-4e1e-9c16-26e6e5e06f65@gmail.com>
 <ZfDEIs63EBIYBJIC@boqun-archlinux>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <ZfDEIs63EBIYBJIC@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/24 14:07, Boqun Feng wrote:
> On Tue, Mar 12, 2024 at 01:32:03PM -0700, Florian Fainelli wrote:
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
>>
> 
> Could you share the config file and your kernel parameters? Also could
> you share the whole log? Thanks!

Here is the configuration file:

https://gist.github.com/ffainelli/f3fd38752a186cee0cb8719089c0b6b8

and here is a log where this fails:

https://gist.github.com/ffainelli/ed08a2b3e853f59343786ebd20364fc8
-- 
Florian


