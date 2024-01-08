Return-Path: <linux-kernel+bounces-19863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E618275B0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4802028408E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C3454BD6;
	Mon,  8 Jan 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oXN78cDh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9C354BD5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-467a18fc0fcso255764137.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 08:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704732400; x=1705337200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v86cSdeLVN4Eor53KHOEZU66rYPCIfEGIjL+hEGlyNA=;
        b=oXN78cDhjWFi1yzkX9VsJPJGNH0wQmSE0IVXkSPYDplZbzwTrLXXXiCOd5Hu0a8wyL
         iXM7lFI8AsD3Vn5Ya6uMsbZ77uxgSnjtEj/+NbsZ4s8aXAOVsxBtY/pBbDYXTNUs7lgz
         497JCLauoUdSTiE9FVzTortuHd3bnXcCyV7ChSJOie9wZfaP0AgXUxEVZnxJaVqQchDx
         UYhn/HJSU2mtqOMlxtlzCB1IEe2zgbriKbto1X+UYPxk5IN/6a2f3mqzR2pZAZpw50N0
         56b+PP28NladRUOZhAShkgTGC2KAANs1ApwQZqMQjcqmqoICmrLYy/Csd8T/AEc4k2Xd
         3AsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704732400; x=1705337200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v86cSdeLVN4Eor53KHOEZU66rYPCIfEGIjL+hEGlyNA=;
        b=nFANj8hP5U+0xbN8MGcVVWCIMOxkwESwQeRsWQsWJBj9eZ4ccV27dJHRv+5uV4Ugt9
         fC+G3sdDZeB475qhTusrnkm1gXT9xcNuEXpahfxAofWlFWKfDkVXn4RK34kpoZuhdcyU
         kXGVYphH/d1QB1JOVStVUP/DDLc6b9Qzvw70x4bD1izAg5J97JSLs/djzX0EV4T/2JNY
         uWfzZcoVaBj/i+6Uc3uAoWbRRKyzMPRg0+/qUv3lBok/L9vNsd25BHpQiO+smOCGEiKQ
         +ByOUJ6w4k2BuwvdEq4xWFwSA1UmYPVBULeeZmSZz0g+swBsEwpWavbzOOwCBCRCAvh+
         DjXg==
X-Gm-Message-State: AOJu0YxpZKguBGvYUO+r4krPmScoCVUlWFENfQQX96fcUfkpJxwiG1uN
	4bkqBgw10ETljQAilygWMVJl4d9EPxrY9w==
X-Google-Smtp-Source: AGHT+IFDHtN0shChS/FabzBprTpMRYYx1/bf2NeDqz0LAzczeUWPYsOkVksyLMdiy/L1EaVaq6GIxA==
X-Received: by 2002:a67:e687:0:b0:467:a189:2f51 with SMTP id hv7-20020a67e687000000b00467a1892f51mr1623827vsb.66.1704732399907;
        Mon, 08 Jan 2024 08:46:39 -0800 (PST)
Received: from ubuntu-server-vm-macos (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id hx6-20020a67e786000000b00467be2e0fa1sm26884vsb.25.2024.01.08.08.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 08:46:39 -0800 (PST)
Date: Mon, 8 Jan 2024 16:46:37 +0000
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/10] counter: stm32-timer-cnt: introduce clock signal
Message-ID: <ZZwm7ZyrL7vFn0Xd@ubuntu-server-vm-macos>
References: <20231220145726.640627-1-fabrice.gasnier@foss.st.com>
 <20231220145726.640627-5-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FfZYnz6NI7seIHjE"
Content-Disposition: inline
In-Reply-To: <20231220145726.640627-5-fabrice.gasnier@foss.st.com>


--FfZYnz6NI7seIHjE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 03:57:20PM +0100, Fabrice Gasnier wrote:
> Introduce the internal clock signal, used to count when in simple rising
> function. Also add the "frequency" extension to the clock signal.
>=20
> With this patch, signal action reports a consistent state when "increase"
> function is used, and the counting frequency:
>     $ echo increase > function
>     $ grep -H "" signal*_action
>     signal0_action:none
>     signal1_action:none
>     signal2_action:rising edge
>     $ echo 1 > enable
>     $ cat count
>     25425
>     $ cat count
>     44439
>     $ cat ../signal2/frequency
>     208877930
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Reviewed-by: William Breathitt Gray <william.gray@linaro.org>

The code is all right, but some minor suggestions below.

> +static struct counter_comp stm32_count_clock_ext[] =3D {
> +	COUNTER_COMP_SIGNAL_U64("frequency", stm32_count_clk_get_freq, NULL),

It might be worth introducing a new COUNTER_COMP_FREQUENCY() macro now
that we have a second driver with the 'frequency' extension
(ti-ecap-capture also has 'frequency'). But it's up to you if you want
to add a precursor patch to this series, or I'll introduce it separately
myself in a independent patch.

> @@ -287,7 +321,13 @@ static struct counter_signal stm32_signals[] =3D {
>  	{
>  		.id =3D STM32_CH2_SIG,
>  		.name =3D "Channel 2"
> -	}
> +	},
> +	{
> +		.id =3D STM32_CLOCK_SIG,
> +		.name =3D "Clock Signal",

The word "Signal" feels unnecessary to me when both the sysfs path and
data structure will have 'signal' already. Do you think "Clock" by
itself is clear enough?

William Breathitt Gray

--FfZYnz6NI7seIHjE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZZwm7QAKCRC1SFbKvhIj
K9HkAP9p5tjj9d7bEok5P8rHe8XAO3QFNKaXaaEcdc+BJgMHqAEA2FngXSvqxRzd
DSkZbpLR+ErJlXMCYj6LMcwcTUqC2Qk=
=D0v2
-----END PGP SIGNATURE-----

--FfZYnz6NI7seIHjE--

