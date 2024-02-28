Return-Path: <linux-kernel+bounces-85359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0755A86B4BA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280741C23317
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0807B6EF0C;
	Wed, 28 Feb 2024 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m61ROf2f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rT8RwQiU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m61ROf2f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rT8RwQiU"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBFD6EEE1;
	Wed, 28 Feb 2024 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137484; cv=none; b=na4eqBhxF+c6K0OL3iAfaawIgOOOYlRw+H9b16wrnseDhrl+EUuXuXMDfy+6Ahc+RZXcO4oh6/NVRjUQrJdH9v21iYCT4e6D5+N7O/xU+OhV1VVyStG0g2Z4VV4LtPP+aHj3NaAK43e5ED6UDCB3nTSB8J2C8GASqJST+kjWwe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137484; c=relaxed/simple;
	bh=LutgMGWxuSH9zdQ63oIT9jf7k84JK3YEuonZSk/O6do=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sT4pnAAlYLsxYcS8pHFypNnTHHP5ceH68b4+MqTjVxoTUmWevB+T2M20w6fjTrxmt73vZtW48DmlZd1Wm6zC8jyqT473iIO2Y7s4G1NzpsspKVMyuueXR+HK3w45VOZ711XqAL6iIvfgoiMLbr935sEL7unKjn+YxFjFrMv1SYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m61ROf2f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rT8RwQiU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m61ROf2f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rT8RwQiU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26C3722195;
	Wed, 28 Feb 2024 16:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709137480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CvZXg0xCo89r9qKtyA9eQ8eOSDhPjhhMBxzcBmMnFQs=;
	b=m61ROf2fb56mGAxY8U4uH2DH/8yjILyDVrTJtctcEFVRfmXO38KaEq/yjAyBiPl1KRUyaR
	yye7ciTnGKO7AZobRMn0vuJ+ocLs8z+lzIQCWSr3XrTABdQLU7B3GWaOPKIY63OOfHsAjZ
	7Cg2XpQrKBACtNhF7XvPah58swRsZVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709137480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CvZXg0xCo89r9qKtyA9eQ8eOSDhPjhhMBxzcBmMnFQs=;
	b=rT8RwQiUVoxAom5hu4lU5kpA0kvfb5F30L/2zi7AS1KUisdg/Jc1EES1lo3epJkzupxfky
	fnzp2N7y2ccu81Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709137480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CvZXg0xCo89r9qKtyA9eQ8eOSDhPjhhMBxzcBmMnFQs=;
	b=m61ROf2fb56mGAxY8U4uH2DH/8yjILyDVrTJtctcEFVRfmXO38KaEq/yjAyBiPl1KRUyaR
	yye7ciTnGKO7AZobRMn0vuJ+ocLs8z+lzIQCWSr3XrTABdQLU7B3GWaOPKIY63OOfHsAjZ
	7Cg2XpQrKBACtNhF7XvPah58swRsZVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709137480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CvZXg0xCo89r9qKtyA9eQ8eOSDhPjhhMBxzcBmMnFQs=;
	b=rT8RwQiUVoxAom5hu4lU5kpA0kvfb5F30L/2zi7AS1KUisdg/Jc1EES1lo3epJkzupxfky
	fnzp2N7y2ccu81Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 905D913A58;
	Wed, 28 Feb 2024 16:24:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WO02IUde32V7EgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 28 Feb 2024 16:24:39 +0000
Date: Wed, 28 Feb 2024 17:24:39 +0100
Message-ID: <87il28h7zs.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Takashi Iwai" <tiwai@suse.de>,
	"Arnd Bergmann" <arnd@kernel.org>,
	"Kees Cook" <keescook@chromium.org>,
	"Jaroslav Kysela" <perex@perex.cz>,
	"Takashi Iwai" <tiwai@suse.com>,
	"Nathan Chancellor" <nathan@kernel.org>,
	"Nick Desaulniers" <ndesaulniers@google.com>,
	"Bill Wendling" <morbo@google.com>,
	"Justin Stitt" <justinstitt@google.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] ALSA: asihpi: work around clang-17+ false positive fortify-string warning
In-Reply-To: <1265517d-b98a-4ec6-9215-10cd988ff78f@app.fastmail.com>
References: <20240228140152.1824901-1-arnd@kernel.org>
	<87msrkhcz6.wl-tiwai@suse.de>
	<1265517d-b98a-4ec6-9215-10cd988ff78f@app.fastmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=m61ROf2f;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rT8RwQiU
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,arndb.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: 26C3722195
X-Spam-Flag: NO

On Wed, 28 Feb 2024 16:03:56 +0100,
Arnd Bergmann wrote:
> 
> On Wed, Feb 28, 2024, at 15:37, Takashi Iwai wrote:
> > On Wed, 28 Feb 2024 15:01:45 +0100,
> > Arnd Bergmann wrote:
> >> 
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> One of the memory copies in this driver triggers a warning about a
> >> possible out of range access:
> >> 
> >> In file included from /home/arnd/arm-soc/sound/pci/asihpi/hpimsgx.c:13:
> >> /home/arnd/arm-soc/include/linux/fortify-string.h:553:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
> >>   553 |                         __write_overflow_field(p_size_field, size);
> >>       |                         ^
> >
> > Hmm, I can't see the relevance of those messages with the code you
> > touched.  Do you have more info?
> 
> Not much. The warning is caused by this line:
> 
>         memcpy(&rESP_HPI_ADAPTER_OPEN[adapter], &hr,
>                 sizeof(rESP_HPI_ADAPTER_OPEN[0]));
> 
> rESP_HPI_ADAPTER_OPEN[] is a global array with a fixed
> length of 20 elements, and 'adapter' is a 16-bit index
> into that array. The warning is intended to trigger when
> there is a code path that will overflow, but it normally
> warns only if there is a known value range that the
> variable can take, not for an unrestricted index.
> 
> My first thought was that clang warns about it here because
> the 'u16 adapter' declaration limits the index to something
> smaller than an 'int' or 'long', but changing the type
> did not get rid of the warning.
> 
> >> Adding a range check avoids the problem, though I don't quite see
> >> why it warns in the first place if clang has no knowledge of the
> >> actual range of the type, or why I never saw the warning in previous
> >> randconfig tests.
> >
> > It's indeed puzzling.  If it's really about adapter_prepare() call,
> > the caller is only HPIMSGX__init(), and there is already an assignment
> > with that index value beforehand:
> >   hpi_entry_points[hr.u.s.adapter_index] = entry_point_func;
> >
> > and this array is also the size of HPI_MAX_ADAPTERS.  That is, the
> > same check should have caught here...
> 
> The fortified-string warning only triggers for string.h operations
> (memset, memcpy, memcmp, strn*...), not for a direct assignment.

Ah, I see.  Then from the logical POV, it's better to have a check
before that assignment; otherwise it'd overflow silently there.

Does putting the check beforehand (like the one below) fix similarly?


thanks,

Takashi

--- a/sound/pci/asihpi/hpimsgx.c
+++ b/sound/pci/asihpi/hpimsgx.c
@@ -708,7 +708,8 @@ static u16 HPIMSGX__init(struct hpi_message *phm,
 		phr->error = HPI_ERROR_PROCESSING_MESSAGE;
 		return phr->error;
 	}
-	if (hr.error == 0) {
+	if (hr.error == 0 &&
+	    hr.u.s.adapter_index < ARRAY_SIZE(rESP_HPI_ADAPTER_OPEN)) {
 		/* the adapter was created successfully
 		   save the mapping for future use */
 		hpi_entry_points[hr.u.s.adapter_index] = entry_point_func;

