Return-Path: <linux-kernel+bounces-52754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939F3849C51
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97961C2427E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDED022EF8;
	Mon,  5 Feb 2024 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UsKyBxQw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RQO/mBUe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UsKyBxQw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RQO/mBUe"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BBC2263E;
	Mon,  5 Feb 2024 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141279; cv=none; b=FGMkTqYiGmvKLkphBOe4Uqg/xgF58CC4Ym4PwITaRV7T2YrtAP210ZixRSsg6YeBgIcqwQ8FXLYHu3QqGZ3wqcqIVSQV2T7y99aLnqgDPNQIycLhGBUdIF51vdWA1x8loL+qiiyudvSySBwLqcCM5G/G+4OTPAdqaZY4g+4ZvYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141279; c=relaxed/simple;
	bh=xY7sIFM80Rbz3G4McrGuT+OINz0NOWltW76ses9f6pM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L5b7G5x/RNny81zYuBw/9sMtcF7H6MYyUhEjwUkhwq8y0sBprKYnWE78YS5tD65fcWp41E5HVF7N/RokuXEZ6nUJ6ei7BnpKh0oVUb0K0eaqr3CePvlVluRJLcAIqwDaHIYEnw/rivRqu3vjWLqn0YvmKybfs9fKjGuI9SfNdDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UsKyBxQw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RQO/mBUe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UsKyBxQw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RQO/mBUe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 99D80219DA;
	Mon,  5 Feb 2024 13:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707141273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91FYVkMXI27dv7DB+mH1AzEVYKDByPJDu/tzLV3zDrs=;
	b=UsKyBxQw21LyQfWqRS0xMqZYRSLQEl5j76mYaTD4EaIz7FQ71hfuhAntMi3PfZ7zbtDfwl
	wH4nIGAjLyrg0OKkgyj1F4wzufQSZjy+uo5u0cNPWqxcCevh48Tyuc/B0AfW57eF00XRjW
	m/iwevtE5g5smuCkAoZSZ8CKBWwe6Ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707141273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91FYVkMXI27dv7DB+mH1AzEVYKDByPJDu/tzLV3zDrs=;
	b=RQO/mBUecyRisGHTsrmvIVXTs232vjGtIyhwEAWTtA0UTetQwt2StSE3lID+CiATLiS0za
	iLmvjPuD5Tb5t8Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707141273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91FYVkMXI27dv7DB+mH1AzEVYKDByPJDu/tzLV3zDrs=;
	b=UsKyBxQw21LyQfWqRS0xMqZYRSLQEl5j76mYaTD4EaIz7FQ71hfuhAntMi3PfZ7zbtDfwl
	wH4nIGAjLyrg0OKkgyj1F4wzufQSZjy+uo5u0cNPWqxcCevh48Tyuc/B0AfW57eF00XRjW
	m/iwevtE5g5smuCkAoZSZ8CKBWwe6Ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707141273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91FYVkMXI27dv7DB+mH1AzEVYKDByPJDu/tzLV3zDrs=;
	b=RQO/mBUecyRisGHTsrmvIVXTs232vjGtIyhwEAWTtA0UTetQwt2StSE3lID+CiATLiS0za
	iLmvjPuD5Tb5t8Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2762E136F5;
	Mon,  5 Feb 2024 13:54:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KPBuBZTowGWYZQAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Mon, 05 Feb 2024 13:54:28 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id 27a4dd74;
	Mon, 5 Feb 2024 13:54:11 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,  Eric Biggers
 <ebiggers@kernel.org>,  keyrings@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] keys: update key quotas in key_put()
In-Reply-To: <3007646.1707134664@warthog.procyon.org.uk> (David Howells's
	message of "Mon, 05 Feb 2024 12:04:24 +0000")
References: <20240130101344.28936-1-lhenriques@suse.de>
	<3007646.1707134664@warthog.procyon.org.uk>
Date: Mon, 05 Feb 2024 13:54:11 +0000
Message-ID: <87il33f24c.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.00)[16.05%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.10

David Howells <dhowells@redhat.com> writes:

> Luis Henriques <lhenriques@suse.de> wrote:
>
>> Delaying key quotas update when key's refcount reaches 0 in key_put() has
>> been causing some issues in fscrypt testing, specifically in fstest
>> generic/581.  This commit fixes this test flakiness by dealing with the
>> quotas immediately, and leaving all the other clean-ups to the key garba=
ge
>> collector.
>
> Okay, I'll accept this.
>

That's awesome, thanks a lot David.  And, as Eric requested, I'll send out
shortly a follow-up fscrypt-specific patch, which will make generic/581
fstest finally pass.

Cheers,
--=20
Lu=C3=ADs


>> This is done by moving the updates to the qnkeys and qnbytes fields in
>> struct key_user from key_gc_unused_keys() into key_put().
>> Unfortunately, this also means that we need to switch to the
>> irq-version of the spinlock that protects these fields and use
>> spin_lock_{irqsave,irqrestore} in all the code that touches these
>> fields.
>
> ... Which shouldn't be that often.  It only happens when a key is created=
 or
> finally let go of.
>
>> Signed-off-by: Luis Henriques <lhenriques@suse.de>
>
> Acked-by: David Howells <dhowells@redhat.com>
>
> Jarkko - could you pick this up?
>


