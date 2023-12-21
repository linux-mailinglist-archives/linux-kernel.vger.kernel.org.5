Return-Path: <linux-kernel+bounces-7994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D1A81B046
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9EE285E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759891799C;
	Thu, 21 Dec 2023 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NsBzmEU2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MduD/OyC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NsBzmEU2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MduD/OyC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B37179A1;
	Thu, 21 Dec 2023 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31C7F21DEF;
	Thu, 21 Dec 2023 08:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703147237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RKp3YiZy1ZxIc9SwUP95Vg6JO6tzrcO5b4SC5IzLdq8=;
	b=NsBzmEU2d+P37EyBExsC/Z6DTYQI9iqIlvpUn+twgj9Y8GZsve+PU+IXIhhC51m/va6w2n
	KeXuDYY4bzlSXjp2LEx2FO9X6WRmRh9qAn/3wg3Z6+TaKHPwG+lm/trlTHfvVW0D8NmRln
	s9vGhp+Vg6F6lpi8n5bj07EuEIc35Ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703147237;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RKp3YiZy1ZxIc9SwUP95Vg6JO6tzrcO5b4SC5IzLdq8=;
	b=MduD/OyC0ojhHmHYUJkqHih/DAlKwLbast8YTvKL3Z6Bp/u40bguqGg0Gx+j/WJr7uE+j2
	CTOky/F/DOpCTBAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703147237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RKp3YiZy1ZxIc9SwUP95Vg6JO6tzrcO5b4SC5IzLdq8=;
	b=NsBzmEU2d+P37EyBExsC/Z6DTYQI9iqIlvpUn+twgj9Y8GZsve+PU+IXIhhC51m/va6w2n
	KeXuDYY4bzlSXjp2LEx2FO9X6WRmRh9qAn/3wg3Z6+TaKHPwG+lm/trlTHfvVW0D8NmRln
	s9vGhp+Vg6F6lpi8n5bj07EuEIc35Ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703147237;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RKp3YiZy1ZxIc9SwUP95Vg6JO6tzrcO5b4SC5IzLdq8=;
	b=MduD/OyC0ojhHmHYUJkqHih/DAlKwLbast8YTvKL3Z6Bp/u40bguqGg0Gx+j/WJr7uE+j2
	CTOky/F/DOpCTBAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 182A413AC2;
	Thu, 21 Dec 2023 08:27:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iAh3BeX2g2U1IgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 21 Dec 2023 08:27:17 +0000
Date: Thu, 21 Dec 2023 09:27:16 +0100
Message-ID: <s5h34vwufiz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 2/2] ALSA: hda: cs35l41: Only add SPI CS GPIO if SPI is enabled in kernel
In-Reply-To: <s5h8r5puwea.wl-tiwai@suse.de>
References: <20231219162232.790358-1-sbinding@opensource.cirrus.com>
	<20231219162232.790358-3-sbinding@opensource.cirrus.com>
	<s5h8r5puwea.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-0.83 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.73)[93.37%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -0.83
X-Spam-Flag: NO

On Wed, 20 Dec 2023 09:10:37 +0100,
Takashi Iwai wrote:
> 
> On Tue, 19 Dec 2023 17:22:32 +0100,
> Stefan Binding wrote:
> > 
> > If CONFIG_SPI is not set in the kernel, there is no point in trying
> > to set the chip selects. We can selectively compile it.
> 
> I guess it should with IS_REACHABLE() instead of IS_ENABLED()?
> It can be still CONFIG_SPI=m while CONFIG_SND_HDA_*=y.

In anyway, I applied the patches as is for now, as it should work in most cases.
Let's see whether the use of IS_REACHABLE() is required.


thanks,

Takashi

