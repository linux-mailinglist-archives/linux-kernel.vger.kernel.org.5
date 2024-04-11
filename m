Return-Path: <linux-kernel+bounces-139879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584AE8A08CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0B1286D03
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CB513D8B1;
	Thu, 11 Apr 2024 06:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="sPk8UsQ6"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B015D13CA96;
	Thu, 11 Apr 2024 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818226; cv=none; b=cKnwTB4KNy4r7WUZYDIMEiXih+Hi5sJ4d1/PeZTERuQ7eZwutz57fvWuu9ZiBVKfurDc7+u2zWj8xhmRu8jDQNbebkxvwxaVxttQF7R+XK9gEGxssdg2RDgmUUJUVybWRWbfqrFlOz/TQ4atAQY22WGPkJoMQgOjcx7i3MgEaeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818226; c=relaxed/simple;
	bh=q2+XwZPtgJk/cnCtVS6DCOGeMMLqluFAalwEIDJpYDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkC/nTkRDKgnFaLz3VnVY1PIHBPfLzIX9THxlYazJCcjOsjSxmonML4TkBRI0EFtCva7JqfWoMZCpEpfHtF4LBQ4vYziapiISrHHklw82dD0Kh3bFNaYECMCGLq/mg5sDKeBdlxEBHnEqkXs2XEqe44rGob5aLYpGlM4cwwh/QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=sPk8UsQ6; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=tLdNWOEuu1plRtAUEvZ9P8MGhy6W5VYiEYxAkdJQ2fs=; t=1712818223;
	x=1713250223; b=sPk8UsQ6NL3Dpmi/3/ovexiq4Nyl6RrW0E38FGBONmOBhiMgh2gvlevlnxppx
	LJ+w9zerRQDRf1piEsNtK34ZJrVLJbIfljlaGtTRc6zcXznHONIuvQbghORNk9oXjuvRyEsHSZH3F
	e5+4BFpEvhUU3yCpwMb6AQUF3bfzHThiZfXgzI3x6SqNPj7jsAiQeKLnx9CBBD5l7hh22lvQ+gSqo
	qYM+zacXlW1c4cssC5OG79g26i6yR7TwD4aYfVA9VHzQWcrSLyP1CeJO8YRWC0JM5aOrND6xwvGfE
	z1ObaUj53qAKUrDuP7jZ5LUzTFzJqoDER/OEZHdTwC5BM4Ku5Q==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1ruoGL-0007g7-5F; Thu, 11 Apr 2024 08:50:21 +0200
Message-ID: <898e813d-883c-4ccb-91ad-03aff40d59e3@leemhuis.info>
Date: Thu, 11 Apr 2024 08:50:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] docs: stable-kernel-rules: call mainline by its
 name and change example
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 stable@vger.kernel.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1712812895.git.linux@leemhuis.info>
 <ec5dff37a62681beb74f89f8fcde41b6618152f0.1712812895.git.linux@leemhuis.info>
 <2024041156-nintendo-paddling-eaad@gregkh>
 <963811ba-6c12-47d1-942e-ba7bcf93a766@leemhuis.info>
 <2024041127-attach-removed-f9f0@gregkh>
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
In-Reply-To: <2024041127-attach-removed-f9f0@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1712818223;0aff2cf4;
X-HE-SMSGID: 1ruoGL-0007g7-5F

On 11.04.24 08:10, Greg Kroah-Hartman wrote:
> On Thu, Apr 11, 2024 at 07:50:29AM +0200, Thorsten Leemhuis wrote:
>> On 11.04.24 07:30, Greg Kroah-Hartman wrote:
>>> On Thu, Apr 11, 2024 at 07:25:05AM +0200, Thorsten Leemhuis wrote:
>>>>  
>>>> -     Cc: <stable@vger.kernel.org> # after 4 weeks in mainline
>>>> +     Cc: <stable@vger.kernel.org> # after 6 weeks in a stable mainline release
>>>
>>> I do not know what "stable mainline release" means here, sorry.  "after
>>> 4 weeks in mainline" means "after in Linus's tree for 4 weeks, but
>>> Linus's tree is not "stable mainline".
>>
>> I meant a proper mainline release like 6.7 or 6.8 to make it obvious
>> that this does not mean a "pre-release".
>>
>> I actually had used the term "proper mainline release" earlier in a
>> draft, but a quick search on the net showed that this is not really used
>> out there. "stable mainline release" is not popular either, but seemed
>> to be a better match; I also considered "final mainline release", but
>> that felt odd.
>>
>> It feels like there must be some better term my mind just stumbles to
>> come up with. Please help. :-D
> 
> Well, what is the goal here?  Just put it in words, I have seen stuff
> like:
> 	Cc: <stable@vger.kernel.org> # wait until -rc3
> 	Cc: <stable@vger.kernel.org> # wait until 6.1 is released
> 	Cc: <stable@vger.kernel.org> # after -rc2
> 
> and so on.
> 
> Just pick a specific time/release might be better?  "after X weeks" is
> assuming that we all know and remember how many weeks something
> happened...

My reasoning was: a developer that submits a patch has no full control
over when the patch mainlined -- and plans sometimes change, too.

So a patch that was meant to go into 6.1-rc with a tag like "# wait
until 4 weeks after 6.1 is released" might only be mainlined for 6.2-rc1
-- and then the tag does not express the developers intention.

But that might be a corner case that we could ignore. So maybe "# wait
until 4 weeks after 6.1 is released" is the better example (from what
I've heard something like that is what developer would like to have
sometimes).

Ciao, Thorsten

