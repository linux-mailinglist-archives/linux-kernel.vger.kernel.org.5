Return-Path: <linux-kernel+bounces-160138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363A88B39B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6EF1C222E2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139A1148823;
	Fri, 26 Apr 2024 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="zaDX0v68"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7A242A99;
	Fri, 26 Apr 2024 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141254; cv=none; b=YfsbBoTNYtOVUfMaIzNtR1a8yXrWwLs8WI8bcxCUjE5BMOvByg1vJfo9VCya84xWZMQ5ASzZNdAaU4b/gOkajq5jHMSgnznlv9Dn679AGfaofeR1WjyriZGTO0QY4AMmIAzHURyxpbXwE/V5eHABYA/5A8G4n9C4wTpQJyIsCVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141254; c=relaxed/simple;
	bh=8jkgyD/xNuucw7rvhnzLJRKIcu6wFztv0aRmrlnfUZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJR1qmUXRwLH3xkvOXba1JNJjP8YvnCU1RH3doT0HaTNIgcv8pLAFQ9pQrnR1FXc1tzwLseHw2ghx0HfQ5hI8LyPAmk4n0YDJFnYv0RcaF6IT64Z3nAgrAh2UFL8lncmHQuqmJo2ANhBGLoIfK02X/VgqPLhRJn32FAlNIaOuWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=zaDX0v68; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=9rYvBQe6TsxDQQVkhjWduuSGKAR6ii1CCvqbJyEHClQ=;
	t=1714141252; x=1714573252; b=zaDX0v684QVpHQf9YAydL3ucIOmg3RGAirYZQYYZ9qAmwy2
	AmNKIO+BF97Kpwc3suVX4vfw1Frk4utWAf931N8o3FTL6xaQXXJXuj/1etLXMY8mKcUVqC+QSK2Ju
	uY0RHVIv6lDxnP6zLfLQoKDdeb20m8oD9xyAuGnnrY7RWxkS3B8EJ0+0fDwKtiI+rdmMF/97R/Pxq
	4ZRxCvwajFkGrHsUwxUT8vXM6iE3rxHCvXDXi4p1n4FLbOAxGtJUd6n0/B24cuT2TqgJvDKT1ScwX
	HJRJuUtTq5Ypgseba+M5ckRtMASaVERpjaPmapu51Bp5yqGeJ7rtZojvieNb+8DA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s0MRT-0006Bh-4R; Fri, 26 Apr 2024 16:20:47 +0200
Message-ID: <94db60bf-c3f4-4217-a900-9c3eba29e180@leemhuis.info>
Date: Fri, 26 Apr 2024 16:20:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH] Revert "vmgenid: emit uevent when
 VMGENID updates"
To: Alexander Graf <graf@amazon.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lennart Poettering <mzxreary@0pointer.de>, Babis Chalios
 <bchalios@amazon.es>, Theodore Ts'o <tytso@mit.edu>,
 "Cali, Marco" <xmarcalx@amazon.co.uk>, Arnd Bergmann <arnd@arndb.de>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 Christian Brauner <brauner@kernel.org>, regressions@lists.linux.dev,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org
References: <20240418114814.24601-1-Jason@zx2c4.com>
 <e09ce9fd-14cb-47aa-a22d-d295e466fbb4@amazon.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Language: en-US, de-DE
In-Reply-To: <e09ce9fd-14cb-47aa-a22d-d295e466fbb4@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1714141252;18255fd5;
X-HE-SMSGID: 1s0MRT-0006Bh-4R

On 22.04.24 09:51, Alexander Graf wrote:
> [Adding CC list of original patch plus regression tracker]
> 
> On 18.04.24 13:48, Jason A. Donenfeld wrote:
>> This reverts commit ad6bcdad2b6724e113f191a12f859a9e8456b26d. I had
>> nak'd it, and Greg said on the thread that it links that he wasn't going
>> to take it either, especially since it's not his code or his tree, but
>> then, seemingly accidentally, it got pushed up some months later, in
>> what looks like a mistake, with no further discussion in the linked
>> thread. So revert it, since it's clearly not intended.
> 
> Reverting this patch creates a user space visible regression compared to
> v6.8.

A theoretical one? Sure! But did any machines actually used in
production break? From my understanding of Linus approach to the "no
regression" rule this is what matters most here.

And even if that was the case: It afaics also matters that the commit
was just in proper releases for a short time frame. Linus thus might
consider the whole situation along the lines of "we really did screw up
here and to fix it we are bending the 'no regressions' rule slightly;
sorry". Things like that iirc have happened in the past, but I might
misremember here.

Linus, if I got you wrong there, please speak up. But right now I'm
inclined to not handle this as a regression and drop it from the tracking.

Ciao, Thorsten

> Please treat it as such.
>
> I'm slightly confused to see you passionate about this patch after you
> ghosted the conversation you referenced:
> 
> 
> https://lore.kernel.org/lkml/00d6172f-e291-4e96-9d3e-63ee8e60d556@amazon.com/
> 
> The purpose of this uevent is to notify systemd[1][2] (or similar) that
> a VM clone event happened, so it can for example regenerate MAC
> addresses if it generated them on boot, regenerate its unique machine id
> or simply force rerequest a new DHCP lease.
> 
> I don't understand how there's any correlation or dependency to
> vgetrandom() or anything RNG in this and why getting vgetrandom() merged
> upstream is even something to talk about in the same line as this patch
> [3].
> 
> We had a lengthy, constructive conversation with Ted at LPC last year
> about the "PRNG and clone" use case and concluded that it's best for
> everyone to simply assume the system could be cloned at any point, hence
> always force intermix of RDRAND or comparable to any PRNG output. We
> since no longer need an event for that case.
> 
> 
> Alex
> 
> [1] https://github.com/systemd/systemd/issues/26380
> [2] https://lore.kernel.org/lkml/ZJGNREN4tLzQXOJr@gardel-login/
> [3]
> https://lore.kernel.org/lkml/CAHmME9pxc-nO_xa=4+1CnvbnuefbRTJHxM7n817c_TPeoxzu_g@mail.gmail.com/
> 
> #regzbot introduced: 3aadf100f93d8081
> 
>>
>> Fixes: ad6bcdad2b67 ("vmgenid: emit uevent when VMGENID updates")
>> Cc: stable@vger.kernel.org
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Link: https://lore.kernel.org/r/20230531095119.11202-2-bchalios@amazon.es
>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>> ---
>>   drivers/virt/vmgenid.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
>> index b67a28da4702..a1c467a0e9f7 100644
>> --- a/drivers/virt/vmgenid.c
>> +++ b/drivers/virt/vmgenid.c
>> @@ -68,7 +68,6 @@ static int vmgenid_add(struct acpi_device *device)
>>   static void vmgenid_notify(struct acpi_device *device, u32 event)
>>   {
>>       struct vmgenid_state *state = acpi_driver_data(device);
>> -    char *envp[] = { "NEW_VMGENID=1", NULL };
>>       u8 old_id[VMGENID_SIZE];
>>         memcpy(old_id, state->this_id, sizeof(old_id));
>> @@ -76,7 +75,6 @@ static void vmgenid_notify(struct acpi_device
>> *device, u32 event)
>>       if (!memcmp(old_id, state->this_id, sizeof(old_id)))
>>           return;
>>       add_vmfork_randomness(state->this_id, sizeof(state->this_id));
>> -    kobject_uevent_env(&device->dev.kobj, KOBJ_CHANGE, envp);
>>   }
>>     static const struct acpi_device_id vmgenid_ids[] = {
> 
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 

