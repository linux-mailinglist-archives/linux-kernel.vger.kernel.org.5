Return-Path: <linux-kernel+bounces-163589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6706E8B6D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CB86B232BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFE219DF74;
	Tue, 30 Apr 2024 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="b7wnGmB2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="b7wnGmB2"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2F912882C;
	Tue, 30 Apr 2024 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467017; cv=none; b=qkJjt+RQ1kFrb+L9jwkrUsa7TRQKcU2GrsZ1dXQHBZcCbU9IaDCtgP7QqSC0s10YP5Wsr1xiKaICE9+LNr4aRuPIr6jfyG+GcSPwKiSxSFkHAaMM5ZlqQiMPV5ViFNGrp9hTQfDp6SHjNV2KwT/ndWncmVhbgnqmx/Kw9oTabeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467017; c=relaxed/simple;
	bh=TJqxYEYHJvnMFSdcdCqGqHYKwQlZ/I3FWciJWjl/vqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euyXsnDZx3D3qNsh63NEza8j9yuBp78KMLS7j+Q0FwS8zSbJeBxtWW93rc26gg5CZhkzOIa+Iansu6yk1Vhp4ue/k16gT0o26s+Tfjyy5AIONNwmYACK8PCqEnLOxcoBi5YftD/OnKbnUBhnP1sQLrHmr06OYIqooX+IN5Kur5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=b7wnGmB2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=b7wnGmB2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A28431F7B3;
	Tue, 30 Apr 2024 08:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714467013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+yX/V0gmYAiZ8hWASvfR8uAFXA0zJcFjg9+aLM1w22I=;
	b=b7wnGmB2Y4obNVPl145JoRA21bcv/CrkzWS5zbArEnuGRYMO0nOPbXRvYYEUf2i13XMtZE
	aUdXGpHYVvH07CEJj8G6eXG9WGx4IXanfxtFqMAd/6c1kCf9fqwmq5Cp5LTkPH0xRMuwjb
	iVH7LAH1RgM6RjXkRxDBFM+umDGQ0LY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714467013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+yX/V0gmYAiZ8hWASvfR8uAFXA0zJcFjg9+aLM1w22I=;
	b=b7wnGmB2Y4obNVPl145JoRA21bcv/CrkzWS5zbArEnuGRYMO0nOPbXRvYYEUf2i13XMtZE
	aUdXGpHYVvH07CEJj8G6eXG9WGx4IXanfxtFqMAd/6c1kCf9fqwmq5Cp5LTkPH0xRMuwjb
	iVH7LAH1RgM6RjXkRxDBFM+umDGQ0LY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 960A2138A7;
	Tue, 30 Apr 2024 08:50:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XyF2JMWwMGY3UAAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Tue, 30 Apr 2024 08:50:13 +0000
Date: Tue, 30 Apr 2024 10:50:12 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org, 
	linux-cve-announce@vger.kernel.org, Breno =?utf-8?Q?Leit=C3=A3o?= <leitao@debian.org>, 
	Tejun Heo <tj@kernel.org>
Subject: Re: Re: CVE-2023-52630: blk-iocost: Fix an UBSAN shift-out-of-bounds
 warning
Message-ID: <yjipzunmzaq3zg4xtsfvref2qwmkaqb4z4z4ak7rd3vpl7iqtf@tgyehozvqd2k>
References: <2024040219-CVE-2023-52630-a529@gregkh>
 <7x4ufwbvk4wmhag66rstdpbm4f2iplyc2l66cl7i2wl5nfh2tm@uxc425y2kfno>
 <2024043053-campsite-refining-1c3c@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ros5gdjg56iqqxgf"
Content-Disposition: inline
In-Reply-To: <2024043053-campsite-refining-1c3c@gregkh>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -5.90
X-Spam-Flag: NO


--ros5gdjg56iqqxgf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2024 at 10:13:10AM +0200, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> Makes sense, thanks for looking into this, and sorry for the delay.  Now
> rejected.

Thanks!

Michal

--ros5gdjg56iqqxgf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZjCwrgAKCRAGvrMr/1gc
jj/WAQDDXJCSu4RiKGBXKe4DglhCpsRqLvy6016DzJTdk1IhSAD/SIUrAald989l
utECqxq3rKDZTgATERrExbUG+bbhdgo=
=I04Z
-----END PGP SIGNATURE-----

--ros5gdjg56iqqxgf--

