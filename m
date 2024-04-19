Return-Path: <linux-kernel+bounces-151278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD208AAC55
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF5ABB227C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774D27E0FB;
	Fri, 19 Apr 2024 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z6w9vO6+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="docqLR7K";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ui8Y2w+8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PbhhxvCh"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA24F7C0A9;
	Fri, 19 Apr 2024 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520901; cv=none; b=Dv1EPgfE6LCE2CNFe91JyAi5VjP8cO3bnktLNykLqn2Vp2DDQ8DWFvvuN984DsRjEkIIArHYsUPuQ/dKfkSrUr/wVjKDAcTB/oW12UgfexoNEkKkF6XkF3NOlcB/qt5MD4FhD2dyEdx7JbaYdILF4AEq0QiKi8Gg7y2tk65OP2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520901; c=relaxed/simple;
	bh=xHKK6J7HyB6h9onkrpVnWnSrBmbzD+Zt2PN1UgHRVAw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8BkPx0TBmE+T6EMrGMeY3+4p/XmnK47Ru6UNoMLoUbx82UmlHCOKTTN7qDHLQOyOBIcETjORjHIJ1WlluBqaPauQTRYlShRaBXfTJJorJq4aoxLreSIhN4hFJSKRIhU24WC46zKpNp0LNtHvZaOD8O5XtdL2LJM+FYxxtErxPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z6w9vO6+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=docqLR7K; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ui8Y2w+8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PbhhxvCh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4320E208AF;
	Fri, 19 Apr 2024 10:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713520894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x5wdBG6p1xzMoT3vI2yLSnaYsmsNjk+6tdZl7RecrCo=;
	b=z6w9vO6+54VJ47vxZXUnSMuKaoRuoyGAfL9IM6nlLl8lruLlpwHUkDse97P6vGJIHvkSG9
	DhIngRItIAz/HIbDaoTqbAPyowTcpz0czxO1Tf64tdncshVa5GlcHsUoKqlMLZQO06pPo9
	F6WKbkhJ++313rbxqG9+muO8kro8hY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713520894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x5wdBG6p1xzMoT3vI2yLSnaYsmsNjk+6tdZl7RecrCo=;
	b=docqLR7Kn2TnqaF1QoCzHb+kIwD+5KGTFfdnlK1eKfDizktpy14Kn+kTYILcBSJWFc1gr0
	70zBYoqIEK6uI5Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ui8Y2w+8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PbhhxvCh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713520893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x5wdBG6p1xzMoT3vI2yLSnaYsmsNjk+6tdZl7RecrCo=;
	b=ui8Y2w+85lyOM01fUkVy/y/lAWdwKJFHQcolXGFmoUwuPNbco+7cko8tybIsZqd0d8y+pp
	rgBCzYX/xCEOrkGHYLXsAlW142RpEYsmUW38CX2DK4B2HBGxg1NoEBcYfBNqSo5+S5WjAV
	aHuvg252feAGWdx4VJcVGdP6wrCJ+C8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713520893;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x5wdBG6p1xzMoT3vI2yLSnaYsmsNjk+6tdZl7RecrCo=;
	b=PbhhxvChh2rcNp3ITYiSOtq+kEbwgv0lvziBOIFnx7YcXXwpK+5H7tZmZsJUCWH79CrjJ6
	MIpHo2Vcer+5WQAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5226136CF;
	Fri, 19 Apr 2024 10:01:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z2m0MvxAImbHDAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 19 Apr 2024 10:01:32 +0000
Date: Fri, 19 Apr 2024 12:01:40 +0200
Message-ID: <87r0f1u0vv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ai Chao <aichao@kylinos.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	luke@ljones.dev,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/realtek - Enable audio jacks of Haier Boyue G42 with ALC269VC
In-Reply-To: <20240419082159.476879-1-aichao@kylinos.cn>
References: <20240419082159.476879-1-aichao@kylinos.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.44 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.93)[86.39%];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,kylinos.cn:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4320E208AF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -1.44

On Fri, 19 Apr 2024 10:21:59 +0200,
Ai Chao wrote:
> 
> The Haier Boyue G42 with ALC269VC cannot detect the MIC of headset,
> the line out and internal speaker until
> ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS quirk applied.
> 
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
> v2: Follow PCI SSID order.

Thanks, applied now.


Takashi

