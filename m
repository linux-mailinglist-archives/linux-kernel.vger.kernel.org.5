Return-Path: <linux-kernel+bounces-90173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1448B86FB66
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507CF281DE7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC35A171B0;
	Mon,  4 Mar 2024 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RM9Nev/0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tvADZt7s";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RM9Nev/0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tvADZt7s"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7157017589;
	Mon,  4 Mar 2024 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540014; cv=none; b=GFnDQqG8hzRkowbs7noty5OdMZjn2qpp/3fMg+/xfBy8RkPoNTU6XPlLiuXVB54eMNG35UiuRqcviP8dkzfOS241cmvMN4F5HaK2/97a416mi5iIQGJvT+BAIeOC21RxwSdy7z9vORr/2HhaFxf5bLDc2rXchbEeLacisafqOvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540014; c=relaxed/simple;
	bh=oO135Fa/uS3SIRBNyJjRCHjRGBBD0/Uzfhsefl3DMTM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9cLD4mj/QKdF+Uwq2F1gzX51Xaiv6/4HSB1dY1tCiLUbG+oPY1fwn75dMm5Mi/FLul/H4DlRcpW122E1APyNIRqn4Mc59wIuFfwpP17fArRzH8jkOuLgZq2W2nVkOurRVRiRpPbbuJC/NY1hk2zrvuf5tvrJQjtJbIHC6Nof3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RM9Nev/0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tvADZt7s; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RM9Nev/0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tvADZt7s; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F416C4DCF1;
	Mon,  4 Mar 2024 08:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709540005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KRMWlyBJcUjbUDZsGjmU9vTL1z05F0OtmydHQLE3nTs=;
	b=RM9Nev/04IT+HRrBGWR/jZnC8y0aHt3QTqK9gRvdj3q5AfKWwuGKFm7Ebw9HsPsnaDQuM1
	C0kcq3gixND3kAM06wlwT626vsO6+6Ke2qcl4DM8pMdA6xKoZwcmSNkVWoYOmHEfHMzeza
	CHsTIFI3r+s6TAZ5qmEGZYZk4Kzfyi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709540005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KRMWlyBJcUjbUDZsGjmU9vTL1z05F0OtmydHQLE3nTs=;
	b=tvADZt7s+HdTSMFbP7gkI8TvODp64I2R1YZuSwookWkqrnnxCooO+wskyrGUVx/bMKKiw/
	cGPOWCsA76JD50AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709540005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KRMWlyBJcUjbUDZsGjmU9vTL1z05F0OtmydHQLE3nTs=;
	b=RM9Nev/04IT+HRrBGWR/jZnC8y0aHt3QTqK9gRvdj3q5AfKWwuGKFm7Ebw9HsPsnaDQuM1
	C0kcq3gixND3kAM06wlwT626vsO6+6Ke2qcl4DM8pMdA6xKoZwcmSNkVWoYOmHEfHMzeza
	CHsTIFI3r+s6TAZ5qmEGZYZk4Kzfyi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709540005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KRMWlyBJcUjbUDZsGjmU9vTL1z05F0OtmydHQLE3nTs=;
	b=tvADZt7s+HdTSMFbP7gkI8TvODp64I2R1YZuSwookWkqrnnxCooO+wskyrGUVx/bMKKiw/
	cGPOWCsA76JD50AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6BF913A58;
	Mon,  4 Mar 2024 08:13:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eL9tK6SC5WW9aAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 04 Mar 2024 08:13:24 +0000
Date: Mon, 04 Mar 2024 09:13:24 +0100
Message-ID: <8734t62z4r.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH v1 0/3] ALSA: hda: cs35l41: Add support for a couple of Lenovo and Asus Laptops
In-Reply-To: <20240301160154.158398-1-sbinding@opensource.cirrus.com>
References: <20240301160154.158398-1-sbinding@opensource.cirrus.com>
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
X-Spam-Score: -3.24
X-Spamd-Result: default: False [-3.24 / 50.00];
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
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.94)[99.75%]
X-Spam-Flag: NO

On Fri, 01 Mar 2024 17:01:51 +0100,
Stefan Binding wrote:
> 
> Add support for a couple of Lenovo Thinkbook 16P laptops using CS35L41
> HDA. Also fix a _DSD BIOS error for the ASUS UM5302LA laptop.
> 
> Stefan Binding (3):
>   ALSA: hda: cs35l41: Support Lenovo Thinkbook 16P
>   ALSA: hda/realtek: Add quirks for Lenovo Thinkbook 16P laptops
>   ALSA: hda: cs35l41: Overwrite CS35L41 configuration for ASUS UM5302LA

Thanks, applied now.


Takashi

