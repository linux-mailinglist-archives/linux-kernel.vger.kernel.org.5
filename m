Return-Path: <linux-kernel+bounces-24114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67F182B746
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89BEBB24EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EE912B91;
	Thu, 11 Jan 2024 22:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="ltn0zYor";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="v/Yo4/Tq"
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE499FC00;
	Thu, 11 Jan 2024 22:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 4E8E860177;
	Thu, 11 Jan 2024 23:48:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1705013325; bh=qKaLIRe/RzTMot/L/E2o5Sb+DNHeKA/1yQyu6L7Oezk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ltn0zYorjAEC9hR9r5zjFEdeZSEqcML3dH9nyEfSkLQhsNcif7gKtw3AsDabq9ju3
	 02BcRNXZefQXE6ZJ/Ipr3kPeWtqYhRa+rgES42BhrLDlcXmQ6P8/GukQ3qyMUoRvnt
	 nNQJFgl5ner/cvySJmAV6oaHvAI0deBpHsK35Bzn0M9KQ2UBfwmUKVIM9GYg14M2wY
	 V7b3VPHk0xks5Ft8SBc088oOA0jAMqbYUC48VHq3EQHdwjNZoRQGyGrkByaOF20825
	 8WoemeR5LdBgxBdNFUtAFOXGoVBP7tA5VbGe4KJUEFjyEDfHJSnVeGfVjMbwRDHZdG
	 6ACAzPPYp9Y9g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uDNchp7RRn6r; Thu, 11 Jan 2024 23:48:43 +0100 (CET)
Received: from [192.168.239.51] (unknown [95.168.107.47])
	by domac.alu.hr (Postfix) with ESMTPSA id 0817360171;
	Thu, 11 Jan 2024 23:48:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1705013323; bh=qKaLIRe/RzTMot/L/E2o5Sb+DNHeKA/1yQyu6L7Oezk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=v/Yo4/Tq9iVfWwHIDf1xYUeNIuOhP59JXsodoEER5HI/wauJn9Faw/SxF4+bfSU/X
	 uLBre9nUaXrPHtk70QpSfeumFoNjgNgJEZbb0bgsdzUk2NV08YOaYEg0LC0cRfK3lO
	 ZqeP5W6kLYZs4ula9pFQqewSn1EqKcTpendTzFG6qwLDrxED4JSOZdq4jjbER2xuGT
	 HqEpfp4zUOGO05mNgWyIpQezBccV5iZQhmXabgJ/5dYlAfGBdiLcoSOpfx1GVqJj0+
	 I+UCx+5aePbjfmuAcW9Hlsx+1UXr0Xf1erV8LkeMfyIsZeqjR8Q0646+LclzIo28Ap
	 WULgye48c8Y9A==
Message-ID: <827b5e97-a436-47a7-a097-13657bcda948@alu.unizg.hr>
Date: Thu, 11 Jan 2024 23:48:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PROBLEM] Very long .deb package build times for bindeb-pkg build
 target
To: Nicolas Schier <nicolas@fjasle.eu>,
 Mirsad Todorovac <mirsad.todorovac@alu.hr>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c2adb439-0dea-4de1-996e-5a0caa5c729d@alu.unizg.hr>
 <ZaALOOhEdBP70lDH@bergen.fjasle.eu>
Content-Language: en-US, hr
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZaALOOhEdBP70lDH@bergen.fjasle.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11. 01. 2024. 16:37, Nicolas Schier wrote:
> Hi Mirsad,
> 
> On Thu 11 Jan 2024 13:22:39 GMT, Mirsad Todorovac wrote:
>> Hi,
>>
>> With this new release, it seems that Debian kernel build uses "xz" in single-
>> threaded mode:
>>
>> Tasks: 484 total,   2 running, 481 sleeping,   0 stopped,   1 zombie
>> %Cpu(s):  2.5 us,  2.2 sy,  6.3 ni, 85.1 id,  2.3 wa,  0.0 hi,  1.7 si,  0.0 st
>> MiB Mem :  64128.3 total,    524.3 free,   5832.0 used,  58540.9 buff/cache
>> MiB Swap:  32760.0 total,  32758.7 free,      1.2 used.  58296.3 avail Mem
>>
>>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
>> COMMAND
>>
>>  978084 marvin    30  10  112440  97792   2432 R 100.0   0.1  29:30.23 xz
>>
>>
>> Before dpkg-deb was using up to 3200% of CPU time on a 16 core SMT CPU.
>>
>> Can it be something with dpkg-deb --thread-max=%n option?
> 
> I cannot find any --thread-max option in Linux tree.  Do you call 
> dpkg-deb manually or somehow induce a thread maximum?
>  
>> Waiting for half an hour just for the build of linux-image-...-dbg package
>> seems like an overkill ...
> 
> With current v6.7 release tree I do not see the reported slow-downs 
> when building bindeb-pkg; I tested by cross-compiling for arm64 on 
> amd64 with CONFIG_MODULE_COMPRESS_XZ=y and =n).
> 
> Both take roughly 5mins on my 24-core i9 system.
> 
> Kind regards,
> Nicolas

I am perplexed too, but you can see from the top output the
single-threaded xz with 29:30m processor time.

On my laptop with the sam Ubuntu 23.10 mantic minotaur, I have
dpkg-deb version 1.20.12 and it shows things like 400% and 3200%
CPU time, so it is working multithreaded.

On desktop machine with the same Ubuntu 23.10 and the same git
torvalds tree, it starts single-threaded xz from dpkg-deb instead.

I tried things like this:

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index d7dd0d04c70c..b2319c23db34 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -38,7 +38,7 @@ create_package() {
 
        # Fix ownership and permissions
        if [ "$DEB_RULES_REQUIRES_ROOT" = "no" ]; then
-               dpkg_deb_opts="--root-owner-group"
+               dpkg_deb_opts="--threads-max=0 --root-owner-group"
        else
                chown -R root:root "$pdir"
        fi

and it didn't work either - dpkg-deb --threads-max=0 still spawned a
single-threaded xz that ran 30 minutes.

Then the workaround was a very simple xz shell script that adds option --threads=0 
and calls system xz:

~/bin/xz:
----------------------------------------------------------------
#!/bin/bash -f

/usr/bin/xz --threads=0 "$@"
----------------------------------------------------------------

This finally worked, but sometimes I get:

marvin@defiant:~/linux/kernel$ xz -9 --memlimit-compress=8000MiB linux-image-6.7.0-rc8-dbg_6.7.0-rc8-6_amd64.deb
/usr/bin/xz: Reduced the number of threads from 8 to 6 to not exceed the memory usage limit of 8000 MiB

(This is of course just an example of compressing a large file, as .deb is already compressed.)

I used the default Ubuntu 23.10 config, with .pems excluded, and I think module compression
did not work either. I had to turn it off ...

Hope this helps.

Regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"


