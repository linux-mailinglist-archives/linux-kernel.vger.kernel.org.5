Return-Path: <linux-kernel+bounces-25273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA7082CC7F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 12:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575481C21ED5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 11:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F30F20DF7;
	Sat, 13 Jan 2024 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="f365jIRH";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="AlB2ouPt"
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E441EF01;
	Sat, 13 Jan 2024 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 4607A6017E;
	Sat, 13 Jan 2024 12:28:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1705145281; bh=VAj5AAwNUdpfXiWXey1DITL/aNNspA9xoYd9dFjINYY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f365jIRHkSwFpvv+rLnGy8Wtoqz8spdphy6C301DTtmY9NCAjib94hlhVpQXo3KP9
	 MzKjfTDiJCwEsLsHAaFWcwtnUBckbWYMndBmom8Y5UW3T6o3E6dCS6mF6cPKMfvPUU
	 7lfJdL/FDLHNI/WBRDlSVGbxHjRijljmM00vVfkRLUenCKYhyugOIlG4LO9mDyT148
	 Do7VQkxRAVGXqQG7E2WzXer/yMvDCZ+TlH/BVBpJQKdvgF95jJH/t7S/p1SWTz70XJ
	 CrTHncPIiqfO4iM9CKa8dHIQJtKAvUgwmeM2BN51ngrhP0TVRl3P7Yawp7EbBOpAQn
	 A+NmIUNZ88tsg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KW7atziFEnLU; Sat, 13 Jan 2024 12:27:58 +0100 (CET)
Received: from [192.168.178.20] (dh207-40-235.xnet.hr [88.207.40.235])
	by domac.alu.hr (Postfix) with ESMTPSA id 687EE6017C;
	Sat, 13 Jan 2024 12:27:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1705145278; bh=VAj5AAwNUdpfXiWXey1DITL/aNNspA9xoYd9dFjINYY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AlB2ouPtXFaDqYtrbvRdwFYaPD/4aVCF6w2b04gMCYBQIWxx/xRYyipA+V4gXF0qF
	 VDSJXq7VhbdQCIKgFtLAE7wVtWv+az3BqI/5/odkStKlhQJzI3+gBClph9cM35yB+E
	 eQWLqDLBb8DodzYWCI0/IZDV6cg/IJYVx17XrOmIV27AvSxLB+6aSO3UAk1H201auY
	 FdZrPzgC8Bqacr8+zKLL4p5I4Syij4gO61JUVDN3UDUCxNZdZq3vcmLmeUlk07alNv
	 dzPn5ulwJw75g2Kd4fbp9oBQ8MIi3Lfpw39IS6DovIpbYbg2huZxG7uefUIDvpGal9
	 y/RU3noqy59nQ==
Message-ID: <b83bf78d-5fb0-4069-a1bb-c6a946b7b23c@alu.unizg.hr>
Date: Sat, 13 Jan 2024 12:27:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PROBLEM] Very long .deb package build times for bindeb-pkg build
 target
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>,
 Mirsad Todorovac <mirsad.todorovac@alu.hr>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <c2adb439-0dea-4de1-996e-5a0caa5c729d@alu.unizg.hr>
 <ZaALOOhEdBP70lDH@bergen.fjasle.eu>
 <827b5e97-a436-47a7-a097-13657bcda948@alu.unizg.hr>
 <CAK7LNAToNP0hFvhzr_gYw6TXMxkJuCN4idWZvqmq3mSTNOHtSQ@mail.gmail.com>
Content-Language: en-US
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <CAK7LNAToNP0hFvhzr_gYw6TXMxkJuCN4idWZvqmq3mSTNOHtSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/13/24 06:40, Masahiro Yamada wrote:
> On Fri, Jan 12, 2024 at 7:48 AM Mirsad Todorovac
> <mirsad.todorovac@alu.unizg.hr> wrote:
>>
>> On 11. 01. 2024. 16:37, Nicolas Schier wrote:
>>> Hi Mirsad,
>>>
>>> On Thu 11 Jan 2024 13:22:39 GMT, Mirsad Todorovac wrote:
>>>> Hi,
>>>>
>>>> With this new release, it seems that Debian kernel build uses "xz" in single-
>>>> threaded mode:

Hi, Masahiro,

Thank you for your reply.

> New release of what?

Forgive me for not being precise. It was the new release of torvalds tree mainline
kernel 6.7+ (with merge commits up-to-date). I sort of mistakenly assumed that
I wrote it, but it was declared in some mail on LKML.

One environment was Ubuntu 23.10 Mantic Minotaur on the desktop at work.

The laptop also has Mantic Minotaur, but for some reason it spawns multithreaded
dpkg-deb when building packages, unlike desktop which spawned single-threaded "xz".

This is at least what the "top" displayed when turning on "H" (show threads).

On one system (upgraded 23.10 from 22.04 LTS) the same dpkg-deb shows as multi-threaded
dpkg-deb, while on the other it calls xz which didn't respect XT_OPT=-T0 (visible
from the copy+paste from top output).

I am perplexed myself.

>>>> Tasks: 484 total,   2 running, 481 sleeping,   0 stopped,   1 zombie
>>>> %Cpu(s):  2.5 us,  2.2 sy,  6.3 ni, 85.1 id,  2.3 wa,  0.0 hi,  1.7 si,  0.0 st
>>>> MiB Mem :  64128.3 total,    524.3 free,   5832.0 used,  58540.9 buff/cache
>>>> MiB Swap:  32760.0 total,  32758.7 free,      1.2 used.  58296.3 avail Mem
>>>>
>>>>      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
>>>> COMMAND
>>>>
>>>>   978084 marvin    30  10  112440  97792   2432 R 100.0   0.1  29:30.23 xz
>>>>
>>>>
>>>> Before dpkg-deb was using up to 3200% of CPU time on a 16 core SMT CPU.
>>>>
>>>> Can it be something with dpkg-deb --thread-max=%n option?
>>>
>>> I cannot find any --thread-max option in Linux tree.  Do you call
>>> dpkg-deb manually or somehow induce a thread maximum?
>>>
>>>> Waiting for half an hour just for the build of linux-image-...-dbg package
>>>> seems like an overkill ...
>>>
>>> With current v6.7 release tree I do not see the reported slow-downs
>>> when building bindeb-pkg; I tested by cross-compiling for arm64 on
>>> amd64 with CONFIG_MODULE_COMPRESS_XZ=y and =n).
>>>
>>> Both take roughly 5mins on my 24-core i9 system.
>>>
>>> Kind regards,
>>> Nicolas
>>
>> I am perplexed too, but you can see from the top output the
>> single-threaded xz with 29:30m processor time.
>>
>> On my laptop with the sam Ubuntu 23.10 mantic minotaur, I have
>> dpkg-deb version 1.20.12 and it shows things like 400% and 3200%
>> CPU time, so it is working multithreaded.
>>
>> On desktop machine with the same Ubuntu 23.10 and the same git
>> torvalds tree, it starts single-threaded xz from dpkg-deb instead.
> 
> You built the same mainline git tree on your laptop and desktop.
> The former runs xz multi-threaded, the latter single-threaded.
> 
> So, this is not about the kernel code, but about your environment,
> isn't it?

It should be. Somehow it doesn't behave rationally. To be true to the facts,
one is 23.10 Mantic Minotaur upgraded from 22.04 LTS, and the other is
fresh Mantic from install.

> You mentioned you were using Ubuntu 23.10, where
> dpkg-deb version is 1.22.0

This is correct.

> Your dpkg-deb version, 1.20.12, is too old for Ubuntu 23.10.
> Is it a self-built one?

Yes, it is the build from Debian 11 source package.

This had the similar rationale because Ubuntu version ran single-threaded.

dpkg-deb from Debian 11 source package worked well for months.

> dpkg-deb usually compresses binary packages, but the default
> compression type depends on the distro.
> (It is determined at "./configure" time)

I see. But the home-built dpkg-deb also resorted to running "xz", and
xz did not recognise XZ_OPT environment variable. Very odd. :-/

> On Ubuntu, the default compression type for dpkg-deb is "zstd"
> (while it is "xz" on Debian)
> 
> Check "man dpkg-deb" on your Ubuntu machine.
> 
>    -Zcompress‐type
>        Specify which compression type to use when building a package.
>        Allowed values are gzip, xz (since dpkg 1.15.6),
>        zstd (since dpkg 1.21.18) and none (default is zstd).

Verified. "man dpkg-deb" confirms that.

> You are still allowed to use xz with "make KDEB_COMPRESS=xz deb-pkg".
> Is this your case?

Somehow, my Mantic's "xz" did not react to the environment variables. Maybe it is
enchanted? :-/

> Overall, your report is not sensible.

> You should check what you are seeing.

I was seeing exactly what I copy+pasted (top output). Give me the benefit of doubt
that I did not falsify copy+paste. Ideally, I should have submitted JPG terminal
screenshot.

Home-built dpkg-deb worked well on Ubuntu 22.04 LTS and 23.10 (upgraded from 22.04).
So it was a surprise that it started showing quirks on this new box with fresh 23.10
from .iso.

But I am only 16 months in the Linux kernel development, so it is probably my fault.

I saw from the output of "ps xewww" that "xz" had "XZ_OPT=-T0", but it refused to obey
the environment variable.

This is probably worth digging and delving into to find the culprit, but eventually the
workaround was the script manually prepending "--threads=0" to the parameter list and
calling system xz:

	/usr/bin/xz --threads=0 "$@"

Certainly, I need to establish "normality" before building complex kernels and applying
patches or the results will be non-reproducible and useless.

I did the background search on your valuable contributions to the LK, but as we have this
problem with the vanilla installation of Ubuntu, maybe we can think of something to
optimise the LK build time?

To recall better from Thursday, I actually tried to prepend "XZ_OPT=--threads=0" to
system xz, and it worked. But when called from dpkg-deb, it suddenly got amnesia, despite
XZ_OPT=-T0 being seen in "ps xewww" output :-/

I believe there should be a rational explanation rather than black or red magic.

Thank you again for considering this problem report and have a nice weekend!

Best regards,
Mirsad Todorovac

>> I tried things like this:
>>
>> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
>> index d7dd0d04c70c..b2319c23db34 100755
>> --- a/scripts/package/builddeb
>> +++ b/scripts/package/builddeb
>> @@ -38,7 +38,7 @@ create_package() {
>>
>>          # Fix ownership and permissions
>>          if [ "$DEB_RULES_REQUIRES_ROOT" = "no" ]; then
>> -               dpkg_deb_opts="--root-owner-group"
>> +               dpkg_deb_opts="--threads-max=0 --root-owner-group"
>>          else
>>                  chown -R root:root "$pdir"
>>          fi
>>
>> and it didn't work either - dpkg-deb --threads-max=0 still spawned a
>> single-threaded xz that ran 30 minutes.
>>
>> Then the workaround was a very simple xz shell script that adds option --threads=0
>> and calls system xz:
>>
>> ~/bin/xz:
>> ----------------------------------------------------------------
>> #!/bin/bash -f
>>
>> /usr/bin/xz --threads=0 "$@"
>> ----------------------------------------------------------------
>>
>> This finally worked, but sometimes I get:
>>
>> marvin@defiant:~/linux/kernel$ xz -9 --memlimit-compress=8000MiB linux-image-6.7.0-rc8-dbg_6.7.0-rc8-6_amd64.deb
>> /usr/bin/xz: Reduced the number of threads from 8 to 6 to not exceed the memory usage limit of 8000 MiB
>>
>> (This is of course just an example of compressing a large file, as .deb is already compressed.)
>>
>> I used the default Ubuntu 23.10 config, with .pems excluded, and I think module compression
>> did not work either. I had to turn it off ...
>>
>> Hope this helps.
>>
>> Regards,
>> Mirsad
>>
>> --
>> Mirsad Goran Todorovac
>> Sistem inženjer
>> Grafički fakultet | Akademija likovnih umjetnosti
>> Sveučilište u Zagrebu
>>
>> System engineer
>> Faculty of Graphic Arts | Academy of Fine Arts
>> University of Zagreb, Republic of Croatia
>> The European Union
>>
>> "I see something approaching fast ... Will it be friends with me?"
>>
>>
> 
> 

