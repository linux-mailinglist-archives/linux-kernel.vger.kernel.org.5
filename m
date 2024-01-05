Return-Path: <linux-kernel+bounces-18090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EC98258C4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA76DB22BBA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2996131A81;
	Fri,  5 Jan 2024 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gokGGuTc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LE6evtG9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gokGGuTc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LE6evtG9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF233174E;
	Fri,  5 Jan 2024 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A09C1FB44;
	Fri,  5 Jan 2024 17:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704474102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0pqSAo1a1EH5HTEcwTG0QckXYLZkoMIPOiDc1r0tpA=;
	b=gokGGuTcazv7gAyIeY0XWVhwKFWgr4lGSrT1TMHvGEkCjCfWkwWdNyHSaGlNNyNyZNIOud
	qgEBrRnycsWUCC6tcBW/se+ltvNQ97vmRjInEHtMcTtxgxw7wFsIZcCJqW/xw2z4r+5az4
	bW2VJsItw4oVPB3zHfFXgH4CGFrDCsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704474102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0pqSAo1a1EH5HTEcwTG0QckXYLZkoMIPOiDc1r0tpA=;
	b=LE6evtG9TrFzZUktbOPlHhYUf90JBfn8dq5uC9wFaTmnGRN0mmvpzmJ3DMETXxC9fuHQnJ
	tcIL51y22uA7HwBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704474102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0pqSAo1a1EH5HTEcwTG0QckXYLZkoMIPOiDc1r0tpA=;
	b=gokGGuTcazv7gAyIeY0XWVhwKFWgr4lGSrT1TMHvGEkCjCfWkwWdNyHSaGlNNyNyZNIOud
	qgEBrRnycsWUCC6tcBW/se+ltvNQ97vmRjInEHtMcTtxgxw7wFsIZcCJqW/xw2z4r+5az4
	bW2VJsItw4oVPB3zHfFXgH4CGFrDCsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704474102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0pqSAo1a1EH5HTEcwTG0QckXYLZkoMIPOiDc1r0tpA=;
	b=LE6evtG9TrFzZUktbOPlHhYUf90JBfn8dq5uC9wFaTmnGRN0mmvpzmJ3DMETXxC9fuHQnJ
	tcIL51y22uA7HwBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09956136F5;
	Fri,  5 Jan 2024 17:01:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1pPjAPY1mGWoSAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 05 Jan 2024 17:01:42 +0000
Date: Fri, 05 Jan 2024 18:01:41 +0100
Message-ID: <871qavk93e.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: bo liu <bo.liu@senarytech.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140
In-Reply-To: <20240104111044.5880-1-bo.liu@senarytech.com>
References: <20240104111044.5880-1-bo.liu@senarytech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 URIBL_BLOCKED(0.00)[senarytech.com:email];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[33.13%]
X-Spam-Flag: NO

On Thu, 04 Jan 2024 12:10:44 +0100,
bo liu wrote:
> 
> When OMTP headset plugin the headset jack of CX8070 and SN6160 sound cards,
> the headset type detection circuit will recognize the headset type as CTIA.
> At this point, plugout and plugin the headset will get the correct headset
> type as OMTP.
> The reason for the failure of headset type recognition is that the sound
> card creation will enable the VREF voltage of the headset mic, which
> interferes with the headset type automatic detection circuit. Plugout and
> plugin the headset will restart the headset detection and get the correct
> headset type.
> The patch is disable the VREF voltage when the headset is not present, and
> will enable the VREF voltage when the headset is present.
> 
> Signed-off-by: bo liu <bo.liu@senarytech.com>

Please put the revision number to the subject prefix, i.e.
"Subject: [PATCH v3] ALSA: hda/conexant: ...."

> +static void cx_fixup_headset_recog(struct hda_codec *codec)
> +{
> +	unsigned int mic_persent;
> +
> +	/* fix some headset type recognize fail issue, such as EDIFIER headset */
> +	snd_hda_codec_write(codec, 0x1c, 0, 0x320, 0x010);
> +	snd_hda_codec_write(codec, 0x1c, 0, 0x3b0, 0xe10);
> +	snd_hda_codec_write(codec, 0x1c, 0, 0x4f0, 0x0eb);

Please use the defined verbs in sound/hda_verbs.h.
The arguments (0x320, 0x010) are (AC_VERB_SET_AMP_GAIN_MUTE, 0x2010)
etc.

Also, it's still not clear what if other nodes are used for headphone
and mic pins -- or when either only headphone or only mic is present.
A rare case, but we need to cover.

> +	/* fix reboot headset type recognize fail issue */
> +	mic_persent = snd_hda_codec_read(codec, 0x19, 0, AC_VERB_GET_PIN_SENSE, 0x0);
> +	if (mic_persent&0x80000000)

A coding style problem.  Similar issues seen in a few other places,
too.  Consult scripts/checkpatch.pl.

> +enum {
> +	CX_HEADSET_NOPRESENT = 0,
> +	CX_HEADSET_PARTPRESENT,
> +	CX_HEADSET_ALLPRESENT,
> +};

This should be defined earlier.  You can use the enum type for
spec->headset_present_flag, too.

> +static void cx_process_headset_plugin(struct hda_codec *codec)
> +{
> +	unsigned int val;
> +	unsigned int count = 0;
> +
> +	/* Wait headset detect done. */
> +	do {
> +		val = snd_hda_codec_read(codec, 0x1c, 0, 0xca0, 0x0);

Use the verb: AC_VERB_GET_PROC_COEF, 0xa000.
At best, define the COEF values 0xa000 and 0xb000, and the
corresponding value bits, too.

> +static void cx_update_headset_mic_vref(struct hda_codec *codec, unsigned int res)
> +{
> +	unsigned int phone_present, mic_persent, phone_tag, mic_tag;
> +	struct conexant_spec *spec = codec->spec;
> +
> +	/* In cx8070 and sn6140, headset is fixed to use node 16 and node 19.

Is it really guaranteed?  IMO, we should check the pin configs
beforehand at the parsing time.


thanks,

Takashi

