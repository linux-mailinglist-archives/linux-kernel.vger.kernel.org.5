Return-Path: <linux-kernel+bounces-12052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E5C81EF76
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894EC1C21363
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8E545033;
	Wed, 27 Dec 2023 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="raWG1YZq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1FB45019
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dbdabb23e91so2373635276.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703687759; x=1704292559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3sUzh8dLo2xVJa594mpdwakY1EN41ZeqN8hITPjA6vk=;
        b=raWG1YZqIaIFbRr9pcQd3SEcYI7NXn8SYR7b0PX6TnD4i2dR2pf2TJbbMP8AGIqPY1
         06dVAzyFUa3Xsqw4gHojPze1npTEqEosOuDgeHBP+7WnyiIqGA/hzPFtbSZ9q70OJd5T
         rBTbDTVWeikenlXkzDbNE2Xc1rOzTxOB/cer56yzgdaoWx/+HKIiQ0YOOLrQxpeQcwOI
         n6jwg/3tTbu+9V/v3wIDfBKrPQ5VCDM+dKBimcJer2OwBmn58pViz0teP90mqVEn4Ozb
         6Yp/W/LqzqjKXAnvlNMkVaY3zmzkZEdvawWDOXr/DrqdMyp2bcVEkaP6R2ibSN2Tw5sS
         3mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703687759; x=1704292559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sUzh8dLo2xVJa594mpdwakY1EN41ZeqN8hITPjA6vk=;
        b=JrjsmlyYJQ2629PA1L/NAyDkY1yz8yEhcxtjuO9xckdd9ibJ8pUdpHjvTa+typ4uDT
         73u/tARjhGZ0CINfnl0ZhRYcHrT3rB8DRBr2oGEx34H0+FKX+HVJ+lHSEOhlsjBXPsgw
         4exPmc43e3Z4bCjp7kqcDIfpPdTeshpAFJ3nmgWVNr5Y2mcGuSYlhuLHJbClZeqNrfzL
         xyqYTkBnL17kUXLRZlNXYrFGzCt2XzdBVv443xKCxInHo5xeI/E7scpiv/rhZN+7NZsV
         XvSRCKHaaXT//6U8wfBSuOe0uibMHLmHjfqajpGeazheP1miOqxAUOyaFGFgMRXhJAes
         eWaQ==
X-Gm-Message-State: AOJu0YwHYjnOa0dMo3gOdF5P/zEOu+y55eCCkFoy8cqefJKnV2X/3wcJ
	yrk5ld/F0Gsh1850iqaR885dFRZb3P+nUw==
X-Google-Smtp-Source: AGHT+IFgMw36vaiIp9m15OxquHQUYTG4hNW25gHKfws/L1G7S6nm2rl47TLk6Vj/ES/wdialH0Qz9A==
X-Received: by 2002:a25:e092:0:b0:dbc:b5cf:d600 with SMTP id x140-20020a25e092000000b00dbcb5cfd600mr2800421ybg.19.1703687757310;
        Wed, 27 Dec 2023 06:35:57 -0800 (PST)
Received: from ubuntu-server-vm-macos (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id t8-20020a25f608000000b00dbd4743a4d8sm5351768ybd.44.2023.12.27.06.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 06:35:56 -0800 (PST)
Date: Wed, 27 Dec 2023 14:35:54 +0000
From: William Breathitt Gray <william.gray@linaro.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] counter: linux/counter.h: fix Excess kernel-doc
 description warning
Message-ID: <ZYw2SkkEzSW2C2gN@ubuntu-server-vm-macos>
References: <20231223050511.13849-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OBG9AcguILqipDt3"
Content-Disposition: inline
In-Reply-To: <20231223050511.13849-1-rdunlap@infradead.org>


--OBG9AcguILqipDt3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 09:05:11PM -0800, Randy Dunlap wrote:
> Remove the @priv: line to prevent the kernel-doc warning:
>=20
> include/linux/counter.h:400: warning: Excess struct member 'priv' descrip=
tion in 'counter_device'
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: William Breathitt Gray <william.gray@linaro.org>
> Cc: linux-iio@vger.kernel.org
> ---
>  include/linux/counter.h |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff -- a/include/linux/counter.h b/include/linux/counter.h
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -359,7 +359,6 @@ struct counter_ops {
>   * @num_counts:		number of Counts specified in @counts
>   * @ext:		optional array of Counter device extensions
>   * @num_ext:		number of Counter device extensions specified in @ext
> - * @priv:		optional private data supplied by driver
>   * @dev:		internal device structure
>   * @chrdev:		internal character device structure
>   * @events_list:	list of current watching Counter events

Hi Randy,

Would you provide a Fixes tag for the commit that removed the 'priv'
member so we can track when this warning appeared? You can respond with
it to this thread and I'll add it in when I merge your patch.

Thanks,

William Breathitt Gray

--OBG9AcguILqipDt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZYw2SgAKCRC1SFbKvhIj
K9tdAQC6IeH/7KLxgyGIA0/sH0woEVafZwDafkceRO3lbo6YSgEA1FIu5ocZl33X
V64BqE9NSmm6eor9qJjfIMUr0/RaPgM=
=V+0S
-----END PGP SIGNATURE-----

--OBG9AcguILqipDt3--

