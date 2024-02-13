Return-Path: <linux-kernel+bounces-63688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B90085334B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA6F1F2157D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EED5EE70;
	Tue, 13 Feb 2024 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a2wTltk7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EYBBwyP0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a2wTltk7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EYBBwyP0"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930765DF1B;
	Tue, 13 Feb 2024 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834996; cv=none; b=W3C3ZGBsoKkDRb81h3bLaotakYlTISJ+ufCH+G68N6Rx5rm+DXFDpYuM/Pziq33NfJQ/7ws9ynXCcyxJzVHm+n4ldR+tV+7x6leVHS3h893IG5aD1s/fg+IwihYMBy81nv3LNRPoQIq3NmeLs8WZV1/7MA+bn+QRiXRGF9tHR7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834996; c=relaxed/simple;
	bh=6fpnG25L709YQc6CBpdSPx52p5geiuVd+undxGv3F8k=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GvuYV8c3Z0KkebOmAf4fOXTBhrssZmLe2Qq+J/BMzK229W3fIBgCh4g1KJ/MKoealkDjrczoo0OGer+Y+3elsyDdEj8y4/Qcx8PCDl86/+cKiwPPmm9k1/p8yhMHpXwrkBs7OBEHYIveIrTNBWBLM0NAktzK6QnIMkUABibmVcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a2wTltk7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EYBBwyP0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a2wTltk7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EYBBwyP0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C2D831FCDC;
	Tue, 13 Feb 2024 14:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707834992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f83NHGJ9TQS4FzV/QQJ2HUXh870K+Fj6gcduNb1X2b0=;
	b=a2wTltk77dc1GNkco0+iHEqL2R24CaueF7MYCXelTBfT45WAKP9l4WQp5K7h8sS0IJP6+9
	Vsy8l6nn3HufVmoueQk1AjJVOfabMjwY2PCVdkQBjOgwQSDTPYwhKbF+P+6In4hsusLL94
	oFk/YF0540ZNTQk7fUzKRALj50ZfGvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707834992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f83NHGJ9TQS4FzV/QQJ2HUXh870K+Fj6gcduNb1X2b0=;
	b=EYBBwyP0PstETSJO4BTDkLn2L9WpUfVzkz9GLAh5adxKlzIuI+Jk/Y+/dvTXz0br/hNOWr
	E4ViVlZo1T/j/MDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707834992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f83NHGJ9TQS4FzV/QQJ2HUXh870K+Fj6gcduNb1X2b0=;
	b=a2wTltk77dc1GNkco0+iHEqL2R24CaueF7MYCXelTBfT45WAKP9l4WQp5K7h8sS0IJP6+9
	Vsy8l6nn3HufVmoueQk1AjJVOfabMjwY2PCVdkQBjOgwQSDTPYwhKbF+P+6In4hsusLL94
	oFk/YF0540ZNTQk7fUzKRALj50ZfGvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707834992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f83NHGJ9TQS4FzV/QQJ2HUXh870K+Fj6gcduNb1X2b0=;
	b=EYBBwyP0PstETSJO4BTDkLn2L9WpUfVzkz9GLAh5adxKlzIuI+Jk/Y+/dvTXz0br/hNOWr
	E4ViVlZo1T/j/MDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EB4913404;
	Tue, 13 Feb 2024 14:36:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2hz3IXB+y2VULAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Feb 2024 14:36:32 +0000
Date: Tue, 13 Feb 2024 15:36:32 +0100
Message-ID: <87y1bowhvz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: ramzes <ramzes005@gmail.com>
Cc: sbinding@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	andy.chi@canonical.com,
	david.rhodes@cirrus.com,
	james.schulman@cirrus.com,
	kailang@realtek.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	luke@ljones.dev,
	patches@opensource.cirrus.com,
	perex@perex.cz,
	rf@opensource.cirrus.com,
	ruinairas1992@gmail.com,
	shenghao-ding@ti.com,
	tiwai@suse.com,
	vitalyr@opensource.cirrus.com
Subject: Re: [PATCH v3] Add Lenovo Legion 7i gen7 sound quirk
In-Reply-To: <CAPtLpdGH6aptJq_Co5=1NL+Sb55vtax8KrUbyMQj2ThvS2YtHg@mail.gmail.com>
References: <000101da5e63$6a2565e0$3e7031a0$@opensource.cirrus.com>
	<20240213115614.10420-1-ramzes005@gmail.com>
	<87jzn8y1u7.wl-tiwai@suse.de>
	<CAPtLpdGH6aptJq_Co5=1NL+Sb55vtax8KrUbyMQj2ThvS2YtHg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.08 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[17];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[opensource.cirrus.com,alsa-project.org,canonical.com,cirrus.com,realtek.com,vger.kernel.org,ljones.dev,perex.cz,gmail.com,ti.com,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.98)[86.94%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.08

On Tue, 13 Feb 2024 14:16:43 +0100,
ramzes wrote:
> 
> 
> Yes, I've compiled kernel with latest patch version, 
> with Stephan's configuration, and sound works well on my laptop.

OK, now I applied the patch.  Thanks.


Takashi

> 
> Tomasz
> 
> wt., 13 lut 2024 o 13:40 Takashi Iwai <tiwai@suse.de> napisa³(a):
> 
>     On Tue, 13 Feb 2024 12:56:14 +0100,
>     Tomasz Kudela wrote:
>     >
>     > From: "Tomasz Kudela" <ramzes005@gmail.com>
>     >
>     > Add sound support for the Legion 7i gen7 laptop (16IAX7).
>     >
>     > Signed-off-by: Tomasz Kudela <ramzes005@gmail.com>
>    
>     You tested with this new patch and confirmed it's still working,
>     right?  Just to be sure.
> 
>     Takashi
> 

