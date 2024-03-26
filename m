Return-Path: <linux-kernel+bounces-118449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F36888BB07
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41D01F3A44C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E52130498;
	Tue, 26 Mar 2024 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ss93DTeF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p/9ZdpiT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ss93DTeF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p/9ZdpiT"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A229D13048D;
	Tue, 26 Mar 2024 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711437405; cv=none; b=DRpNpWYxfkXpzDYPwMK8yj+B4klVOt7mshzNcXz509o6sW9eTASsT+UNw7VdA0z8cVbjLQJl5QArWq0QoboZtcIf0K5XaEPA+w1lW4fwuINHSlxJQ9yZ5GrP0wYt2CxY2yHEuTlFpCRs2d7Oudw8+p5rTWUlEOUFFB0kq9UgVII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711437405; c=relaxed/simple;
	bh=QB2znJuNJc7Jw3xDnmQHgrPw3SJ62BZDEf9LwLRRtj0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mU15CVddSkcvcRwiZy1mjlX8gAi/QmDmnXNWVmAsB6mDPghigopvHvEBhHKjsyvPI/MzDZrCY2YxXDnGKLo6h4xQDJ7ch8kscMjJZ5JY8/xEXUuVkAPJnZvT4oA75gLuwrrD8ZvcVV3zgukHq0HvacctLHKuHPlYd1jBPTfw3o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ss93DTeF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p/9ZdpiT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ss93DTeF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p/9ZdpiT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 865A0378A1;
	Tue, 26 Mar 2024 07:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711437401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SudFTEiUfI2unsWkokt8yBfOaCJEwdmvYWm1y/DzONg=;
	b=Ss93DTeFG9sYuMPeu2NOamNVGp1y2O+nQyXeDZrMtLXihWjIvrba9Oa7Endx2hc8AX8RVq
	jLe2JqbGUCtUqqHZXldbtwzQKj8ydPHX5e11ZP0sgxCV77I9Zax27P2uoTexdYkuzYCMgK
	dOc2nd/qpPFqj7TPav5G6dKASrWsFq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711437401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SudFTEiUfI2unsWkokt8yBfOaCJEwdmvYWm1y/DzONg=;
	b=p/9ZdpiTRT6das/OoDxTgu/JxL8fXwUIdzpaW7qFg6yCbi/+32eXjla3Ue6gfMhHWvP9g4
	kXOFiNRpbYVDXVCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711437401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SudFTEiUfI2unsWkokt8yBfOaCJEwdmvYWm1y/DzONg=;
	b=Ss93DTeFG9sYuMPeu2NOamNVGp1y2O+nQyXeDZrMtLXihWjIvrba9Oa7Endx2hc8AX8RVq
	jLe2JqbGUCtUqqHZXldbtwzQKj8ydPHX5e11ZP0sgxCV77I9Zax27P2uoTexdYkuzYCMgK
	dOc2nd/qpPFqj7TPav5G6dKASrWsFq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711437401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SudFTEiUfI2unsWkokt8yBfOaCJEwdmvYWm1y/DzONg=;
	b=p/9ZdpiTRT6das/OoDxTgu/JxL8fXwUIdzpaW7qFg6yCbi/+32eXjla3Ue6gfMhHWvP9g4
	kXOFiNRpbYVDXVCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3615013306;
	Tue, 26 Mar 2024 07:16:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +DCdC1l2AmZbTgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 26 Mar 2024 07:16:41 +0000
Date: Tue, 26 Mar 2024 08:16:42 +0100
Message-ID: <874jctwjhh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Gergo Koteles <soyer@irl.hu>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ALSA: hda/tas2781: add debug statements to kcontrols
In-Reply-To: <377e0f33-697c-4baf-ac48-baff6199dd53@linux.intel.com>
References: <cover.1711401621.git.soyer@irl.hu>
	<cbdc337b911bee0f80f805b936041fd59c1db54a.1711401621.git.soyer@irl.hu>
	<377e0f33-697c-4baf-ac48-baff6199dd53@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.27
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.27 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.76)[84.29%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ss93DTeF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="p/9ZdpiT"
X-Rspamd-Queue-Id: 865A0378A1

On Mon, 25 Mar 2024 23:01:18 +0100,
Pierre-Louis Bossart wrote:
> 
> 
> 
> 
> > +++ b/sound/pci/hda/tas2781_hda_i2c.c
> > @@ -189,6 +189,9 @@ static int tasdevice_get_profile_id(struct snd_kcontrol *kcontrol,
> >  
> >  	ucontrol->value.integer.value[0] = tas_priv->rcabin.profile_cfg_id;
> >  
> > +	dev_dbg(tas_priv->dev, "%s: %d\n", __func__,
> 
> Nit-pick: you don't need to add __func__ to dev_dbg logs, the user can
> add the information with the dyndbg parameter, e.g.
> 
> options snd_intel_dspcfg dyndbg=+pmf

Since this doesn't always show up, I don't mind to have the function
name shown explicitly there.  OTOH, what bothers me is that all those
messages have a short format "__func__: %d" while the values are
utterly different, depending on the function.  That can be confusing.
IMO, it'd be more user-friendly to indicate what values are presented,
too.


thanks,

Takashi

