Return-Path: <linux-kernel+bounces-87322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C8F86D2B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585F21C22011
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132D0134436;
	Thu, 29 Feb 2024 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="goCQmnLZ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426E37828A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709233099; cv=none; b=VqatAVH+txlz3YO47JzmLWsC6k2dmLZ6145YWG6G7bjskr3N0b+xZYQ0LtNeZF3y7BUTWCu2LP0xIEKbDINCbw//u6Nr4HfjvHvF9muM7rZ3kJOIey3kUC+6tzVH1GkZ8/IjzCEPjmweEOTuP7MA5JzWI43lx7wM6nezRTH6OcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709233099; c=relaxed/simple;
	bh=qS96ijGQ0VA9eqcSA1aKuuwW+o+9E9lQmPLX2nzFYgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jh/JoMfVoN7ZB6FnLCGJXaWkGinRuqg4mw7Y76IHoGrvu8tM2cx/E3VzAIJ6kAgA8Ps7ffF4kzLuzJrL6txx3z7F0qOTLJlF4HZB65pVqojm45X9jMBxpNi7BvxwZ0y1EPHDvCInMBZ3BDGChEYM/SuVGnkKgEVTq5UUDnOToiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=goCQmnLZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412c286be35so3942105e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709233094; x=1709837894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QOMkV8+zwYA3EDl4Oj8veMVbhFWWtMnCBkuFp1N+OIc=;
        b=goCQmnLZC19UjZUzaztMnc8jAHvVxejo6gaBAgbQyHaOCNU7OwRBUyKDMGECpjq8Uq
         FbEI916TxXfRHu+zu65EfcNctTFzOEvLe4D1QXNtfoaFD7irqkvGQQrkVCTY5iwDT52C
         vKhjmhzVMnMfqoOSmcO6YUqmHqpZJdV8CZc9B4u8d9UxmordwLQFU52ZZBSAC8mcREfD
         RsUWA+/ACI3PBDqXUJ3PIAjWnn/vvzIeZOTj6r3viPkhbqfCBdpKzCNHyG2DEs4+30t3
         xOkjR/rOLlwChYdbwn8ijwR2VaEn6oD9GXslLMN6etGqPWtB5udvdd12z2dHpcq2+ZKW
         jqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709233094; x=1709837894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOMkV8+zwYA3EDl4Oj8veMVbhFWWtMnCBkuFp1N+OIc=;
        b=XqqB+x/ziZ/ZD+J6LjgxrBlCRPiImh1fEy12r4XjawzZAV1UIErksEbgF5fE6mfbqq
         mEvtgVat9YTmyOvLS+ujFo25oBQ9KB2jCL/QCaICnU0wtQBwwiV6RgzMZVO8nBnP3ZXR
         2VpbDH4sEK6vpscncC53tnidxk+Ci1rsTkFq8KhShXV73zSbZEy0/hra7DG9qfg3PK0T
         yuxe7Fo4+Ztjd3Opr+4dY5BgdywgpboZlKPw+tSpdl8GUnsOIeBFbJD9WTkxhyLj6TgN
         n5/bHpdXJbJ7j0Q5WQ6elMABg6LhDhoneP2/5B44++6NbROEyTxBc83WBfSEIszsfdjG
         53CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLtoHoRicogf0bohJrSwOghv6WEqgaMr3D0xHVpgnZnH1ERdR/eKnpTmJlkO9BwnFMkqAyb7qFMFztp3weCX4BDrgZdUMrOsgD+NyW
X-Gm-Message-State: AOJu0YxJkakD2mCLDLeIqtyPevt39mqJ+bv8N6m/keagqKzki1b4M4Ds
	wBcqKKfEozkEvbNJ9QjARgM1bS/Tiu8D3OryNdnacJishk6BiHlYLES0Ag/WvIM=
X-Google-Smtp-Source: AGHT+IE6N6/fBwdedrFzOy5DgpuEwQoJ27wC7Wfz2Gw6PuOexlU0y1KaywrIq7wNyzeVlhR8897a1g==
X-Received: by 2002:a05:600c:1d24:b0:412:b74a:452a with SMTP id l36-20020a05600c1d2400b00412b74a452amr2732349wms.29.1709233094459;
        Thu, 29 Feb 2024 10:58:14 -0800 (PST)
Received: from ishi ([185.243.57.250])
        by smtp.gmail.com with ESMTPSA id fc18-20020a05600c525200b00412aeb77bbcsm2863560wmb.19.2024.02.29.10.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:58:14 -0800 (PST)
Date: Thu, 29 Feb 2024 13:58:08 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Julien Panis <jpanis@baylibre.com>,
	Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH v3 04/10] counter: stm32-timer-cnt: introduce clock signal
Message-ID: <ZeDTwKMP7MX0Nlx5@ishi>
References: <20231220145726.640627-1-fabrice.gasnier@foss.st.com>
 <20231220145726.640627-5-fabrice.gasnier@foss.st.com>
 <ZZwm7ZyrL7vFn0Xd@ubuntu-server-vm-macos>
 <599a7357-b4d6-4581-9d5c-c1d0ade3e410@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="el6dlSHLw0+sJrWy"
Content-Disposition: inline
In-Reply-To: <599a7357-b4d6-4581-9d5c-c1d0ade3e410@foss.st.com>


--el6dlSHLw0+sJrWy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 06:43:20PM +0100, Fabrice Gasnier wrote:
> On 1/8/24 17:46, William Breathitt Gray wrote:
> > On Wed, Dec 20, 2023 at 03:57:20PM +0100, Fabrice Gasnier wrote:
> >> Introduce the internal clock signal, used to count when in simple risi=
ng
> >> function. Also add the "frequency" extension to the clock signal.
> >>
> >> With this patch, signal action reports a consistent state when "increa=
se"
> >> function is used, and the counting frequency:
> >>     $ echo increase > function
> >>     $ grep -H "" signal*_action
> >>     signal0_action:none
> >>     signal1_action:none
> >>     signal2_action:rising edge
> >>     $ echo 1 > enable
> >>     $ cat count
> >>     25425
> >>     $ cat count
> >>     44439
> >>     $ cat ../signal2/frequency
> >>     208877930
> >>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> >=20
> > Reviewed-by: William Breathitt Gray <william.gray@linaro.org>
> >=20
> > The code is all right, but some minor suggestions below.
> >=20
> >> +static struct counter_comp stm32_count_clock_ext[] =3D {
> >> +	COUNTER_COMP_SIGNAL_U64("frequency", stm32_count_clk_get_freq, NULL),
> >=20
> > It might be worth introducing a new COUNTER_COMP_FREQUENCY() macro now
> > that we have a second driver with the 'frequency' extension
> > (ti-ecap-capture also has 'frequency'). But it's up to you if you want
> > to add a precursor patch to this series, or I'll introduce it separately
> > myself in a independent patch.
>=20
> Thanks for suggesting.
>=20
> I added a precursor patch to this series.
> I guess you wishes to see it used in both ti-ecap-capture and
> stm32-timer-cnt. I only cared about stm32-timer-cnt in this series.
>=20
> Can I let you do ti-ecap-capture change if/when you're going to apply it?

Thanks Fabrice, I'll pick up the precursor patch so we an start using it
in other drivers. Syed will take on the ti-ecap-capture change, and I've
CC'd Vignesh and Julien to this email as well so they are aware of the
incoming patch.

William Breathitt Gray

--el6dlSHLw0+sJrWy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZeDTwAAKCRC1SFbKvhIj
K3yKAP9au8psfZPV7oz/mKiqINUHWTZ0uA0altrVA9qTHRrJWQEA6q36cJEVxyKY
FxE179tE7UvScdEB6mKG/o/bFy2hVQk=
=nCx4
-----END PGP SIGNATURE-----

--el6dlSHLw0+sJrWy--

