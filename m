Return-Path: <linux-kernel+bounces-80945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383B0866E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42742867C6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A315B206;
	Mon, 26 Feb 2024 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PBkRM6fm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dai91Ri6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PBkRM6fm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dai91Ri6"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4745B043;
	Mon, 26 Feb 2024 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937122; cv=none; b=T7S77fx4yI6TslsDkxo9Qgqn2RHZX6Sb5FnBMJavQ8NkwyRPwTDkG1v09aYLYFUbiaSKupuDnU1IOsTRDhF1vBLuy8s3xmaYd2vsf5RKt6pscNyxcs/Sq4bsjN11ZEM2chtyeySGwt1qCLdn4h4KFyZLaWwGXvDe4gC0M5P2lOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937122; c=relaxed/simple;
	bh=u1Uk/L1IrDcZRw5xoA8GWBJ3cV7BLElyTityFQ63bWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbfhWBnfwyGU9Y36xxhVxHVu73Ek45U+A/HRAuT69gmj/0sLjJAsKPYY0W8/vRSfUu08+1bqyHOz8ymD6DK9uQW+iQDioKc63GPqKvfiKMvPbeVtihdDQyIqfL0nj8Kv0A1GzH3z4FynUN3T4Dkt0gM+yncp5AFIFn8FiLbICfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PBkRM6fm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dai91Ri6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PBkRM6fm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dai91Ri6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC91D1FB3C;
	Mon, 26 Feb 2024 08:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708937117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDNCpqpWyCkrHeQ7/zkg5D0/ATBvTrpfH/+EnnRRQpU=;
	b=PBkRM6fmokE6jjHDdz8GB36mu7HbbxclHhhnWXeZwysKGoyzxEWjnY/jPplKMKaKM99Ezj
	cPtdoc7kgrMVbdCDmV/htbc8CpLDN0Ie2cww4yJxPHBuFtufv/mggKHHSjIsSuYNArM0cA
	SD/Vcs4c2uSv8rKGnpw3XETQ2A/oCwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708937117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDNCpqpWyCkrHeQ7/zkg5D0/ATBvTrpfH/+EnnRRQpU=;
	b=Dai91Ri6pWuqMHPB2xjKfgEgy9cpl1XoFPn9dtEfRQAwfcO1SkHbOOInI0bH9SQhuMF7OW
	7iktYSiqDiJFArAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708937117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDNCpqpWyCkrHeQ7/zkg5D0/ATBvTrpfH/+EnnRRQpU=;
	b=PBkRM6fmokE6jjHDdz8GB36mu7HbbxclHhhnWXeZwysKGoyzxEWjnY/jPplKMKaKM99Ezj
	cPtdoc7kgrMVbdCDmV/htbc8CpLDN0Ie2cww4yJxPHBuFtufv/mggKHHSjIsSuYNArM0cA
	SD/Vcs4c2uSv8rKGnpw3XETQ2A/oCwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708937117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDNCpqpWyCkrHeQ7/zkg5D0/ATBvTrpfH/+EnnRRQpU=;
	b=Dai91Ri6pWuqMHPB2xjKfgEgy9cpl1XoFPn9dtEfRQAwfcO1SkHbOOInI0bH9SQhuMF7OW
	7iktYSiqDiJFArAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C234213A58;
	Mon, 26 Feb 2024 08:45:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kmwTL51P3GWSFQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 26 Feb 2024 08:45:17 +0000
Message-ID: <a36b35a9-fb37-4afe-a718-a47dfe658cb5@suse.cz>
Date: Mon, 26 Feb 2024 09:45:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k allocation failure on resume breaking wifi until power
 cycle
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, Takashi Iwai <tiwai@suse.de>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
 Linux Wireless <linux-wireless@vger.kernel.org>, ath11k@lists.infradead.org,
 LKML <linux-kernel@vger.kernel.org>, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org
References: <96481a45-3547-4d23-ad34-3a8f1d90c1cd@suse.cz>
 <0994ae16-8174-4a04-b454-1974b16bc106@quicinc.com>
 <20240222054739.GG3374@thinkpad>
 <38c36d16-9cc1-4f03-b758-4a3ba90f8aa4@suse.cz>
 <abc0c24f-2137-41eb-bb99-80aea8dacdb2@quicinc.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <abc0c24f-2137-41eb-bb99-80aea8dacdb2@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PBkRM6fm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Dai91Ri6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -4.50
X-Rspamd-Queue-Id: DC91D1FB3C
X-Spam-Flag: NO

On 2/26/24 03:09, Baochen Qiang wrote:
> 
> 
> On 2/23/2024 11:28 PM, Vlastimil Babka wrote:
>> On 2/22/24 06:47, Manivannan Sadhasivam wrote:
>>> On Wed, Feb 21, 2024 at 08:34:23AM -0800, Jeff Johnson wrote:
>>>> On 2/21/2024 6:39 AM, Vlastimil Babka wrote:
>>>>> Hi,
>>>>>
>>>>> starting with 6.8 rc series, I'm experiencing problems on resume from s2idle
>>>>> on my laptop, which is Lenovo T14s Gen3:
>>>>>
>>>>> LENOVO 21CRS0K63K/21CRS0K63K, BIOS R22ET65W (1.35 )
>>>>> ath11k_pci 0000:01:00.0: wcn6855 hw2.1
>>>>> ath11k_pci 0000:01:00.0: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
>>>>> ath11k_pci 0000:01:00.0: fw_version 0x1106196e fw_build_timestamp 2024-01-12 11:30 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
>>>>>
>>>>> The problem is an allocation failure happening on resume from s2idle. After
>>>>> that the wifi stops working and even a reboot won't fix it, only a
>>>>> poweroff/poweron cycle of the laptop.
>>>>>
>>>
>>> Looks like WLAN is powered down during s2idle, which doesn't make sense. I hope
>>> Jeff will figure out what's going on.
>> 
>> You mean the firmware is supposed to power it down/up transparently without
>> kernel involvement? Because it should be powered down to save the power, no?
> Let me clarify: from backtrace info, seems you are using a kernel with 
> the hibernation-support patches [1] applied, which are not accepted yet 
> to mainline kernel or even 
> git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git.

Oh, you're right. Sorry for confusing you all. The rc kernel builds we have
for openSUSE have nearly no non-upstream patches so it didn't really occur
to me to double check if there might be in the area.

Seems Takashi (Cc'd) added them indeed to make hibernation work:
https://bugzilla.suse.com/show_bug.cgi?id=1207948#c51

But then, why do they affect also s2idle, is it intentional? And why I only
started seeing the problems in 6.8, the patches are there since August.

> So this is why you see WLAN firmware is powered down during suspend.
> 
> [1] 
> https://patchwork.kernel.org/project/linux-wireless/cover/20231127162022.518834-1-kvalo@kernel.org/
> 
>> 
>> But I just found out that when I build my own kernel using the distro config
>> as base but reduced by make localmodconfig, the "mhi mhi0: Requested to
>> power ON" and related messages don't occur anymore, so there's something
>> weird going on.
> Here your own kernel doesn't include the hibernation-support patches, right?

Right.



