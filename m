Return-Path: <linux-kernel+bounces-94490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B8387409A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B011C21568
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591B7140397;
	Wed,  6 Mar 2024 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OHKWpNi2"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EE6140360
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709753997; cv=none; b=kO8N+NDO0c/4it7gr2hSSGwEcKfUgSiprZQDwNjFXkgQ9Q6OOA0xi1enrtZhsikf5xYwYOBPn6YuU4HnfAbnnyRx8B9ihvdk1g1eukiljkVxDxp2ZvYIwxJbiGMa9ClTkVgpU0M+8oGFQI+KTYRj0jK7+FpEQplHjtoK5vAJohM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709753997; c=relaxed/simple;
	bh=cUaL5wX9lCcHMpyt8Zu+oEHigjdI4PKIxNn0fnhJ8Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACOhOFPizp1CB60oMKz/lasVOXxeEE9licKK+jWjdfQTb5xM7eaLVIOJPFCoh0rRU9szcfmU99pwDQrZvYYaEFJpVOMHnmlRt9r5y5Y5fBJMC2fvRLE1RT+MbpB7yPaTNzHYKQPpBDl2qK5jtSmZ1OcOvLFHTCmZFTT5TSqLnLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OHKWpNi2; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4d34fbbd91eso1665655e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 11:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709753995; x=1710358795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cUaL5wX9lCcHMpyt8Zu+oEHigjdI4PKIxNn0fnhJ8Po=;
        b=OHKWpNi2LpJcpoVAnzcsAGJsZLKBdruIypwDl+3w0Hl+sKCR+rHsiYpjfhh/OJGLQG
         21V7p3ZahnIUgPedOyTbDL5qiVvrK1BIyjC5Ial20ljxrcnwNzFRydT90HmUtND4jjzD
         KSpXGVWdhEXg4Ycgd/xAu3w/SmpFugEYe+HAR5gvYmGeNyREk5uUk4ZmB/XCiLFRz257
         pV9gF4Io4JoEhcpFQw0KkM2rqKdEYmAKx6reXqSTb+aUuZSXY08+ymWf94TmNnpPO3wK
         eK1FCkmByHSRQx6FHnSvudeesNPxda2imk0igMxL4MArCuU3wG1knJXO0FNYlJsS3zxB
         Yq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709753995; x=1710358795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUaL5wX9lCcHMpyt8Zu+oEHigjdI4PKIxNn0fnhJ8Po=;
        b=DXaKMCuuYylSNOXNPiNo2ilZZDUGN5+whdWAAWbttShzkIm98bF1RfAGsYtFQugQ6B
         WaYG974DE1A0ZptBn1GN9sD4TLRPlpS0Ih+qNKhzLhjqEBJYHHoFH+uA+Mn18I+Fbm+P
         m6DQ5TXZGTnYJqJaAM6j5Csl3nSLVeixb9HcgrR9CVoo3BfI55iynNm3QoKbdQsm6vcV
         DfSpuw15l9Jb4WDWrNqWQwI6ZuY5/B1wll382bAPKU7WKd4f+7MTeiabg9M7VDXAwkm+
         YmqNYFNKMqz2OfsTEfQlv5nFkd9ekAOo+UWNId8E8pRdeJDAJ6HcwvkMBDTNil/2KLLJ
         FoAA==
X-Forwarded-Encrypted: i=1; AJvYcCWhWusRxQ4LDmOHsVOQ5Ypt0UGgd6xrkuzSHFBz3euC9MO51O80PsFwShWpEE17Tdb7xUKh+yvFq0LA64Ji0st+k4tk424/XQDhwl0C
X-Gm-Message-State: AOJu0Yw04ok2F+YO4BTTa/9QLUff1eW/J6DslZLG6zNSmI6nhyv/dp7P
	mY4c2IMyikcECdG3/qmEgyPGmxBL7ogVTlmHDaTTZGigbVX78+oWMJw+6GqOpKw=
X-Google-Smtp-Source: AGHT+IGXg5I00ytK4b1k0hPS2EZIeSRWy/K14ck3db1WCJDBJQ/eqPd+cm7XflCOTeslEXOmUhInbA==
X-Received: by 2002:a05:6122:30ab:b0:4c7:5fee:f525 with SMTP id cd43-20020a05612230ab00b004c75feef525mr6341546vkb.13.1709753994992;
        Wed, 06 Mar 2024 11:39:54 -0800 (PST)
Received: from ishi ([185.243.57.249])
        by smtp.gmail.com with ESMTPSA id d20-20020a056122033400b004d347f2551asm1500370vko.40.2024.03.06.11.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 11:39:54 -0800 (PST)
Date: Wed, 6 Mar 2024 14:39:52 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/11] counter: stm32-timer-cnt: add checks on
 quadrature encoder capability
Message-ID: <ZejGiKovtkCrydzp@ishi>
References: <20240227173803.53906-1-fabrice.gasnier@foss.st.com>
 <20240227173803.53906-8-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O7snGDCakkkZmDqH"
Content-Disposition: inline
In-Reply-To: <20240227173803.53906-8-fabrice.gasnier@foss.st.com>


--O7snGDCakkkZmDqH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 06:37:59PM +0100, Fabrice Gasnier wrote:
> This is a precursor patch to support capture channels on all possible
> channels and stm32 timer types. Original driver was intended to be used
> only as quadrature encoder and simple counter on internal clock.
>=20
> So, add a check on encoder capability, so the driver may be probed for
> timer instances without encoder feature. This way, all timers may be used
> as simple counter on internal clock, starting from here.
>=20
> Encoder capability is retrieved by using the timer index (originally in
> stm32-timer-trigger driver and dt-bindings). The need to keep backward
> compatibility with existing device tree lead to parse aside trigger node.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Reviewed-by: William Breathitt Gray <william.gray@linaro.org>

--O7snGDCakkkZmDqH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZejGiAAKCRC1SFbKvhIj
K5KbAP9fffVz3i5+FStoFd1EjIyVXWU6OcHNjQXPePsUhuk1WQEAoZG/LUlGu/3W
4MPtiZAoi8G7OzYxEFU0+n2pwYQl1As=
=Pqa6
-----END PGP SIGNATURE-----

--O7snGDCakkkZmDqH--

