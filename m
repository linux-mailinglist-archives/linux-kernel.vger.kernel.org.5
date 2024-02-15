Return-Path: <linux-kernel+bounces-67046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD0985654A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F70B2A817
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DF1131E4A;
	Thu, 15 Feb 2024 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HIe8BbWL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LaPvB19g";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HIe8BbWL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LaPvB19g"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E335A131E34;
	Thu, 15 Feb 2024 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005871; cv=none; b=GlnMbG1BuTrIYmY1D4UMlqbXUCKfBvmrx8V16esevrxOcM4GzXLuVeMIgihFH8pFeEKPgfrbvwqnVaX5FU+TeBlsZhTZbDpFHVT6bYHMn9pSp+V7mEj8Y0ARo2VROc9w7YdPx1wWZ6Xn4KaBwq2yrofscCtTHIZpKrFDT1h+9ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005871; c=relaxed/simple;
	bh=njQRUvvclzFnE8Ay9P08gRLmVoBlZGDgoIiDWrhUP6g=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psT/+1uhZe1beIem0rfxto4np/6rcPrF1KIHD4JcAIJpU1ZLFTxsPxQKFikZ0KePQfRgvlnJ2nHfB1j3rGVsw323buQ34a8TspWQvXufbVSxLwMkiejMvTC6vz03nKAZNbXImcgGYqcun38uO1r3iABQkhr1XFhjDp7z2xN4vmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HIe8BbWL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LaPvB19g; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HIe8BbWL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LaPvB19g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2988D21F4C;
	Thu, 15 Feb 2024 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708005868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MqlIAGsDAmdAOKkcbo+b/U2RCdxvbu7VSb2tSblcO+w=;
	b=HIe8BbWLrm/S6Er54Rs66rYLIbpKjs36mvsyoLfFJU5vD36/jCk1klhliXwG3nvojs98eF
	yi3sCbatvDsP0XJF9L/WvMc3i62o1qpnZzkyLzLetnyePyKKV6YauTcJTxvw/1FPxWXhF0
	eGKfU3CBP6djfy67sR6NfpygrVhSqQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708005868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MqlIAGsDAmdAOKkcbo+b/U2RCdxvbu7VSb2tSblcO+w=;
	b=LaPvB19gIWCPSfKBWtDXPltWhfolOlJLSZrmLU/oWFO92pj0bmOitN5/KYfkOIV+35Vn+w
	cLb7Oum2sYN6iKDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708005868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MqlIAGsDAmdAOKkcbo+b/U2RCdxvbu7VSb2tSblcO+w=;
	b=HIe8BbWLrm/S6Er54Rs66rYLIbpKjs36mvsyoLfFJU5vD36/jCk1klhliXwG3nvojs98eF
	yi3sCbatvDsP0XJF9L/WvMc3i62o1qpnZzkyLzLetnyePyKKV6YauTcJTxvw/1FPxWXhF0
	eGKfU3CBP6djfy67sR6NfpygrVhSqQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708005868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MqlIAGsDAmdAOKkcbo+b/U2RCdxvbu7VSb2tSblcO+w=;
	b=LaPvB19gIWCPSfKBWtDXPltWhfolOlJLSZrmLU/oWFO92pj0bmOitN5/KYfkOIV+35Vn+w
	cLb7Oum2sYN6iKDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC7AD13A82;
	Thu, 15 Feb 2024 14:04:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aW8pOOsZzmUfYAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 15 Feb 2024 14:04:27 +0000
Date: Thu, 15 Feb 2024 15:04:27 +0100
Message-ID: <87mss1esd0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: seq: remove redundant 'tristate' for SND_SEQ_UMP_CLIENT
In-Reply-To: <20240215135304.1909431-1-masahiroy@kernel.org>
References: <20240215135304.1909431-1-masahiroy@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HIe8BbWL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LaPvB19g
X-Spamd-Result: default: False [-2.16 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
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
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.85)[99.33%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2988D21F4C
X-Spam-Level: 
X-Spam-Score: -2.16
X-Spam-Flag: NO

On Thu, 15 Feb 2024 14:53:04 +0100,
Masahiro Yamada wrote:
> 
> 'def_tristate' is a shorthand for 'default' + 'tristate'.
> 
> Another 'tristate' is redundant.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks, applied.


Takashi

