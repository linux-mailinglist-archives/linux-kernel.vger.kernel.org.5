Return-Path: <linux-kernel+bounces-44453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3507F84222F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1FB285BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA39664A9;
	Tue, 30 Jan 2024 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j3VR5Dby";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yvHBdjZQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j3VR5Dby";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yvHBdjZQ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CAB537F3;
	Tue, 30 Jan 2024 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612683; cv=none; b=VXzsZiu6JQeTxmxwxBEcQUXg6M+7sqVpaWwMlFYCbElU7nbQm3o34o6NQHl4N2oDH+Ss4oNuvWN8o/Dd7zH5CXJxfjqVa2fi6rD96VDs7VxoMrRQ8eTNyuRDlxxZC0GY6LbFj4VS8Fy1fpJjcyo5W26JAwFFP7Lpswb8Aer5grk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612683; c=relaxed/simple;
	bh=wrZt8z8zTmzW8IvQQjwBzRY7jmPtbq4xDEZvOvmBoRQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2elb8ZnwKJ//V4F3bSBh1cgDB77ThGIfVVtV+zq+GyM2RCHVhXuUkU/puenx2/wOBwFhgvdy2zCUGBJ93tYHj8QHkOU61rnsbHrXyZanxpEKBlluZ0frFZrqAA0tuzCX7cfMSRI1Wa9y0Wg95nwW1ylN9/Y2HTdVXl3NEDTtoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j3VR5Dby; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yvHBdjZQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j3VR5Dby; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yvHBdjZQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 500DB222DD;
	Tue, 30 Jan 2024 11:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706612680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEVz5JmWBEANKaFyMPvbOuOMOWYWEZA86IFpZQWLBn4=;
	b=j3VR5DbyoEcoY2hfmObv/PKnjl7aUb2689QjE+gcKoIQEbCOPQdbuJP5yGMNUmR5XfLK1B
	HgdLFWF2jr2qJv7NMfsVT06uni39tXwpA9/WjNbNqq/lPugVCcBp48xC82A09XL3b/O2BW
	BmLEf/7i69238PTN9UmjxjDAqddWgzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706612680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEVz5JmWBEANKaFyMPvbOuOMOWYWEZA86IFpZQWLBn4=;
	b=yvHBdjZQthgfG6zpBOFsG6QnIvlJswOuf8brj2d/ZdRm0ChkyAl0i0Bf49QgoPuibHRMz2
	fpJ1DUp68i+/WKCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706612680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEVz5JmWBEANKaFyMPvbOuOMOWYWEZA86IFpZQWLBn4=;
	b=j3VR5DbyoEcoY2hfmObv/PKnjl7aUb2689QjE+gcKoIQEbCOPQdbuJP5yGMNUmR5XfLK1B
	HgdLFWF2jr2qJv7NMfsVT06uni39tXwpA9/WjNbNqq/lPugVCcBp48xC82A09XL3b/O2BW
	BmLEf/7i69238PTN9UmjxjDAqddWgzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706612680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEVz5JmWBEANKaFyMPvbOuOMOWYWEZA86IFpZQWLBn4=;
	b=yvHBdjZQthgfG6zpBOFsG6QnIvlJswOuf8brj2d/ZdRm0ChkyAl0i0Bf49QgoPuibHRMz2
	fpJ1DUp68i+/WKCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFF5D12FF7;
	Tue, 30 Jan 2024 11:04:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jUMhOcfXuGU4PQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 30 Jan 2024 11:04:39 +0000
Date: Tue, 30 Jan 2024 12:04:39 +0100
Message-ID: <87jznr3wvs.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kenzo Gomez <kenzo.sgomez@gmail.com>
Cc: alsa-devel@alsa-project.org,
	david.rhodes@cirrus.com,
	james.schulman@cirrus.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	perex@perex.cz,
	rf@opensource.cirrus.com,
	sbinding@opensource.cirrus.com,
	tiwai@suse.com
Subject: Re: [PATCH v3] ALSA: hda: cs35l41: Support additional ASUS Zenbook UX3402VA
In-Reply-To: <20240127164621.26431-1-kenzo.sgomez@gmail.com>
References: <874jfdwsfg.wl-tiwai@suse.de>
	<20240127164621.26431-1-kenzo.sgomez@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.60

On Sat, 27 Jan 2024 17:46:21 +0100,
Kenzo Gomez wrote:
> 
> Add new model entry into configuration table.
> 
> Signed-off-by: Kenzo Gomez <kenzo.sgomez@gmail.com>

Cirrus people, could you take a look?
I'm inclined to take as is, unless you have any objections.


thanks,

Takashi

> ---
>  sound/pci/hda/cs35l41_hda_property.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
> index 35277ce890a4..59504852adc6 100644
> --- a/sound/pci/hda/cs35l41_hda_property.c
> +++ b/sound/pci/hda/cs35l41_hda_property.c
> @@ -76,6 +76,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
>  	{ "10431533", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
>  	{ "10431573", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
>  	{ "10431663", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
> +	{ "104316A3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
>  	{ "104316D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
>  	{ "104316F3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
>  	{ "104317F3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
> @@ -410,6 +411,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
>  	{ "CSC3551", "10431533", generic_dsd_config },
>  	{ "CSC3551", "10431573", generic_dsd_config },
>  	{ "CSC3551", "10431663", generic_dsd_config },
> +	{ "CSC3551", "104316A3", generic_dsd_config },
>  	{ "CSC3551", "104316D3", generic_dsd_config },
>  	{ "CSC3551", "104316F3", generic_dsd_config },
>  	{ "CSC3551", "104317F3", generic_dsd_config },
> -- 
> 2.43.0
> 

