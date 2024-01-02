Return-Path: <linux-kernel+bounces-14543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924AE821E71
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B0B283B90
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD8914293;
	Tue,  2 Jan 2024 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JOcRegzk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zv5WJ4SY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JOcRegzk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zv5WJ4SY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7600C14F81;
	Tue,  2 Jan 2024 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D5D31FD01;
	Tue,  2 Jan 2024 15:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704208314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/JPp9CBVxTZIXJwFerBBgfFdcUZgr8/tjs7x7FZU538=;
	b=JOcRegzkh2aEJ/PzXrIdhCnF8UWLId/pOyRd6v5DxAErAIWAWQC3pWcnhr4tA47LsQ2Et/
	WjRimchH6z1Wy0kfxoaLlSILtfaoEjdsiWoPFBFAAbZRHALCmtYLA8ihNcLFIzc75vQA+f
	pR9TQG5sozaYbSHTIxBtbOYcjaxU/cI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704208314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/JPp9CBVxTZIXJwFerBBgfFdcUZgr8/tjs7x7FZU538=;
	b=zv5WJ4SYCzIHIO6yWIv/FQh3HmG6hESgrxYu9vxIRpv5S59zdn2H7zuDsl6vjk3US2WzKF
	AWRaH2snxmhdBJCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704208314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/JPp9CBVxTZIXJwFerBBgfFdcUZgr8/tjs7x7FZU538=;
	b=JOcRegzkh2aEJ/PzXrIdhCnF8UWLId/pOyRd6v5DxAErAIWAWQC3pWcnhr4tA47LsQ2Et/
	WjRimchH6z1Wy0kfxoaLlSILtfaoEjdsiWoPFBFAAbZRHALCmtYLA8ihNcLFIzc75vQA+f
	pR9TQG5sozaYbSHTIxBtbOYcjaxU/cI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704208314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/JPp9CBVxTZIXJwFerBBgfFdcUZgr8/tjs7x7FZU538=;
	b=zv5WJ4SYCzIHIO6yWIv/FQh3HmG6hESgrxYu9vxIRpv5S59zdn2H7zuDsl6vjk3US2WzKF
	AWRaH2snxmhdBJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27B4713AC6;
	Tue,  2 Jan 2024 15:11:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q5w1CLonlGXAawAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 02 Jan 2024 15:11:54 +0000
Date: Tue, 02 Jan 2024 16:11:53 +0100
Message-ID: <87wmsr7osm.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: bo liu <bo.liu@senarytech.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140
In-Reply-To: <20240102060457.4917-1-bo.liu@senarytech.com>
References: <20240102060457.4917-1-bo.liu@senarytech.com>
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
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
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
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue, 02 Jan 2024 07:04:57 +0100,
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

Thanks, this is *much* better than the previous version!

However, something still need to be fixed in the content:

> ---
>  sound/pci/hda/patch_conexant.c | 72 +++++++++++++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
> index a889cccdd607..e24befa1fad9 100644
> --- a/sound/pci/hda/patch_conexant.c
> +++ b/sound/pci/hda/patch_conexant.c
> @@ -166,6 +166,7 @@ static void cxt_init_gpio_led(struct hda_codec *codec)
>  
>  static int cx_auto_init(struct hda_codec *codec)
>  {
> +	unsigned int mic_persent;
>  	struct conexant_spec *spec = codec->spec;
>  	snd_hda_gen_init(codec);
>  	if (!spec->dynamic_eapd)
> @@ -174,6 +175,22 @@ static int cx_auto_init(struct hda_codec *codec)
>  	cxt_init_gpio_led(codec);
>  	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_INIT);
>  
> +	switch (codec->core.vendor_id) {
> +	case 0x14f11f86:
> +	case 0x14f11f87:

If those ID checks appear multiple times, it's better to make it as a
flag in conexant_spec, and set it at the probe time.

> +		/* fix some headset type recognize fail issue, such as EDIFIER headset */
> +		snd_hda_codec_write(codec, 0x1c, 0, 0x320, 0x010);
> +		snd_hda_codec_write(codec, 0x1c, 0, 0x3b0, 0xe10);
> +		snd_hda_codec_write(codec, 0x1c, 0, 0x4f0, 0x0eb);
(snip)

Those code can be better factored out to a function.
It'll lead to less indentation, hence it makes easier to read, too.

> @@ -192,6 +209,58 @@ static void cx_auto_free(struct hda_codec *codec)
>  	snd_hda_gen_free(codec);
>  }
>  
> +static int headset_present_flag;

It's bad to use a static variable here.  In theory, there can be
multiple same codecs used on the bus.

If any, put this into conexant_spec and use locally.

> +static void cx_jack_unsol_event(struct hda_codec *codec, unsigned int res)
> +{
> +	unsigned int val, phone_present, mic_persent, phone_tag, mic_tag;
> +	unsigned int count = 0;
> +
> +	switch (codec->core.vendor_id) {
> +	case 0x14f11f86:
> +	case 0x14f11f87:

Again, use a different flag.  Also factor out the specific code into a
function.

> +		/* check hp&mic tag to process headset pulgin&plugout */
> +		phone_tag = snd_hda_codec_read(codec, 0x16, 0, 0xf08, 0x0);
> +		mic_tag = snd_hda_codec_read(codec, 0x19, 0, 0xf08, 0x0);

Are those pins *always* fixed to 0x16 and 0x19?  Or they might be
assigned to different pins...?   In the latter case, the pin nid
should be taken from the parsed configuration instead of fixed
numbers.

> +		if ((phone_tag&(res>>26)) || (mic_tag&(res>>26))) {

Some coding style issues here.  Consult scripts/checkpatch.pl.
Also avoid a magic number.  0xf08 is AC_VERB_GET_UNSOLICITED_RESPONSE,
and 26 is AC_UNSOL_RES_TAG_SHIFT, for example.

> +			phone_present = snd_hda_codec_read(codec, 0x16, 0, 0xf09, 0x0);
> +			if (!(phone_present&0x80000000)) {/* headphone plugout */

Ditto.  0x80000000 is AC_PINSENSE_PRESENCE.

> +				headset_present_flag = 0;

Better to use an enum to hold the state instead of the raw 0, 1, 2.


> +				break;
> +			}
> +			if (headset_present_flag == 0) {
> +				headset_present_flag = 1;
> +			} else if (headset_present_flag == 1) {
> +				mic_persent = snd_hda_codec_read(codec, 0x19, 0, 0xf09, 0x0);
> +				/* headset is present */
> +				if ((phone_present&0x80000000) && (mic_persent&0x80000000)) {
> +					/* wait headset detect done */
> +					do {
> +						msleep(20);
> +						val = snd_hda_codec_read(codec, 0x1c,
> +									0, 0xca0, 0x0);
> +						count += 1;

Usually we use "++" for increment.


thanks,

Takashi

