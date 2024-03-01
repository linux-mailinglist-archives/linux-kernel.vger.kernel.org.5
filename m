Return-Path: <linux-kernel+bounces-88649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFB986E4CF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2AC1C22A07
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3816970CBC;
	Fri,  1 Mar 2024 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xkXU8XM2"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E5171B45
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308548; cv=none; b=Vm25XBJjQ+sPdkm+737sVtJ+yqGjOU+K4Ym9BNwvdwzoMdHNRBCXDDtkorsRTIK7b6BhrCSLSwjz1QPCnkFhncC/oFPuH1B1+C3scPLnWmqpoe3WK4La5q1L+ew+QNSdmagnvqFCHdNKtmV7aG1NLO4UHG+fTnJTaVcA8NKWxjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308548; c=relaxed/simple;
	bh=xU2424lQTKxKZg6MHne9qfkBy5cOcIamXDnnHV78UpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbgf+CbP1m2k1EZllRgjfPMOMr+dqknavpSMpWUO8PyzUAd63bMm5oivAwwnMOunmW4C1bEwQmzapixB5/YWGAD7JJ4MLj4SIxjEOLHbQ/bJQ+AmTgFEWXByY6nfRXMgj2PFEQ27lAWiYY3T0seeM5pOFhzS8JwEEMpbhG3VTXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xkXU8XM2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412b83cfac4so16166305e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 07:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709308545; x=1709913345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dEf+rbXNQvLvB9iPkH1P+r9uBHTvmiiyJwMOWWoELNo=;
        b=xkXU8XM2AlxDhUXHrsOonXihIuEhwmsT5WezvjUChW+s1A+sL8Zhn1MO1KqJLS5NJD
         u4sZ40IaW4+wPfwvPk2hccRo+oYy7OYkTUBPVbikI3qOLGrvOiksdKhrWNuEjcsnVN1P
         7HvJNGsoMvpHcedZ0GIS8JLUKxdSBYiHbZqOEznrlRtAeTUN0VscVdDVWs9ApTjA9ayr
         MOSHXS1f93Hfp9sG7FRy1ADa0/K01/GwhEuVtq/ylytNzCDjC9LIDZotA8DLIPqBQlwW
         JUGtRW1rSafFww+/qVZC6wJAv8GY0Mbp5xczCdcH/qcAbDTTTkUjDl4OXerzes1zqQnW
         Noqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709308545; x=1709913345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEf+rbXNQvLvB9iPkH1P+r9uBHTvmiiyJwMOWWoELNo=;
        b=s/T+wMtI8Pa+rdZpjg7r8cHnWRbvIqUGNwGd0DGxeLq+rh224gZvoAu2BQbSqVb/Dl
         0JelQ9jNvsZWZ95O5qlsbu6FL63Q4APuMcFWvfJW1DPH3lChwRfCEDGRjRPPCcv561EI
         iqXXtUvx86ImJtQSISL2yXlRvM+2/1AFhk1JOk7KGkb0Qf3lnDnoHnTfKJzinTvkrIk7
         qmWmSklsbrgYqW/jT+a71j7nLnEZeQ6llgYhKL21t7tSdhMm449prRXKyhFvC68dT42V
         sI1sUayKJHSJ/OoXsQ1SW/U42fwqYVWG71IT8hETS6a0pUshyV7AnUhtmVDMPrTpgzya
         OD6A==
X-Forwarded-Encrypted: i=1; AJvYcCVE1TCAfQF37XukpbUcuc6CH2Idhng9HJJaMnCzfWQNbBi4NIZ+OkIPQQI78qIXZuo8/qJiTxHWAQunEYVWi1gnpMqMw/rMsthL/SNJ
X-Gm-Message-State: AOJu0Ywr8kAS26ZBzYKPOOR5OgkBvt5f4mwgakMmAjWGHJ65Gmi40Gbg
	Sfarj7UAIBluwMlfWdcBQpY+E2FoTprELQjd4FsEPZyIZ2XDXKJkfHX11wWfOFmt51kooAbEQg2
	F
X-Google-Smtp-Source: AGHT+IHXfsf1QVNUUheaEgcb1fKDrYSnpwanX1F3NHauzqf3xzyG0GvJEj7Pf7CKoluJk/kSHAeU6Q==
X-Received: by 2002:a05:600c:1986:b0:412:8fe7:4e06 with SMTP id t6-20020a05600c198600b004128fe74e06mr1813507wmq.38.1709308545005;
        Fri, 01 Mar 2024 07:55:45 -0800 (PST)
Received: from ishi ([185.243.57.254])
        by smtp.gmail.com with ESMTPSA id u21-20020a7bc055000000b004129a1097e7sm8774972wmc.12.2024.03.01.07.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:55:44 -0800 (PST)
Date: Fri, 1 Mar 2024 10:55:39 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: syednwaris@gmail.com, vigneshr@ti.com, jpanis@baylibre.com,
	alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] counter: Introduce the COUNTER_COMP_FREQUENCY() macro
Message-ID: <ZeH6e02zzfAjw-sd@ishi>
References: <20240301102505.591918-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NVfMO94wBSa46KPR"
Content-Disposition: inline
In-Reply-To: <20240301102505.591918-1-fabrice.gasnier@foss.st.com>


--NVfMO94wBSa46KPR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 11:25:05AM +0100, Fabrice Gasnier wrote:
> Now that there are two users for the "frequency" extension, introduce a
> new COUNTER_COMP_FREQUENCY() macro.
> This extension is intended to be a read-only signal attribute.
>=20
> Suggested-by: William Breathitt Gray <william.gray@linaro.org>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Changes in v5
> - "frequency" extension is read-only, so there's no need to provide
>   a write parameter.
> - patch sent separately from "counter: Add stm32 timer events support" [1]
> [1] https://lore.kernel.org/lkml/20240227173803.53906-2-fabrice.gasnier@f=
oss.st.com/
> ---
>  include/linux/counter.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index 702e9108bbb4..0ac36f815b7d 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -602,6 +602,13 @@ struct counter_array {
>  #define COUNTER_COMP_FLOOR(_read, _write) \
>  	COUNTER_COMP_COUNT_U64("floor", _read, _write)
> =20
> +#define COUNTER_COMP_FREQUENCY(_read) \
> +{ \
> +	.type =3D COUNTER_COMP_U64, \
> +	.name =3D "frequency", \
> +	.signal_u64_read =3D (_read), \
> +}
> +
>  #define COUNTER_COMP_POLARITY(_read, _write, _available) \
>  { \
>  	.type =3D COUNTER_COMP_SIGNAL_POLARITY, \
> --=20
> 2.25.1

Hi Fabrice,

Setting the structure members directly works, but why not use
COUNTER_COMP_SIGNAL_U64("frequency", _read, NULL) instead to keep the
code more succinct?

William Breathitt Gray

--NVfMO94wBSa46KPR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZeH6ewAKCRC1SFbKvhIj
K217AP9hJmpnlwQnUsdqaZn6twmR5QyJBT3lfeSMtz4eusnWowEA7uP/8rZ0WZLf
TDqIuD3w+89Mcs0vrikcijgkauAOigs=
=Zn8v
-----END PGP SIGNATURE-----

--NVfMO94wBSa46KPR--

