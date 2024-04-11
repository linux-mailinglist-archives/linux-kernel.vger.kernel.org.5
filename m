Return-Path: <linux-kernel+bounces-140210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E5F8A0CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234C91F23021
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E7D145B13;
	Thu, 11 Apr 2024 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="IMKmZnr3"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D71422C4;
	Thu, 11 Apr 2024 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829431; cv=none; b=eyjjzs0wx0VQrhoCwCE0sSsJHU/2AvPHyc0lCxmYIjEdkRIqQHml6OCT3o+Wf2sbrGVi/NXqTQaHB9t8AWpWhKmDfhV4W9Y5wH1uJFUlT9jzG1XeQ4ex1TCNHHxx9Cx7B/s8FzfgRHTsBnKf63AtXN/XbtzfeKKpf3HHi9XSafY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829431; c=relaxed/simple;
	bh=RHao9Q0Dtu7glt67ZlrYAVmmzIbn6E1k86RKjOSV4vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0PGKHN3YOMvl9a9NSwYWY73cdYtI3XiB7mSoPR2VUpBxTkOgG7rl0id80ohOIcAOMrgy+6Io7gy5ultrxdi7Wcnf/d0zEtlzpbX6WBbuiLKBr/2LxwsGAvycp+cv9WiD9mi2r5eJ9dkr6ZFaiyGatHuKAzr0yBkZuLMuQihC0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=IMKmZnr3; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=t7qL7aJGOqaqNnVv4GA8xpy6I1wQ48IdjiCl+sVigII=; t=1712829428;
	x=1713261428; b=IMKmZnr3c8cQpxdBvhHH3N1Bp9fijZ2XjjwEEnT1LXOtwRuO1mEuv74fHOQ5s
	scVNeElrVwHOMgGxkKp/EvW8UURYktOxG+sce7RheEh4fgFghD4/+lJ2YR5fjNf1SJ/GxvdjXXTNo
	NtidKT4YBh5G9I15rVVbye/3bn+q1AW7Lug3d/w7P/TpI/VYI3pRy8tPJcb7JQyu5YRYkz361/0Si
	uOE8KQ9SihYbat6p8XOJxtBCqpkNnKIyjGYgt7HUxUdWmN5os3RVES6jdzyyDkP+9G9jg/3BNsCO3
	Bylu+g4t+hFMdUQqeBzMVdm/qNYtAYmRZEO3C/yRivfE6mgvKw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rurB2-0002xh-QZ; Thu, 11 Apr 2024 11:57:04 +0200
Message-ID: <c7e5a7b5-837c-4ad5-91b9-1abaa245cc15@leemhuis.info>
Date: Thu, 11 Apr 2024 11:57:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] docs: stable-kernel-rules: mention "no
 semi-automatic backport"
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 stable@vger.kernel.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1712812895.git.linux@leemhuis.info>
 <c0a08b160b286e8c98549eedb37404c6e784cf8a.1712812895.git.linux@leemhuis.info>
 <2024041156-backache-dolly-a420@gregkh>
 <3f395eca-fc24-469b-b5fc-de47ab2a6861@leemhuis.info>
 <2024041123-earthling-primarily-4656@gregkh>
 <dad33d1c-77da-4b97-a0ec-4bf566f8d861@leemhuis.info>
 <2024041159-undone-deacon-3170@gregkh>
 <CAMuHMdXMRJM1xQLHDc6yKWvs97W2iTZnYnNNZE=8-WrtnGRNfw@mail.gmail.com>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 xsFNBFJ4AQ0BEADCz16x4kl/YGBegAsYXJMjFRi3QOr2YMmcNuu1fdsi3XnM+xMRaukWby47
 JcsZYLDKRHTQ/Lalw9L1HI3NRwK+9ayjg31wFdekgsuPbu4x5RGDIfyNpd378Upa8SUmvHik
 apCnzsxPTEE4Z2KUxBIwTvg+snEjgZ03EIQEi5cKmnlaUynNqv3xaGstx5jMCEnR2X54rH8j
 QPvo2l5/79Po58f6DhxV2RrOrOjQIQcPZ6kUqwLi6EQOi92NS9Uy6jbZcrMqPIRqJZ/tTKIR
 OLWsEjNrc3PMcve+NmORiEgLFclN8kHbPl1tLo4M5jN9xmsa0OZv3M0katqW8kC1hzR7mhz+
 Rv4MgnbkPDDO086HjQBlS6Zzo49fQB2JErs5nZ0mwkqlETu6emhxneAMcc67+ZtTeUj54K2y
 Iu8kk6ghaUAfgMqkdIzeSfhO8eURMhvwzSpsqhUs7pIj4u0TPN8OFAvxE/3adoUwMaB+/plk
 sNe9RsHHPV+7LGADZ6OzOWWftk34QLTVTcz02bGyxLNIkhY+vIJpZWX9UrfGdHSiyYThHCIy
 /dLz95b9EG+1tbCIyNynr9TjIOmtLOk7ssB3kL3XQGgmdQ+rJ3zckJUQapLKP2YfBi+8P1iP
 rKkYtbWk0u/FmCbxcBA31KqXQZoR4cd1PJ1PDCe7/DxeoYMVuwARAQABzSdUaG9yc3RlbiBM
 ZWVtaHVpcyA8bGludXhAbGVlbWh1aXMuaW5mbz7CwZQEEwEKAD4CGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AWIQSoq8a+lZZX4oPULXVytubvTFg9LQUCX31PIwUJFmtPkwAKCRBytubv
 TFg9LWsyD/4t3g4i2YVp8RoKAcOut0AZ7/uLSqlm8Jcbb+LeeuzjY9T3mQ4ZX8cybc1jRlsL
 JMYL8GD3a53/+bXCDdk2HhQKUwBJ9PUDbfWa2E/pnqeJeX6naLn1LtMJ78G9gPeG81dX5Yq+
 g/2bLXyWefpejlaefaM0GviCt00kG4R/mJJpHPKIPxPbOPY2REzWPoHXJpi7vTOA2R8HrFg/
 QJbnA25W55DzoxlRb/nGZYG4iQ+2Eplkweq3s3tN88MxzNpsxZp475RmzgcmQpUtKND7Pw+8
 zTDPmEzkHcUChMEmrhgWc2OCuAu3/ezsw7RnWV0k9Pl5AGROaDqvARUtopQ3yEDAdV6eil2z
 TvbrokZQca2808v2rYO3TtvtRMtmW/M/yyR233G/JSNos4lODkCwd16GKjERYj+sJsW4/hoZ
 RQiJQBxjnYr+p26JEvghLE1BMnTK24i88Oo8v+AngR6JBxwH7wFuEIIuLCB9Aagb+TKsf+0c
 HbQaHZj+wSY5FwgKi6psJxvMxpRpLqPsgl+awFPHARktdPtMzSa+kWMhXC4rJahBC5eEjNmP
 i23DaFWm8BE9LNjdG8Yl5hl7Zx0mwtnQas7+z6XymGuhNXCOevXVEqm1E42fptYMNiANmrpA
 OKRF+BHOreakveezlpOz8OtUhsew9b/BsAHXBCEEOuuUg87BTQRSeAENARAAzu/3satWzly6
 +Lqi5dTFS9+hKvFMtdRb/vW4o9CQsMqL2BJGoE4uXvy3cancvcyodzTXCUxbesNP779JqeHy
 s7WkF2mtLVX2lnyXSUBm/ONwasuK7KLz8qusseUssvjJPDdw8mRLAWvjcsYsZ0qgIU6kBbvY
 ckUWkbJj/0kuQCmmulRMcaQRrRYrk7ZdUOjaYmjKR+UJHljxLgeregyiXulRJxCphP5migoy
 ioa1eset8iF9fhb+YWY16X1I3TnucVCiXixzxwn3uwiVGg28n+vdfZ5lackCOj6iK4+lfzld
 z4NfIXK+8/R1wD9yOj1rr3OsjDqOaugoMxgEFOiwhQDiJlRKVaDbfmC1G5N1YfQIn90znEYc
 M7+Sp8Rc5RUgN5yfuwyicifIJQCtiWgjF8ttcIEuKg0TmGb6HQHAtGaBXKyXGQulD1CmBHIW
 zg7bGge5R66hdbq1BiMX5Qdk/o3Sr2OLCrxWhqMdreJFLzboEc0S13BCxVglnPqdv5sd7veb
 0az5LGS6zyVTdTbuPUu4C1ZbstPbuCBwSwe3ERpvpmdIzHtIK4G9iGIR3Seo0oWOzQvkFn8m
 2k6H2/Delz9IcHEefSe5u0GjIA18bZEt7R2k8CMZ84vpyWOchgwXK2DNXAOzq4zwV8W4TiYi
 FiIVXfSj185vCpuE7j0ugp0AEQEAAcLBfAQYAQoAJgIbDBYhBKirxr6Vllfig9QtdXK25u9M
 WD0tBQJffU8wBQkWa0+jAAoJEHK25u9MWD0tv+0P/A47x8r+hekpuF2KvPpGi3M6rFpdPfeO
 RpIGkjQWk5M+oF0YH3vtb0+92J7LKfJwv7GIy2PZO2svVnIeCOvXzEM/7G1n5zmNMYGZkSyf
 x9dnNCjNl10CmuTYud7zsd3cXDku0T+Ow5Dhnk6l4bbJSYzFEbz3B8zMZGrs9EhqNzTLTZ8S
 Mznmtkxcbb3f/o5SW9NhH60mQ23bB3bBbX1wUQAmMjaDQ/Nt5oHWHN0/6wLyF4lStBGCKN9a
 TLp6E3100BuTCUCrQf9F3kB7BC92VHvobqYmvLTCTcbxFS4JNuT+ZyV+xR5JiV+2g2HwhxWW
 uC88BtriqL4atyvtuybQT+56IiiU2gszQ+oxR/1Aq+VZHdUeC6lijFiQblqV6EjenJu+pR9A
 7EElGPPmYdO1WQbBrmuOrFuO6wQrbo0TbUiaxYWyoM9cA7v7eFyaxgwXBSWKbo/bcAAViqLW
 ysaCIZqWxrlhHWWmJMvowVMkB92uPVkxs5IMhSxHS4c2PfZ6D5kvrs3URvIc6zyOrgIaHNzR
 8AF4PXWPAuZu1oaG/XKwzMqN/Y/AoxWrCFZNHE27E1RrMhDgmyzIzWQTffJsVPDMQqDfLBhV
 ic3b8Yec+Kn+ExIF5IuLfHkUgIUs83kDGGbV+wM8NtlGmCXmatyavUwNCXMsuI24HPl7gV2h n7RI
In-Reply-To: <CAMuHMdXMRJM1xQLHDc6yKWvs97W2iTZnYnNNZE=8-WrtnGRNfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1712829428;13aba6df;
X-HE-SMSGID: 1rurB2-0002xh-QZ

On 11.04.24 11:19, Geert Uytterhoeven wrote:
> On Thu, Apr 11, 2024 at 11:13 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Thu, Apr 11, 2024 at 09:50:24AM +0200, Thorsten Leemhuis wrote:
>>> On 11.04.24 09:40, Greg Kroah-Hartman wrote:
>>>> On Thu, Apr 11, 2024 at 08:59:39AM +0200, Thorsten Leemhuis wrote:
>>>>> On 11.04.24 07:29, Greg Kroah-Hartman wrote:
>>>>>> On Thu, Apr 11, 2024 at 07:25:04AM +0200, Thorsten Leemhuis wrote:
>>>>>>> Some developers deliberately steer clear of 'Fixes:' tags to prevent
>>>>>>> changes from being backported semi-automatically by the stable team.
>>>>>>> That somewhat undermines the reason for the existence of the Fixes: tag,
>>>>>>> hence point out there is an alternative to reach the same effect.
>>>> [...]
>>>>>> I do not understand, why are you saying "cc: stable" here if you do NOT
>>>>>> want it backported?
>>>>> Because the only alternative the developers have to make the stable team
>>>>> not pick a single patch[1] is to deliberately omit a Fixes: tag even if
>>>>> the patch normally should have one. Like it was done here:
>>>>> https://lore.kernel.org/all/cover.1712226175.git.antony.antony@secunet.com/
>>>> That feels odd, but ok I now see the need for this for some minor set of
>>>> changes (i.e. this has rarely come up in the past 15+ years)
>>>>
>>>> [...]
>>>>> E.g. 'ignore for the AUTOSEL and the "Fixes tag only" tools'. That was
>>>>> the best term I came up with.
>>>>
>>>> Thinking about it more, I think we need to be much more explicit, and
>>>> provide the reason why.
>>>>
>>>> How about:
>>>>     cc: <do-not-apply-to-stable@kernel.org> # Reason goes here, and must be present
>>>>
>>>> and we can make that address be routed to /dev/null just like
>>>> <stable@kernel.org> is?
>>>
>>> Totally fine with me, but that feels somewhat long and hard to type.
>>
>> I want it long and hard to type and very very explicit that this is what
>> the developer/maintainer wants to have happen (again, because this is
>> such a rare occurrence.)
>>
>>> How
>>> about just 'no-stable@kernel.org' (or 'nostable@kernel.org')?
>>
>> More words are better :)
> 
> And after that, someone discovers this turns out to be (a hard
> dependency for) a very critical fix that does need backporting?

Ask why the tag was set I guess. But yeah, that was among the minor
reasons why I had come up with "no semiautomatic stable backport" thing,
as it made the intention more clear. Maybe

only-manual-stable-backport@kernel.org

could help and is even longer. But I might be getting into bikeshedding
territory here. :-D

Ciao, Thorsten


Cioao, Thorsten

