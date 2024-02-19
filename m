Return-Path: <linux-kernel+bounces-71378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E950285A45A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67C22822C2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B6C36AF2;
	Mon, 19 Feb 2024 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="enfEQQeR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="enfEQQeR"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B652D2D607;
	Mon, 19 Feb 2024 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348082; cv=none; b=WtiIUtJdMsls9nPlzu5ZtGeKD3nRaVa5ZoFdJy7z59kcSaXVO393mrXHdRTJdnPsNgA6rV87IlAqyjUkSbm5pzDdARr32N0WK0f/9eHlwGAePqbs8ZLMBjxJl/N1nj0x+gSmKUelLl49ZlCvbIq1xirDc3DiTwGxlXkARgEMSb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348082; c=relaxed/simple;
	bh=aqhdz5jZvoHHhKuVHFSbbTrTM0VXAIh+AtbEXvKiV5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7PUeqmBFQeva5pTOESjr9Nd/PVUyl0aScoT/66mbfdNpNu29E1OBJeROqFEViAJtBQwm31ljfrFB8D7dS3fHnTzS3l9V4RAfSoMlf7+bjfewpzNvYIE7rMlV0SJcRCttTvS0qxb17AC2PuMaOW+bdsInn3jilfRfD9dUDRHMV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=enfEQQeR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=enfEQQeR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 521D722180;
	Mon, 19 Feb 2024 13:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708348078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIfSlUEslrWVPddWPziGhX/JsVABAGYKiD/rmY5VVxs=;
	b=enfEQQeRmU6VXSNN8iWZmhdNJOHrOi3WxuFJq0cARxVCwIFkYIBUUMWXjIzQeUwafX5YJK
	gNFKQqr2XnPrgyxMZU0O3oC1b/s5e8QpA3fBtzXpiTA7f72boOzvhcgrH3Dsl1sSO9jlhZ
	Sq0oBzHdUlMKEXdmXMnrqPPZJhtNN2M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708348078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIfSlUEslrWVPddWPziGhX/JsVABAGYKiD/rmY5VVxs=;
	b=enfEQQeRmU6VXSNN8iWZmhdNJOHrOi3WxuFJq0cARxVCwIFkYIBUUMWXjIzQeUwafX5YJK
	gNFKQqr2XnPrgyxMZU0O3oC1b/s5e8QpA3fBtzXpiTA7f72boOzvhcgrH3Dsl1sSO9jlhZ
	Sq0oBzHdUlMKEXdmXMnrqPPZJhtNN2M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05A3613647;
	Mon, 19 Feb 2024 13:07:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S1IlO61S02UtTAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 19 Feb 2024 13:07:57 +0000
Message-ID: <23ecde01-0e9a-4d2f-8194-294174ca7dbc@suse.com>
Date: Mon, 19 Feb 2024 14:07:57 +0100
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
Cc: Guixiong Wei <guixiongwei@gmail.com>, linux-hardening@vger.kernel.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Guixiong Wei <weiguixiong@bytedance.com>, linux-kernel@vger.kernel.org
References: <20240218073501.54555-1-guixiongwei@gmail.com>
 <2024021825-skiing-trustee-a56a@gregkh> <202402180028.6DB512C50@keescook>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <202402180028.6DB512C50@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.62 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.00)[21.84%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 R_MIXED_CHARSET(0.71)[subject];
	 FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,oracle.com,kernel.org,epam.com,bytedance.com];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.62

On 18.02.24 10:04, Kees Cook wrote:
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
>>
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
>>
>> I've cc: the hardening list on this, I'm sure the developers there have
>> opinions about this.
> 
> Oh eww, why is Xen spewing addresses into the notes section? (This must
> be how it finds its entry point? But that would be before relocations
> happen...)

Right. Xen is looking into the ELF-file to find the entry point of the
kernel (PV and PVH guest types only).

> 
> But yes, I can confirm that relocations are done against the .notes
> section at boot, so the addresses exposed in .notes is an immediate
> KASLR offset exposure.

Relocations applied to the kernel when it has been started don't need
to cover the notes section as far as Xen is concerned.


Juergen

