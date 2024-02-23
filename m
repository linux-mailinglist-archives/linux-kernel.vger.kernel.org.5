Return-Path: <linux-kernel+bounces-78384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D468612C5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C29B1C20F74
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36587EF0F;
	Fri, 23 Feb 2024 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sQOGblkp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="//qkOW96";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sQOGblkp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="//qkOW96"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8157E779;
	Fri, 23 Feb 2024 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695226; cv=none; b=ET1xoc9RxMb5Vt+2GgyHUcsnSgcj9ocpD+eN7XQcJUlewETQYH20bpcOGv8V3O5QedkQPjFLzQdc9vuRil2/duGpxAuSxvDi4uywRW5oCF05kgc3ch5JN7CAQhhUi0DCLHWaFccEeJuAMdtdikvUMpe4cODqTtOhzyBVwUTBHsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695226; c=relaxed/simple;
	bh=oUxqSzZqQBYpocUGl1L/RrfzZGEAqSdrli9rsNXnAEA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ag0ZB5+ue0jrSmBW9sMJg2pI+20vEGDG88cbkaorL4YafyHhn/bodMh4ghe1K/EjwSyBhv05YYWNe6wBUcoSHYRiKUafQTwRjoLMQ2BuP/2iYaXPmZwOvxNIVZ+qkTFciAtxeFWY5afaRGNclhl/6mk88iSD1SJEZr+pkajgqjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sQOGblkp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=//qkOW96; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sQOGblkp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=//qkOW96; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 99DB51F7AF;
	Fri, 23 Feb 2024 13:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708695222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xy9QEdTXAj64w03PMB8hpvq3C4fgdJIvBJUiHqeCNKs=;
	b=sQOGblkpudeS/4GVdYO+y0hfRHjGaS7DtI/EnNv/KSA+SCT57X8lkNvhpsFlkURQoIT1PX
	TCuKiNYMXBzPNwu02XHUOozDQKVkFIlpAHfNAYfZGFFEQNPlFgHfBZ7SZXzpLXREQ5mxwD
	onad0O8k+eR7QwMQsAKRNe3pdENv040=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708695222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xy9QEdTXAj64w03PMB8hpvq3C4fgdJIvBJUiHqeCNKs=;
	b=//qkOW966GRBJzkU2tmypU/yzAVNh+/8vKquYBxXQvmyVVCFoh/4fnprfPCKNObLLjmP/A
	w/oFQsoXgYc0d5DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708695222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xy9QEdTXAj64w03PMB8hpvq3C4fgdJIvBJUiHqeCNKs=;
	b=sQOGblkpudeS/4GVdYO+y0hfRHjGaS7DtI/EnNv/KSA+SCT57X8lkNvhpsFlkURQoIT1PX
	TCuKiNYMXBzPNwu02XHUOozDQKVkFIlpAHfNAYfZGFFEQNPlFgHfBZ7SZXzpLXREQ5mxwD
	onad0O8k+eR7QwMQsAKRNe3pdENv040=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708695222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xy9QEdTXAj64w03PMB8hpvq3C4fgdJIvBJUiHqeCNKs=;
	b=//qkOW966GRBJzkU2tmypU/yzAVNh+/8vKquYBxXQvmyVVCFoh/4fnprfPCKNObLLjmP/A
	w/oFQsoXgYc0d5DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5756A132C7;
	Fri, 23 Feb 2024 13:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9TTVE7ae2GXyBQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 23 Feb 2024 13:33:42 +0000
Date: Fri, 23 Feb 2024 14:33:41 +0100
Message-ID: <87v86f2tl6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Gergo Koteles <soyer@irl.hu>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: tas2781: enable subwoofer volume control
In-Reply-To: <7ffae10ebba58601d25fe2ff8381a6ae3a926e62.1708687813.git.soyer@irl.hu>
References: <7ffae10ebba58601d25fe2ff8381a6ae3a926e62.1708687813.git.soyer@irl.hu>
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
X-Spam-Level: 
X-Spam-Score: -3.27
X-Spamd-Result: default: False [-3.27 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.97)[99.87%]
X-Spam-Flag: NO

On Fri, 23 Feb 2024 12:34:30 +0100,
Gergo Koteles wrote:
> 
> The volume of subwoofer channels is always at maximum with the
> ALC269_FIXUP_THINKPAD_ACPI chain.
> 
> Use ALC285_FIXUP_THINKPAD_HEADSET_JACK to align it to the master volume.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=208555#c827
> 
> Fixes: 3babae915f4c ("ALSA: hda/tas2781: Add tas2781 HDA driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

Thanks, applied.


Takashi

