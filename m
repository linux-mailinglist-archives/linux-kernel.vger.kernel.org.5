Return-Path: <linux-kernel+bounces-59251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C61484F3DB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4431428911E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4481A28699;
	Fri,  9 Feb 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X3A0p7Oo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sxDKMLGk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X3A0p7Oo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sxDKMLGk"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF79C1DA59;
	Fri,  9 Feb 2024 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476102; cv=none; b=KzYM7wUnnxU43pA6MbUPzo7nISlpfuDZadn2h76lAb7m9oMrpOXYTvnhiGw+xpkyC0kyxWJc39iCvBJu7lNE1CaKa9HK09Q0E0XXXQmTWZldeuCKURzkhWQcT6sFrVgoRVdjwbHOW2Liotpimi6f0zrE8BWHAHS7xZsMlsA7L3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476102; c=relaxed/simple;
	bh=RzCj/wjUmQAdnlPi3yHNMR9znSA3zmdXvQ3SsxyGDUQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wc0fPZVagm6kFdTUiP2QsImq41SN7qv9uvtj9TPI9ejh/5Fh5trx7y3UQZF/W+rz6iqEuQcdvuSXO0HO7yujARLrDoHQdULhjHAeRgRpUCOMdF2EZImwCT8LL/9fsSvboK6FvfYlRfP5813V+GwZceJF27RZSTDR9OwjtXniU5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X3A0p7Oo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sxDKMLGk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X3A0p7Oo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sxDKMLGk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F10221F7F9;
	Fri,  9 Feb 2024 10:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707476099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mei8ER/v1qZQ1A3xvXCrGn5Qp6d30zZIBW+eYO6/mIM=;
	b=X3A0p7Oo15P0tX5i2rgPG3EKTpts4Nhv3pOf6Mg3Yun/YQ0XhUw2F63TUoK8E+tTWEnkyt
	INOu/E/O+H3JWWIwtD/YBcVULJ5aaFxCLb5KlsCIn6ZmkEtd3Ayoymj/w6PnajnXbOo/Bg
	6gehD2lI+W6sSJpPo5oiq+IxMyRFBYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707476099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mei8ER/v1qZQ1A3xvXCrGn5Qp6d30zZIBW+eYO6/mIM=;
	b=sxDKMLGkxfmZDv/IoUa7wHover2llMtx5EbV+pvmzVazlEERbUt+v3ZT+/ZgpjsxleyCpy
	/6Qz9Lvooo5Q2dDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707476099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mei8ER/v1qZQ1A3xvXCrGn5Qp6d30zZIBW+eYO6/mIM=;
	b=X3A0p7Oo15P0tX5i2rgPG3EKTpts4Nhv3pOf6Mg3Yun/YQ0XhUw2F63TUoK8E+tTWEnkyt
	INOu/E/O+H3JWWIwtD/YBcVULJ5aaFxCLb5KlsCIn6ZmkEtd3Ayoymj/w6PnajnXbOo/Bg
	6gehD2lI+W6sSJpPo5oiq+IxMyRFBYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707476099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mei8ER/v1qZQ1A3xvXCrGn5Qp6d30zZIBW+eYO6/mIM=;
	b=sxDKMLGkxfmZDv/IoUa7wHover2llMtx5EbV+pvmzVazlEERbUt+v3ZT+/ZgpjsxleyCpy
	/6Qz9Lvooo5Q2dDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45FBA1326D;
	Fri,  9 Feb 2024 10:54:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n3phD4IExmXGLAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 09 Feb 2024 10:54:58 +0000
Date: Fri, 09 Feb 2024 11:54:57 +0100
Message-ID: <87r0hl29ha.wl-tiwai@suse.de>
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
Subject: Re: [PATCH v14 20/53] ASoC: Add SOC USB APIs for adding an USB backend
In-Reply-To: <20240208231406.27397-21-quic_wcheng@quicinc.com>
References: <20240208231406.27397-1-quic_wcheng@quicinc.com>
	<20240208231406.27397-21-quic_wcheng@quicinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=X3A0p7Oo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sxDKMLGk
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.23 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLe67txhfobum3fqdb5xx8e3au)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-1.22)[89.32%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,quicinc.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linaro.org,intel.com,perex.cz,kernel.org,lwn.net,gmail.com,linuxfoundation.org,synopsys.com,quicinc.com,suse.com,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -0.23
X-Rspamd-Queue-Id: F10221F7F9
X-Spam-Flag: NO

On Fri, 09 Feb 2024 00:13:33 +0100,
Wesley Cheng wrote:
> 
> Some platforms may have support for offloading USB audio devices to a
> dedicated audio DSP.  Introduce a set of APIs that allow for management of
> USB sound card and PCM devices enumerated by the USB SND class driver.
> This allows for the ASoC components to be aware of what USB devices are
> available for offloading.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
(snip)
> --- a/sound/soc/Makefile
> +++ b/sound/soc/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-utils.o soc-dai.o soc-component.o
> +snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-usb.o soc-utils.o soc-dai.o soc-component.o
>  snd-soc-core-objs += soc-pcm.o soc-devres.o soc-ops.o soc-link.o soc-card.o
>  snd-soc-core-$(CONFIG_SND_SOC_COMPRESS) += soc-compress.o

Do we really want to build this into ASoC core unconditionally?
This is very specific to Qualcomm USB-offload stuff, so it's better to
factor out.


thanks,

Takashi

