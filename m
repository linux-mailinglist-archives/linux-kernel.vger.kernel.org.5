Return-Path: <linux-kernel+bounces-160502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 356B98B3E51
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D3D1C20E29
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB15416D301;
	Fri, 26 Apr 2024 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Jv2ITry/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Jv2ITry/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC571148854;
	Fri, 26 Apr 2024 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152897; cv=none; b=OGUWD+HEhNw/sg7Lo/xCNhLhmnTJMjP6PRZl5J+6D4lY48jgCIyHsBr23yZT1d7cVKIjwCrZHLpUEd34Ynvi4M3SEkzudvp0XmWLOzK4Jv8xaHsk92vw0g6Sl5ekhNenkazPgWYQsUNF39BgmpWN/9ThaR5fM4HlsKHPbwp3yiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152897; c=relaxed/simple;
	bh=0VbksMOsODA1WCu/dzHuDmP0hc5DG+CHv71ZWXXK1lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUZDbvAxxuEgflmBTYfg+R7+W/LR60q7ghzi45xPFpt5FqhGMqBT0Zu/J17A3+j7GmbaRLbGsc0hbaiq4WI6UpFlB8WlfiTnDtkclnM6lYcu3QwTzfGRQeKQ9t/ZCIMjpz2wnjy/EZtFcCurlR0vuwB+RCAOHdAYDUVyUua3dTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Jv2ITry/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Jv2ITry/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5F4915D3C7;
	Fri, 26 Apr 2024 17:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714152890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4ceGyo/Ua0O9gz2kTiItt6d/5Ru/yUEVPywxkSlUPc=;
	b=Jv2ITry/urbw/MDJYqH7s4TgCkel1/hhNDJQBOMMrdsT0/Stm7G2KCkGrVplZ8XGEOL5ah
	FVQLoplICL7TDLGVhoo8ldkgx2NnNlrrRogdwGDnWds3JitfBWSZsppOiAK5g6zuwNjJMV
	C7J85DgnTX4YwiRuApXeTh62sxQ434M=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="Jv2ITry/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714152890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4ceGyo/Ua0O9gz2kTiItt6d/5Ru/yUEVPywxkSlUPc=;
	b=Jv2ITry/urbw/MDJYqH7s4TgCkel1/hhNDJQBOMMrdsT0/Stm7G2KCkGrVplZ8XGEOL5ah
	FVQLoplICL7TDLGVhoo8ldkgx2NnNlrrRogdwGDnWds3JitfBWSZsppOiAK5g6zuwNjJMV
	C7J85DgnTX4YwiRuApXeTh62sxQ434M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 674E0139B1;
	Fri, 26 Apr 2024 17:34:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bO0aFrnlK2aMIgAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Fri, 26 Apr 2024 17:34:49 +0000
Date: Fri, 26 Apr 2024 19:34:45 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Breno =?utf-8?Q?Leit=C3=A3o?= <leitao@debian.org>, 
	Tejun Heo <tj@kernel.org>
Subject: Re: CVE-2023-52630: blk-iocost: Fix an UBSAN shift-out-of-bounds
 warning
Message-ID: <7x4ufwbvk4wmhag66rstdpbm4f2iplyc2l66cl7i2wl5nfh2tm@uxc425y2kfno>
References: <2024040219-CVE-2023-52630-a529@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="knjgfunz3pfevm5m"
Content-Disposition: inline
In-Reply-To: <2024040219-CVE-2023-52630-a529@gregkh>
X-Spam-Level: 
X-Spamd-Result: default: False [-6.11 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5F4915D3C7
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -6.11


--knjgfunz3pfevm5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 08:22:20AM +0200, Greg Kroah-Hartman <gregkh@linuxf=
oundation.org> wrote:
> Description
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> In the Linux kernel, the following vulnerability has been resolved:
>=20
> blk-iocost: Fix an UBSAN shift-out-of-bounds warning
>=20
> When iocg_kick_delay() is called from a CPU different than the one which =
set
> the delay, @now may be in the past of @iocg->delay_at leading to the
> following warning:
>=20
>   UBSAN: shift-out-of-bounds in block/blk-iocost.c:1359:23
>   shift exponent 18446744073709 is too large for 64-bit type 'u64' (aka '=
unsigned long long')
>   ...
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x79/0xc0
>    __ubsan_handle_shift_out_of_bounds+0x2ab/0x300
>    iocg_kick_delay+0x222/0x230
>    ioc_rqos_merge+0x1d7/0x2c0
>    __rq_qos_merge+0x2c/0x80
>    bio_attempt_back_merge+0x83/0x190
>    blk_attempt_plug_merge+0x101/0x150
>    blk_mq_submit_bio+0x2b1/0x720
>    submit_bio_noacct_nocheck+0x320/0x3e0
>    __swap_writepage+0x2ab/0x9d0
>=20
> The underflow itself doesn't really affect the behavior in any meaningful
> way; however, the past timestamp may exaggerate the delay amount calculat=
ed
> later in the code, which shouldn't be a material problem given the nature=
 of
> the delay mechanism.

The worst implication is unfair or slowed IO but that can't be
quantified given empirical implementation of the delay mechanism.

> If @now is in the past, this CPU is racing another CPU which recently set=
 up
> the delay and there's nothing this CPU can contribute w.r.t. the delay.

This means the user has limited control (with noise) over such
placements.

> Let's bail early from iocg_kick_delay() in such cases.
>=20
> The Linux kernel CVE team has assigned CVE-2023-52630 to this issue.

Based on the above I don't think this fix deserves CVE tracking. Shall
it be rejected?

Michal

--knjgfunz3pfevm5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZivlsgAKCRAGvrMr/1gc
jjvPAP9KnRcNccTCmxgDKg5Tj4NvHNZdghJaX4/2f56gYlaiXQD+OXKX8jXsywVQ
fCk6Pmj59+Yo5kdLqYxQvYGc5rxxjQo=
=Xtp6
-----END PGP SIGNATURE-----

--knjgfunz3pfevm5m--

