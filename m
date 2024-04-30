Return-Path: <linux-kernel+bounces-163471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A7D8B6BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E183B21CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0707381AD2;
	Tue, 30 Apr 2024 07:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kEySrfs2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gCvtzm7i";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kEySrfs2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gCvtzm7i"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759613F9FC;
	Tue, 30 Apr 2024 07:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462153; cv=none; b=Epw96ETnZwVE++brdkz8kJIEAdVc81UPI+nkvLv6PbjmyjZKQpJRiOs/UVxi4iAQT/TRSKMiWQ9mO2RRlaMOoRLwxo4y0jCKxKl3tuP6S2zEWNkiZLN4wHdnDRW3jnylB0665jruxxrusX1N4K5Xg40cmycdDNUHWy3zwwOPJbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462153; c=relaxed/simple;
	bh=lweGfDIlGI2nmsgmRB1WBR7R2QWr5hP78T1d5i2qsj8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLLu3o2MUeco4fqenRIy6KoTvLkO8RZqXciYqOhKIlHRYN9rcqUDWlxNCVuGQL/ByW7A/2B5XsDvQALOidffJJ7+f8+p1gfg54t8Vi4UqPNfUjxtasz7XQGQw29CdYN52vXq3DZYZr7AgD+X7rou+tCRGvsLetqMAv0vf8nFchI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kEySrfs2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gCvtzm7i; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kEySrfs2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gCvtzm7i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D2C41F7C7;
	Tue, 30 Apr 2024 07:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714462149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=69ZdtCtJjvr3V5TXSmtMXF57C4EjGwdpN/08M8Ut6SQ=;
	b=kEySrfs2e/papNB7c33RAcjpYFHuM0BbA6aXi0jYdZpKfmTX36UURTU4tlNO2fjcma9CnQ
	VC5IXT4Fp1hnnndqiWaBDVsB9U9N6lV/eVdl92/cjeJt1IwbNBIT7GyB/ZRpjUg+YJf6if
	vAkQhQ9PIZTDH3CseWUz2FY3GbozWLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714462149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=69ZdtCtJjvr3V5TXSmtMXF57C4EjGwdpN/08M8Ut6SQ=;
	b=gCvtzm7iVM1AABXqCJvvc2njO8UJCGR3lLVj8/SREf69eae9eJTWfcZ1ZqmPsApGBuRjX9
	qoqsyj7Ftsg+PWCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714462149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=69ZdtCtJjvr3V5TXSmtMXF57C4EjGwdpN/08M8Ut6SQ=;
	b=kEySrfs2e/papNB7c33RAcjpYFHuM0BbA6aXi0jYdZpKfmTX36UURTU4tlNO2fjcma9CnQ
	VC5IXT4Fp1hnnndqiWaBDVsB9U9N6lV/eVdl92/cjeJt1IwbNBIT7GyB/ZRpjUg+YJf6if
	vAkQhQ9PIZTDH3CseWUz2FY3GbozWLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714462149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=69ZdtCtJjvr3V5TXSmtMXF57C4EjGwdpN/08M8Ut6SQ=;
	b=gCvtzm7iVM1AABXqCJvvc2njO8UJCGR3lLVj8/SREf69eae9eJTWfcZ1ZqmPsApGBuRjX9
	qoqsyj7Ftsg+PWCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49239133A7;
	Tue, 30 Apr 2024 07:29:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X5C2EMWdMGYRNAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 30 Apr 2024 07:29:09 +0000
Date: Tue, 30 Apr 2024 09:29:21 +0200
Message-ID: <87edannwa6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH v1 0/2] ALSA: hda: cs35l41: Ignore errors when configuring interrupts to allow laptops with bad ACPI to play audio
In-Reply-To: <20240429154853.9393-1-sbinding@opensource.cirrus.com>
References: <20240429154853.9393-1-sbinding@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -2.58
X-Spam-Level: 
X-Spamd-Result: default: False [-2.58 / 50.00];
	BAYES_HAM(-2.28)[96.64%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Mon, 29 Apr 2024 17:48:51 +0200,
Stefan Binding wrote:
> 
> Some laptops have a bad _CRS defined for its interrupt.
> This errors out inside the driver probe for CS35L41 HDA.
> However, there is no fix in software for this bad configuration,
> and it is unlikely to get a new BIOS, therefore it is better to
> allow the laptop to continue probe, instead of erroring out inside
> the probe. The interrupt is only used for Error Detection and
> recovery, without the interrupt the driver will continue to function,
> but errors will not be detected, and recovery will require a reboot.
> 
> Also add support for ASUS ROG 2024 laptops.
> These laptops were released without _DSD, so need to be added into
> the CS35L41 config table. Quirks for these laptops already exist.
> 
> Stefan Binding (2):
>   ALSA: hda: cs35l41: Ignore errors when configuring IRQs
>   ALSA: hda: cs35l41: Add support for ASUS ROG 2024 Laptops

Thanks, applied both patches to for-next branch now.


Takashi

