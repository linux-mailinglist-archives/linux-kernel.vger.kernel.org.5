Return-Path: <linux-kernel+bounces-42607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6248403BB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E28E1F23935
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965E05BACB;
	Mon, 29 Jan 2024 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FJJhHOtc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HRrekIDT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FJJhHOtc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HRrekIDT"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07125B21C;
	Mon, 29 Jan 2024 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527444; cv=none; b=f8bBmKiX59aM1dlnifuIn2wD/B3XRINYz64P0p3XFR8dkXZf3ZmTanljZ/n3uBXb+lcCZsuJINLHqOmpmICfhwkZYFIcOZ/CaScQLsf8wBsHjjn9tBmG0oCRcPkQ3NJ9Jr8aS6vB/omesGqIeXXO8VsHZ2rpKM/Leg2TBI5/+qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527444; c=relaxed/simple;
	bh=VhQbo2Ta/LUPWz7UoV9ADL7IXiXPbP+88STQOYGKQ78=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ahUoe/blyfgXpvt03YeB/dYCkigeNWhlRlmBSXTPm0SxHm5BUqNVk4xRw8KC+5qJ4KByWcb+c38ws45DPzWo+XAAOBzvGNpTMC0dEyv1n0F7A8gRT82FZ/N+nxDW58wVHRSZqyTenvEPluwK/74/9NUNI2dL7bZCaFc7RI/DVqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FJJhHOtc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HRrekIDT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FJJhHOtc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HRrekIDT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C492222033;
	Mon, 29 Jan 2024 11:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706527440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aj5mLb+2il4qUCNjeQIpYPe+3N72x6SbebAktm1kOU=;
	b=FJJhHOtc5nM+5SlZuIoZUlawukmxnfLMxuRotjwULN25sGiOBUF5T8RGEyL/nqFRMKWe6y
	zG1dlOE1Q/2NBr8kUmgIbkC99D/GsX8AQl+ZveZNEDQU5gVUIiqsgk5W6ksHyp5ewtefO4
	z0tUPhL/1vRT7gAd66FnCxUCLHCe7CY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706527440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aj5mLb+2il4qUCNjeQIpYPe+3N72x6SbebAktm1kOU=;
	b=HRrekIDTJvjzB6qTnyAk6zicT70gdnXVzwhDeSzWsI16DfT9BJhrf7X1KvFiELoHivW6d+
	PHUzvK7rE2mmp7Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706527440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aj5mLb+2il4qUCNjeQIpYPe+3N72x6SbebAktm1kOU=;
	b=FJJhHOtc5nM+5SlZuIoZUlawukmxnfLMxuRotjwULN25sGiOBUF5T8RGEyL/nqFRMKWe6y
	zG1dlOE1Q/2NBr8kUmgIbkC99D/GsX8AQl+ZveZNEDQU5gVUIiqsgk5W6ksHyp5ewtefO4
	z0tUPhL/1vRT7gAd66FnCxUCLHCe7CY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706527440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aj5mLb+2il4qUCNjeQIpYPe+3N72x6SbebAktm1kOU=;
	b=HRrekIDTJvjzB6qTnyAk6zicT70gdnXVzwhDeSzWsI16DfT9BJhrf7X1KvFiELoHivW6d+
	PHUzvK7rE2mmp7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EE9B13647;
	Mon, 29 Jan 2024 11:24:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M5ySD9CKt2UACwAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Mon, 29 Jan 2024 11:24:00 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id cb9889d0;
	Mon, 29 Jan 2024 11:23:59 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>,  Jarkko Sakkinen
 <jarkko@kernel.org>,  keyrings@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] keys: update key quotas in key_put()
In-Reply-To: <20240127064220.GB11935@sol.localdomain> (Eric Biggers's message
	of "Fri, 26 Jan 2024 22:42:20 -0800")
References: <2744563.1702303367@warthog.procyon.org.uk>
	<20240115120300.27606-1-lhenriques@suse.de>
	<20240124221225.GD1088@sol.localdomain> <87bk988450.fsf@suse.de>
	<20240127064220.GB11935@sol.localdomain>
Date: Mon, 29 Jan 2024 11:23:59 +0000
Message-ID: <87bk94qt68.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FJJhHOtc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HRrekIDT
X-Spamd-Result: default: False [-3.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C492222033
X-Spam-Level: 
X-Spam-Score: -3.31
X-Spam-Flag: NO

Eric Biggers <ebiggers@kernel.org> writes:

> On Fri, Jan 26, 2024 at 04:12:59PM +0000, Luis Henriques wrote:
>> Eric Biggers <ebiggers@kernel.org> writes:
>>=20
>> > On Mon, Jan 15, 2024 at 12:03:00PM +0000, Luis Henriques wrote:
>> >> Delaying key quotas update when key's refcount reaches 0 in key_put()=
 has
>> >> been causing some issues in fscrypt testing.  This patches fixes this=
 test
>> >> flakiness by dealing with the quotas immediately, but leaving all the=
 other
>> >> clean-ups to the key garbage collector.  Unfortunately, this means th=
at we
>> >> also need to switch to the irq-version of the spinlock that protects =
quota.
>> >>=20
>> >> Signed-off-by: Luis Henriques <lhenriques@suse.de>
>> >> ---
>> >> Hi David!
>> >>=20
>> >> I have these changes in my local disk for a while; I wanted to send t=
hem
>> >> before EOY break but... yeah, it didn't happen.  Anyway, I'm still se=
nding
>> >> it as an RFC as I'm probably missing something.
>> >>=20
>> >>  security/keys/gc.c     |  8 --------
>> >>  security/keys/key.c    | 32 ++++++++++++++++++++++----------
>> >>  security/keys/keyctl.c | 11 ++++++-----
>> >>  3 files changed, 28 insertions(+), 23 deletions(-)
>> >
>> > This patch seems reasonable to me, though I'm still thinking about cha=
nging
>> > fs/crypto/ to manage its key quotas itself which would avoid the issue=
 entirely.
>> >
>> > Note that as I said before, fs/crypto/ does key_put() on a whole keyri=
ng at
>> > once, in order to release the quota of the keys in the keyring.  Do yo=
u plan to
>> > also change fs/crypto/ to keyring_clear() the keyring before putting i=
t?
>> > Without that, I don't think the problem is solved, as the quota releas=
e will
>> > still happen asynchronously due to the keyring being cleared asynchron=
ously.
>>=20
>> Ah, good point.  In the meantime I had forgotten everything about this
>> code and missed that.  So, I can send another patch to fs/crypto to add
>> that extra call once (or if) this patch is accepted.
>>=20
>> If I'm reading the code correctly, the only place where this extra call =
is
>> required is on fscrypt_put_master_key():
>>=20
>> diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
>> index 0edf0b58daa7..4afd32f1aed9 100644
>> --- a/fs/crypto/keyring.c
>> +++ b/fs/crypto/keyring.c
>> @@ -74,6 +74,7 @@ void fscrypt_put_master_key(struct fscrypt_master_key =
*mk)
>>  	 * that concurrent keyring lookups can no longer find it.
>>  	 */
>>  	WARN_ON_ONCE(refcount_read(&mk->mk_active_refs) !=3D 0);
>> +	keyring_clear(mk->mk_users);
>>  	key_put(mk->mk_users);
>>  	mk->mk_users =3D NULL;
>
> This will need a NULL check, since keyring_clear() doesn't accept NULL:
>
> 	if (mk->mk_users) {
> 		keyring_clear(mk->mk_users);
> 		key_put(mk->mk_users);
> 		mk->mk_users =3D NULL;
> 	}
>

Ah, good point.  Makes sense.

>>  	call_rcu(&mk->mk_rcu_head, fscrypt_free_master_key);
>>=20
>> On the other hand, if you're really working towards dropping this code
>> entirely, maybe there's not point doing that.
>
> Well, it depends whether this patch (the one for security/keys/) is accep=
ted or
> not.  If it's accepted, I think it makes sense to add the keyring_clear()=
 and
> otherwise keep the fs/crypto/ code as-is.  If it's not accepted, I think =
I'll
> have to make fs/crypto/ handle the quotas itself.

Awesome, thank.

David, do you have any feedback on this patch or would you rather have me
send v3, addressing Jarkko comments regarding the commit message?

Cheers,
--=20
Lu=C3=ADs

