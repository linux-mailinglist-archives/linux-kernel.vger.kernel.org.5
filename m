Return-Path: <linux-kernel+bounces-100765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2450879CEE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2F30B236EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1230142913;
	Tue, 12 Mar 2024 20:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnP4nshB"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DB41428E2;
	Tue, 12 Mar 2024 20:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275527; cv=none; b=d/D1RUo1lmOyVLphIH+Ln1zd5cJdK0XGeGI33EbNtM1n8bcdu/yCl5tHYx9lGz4CgC3GHxPjJP/q5Ju1jdVSnkvgFvMzmgLD2leqyCxYwHk/Lwj8oK63aVm+LlC9kcyuSBQQoJNMquAHkKST1eGzAmwFW2vs7Ar3Kuaeht1jNS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275527; c=relaxed/simple;
	bh=raE7cbSZ+aK5qQqmG3T6uUi1EiTHkbjMLmCGIxVBOaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pCf37Bs/L1N9UIHzbqDAkDZqNOhAytlq2jL2LoXsHpL3tGpbBory8mnpc2Wvqf7WrvL7e4/4oIBZid0HTU8mmlc2afV7vfUkvqtY8F+51gT0Lk6+aii/+x2L+qPRkTtcfBcXfQIPq731ZoVSeZLWfdprR8lkA+AUnWzJs0GHtF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnP4nshB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e5d7f1f25fso3028680b3a.0;
        Tue, 12 Mar 2024 13:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710275526; x=1710880326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08ZYUVSJOvfsxERQ4dacpJ9wSXtJkXFFIViIlrgIPXE=;
        b=MnP4nshBCedadwKYQImIV0RZsL9+PFJkBvt7Yj574Wi/GNvxOpuTzh8cTQ8rBbk9xg
         yxygwUTeK+EktjqRedQ40q/rG5jQWjmXN4ujo+kS1EpxyhA0ZAF+NEEUGF4CtN1pRfhW
         7gpiVi02DT4WlLAVTLV3rjbfWq5eohlY+EqnVEUzYYO9WTPZSXdF2HvBu4wKQdJK+haa
         sB/O1PWBoTuSxZkv9lv3Zs7NEhvn/XAbS5DHvxKxFq8DjTTOuTq6o1HCaWwbbufeWuTJ
         U7bjYB5G09Hi1sFjEp12znRfKyq+mJy3sFfGR5hR7j4XJUpNzLTFXlRe0Sv3+czRcgHc
         uwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710275526; x=1710880326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08ZYUVSJOvfsxERQ4dacpJ9wSXtJkXFFIViIlrgIPXE=;
        b=MP0AnRpf3V866goFDLfnBwcHaMjh+v6A7KyILT+mIcBj38k7kKB9S5rxEMEGM6vd1/
         8qnEOHGQORV7DE30bMMKdMLTttfKQeWGZfhX2VlLmJA25W8hKaezdOOXhRlezsSnvtUc
         6U5Z29dByGpDIZRBdF+ZN1+mLqcMiO5Ax5fN+ILLcNi3wx/YR+gDZdSZWPdIGHJSJRVf
         MoIRDVMgsi9GSkI6vZ25pUd8iU5BcfeW6VxJ+ESKBi5J7kw58UNA3bzy3bvn99KZhJc0
         U0K7YJ1Fa+LI0KFHYWDrbAswGQ+HfDOK2zefXOIR0uDRXjx4xqJev6db/4IpkV+sbj0K
         6i3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4ejL0ZiOIoIEWjn3iasdjx03yzQzPla2f5ZWQ6KxcQVLnBV6B/81a/R8YUKrnr+Ng2hQJT8xyhH6Fwc0sSO36e73P
X-Gm-Message-State: AOJu0Yyx9GF4WPSbNHHi4Y0fQmj/f9oSPG9tPdZRiYaTwHLDbZxklhSW
	eOxx3w+NOuqALGPPSl2t1xppxUGSYnRGi2u4kvh8N63bEpqGX7mh
X-Google-Smtp-Source: AGHT+IGiEwfqUObXGeYTAiw1X1fOJ/rDoWSE6qISpBhLjM2lnHSxaj6nddxfuMv9YHYr36S2VFjpIA==
X-Received: by 2002:a05:6a20:2d11:b0:1a1:6cbd:e113 with SMTP id g17-20020a056a202d1100b001a16cbde113mr10629533pzl.54.1710275525565;
        Tue, 12 Mar 2024 13:32:05 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id q66-20020a17090a17c800b0029bb1631819sm818187pja.0.2024.03.12.13.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 13:32:05 -0700 (PDT)
Message-ID: <4274be61-60bd-4e1e-9c16-26e6e5e06f65@gmail.com>
Date: Tue, 12 Mar 2024 13:32:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes for
 v6.9]
Content-Language: en-US
To: Boqun Feng <boqun.feng@gmail.com>, torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org,
 mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org,
 joel@joelfernandes.org, neeraj.upadhyay@amd.com, urezki@gmail.com,
 qiang.zhang1211@gmail.com, frederic@kernel.org, bigeasy@linutronix.de,
 anna-maria@linutronix.de, chenzhongjin@huawei.com, yangjihong1@huawei.com,
 rostedt@goodmis.org
References: <ZetHwrCb0KXE0xFI@tardis>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <ZetHwrCb0KXE0xFI@tardis>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Boqun,

On 3/8/24 09:15, Boqun Feng wrote:
> Hi Linus,
> 
> Please pull this for the RCU changes of v6.9:
> 
> The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:
> 
>    Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git tags/rcu.next.v6.9
> 
> for you to fetch changes up to 3add00be5fe5810d7aa5ec3af8b6a245ef33144b:
> 
>    Merge branches 'rcu-doc.2024.02.14a', 'rcu-nocb.2024.02.14a', 'rcu-exp.2024.02.14a', 'rcu-tasks.2024.02.26a' and 'rcu-misc.2024.02.14a' into rcu.2024.02.26a (2024-02-26 17:37:25 -0800)
> 
> 
> Two merge conflicts were detected by linux-next:
> 
> * https://lore.kernel.org/lkml/20240226135745.12ac854d@canb.auug.org.au/
> * https://lore.kernel.org/lkml/20240227125522.2bdbe6be@canb.auug.org.au/
> 
> These conflict resolutions from linux-next look good to me, plus I made
> my own resolutions at branch merge/rcu.2024.02.27a for your reference.
> 
> 
> Some highlights of the changes:
> 
> * Eliminates deadlocks involving do_exit() and RCU tasks, by Paul:
>    Instead of SRCU read side critical sections, now a percpu list is used
>    in do_exit() for scaning yet-to-exit tasks.
> 
> * Fixes a deadlock due to the dependency between workqueue and RCU
>    expedited grace period, reported by Anna-Maria Behnsen and Thomas
>    Gleixner and fixed by Frederic: Now RCU expedited always uses its own
>    kthread worker instead of a workqueue.

At least one device in my test farm (ARM 32-bit) has consistently shown 
a very long boot, and some others are intermittently affected. This 
consistently looks like this on most of my devices:

[    2.450351] bcmgenet f0480000.ethernet: GENET 5.0 EPHY: 0x0000
[    2.547562] ata1: SATA link down (SStatus 0 SControl 300)
[  162.107264] unimac-mdio unimac-mdio.0: Broadcom UniMAC MDIO bus

this gets flagged by my boot script as a boot failure since we exceeded 
the 30 seconds timeout given to boot a kernel to a prompt.

It has been somewhat difficult to get a reliable bisection going on, but 
what I am sure of is that e5a3878c947ceef7b6ab68fdc093f3848059842c~1 
does not expose the problem for 10 consecutive boots, while I *might* 
see it at e5a3878c947ceef7b6ab68fdc093f3848059842c and beyond.

Any clues what is going on here?

Thanks!
-- 
Florian


