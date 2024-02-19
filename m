Return-Path: <linux-kernel+bounces-71183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7568385A1CA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301E0283B78
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A922C19C;
	Mon, 19 Feb 2024 11:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LKpdmuB3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9KN1w+Tb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LKpdmuB3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9KN1w+Tb"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675E02C197;
	Mon, 19 Feb 2024 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341600; cv=none; b=YAzK/0WBAO7oXVchgZenWbDgpfNWZMaEFYzNF5qjJ3WWH6hJu3fjLpkRraqIK6HXSpVSCVgcPlOVCCsPxgmzFPG67OFTvc59zePSw5/hP1RUR5z57dH3sg/uB5QLa2XYNfHg5T3MG3D9/+WvPO5C4JIN5pLaSQ5v7q7sRclwMcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341600; c=relaxed/simple;
	bh=45rnvUaUPAfCSe5CBydsQQMyQFkW2jw6N87HcpBnmQI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyYrU5hYw9uEz/G5kdx+1dcjvp91BMLJp4DCFzPZH+FOPsJCer9GqBrcDJn90xJVnUX9cUv3+CDglG9E4uEic7VzqKsW/6toigq2knNO37Dr6N8TlB5AE2/PhDqZIfhAin7iTrh0Vv2ks2QGWNH/dXBVZ2TlzSjQDXMFtWF25zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LKpdmuB3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9KN1w+Tb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LKpdmuB3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9KN1w+Tb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A18F1F7F1;
	Mon, 19 Feb 2024 11:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708341596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1TZFf4FqHXti3cE1EXqChNcXmHSmMIGGoN+xhN0X77Y=;
	b=LKpdmuB3knKa0mVmFF1ps7CbckcaMwBs0vXN6GF0QogY2GkCsMjGgjb/EolHyOvAPjChvP
	VZcU1eUWI6MsM8Yd3OX/iwvenxa/ekR0NYMOWrcjPU98mhkBy9TJsaA4WOY53RwTQsVdHw
	2yu/OOFuVvmAYig4hMxnbHMpNFyX+lo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708341596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1TZFf4FqHXti3cE1EXqChNcXmHSmMIGGoN+xhN0X77Y=;
	b=9KN1w+Tb2IxjJLF3V1vqBnUAzxZC0zj/TWT6nORlzyJ892D8Mo/AFEqcqkh1v8/9eluQRY
	DNYWtootUqCyCVBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708341596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1TZFf4FqHXti3cE1EXqChNcXmHSmMIGGoN+xhN0X77Y=;
	b=LKpdmuB3knKa0mVmFF1ps7CbckcaMwBs0vXN6GF0QogY2GkCsMjGgjb/EolHyOvAPjChvP
	VZcU1eUWI6MsM8Yd3OX/iwvenxa/ekR0NYMOWrcjPU98mhkBy9TJsaA4WOY53RwTQsVdHw
	2yu/OOFuVvmAYig4hMxnbHMpNFyX+lo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708341596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1TZFf4FqHXti3cE1EXqChNcXmHSmMIGGoN+xhN0X77Y=;
	b=9KN1w+Tb2IxjJLF3V1vqBnUAzxZC0zj/TWT6nORlzyJ892D8Mo/AFEqcqkh1v8/9eluQRY
	DNYWtootUqCyCVBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CEAA13647;
	Mon, 19 Feb 2024 11:19:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6QWWCVw502X0MQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 19 Feb 2024 11:19:56 +0000
Date: Mon, 19 Feb 2024 12:19:55 +0100
Message-ID: <87le7gog4k.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sven van Ashbrook <svenva@chromium.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Hillf Danton <hdanton@sina.com>,
	Karthikeyan Ramasubramanian <kramasub@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-sound@vger.kernel.org,
	"Arava, Jairaj" <jairaj.arava@intel.com>,
	Curtis Malainey <cujomalainey@chromium.org>
Subject: Re: [PATCH v1] ALSA: memalloc: Fix indefinite hang in non-iommu case
In-Reply-To: <CAG-rBihE31G1q0pXbdR22bHKNboiADTUHx0JMnDKBg_sua+0RA@mail.gmail.com>
References: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid>
	<20240215034528.240-1-hdanton@sina.com>
	<87h6iaf7di.wl-tiwai@suse.de>
	<CAG-rBigFG-U-sKY77CvzghGzs+1Xm3YXzBF6N4ti0+h6UdAb8Q@mail.gmail.com>
	<875xypk6d6.wl-tiwai@suse.de>
	<20240216043426.1218-1-hdanton@sina.com>
	<87plwwiz6z.wl-tiwai@suse.de>
	<87frxsiueo.wl-tiwai@suse.de>
	<alpine.DEB.2.22.394.2402161246520.14041@eliteleevi.tm.intel.com>
	<87zfw0h3lu.wl-tiwai@suse.de>
	<CAG-rBihE31G1q0pXbdR22bHKNboiADTUHx0JMnDKBg_sua+0RA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.36
X-Spamd-Result: default: False [-0.36 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[sina.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.de,linux.intel.com,sina.com,chromium.org,vger.kernel.org,google.com,intel.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.06)[61.43%]
X-Spam-Flag: NO

On Fri, 16 Feb 2024 17:22:45 +0100,
Sven van Ashbrook wrote:
> 
> On Fri, Feb 16, 2024 at 9:43 AM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > OK, then how about the one like below?
> >
> > This changes:
> > - Back to __GFP_NORETRY as default
> > - Use __GFP_RETRY_MAYFAIL for SNDRV_DMA_TYPE_NONCONTIG with IOMMU;
> >   this should cover the commit a61c7d88d38c
> > - Also use __GFP_RETRY_MAYFAIL for the SG-fallback allocations of the
> >   minimal order, just like IOMMU allocator does.
> >
> > This should be less destructive, while still allowing more aggressive
> > allocations for SG buffers.
> 
> This one looks like it would keep the SOF firmware allocation issue at bay,
> in both iommu and non-iommu cases.
> 
> If there is no further discussion in this thread, we'll stress test this
> on iommu and non-iommu Chromebooks.

The test with my latest patch would be appreciated in anyway.


thanks,

Takashi


