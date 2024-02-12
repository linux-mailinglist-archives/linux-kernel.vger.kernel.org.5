Return-Path: <linux-kernel+bounces-61745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B7585160C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9011C20E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631E83FB01;
	Mon, 12 Feb 2024 13:45:23 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E431B4F881;
	Mon, 12 Feb 2024 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745523; cv=none; b=TqBhCX8CeFFUeCweKxfXAQ5yssTt/xfJhXAiVobOrO8T2ApBBV6idsUsxnBi+K+EbhQyVkLmqSf+vry/b8e5LhfvJQciL6UdZJ0KoVATrCy0gxfO1TO9X2JUvhu257ed9EH/nVuqbU85+kF0dCgWNw8i/jyI2yQaPie2nM31Ek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745523; c=relaxed/simple;
	bh=xWGb8Cmbkd5btS6NzBDa8BLzh5ExnreyW6RfyI6vZUo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sMnbaPor1B1zoKIsLJ3nJYSLTUJIQj29R16FQ9amDHPfSfu6Pmbllmbf2bL71lof+J0WJEMV/Ra1t6v1wVaJ50tOOHlB7BL/DVEl/TUmAkg1A5PnbgY0WiHPSvx49Kiqkx1N43MNtJyF14/ytSQcvCdnnFurXp1WGUxe9fcrYCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rZWcM-0003L2-OM; Mon, 12 Feb 2024 14:45:06 +0100
Message-ID: <1354c5d5-99b7-4178-bcf5-9ddb776de946@leemhuis.info>
Date: Mon, 12 Feb 2024 14:45:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: huge_memory: don't force huge page alignment on 32
 bit
Content-Language: en-US, de-DE
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, surenb@google.com, riel@surriel.com,
 willy@infradead.org, cl@linux.com, akpm@linux-foundation.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 yang@os.amperecomputing.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
 Yang Shi <shy828301@gmail.com>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <20240118133504.2910955-1-shy828301@gmail.com>
 <ad920491-9d73-4512-8996-badace520699@leemhuis.info>
 <CAHbLzkp7s1CcSE0rc-CpfcCrNtMdepAA5-K+0P4wz11x4SK6=g@mail.gmail.com>
 <dc9f8eab-ec5c-46f1-a168-c510650d1cac@leemhuis.info>
In-Reply-To: <dc9f8eab-ec5c-46f1-a168-c510650d1cac@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707745521;4cb5780d;
X-HE-SMSGID: 1rZWcM-0003L2-OM

Hey Greg, is below mail still in your queue of linux-stable mails to
process? If so please apologize this interruption and just ignore this
mail. I just started to wonder if it might have fallen through the
cracks somehow, as I've seen you updating stable-queue.git for 6.7.y,
but it's still missing this patch (and the other one mentioned) --
that's why I decided to write this quick status inquiry.

Ciao, Thorsten

On 05.02.24 18:53, Linux regression tracking (Thorsten Leemhuis) wrote:
> [adding the stable team]
> 
> On 05.02.24 18:07, Yang Shi wrote:
>> On Sat, Feb 3, 2024 at 1:24 AM Thorsten Leemhuis
>> <regressions@leemhuis.info> wrote:
>>> On 18.01.24 14:35, Yang Shi wrote:
>>>>
>>>> The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
>>>> boundaries") caused two issues [1] [2] reported on 32 bit system or compat
>>>> userspace.
> [...]
>>> [FWIW, this is now 4ef9ad19e17676 ("mm: huge_memory: don't force huge
>>> page alignment on 32 bit") in mainline]
>>>
>>> Quick question: it it okay to ask Greg to pick this up for linux-6.7.y
>>> series?
>>
>> Yes, definitely. Thanks for following up.
> 
> In that case: Greg, could you please consider picking up 4ef9ad19e17676
> ("mm: huge_memory: don't force huge page alignment on 32 bit") for the
> next linux-6.7 rc round? tia!
> 
> Ohh, and btw: you might also want to pick up c4608d1bf7c653 ("mm: mmap:
> map MAP_STACK to VM_NOHUGEPAGE") if you haven't already done so: its
> stable tag contains a typo, hence I guess your scripts might have missed
> it (I only noticed that by chance).
> 
> Ciao, Thorsten

