Return-Path: <linux-kernel+bounces-55308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AE084BAB2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A3AB260A6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6125D134CD3;
	Tue,  6 Feb 2024 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iMtyp49N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JRtN7CXY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lXiP/ZYD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IDJJySEM"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE1134CC6;
	Tue,  6 Feb 2024 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236097; cv=none; b=WvpALxjJHMJRa/NvYfi8cdG4S7wJK/CshmZXiXBEzQEGpZWkzD15anNHHGgCnXeD9/mqqcnRvrrzC3gqfaZsFaaidIAJxGpFnRYeMavi444NjI6RU0RkeynE3TjU/Qb1N63tXec27fEEUXEBsvN8ycOAYk4x7pVuJyhyQ4UmbqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236097; c=relaxed/simple;
	bh=rYgMKuXeeYNNmpYJbDLDGfYk707E0qHWmVKLXAui73k=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6rF2Pfb/pDpQiIEvzWdNbjDzxrSVby44t7T48hWMP1Qso4lL0vw2RsfWT9DsZLaniIK3OCs1uIDCCrCoC3xulRSXKUBVllbgBFdUp4O4lmPDrTsbcpIEX2JMlCCAbi0A9gaR/sb2w3Sy5QkfrEpKVY3moKGdlcibI+CTxorMZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iMtyp49N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JRtN7CXY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lXiP/ZYD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IDJJySEM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CE2822211D;
	Tue,  6 Feb 2024 16:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707236094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4N5m6Gf+OHcDb2SVGZM06tiTZHwCdlGokSrfyyYoxjk=;
	b=iMtyp49Np6kRjAglceliOVxQxpMofrzhDOr2C0EOXbenYv4Edkk+9MYGWosVXUrrOhBDTY
	sJzBTPXrdWhxe59M7+GbqPtep0EBKAs7u+Qj7V7dG8PlUZP+Zpk7d4f97B1azaCWbU0GHS
	RyOw6ZZ34zeHKx2IfayXe/DHV65EF9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707236094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4N5m6Gf+OHcDb2SVGZM06tiTZHwCdlGokSrfyyYoxjk=;
	b=JRtN7CXYAAk8c88QJyr1WkA8DnF44d/sXmTcwv0hyxH3KfaEEb4lafLci8vlI0ZPhJgjNI
	fEkKrLH25n5/hmDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707236093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4N5m6Gf+OHcDb2SVGZM06tiTZHwCdlGokSrfyyYoxjk=;
	b=lXiP/ZYDU0aTkoJ2nydfrogFvBQSdcV9SaCykLSk1MenNCY65YGetDSLAcygpdPR0zUbAD
	kMPrh2xfYgtf5gLyx92PnHYYQr8pEZrYRul+Z5WaSTOhk/bUePW4zkkv90zpcTrFLYajqB
	ZlotnV+8gBUdjxJ9eFrufIbNX8e/Ypo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707236093;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4N5m6Gf+OHcDb2SVGZM06tiTZHwCdlGokSrfyyYoxjk=;
	b=IDJJySEMEE4JolTPgptTnastNKZs6s3aJkAfj2wokW8AtWYYFuPcCi6KmhZmE2mev6YXiE
	ui2NRbeEG+wPLGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88A8A139D8;
	Tue,  6 Feb 2024 16:14:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cPWlH/1awmVSbwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 06 Feb 2024 16:14:53 +0000
Date: Tue, 06 Feb 2024 17:14:53 +0100
Message-ID: <87o7ct7eo2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?Jean-Lo=EFc?= Charroud <lagiraudiere+linux@free.fr>
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH] ALSA: hda/realtek: cs35l41: Fix internal speaker support for ASUS UM3402 with missing DSD
In-Reply-To: <eac660b7-5202-4ea1-836c-8d3cdb97c5d4@free.fr>
References: <eac660b7-5202-4ea1-836c-8d3cdb97c5d4@free.fr>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="lXiP/ZYD";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IDJJySEM
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.56 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[free.fr];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.05)[95.35%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[free.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[linux];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.56
X-Rspamd-Queue-Id: CE2822211D
X-Spam-Flag: NO

On Tue, 06 Feb 2024 10:14:04 +0100,
Jean-Loïc Charroud wrote:
> 
> Fix device ID for "ASUS UM3402" and "ASUS UM6702RA/RC".
> Add DSD values for "ASUS UM3402" to cs35l41_config_table[].
> Reorder alc269_fixup_tbl[] by device id and remove duplicate QUIRK
> entry for device {0x1043, 0x1f62, "ASUS UX7602ZM"}.
> 
> Signed-off-by: Jean-Loïc Charroud <lagiraudiere+linux@free.fr>

The patch isn't cleanly applicable, the tabs and spaces got broken
likely by your mailer.
Could you fix your mailer setup and resubmit?  At best with
git-send-email.


thanks,

Takashi

