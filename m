Return-Path: <linux-kernel+bounces-13133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5636B820025
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82BC4B22443
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48168125AE;
	Fri, 29 Dec 2023 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SY+yDSdr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O+VqTc0i";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qbPqNspp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QUehGdQG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB04125A4;
	Fri, 29 Dec 2023 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C90D221FE6;
	Fri, 29 Dec 2023 15:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703862916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hx89e7Kld1LDfMIBU8m+wQLqkRWhiPf9+drw6fxpFmI=;
	b=SY+yDSdr5Ol+2ixDn0Ouxohw+7zwFDFG8v0MxkkSkaXksdqNU1dF5Jl3SxmE9aWKO4SYcY
	TcRmnbo8+WmoZiXCJjiVzmdxSsSd9achxymBVLeDmWHn3Lm94ln8QZox5sAenIbz17K4l+
	uNGLluTbV+373KapARKcMaUEMVp5vak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703862916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hx89e7Kld1LDfMIBU8m+wQLqkRWhiPf9+drw6fxpFmI=;
	b=O+VqTc0iUW9SgWW0OaDokYY4LEF5uh3P1j6XpB/C7MSFYkV5XBLrtIAdxg+5cAmT+Rud1B
	2GpXbq5zWpPMrdBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703862915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hx89e7Kld1LDfMIBU8m+wQLqkRWhiPf9+drw6fxpFmI=;
	b=qbPqNspptO3qhL+nXIk9Sueh2vtngKqRD0LMDltHDuBMqGmB1nyrsMyAfQJQrAJqnVa/Eb
	RfquQwAnsq7QYITfXe+VeW15RWLqicY+u31LejkrC8/fhNVnd65dBgdwcR24K8VcO+h3wv
	6cst2cwWEN9lu0HBVUMby7i69oTpsKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703862915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hx89e7Kld1LDfMIBU8m+wQLqkRWhiPf9+drw6fxpFmI=;
	b=QUehGdQGftgNhsQJgSWjrWQ67ONWWvdtZLBfyK9+q4RzkSGvjjR2eIrwm8UugSfJuix+7V
	iH5mX2UWeWQR9TDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91E23133E5;
	Fri, 29 Dec 2023 15:15:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aSTsIYPijmW3AwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 29 Dec 2023 15:15:15 +0000
Date: Fri, 29 Dec 2023 16:15:15 +0100
Message-ID: <87a5ptxcos.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: bo liu <bo.liu@senarytech.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Fix headset auto detect fail in cx8070 and SN6140
In-Reply-To: <20231227071008.13665-1-bo.liu@senarytech.com>
References: <20231227071008.13665-1-bo.liu@senarytech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: *
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qbPqNspp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QUehGdQG
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.75 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
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
	 BAYES_HAM(-0.24)[73.07%]
X-Spam-Score: -0.75
X-Rspamd-Queue-Id: C90D221FE6
X-Spam-Flag: NO

On Wed, 27 Dec 2023 08:10:06 +0100,
bo liu wrote:
> 
> CX8070 and SN6140 will get wrong headset type when use OMTP headset, then the headset mic will not work.
> 
> Signed-off-by: bo liu <bo.liu@senarytech.com>

Well, the patch series has a serious problem, unfortunately.

Basically the patch that is submitted to the upstream should be in the
final form.  But this series puts the coding style errors and then
corrects multiple times in the series.  This is absolutely no-go.

Create a "perfect patch", and submit it, instead.

For that, you'll need to give a bit more detailed patch description.
Currently it says nothing but the problem.  It doesn't mention how and
what to be fixed / changed.  Ideally speaking, the patch should have a
description that is self-explanatory.

Last but not least, please put the proper subject prefix.
In your case, it'd be like "ALSA: hda/conexant:".

Please try to address the above points and resubmit.


thanks,

Takashi

