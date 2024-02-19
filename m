Return-Path: <linux-kernel+bounces-71230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B3285A23C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3498B25E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92112C6B9;
	Mon, 19 Feb 2024 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIIEmoKR"
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487F32C6B2;
	Mon, 19 Feb 2024 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342883; cv=none; b=an6Zh10oD8/kpieSSP2dv7kJXGXpgh9ZvvNmUlXE3m25rcj37su24HzdYzJgMtpvl1y/ZopGYGWyI2uGpw2opXkKt7/er1J4wcMrsJOQ9iphLa6NXb6CL46b9iHkuqf33VHcBCirmLbNafP/HmnEGrjJ6ZfrLXIP09t896icJ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342883; c=relaxed/simple;
	bh=GarlTur4+PHKD6pyM7B394O7WrFcuzDDaSRQcnIMS2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hdwA1yXaFE4g1YjtkH5bn9vFo+YyZAPJA0B/ujllpYRFchkwiyk7RG76xN0t3Q5ZvlPG4eTijYvn705HOioAlSgr/8Fi3QMo3/Z6zupfYOeQjW9hWuFf90JN53uVa9+2p2I1ojRPxY8bxqEUpdYgt9kyPv5NvKLXImQQEaPxYAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIIEmoKR; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so3483059a12.1;
        Mon, 19 Feb 2024 03:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708342881; x=1708947681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DseBf/8i17+ETW7/Dma7xksfJzr0mR0ZxNxdl75ecBo=;
        b=IIIEmoKRP1oBzFqaOPPp2A1ZcMN7T9hl1wJJQCwA9ENdaA5xmSwxAeLQ5l1ZwcSaDs
         reGuTc2sFoveVcUVlN3qj2WTxF2QFawO0dtoe/ss2aHttg5hJsLlLTE/VDkvWz/V86uR
         laAwqt3Osa0gid4JQTKaESZljZXedu2LgiiVxpIHlwF5oYvVwE3hpT+K3cOi6hGjS8HK
         crcFDvv997tUyf91lErpcceDzhYdDv7a4/m/bWWxGW6jK45MyWp6qW80vwDsDweUeHzq
         QsFvCCVQR2JFPkP8xAfsNU5fiYlznilUy4KS9SkTiCi7UCuA6ridGB3bed/HFVouMY3u
         zZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708342881; x=1708947681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DseBf/8i17+ETW7/Dma7xksfJzr0mR0ZxNxdl75ecBo=;
        b=egJaNwhZmFRtl9vCNQDxIcpCVYahl13aco9RJvZVaCEAcvT5uC9Yrlssi4Ve8HmKdo
         ROM0UepdJU/wJuccKQ5LUtrGYD0FYXcAFEXFofV1SlkBuxqmgeCzd7wlq5P6mrRQfy/1
         oYspWGNwJ1EylSQer0hrsI93ykedDB2VvGq+E+y0xHg83xw+rURGwwWoQ/GkhmWfPb3/
         9GmcaByumr7GrzDz6pyCWHvgodNz46WmAXBruSHcUtEOK5KcX4B62ILSGMKQJyabX7fH
         rBIvfr1Wz7PpH5MxAEHnKRBQIuMTYKOAHGrcnZnEF+mieVnjfKw5mnxZXIAi4kYIIQNQ
         1ZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHgf2gb5E1f+FA5/ujIva6po5UpB7vrRKWDHMmfMoj90JEPQwpUkBq9UZAu9pS8CVIPHB7M7g0JSu2wQ7RwI0lnvv4jsmEwrbOcx3e
X-Gm-Message-State: AOJu0YzTkN/h/th8mXtvJcx8661bTfa2snIADtn3FuMHaJXkPZ4Hoozj
	+FPkH5X3U2y9xSLONpKYiMTsAVLJOnhF+fa33s6jRau3Uw/G5osbH/kcqnOB+ZbdZIeZ41k=
X-Google-Smtp-Source: AGHT+IHt9rUtlOsN4joDJDaLQ46HZsx+ssQX5mNojSpy9mOPjyyNMVV/S4A0DycY+IBGc04fyk0DsA==
X-Received: by 2002:a17:90a:134f:b0:299:11c0:13c4 with SMTP id y15-20020a17090a134f00b0029911c013c4mr7631636pjf.24.1708342881478;
        Mon, 19 Feb 2024 03:41:21 -0800 (PST)
Received: from [10.4.72.30] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id w3-20020a17090a528300b002990d91d31dsm4956437pjh.15.2024.02.19.03.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 03:41:21 -0800 (PST)
Message-ID: <7a1c2bf7-df85-431a-ae21-82eeb171f1c4@gmail.com>
Date: Mon, 19 Feb 2024 19:41:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC] kernel/ksysfs.c: restrict /sys/kernel/notes to root
 access
To: Kees Cook <keescook@chromium.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: linux-hardening@vger.kernel.org, Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Guixiong Wei <weiguixiong@bytedance.com>, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20240218073501.54555-1-guixiongwei@gmail.com>
 <2024021825-skiing-trustee-a56a@gregkh> <202402180028.6DB512C50@keescook>
From: Guixiong Wei <guixiongwei@gmail.com>
In-Reply-To: <202402180028.6DB512C50@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/2/18 17:04, Kees Cook wrote:
> On Sun, Feb 18, 2024 at 08:47:03AM +0100, Greg KH wrote:
>> On Sun, Feb 18, 2024 at 03:35:01PM +0800, Guixiong Wei wrote:
>>> From: Guixiong Wei <weiguixiong@bytedance.com>
>>>
>>> Restrict non-privileged user access to /sys/kernel/notes to
>>> avoid security attack.
>>>
>>> The non-privileged users have read access to notes. The notes
>>> expose the load address of startup_xen. This address could be
>>> used to bypass KASLR.
>> How can it be used to bypass it?
>>
>> KASLR is, for local users, pretty much not an issue, as that's not what
>> it protects from, only remote ones.
>>
>>> For example, the startup_xen is built at 0xffffffff82465180 and
>>> commit_creds is built at 0xffffffff810ad570 which could read from
>>> the /boot/System.map. And the loaded address of startup_xen is
>>> 0xffffffffbc265180 which read from /sys/kernel/notes. So the loaded
>>> address of commit_creds is 0xffffffffbc265180 - (0xffffffff82465180
>>>   - 0xffffffff810ad570) = 0xffffffffbaead570.
>> I've cc: the hardening list on this, I'm sure the developers there have
>> opinions about this.
> Oh eww, why is Xen spewing addresses into the notes section? (This must
> be how it finds its entry point? But that would be before relocations
> happen...)
>
> But yes, I can confirm that relocations are done against the .notes
> section at boot, so the addresses exposed in .notes is an immediate
> KASLR offset exposure.
>
> In /sys/kernel/notes (are there any tools to read this? I wrote my own...)
>
> 	type: 1
> 	name: Xen
> 	desc: 0xb4a711c0 0xffffffff
>
> which matches a privileged read of /proc/kallsysms:
>
> 	ffffffffb4a711c0 T startup_xen
>
> (and the hypercall_page too)
>
> There are all coming from arch/x86/xen/xen-head.S:
>
>          ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz "linux")
>          ELFNOTE(Xen, XEN_ELFNOTE_GUEST_VERSION,  .asciz "2.6")
>          ELFNOTE(Xen, XEN_ELFNOTE_XEN_VERSION,    .asciz "xen-3.0")
> #ifdef CONFIG_XEN_PV
>          ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,      _ASM_PTR __START_KERNEL_map)
>          /* Map the p2m table to a 512GB-aligned user address. */
>          ELFNOTE(Xen, XEN_ELFNOTE_INIT_P2M,       .quad (PUD_SIZE * PTRS_PER_PUD))
>          ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          _ASM_PTR startup_xen)
> ...
>
> Introduced in commit 5ead97c84fa7 ("xen: Core Xen implementation")
>
> Exposed in commit da1a679cde9b ("Add /sys/kernel/notes")
>
> Amazingly these both went in on the same release (v2.6.23, 2007). This
> has been exposed for longer than KASLR has been upstream. :P
>
>>> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
>>> ---
>>>   kernel/ksysfs.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
>>> index b1292a57c2a5..09bc0730239b 100644
>>> --- a/kernel/ksysfs.c
>>> +++ b/kernel/ksysfs.c
>>> @@ -199,7 +199,7 @@ static ssize_t notes_read(struct file *filp, struct kobject *kobj,
>>>   static struct bin_attribute notes_attr __ro_after_init  = {
>>>   	.attr = {
>>>   		.name = "notes",
>>> -		.mode = S_IRUGO,
>>> +		.mode = S_IRUSR,
>>>   	},
>>>   	.read = &notes_read,
>>>   };
> Yes please.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> I wonder if we should also remove relocations that are aimed at the
> .notes section for good measure? If that had already been true, this
> would have just given the same info as System.map.
That's a good idea, but it depends on whether the user space tool can 
accept the remove relocation address.
>> No objection from me, but what userspace tool requires access to this
>> file today?  Will it break if permissions are changed on it?
 From the exposed content, it seems that the main users are Xen-related 
tools. I add Xen list, developers should be able to provide some 
information.
>> And what about the module notes files?  If you change one, shouldn't you
>> change all?
 From what I currently know, the module note files do not expose any 
kernel symbol address, so there is no need for modification.
> Luckily all of _those_ contain what I'd expect: the Linux and
> GNU.build-id notes, which are harmless. But if we're going to suddenly
> have things appearing in here, let's make those root-only too.
Yes, but I also not sure whether the user space tools using this file 
can accept this permission modification.

