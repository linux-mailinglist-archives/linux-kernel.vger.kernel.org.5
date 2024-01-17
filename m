Return-Path: <linux-kernel+bounces-29356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF5B830D37
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C511F26AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE79249E0;
	Wed, 17 Jan 2024 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="k29gJPlG";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="OFeiNcGM"
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7912D24205;
	Wed, 17 Jan 2024 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705519089; cv=none; b=J6MIBgsLYd8RgB01ih9pIXgLTEOf5L4OBe6RqkiV/E0iV6gG/LshkoEjPhkojgo00zWfD8fowkISUh4s7svpXUuz+k10fqp5wZ5Twn/Ic9Ty0BTbINV4yoFNhZYYYn5BkC2TgTYviwfsY0hIE+AVGVq+F8kwPMNtADuvpgOdbd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705519089; c=relaxed/simple;
	bh=kKq/R7Slr9WQYBDkv/f7dUaLlvKEXcOV0LTrW9msMww=;
	h=Received:DKIM-Signature:X-Virus-Scanned:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=RkvafWRltmK/tHi2t+jrpH7Wg63Tl1k764r5rLUBQ1FH9fDt+tlktA1ielki+Yva+g3eIl1mJMFwCizVNZnXGJ2xQyR4KdK8cubn/J1yPyDgJL2QI/HrmFQa8veIueB/L7kbHknOxrsMfzSz0AdhUqqNen2D964txSkpoUyKwPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr; spf=pass smtp.mailfrom=alu.unizg.hr; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=k29gJPlG; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=OFeiNcGM; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 8522B601A1;
	Wed, 17 Jan 2024 20:18:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1705519081; bh=kKq/R7Slr9WQYBDkv/f7dUaLlvKEXcOV0LTrW9msMww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k29gJPlGCgA5aXPKggCKOTtD2n9wX1yfPrpIY60iGkuidibjyn/QogKYdyW87PDqc
	 ZN34sHXod4pbgljUj27OEwmSfK14QllwiUV1b1AKbE0AZcPZiT+3n7XZoo2DVn+UbU
	 EQK9QQlOHuA2TE8u5fvbfuG/8NF+iSdSLQ7mT4hALM3wpLAMsPd9lqycsDtH5TF/N8
	 uQ42sJ4KeFk0Q14IoTpJRja9hHifk8KMmTN4kjPdsERng0iHYU0Fm+UukDANJNTsfA
	 Moqv0QH5xaN6IGM2O3i7wPy1sEiFM23FW9Vg+4HWRL+5/VGNU03PHMNOduPmJBJGEU
	 f/p0TmClwJCqg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SeUNTzMCqVuQ; Wed, 17 Jan 2024 20:17:58 +0100 (CET)
Received: from [192.168.178.20] (dh207-40-167.xnet.hr [88.207.40.167])
	by domac.alu.hr (Postfix) with ESMTPSA id 0DC5A6019B;
	Wed, 17 Jan 2024 20:17:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1705519078; bh=kKq/R7Slr9WQYBDkv/f7dUaLlvKEXcOV0LTrW9msMww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OFeiNcGM+p0YmIjrUMsBODGEjMpEcwIAON/EGtmiXys58fQiKWB5uFxGL2d4twlWW
	 njqOhy/nvv+AtffooGBSnCeeBvBrFv0EIctDy2QnxNhoiS/Ura5IG4hQZvY3Co9ITu
	 fMTo5SKffmC0k3kTDpRzWQeKPd3hB0Js5d21cK9lqx7iCpZHpg1JAH6X91Bt4EYURr
	 Nz7qzielGTafsgeRVzGIWYbdlBKyyuUCF6WRXHezIxLtITnhiDJ46nLd7a6l3YsW1w
	 21yuGQdQfhDcFz9kamziGqF6a4gKkVRXxRMP0iXfbz7Djg96ymm7HCHR8RD3Rh/5n8
	 JG9vbGDEgwhRA==
Message-ID: <88ec168b-471a-4c0d-984d-d27cc96404fc@alu.unizg.hr>
Date: Wed, 17 Jan 2024 20:17:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PROBLEM] Very long .deb package build times for bindeb-pkg build
 target
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>,
 Mirsad Todorovac <mirsad.todorovac@alu.hr>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <c2adb439-0dea-4de1-996e-5a0caa5c729d@alu.unizg.hr>
 <ZaALOOhEdBP70lDH@bergen.fjasle.eu>
 <827b5e97-a436-47a7-a097-13657bcda948@alu.unizg.hr>
 <CAK7LNAToNP0hFvhzr_gYw6TXMxkJuCN4idWZvqmq3mSTNOHtSQ@mail.gmail.com>
 <b83bf78d-5fb0-4069-a1bb-c6a946b7b23c@alu.unizg.hr>
 <CAK7LNASCuuaO9tx44dbeS=deL-1Lvgy3REyC3FsVhfCmtWdB=w@mail.gmail.com>
 <b2acb406-11cb-4f5e-a924-e1f75a7f674c@alu.unizg.hr>
 <CAK7LNAR73NVGhE_UCwtsSfb6men=D9cy3t-8fPM-m1WaCogdqA@mail.gmail.com>
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <CAK7LNAR73NVGhE_UCwtsSfb6men=D9cy3t-8fPM-m1WaCogdqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/16/24 12:21, Masahiro Yamada wrote:
> On Sun, Jan 14, 2024 at 6:09 AM Mirsad Todorovac
> <mirsad.todorovac@alu.unizg.hr> wrote:
>>
>> On 1/13/24 16:16, Masahiro Yamada wrote:
>>> On Sat, Jan 13, 2024 at 8:28 PM Mirsad Todorovac
>>> <mirsad.todorovac@alu.unizg.hr> wrote:
>>>>
>>>> On 1/13/24 06:40, Masahiro Yamada wrote:
>>>>> On Fri, Jan 12, 2024 at 7:48 AM Mirsad Todorovac
>>>>> <mirsad.todorovac@alu.unizg.hr> wrote:
>>>>>>
>>>>>> On 11. 01. 2024. 16:37, Nicolas Schier wrote:
>>>>>>> Hi Mirsad,
>>>>>>>
>>>>>>> On Thu 11 Jan 2024 13:22:39 GMT, Mirsad Todorovac wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> With this new release, it seems that Debian kernel build uses "xz" in single-
>>>>>>>> threaded mode:
>>>>
>>>> Hi, Masahiro,
>>>>
>>>> Thank you for your reply.
>>>>
>>>>> New release of what?
>>>>
>>>> Forgive me for not being precise. It was the new release of torvalds tree mainline
>>>> kernel 6.7+ (with merge commits up-to-date). I sort of mistakenly assumed that
>>>> I wrote it, but it was declared in some mail on LKML.
>>>
>>> When you report a regression in the kernel code in the future,
>>> please try to do "git bisect" and pin-point an offending commit.
>>>
>>> That is more helpful to figure out how to fix the issue.
>>>
>>> And, you will be sure whether or not the root cause exists
>>> in the kernel.
>>
>> Good point. Thanks.
>>
>> But I did not notice any regression on Ubuntu 22.04 LTS system, and neither on
>> the Ubuntu 22.10 Mantic system which was upgraded. So I assumed it was not related to
>> particular commit, and I did not think of bisect.
>>
>>>> One environment was Ubuntu 23.10 Mantic Minotaur on the desktop at work.
>>>>
>>>> The laptop also has Mantic Minotaur, but for some reason it spawns multithreaded
>>>> dpkg-deb when building packages, unlike desktop which spawned single-threaded "xz".
>>>>
>>>> This is at least what the "top" displayed when turning on "H" (show threads).
>>>>
>>>> On one system (upgraded 23.10 from 22.04 LTS) the same dpkg-deb shows as multi-threaded
>>>> dpkg-deb, while on the other it calls xz which didn't respect XT_OPT=-T0 (visible
>>>> from the copy+paste from top output).
>>>>
>>>> I am perplexed myself.
>>>>
>>>>>>>> Tasks: 484 total,   2 running, 481 sleeping,   0 stopped,   1 zombie
>>>>>>>> %Cpu(s):  2.5 us,  2.2 sy,  6.3 ni, 85.1 id,  2.3 wa,  0.0 hi,  1.7 si,  0.0 st
>>>>>>>> MiB Mem :  64128.3 total,    524.3 free,   5832.0 used,  58540.9 buff/cache
>>>>>>>> MiB Swap:  32760.0 total,  32758.7 free,      1.2 used.  58296.3 avail Mem
>>>>>>>>
>>>>>>>>        PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
>>>>>>>> COMMAND
>>>>>>>>
>>>>>>>>     978084 marvin    30  10  112440  97792   2432 R 100.0   0.1  29:30.23 xz
>>>>>>>>
>>>>>>>>
>>>>>>>> Before dpkg-deb was using up to 3200% of CPU time on a 16 core SMT CPU.
>>>>>>>>
>>>>>>>> Can it be something with dpkg-deb --thread-max=%n option?
>>>>>>>
>>>>>>> I cannot find any --thread-max option in Linux tree.  Do you call
>>>>>>> dpkg-deb manually or somehow induce a thread maximum?
>>>>>>>
>>>>>>>> Waiting for half an hour just for the build of linux-image-...-dbg package
>>>>>>>> seems like an overkill ...
>>>>>>>
>>>>>>> With current v6.7 release tree I do not see the reported slow-downs
>>>>>>> when building bindeb-pkg; I tested by cross-compiling for arm64 on
>>>>>>> amd64 with CONFIG_MODULE_COMPRESS_XZ=y and =n).
>>>>>>>
>>>>>>> Both take roughly 5mins on my 24-core i9 system.
>>>>>>>
>>>>>>> Kind regards,
>>>>>>> Nicolas
>>>>>>
>>>>>> I am perplexed too, but you can see from the top output the
>>>>>> single-threaded xz with 29:30m processor time.
>>>>>>
>>>>>> On my laptop with the sam Ubuntu 23.10 mantic minotaur, I have
>>>>>> dpkg-deb version 1.20.12 and it shows things like 400% and 3200%
>>>>>> CPU time, so it is working multithreaded.
>>>>>>
>>>>>> On desktop machine with the same Ubuntu 23.10 and the same git
>>>>>> torvalds tree, it starts single-threaded xz from dpkg-deb instead.
>>>>>
>>>>> You built the same mainline git tree on your laptop and desktop.
>>>>> The former runs xz multi-threaded, the latter single-threaded.
>>>>>
>>>>> So, this is not about the kernel code, but about your environment,
>>>>> isn't it?
>>>>
>>>> It should be. Somehow it doesn't behave rationally. To be true to the facts,
>>>> one is 23.10 Mantic Minotaur upgraded from 22.04 LTS, and the other is
>>>> fresh Mantic from install.
>>>>
>>>>> You mentioned you were using Ubuntu 23.10, where
>>>>> dpkg-deb version is 1.22.0
>>>>
>>>> This is correct.
>>>>
>>>>> Your dpkg-deb version, 1.20.12, is too old for Ubuntu 23.10.
>>>>> Is it a self-built one?
>>>>
>>>> Yes, it is the build from Debian 11 source package.
>>>>
>>>> This had the similar rationale because Ubuntu version ran single-threaded.
>>>>
>>>> dpkg-deb from Debian 11 source package worked well for months.
>>>>
>>>>> dpkg-deb usually compresses binary packages, but the default
>>>>> compression type depends on the distro.
>>>>> (It is determined at "./configure" time)
>>>>
>>>> I see. But the home-built dpkg-deb also resorted to running "xz", and
>>>> xz did not recognise XZ_OPT environment variable. Very odd. :-/
>>>
>>> It depends on the environment whether or not dpkg-deb
>>> spawns the external 'xz' command.
>>>
>>> With WITH_LIBLZMA defined, dpkg-deb uses internal code
>>> to compress the data with xz.  [1]
>>>
>>> Without WITH_LIBLZMA, dpkg-deb sparns "xz" processes. [2]
>>>
>>> [1]: https://salsa.debian.org/dpkg-team/dpkg/-/blob/1.20.12/lib/dpkg/compress.c?ref_type=tags#L412
>>> [2]: https://salsa.debian.org/dpkg-team/dpkg/-/blob/1.20.12/lib/dpkg/compress.c?ref_type=tags#L663
>>>
>>> Since you said you saw "xz" in the "ps" command output,
>>> I believe your case is the latter.
>>
>> Thanks for your insight. It is obviously a compile-time define.
>>
>> In previous build the defaults were apparently different. The Debian defaulting to multi-threaded
>> dpkg-deb was the exact reason why I did the hand build in the first place.
>>
>> In the long run, it saved an awful lot of time.
>>
>> But I can't see the logic of enforcing the single-threaded "xz" from dpkg-deg :-/
>>
>>> When dpkg-deb swarns the external "xz" command,
>>> dpkg-deb unsets "XZ_OPT". [3]
>>>
>>> I believe that's why you do not see XZ_OPT propagated.
>>>
>>> [3]: https://salsa.debian.org/dpkg-team/dpkg/-/blob/1.20.12/lib/dpkg/compress.c?ref_type=tags#L643
>>
>> Your insight really casts light on this. Now it is very clear.
>>
>> But IMHO single-threaded 30-min xz compression on a 16-core or 32-SMT machine is kind of weird.
>> I wish there was something we could do about it.
>>
>> The same happened with the rpmbuild with similar defaults on Fedora. :-(
>>
>>>>> On Ubuntu, the default compression type for dpkg-deb is "zstd"
>>>>> (while it is "xz" on Debian)
>>>>>
>>>>> Check "man dpkg-deb" on your Ubuntu machine.
>>>>>
>>>>>      -Zcompress‐type
>>>>>          Specify which compression type to use when building a package.
>>>>>          Allowed values are gzip, xz (since dpkg 1.15.6),
>>>>>          zstd (since dpkg 1.21.18) and none (default is zstd).
>>>>
>>>> Verified. "man dpkg-deb" confirms that.
>>>>
>>>>> You are still allowed to use xz with "make KDEB_COMPRESS=xz deb-pkg".
>>>>> Is this your case?
>>>>
>>>> Somehow, my Mantic's "xz" did not react to the environment variables. Maybe it is
>>>> enchanted? :-/
>>>>> Overall, your report is not sensible.
>>>>
>>>>> You should check what you are seeing.
>>>>
>>>> I was seeing exactly what I copy+pasted (top output). Give me the benefit of doubt
>>>> that I did not falsify copy+paste. Ideally, I should have submitted JPG terminal
>>>> screenshot.
>>>>
>>>> Home-built dpkg-deb worked well on Ubuntu 22.04 LTS and 23.10 (upgraded from 22.04).
>>>> So it was a surprise that it started showing quirks on this new box with fresh 23.10
>>>> from .iso.
>>>>
>>>> But I am only 16 months in the Linux kernel development, so it is probably my fault.
>>>>
>>>> I saw from the output of "ps xewww" that "xz" had "XZ_OPT=-T0", but it refused to obey
>>>> the environment variable.
>>>>
>>>> This is probably worth digging and delving into to find the culprit, but eventually the
>>>> workaround was the script manually prepending "--threads=0" to the parameter list and
>>>> calling system xz:
>>>>
>>>>           /usr/bin/xz --threads=0 "$@"
>>>>
>>>> Certainly, I need to establish "normality" before building complex kernels and applying
>>>> patches or the results will be non-reproducible and useless.
>>>>
>>>> I did the background search on your valuable contributions to the LK, but as we have this
>>>> problem with the vanilla installation of Ubuntu, maybe we can think of something to
>>>> optimise the LK build time?
>>>
>>>
>>> I do not think so.
>>>
>>> There already exists a solution to control the number of threads.
>>>
>>> See "man dpkg-deb"
>>>
>>>      DPKG_DEB_THREADS_MAX
>>>          Sets the maximum number of threads allowed for compressors that
>>>          support multi‐threaded operations (since dpkg 1.21.9).
>>>
>>>          The --threads-max option overrides this value.
>>> By setting this env variable, you should be able to control the multi-threading.
>>>
>>>
>>> However, your dpkg-deb is 1.20.12, so you need to use a newer version.
>>>
>>> You locally hacked builddeb to add --threads-max, but it does not
>>> work for you for the same reason; it requires dpkg 1.21.9+
>>>
>>>     --threads-max=threads
>>>        Sets the maximum number of threads allowed for compressors that support
>>>        multi‐threaded operations (since dpkg 1.21.9).
>>>
>>> Why do you stick to the old home-built dpkg-deb?
>>>
>>> If you use the default dpkg-deb bundled with Ubuntu 23.10,
>>> you will have a better experience.
>>
>> Yes, but I did it because Ubuntu dpkg-deb was single-threaded by default. I did not
>> know so many kbuild options at the time ...
> 
> 
> 
> No.
> 
> The dpkg-deb on Ubuntu works multi-threaded by default.
> 
> Just try /usr/bin/dpkg-deb installed by APT, then
> you will see more than 100% CPU resources used.
> 
> 
> With proper library installed, "./configure" for dpkg
> should show:
> 
>    checking for lzma_stream_encoder_mt in -llzma... yes
> 
> 
> With HAVE_LZMA_MT_ENCODER defined, filter_xz_get_cputhreads()
> returns the number of threads to use.
> The default is the number of available CPU cores.
> 
> [1]: https://salsa.debian.org/dpkg-team/dpkg/-/blob/main/lib/dpkg/compress.c?ref_type=heads#L717

I think that 20.04 LTS or 18.04 LTS didn't by default (or I wouldn't have the need to
build a home-built dpkg-deb in the first place), and it was a big issue back then:

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=501456

[2] https://askubuntu.com/questions/841784/any-way-to-multithread-dpkg-deb

It was an issue back then already, but on a system with 6+ cores the difference is significant.
Of course, back then a 4-core/8-thread CPU was a rocket :-)

If I could only teleport this system back to 2000s and use it with those ideas 8-)

Best regards,
Mirsad

