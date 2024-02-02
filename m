Return-Path: <linux-kernel+bounces-50156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F75847500
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C271F2B6A6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B0C148FFA;
	Fri,  2 Feb 2024 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q422YdGu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BRsZIMes";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ely6qj5U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c68PZsJs"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD251474BD;
	Fri,  2 Feb 2024 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891828; cv=none; b=SLDWbGYCwzfhVLAUwu9cJjrzrOsSlIvWx98AuAzyOJpVaOqLrwLK7BAQlatTRfRmedJOeQ27dHZyzRkMyVwpzmG04a9VOouxthCVhIhnlE5quVtdWyDDyfLR6258Z1MC3+n22D+4hK5Cz5ER5jj/YJFZubNY8sLoaZIOCUy1VqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891828; c=relaxed/simple;
	bh=2IQ+vBuNGH+uCED7BLNTlAPGrNwVDPzJJwLeYiyR4kk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPIzJuOGX++SRUpriTb5Pge2FSJrI+wxR1eeXuGLSPCdQK/vEvjmLggBAUGUn0xolCnXVMyvKon778meabqc1eY8ZmWf2+6kmdQnvpD/mq+12oJn8K5NSwxVTMdRJKl3JjLQmXs0Zhhh2XnOuf3nK0G3G/D9AILjnM7rKNKZNcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q422YdGu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BRsZIMes; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ely6qj5U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c68PZsJs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D90CF1FCEB;
	Fri,  2 Feb 2024 16:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706891821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i5OYyppaEpO0SPq6/5Bwy/6qzOT3TwRTRsrQSCOZ6yo=;
	b=Q422YdGuXEF5Dj161vDgMh58DQndcNFRXMospYRtqEjEWranhYiZcItQu2EyVt3+bmpCkh
	qO1wqIrnxlsFPRv69wEm2B3G2XJg5HZEp194AaX352p8mTNmVb9a/Fd/ehWf+jGDwzZnMn
	Esy4r3dapV+7YXzmMVus6h6w0w4jx+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706891821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i5OYyppaEpO0SPq6/5Bwy/6qzOT3TwRTRsrQSCOZ6yo=;
	b=BRsZIMesIBWGXEd7X6cDN9yVYaADqKO5SV4qRzauYDRAlCxGohYpV4cDj8ffsrS8fwZ016
	DCacKMf8qrDr6iDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706891820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i5OYyppaEpO0SPq6/5Bwy/6qzOT3TwRTRsrQSCOZ6yo=;
	b=ely6qj5UuwwE9/awi1Tpu9efpX5KZYVNRllI5Pw09WyBJUZcBldPY9tcOY5bQJQKbL2RfE
	xYl92X+EqX/EoPpxUalSJHF7KPhtXhGWfaJ/iMFcz4t3E2vfgt+oWWfOHipXJFWEAsj4qm
	1XXVcFp97D4oMKdSVLDW2BMAzmzzlkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706891820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i5OYyppaEpO0SPq6/5Bwy/6qzOT3TwRTRsrQSCOZ6yo=;
	b=c68PZsJsMlIffGWrMO8zEUoKubuIfzo3omPiZtWpX/sKVH2e0XAVtF69Gskca90sQY6XzX
	zao4zp6I4MG+kzDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9556E13A60;
	Fri,  2 Feb 2024 16:37:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bbnEIiwavWV2QgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 02 Feb 2024 16:37:00 +0000
Date: Fri, 02 Feb 2024 17:37:00 +0100
Message-ID: <87v876bz6b.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH v1] ALSA: hda/realtek: Remove two HP Laptops using CS35L41
In-Reply-To: <20240202161727.321373-1-sbinding@opensource.cirrus.com>
References: <20240202161727.321373-1-sbinding@opensource.cirrus.com>
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ely6qj5U;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=c68PZsJs
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.18)[89.01%]
X-Spam-Score: -3.69
X-Rspamd-Queue-Id: D90CF1FCEB
X-Spam-Flag: NO

On Fri, 02 Feb 2024 17:17:27 +0100,
Stefan Binding wrote:
> 
> These two HP laptops are changing configurations.

What exactly does this mean?  The PCI SSIDs are no longer valid, or
the quirk became wrong, or what?


thanks,

Takashi

