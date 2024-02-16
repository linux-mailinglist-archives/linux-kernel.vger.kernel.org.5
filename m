Return-Path: <linux-kernel+bounces-68662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EEA857E02
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC02281BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984ED12BF1D;
	Fri, 16 Feb 2024 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K8tI6CD1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EmkAHWCs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rPMzMHVG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9Ozn174C"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C78129A9E;
	Fri, 16 Feb 2024 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091294; cv=none; b=FsTk5qRCkgdxxC91HkC+4X5Z/Y1QlSs1kLnrvV+SXPKp2KlxUaTSvxVxrHvwjXMKSAEuOZlZsTHzTUp2h1Z2b2U7TRWdtorHwehXvKX99NL6AjyqquSVNDSJ2/ADJw1KrRuvTzM+rZGi6VgcBmsYq3W1wYeq3VCwFFJ4s7D3TqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091294; c=relaxed/simple;
	bh=AUd/i/gCNVFvRDRbZinMTfyiBZcl7ncMvj1mbMkyqak=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KU+fq8jtE//GyBEzqQxky7Dym8Blo2j4QhTN4IhrSyXqcpVrlH95OcW4zLvbY7+mDHpX4os9P5snJtdwvlLLX8CR/1N3p+dzhuwzdWLlm7K54cvhDHEAZOINJ540mT3xu7Lgyr734/rmMICJlAFIdg9goIyyIiXnaiFgt8T4m2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K8tI6CD1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EmkAHWCs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rPMzMHVG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9Ozn174C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B0D4E1FB6C;
	Fri, 16 Feb 2024 13:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708091262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FANIEuihh+kpojnUiE93Db4hY1Uz1nVxL+OASfv1Ds0=;
	b=K8tI6CD1Ntt/mMAVCjTdTPjthVADmcDJq3XJ02ch9qaeCiTnBtANDND2bD7q0JUqTNpUFN
	CbnvBLe1sxPq4HOWzFvE1kllTJqHoKP/YWpHigkHOR2QYMDvWbOEtaBOBE+uKI1bK6NKZi
	O8PMQTd3v0ZZ4ERwc2Kyukr4wVsiiH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708091262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FANIEuihh+kpojnUiE93Db4hY1Uz1nVxL+OASfv1Ds0=;
	b=EmkAHWCsKoMzo+2EpZLzzkVU9P9X7r5xMnVtv8IdqL2OY5oKncpei0O1LRGhRJlcpt+7tU
	mf+nm5WL/FRIhMBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708091261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FANIEuihh+kpojnUiE93Db4hY1Uz1nVxL+OASfv1Ds0=;
	b=rPMzMHVGJteFpW3+T8nqziE3mzU3J9I8yOr4izc+m7jX+8vBf+WM+VnCpL9MWksg5y9yDI
	FgxjcdlFB3HluP5uHXh4cLUjvzPQ9+agm/iiwtm42dscVBv4bbopB2slI3Byo+nAVIKLLX
	MUluTYVfH+OWnCVwVeHWcAY+NHC5teY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708091261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FANIEuihh+kpojnUiE93Db4hY1Uz1nVxL+OASfv1Ds0=;
	b=9Ozn174CFydp4v2xk6JbboFtUkMQBjAvEnD3RyO6W+7X6yqnBETUhBbP8mLENsFtVvvtsW
	HZpnUM8bmED1SKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7332813A39;
	Fri, 16 Feb 2024 13:47:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IAtZGn1nz2WmKgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 16 Feb 2024 13:47:41 +0000
Date: Fri, 16 Feb 2024 14:47:41 +0100
Message-ID: <87cyswikqq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: avoid 'bool' as variable name
In-Reply-To: <20240216130211.3828455-1-arnd@kernel.org>
References: <20240216130211.3828455-1-arnd@kernel.org>
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
X-Spam-Score: -1.25
X-Spamd-Result: default: False [-1.25 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.95)[86.58%]
X-Spam-Flag: NO

On Fri, 16 Feb 2024 14:02:04 +0100,
Arnd Bergmann wrote:
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> In modern C versions, 'bool' is a keyword that cannot be used as
> a variable name, so change this instance use something else, and
> change the type to bool instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied.


Takashi

