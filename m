Return-Path: <linux-kernel+bounces-63371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC02852E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5CF21F25550
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1662BB04;
	Tue, 13 Feb 2024 10:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1rKgP++3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="apC07bjj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1rKgP++3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="apC07bjj"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945671775C;
	Tue, 13 Feb 2024 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821288; cv=none; b=CK9Xc24Jesjke+xTiNbcheNSWHQR3BPxmNyCpztjVcRBQlevnEqhWb0NUfUYqfB4+UZksgMOSRZl49cvl3Vcb0EaPaCNig05RJtjNWe7mqFZ7wdKvm88sRodyum9vbaw+DTxPivl1pYEngskrj+x9Gi3GQ4iV6acRuqhDflIips=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821288; c=relaxed/simple;
	bh=3U05UCAq1LKPx4ylCJPyDo9lukWD3K8+5PwEuPQdu/o=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpvHEiNbjuEiQkRmcr3M7oY2P0P3V3w1uhFo+mozrDRkjt0B3u4Mvl1tE0/YboqaoEtbuBRby4MByFB7yiwHNlHFX+oEEfqlnNeXoUckmYOizRUwqRNv6mm8WOnBCGS1PsyoOsUzPCV1q2XtGPGPvoL1VZ94PqS0ZBE8fiwr1fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1rKgP++3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=apC07bjj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1rKgP++3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=apC07bjj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ABE8C1FC81;
	Tue, 13 Feb 2024 10:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707821284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+fmGgJEKlpIBOZTyUzn23meJGrW/K86RdyX8/Qka9Pc=;
	b=1rKgP++34WbapWVIwZ/rbpaWLAathMQ69A9jkI+8TeMSM1V655GQzx/fNAGI3rmPnSiHQG
	wDtb2rQw0jW0ygX8ONm/gMH0LwMvAFgO451zB1aZzeYx52SrU8wspbS7aowj7Nh2qydvH8
	dmoVyZoaC+6yB7yybtUo9TlLyRIB07c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707821284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+fmGgJEKlpIBOZTyUzn23meJGrW/K86RdyX8/Qka9Pc=;
	b=apC07bjjmW4Lg467s45A6nN999r+fIhfE3gNN8cBieQvW8QpZZNf5UBjN9PlnWr1TLnRih
	DLmg6gKN5pQ2a6AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707821284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+fmGgJEKlpIBOZTyUzn23meJGrW/K86RdyX8/Qka9Pc=;
	b=1rKgP++34WbapWVIwZ/rbpaWLAathMQ69A9jkI+8TeMSM1V655GQzx/fNAGI3rmPnSiHQG
	wDtb2rQw0jW0ygX8ONm/gMH0LwMvAFgO451zB1aZzeYx52SrU8wspbS7aowj7Nh2qydvH8
	dmoVyZoaC+6yB7yybtUo9TlLyRIB07c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707821284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+fmGgJEKlpIBOZTyUzn23meJGrW/K86RdyX8/Qka9Pc=;
	b=apC07bjjmW4Lg467s45A6nN999r+fIhfE3gNN8cBieQvW8QpZZNf5UBjN9PlnWr1TLnRih
	DLmg6gKN5pQ2a6AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B66413404;
	Tue, 13 Feb 2024 10:48:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gvaAGeRIy2XcbQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Feb 2024 10:48:04 +0000
Date: Tue, 13 Feb 2024 11:48:04 +0100
Message-ID: <87zfw4y717.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: <srinivas.kandagatla@linaro.org>,
	<mathias.nyman@intel.com>,
	<perex@perex.cz>,
	<conor+dt@kernel.org>,
	<corbet@lwn.net>,
	<lgirdwood@gmail.com>,
	<andersson@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>,
	<gregkh@linuxfoundation.org>,
	<Thinh.Nguyen@synopsys.com>,
	<broonie@kernel.org>,
	<bgoswami@quicinc.com>,
	<tiwai@suse.com>,
	<robh+dt@kernel.org>,
	<konrad.dybcio@linaro.org>,
	<linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<linux-usb@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>,
	<alsa-devel@alsa-project.org>
Subject: Re: [PATCH v15 18/50] ASoC: Add SOC USB APIs for adding an USB backend
In-Reply-To: <20240213005422.3121-19-quic_wcheng@quicinc.com>
References: <20240213005422.3121-1-quic_wcheng@quicinc.com>
	<20240213005422.3121-19-quic_wcheng@quicinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1rKgP++3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=apC07bjj
X-Spamd-Result: default: False [1.10 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLe67txhfobum3fqdb5xx8e3au)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.09)[64.62%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linaro.org,intel.com,perex.cz,kernel.org,lwn.net,gmail.com,linuxfoundation.org,synopsys.com,quicinc.com,suse.com,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.10
X-Rspamd-Queue-Id: ABE8C1FC81
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

On Tue, 13 Feb 2024 01:53:50 +0100,
Wesley Cheng wrote:
> 
> --- a/sound/soc/Kconfig
> +++ b/sound/soc/Kconfig
> @@ -76,6 +76,15 @@ config SND_SOC_UTILS_KUNIT_TEST
>  config SND_SOC_ACPI
>  	tristate
>  
> +config SND_SOC_USB
> +	bool "SoC based USB audio offloading"
> +	help
> +	  Enable this option if an ASoC platform card has support to handle
> +	  USB audio offloading.  This enables the SoC USB layer, which will
> +	  notifies the ASoC USB DPCM backend DAI link about available USB audio
> +	  devices.  Based on the notifications, sequences to enable the audio
> +	  stream can be taken based on the design.

This should be tristate, and...

> --- a/sound/soc/Makefile
> +++ b/sound/soc/Makefile
> @@ -31,6 +31,10 @@ endif
>  
>  obj-$(CONFIG_SND_SOC_ACPI) += snd-soc-acpi.o
>  
> +ifneq ($(CONFIG_SND_SOC_USB),)
> +snd-soc-core-objs += soc-usb.o
> +endif

.. split it to an individual module, i.e.:

snd-soc-usb-objs := soc-usb.o
obj-$(CONFIG_SND_SOC_USB) += snd-soc-usb.o

Otherwise it'll lead to a hard-dependency to snd-soc-core on
snd-usb-audio, which is utterly unnecessary for most of other
devices.


thanks,

Takashi

