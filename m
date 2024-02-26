Return-Path: <linux-kernel+bounces-80964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1EA866E72
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2449A1F252FF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4326024D;
	Mon, 26 Feb 2024 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wfKheqgf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uy7Zbc0g";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wfKheqgf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uy7Zbc0g"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BE55FF18;
	Mon, 26 Feb 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937449; cv=none; b=GRA6RaZluSlErF/EwaquDGV8E7eeXAiKYfzB0seb7aRmRDquwRx/wJ4Rzm1+yYP7G5TizljXlNsyQXDyzp/rJ9aFOqxOiJx0+o6rqEDRd2c6Jpb0sHb0zj9paejE3DCoSjHFxnWIS9N4h94cUZqqIBnTa1iO/baM3hZyOaAWE2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937449; c=relaxed/simple;
	bh=oaDCTS0Y18vsEvDVZTZJLmkjz0O+k+Dseb0hfV1wNuE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWLnfwf0tbsCGOfdtd7Yt28JTcyHUytc4nM4JUUq1UAb6qaERUkswjPLRg075IwBZZ3+T+MNtldriPRTKq/x1jR0JGEB3ljMdY7ZHQFQnCBeSHgH3FFYo0Wex6wZECgigzbFxmPXFabQ8RlobzL6+xkguIr5qfl1KNyLxar3aO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wfKheqgf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uy7Zbc0g; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wfKheqgf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uy7Zbc0g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 058E41F911;
	Mon, 26 Feb 2024 08:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708937446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jVg3+4MrPJeDgDG/+SZ95kFC8x4+K8jcoMQ3drqjs2s=;
	b=wfKheqgfxIiPGc70DzQV8gHwnadGVfgtUkY5klsdWCZNNGS1ybI2YDBPJPaNEDp1k6ZVB5
	ttX/0ubhpcHymwT/GGK/RvWGz7GSdXLfwEjZEH+/YR7sQEgJR6alD8KEKMBHf3frU9tEw3
	E2nwEgA3DwdX2MapODIbF0IsOzB9NQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708937446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jVg3+4MrPJeDgDG/+SZ95kFC8x4+K8jcoMQ3drqjs2s=;
	b=uy7Zbc0gqJJeLqdh8jsW34YKqqtLKH9keGE+5+VBfWIec7Mi8JMy7ulYAmGETuJVZrLehA
	BnH3Yr8TJlgND4BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708937446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jVg3+4MrPJeDgDG/+SZ95kFC8x4+K8jcoMQ3drqjs2s=;
	b=wfKheqgfxIiPGc70DzQV8gHwnadGVfgtUkY5klsdWCZNNGS1ybI2YDBPJPaNEDp1k6ZVB5
	ttX/0ubhpcHymwT/GGK/RvWGz7GSdXLfwEjZEH+/YR7sQEgJR6alD8KEKMBHf3frU9tEw3
	E2nwEgA3DwdX2MapODIbF0IsOzB9NQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708937446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jVg3+4MrPJeDgDG/+SZ95kFC8x4+K8jcoMQ3drqjs2s=;
	b=uy7Zbc0gqJJeLqdh8jsW34YKqqtLKH9keGE+5+VBfWIec7Mi8JMy7ulYAmGETuJVZrLehA
	BnH3Yr8TJlgND4BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72BBA13A58;
	Mon, 26 Feb 2024 08:50:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q93IF+VQ3GXqFgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 26 Feb 2024 08:50:45 +0000
Date: Mon, 26 Feb 2024 09:50:45 +0100
Message-ID: <87wmqrzk0q.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Takashi Iwai <tiwai@suse.de>,
	Jiri Slaby <jirislaby@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Linux Wireless <linux-wireless@vger.kernel.org>,
	ath11k@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org
Subject: Re: ath11k allocation failure on resume breaking wifi until power cycle
In-Reply-To: <a36b35a9-fb37-4afe-a718-a47dfe658cb5@suse.cz>
References: <96481a45-3547-4d23-ad34-3a8f1d90c1cd@suse.cz>
	<0994ae16-8174-4a04-b454-1974b16bc106@quicinc.com>
	<20240222054739.GG3374@thinkpad>
	<38c36d16-9cc1-4f03-b758-4a3ba90f8aa4@suse.cz>
	<abc0c24f-2137-41eb-bb99-80aea8dacdb2@quicinc.com>
	<a36b35a9-fb37-4afe-a718-a47dfe658cb5@suse.cz>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

On Mon, 26 Feb 2024 09:45:17 +0100,
Vlastimil Babka wrote:
> 
> On 2/26/24 03:09, Baochen Qiang wrote:
> > 
> > 
> > On 2/23/2024 11:28 PM, Vlastimil Babka wrote:
> >> On 2/22/24 06:47, Manivannan Sadhasivam wrote:
> >>> On Wed, Feb 21, 2024 at 08:34:23AM -0800, Jeff Johnson wrote:
> >>>> On 2/21/2024 6:39 AM, Vlastimil Babka wrote:
> >>>>> Hi,
> >>>>>
> >>>>> starting with 6.8 rc series, I'm experiencing problems on resume from s2idle
> >>>>> on my laptop, which is Lenovo T14s Gen3:
> >>>>>
> >>>>> LENOVO 21CRS0K63K/21CRS0K63K, BIOS R22ET65W (1.35 )
> >>>>> ath11k_pci 0000:01:00.0: wcn6855 hw2.1
> >>>>> ath11k_pci 0000:01:00.0: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
> >>>>> ath11k_pci 0000:01:00.0: fw_version 0x1106196e fw_build_timestamp 2024-01-12 11:30 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
> >>>>>
> >>>>> The problem is an allocation failure happening on resume from s2idle. After
> >>>>> that the wifi stops working and even a reboot won't fix it, only a
> >>>>> poweroff/poweron cycle of the laptop.
> >>>>>
> >>>
> >>> Looks like WLAN is powered down during s2idle, which doesn't make sense. I hope
> >>> Jeff will figure out what's going on.
> >> 
> >> You mean the firmware is supposed to power it down/up transparently without
> >> kernel involvement? Because it should be powered down to save the power, no?
> > Let me clarify: from backtrace info, seems you are using a kernel with 
> > the hibernation-support patches [1] applied, which are not accepted yet 
> > to mainline kernel or even 
> > git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git.
> 
> Oh, you're right. Sorry for confusing you all. The rc kernel builds we have
> for openSUSE have nearly no non-upstream patches so it didn't really occur
> to me to double check if there might be in the area.
> 
> Seems Takashi (Cc'd) added them indeed to make hibernation work:
> https://bugzilla.suse.com/show_bug.cgi?id=1207948#c51

Yeah, and I'm afraid that we still have the ath11k hibernation patches
in our 6.8-rc default kernel (i.e. patches are in both master and
stable branches).  But you can test vanilla flavor that has certainly
no downstream patches at all.


thanks,

Takashi

