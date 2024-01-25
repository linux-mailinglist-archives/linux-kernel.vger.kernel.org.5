Return-Path: <linux-kernel+bounces-38739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7B383C514
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13017B24989
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3DF6EB40;
	Thu, 25 Jan 2024 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="chmcbZXQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p93GcxoR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="chmcbZXQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p93GcxoR"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72546BF;
	Thu, 25 Jan 2024 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193961; cv=none; b=V+IpW9QNU1Ki8JWi4G/5BrMWUz2Pq8V+UZIx3T5aFKYWFOdDQffx+C9Tbw1XZHhEjlgFROYts/WvxW69TiGkfh3r5tgS+q6YVPBk3zDPr5GWdroubb6c2/E+e+wJZwQ4R4bcFJSws3CPF3nJ7lgcVmV++mQ2je9naj1rGuu7mQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193961; c=relaxed/simple;
	bh=bfVt/Qp6nnFYjEv4fNujG3FRQZPxd9dF8Ktl3posgQY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udzYqn9S4v6zZihuWskkHquJgsDn+Nk1hLnsxiJuexWViO5VciNR08gjH9K14wiC0mXt9XWZUOFEr16X7Jy4QemtCAlbdH4pjRqOU6vs3kjY23upoZNMSnL4eBS5H/AjG6j073dw91eugSKNymqBvU9oHhtVszhgkP2/jfezLXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=chmcbZXQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p93GcxoR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=chmcbZXQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p93GcxoR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9DD9821F23;
	Thu, 25 Jan 2024 14:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706193957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DGm5WEZ37sgB5OWaEWo1WkYoug1DC2BQn8LeaNqX+Ao=;
	b=chmcbZXQpKrAJZflIygDobgKzyQAoUQxbISJAjG07DAI8FXXiMmH81sfqiB1jASWRiSSxm
	mmIGcwGJitRIOCTlbWUkP2Y5gWGJBafgtj/2CnU6WL4Lx9JImhu03oTbMvYZKkGs/AhESK
	M4gEsitqcU0zF85s7VFudrWZadSj5F4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706193957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DGm5WEZ37sgB5OWaEWo1WkYoug1DC2BQn8LeaNqX+Ao=;
	b=p93GcxoR2gnRAhMlSO4mxOnDD/ATtxJFuWBCY/f8eNTKFuzO/NyeMh4wJsYqAsmLGlOfzD
	hl6hHO8s1ozd4FAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706193957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DGm5WEZ37sgB5OWaEWo1WkYoug1DC2BQn8LeaNqX+Ao=;
	b=chmcbZXQpKrAJZflIygDobgKzyQAoUQxbISJAjG07DAI8FXXiMmH81sfqiB1jASWRiSSxm
	mmIGcwGJitRIOCTlbWUkP2Y5gWGJBafgtj/2CnU6WL4Lx9JImhu03oTbMvYZKkGs/AhESK
	M4gEsitqcU0zF85s7VFudrWZadSj5F4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706193957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DGm5WEZ37sgB5OWaEWo1WkYoug1DC2BQn8LeaNqX+Ao=;
	b=p93GcxoR2gnRAhMlSO4mxOnDD/ATtxJFuWBCY/f8eNTKFuzO/NyeMh4wJsYqAsmLGlOfzD
	hl6hHO8s1ozd4FAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D31C134C3;
	Thu, 25 Jan 2024 14:45:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4D6IECV0smV1WQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 25 Jan 2024 14:45:57 +0000
Date: Thu, 25 Jan 2024 15:45:56 +0100
Message-ID: <87sf2lii8r.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<perex@perex.cz>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<patches@opensource.cirrus.com>,
	Simon Trimmer
	<simont@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirks for HP G11 Laptops using CS35L56
In-Reply-To: <20240125123301.41692-1-rf@opensource.cirrus.com>
References: <20240125123301.41692-1-rf@opensource.cirrus.com>
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
X-Spamd-Result: default: False [0.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.11)[66.18%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.79

On Thu, 25 Jan 2024 13:33:01 +0100,
Richard Fitzgerald wrote:
> 
> From: Simon Trimmer <simont@opensource.cirrus.com>
> 
> Add quirks for two HP G11 laptops that use a Realtek HDA codec combined
> with four CS35L56 amplifiers using SPI.
> 
> The CS35L56 driver uses the component binding interface, so uses the same
> setup code as the CS35L41 quirks.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Thanks, applied.


Takashi

