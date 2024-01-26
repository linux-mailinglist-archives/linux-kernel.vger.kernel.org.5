Return-Path: <linux-kernel+bounces-40252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E6D83DD34
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6B4282A51
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC73D1CF8B;
	Fri, 26 Jan 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T6yvCaEW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wGfagHKN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T6yvCaEW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wGfagHKN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770AA1CD34;
	Fri, 26 Jan 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282101; cv=none; b=mC49LiTf5fyI2KLzy4vcKG8otLwpfL0M3Fcz6vhP2gkFg5qmTOCrGUDF4G8Zb93tqbt0hZ3Xcxb6IZh/4z5ooWEKqVcT55lYvXUBxJFCV0W+Qmo/Z+RMekejGtXdKw5DKEeW82mGz7JDuwWU1tCzSLpk5S+IoyXu+spfFEuG/9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282101; c=relaxed/simple;
	bh=xR5OqKJHgzoeSr73MWTEO6XlarE2SYI2VkCSpnevdKY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nD7wgp8AV2cIUAldqttO1JjuwJjIH2N8RXgG7coZruTJRdKM45GcT3gzT/cSWm5VNZf4Q6TIw+hEb+1mOsHsE8cyV2ccoHvbWJYAPCFSQHwQ19o7rEpLPEI7SWGLSQR5ZDWqeCpO3/wd4PFLd0OsO6KnaFA1cUyT+dom002SdwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T6yvCaEW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wGfagHKN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T6yvCaEW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wGfagHKN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 54CF721DCF;
	Fri, 26 Jan 2024 15:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706282097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S4SUEWYijM+vF7TtPJURVmNeX8K+VvFmQtAMWbV0ogA=;
	b=T6yvCaEWFmiN6iq977b+hnl19VCDk4Ndf8wJTFRj3l/8brTsEMDM7q7J4BPEOhMTeaJy2t
	82yxPTPkgsKimrFakGEbqJItroFrcFtv07EuqERdczaOOkfAreJ03BKkCTSRw1OVGQw1gS
	pMGQ/Yim/a0CrywxV5fLIfYyH8tpQ/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706282097;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S4SUEWYijM+vF7TtPJURVmNeX8K+VvFmQtAMWbV0ogA=;
	b=wGfagHKNEN6Y39n6r13lPlKa1yUJhNSQJhFUqp8KLJoDmpXQ5xqbdXGF1p4XM6CNHofRD0
	mi814hTVqi4rp3Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706282097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S4SUEWYijM+vF7TtPJURVmNeX8K+VvFmQtAMWbV0ogA=;
	b=T6yvCaEWFmiN6iq977b+hnl19VCDk4Ndf8wJTFRj3l/8brTsEMDM7q7J4BPEOhMTeaJy2t
	82yxPTPkgsKimrFakGEbqJItroFrcFtv07EuqERdczaOOkfAreJ03BKkCTSRw1OVGQw1gS
	pMGQ/Yim/a0CrywxV5fLIfYyH8tpQ/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706282097;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S4SUEWYijM+vF7TtPJURVmNeX8K+VvFmQtAMWbV0ogA=;
	b=wGfagHKNEN6Y39n6r13lPlKa1yUJhNSQJhFUqp8KLJoDmpXQ5xqbdXGF1p4XM6CNHofRD0
	mi814hTVqi4rp3Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 170BB134C3;
	Fri, 26 Jan 2024 15:14:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +3UqBHHMs2X0fwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 26 Jan 2024 15:14:57 +0000
Date: Fri, 26 Jan 2024 16:14:56 +0100
Message-ID: <87wmrwnn2n.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH v1 0/4] Support HP Models without _DSD
In-Reply-To: <20240126113007.4084-1-sbinding@opensource.cirrus.com>
References: <20240126113007.4084-1-sbinding@opensource.cirrus.com>
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
X-Spam-Level: 
X-Spam-Score: -2.61
X-Spamd-Result: default: False [-2.61 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.996];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.31)[96.79%]
X-Spam-Flag: NO

On Fri, 26 Jan 2024 12:30:03 +0100,
Stefan Binding wrote:
> 
> Add Quirks and driver properties for Dell models.
> Driver properties are required since these models do not have _DSD.
> Some models require special handing for Speaker ID and cannot use
> the configuration table to add properties.
> Also fix an issue for Channel Index property, when set through the
> configuration table, to use the same method as when loading _DSD
> properties. This is needed for laptops with 4 amps where the
> channels do not alternate.
> 
> Stefan Binding (4):
>   ALSA: hda: cs35l41: Set Channel Index correctly when system is missing
>     _DSD
>   ALSA: hda: cs35l41: Support additional HP Envy Models
>   ALSA: hda: cs35l41: Support HP models without _DSD using dual Speaker
>     ID
>   ALSA: hda/realtek: Add quirks for various HP ENVY models

The last one conflicts with the latest for-next branch due to the
recent change from Cirrus.  Could you rebase and resubmit?


thanks,

Takashi

