Return-Path: <linux-kernel+bounces-109324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8FE881796
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C664D285047
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EBA85620;
	Wed, 20 Mar 2024 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="DY+5muLF";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="RiKRQU/J"
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC5085284;
	Wed, 20 Mar 2024 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710961091; cv=none; b=Jg3Ypif6wf3+cWiDu81C+7p2jzqchqMLJOVWyNuwqHsKVIzeEkbeKsGkXfvJ5esYXfsMYKMNm9JonkSMeDmfDtMYmf8Eb0q0T76c+szftxiTy8wROtaXrTq8zfyhNk/+4SU9dHu/AQNTrDPMlVo2y7HE35eY3yb3XUxKh4trT+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710961091; c=relaxed/simple;
	bh=cTN3MDWduNZ2VVH6OHDT0Y/oKmYN/zt5QKvqDfh2tgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efXN3rulYYbGtKPNqLjqSmyG7syThx5/CuvUyQIhRCTs+NdcjvxcDNkg2zWWePm3BOkDDFCrmmo9jWHBYTjMI/8TKqnGW316ug38zZIzXrIJ5QiCOZ6r0HDhAYivIjz0CizWR9FdMGNOG1I/qHpj9Dx7xM2Us0o6c/ekuNRHFuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr; spf=pass smtp.mailfrom=alu.unizg.hr; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=DY+5muLF; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=RiKRQU/J; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 5E3DE60177;
	Wed, 20 Mar 2024 19:58:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1710961081; bh=cTN3MDWduNZ2VVH6OHDT0Y/oKmYN/zt5QKvqDfh2tgk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DY+5muLFNrPwcksLBq7MWz5d1e/rcJ4qwHefTd1WzJK5/jfRoHtTP7pnBQTLff25L
	 EB1tiIYlZI/ZeVqRIYl/bxf4CobnAVouVGO0PteTqEuT4DTACxoirQ2eIcsi+m+A71
	 41x4K5nmiJB26Roba/+kJaHhauaYfldAB2AJpjO0Nj1U9vZ+zSEpbU8CbPRlsntk6J
	 Dq2zM7nUODtQ1apEPQdF8Wi1t//CYW7Z3oYkIqaRyCX9kKwjtdSzSqiF9wh8lF+edM
	 IrvqV3LP4dmMm+zyvUjO2cklxK7ucX5j+6vj9Vput7Yq1uKxUxXscn7AZfmsTh2dkN
	 Rld9TXENxq0Rw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MpvGs34--TU3; Wed, 20 Mar 2024 19:57:52 +0100 (CET)
Received: from [192.168.178.20] (dh207-43-75.xnet.hr [88.207.43.75])
	by domac.alu.hr (Postfix) with ESMTPSA id 769806015E;
	Wed, 20 Mar 2024 19:57:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1710961072; bh=cTN3MDWduNZ2VVH6OHDT0Y/oKmYN/zt5QKvqDfh2tgk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RiKRQU/JAwmyZpGYCdlRCJ7opfNiRahL08pQC7ORYlcFB2ifFBOaS6dB86vfCHcCl
	 vAKAvbyVs7WLR4JMv3MsXsz0FKnS982GjvyhW99Sy1+RDDpXZryKRDstvLzuJGcKoI
	 a+iwrrSmYt8rg0X3yxg5D1CQMUdHU1jjHbxmw78MsYlsGg0LY69YSfOE262qKVS55n
	 SY7hMkxK8+HsD/m3C6//XH5lqcWDTaOapNNey1Ti1wK6Hl7R8g6PQ5R4CWj/isKP9k
	 bbWiILDZ5t08pTq000Fg2CqHGJTMY+G8IF3MgXMiyWOhZWirCjgh53cehuc/prB05Y
	 9Ob/LvMqzl7MA==
Message-ID: <e0441a7a-b76f-42e7-8ad4-9ba00327c2ca@alu.unizg.hr>
Date: Wed, 20 Mar 2024 19:57:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] alsa: KMEMLEAK in pulseaudio and alsa-sink-ALC89
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-sound@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>,
 linux-kernel@vger.kernel.org
References: <c1e2ef3c-164f-4840-9b1c-f7ca07ca422a@alu.unizg.hr>
 <87wmpxto4g.wl-tiwai@suse.de>
Content-Language: en-US
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <87wmpxto4g.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/24 07:26, Takashi Iwai wrote:
> On Wed, 20 Mar 2024 02:13:08 +0100,
> Mirsad Todorovac wrote:
>>
>> Hi,
>>
>> On Ubuntu 22.04 LTS, with the torvalds tree kernel vanilla v6.8-11167-g4438a810f396,
>> there is like 660K memory leaks sized 2048 bytes (1.35 GB)
>>
>> unreferenced object 0xffff919c43c7c800 (size 2048):
>> unreferenced object 0xffff919c43c78000 (size 2048):
>> unreferenced object 0xffff919c43c79800 (size 2048):
>> root@defiant:/home/marvin/linux/kernel/linux_torvalds# grep size ~marvin/linux/kernel_bugs/v6.8-11167/kmemleak.log | wc -l
>> 663265
>> root@defiant:/home/marvin/linux/kernel/linux_torvalds#
>>
>> Please find the .config attached.
>>
>> The kmemleak output is:
>>
>> unreferenced object 0xffff9199526ba800 (size 2048):
>>    comm "pulseaudio", pid 2533, jiffies 4294900352
>>    hex dump (first 32 bytes):
>>      04 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
>>      49 45 43 39 35 38 20 50 6c 61 79 62 61 63 6b 20  IEC958 Playback
>>    backtrace (crc 87c1dcdc):
>>      [<ffffffffb2fa477b>] kmemleak_alloc+0x4b/0x90
>>      [<ffffffffb210e517>] __kmalloc_node_track_caller+0x3c7/0x530
>>      [<ffffffffb20a102b>] memdup_user+0x2b/0xb0
>>      [<ffffffffc0746d56>] snd_ctl_ioctl+0x726/0x860 [snd]
>>      [<ffffffffb21bed6d>] __x64_sys_ioctl+0x9d/0xe0
>>      [<ffffffffb2f93d33>] do_syscall_64+0x83/0x150
>>      [<ffffffffb3000121>] entry_SYSCALL_64_after_hwframe+0x6c/0x74
> 
> Thanks for the report.  This was indeed an overlooked marking of
> __free(kfree).  I'll submit the fix patch.
> 
> Takashi

Not at all, thanks for such an early response.

I understand the problems with the incremental development. Actually, great it was caught before
the release ;-)

Best regards,
Mirsad Todorovac

