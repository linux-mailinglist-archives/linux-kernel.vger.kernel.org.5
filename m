Return-Path: <linux-kernel+bounces-56576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A55E384CBDC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB8A1F2360A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A3A7A70F;
	Wed,  7 Feb 2024 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sdUhc/Sj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8UqOy8GD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sdUhc/Sj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8UqOy8GD"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721987993D;
	Wed,  7 Feb 2024 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313347; cv=none; b=a6Rr8w0eFkSX1u2TzOf0RXXo2eJseveOzRYH00Z3S/zzl9fb7N4XQRCb95yI0bl6ml1kouU4eguvVj9pDpN23iuFiF67qlrKyJ1P4BMRa2+Yysm7dY/Y0Slmg1lXa7mls+1JPzRz5EgTfnKJEtjr5jlEj6oz7eHIjpLK1rBZpns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313347; c=relaxed/simple;
	bh=biTnfIR0P6z4A+HuIjLWtAZ/odQWEGrcuiQOu0E4WKo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSXvH577EFNTR1JGR1r55AP1GkmjMsYrOCKqMzsuEiTD9ltWUiIeJbAaFK6RlWl8rLgwRUOKip+vEC/1bpHSMGrjc+f4wVzRNKupcpElz7S80gbO8Ctg/D6kHMWUaYEyE98bTrQ01O+K4r1nWdpHiTq9b2q5WTUE42T7gpa2IQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sdUhc/Sj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8UqOy8GD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sdUhc/Sj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8UqOy8GD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 91B541FC04;
	Wed,  7 Feb 2024 13:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707313343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JlakNdSdjpymzVj6r977DOdnguJBAVAgJvVlaPKXIko=;
	b=sdUhc/Sjbs2A0k+Pym4m6CwUvQKkyCQ2hR7gijqD2Jc+t4xUru8lwzYaK0+9gU5SJpZdFl
	1NrLD8Qw72bJPWxhCPW2qENFySj27/dUgjVvcK3QxjkplpwkhLBX2x+5nyN4YXrEKRtoF/
	8nMuvnOUpTi4+AQJwjCRnnDeiWWYNSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707313343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JlakNdSdjpymzVj6r977DOdnguJBAVAgJvVlaPKXIko=;
	b=8UqOy8GDOjAR3qhJOSFIw2RfUbNLFOPvXVz+l/jqZAy0+eTi6TXvKkvJO4Z1CsjwAfbmtR
	Ut0XkK7Lu8XxmMAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707313343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JlakNdSdjpymzVj6r977DOdnguJBAVAgJvVlaPKXIko=;
	b=sdUhc/Sjbs2A0k+Pym4m6CwUvQKkyCQ2hR7gijqD2Jc+t4xUru8lwzYaK0+9gU5SJpZdFl
	1NrLD8Qw72bJPWxhCPW2qENFySj27/dUgjVvcK3QxjkplpwkhLBX2x+5nyN4YXrEKRtoF/
	8nMuvnOUpTi4+AQJwjCRnnDeiWWYNSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707313343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JlakNdSdjpymzVj6r977DOdnguJBAVAgJvVlaPKXIko=;
	b=8UqOy8GDOjAR3qhJOSFIw2RfUbNLFOPvXVz+l/jqZAy0+eTi6TXvKkvJO4Z1CsjwAfbmtR
	Ut0XkK7Lu8XxmMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 477DB139B9;
	Wed,  7 Feb 2024 13:42:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EOvzD7+Iw2WdHwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 07 Feb 2024 13:42:23 +0000
Date: Wed, 07 Feb 2024 14:42:22 +0100
Message-ID: <87o7cs5r29.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?Jean-Lo=EFc?= Charroud <lagiraudiere+linux@free.fr>
Cc: Takashi Iwai <tiwai@suse.de>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v2] ALSA: hda/realtek: cs35l41: Fix internal speaker support for ASUS UM3402 with missing DSD
In-Reply-To: <726559913.576332068.1707239153891.JavaMail.zimbra@free.fr>
References: <726559913.576332068.1707239153891.JavaMail.zimbra@free.fr>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.07 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.33)[75.89%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[free.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[linux];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[free.fr];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: **
X-Spam-Score: 2.07
X-Spam-Flag: NO

On Tue, 06 Feb 2024 18:05:53 +0100,
Jean-Loïc Charroud wrote:
> 
> Fix device ID for "ASUS UM3402" and "ASUS UM6702RA/RC".
> Add _DSD values for "ASUS UM3402" to cs35l41_config_table[].

So far, so good, but...

> Reorder alc269_fixup_tbl[] by device id and remove duplicate QUIRK
> entry for device {0x1043, 0x1f62, "ASUS UX7602ZM"}.

Don't mix up multiple things in a single patch.
The sort of the existing entries has little to do with your change.
Leave it to another patch instead (with Fixes tag for the
corresponding commit, too).


thanks,

Takashi

