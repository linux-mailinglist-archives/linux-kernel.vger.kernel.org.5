Return-Path: <linux-kernel+bounces-90077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6945A86F9EC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0402815F5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA94CA4A;
	Mon,  4 Mar 2024 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="DpT3jIfe"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CABBA5E;
	Mon,  4 Mar 2024 06:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709533012; cv=none; b=Jn4XSyb+9e923eu93nX7yKdzBTYLVYtIL0AE/QTdWWhnbr6zpy1C+726TKQTagRnqDc9YXgI0QagcZPGuQnUJ4o6vPcYh0Zw7q0vFoxNfrg4mOcKluRIoc/pVDlQvzVMrgmSSkCUpUUZAb0f899IFpI6Cf7x5Tk/5C7p7tpfmIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709533012; c=relaxed/simple;
	bh=vDEkHhbgoncuK1EhIkt+qBLzvO6pAGjxBO7E/Z8jvNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ef/yaCzT3pXQ3Ay+kK6c+s/N8u/NsCxor/dBeBcccAS01X4bVhvkZMO6/06Qg535BgcnkkjNP8sB1BYvIe8+6QvK5zhQKNBE5zrqqlc9nlOFf86oehAQIMqlDTNV6ZrRp2c4+ubo+PmdRLrfYXf+QRlevy+WJqbg2H3MBznuJMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=DpT3jIfe; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=BJJ1FnvZ+/hL3/GZOS7H0S2hO+1YoMgqTri63N9h0ZM=; t=1709533010;
	x=1709965010; b=DpT3jIfeeua4C8TkKdh93dK/4LNNN6yUumz3OfzpaoTb/V+v/Se2sZLRqjn80
	/NytuTIWzY/p+4vn0qEIF7xfkRyQxwyD7UStKAFzCaUEV541sJ/G6OpzWoyFpn/M13v7yqp2axyoh
	LMEtDGO9NVwZVcl+b1tcPOBnr/FbI6kUBhkCeyJWL+GvQ6Em7QdwLVNXYag1u3YeyRC+JRyUK6Ou8
	IcLEhLl8j+I+TzIDfaGLIAOxriT3tyw/dWCjPvapBfxmcuc8xgoCMmd5YEecWTJcXb0NLSDYaH/vb
	v+U+KinOQTMDBM/OfLgJm8G2fnDK5pfGhjjW2K1Vlk68IAretA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rh1cw-0002hs-9B; Mon, 04 Mar 2024 07:16:42 +0100
Message-ID: <e1d87d5c-97ee-4e08-84c9-61a02c81ca63@leemhuis.info>
Date: Mon, 4 Mar 2024 07:16:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: guide on bisecting (was Re: [REGRESSION] kexec does firmware
 reboot in kernel v6.7.6)
Content-Language: en-US, de-DE
To: Pavin Joseph <me@pavinjoseph.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com>
 <7ebb1c90-544d-4540-87c0-b18dea963004@leemhuis.info>
 <3a8453e8-03a3-462f-81a2-e9366466b990@pavinjoseph.com>
 <a84c1a5d-3a8a-4eea-9f66-0402c983ccbb@leemhuis.info>
 <806629e6-c228-4046-828a-68d397eb8dbc@pavinjoseph.com>
 <4630483e-fc4e-448d-8fd6-916d3422784e@leemhuis.info>
 <66019e35-5adb-4817-a64d-e379b6f4240a@pavinjoseph.com>
From: Thorsten Leemhuis <linux@leemhuis.info>
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
In-Reply-To: <66019e35-5adb-4817-a64d-e379b6f4240a@pavinjoseph.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1709533010;dcd7aaf7;
X-HE-SMSGID: 1rh1cw-0002hs-9B

On 03.03.24 11:17, Pavin Joseph wrote:
> On 3/3/24 14:06, Thorsten Leemhuis wrote:
> 
>> That being said: I think I might know what sent you sideways: the main
>> section lacked a "git remote add -t master stable
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git". :-((
> Now that I read through it with a fresh pair of eyes, this is exactly
> the problem!

Thx for confirming, fixed this up locally and will submit a patch to fix
this for inclusion (the text is now in -next, yeah!).

>>> 2. The "installkernel" command is called "kernel-install" in OpenSuse,
>>
>> Yeah, it looks like that, but that's not really the case. :-) In short:
>> on Fedora "installkernel" calls into kernel-install -- and
>> "installkernel" has a long history, so doing what Fedora does is likely
>> a wise thing for distros. And openSUSE had a "installkernel" as well,
>> which was part of the dracut package. Not sure if that is still the case
>> for current Leap and Tumbleweed. Could you check?
> 
> It's not available even as a symlink in OpenSuse TW / Slowroll I'm afraid.

I'm not really familiar with openSUSE, but it set up a TW container and
found that a package kernel-install-tools provides installkernel script.
Not sure how good it works though. Could you maybe test that?

>>> and it doesn't really perform all the steps to install kernel. It calls
>>> dracut to create initramfs though, but that's hardly much help.
>> Could you please elaborate a bit on that "hardly much help", as I'm not
>> really sure what you exactly mean here. Are you and/or openSUSE normally
>> not using dracut?
> I meant that calling kernel-install in OpenSuse only seems to then call
> dracut to build an initramfs for the kernel. I can call dracut myself
> without adding an unnecessary middleman (kernel-install) in the process
> and less verbosely too: dracut --kver $(make -s kernelrelease)

kernel-install is normally meant to copy the image over to /boot/ as
well afaik; maybe it did not do that in your case because you already
had placed it there manually?

> Perhaps you could add generic details such as I provided in the
> reference section for distros where installkernel doesn't exist or don't
> perform all the steps required.

Go look, they are there since the start. They differ from your
instructions though, as you put the image in /usr/lib/modules/ which
only works with distros that have kernel-install. Hmmm. Maybe it at some
point will likely be better to just use it for the manual install
instructions; but it feels a bit like it's to early for that. Not sure.

>>> 3. The dependencies for kernel building in OpenSuse and other major
>>> distros are incomplete,
>> So what was missing?
> Sorry, I don't remember.

I checked using a container and fixed this this.

> The compile/build threw some error and I looked
> up how to install kernel building dependencies in OpenSuse only to find
> out there was a pattern for it already.

I just checked, the command you provided earlier would download ~250
MByte of packages that would consume 1,5 GByte disk space, all of which
are unneeded afaics. I'm taken a bit back and forth there, but I think
sticking to just listing the packages that are actually needed might be
the better approach.

> Perhaps you could list the basic dependencies in the main section and
> provide the collection/patterns in the reference section.

I want to keep the main section distro-agnostic as much as possible;
listing package names for distros would also make it longer. I think
it's better to do that in the reference section.

>>> 4. The command to build RPM package (make binrpm-pkg) fails as the
>>> modules are installed into "/home/<user>/linux/.../lib" while depmod
>>> checks for modules in "/home/<user>/linux/.../usr/lib".
>> That sounds like a bug that should be reported and fixed, not something
>> that docs should catch and work around. Could you report that?
> Please, could you tell me where to report this bug? Kernel bugzilla?
> Which category/component?

Just sent a mail to Masahiro Yamada <masahiroy@kernel.org> with
linux-kbuild@vger.kernel.org and linux-kernel@vger.kernel.org in CC.

> Thanks for all your help 😉

Thx for your feedback, it helped making things better!

Ciao, Thorsten

