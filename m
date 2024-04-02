Return-Path: <linux-kernel+bounces-128111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079DA895644
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CB8284295
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE5886134;
	Tue,  2 Apr 2024 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="JVs4qOJy"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2C085C52;
	Tue,  2 Apr 2024 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066983; cv=none; b=ZyQJaUJuaSAAxQxBiUB1nAu15uAtozxCFO4j47iC2aBx5sDcvQFlzZJwd4IQlcNz4SYDdMICGSIWTAOCSj3kiuLjJDUcW+7jRkj+QxA8YrZhCajPGEG4dFpgZiSRT6Gvqjpb7Rq5QKMk3y0uZTuY4Y26uUhtcQZehsoPZHuWPSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066983; c=relaxed/simple;
	bh=o9zg2EYP3VfME7dTRKvMGNy5dt/wZYuKnQ/u1Qb2bmk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=G6oMmAXaU5icwT8kNA6UC9jLLd9MGLHkESlQ6FJwdp+pouWkXVJvACOtK6/hveEO8dDh0VV1KeG2ILSP4yy6y5GbEBazXSRi207hGO8gKxhuOYczk7T0eebfpApgGEK9ZN7hgIbYwvy236ZO3aXWwAUGJSD9K8dXeOpzS2gPfT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=JVs4qOJy; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Reply-To:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=dqvRXQEZOjC607wRxzYnb2l3bFAM7p6fyF69p9Uu1wc=;
	t=1712066981; x=1712498981; b=JVs4qOJy8tPoEAVSmdzq2Z0buwo32F0KEq5zLrZIYJuBtUM
	OwMTxoakhZe3ffuk2KlmfM616EBQjySd3Sbbx4LurafhcTqtwzYji4aC/xKBeA9vay825pLscAXK6
	Frxc4IcR/PNel4mrcnHCy8Zy6NwQSlTZhI2GRhmO/EKoQLdoEsuLJQFVQ2fj988NjdYQcD2/UaTXk
	KhDE2ZMAzEvqYK/uN+UpO5PH+ywF1nOCoJxf6/GeZRhol1JD+7+4YgsKTjhKwNNx4S/hr/2pmD4lB
	A8zQTrdgAeE9yEdofNAaaYAyxLIgaeHEHnP4K0JIbtfCGf0cjNJtjoRmYV3qo12A==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rreN7-0002lq-56; Tue, 02 Apr 2024 15:40:17 +0200
Message-ID: <72e39571-7122-4f6a-9252-83e663e4b703@leemhuis.info>
Date: Tue, 2 Apr 2024 15:40:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] u64_stats: fix u64_stats_init() for lockdep when used
 repeatedly in one file
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>,
 Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>, stable@kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev <netdev@vger.kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <20240306111157.29327-1-petr@tesarici.cz>
 <20240311182516.1e2eebd8@meshulam.tesarici.cz>
 <CANn89iKQpSaF5KG5=dT_o=WBeZtCiLcN768eUdYvUew-dLbKaA@mail.gmail.com>
 <20240311192118.31cfc1fb@meshulam.tesarici.cz>
 <764f2b10-9791-4861-9bef-7160fdb8f3ae@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <764f2b10-9791-4861-9bef-7160fdb8f3ae@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712066981;5f967a66;
X-HE-SMSGID: 1rreN7-0002lq-56

Hi. Top-posting for once, to make this easily accessible to everyone.

Hmmm, looks like Petr's patch for a (minor) 6.8 regression didn't make
any progress in the past two weeks.

Does nobody care? Did nobody merge it because no tree feels really
appropriate? Or am I missing something obvious and making a fool out of
myself by asking these questions? :D

Ciao, Thorsten

#regzbot ignore-activity

On 18.03.24 15:23, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 11.03.24 19:21, Petr Tesařík wrote:
>> On Mon, 11 Mar 2024 18:43:59 +0100
>> Eric Dumazet <edumazet@google.com> wrote:
>>> On Mon, Mar 11, 2024 at 6:25 PM Petr Tesařík <petr@tesarici.cz> wrote:
>>>> On Wed,  6 Mar 2024 12:11:57 +0100
>>>> Petr Tesarik <petr@tesarici.cz> wrote:
>>>>  
>>>>> Fix bogus lockdep warnings if multiple u64_stats_sync variables are
>>>>> initialized in the same file.
>>>>>
>>>>> With CONFIG_LOCKDEP, seqcount_init() is a macro which declares:
>>>>>
>>>>>       static struct lock_class_key __key;
>>>>>
>>>>> Since u64_stats_init() is a function (albeit an inline one), all calls
>>>>> within the same file end up using the same instance, effectively treating
>>>>> them all as a single lock-class.  
>>>> What happens with this fix now?
>>>>
>>>> IIUC it should be reviewed by Eric, but I don't know through which tree
>>>> it should be merged. Any plans yet?  
>>>
>>> I thought I gave a reply, but apparently not .
>>>
>>> Reviewed-by: Eric Dumazet <edumazet@google.com>
>>
>> Thank you!
> 
> Great. Just wondering, as there afaics was no activity since about one
> week: what is the plan forward here?
> 
> Is the "through which tree it should be merged" question still
> unresolved? I quickly looked and it seems two of the last tree changes
> to that file over the past years went through net-next (the other one
> through the tip tree). That's why I CCed the other two net maintainers
> and the net list now.
> 
> Or is the plan to merge this after the merge window? Or only merge it
> for 6.10, as it are bogus lockdep warnings that are being fixed?
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> #regzbot poke
> 
> 

