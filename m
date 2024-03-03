Return-Path: <linux-kernel+bounces-89677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 502B586F410
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 09:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9FCE1F21630
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 08:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27454AD27;
	Sun,  3 Mar 2024 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="cE6hGJqS"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C0D945A;
	Sun,  3 Mar 2024 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709454994; cv=none; b=R40ZfILG4gsJRoAhhq3YZZuEpq/XMuQBmnJG8S7CdEJtqHxiins4dYc8ojPEMyhWT1mAROQAnBnRhAADX2gVRZDmI7ANF+kyx95vaicIaCuk/82Kn10gRol2Ph0nfJ16GCNg4N+43SiedKSXY8lEI8PDxIZko32FyOXrpi15Zc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709454994; c=relaxed/simple;
	bh=ac+iYkX+pJIVhLYKgVMXOn4lNfEMWAC3K/ZEnnFyR5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pf7TS4HovkRG5K7ISNE81ZgvGTNQwbUwVBMJnIk8BN+rHN54PMlU4E5MGQdxBBtR/8clmQEPZgyIFVJUDIzX+mzIQXT9P5+LF7YUCEvKWaugkHCyZAAKhgB9q/vAYSVhZN+YBp7oxuwv4lssHLoNmq1/BGr6kFYOKWc3Uix168c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=cE6hGJqS; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=iALt9c6+s5+9Kb6Prmt/Axjj0j1jgisKNMhcnOfI//8=; t=1709454991;
	x=1709886991; b=cE6hGJqS7G6fS/LPYSfriJuW8/OUuv7zXLcyF2RSQvBT12bbL3JQeAtJdqjjw
	p1a2TKS1CEOMIbzi13kh/EDa52jPmhj92EY31Gx50HeS8p2YPYQRT8COpZKXJdzWmoCR6+H9D29zo
	hQ51mAqLcBvh5iaK9SH5uLWoC4ooFSzR4DmJx2z9quK4rPhifIUDLKJyweB84wkL9m4UZnGwPFWD9
	cSY5F0PqIig2QY0oOthTbagzy0NsCTlrRwSaFkzg/I6TrqJaMbE60d47Gm2wS5U+miisBhd8fB8jE
	RYDcqlZocfPCESpPH61saPh1rBN/IVGjlrJ4bXF+SQ7JbgP3ag==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rghKf-0005bM-Az; Sun, 03 Mar 2024 09:36:29 +0100
Message-ID: <4630483e-fc4e-448d-8fd6-916d3422784e@leemhuis.info>
Date: Sun, 3 Mar 2024 09:36:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: guide on bisecting (was Re: [REGRESSION] kexec does firmware reboot
 in kernel v6.7.6)
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
In-Reply-To: <806629e6-c228-4046-828a-68d397eb8dbc@pavinjoseph.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1709454991;2858e555;
X-HE-SMSGID: 1rghKf-0005bM-Az

[dropping Steve, Dave and the stable list from CC while adding LKML and
linux-docs]

On 02.03.24 17:10, Pavin Joseph wrote:
> 
> On 3/2/24 20:47, Linux regression tracking (Thorsten Leemhuis) wrote>
> Thx for testing and glad to hear. Still: if you have any feedback how to
>> make that guide even better, please let me know!
> Yes, I have some improvements in mind.

Many thx for the suggestion!

> 1. The git clone/fetch instructions in the TLDR is easy to follow, but
> there are conflicting information later on in the main section and
> reference that taken together does not work.
>
> I think it would be better to not perform shallow clones

Hmmm. Either something sent you sideways or I'm missing something, as
the main section does not use a shallow clone. It did in earlier
versions. Wondering if something was left behind I missed.

That being said: I think I might know what sent you sideways: the main
section lacked a "git remote add -t master stable
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git". :-((

> or such advanced topics could be relegated
> to its own reference section.

They are. But I'm wondering if the "this is a alternative way" aspect
was obvious enough. That's why I slightly changed that part of the
reference section in my local copy. It now looks like this:

"""

Download the sources using git
------------------------------

  *Retrieve the Linux mainline sources.*
  [:ref:`...<sources_bissbs>`]

The step-by-step guide outlines how to retrieve the Linux sources using
a full Git clone of Linus' mainline repository. There is nothing more to
say about that -- but there are two alternatives ways to retrieve the
sources that might be more suitable for your situation:

 * If you have an unreliable internet connection, you might want to use
   a 'Git bundle' to retrieve the sources.

 * If downloading the complete repository would take too long or
   requires too much storage space, consider using a shallow clone.

Downloading Linux mainline using a bundle
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Switch to you home directory and  [...]
"""

> Here's what I ended up using:
> [...]

That's round about the same as the main section, but as I said, that
"git remote add -t master stable
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git" was
missing.

> 2. The "installkernel" command is called "kernel-install" in OpenSuse,

Yeah, it looks like that, but that's not really the case. :-) In short:
on Fedora "installkernel" calls into kernel-install -- and
"installkernel" has a long history, so doing what Fedora does is likely
a wise thing for distros. And openSUSE had a "installkernel" as well,
which was part of the dracut package. Not sure if that is still the case
for current Leap and Tumbleweed. Could you check?

> and it doesn't really perform all the steps to install kernel. It calls
> dracut to create initramfs though, but that's hardly much help.

Could you please elaborate a bit on that "hardly much help", as I'm not
really sure what you exactly mean here. Are you and/or openSUSE normally
not using dracut?

> I ended up doing: [...]

Good to know, but I don't really want to add that to the guide for all
the major distros, as then things likely get messy quickly. This IMHO
better should be dealt with on the distro level, as some distros show
that calling into installkernel can make everything work.

> 3. The dependencies for kernel building in OpenSuse and other major
> distros are incomplete,

So what was missing?

> most of them have some form of package
> collection that can be provided as an alternative.

Which sometimes also install stuff that is not needed. I'm willing to
switch, but you must give me good reasons.

And in my experience doing something what is done for Fedora is likely
the best, as the name of the executable hardly change, while
"collections" come and go and sometimes change names.

But as I said, I'm not totally against switching.

> [...]
> 4. The command to build RPM package (make binrpm-pkg) fails as the
> modules are installed into "/home/<user>/linux/.../lib" while depmod
> checks for modules in "/home/<user>/linux/.../usr/lib".

That sounds like a bug that should be reported and fixed, not something
that docs should catch and work around. Could you report that?

> I think that's it, turned out not to be a gist after all. 🙂

Again, thx for the feedback, this is really helpful.

> Thank you very much for writing the updated guide, it was very helpful
> without which I don't think it would have been possible for someone like
> me to find/report this bug.

Glad to hear, as that was the goal.

Ciao, Thorsten

