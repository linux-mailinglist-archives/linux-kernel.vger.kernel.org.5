Return-Path: <linux-kernel+bounces-19200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1F38269B0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375B91F2130B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6265BE76;
	Mon,  8 Jan 2024 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nqy+cecd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i6wVTFVv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nqy+cecd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i6wVTFVv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC17BE49;
	Mon,  8 Jan 2024 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB44221FF6;
	Mon,  8 Jan 2024 08:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704703358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xavgp20wJchhEiut1T9EaOus3HeMGe9zH5qTQoxluvE=;
	b=nqy+cecd3COaFtxFUt2POZxT8TcUB9XWJmfb07PXCJUkPAJgrraALBxNuqdyIC8nrl1Abs
	VcTVUZQ+MVU4qhYZzg1vu4okiH1mxyKDx0Wfn5j8WQGaP8wKY8rYmfRe+uYqNyfkIkjHWA
	sdOJlCaXyygEiWuizQ6wRTY1nwAWUWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704703358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xavgp20wJchhEiut1T9EaOus3HeMGe9zH5qTQoxluvE=;
	b=i6wVTFVve1JhZslr/4OiI4tRSj6o7QGkR2R5Lma6hGr/yi5KX6IR4ic2ncP3fGeTxlSj4W
	p8iRWSjX/e8NycBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704703358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xavgp20wJchhEiut1T9EaOus3HeMGe9zH5qTQoxluvE=;
	b=nqy+cecd3COaFtxFUt2POZxT8TcUB9XWJmfb07PXCJUkPAJgrraALBxNuqdyIC8nrl1Abs
	VcTVUZQ+MVU4qhYZzg1vu4okiH1mxyKDx0Wfn5j8WQGaP8wKY8rYmfRe+uYqNyfkIkjHWA
	sdOJlCaXyygEiWuizQ6wRTY1nwAWUWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704703358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xavgp20wJchhEiut1T9EaOus3HeMGe9zH5qTQoxluvE=;
	b=i6wVTFVve1JhZslr/4OiI4tRSj6o7QGkR2R5Lma6hGr/yi5KX6IR4ic2ncP3fGeTxlSj4W
	p8iRWSjX/e8NycBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F3171392C;
	Mon,  8 Jan 2024 08:42:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZNx+IX61m2V6AgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 08 Jan 2024 08:42:38 +0000
Date: Mon, 08 Jan 2024 09:42:38 +0100
Message-ID: <87frz8i5c1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?GB2312?B?wfWyqQ==?= <bo.liu@senarytech.com>
Cc: "'Takashi Iwai'" <tiwai@suse.de>,
	<perex@perex.cz>,
	<tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140
In-Reply-To: <002401da41e2$f159f5f0$d40de1d0$@senarytech.com>
References: <002401da41e2$f159f5f0$d40de1d0$@senarytech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Mon, 08 Jan 2024 04:29:51 +0100,
Αυ²© wrote:
> 
> hi Takashi Iwai,
> 	Thank you very much for your patient guidance. Below is the reply to
> the question, please kindly correct it, thanks.
> 
> > +static void cx_fixup_headset_recog(struct hda_codec *codec) {
> > +	unsigned int mic_persent;
> > +
> > +	/* fix some headset type recognize fail issue, such as EDIFIER
> headset */
> > +	snd_hda_codec_write(codec, 0x1c, 0, 0x320, 0x010);
> > +	snd_hda_codec_write(codec, 0x1c, 0, 0x3b0, 0xe10);
> > +	snd_hda_codec_write(codec, 0x1c, 0, 0x4f0, 0x0eb);
> 
> Please use the defined verbs in sound/hda_verbs.h.
> The arguments (0x320, 0x010) are (AC_VERB_SET_AMP_GAIN_MUTE, 0x2010) etc.
> 
> Re: (0x1c, 0x320) is not amp gain register, but vendor defined register as
> rx control register. Use AC_VERB_SET_AMP_GAIN_MUTE will confused. It's
> similar to 0x4f0 and 0xca0.

Ah interesting.  But the verb is actually seen as
AC_VERB_SET_AMP_GAIN_MUTE -- although the resultant bits seem invalid.

HD-audio combines the verb and the value into 20 bits, e.g. (0x320,
0x10) is composed as 0x32010, and (0x3b0, 0xe10) is 0x3be10.
0x3xx is translated as SET_AMP_GAIN_MUTE, but in your case, 0x32010
leaves 0 to both the input/output bits (bits 14 and 15), which makes
it as invalid.

0x3be10 is another invalid verb, which sets SET_AMP_GAIN_MUTE with
OUTPUT, but it sets both LEFT and RIGHT, and passes a high index
(14).

And, what actually (0x4f0, 0x0eb) does?  It's composed as 0x4f0eb, and
in this case, it's a valid verb (SET_PROC_COEF + 0xf0eb).  But COEF is
vendor-specific, so it can be translated in everything the chip
wants.

So, if those verbs are vendor-specific ones, please define them and/or
give proper comments to explain what they do for each.


> Also, it's still not clear what if other nodes are used for headphone and
> mic pins -- or when either only headphone or only mic is present.
> A rare case, but we need to cover.
> 
> Re: in cx8070 and sn6140, only 0x16 and 0x19 can be used together as
> headset. Other nodes can be used separately as headphones or microphones,
> but not as headset, 
> so their configuration will not interfere with the type detection of
> headset.

OK, then explain this in comments, too (that we blindly assume those
pins).


> > +	/* fix reboot headset type recognize fail issue */
> > +	mic_persent = snd_hda_codec_read(codec, 0x19, 0,
> AC_VERB_GET_PIN_SENSE, 0x0);
> > +	if (mic_persent&0x80000000)
> 
> A coding style problem.  Similar issues seen in a few other places, too.
> Consult scripts/checkpatch.pl.
> 
> Re: was & need space? I have checked with scripts/checkpatch.pl before
> submitting the patch and there are no warnings or errors.

Yes.  Please put spaces around the operators.


> > +static void cx_process_headset_plugin(struct hda_codec *codec) {
> > +	unsigned int val;
> > +	unsigned int count = 0;
> > +
> > +	/* Wait headset detect done. */
> > +	do {
> > +		val = snd_hda_codec_read(codec, 0x1c, 0, 0xca0, 0x0);
> 
> Use the verb: AC_VERB_GET_PROC_COEF, 0xa000.
> At best, define the COEF values 0xa000 and 0xb000, and the corresponding
> value bits, too.
> 
> Re: (0x1c, 0xca0) is not COEF register, but vendor defined register as
> jacksense register.
> 
> > +static void cx_update_headset_mic_vref(struct hda_codec *codec, 
> > +unsigned int res) {
> > +	unsigned int phone_present, mic_persent, phone_tag, mic_tag;
> > +	struct conexant_spec *spec = codec->spec;
> > +
> > +	/* In cx8070 and sn6140, headset is fixed to use node 16 and node
> 19.
> 
> Is it really guaranteed?  IMO, we should check the pin configs beforehand at
> the parsing time.
> 
> Re: in cx8070 and sn6140, only 0x16 and 0x19 can be used together as
> headset. The node 16 can only be config to headphone or disable,
> The node 19 can only be config to microphone or disable. Only node 16 and
> node 19 both enable, the patch will process.

Then we still might need a check for the condition?


thanks,

Takashi

