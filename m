Return-Path: <linux-kernel+bounces-13514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0543820789
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 17:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4ABA1C21387
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43323B662;
	Sat, 30 Dec 2023 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QsXO5n2h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="irZxf2fQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QsXO5n2h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="irZxf2fQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95C28F45;
	Sat, 30 Dec 2023 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6417C1F822;
	Sat, 30 Dec 2023 16:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703955551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vfzN6NhKAtjc7zH+0FmYY2Pnf+rrbAm9voajSr74Ws=;
	b=QsXO5n2h3CJlV1/tpiefgXlPVF2QMUdBk1cvz6d/QWU4YaokynC1LLSThKSX6ShGDmIF0K
	wRwXvK4SRkWKV2tuS9IX5xBifRn4eM7HuB6AOxEi3VI9SbWDnvkvaMHSJtNd2JY4FW4S41
	NYgoaBWBZom1uh15Pk1GAvMddcYlpIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703955551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vfzN6NhKAtjc7zH+0FmYY2Pnf+rrbAm9voajSr74Ws=;
	b=irZxf2fQhY4IsGPJzRxNohxJkXBKdpT2hX6AL9tmZlN6+jS5ki/f4zyo2hLy0m+95kKLSX
	4+hMkNyT0uXbwaDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703955551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vfzN6NhKAtjc7zH+0FmYY2Pnf+rrbAm9voajSr74Ws=;
	b=QsXO5n2h3CJlV1/tpiefgXlPVF2QMUdBk1cvz6d/QWU4YaokynC1LLSThKSX6ShGDmIF0K
	wRwXvK4SRkWKV2tuS9IX5xBifRn4eM7HuB6AOxEi3VI9SbWDnvkvaMHSJtNd2JY4FW4S41
	NYgoaBWBZom1uh15Pk1GAvMddcYlpIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703955551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vfzN6NhKAtjc7zH+0FmYY2Pnf+rrbAm9voajSr74Ws=;
	b=irZxf2fQhY4IsGPJzRxNohxJkXBKdpT2hX6AL9tmZlN6+jS5ki/f4zyo2hLy0m+95kKLSX
	4+hMkNyT0uXbwaDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D6BE13782;
	Sat, 30 Dec 2023 16:59:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SOxdAV9MkGW4AgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 30 Dec 2023 16:59:11 +0000
Date: Sat, 30 Dec 2023 17:59:10 +0100
Message-ID: <87il4fwrs1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 0/4] ALSA: hda/tas2781: Add tas2563 support
In-Reply-To: <cover.1703891777.git.soyer@irl.hu>
References: <cover.1701906455.git.soyer@irl.hu>
	<cover.1703891777.git.soyer@irl.hu>
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
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QsXO5n2h;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=irZxf2fQ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.74 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.14)[-0.701];
	 FREEMAIL_CC(0.00)[ti.com,perex.cz,suse.com,gmail.com,kernel.org,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.29)[74.81%]
X-Spam-Score: -2.74
X-Rspamd-Queue-Id: 6417C1F822
X-Spam-Flag: NO

On Sat, 30 Dec 2023 01:09:41 +0100,
Gergo Koteles wrote:
> 
> The tas2781-hda driver can be modified to support tas2563 as well.
> Before knowing this information, I created another series for a
> new driver.
> Link: https://lore.kernel.org/lkml/cover.1701733441.git.soyer@irl.hu/
> 
> This series now extends tas2781-hda.
> 
> The tas2563 is a smart amplifier. Similar to tas2562 but with DSP. Some
> Lenovo laptops have it to drive the bass speakers. By default, it is in
> software shutdown state.
> 
> To make the DSP work it needs a firmware and some calibration data.
> The latter can be read from the EFI in Lenovo laptops.
> 
> For the correct configuration it needs additional register data.
> It captured after running the Windows driver.
> 
> The firmware can be extracted as TAS2563Firmware.bin from the Windows
> driver with innoextract.
> https://download.lenovo.com/consumer/mobiles/h5yd037fbfyy7kd0.exe
> 
> The driver will search for it as TAS2XXX3870.bin with the Lenovo Yoga 7 
> 14ARB7.
> 
> The captured registers extracted with TI's regtool: 
> https://github.com/soyersoyer/tas2563rca/raw/main/INT8866RCA2.bin
> 
> Changes since v1:
> - fixes were sent as individual patches
> - rebased onto for-next
> - adding the missed fixup
> 
> Gergo Koteles (4):
>   ALSA: hda/tas2781: add ptrs to calibration functions
>   ALSA: hda/tas2781: add configurable global i2c address
>   ALSA: hda/tas2781: add TAS2563 support for 14ARB7
>   ALSA: hda/tas2781: add fixup for Lenovo 14ARB7

Thanks, I guess I'll take this series later for 6.8 unless any
objection is raised from reviewers.

But, I'd like to hear clarifications of some points beforehand:

- Did we get consensus about the ACPI HID?  I didn't follow the
  previous thread completely.

  Since those models have been already in the market for quite some
  time, we'd have to accept "INT8866", I'm afraid.  But it's still
  very important to know whether a similar problem can be avoided in
  future.

- Will be the firmware files upstreamed to linux-firmware tree later?
  Otherwise users will have significant difficulties.


Takashi

