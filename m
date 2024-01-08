Return-Path: <linux-kernel+bounces-19864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 742558275B7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214FF283EDC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3450A53E31;
	Mon,  8 Jan 2024 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyDu/ekc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E6E53E2A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4b756f2aebeso358553e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 08:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704732494; x=1705337294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TxF270K+sexJ/eLc9N8yPVgplaxBJJ/k6+fU5vbUs84=;
        b=QyDu/ekcK/axVJCqLjqw63WIZZ4gM0BEMtiGUbtXseoHDE8e/7fWzPZ+wf29vfZiEF
         iFU9m3mGFwJtbMgcZs8LH4tXiPIedj02k8cpkKDSliIxKcH5fn7WeXL9ozdpPMbhHJeO
         OuI9osekGpKdA5M8hwW8Kjo9bjMC3/iGqr/2qKlZJClC/0ONeAIF34bYCICPa2I6JCiq
         cAlnPbGN5DeyS7DIpXvwLBI2LMmFt6pmePw8zg/hod4eCMGpNGAFO3gyNRTxVjvob98B
         K/h8YZF6OQiBgqFmSmr/aC56P9/lM3vWV5+Q0JB76k1GLg2P8gpQJxScif/e0WzeCfdJ
         Hn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704732494; x=1705337294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxF270K+sexJ/eLc9N8yPVgplaxBJJ/k6+fU5vbUs84=;
        b=KYOrDRpnfWBXB16ba/2arFi6JQsnxRbaYTdiycWUNCJNbdjOpVQEG1UlZKIpKlOKrV
         moAqJ2XjD3vD/AJrsoubiPQdjx8AHXmaa3Nv0wyrYXvhPn5mJkLD0sjHsb0k7HUVMnhi
         aSfkFujHK1vVR1k46UkDrC4AFiVE/aga+QRXly9hnNU1PB39p7rWbXfGFQ6DesaOcKnS
         fDZH2X+ZsEv2doZvWjFzmMez9LcE3enGVN1m47RgFtx6MubUOZnJdW09lACm6X4aqDoV
         sSA49ZWp3rS8/9yN0Jo3+4YBYV9g+klBRPUsZ30Oynk9Wt/nl4NjW2zuRD/gQDJ2Ne5a
         s+SQ==
X-Gm-Message-State: AOJu0Yx1me+0fmPGV2MWpc1VFxMGkpUkIRIJu8izIypletH3oXmwh25l
	ylKgUqfGHBBXdMvX94O41KBULwEsyYBANw==
X-Google-Smtp-Source: AGHT+IFnw3iDIzHmdSbsEwn7wuu3C3WEjdB3EjbZeioFoqdMp0jSYH5m3FcMGDqp4NpvTo1r11M+/A==
X-Received: by 2002:ac5:cbc9:0:b0:4b7:209d:4b2e with SMTP id h9-20020ac5cbc9000000b004b7209d4b2emr1311471vkn.22.1704732493947;
        Mon, 08 Jan 2024 08:48:13 -0800 (PST)
Received: from ubuntu-server-vm-macos (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id k11-20020a056122210b00b004b723e0ea8fsm27109vkd.9.2024.01.08.08.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 08:48:13 -0800 (PST)
Date: Mon, 8 Jan 2024 16:48:11 +0000
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/10] counter: stm32-timer-cnt: add counter prescaler
 extension
Message-ID: <ZZwnSwh2oFby+0p0@ubuntu-server-vm-macos>
References: <20231220145726.640627-1-fabrice.gasnier@foss.st.com>
 <20231220145726.640627-6-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4h1HqCgsu7cQ8iVi"
Content-Disposition: inline
In-Reply-To: <20231220145726.640627-6-fabrice.gasnier@foss.st.com>


--4h1HqCgsu7cQ8iVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 03:57:21PM +0100, Fabrice Gasnier wrote:
> There's a prescaler in between the selected input signal used for
> counting (CK_PSC), and the counter input (CK_CNT).
> So add the "prescaler" extension to the counter.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Changes in v3:
> - New patch split from "counter: stm32-timer-cnt: introduce clock signal"

Reviewed-by: William Breathitt Gray <william.gray@linaro.org>

--4h1HqCgsu7cQ8iVi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZZwnSwAKCRC1SFbKvhIj
K9RaAP9IqRLPnpdLYchE7O5E/UqKIxSSeo6jMBIU80OM+m3J/AD9Gok/LU2WQLEP
+9wSu6cs8f5l8Q6eWhM+ZMzI5V42bQQ=
=OgJB
-----END PGP SIGNATURE-----

--4h1HqCgsu7cQ8iVi--

