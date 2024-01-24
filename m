Return-Path: <linux-kernel+bounces-37270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECC283AD8C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F328D1C24481
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851147C09F;
	Wed, 24 Jan 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QhPwtVPg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="upTWk8im";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QhPwtVPg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="upTWk8im"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301721E503;
	Wed, 24 Jan 2024 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110829; cv=none; b=fhJ9OKrNVUIadTmsJ+PDAybfPK2/ei+RCKUbLZKEAni4+sHLQE4v9244ojsagsIhu30h8QLWskY/FS0AahN2VdmSELxatBcgH1KFRHfr5bEPacxOUUZ1yQwz4bXcrR2vUmzI0Zuvra9CJP2zjh55tmxD9+R1TvIva9O/xpOtiNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110829; c=relaxed/simple;
	bh=pM7Og7SVpD0K9VmiAkA8Ep/mDsPV1pMCJYaK3vfTavI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ltj3IdP38mB8DNGkgNbFPmJjKfTe1OD0aT4pOho0vkJ6L8iRJYzm1AQVuu7PZPj4D3zlpxgM1sdJLkyzg1GC4EpCB7M2CayxoDiG2mJ93XNyxMu7SEk80XCXLmWgre+XmzIl0SnX8x6BYvP8LDdbAKQVudLwuwtcYLaXTii2Paw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QhPwtVPg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=upTWk8im; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QhPwtVPg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=upTWk8im; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 439211F7E5;
	Wed, 24 Jan 2024 15:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706110826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bAPaPbRzIYK27PGLjL/yZrS5FIUuz/u2iqA6zj1bu6E=;
	b=QhPwtVPgGGIPk/J/cMtGurskI5Z6kNYDwxW0RRHBvjEiNKO4apjjqFMBMQjH9XIGrNoXUs
	CbNK0cERzcOZuHbeWU87gBo6bDQmB856TWLNrRHgC4L0qMYOovQaEU68fM8vm7ewAp+VJo
	ue5YvOeaUlo5PIzGYNlMAp8TFUHobE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706110826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bAPaPbRzIYK27PGLjL/yZrS5FIUuz/u2iqA6zj1bu6E=;
	b=upTWk8imk9lVE8T/OQsF5cYdjBh3zPd6OcxP0RZ3rQeNT2zpgJqUK3PQKPwfoNQ4R0Bzm0
	oXH/A87l5enZ+SCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706110826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bAPaPbRzIYK27PGLjL/yZrS5FIUuz/u2iqA6zj1bu6E=;
	b=QhPwtVPgGGIPk/J/cMtGurskI5Z6kNYDwxW0RRHBvjEiNKO4apjjqFMBMQjH9XIGrNoXUs
	CbNK0cERzcOZuHbeWU87gBo6bDQmB856TWLNrRHgC4L0qMYOovQaEU68fM8vm7ewAp+VJo
	ue5YvOeaUlo5PIzGYNlMAp8TFUHobE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706110826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bAPaPbRzIYK27PGLjL/yZrS5FIUuz/u2iqA6zj1bu6E=;
	b=upTWk8imk9lVE8T/OQsF5cYdjBh3zPd6OcxP0RZ3rQeNT2zpgJqUK3PQKPwfoNQ4R0Bzm0
	oXH/A87l5enZ+SCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1631F13786;
	Wed, 24 Jan 2024 15:40:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /I8QBGovsWUBFAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 24 Jan 2024 15:40:26 +0000
Date: Wed, 24 Jan 2024 16:40:25 +0100
Message-ID: <87bk9aloye.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sean Young <sean@mess.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: add quirk for RODE NT-USB+
In-Reply-To: <20240124151524.23314-1-sean@mess.org>
References: <20240124151524.23314-1-sean@mess.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QhPwtVPg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=upTWk8im
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -5.51
X-Rspamd-Queue-Id: 439211F7E5
X-Spam-Flag: NO

On Wed, 24 Jan 2024 16:15:24 +0100,
Sean Young wrote:
> 
> The RODE NT-USB+ is marketed as a professional usb microphone, however the
> usb audio interface is a mess:
> 
> [    1.130977] usb 1-5: new full-speed USB device number 2 using xhci_hcd
> [    1.503906] usb 1-5: config 1 has an invalid interface number: 5 but max is 4
> [    1.503912] usb 1-5: config 1 has no interface number 4
> [    1.519689] usb 1-5: New USB device found, idVendor=19f7, idProduct=0035, bcdDevice= 1.09
> [    1.519695] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    1.519697] usb 1-5: Product: RØDE NT-USB+
> [    1.519699] usb 1-5: Manufacturer: RØDE
> [    1.519700] usb 1-5: SerialNumber: 1D773A1A
> [    8.327495] usb 1-5: 1:1: cannot get freq at ep 0x82
> [    8.344500] usb 1-5: 1:2: cannot get freq at ep 0x82
> [    8.365499] usb 1-5: 2:1: cannot get freq at ep 0x2
> 
> Add QUIRK_FLAG_GET_SAMPLE_RATE to work around the broken sample rate get.
> I have asked Rode support to fix it, but they show no interest.
> 
> Signed-off-by: Sean Young <sean@mess.org>

Applied now.  Thanks.


Takashi

