Return-Path: <linux-kernel+bounces-63541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B27A8530FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53038283F79
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DEC482EE;
	Tue, 13 Feb 2024 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jbiwsb5U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GAEUyXMj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jbiwsb5U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GAEUyXMj"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB43383AE;
	Tue, 13 Feb 2024 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828984; cv=none; b=H1H/0BZzPKD9Jb2VLQB2TmzjAFHJlpIHOP4aISKBsqKGFgaZrx1v0N43uyjaLgffqcj531Ag5mbrHPxBYLrAn8Pkq8sJPbMF3++B/rDgxa19aqvac4TF2WCukSy68iNXo7SOtM79qWwBf8R5nUB/jt5+n4h6f7M2WKvyZp8R8pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828984; c=relaxed/simple;
	bh=t1x649ig19aP6KHbfZwn5EC4H55tmsOlY9ADZyGqX1A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=npyCXFbGRKvjdH6LPQbxij47OH63z9Gc3DKOVJcPCAqBj2G6EtVJJ3LxBZvGlbmy1cRolAMGA9BnQl/9N+ivTn4PajnINN4hoG/edvsIuLI+X/r2+K4noTMF4aD99OIOea27w6mO3GkvpgOLbTLwyC/z55WWVrq86orxxLUesI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jbiwsb5U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GAEUyXMj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jbiwsb5U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GAEUyXMj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C408C21CCD;
	Tue, 13 Feb 2024 12:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707828980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XZxzAm1AtsNglX5/RVCycu9VVDNzxxqqfa1iuH8Lttc=;
	b=jbiwsb5U8m7im9qAiRpvb7++489pbODKjl1JF+wwF12q+/e4CYLSHODtnGpOZdQtYFmshF
	hUc5d1ap0fc9br1cuQXMcPfcYcbowBlfD3R+M9HH4b5/ays5fUW1bJQ6v0hOoVLeuovvUE
	ZFUYyUcK3kYsvtPiE0OzVWJoyVZTXW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707828980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XZxzAm1AtsNglX5/RVCycu9VVDNzxxqqfa1iuH8Lttc=;
	b=GAEUyXMjAaktrXRIIkJcP8QJbCBrdb3DUt1ZgdEOziHmva61PThKob1XNQlgHs/fDGCQvB
	RWQrZgWFvUTg/2Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707828980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XZxzAm1AtsNglX5/RVCycu9VVDNzxxqqfa1iuH8Lttc=;
	b=jbiwsb5U8m7im9qAiRpvb7++489pbODKjl1JF+wwF12q+/e4CYLSHODtnGpOZdQtYFmshF
	hUc5d1ap0fc9br1cuQXMcPfcYcbowBlfD3R+M9HH4b5/ays5fUW1bJQ6v0hOoVLeuovvUE
	ZFUYyUcK3kYsvtPiE0OzVWJoyVZTXW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707828980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XZxzAm1AtsNglX5/RVCycu9VVDNzxxqqfa1iuH8Lttc=;
	b=GAEUyXMjAaktrXRIIkJcP8QJbCBrdb3DUt1ZgdEOziHmva61PThKob1XNQlgHs/fDGCQvB
	RWQrZgWFvUTg/2Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9892413404;
	Tue, 13 Feb 2024 12:56:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6YyyI/Rmy2XxEAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Feb 2024 12:56:20 +0000
Date: Tue, 13 Feb 2024 13:56:20 +0100
Message-ID: <87il2sy13f.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Curtis Malainey <cujomalainey@chromium.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] ALSA: fix function cast warnings
In-Reply-To: <20240213101020.459183-1-arnd@kernel.org>
References: <20240213101020.459183-1-arnd@kernel.org>
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
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[yandex.ru];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[perex.cz,suse.com,arndb.de,kernel.org,google.com,chromium.org,yandex.ru,vger.kernel.org,lists.linux.dev];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue, 13 Feb 2024 11:09:56 +0100,
Arnd Bergmann wrote:
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-16 points out a control flow integrity (kcfi) issue when event
> callbacks get converted to incompatible types:
> 
> sound/core/seq/seq_midi.c:135:30: error: cast from 'int (*)(struct snd_rawmidi_substream *, const char *, int)' to 'snd_seq_dump_func_t' (aka 'int (*)(void *, void *, int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>   135 |                 snd_seq_dump_var_event(ev, (snd_seq_dump_func_t)dump_midi, substream);
>       |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/core/seq/seq_virmidi.c:83:31: error: cast from 'int (*)(struct snd_rawmidi_substream *, const unsigned char *, int)' to 'snd_seq_dump_func_t' (aka 'int (*)(void *, void *, int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>    83 |                         snd_seq_dump_var_event(ev, (snd_seq_dump_func_t)snd_rawmidi_receive, vmidi->substream);
>       |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Change these both to take a 'const void *' buffer and a 'void *' context,
> converting to the respective types in the callee. The change to 'const'
> buffers propagates to a couple of other functions.
> 
> The code was originally added with the initial ALSA merge in linux-2.5.4.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/sound/rawmidi.h            | 3 +--
>  include/sound/seq_kernel.h         | 2 +-
>  sound/core/rawmidi.c               | 6 +++---
>  sound/core/seq/oss/seq_oss_readq.c | 4 ++--
>  sound/core/seq/oss/seq_oss_readq.h | 2 +-
>  sound/core/seq/seq_memory.c        | 4 ++--
>  sound/core/seq/seq_midi.c          | 5 +++--
>  sound/core/seq/seq_virmidi.c       | 2 +-
>  8 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
> index f31cabf0158c..91947fb16e07 100644
> --- a/include/sound/rawmidi.h
> +++ b/include/sound/rawmidi.h
> @@ -161,8 +161,7 @@ int snd_rawmidi_free(struct snd_rawmidi *rmidi);
>  
>  /* callbacks */
>  
> -int snd_rawmidi_receive(struct snd_rawmidi_substream *substream,
> -			const unsigned char *buffer, int count);
> +int snd_rawmidi_receive(void *ptr, const void *buffer, int count);

If it were only about the type of the buffer argument being a void
pointer, it's fine.  But the substream argument should be explicitly
typed, otherwise it's confusing for other normal call patterns.

I guess the suitable fix for now would be to provide wrapper functions
that are used for callbacks and bridge to the actual function with
pointer cast, something like below.  Eventually we can put more const,
but it's basically irrelevant with the warning itself.


thanks,

Takashi

-- 8< --
--- a/sound/core/seq/seq_midi.c
+++ b/sound/core/seq/seq_midi.c
@@ -113,6 +113,12 @@ static int dump_midi(struct snd_rawmidi_substream *substream, const char *buf, i
 	return 0;
 }
 
+/* callback for snd_seq_dump_var_event(), bridging to dump_midi() */
+static int __dump_midi(void *ptr, void *buf, int count)
+{
+	return dump_midi(ptr, buf, count);
+}
+
 static int event_process_midi(struct snd_seq_event *ev, int direct,
 			      void *private_data, int atomic, int hop)
 {
@@ -132,7 +138,7 @@ static int event_process_midi(struct snd_seq_event *ev, int direct,
 			pr_debug("ALSA: seq_midi: invalid sysex event flags = 0x%x\n", ev->flags);
 			return 0;
 		}
-		snd_seq_dump_var_event(ev, (snd_seq_dump_func_t)dump_midi, substream);
+		snd_seq_dump_var_event(ev, __dump_midi, substream);
 		snd_midi_event_reset_decode(msynth->parser);
 	} else {
 		if (msynth->parser == NULL)
--- a/sound/core/seq/seq_virmidi.c
+++ b/sound/core/seq/seq_virmidi.c
@@ -62,6 +62,13 @@ static void snd_virmidi_init_event(struct snd_virmidi *vmidi,
 /*
  * decode input event and put to read buffer of each opened file
  */
+
+/* callback for snd_seq_dump_var_event(), bridging to snd_rawmidi_receive() */
+static int dump_to_rawmidi(void *ptr, void *buf, int count)
+{
+	return snd_rawmidi_receive(ptr, buf, count);
+}
+
 static int snd_virmidi_dev_receive_event(struct snd_virmidi_dev *rdev,
 					 struct snd_seq_event *ev,
 					 bool atomic)
@@ -80,7 +87,7 @@ static int snd_virmidi_dev_receive_event(struct snd_virmidi_dev *rdev,
 		if (ev->type == SNDRV_SEQ_EVENT_SYSEX) {
 			if ((ev->flags & SNDRV_SEQ_EVENT_LENGTH_MASK) != SNDRV_SEQ_EVENT_LENGTH_VARIABLE)
 				continue;
-			snd_seq_dump_var_event(ev, (snd_seq_dump_func_t)snd_rawmidi_receive, vmidi->substream);
+			snd_seq_dump_var_event(ev, dump_to_rawmidi, vmidi->substream);
 			snd_midi_event_reset_decode(vmidi->parser);
 		} else {
 			len = snd_midi_event_decode(vmidi->parser, msg, sizeof(msg), ev);

