Return-Path: <linux-kernel+bounces-19851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0899C82754F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8814B22E2A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822215380F;
	Mon,  8 Jan 2024 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSDcafJg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E340F42AB2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-46788b25f95so253414137.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 08:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704731697; x=1705336497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aaeb09tWE1K+nwOrTBr/Ka6fbm31sgc04gxFPmYXCe4=;
        b=dSDcafJgdh6UvHr8xZ/7oaLibyPvUBDAsV4FJRLYtaWkabgBNhU2CL1mDzdbz5fcRM
         qTXC36McWHrFo3yKwl0Cd5ElStW4bY3pozacHH30Em0PwHjMghonkWn73D+JIGiSYFYh
         oooL3++lTkfY07HRFv+Sbe4TOyFsumDg7xQLGDD4aqQyEREjJabkAFxEKRv4CU42PbuU
         F9EeSR+l1D4aSq8PtRjC2/ebUHlb35evngb5+GEqflWIYYOEhK2ZX3KgnojPZngNXK8M
         YWvgiROyVEzuIbHrY+34eYq+vvgH8hHjXiaQ18AYaWGd7qRLtSWLbEmRo3HW61q9WAgg
         OHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704731697; x=1705336497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aaeb09tWE1K+nwOrTBr/Ka6fbm31sgc04gxFPmYXCe4=;
        b=DonQ4legsl+6B7U0m6+9ukNtDALGIic+0+kDRyF9maujEmWMj8d8ZJDd3tKf4f8AbX
         +MUBYBgiHn5t63trRVh35vCMWrOsL7auQutYRS/CQC59HBfIxQ8umbjY+d5TEWCEzL7h
         5DsD71yceH1Smw1Ds/6ggp3p+kxPWhT+ufqwAUACGNrx1SfyMg9+OKeDLF5dxnYiq02m
         wDYdef43PiHyKILvkWsy3T0inu7+QSZFOKnEkj1kcZwKsRsdxgpnewR8i6VbxFZkSP6u
         Ypl1d8WdcZlTufP3uWahhSJrlBhaI46t9hKdf/KH+QfNHlvlavPqxfnmtERRO4qWoJKl
         PfVA==
X-Gm-Message-State: AOJu0YxZfLuIIoczB494UhqPXEQJBdX7DFz+2MklVcER5Q4YRUKShF8V
	oEYU5iH9MLiG8b+w++dVGb+GSbUz+Pn3eQ==
X-Google-Smtp-Source: AGHT+IGQ0arLRW2+JcH6xmHwAlc+Cv6QrAiA3W02JuecyXKxM31mvSYE9QkoJVTjcNvoa88gdfyFQg==
X-Received: by 2002:a05:6102:4b87:b0:467:1786:6144 with SMTP id ic7-20020a0561024b8700b0046717866144mr2027372vsb.30.1704731696796;
        Mon, 08 Jan 2024 08:34:56 -0800 (PST)
Received: from ubuntu-server-vm-macos (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id i18-20020ab03752000000b007cd2ad6e1e0sm14811uat.38.2024.01.08.08.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 08:34:56 -0800 (PST)
Date: Mon, 8 Jan 2024 16:34:54 +0000
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] counter: stm32-timer-cnt: adopt signal
 definitions
Message-ID: <ZZwkLhQZsL9RPuWt@ubuntu-server-vm-macos>
References: <20231220145726.640627-1-fabrice.gasnier@foss.st.com>
 <20231220145726.640627-4-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2A3cd3ictZgfwlWr"
Content-Disposition: inline
In-Reply-To: <20231220145726.640627-4-fabrice.gasnier@foss.st.com>


--2A3cd3ictZgfwlWr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 03:57:19PM +0100, Fabrice Gasnier wrote:
> Adopt signals definitions to ease later signals additions.
> There are no intended functional changes here.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Reviewed-by: William Breathitt Gray <william.gray@linaro.org>

--2A3cd3ictZgfwlWr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZZwkLgAKCRC1SFbKvhIj
K/5VAP9dNxQRO/rMnLCWzROjUOk/Yef+aY3rTJDWSCLMEphZ+gD/b4LhAHIbnPCY
PxZZZd7COd6FDzoCqPsZKQ4NM47JYw8=
=hX0c
-----END PGP SIGNATURE-----

--2A3cd3ictZgfwlWr--

