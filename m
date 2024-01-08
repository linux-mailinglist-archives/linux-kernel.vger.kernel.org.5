Return-Path: <linux-kernel+bounces-19849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AACC827548
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE56281D57
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22737537ED;
	Mon,  8 Jan 2024 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eOjjuiHR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F0353E0E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-467d58e133eso254529137.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 08:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704731653; x=1705336453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fHFnMSPKJS+MsU+LmkMOjkcyVfbo7MPduwk+npNeGQg=;
        b=eOjjuiHR4RAxlZWUFhDO2agMP+cBs5IcxRQj9DRZxtVv8NEoKd4Q8DdqvH2LReFPEN
         sITL13XTX3UijkyQVvdcCiVG/zrBEUmyD+VmD9yX4tocpWyxR1oFpJQN7FjI8UYe2h7C
         xoIeE3pLdRJQ+DOLkqVpiDqIhrGU1vMik2K/dTMJeSEaof9QuVrekGNXap3I9w0UdSCX
         6R8maq1AF8AD8IvtolC8zDEdjhUBcvMlqbgYoQkL4cqAYCV+ACqZ2ky86E0OWxKdBb0q
         5rA1HLCK52nxRf2ca3yfJMBMImhtnkJP3rZ9DQ27ARjh8upu3iUqKW77GlqETO9L2oLS
         QljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704731653; x=1705336453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHFnMSPKJS+MsU+LmkMOjkcyVfbo7MPduwk+npNeGQg=;
        b=mD6TYl5jJbPb6ecannAkVrqGnRm9ukWlri4TTUhKgFEz/uBdZLjWqCvN+1Mw6CpVKF
         T7MethENzgXSWmgXSd3roXkyMCBdTCwCC+aav3smQqoE46tacCTogUcHt/FHUYV0hhjd
         gopZJaqBkgYLkYSzXekM7p4qUyj5QMrbx8zCSYysV9IHk3nOekw6gZC7po5lnQVHEfI9
         vkZzQY/4emsI4fPXBSOle5D7taf2KnoAo0Z2LvOg1693tau9+5KP7RRFKzIR6WNG0+01
         eOUZJrIeXatrNGKJfs5v4nMhu3Qw/d8En8uUrYtLzWPQEyP33sV+qTuMeIGgoQf+7kki
         Qy7w==
X-Gm-Message-State: AOJu0YxpP0z5l1pYhAPnGaD1OSiTmcSCwllrQqcxj+LCGGWC5CZ0MljM
	JKfFf+tBtwCTKQcidn6d9rf1mLNughUxmQ==
X-Google-Smtp-Source: AGHT+IGJc4KJIdikcnB6yTrThRooVa+lQXzg0GhWaOLz2a4/SoKrdlHZ09f6kAqhm9yd20QGRd/2Rw==
X-Received: by 2002:a05:6102:32c4:b0:466:a788:3b3d with SMTP id o4-20020a05610232c400b00466a7883b3dmr2320170vss.5.1704731652489;
        Mon, 08 Jan 2024 08:34:12 -0800 (PST)
Received: from ubuntu-server-vm-macos (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id ia8-20020a0561024b0800b00467c8a9ed3fsm24646vsb.15.2024.01.08.08.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 08:34:11 -0800 (PST)
Date: Mon, 8 Jan 2024 16:34:09 +0000
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/10] counter: stm32-timer-cnt: rename counter
Message-ID: <ZZwkAR/DD2yElYQk@ubuntu-server-vm-macos>
References: <20231220145726.640627-1-fabrice.gasnier@foss.st.com>
 <20231220145726.640627-3-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r0P87XSHUG2RZJfY"
Content-Disposition: inline
In-Reply-To: <20231220145726.640627-3-fabrice.gasnier@foss.st.com>


--r0P87XSHUG2RZJfY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 03:57:18PM +0100, Fabrice Gasnier wrote:
> The STM32 timer may count on various sources or channels. The counter
> isn't specifically counting on channe1 1. So rename it to avoid a
> confusion.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Reviewed-by: William Breathitt Gray <william.gray@linaro.org>

--r0P87XSHUG2RZJfY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZZwkAQAKCRC1SFbKvhIj
KwTdAQDOmsC43umCubyDQb5Ham5tg3Vf+30AuOL1mI8YBRV0/gEAvHWZZ5yKsL0W
4K7YQWzO4KZhEeu7cam2sUxteRvhTAs=
=wZZQ
-----END PGP SIGNATURE-----

--r0P87XSHUG2RZJfY--

