Return-Path: <linux-kernel+bounces-40318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0D983DE64
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BBA7B20C40
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07531D559;
	Fri, 26 Jan 2024 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NiXb+5/D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E6wxnN77";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NiXb+5/D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E6wxnN77"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5902E1CF92;
	Fri, 26 Jan 2024 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706285584; cv=none; b=rgOjvi2bTuhhfbNLInUCb3FSH3MX8Mit1wQtsN6TjXHYyMEJsY07tt/i39AkdLSJn/86AkzMHmy/1MnNbtfNvWtbHfgZL2l3gYs5YZ/jlq3FgO3Ps9sm1trTFE359UMVkpVnbyl5ab7dMK00shycDD05Wdngi6E2KubW7k4ie3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706285584; c=relaxed/simple;
	bh=D7Il6TcJrHrENwBzqDk4YJ8I9CxcEHlbklcOggMCQAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fdQLiufgUwPTIX2SlQLzfwiOUZ9N0IjikfpRaK/upCcWf/SpLGvPv7F9EESeapxvR1lLVTIBsbcveVgOz57JWS8oLAGXVkqzcbTpiT7moN0KFL1liNugpe+FpnrXMQq6OLYrASfv4nhSTooC7pO4hDnHpzWQPJ1WqIakRA5pB9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NiXb+5/D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E6wxnN77; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NiXb+5/D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E6wxnN77; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6BF7C1F749;
	Fri, 26 Jan 2024 16:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706285580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxeqAeeZ/c+Prn9baOvxevx3t4mfvUcXn7Z1NU+Rph8=;
	b=NiXb+5/DaFYxM28qfN+Jtef3H3Hg2DLr8TnAo8Eo6e/gmUzGvAH7o2R7hm8Fsrgmq6TG44
	VZF0SeX4hCAHZ4BCc+8FrLtqfjJ0r7lqqlz+8dpH3diL2dC28Mr9HVhRexQJSEq1BDcYL+
	SST64yfHNpo3m71YKq1ELqZ14O7zc7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706285580;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxeqAeeZ/c+Prn9baOvxevx3t4mfvUcXn7Z1NU+Rph8=;
	b=E6wxnN77LN1HfYVG6vtMksGrJoA+3w7Xend2RxbA4l/3l9msxWRbq4KNeBGamq2QIwDR7R
	yCBNn3k6DJldAACg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706285580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxeqAeeZ/c+Prn9baOvxevx3t4mfvUcXn7Z1NU+Rph8=;
	b=NiXb+5/DaFYxM28qfN+Jtef3H3Hg2DLr8TnAo8Eo6e/gmUzGvAH7o2R7hm8Fsrgmq6TG44
	VZF0SeX4hCAHZ4BCc+8FrLtqfjJ0r7lqqlz+8dpH3diL2dC28Mr9HVhRexQJSEq1BDcYL+
	SST64yfHNpo3m71YKq1ELqZ14O7zc7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706285580;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxeqAeeZ/c+Prn9baOvxevx3t4mfvUcXn7Z1NU+Rph8=;
	b=E6wxnN77LN1HfYVG6vtMksGrJoA+3w7Xend2RxbA4l/3l9msxWRbq4KNeBGamq2QIwDR7R
	yCBNn3k6DJldAACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07F8E13A22;
	Fri, 26 Jan 2024 16:12:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4spGOgvas2UrEwAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Fri, 26 Jan 2024 16:12:59 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id 47f93bf8;
	Fri, 26 Jan 2024 16:12:59 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>,  Jarkko Sakkinen
 <jarkko@kernel.org>,  keyrings@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] keys: update key quotas in key_put()
In-Reply-To: <20240124221225.GD1088@sol.localdomain> (Eric Biggers's message
	of "Wed, 24 Jan 2024 14:12:25 -0800")
References: <2744563.1702303367@warthog.procyon.org.uk>
	<20240115120300.27606-1-lhenriques@suse.de>
	<20240124221225.GD1088@sol.localdomain>
Date: Fri, 26 Jan 2024 16:12:59 +0000
Message-ID: <87bk988450.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="NiXb+5/D";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=E6wxnN77
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 6BF7C1F749
X-Spam-Flag: NO

Eric Biggers <ebiggers@kernel.org> writes:

> On Mon, Jan 15, 2024 at 12:03:00PM +0000, Luis Henriques wrote:
>> Delaying key quotas update when key's refcount reaches 0 in key_put() has
>> been causing some issues in fscrypt testing.  This patches fixes this te=
st
>> flakiness by dealing with the quotas immediately, but leaving all the ot=
her
>> clean-ups to the key garbage collector.  Unfortunately, this means that =
we
>> also need to switch to the irq-version of the spinlock that protects quo=
ta.
>>=20
>> Signed-off-by: Luis Henriques <lhenriques@suse.de>
>> ---
>> Hi David!
>>=20
>> I have these changes in my local disk for a while; I wanted to send them
>> before EOY break but... yeah, it didn't happen.  Anyway, I'm still sendi=
ng
>> it as an RFC as I'm probably missing something.
>>=20
>>  security/keys/gc.c     |  8 --------
>>  security/keys/key.c    | 32 ++++++++++++++++++++++----------
>>  security/keys/keyctl.c | 11 ++++++-----
>>  3 files changed, 28 insertions(+), 23 deletions(-)
>
> This patch seems reasonable to me, though I'm still thinking about changi=
ng
> fs/crypto/ to manage its key quotas itself which would avoid the issue en=
tirely.
>
> Note that as I said before, fs/crypto/ does key_put() on a whole keyring =
at
> once, in order to release the quota of the keys in the keyring.  Do you p=
lan to
> also change fs/crypto/ to keyring_clear() the keyring before putting it?
> Without that, I don't think the problem is solved, as the quota release w=
ill
> still happen asynchronously due to the keyring being cleared asynchronous=
ly.

Ah, good point.  In the meantime I had forgotten everything about this
code and missed that.  So, I can send another patch to fs/crypto to add
that extra call once (or if) this patch is accepted.

If I'm reading the code correctly, the only place where this extra call is
required is on fscrypt_put_master_key():

diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 0edf0b58daa7..4afd32f1aed9 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -74,6 +74,7 @@ void fscrypt_put_master_key(struct fscrypt_master_key *mk)
 	 * that concurrent keyring lookups can no longer find it.
 	 */
 	WARN_ON_ONCE(refcount_read(&mk->mk_active_refs) !=3D 0);
+	keyring_clear(mk->mk_users);
 	key_put(mk->mk_users);
 	mk->mk_users =3D NULL;
 	call_rcu(&mk->mk_rcu_head, fscrypt_free_master_key);

On the other hand, if you're really working towards dropping this code
entirely, maybe there's not point doing that.

Cheers,
--=20
Lu=C3=ADs


