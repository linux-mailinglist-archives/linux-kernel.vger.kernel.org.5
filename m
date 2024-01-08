Return-Path: <linux-kernel+bounces-19590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4B6826F4B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06201F22F99
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F09541231;
	Mon,  8 Jan 2024 13:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jqqXa2xE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ox5Vej9b";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jqqXa2xE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ox5Vej9b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B059A41215;
	Mon,  8 Jan 2024 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A785E1F7A0;
	Mon,  8 Jan 2024 13:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704719338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f0o21J7nR/xVWxq9H8+akzo3UfGPo0sTHjBmxD9KITA=;
	b=jqqXa2xELO1mVJ8Nlw38X3rwIzjeg3ODyYa1ttTfVsIm19hqmF4KAsaTdW4uBB0GEMJLWd
	Cale0BffxBVAwy6m3uvwUK7xywe+vxj/ZD05U+D89vGfg9+Xj5ReDKh3Qhr6npJ/A1r3OK
	WiyapG+q+yRCXo3nBtlkYaFuOkamiDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704719338;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f0o21J7nR/xVWxq9H8+akzo3UfGPo0sTHjBmxD9KITA=;
	b=ox5Vej9bSL8rsyfsffoQSiixxpa61UEo/Lk6PyUk1grPJH1SS9CXiM5MhTh9/MkHffq/i8
	TBUKmWFJR88oWyDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704719338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f0o21J7nR/xVWxq9H8+akzo3UfGPo0sTHjBmxD9KITA=;
	b=jqqXa2xELO1mVJ8Nlw38X3rwIzjeg3ODyYa1ttTfVsIm19hqmF4KAsaTdW4uBB0GEMJLWd
	Cale0BffxBVAwy6m3uvwUK7xywe+vxj/ZD05U+D89vGfg9+Xj5ReDKh3Qhr6npJ/A1r3OK
	WiyapG+q+yRCXo3nBtlkYaFuOkamiDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704719338;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f0o21J7nR/xVWxq9H8+akzo3UfGPo0sTHjBmxD9KITA=;
	b=ox5Vej9bSL8rsyfsffoQSiixxpa61UEo/Lk6PyUk1grPJH1SS9CXiM5MhTh9/MkHffq/i8
	TBUKmWFJR88oWyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 727DC13686;
	Mon,  8 Jan 2024 13:08:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BE8oGurzm2UjbAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 08 Jan 2024 13:08:58 +0000
Date: Mon, 08 Jan 2024 14:08:58 +0100
Message-ID: <87bk9wt1jp.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: bo liu <bo.liu@senarytech.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140
In-Reply-To: <20240108110235.3867-1-bo.liu@senarytech.com>
References: <20240108110235.3867-1-bo.liu@senarytech.com>
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
X-Spamd-Result: default: False [-2.14 / 50.00];
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
	 BAYES_HAM(-1.84)[94.10%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.14

On Mon, 08 Jan 2024 12:02:35 +0100,
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

Thanks, applied now.


Takashi

