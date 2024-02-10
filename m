Return-Path: <linux-kernel+bounces-60346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131CD850376
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 09:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAA62B23C5A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D815533CD2;
	Sat, 10 Feb 2024 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KJoW4J71";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DALLQMtL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZTWz1/eC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xJIBcXYS"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3098B23DB;
	Sat, 10 Feb 2024 08:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707552521; cv=none; b=OwGFxKA5M57o6TbtJYLLJec8nayWveFq4/A6TXx5fMIUV1lkxPDn1dlbXvWhAqlqi4MiqJoaDXXlIJu1EDfGu8RvX6Y6aA5fhx5x/uaJPaXGG7UZiCvxF3S4YRJfX80Z9IoTP12Y1wL1dGzmSKMHCnureubc92+3q6WPk8ThUt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707552521; c=relaxed/simple;
	bh=F8DGyIH//SMvI1ax+96o/ObM1ZtA0zzCYF6zYzURkuY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhCY1L1lQi+MdjZS2jWDSFdycXNRwKP6xvGQD9BN6rFJ46d/6ijPOmZjlHzIeZsrJVepws8kchAfqha3LIIX59Sh/XEIaNfdRXHG05bJsHTw+vOXcb0JV42fnPdjdVE2aDEMqgRdN8OVNE7xmZkxnrmohCXGCl6VehNhjxbGRIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KJoW4J71; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DALLQMtL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZTWz1/eC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xJIBcXYS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A6711F871;
	Sat, 10 Feb 2024 08:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707552517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zlZxIUNjuMw/gmtQRSWgnNoi6CtpoNOtj4J6OuXVIjg=;
	b=KJoW4J71U9ZLJ7gO2a8d/PIy4nhqzxY0s2zlnSK3EfY+kPyH4g9TEVPDrbfiXtcc/TIc19
	rBz1R3rMMqHBFpfdklsVYAvJUBGeIBd1yEeUbyG+S4pvPUI3SlQWCdSERiYlNcqQK8aMbi
	FLTcGWIGmoltnHEJ9DbUUfL3K59u3Cs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707552517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zlZxIUNjuMw/gmtQRSWgnNoi6CtpoNOtj4J6OuXVIjg=;
	b=DALLQMtLxjWwWSgCINWrel5oJJeUceaqE4HtJb6m4CQza+kjwh0s/IV8ugvQhrrR/EzT5b
	Us/14GhwwZ1wBUAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707552515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zlZxIUNjuMw/gmtQRSWgnNoi6CtpoNOtj4J6OuXVIjg=;
	b=ZTWz1/eCrW4xLIfHtnBLB6BnNE2Hyv+DpxtveF0h6zNq9n2cM02p5thixj/s3MPSNtnQ1z
	oWVlRIw4qVHxPrc9pXXKeC739EKUY3jDKS0izOgEk9N/+8AYvkDEcvuryy8bu1Wg0PaJqU
	w8ZfhTZZRJjf5urEpo/4ELDawf/K784=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707552515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zlZxIUNjuMw/gmtQRSWgnNoi6CtpoNOtj4J6OuXVIjg=;
	b=xJIBcXYSPUlRFsJAH686aURuAcIgKNqRNMW8Sp8PsxJ1wmcHs6/sbp65Meumml9uDAWSPz
	lg4vL/0gbcQppkBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A58C613867;
	Sat, 10 Feb 2024 08:08:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dyCTJgIvx2VMcQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 10 Feb 2024 08:08:34 +0000
Date: Sat, 10 Feb 2024 09:08:34 +0100
Message-ID: <875xywzqpp.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: <srinivas.kandagatla@linaro.org>,
	<mathias.nyman@intel.com>,
	<perex@perex.cz>,
	<conor+dt@kernel.org>,
	<corbet@lwn.net>,
	<lgirdwood@gmail.com>,
	<andersson@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>,
	<gregkh@linuxfoundation.org>,
	<Thinh.Nguyen@synopsys.com>,
	<broonie@kernel.org>,
	<bgoswami@quicinc.com>,
	<tiwai@suse.com>,
	<robh+dt@kernel.org>,
	<konrad.dybcio@linaro.org>,
	<linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<linux-usb@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>,
	<alsa-devel@alsa-project.org>
Subject: Re: [PATCH v14 20/53] ASoC: Add SOC USB APIs for adding an USB backend
In-Reply-To: <b007a78c-b8fb-83bc-3be6-963708182cee@quicinc.com>
References: <20240208231406.27397-1-quic_wcheng@quicinc.com>
	<20240208231406.27397-21-quic_wcheng@quicinc.com>
	<87r0hl29ha.wl-tiwai@suse.de>
	<b007a78c-b8fb-83bc-3be6-963708182cee@quicinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="ZTWz1/eC";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xJIBcXYS
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLe67txhfobum3fqdb5xx8e3au)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,quicinc.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linaro.org,intel.com,perex.cz,kernel.org,lwn.net,gmail.com,linuxfoundation.org,synopsys.com,quicinc.com,suse.com,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 5A6711F871
X-Spam-Flag: NO

On Fri, 09 Feb 2024 21:34:39 +0100,
Wesley Cheng wrote:
> 
> Hi Takashi,
> 
> On 2/9/2024 2:54 AM, Takashi Iwai wrote:
> > On Fri, 09 Feb 2024 00:13:33 +0100,
> > Wesley Cheng wrote:
> >> 
> >> Some platforms may have support for offloading USB audio devices to a
> >> dedicated audio DSP.  Introduce a set of APIs that allow for management of
> >> USB sound card and PCM devices enumerated by the USB SND class driver.
> >> This allows for the ASoC components to be aware of what USB devices are
> >> available for offloading.
> >> 
> >> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> > (snip)
> >> --- a/sound/soc/Makefile
> >> +++ b/sound/soc/Makefile
> >> @@ -1,5 +1,5 @@
> >>   # SPDX-License-Identifier: GPL-2.0
> >> -snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-utils.o soc-dai.o soc-component.o
> >> +snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-usb.o soc-utils.o soc-dai.o soc-component.o
> >>   snd-soc-core-objs += soc-pcm.o soc-devres.o soc-ops.o soc-link.o soc-card.o
> >>   snd-soc-core-$(CONFIG_SND_SOC_COMPRESS) += soc-compress.o
> > 
> > Do we really want to build this into ASoC core unconditionally?
> > This is very specific to Qualcomm USB-offload stuff, so it's better to
> > factor out.
> > 
> 
> Ideally, the SOC USB part shouldn't be Qualcomm specific.  Since I
> don't have access or insight into how other vendors are achieving the
> same thing, I can only base the soc-usb layer to work with the
> information that is required to get the audio stream up and running on
> the QC platforms.  In its simplest form, its basically just a SW
> entity that notifies ASoC components about changes occurring from USB
> SND, and I think all vendors that have an ASoC based platform card
> handling the offload will need this notification.

Yes, but it's not necessarily built into the snd-soc-core module at
all, but can be split to another module, right?  Otherwise all
machines must load this code even if it doesn't use at all.
If this were common among various chips, it'd be worth to be merged
into the default common module.  But I don't think that's the case.


thanks,

Takashi

