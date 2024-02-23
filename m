Return-Path: <linux-kernel+bounces-78606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA8D8615C7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270161C23525
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5C282887;
	Fri, 23 Feb 2024 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BksMdMFr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L1IGN+0c";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BksMdMFr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L1IGN+0c"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B612E412;
	Fri, 23 Feb 2024 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702111; cv=none; b=tyiw1eeA1CRcM38qATPWGtYSC3+CgEjtFJeIyhUVho5lpy+cJLF8/FEqOT8L+JMs9UfZXGuiTAHGIdFLkxhBQKGlbqokM+bVO0yVIIATUVp1hui0m2UeSzKZ5997lE/kwV5OvrdRKcMnDwTvIhnFnOypWc+oYO4N9e/oRWGrvu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702111; c=relaxed/simple;
	bh=9hvVEuEX7/xy74xE2geevxGtJuW1beNH5JA1d/aaE1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJTS3+5bY97jFVzAb3b4w0X+bAPgDWeQnPLGHIuRy8u3YF/SyxfO5LpgJBmrMxDE9bPq3R0ZzbyzBGugd74h8kNmC56vY+Sq8DBi0socxx8nuV8Pj4POmud3+Re6/vRTlrOUqaQJV7HG311439mClQrcHokJ5I0Zs0vd1adxwUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BksMdMFr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L1IGN+0c; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BksMdMFr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L1IGN+0c; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CFFCD1FC0C;
	Fri, 23 Feb 2024 15:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708702107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v36nd4PFmvY6FAwtTKo1vy8S4903safEpdw3P1sE3Ec=;
	b=BksMdMFr9gcRTPKjaEHC8XeOgShZGz+yZWEYIWYAU9rIagxoEF8ASZAJILXbW++iMNuop0
	h7gfrWrhNbuJMsSkRW0Ss8D73dUvu/RLVIKd8+V2oPfqibhjsaPYFrB/kYpUxN58bAa7lr
	UisbuQRnmNnf3D/O94OaTSBth0DUlII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708702107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v36nd4PFmvY6FAwtTKo1vy8S4903safEpdw3P1sE3Ec=;
	b=L1IGN+0c4p0OUTU5vp0xP+7UubceuCK+19sE/B1Qd2apWi/r7jIdGubAWWvW0pL3yokX0k
	ZQHyNCgNabXl2gDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708702107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v36nd4PFmvY6FAwtTKo1vy8S4903safEpdw3P1sE3Ec=;
	b=BksMdMFr9gcRTPKjaEHC8XeOgShZGz+yZWEYIWYAU9rIagxoEF8ASZAJILXbW++iMNuop0
	h7gfrWrhNbuJMsSkRW0Ss8D73dUvu/RLVIKd8+V2oPfqibhjsaPYFrB/kYpUxN58bAa7lr
	UisbuQRnmNnf3D/O94OaTSBth0DUlII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708702107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v36nd4PFmvY6FAwtTKo1vy8S4903safEpdw3P1sE3Ec=;
	b=L1IGN+0c4p0OUTU5vp0xP+7UubceuCK+19sE/B1Qd2apWi/r7jIdGubAWWvW0pL3yokX0k
	ZQHyNCgNabXl2gDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC93C132C7;
	Fri, 23 Feb 2024 15:28:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D5qvLZu52GW6IgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 23 Feb 2024 15:28:27 +0000
Message-ID: <38c36d16-9cc1-4f03-b758-4a3ba90f8aa4@suse.cz>
Date: Fri, 23 Feb 2024 16:28:27 +0100
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
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>,
 Linux Wireless <linux-wireless@vger.kernel.org>, ath11k@lists.infradead.org,
 LKML <linux-kernel@vger.kernel.org>, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org
References: <96481a45-3547-4d23-ad34-3a8f1d90c1cd@suse.cz>
 <0994ae16-8174-4a04-b454-1974b16bc106@quicinc.com>
 <20240222054739.GG3374@thinkpad>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240222054739.GG3374@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BksMdMFr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=L1IGN+0c
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CFFCD1FC0C
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spam-Flag: NO

On 2/22/24 06:47, Manivannan Sadhasivam wrote:
> On Wed, Feb 21, 2024 at 08:34:23AM -0800, Jeff Johnson wrote:
>> On 2/21/2024 6:39 AM, Vlastimil Babka wrote:
>> > Hi,
>> > 
>> > starting with 6.8 rc series, I'm experiencing problems on resume from s2idle
>> > on my laptop, which is Lenovo T14s Gen3:
>> > 
>> > LENOVO 21CRS0K63K/21CRS0K63K, BIOS R22ET65W (1.35 )
>> > ath11k_pci 0000:01:00.0: wcn6855 hw2.1
>> > ath11k_pci 0000:01:00.0: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
>> > ath11k_pci 0000:01:00.0: fw_version 0x1106196e fw_build_timestamp 2024-01-12 11:30 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
>> > 
>> > The problem is an allocation failure happening on resume from s2idle. After
>> > that the wifi stops working and even a reboot won't fix it, only a
>> > poweroff/poweron cycle of the laptop.
>> > 
> 
> Looks like WLAN is powered down during s2idle, which doesn't make sense. I hope
> Jeff will figure out what's going on.

You mean the firmware is supposed to power it down/up transparently without
kernel involvement? Because it should be powered down to save the power, no?

But I just found out that when I build my own kernel using the distro config
as base but reduced by make localmodconfig, the "mhi mhi0: Requested to
power ON" and related messages don't occur anymore, so there's something
weird going on.

> But if you can share the dmesg after enabling the debug prints of both ath11k
> and MHI, it will help a lot.
> 
> - Mani
> 
>> > This is order 4 (costly order), GFP_NOIO (maybe it's originally GFP_KERNEL
>> > but we restrict to GFP_NOIO during resume) allocation, thus it's impossible
>> > to do memory compaction and the page allocator gives up. Such high-order
>> > allocations should have a fallback using smaller pages, or maybe it could at
>> > least retry once the restricted GFP_NOIO context is gone.
>> > 
>> > I don't know why it never happened before 6.8, didn't spot anything obvious
>> > and it happens too unreliably to go bisect. Any idea?
>> 
>> I've asked the development team to look at this, but in the interim can
>> you apply the two hibernation patchsets to see if those cleanups also
>> fix your problem:
>> 
>> [PATCH 0/5] wifi: ath11k: prepare for hibernation support
>> https://lore.kernel.org/linux-wireless/20240221024725.10057-1-quic_bqiang@quicinc.com
>> 
>> [PATCH 0/3] wifi: ath11k: hibernation support
>> https://lore.kernel.org/linux-wireless/20240221030026.10553-1-quic_bqiang@quicinc.com
> 


