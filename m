Return-Path: <linux-kernel+bounces-160215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C5F8B3AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28781F2111B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1123A149003;
	Fri, 26 Apr 2024 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="evDT79gS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VbIG4GZT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XxlbJUAG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lXxQTYOC"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D3814885D;
	Fri, 26 Apr 2024 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144125; cv=none; b=B211gA+zjNMN6X0PTfIT41S0H2TOR0d+qM0WzYnCQlEUc+tnOGKxBd5eXRIjxMNxUzNx2JgxKF8L0P7A9MxLxpwStM4PK3pHw/XaNa8eAp0PqEoYP9RZjAA0r6Jkm4+q2U+gweMvRLkTvx+v7LOzgGMjbbIfKs/YAKySbjpjUI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144125; c=relaxed/simple;
	bh=UGBS6UWaXM1p5rTzuuVlN3dBmXfGiZm+cK1RKFexZvc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSaFNx43RiYZl1+qjZaCkQSZeAPHQFAoV21wteuwf7FFuNiyrPAzXu5Yf/tD25K0W4lLG0TPYtZr57dAXkZQpxY+RA9uLdiV9r/LarpaRpfsgwJJq11Z6qn9mTu0r7u8EYR9iHIQAZjuwBHZqgYTSp0I8aG7im7/59jBDrxhEj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=evDT79gS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VbIG4GZT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XxlbJUAG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lXxQTYOC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB8135D23E;
	Fri, 26 Apr 2024 15:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714144114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/RIal2x/fOxrYv19regwNkcgG8g/gUeT8uDQISy/Mj8=;
	b=evDT79gSCBT5QeOYt6WVCxDps7iHTc4O2FfiaTNK6t+g3H79iGVj5r9Y6Lkgo6Avfsn/Pi
	uzKqICSkLFBBBrP5ekfOrdkguCd38w2xluYyG9TsGq+SkVQl7I2oYFsMR/IZKZ5YoviFUt
	FkqiNpjsA+3rHux+P4o85rYe6BsRyCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714144114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/RIal2x/fOxrYv19regwNkcgG8g/gUeT8uDQISy/Mj8=;
	b=VbIG4GZTMxUGY62z/vBjGhiRgYa31nl+h7HIVDvexGZpg1/cmvqmeATiHQyFC81htXazYz
	/mHhv7ItLdJlJYDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714144113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/RIal2x/fOxrYv19regwNkcgG8g/gUeT8uDQISy/Mj8=;
	b=XxlbJUAGF3muCA8b0lx1Xqty/94yLat2QlpNGpZLiCwHe6wzP6VNaW6BUEdRCOKFHZUjjv
	69cI+s9qhvfVJcglT8mzXQAZW1szOiQ9gM0j0d3CWsCcMvYOHa2mRRZl8ENfO71rVSA8pI
	AeT6w0zR6QEp/re9BWgwWiffwDkFAnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714144113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/RIal2x/fOxrYv19regwNkcgG8g/gUeT8uDQISy/Mj8=;
	b=lXxQTYOCCXo18CBHN+JZqzwBFes4+s7brVZT6E30GjfK+VjLQnthnHH9JyM0TGASmUuDYd
	+GAoQmslDCZjdaBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC7A81398B;
	Fri, 26 Apr 2024 15:08:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qBhYKHHDK2b1fAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 26 Apr 2024 15:08:33 +0000
Date: Fri, 26 Apr 2024 17:08:44 +0200
Message-ID: <87il042mbn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Colin Ian King <colin.i.king@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ALSA: kunit: make read-only array buf_samples static const
In-Reply-To: <81a9e3c2-2c44-406e-af19-90d9dcfe4a92@gmail.com>
References: <20240425160754.114716-1-colin.i.king@gmail.com>
	<20240425232250.GA205425@workstation.local>
	<81a9e3c2-2c44-406e-af19-90d9dcfe4a92@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[sakamocchi.jp,gmail.com,perex.cz,suse.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -1.80
X-Spam-Flag: NO

On Fri, 26 Apr 2024 14:05:34 +0200,
Ivan Orlov wrote:
> 
> On 4/26/24 00:22, Takashi Sakamoto wrote:
> > Hi,
> > 
> > On Thu, Apr 25, 2024 at 05:07:54PM +0100, Colin Ian King wrote:
> >> Don't populate the read-only array buf_samples on the stack at
> >> run time, instead make it static const.
> >> 
> >> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> >> ---
> >>   sound/core/sound_kunit.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/sound/core/sound_kunit.c b/sound/core/sound_kunit.c
> >> index eb90f62228c0..e34c4317f5eb 100644
> >> --- a/sound/core/sound_kunit.c
> >> +++ b/sound/core/sound_kunit.c
> >> @@ -167,7 +167,7 @@ static void _test_fill_silence(struct kunit *test, struct snd_format_test_data *
> >>     static void test_format_fill_silence(struct kunit *test)
> >>   {
> >> -	u32 buf_samples[] = { 10, 20, 32, 64, 129, SILENCE_BUFFER_MAX_FRAMES };
> >> +	static const u32 buf_samples[] = { 10, 20, 32, 64, 129, SILENCE_BUFFER_MAX_FRAMES };
> >>   	u8 *buffer;
> >>   	u32 i, j;
> > 
> > Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> > 
> > We can see the other similar cases in the kunit file. I'll post the fix
> > later.
> > 
> 
> Hi Takashi,
> 
> Hmm, correct me if I'm wrong, but I don't see any other significant
> allocations on the stack in the test.

I guess he meant slightly different ones
  https://lore.kernel.org/r/20240425233653.218434-1-o-takashi@sakamocchi.jp


Takashi

