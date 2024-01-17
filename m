Return-Path: <linux-kernel+bounces-29249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFA5830B97
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E241F244F1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D58F225CB;
	Wed, 17 Jan 2024 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gDYtEBWS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+T6MFR+v";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gDYtEBWS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+T6MFR+v"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604FD225A1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705510817; cv=none; b=hQZY458UWA518K+tgggxYakQsW59veBb6OUu2c+R16eooMZEc+GqBYdazb6foVPHKLbOJYXdeolhdL0FkthzDI40xwphQ7VbTvwZqNue3eJ/7t7ELENl0num1SMsBVPv9wNl6rSTfcWEM6E3nTi3dwceH/xdN7f5Iw8Dy7IBA3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705510817; c=relaxed/simple;
	bh=nUhfynRQw0SAmsyL3bUNLuR88CILK5gA+qwvQvFqOPw=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Spam-Level:X-Spam-Score:X-Spamd-Result:X-Spam-Flag;
	b=C2YfMPi51B1APB/k10bTo2/4Ei4FAwQLyUrzTn3dQxKN3YHgIR8vGPDw4WXmWr1zcsPBMKYIkrh9CxuAiK9Gv6W+Jqnbq7cDvaya7ZW2NEe1rqZC0kXvtNUuuODs+v1PTtBVfyrJbb3vSt9z9mrK2+QeO/SwUFFpLJ3we54TKNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gDYtEBWS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+T6MFR+v; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gDYtEBWS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+T6MFR+v; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 696261FCDA;
	Wed, 17 Jan 2024 17:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705510814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9o0+yuyUMrXi9idbGF21yhZkpR86uzPwxcyPrphdms=;
	b=gDYtEBWSr5hcMeDAk8BtFi5Y7MtWKtsVhX8N4KqzuT/bjbygTwtRzu5NlmJTx2ZSEmT/JB
	vz19RzYhkx6jEvXIlmD3PkZmqJ/vyoYekluj86o25MhE5OtJQo/YWo/mZk41KmrP1D/FrO
	H7qnzwQSeKXkrp7yT+LqPwL1IGAzzns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705510814;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9o0+yuyUMrXi9idbGF21yhZkpR86uzPwxcyPrphdms=;
	b=+T6MFR+vOQW1P0TL07bkfQH4nAlcLzHEYrKXdTZimZXGIphWDADrGmbvA919Y9EBTkh4U6
	ZQNVmQTQukObOMBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705510814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9o0+yuyUMrXi9idbGF21yhZkpR86uzPwxcyPrphdms=;
	b=gDYtEBWSr5hcMeDAk8BtFi5Y7MtWKtsVhX8N4KqzuT/bjbygTwtRzu5NlmJTx2ZSEmT/JB
	vz19RzYhkx6jEvXIlmD3PkZmqJ/vyoYekluj86o25MhE5OtJQo/YWo/mZk41KmrP1D/FrO
	H7qnzwQSeKXkrp7yT+LqPwL1IGAzzns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705510814;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9o0+yuyUMrXi9idbGF21yhZkpR86uzPwxcyPrphdms=;
	b=+T6MFR+vOQW1P0TL07bkfQH4nAlcLzHEYrKXdTZimZXGIphWDADrGmbvA919Y9EBTkh4U6
	ZQNVmQTQukObOMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33EA013800;
	Wed, 17 Jan 2024 17:00:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oL9EC54HqGVVNwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 17 Jan 2024 17:00:14 +0000
Date: Wed, 17 Jan 2024 18:00:13 +0100
Message-ID: <87fryvuc82.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Bin Li <bin.li@canonical.com>
Cc: tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	aaron.ma@canonical.com,
	libin.charles@gmail.com
Subject: Re: [PATCH] ALSA: hda/realtek: Enable headset mic on Lenovo M70 Gen5
In-Reply-To: <20240117154123.21578-1-bin.li@canonical.com>
References: <20240117154123.21578-1-bin.li@canonical.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.20
X-Spamd-Result: default: False [-1.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-2.40)[97.24%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.com,alsa-project.org,vger.kernel.org,canonical.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Wed, 17 Jan 2024 16:41:23 +0100,
Bin Li wrote:
> 
> Lenovo M70 Gen5 is equipped with ALC623, and it needs
> ALC283_FIXUP_HEADSET_MIC quirk to make its headset mic work.
> 
> Signed-off-by: Bin Li <bin.li@canonical.com>

Thanks, applied now.


Takashi

