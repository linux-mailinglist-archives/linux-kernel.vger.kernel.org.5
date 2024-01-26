Return-Path: <linux-kernel+bounces-40247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3D783DD27
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A9D1F237D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF751CF9C;
	Fri, 26 Jan 2024 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="akmA595R"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5161D54A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281940; cv=none; b=vC8JYx4KbVEyBNNd8E+kJG55IBkNcsIEVRIoQOlc770fiue4MTVQ+0KQhjEDayuYmc+Vnwm0s77qE5bUaM1pvTOB9ZzMg4jw/CJDLLdNtLFdVKGwxM45Xowblx9L3J/3XO4aHKP9gcASDAudJ/MAuAzPRHkZjdo1iAlHFmvmuxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281940; c=relaxed/simple;
	bh=4RE9EljdMUOvnOvsl8qSrh585fszJ7BPNfle+haelpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qT7TZx/crBOAcpMcabtoJN/KKKY+2chY0/qzCvaxTuaeXNuVby1gRVFQZf+odW2rHggs5wQF9ppFwMGXchZD4461OAvNs0n6R3Rk1o11RGUpvoQ2l9BtbexxtBGEmBJV0bjt2fRTzhesKXMil9IjKUZEjONyt3jP1vNmvqE0RMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=akmA595R; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=4RE9
	EljdMUOvnOvsl8qSrh585fszJ7BPNfle+haelpc=; b=akmA595RRupGZ7bwoG9i
	5FPVeNPTjcyIfIxcBszYKnEAdPne6lyuMmDADPF5MPci74u83wT1iNJAkUXp+Lnq
	2caLgNZSsdqLW6VG4149zgkZkPZ6M/3ZLxl/fP0RutpuXiJeSZJukFnQYjJCytJ+
	CYCCZAruYH+GhXVJf+Rciv9LFJwr5IAUA4XouLJBXHNL+T652y7xG7ZKOaXInJPR
	ajG3HTy8FeNA9sU1hJlUeSRDnYxXlhBLs53mpkC1L5xcdQrAivdqpAzNl+AuSxLR
	ntv4Ee0A/kbeS2YODgHsVfj65vabzoDTXiQq0OFMdcfzgQ6Vz2aUErF6vKCUbf1J
	oA==
Received: (qmail 1549173 invoked from network); 26 Jan 2024 16:05:32 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Jan 2024 16:05:32 +0100
X-UD-Smtp-Session: l3s3148p1@KtWeoNoPUsxehhrU
Date: Fri, 26 Jan 2024 16:05:32 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/2] arm64: dts: renesas: ulcb-kf: add node for
 GNSS
Message-ID: <ZbPKPGB7DIHhZ3GJ@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-renesas-soc@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20240117131807.24997-1-wsa+renesas@sang-engineering.com>
 <20240117131807.24997-3-wsa+renesas@sang-engineering.com>
 <CAMuHMdX7Z8w0JykKuboP__ZE4x+LeKSQAGdyrUezERxysPUCKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rRSFQ5n7OdqjkQvG"
Content-Disposition: inline
In-Reply-To: <CAMuHMdX7Z8w0JykKuboP__ZE4x+LeKSQAGdyrUezERxysPUCKA@mail.gmail.com>


--rRSFQ5n7OdqjkQvG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Can it be used over I2C too? Is there some strapping to select the
> interface used? I couldn't find that in the documentation.

It looks to me they both work at the same time. I was able to write and
read via I2C (thus not very meaningful data) while serial port was doing
the real work. I am not aware of a full GNSS implementation supporting
the I2C interface, so I considered it good at that point.


--rRSFQ5n7OdqjkQvG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmWzyjgACgkQFA3kzBSg
KbaRiQ//bxRG4uuUlTt8MoZCNahMBC79+M3/Ki+7+wA/uAHJkTp0HU205zSwDi8Q
Knl7i63CbabFPED93WeqrkDm7QVW4f0iaQ7fSe0MhkLD8sHRhhr3N3KkTjEwwmJj
r05N6Ygt6nw/d0ncZnQbpTx5aM5a6GY2h/xN6P+6SnozAylqAiNCht09P4OnFvLu
QGybJJPafwe3KbXGK2hhNsS7fTs7Kg1dijPVhY444xcgKbRHWzdGnbu+0PfZOPCP
A8UtgKRn+HdbDfAkH/e7naVC1MMA7PyFM7TEmi8dAz/u65c20ZlkpO/k0dWcMqKW
94Z/dR3RZfmYBLxp7N7g9DBR/l919g+wnHU24h+1PYxmCia1YHgVyABbANXsulyW
Mw1DM5Hm+S9J2Kn5PaOIPuyDFn/GBlqGZour/dZv1OMk9P1n9/9L8V9u/MDTXV8i
YIQlxl5+AfyYpZqvhrOWDllBoxLTrLQX32d2hABBW7XE3pQuBm8z+RJBcfAi9WAI
DOe31HalytJvGvhfR8je+yPDPQQ/oAe/VnhhFjnD5GVEYuQfyglN2yv+EBe23khP
H6jlcUu73X+FVWS0CsSBkQNAHEcuTTuf/Hinge4lK4KPk4CZL1qQNNJ+nGNR7F4p
8IDpVrtd6N/V7w49GC77/0RseWUxQiTHlBLfjFSozw1IPrcXNFc=
=tXXw
-----END PGP SIGNATURE-----

--rRSFQ5n7OdqjkQvG--

