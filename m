Return-Path: <linux-kernel+bounces-149601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 283508A9352
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924C51F21BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D062C6BB;
	Thu, 18 Apr 2024 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y9bgnkYp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Unpk3zC1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y9bgnkYp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Unpk3zC1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2062D03B;
	Thu, 18 Apr 2024 06:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422616; cv=none; b=Q1IEk02wsScv1oXiAWOEIX9Gd095ka3DbyspKXBWmFeJtJjaKP/VOmoIeRhxnN0LVW7uggrvwh836jgh0tkTrYuua+crc3jeTTHH6bQpc+Gpyt4n1GYuG8KmzI8ZVdQbepfhCefhR2frS7KqdWC8AZ5ZZ1UUIsRPoUEZCrxpdDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422616; c=relaxed/simple;
	bh=jFbHu/heAjXaIjCpcnhTfqFBsbEQCpoQU/YCuHvZGNU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvkbesDJ99UgENyC7CgdlLNDgx4N/9Jlu12rHwyHIwKPMNqsY1kC8xs/j1UId1Ycaf14fDE9qstseo2OYJmTPVofldiMA4UMt7Jyt9RXznyi1nj2IH1ouG1N2R8k68DSGS4bYrBGG+i0kf+dF1tGCYopclgJ0ant+kWHl+VV+oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y9bgnkYp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Unpk3zC1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y9bgnkYp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Unpk3zC1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B86E34A5E;
	Thu, 18 Apr 2024 06:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713422613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=60G8of3gS7cctmrTlQSZrR+KoHO+FvZsBEhHd82NKFw=;
	b=y9bgnkYplswsJEa+d/unVhrH4MaF2yk1g8S1kYWBu7f5Y0qKwt7+X9aGQEPU/iikseBiJh
	uf689J+o+kR7BuT2EZVYGffJcNALx+89H3V6iVwi96O6x4f+rf7r/XbzBppSLV5TuOa8mj
	r5GgYWpum/60oh1iFd0On9WeRnj6A5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713422613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=60G8of3gS7cctmrTlQSZrR+KoHO+FvZsBEhHd82NKFw=;
	b=Unpk3zC18OGtawvsjCHDNoJizTctGvVNN+BI2F7yfzhpxySdb7majp45PL4PIMuHK7+nrM
	sIX8bHjbUOPCVqCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713422613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=60G8of3gS7cctmrTlQSZrR+KoHO+FvZsBEhHd82NKFw=;
	b=y9bgnkYplswsJEa+d/unVhrH4MaF2yk1g8S1kYWBu7f5Y0qKwt7+X9aGQEPU/iikseBiJh
	uf689J+o+kR7BuT2EZVYGffJcNALx+89H3V6iVwi96O6x4f+rf7r/XbzBppSLV5TuOa8mj
	r5GgYWpum/60oh1iFd0On9WeRnj6A5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713422613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=60G8of3gS7cctmrTlQSZrR+KoHO+FvZsBEhHd82NKFw=;
	b=Unpk3zC18OGtawvsjCHDNoJizTctGvVNN+BI2F7yfzhpxySdb7majp45PL4PIMuHK7+nrM
	sIX8bHjbUOPCVqCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36AB513687;
	Thu, 18 Apr 2024 06:43:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mvscDBXBIGY9eAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 18 Apr 2024 06:43:33 +0000
Date: Thu, 18 Apr 2024 08:43:41 +0200
Message-ID: <87il0fxjaa.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH v2 0/7] Add features, fixes and laptops for CS35L41 HDA
In-Reply-To: <20240411110813.330483-1-sbinding@opensource.cirrus.com>
References: <20240411110813.330483-1-sbinding@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Thu, 11 Apr 2024 13:08:06 +0200,
Stefan Binding wrote:
> 
> This chain adds a number of improvements for CS35L41, including a new
> firmware loading feature, as well as some additional cleanup.
> 
> Patch 1 adds support for a new firmware tuning file which is used to set
> special tuning parameters used by the firmware. The HP Omen laptop added
> in patches 2 and 3 use such a feature.
> 
> Patch 4 changes the DSP1RX5/6 Source used by the firmware to depend on
> the boost type. A similar change in the ASoC driver will be needed later.
> 
> Patches 5 and 6 are cleanup patches, with the first of those re-using
> cs-amp-lib for calibration which as added for CS35L56 drivers, ensuring
> that all laptops are using the correct calibration values.
> 
> Patch 7 fixes a small error in the CS35L41 Property table for the
> Lenovo Legion slim 7 16ARHA7.
> 
> Changes since v1:
> - Fixed print statements based on warnings from kernel test robot
> 
> Richard Fitzgerald (1):
>   ALSA: hda: cs35l41: Remove redundant argument to
>     cs35l41_request_firmware_file()
> 
> Stefan Binding (6):
>   ALSA: hda: cs35l41: Set the max PCM Gain using tuning setting
>   ALSA: hda: cs35l41: Support HP Omen models without _DSD
>   ALSA: hda/realtek: Add quirks for HP Omen models using CS35L41
>   ALSA: hda: cs35l41: Update DSP1RX5/6 Sources for DSP config
>   ALSA: hda: cs35l41: Use shared cs-amp-lib to apply calibration
>   ALSA: hda: cs35l41: Remove Speaker ID for Lenovo Legion slim 7 16ARHA7

Now applied to for-next branch.  Thanks.


Takashi

