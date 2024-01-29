Return-Path: <linux-kernel+bounces-43121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24859840BC4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F481C22EDE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C96A15B310;
	Mon, 29 Jan 2024 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QS7P6y5N";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q0I4l+8T"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B374615698B;
	Mon, 29 Jan 2024 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546008; cv=none; b=W43faLWebjEGQxy1ip6Mur5AcYifXpqoUmqEqqPgVARpRhORpav2Jc4DxJH0GFGaH3D+LWBCitje346TKidP2lZJjHJDv1dcz53kwWB4rSngknnz8XM+mHkODtCLR2Ccm2YvhH19shTAm/UUU5Kz5BZFV1MX071iaQXzPIdlX/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546008; c=relaxed/simple;
	bh=3v40ec3fp4rIySLwMRSC+DSQBuRjYm7PCdjEg/BN2qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzvO/0KebU7bI6EnQLsEjhjCoMcyRpRW0DTBVUxot8525uALSJ+BguZjJu6WVAP+NmUWGQoHZ349uwcW13TBXmcyNTef37OInzwZJvU5SwrC3bR3LczQGMbnStHkBEJ+bIQTmHaJAlCTCkaLV4Z9NtHATnqg1/7Ou8EyLId7gNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QS7P6y5N; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=q0I4l+8T; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from blackpad (unknown [10.100.12.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D827C21280;
	Mon, 29 Jan 2024 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706546002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3v40ec3fp4rIySLwMRSC+DSQBuRjYm7PCdjEg/BN2qM=;
	b=QS7P6y5NylUMxfuK6r6g4fywoDhhJIXpG9fyGzogfuMl36ZKDunidmXOJ6XVGwV3I69Ge4
	fcCjtuEYDKsUP9mx8ISkyr5opP1RkHUue2j/hzeADM63HHJA9T9cU18r0QdDKVQx1GXA4D
	OGaBzuuhU6U680MPu82F2UTHFbbLrTY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706546000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3v40ec3fp4rIySLwMRSC+DSQBuRjYm7PCdjEg/BN2qM=;
	b=q0I4l+8T7E1lhioda0ghqHOS8BmWrpp9LLLkQ1FVSr4xlnPaJGHrRte1C97ica/5adav1Z
	hvyp5W7+OIio0fSLbzR2AtrDZ6uTPEbJqkVwsVNe7Z8pRbJFoYWMijP7tD8c6wikqm5qTh
	8hQaYG8pivL4RwYt332QUgQ5RKAIZaU=
Date: Mon, 29 Jan 2024 17:33:19 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Deepak Kumar Singh <quic_deesin@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, afaerber@suse.com, 
	ivan.ivanov@suse.com
Subject: Re: Re: [RFC PATCH] rpmsg: glink: Add bounds check on tx path
Message-ID: <egp4g4i54le4iizpdfpxi24k563hniwub7iy2dwrk7ul47uhf4@z5scfrisbd46>
References: <20240113002505.15503-1-mkoutny@suse.com>
 <151f5738-791e-42cb-b8fe-e0cfbf9f7dca@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fdlqzqmm5seh4aly"
Content-Disposition: inline
In-Reply-To: <151f5738-791e-42cb-b8fe-e0cfbf9f7dca@quicinc.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.51
X-Spamd-Result: default: False [-0.51 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 NEURAL_SPAM_SHORT(2.21)[0.737];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 BAYES_HAM(-0.02)[53.78%]
X-Spam-Flag: NO


--fdlqzqmm5seh4aly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 29, 2024 at 04:18:36PM +0530, Deepak Kumar Singh <quic_deesin@quicinc.com> wrote:
> There is already a patch posted for similar problem -
> https://lore.kernel.org/all/20231201110631.669085-1-quic_deesin@quicinc.com/

I was not aware, thanks for the pointer.

Do you plan to update your patch to "just" bail-out/zero instead of
using slightly random values (as pointed out by Bjorn)?

Michal

--fdlqzqmm5seh4aly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZbfTTQAKCRAGvrMr/1gc
jjXFAP9Um5p58DEI4KDPRXFI2e/uPlQEy/pIzWZc4O3XF1pRUwEA+6k1aF11nti8
VOaJgaLHsoDXocKFBct9GyKDZz7F7g8=
=uPQp
-----END PGP SIGNATURE-----

--fdlqzqmm5seh4aly--

