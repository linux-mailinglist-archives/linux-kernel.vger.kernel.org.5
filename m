Return-Path: <linux-kernel+bounces-4214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABADA817929
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2AC1F242AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E442474E06;
	Mon, 18 Dec 2023 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fo3WRtpx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jCecfQhV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fo3WRtpx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jCecfQhV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2274E39;
	Mon, 18 Dec 2023 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE5C51F450;
	Mon, 18 Dec 2023 17:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702921714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mByW+MzACC2iIlFrod5tliLDSa6iODdWULR3MPvcv1k=;
	b=fo3WRtpxplWsMWAJAgHAABgqYDphcx0eUH7HkrMTOkrTsEDgB8JYls43teIEmtgWVGHD4M
	QU8ucJXRpx3lcnVgXXYVrUjzMdpLCNQeOsnioexAX5m33H/UvnWDxJq9CEE9gPcZlKqJRL
	5vlqaV5As/6sl2lQAwGfDdY0Rw3WFKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702921714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mByW+MzACC2iIlFrod5tliLDSa6iODdWULR3MPvcv1k=;
	b=jCecfQhVtAhd+AteH8NwM9577MFzdVRpmEKwRYQFlQ5bL9gc/dwl0vWgmLthDCxI0ZMZbz
	5SmBHLRmHBcru5CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702921714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mByW+MzACC2iIlFrod5tliLDSa6iODdWULR3MPvcv1k=;
	b=fo3WRtpxplWsMWAJAgHAABgqYDphcx0eUH7HkrMTOkrTsEDgB8JYls43teIEmtgWVGHD4M
	QU8ucJXRpx3lcnVgXXYVrUjzMdpLCNQeOsnioexAX5m33H/UvnWDxJq9CEE9gPcZlKqJRL
	5vlqaV5As/6sl2lQAwGfDdY0Rw3WFKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702921714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mByW+MzACC2iIlFrod5tliLDSa6iODdWULR3MPvcv1k=;
	b=jCecfQhVtAhd+AteH8NwM9577MFzdVRpmEKwRYQFlQ5bL9gc/dwl0vWgmLthDCxI0ZMZbz
	5SmBHLRmHBcru5CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E08713894;
	Mon, 18 Dec 2023 17:48:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dOEwGfKFgGUSKgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 18 Dec 2023 17:48:34 +0000
Date: Mon, 18 Dec 2023 18:48:34 +0100
Message-ID: <878r5rz9jh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH v1 0/7] Add support for various laptops using CS35L41 HDA without _DSD
In-Reply-To: <20231218151221.388745-1-sbinding@opensource.cirrus.com>
References: <20231218151221.388745-1-sbinding@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 0.90
X-Spam-Flag: NO

On Mon, 18 Dec 2023 16:12:14 +0100,
Stefan Binding wrote:
> 
> The CS35L41 HDA driver requires various system defined properties to configure
> the driver for an individual system. For some laptops, these properties are
> missing in the BIOS. To be able to support these laptops, there is a mechanism
> in the driver to get this configuration from a lookup table, to be able to add
> or patch _DSD as necessary.
> 
> However this mechanism currently only allows for laptops to be patched one at
> a time, however, in the case where there are many laptops which need to be
> configured generically, a generic function has been added, with an additional
> lookup table to the individual laptops, indexed by SSID.
> 
> To support laptops using SPI without _DSD, an additional workaround is needed
> to be able to support the SPI Chip Select GPIOs whose resources are defined
> inside the _CRS for the Speaker ACPI Node. This workaround only works for
> SPI laptops which contain up to 2 amps, since the SPI controller would not
> allow more than 2 amps to be instantiated without the cs-gpios entry in
> _DSD.
> 
> These patches add support for various ASUS laptops without _DSD, but the
> framework added here allows for support for more laptops in the future
> for other manufacturers. Support for laptops without _DSD from other
> manufacturers is coming in the future.
> 
> Note: for systems which use modified _DSD to emulate the missing _DSD,
> these patches are incompatible, and the modified _DSD must be removed in
> order for the support through this framework to work for those laptops.
> 
> Stefan Binding (7):
>   ALSA: hda: cs35l41: Add config table to support many laptops without
>     _DSD
>   ALSA: hda: cs35l41: Support additional ASUS ROG 2023 models
>   ALSA: hda/realtek: Add quirks for ASUS ROG 2023 models
>   ALSA: hda: cs35l41: Support additional ASUS Zenbook 2022 Models
>   ALSA: hda/realtek: Add quirks for ASUS Zenbook 2022 Models
>   ALSA: hda: cs35l41: Support additional ASUS Zenbook 2023 Models
>   ALSA: hda/realtek: Add quirks for ASUS Zenbook 2023 Models

Applied all seven patches now.  Thanks.


Takashi

