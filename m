Return-Path: <linux-kernel+bounces-94493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CFF8740A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FAC5B22B6F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB7B14036B;
	Wed,  6 Mar 2024 19:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jwvw0I7g"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A881350DB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754055; cv=none; b=taRrAmM0xu2uLZXtIlNYI6PJo0HFBTzStoHKhNSnoWMmSQANJ6BX+B5ephOxnHbnOA+KCrGBFMO1IWIzROtPD2f/h+pIl7o3gP5TBYo8TTJXL+WnDxnibhPmvtaT0o2kSAoyUhTJbjFvvGG2RSH/PyWvxDylK/bkutwYqm1w3/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754055; c=relaxed/simple;
	bh=lLww44fHzXJw1Kt8CwXW/KAA0YiI8Bp1KLHYfbruk68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqLFANWkSqsNCSy7RTVP8nwluEgk6909QkGOzr+d13hmVUDxvLz/PX5M6ofk7WCVqjzTa4OCnu0kxE4ENAVqfgiK17xeMHQRxZMnsW9v8H1WMRaODOZKYwyCxJ9ggZPTc4Wt+3PW4WG9TzNJeFznSTr8CYNJYkwxXORH5FiaTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jwvw0I7g; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4d34dadcb23so1451978e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 11:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709754053; x=1710358853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lLww44fHzXJw1Kt8CwXW/KAA0YiI8Bp1KLHYfbruk68=;
        b=Jwvw0I7gSP93wzf+T4MT9BPf28KCNJ7qAl/e+moPGm6O9snpKmydgN4aBOX8YuXYue
         wcqNF+TZ836yPmDGvASCv5SoG9SkIO/3qieXiojIkxpfEoGfW7h5HI9W8+ODADrjN8jq
         jpXkn8jfRz1Ap+bhgRVO4cqaTggnn6QUtdJsc+8YAss2KFE+qxDEJayEIoFPCxzM8fLC
         vGBYUS4lFYBIVXLA2m/M/2NbIbgYF33fVMGG8xN7M+DpdUjw+qhEug4wcGhoJAvMhH9Y
         MTjqQPNh0XDUg41NG8fLZIOMxDQbF1FmKsYEL7ojvcOoKQ/zwsJMbVOPPFmUF3HVeVTQ
         FVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709754053; x=1710358853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLww44fHzXJw1Kt8CwXW/KAA0YiI8Bp1KLHYfbruk68=;
        b=n0yyBKCeZGqVTkzmbOH0jw8ePXWe8QkosHX/DqbJK8RMH25v5rCRi/8q3t5qkOVVMy
         YVSOCGEOVLq7ha78F3/iZN40MBPZFPSfIjZn6HpUSwBPyA2CvMtwRGJTccU0I9q/1i27
         DQMpDP5ygOtf3mlnPg3nnZ5yJIaXc2XJgJiyo/REa//AgfcShSt3HZRcEa5x4UhnA4ER
         MGqdZ/Ur+MaiBUPaU+BafDXsMj/jufeEtkPjqum6IrsERteInZF8wI6ioye1d9pKg+SN
         mYSsxGB2Tk+3jXkCtFeh0meoGBr3uNnsU28DaLjKII3oiS1lu8jC05UBGAABTQGXllFy
         M/qA==
X-Forwarded-Encrypted: i=1; AJvYcCUdGJfF0hKqsEVbxeTtPlu+duFc26nyXuczjn2ouZU+XleWedzSQcbQvRTkfVj3UhsnQXpRm3pkyoi1ZZ8ziY5YCjFf3hv3xPKhbqFh
X-Gm-Message-State: AOJu0YyyH12JcJkgzam6ImZjA54w2P7T28OH6IVpVplhgV47Wk+wJa0P
	5bMSbtlVFfrF8/S4nPcgIZ7TFZtSIQhrhIsORVxDy6f8KlhpfYt4TuLEu/sMtYg=
X-Google-Smtp-Source: AGHT+IFX+X96b30F665Z3v9XkkXlmdpro8bRgsJ4O1L64Bn+CTNhw2E2bPqB2AjrkrHwsVj2Sgb92Q==
X-Received: by 2002:a05:6122:49a:b0:4c8:e834:6ce2 with SMTP id o26-20020a056122049a00b004c8e8346ce2mr5202856vkn.5.1709754053042;
        Wed, 06 Mar 2024 11:40:53 -0800 (PST)
Received: from ishi ([185.243.57.249])
        by smtp.gmail.com with ESMTPSA id n21-20020ac5cd55000000b004c0460eeea3sm1641635vkm.43.2024.03.06.11.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 11:40:52 -0800 (PST)
Date: Wed, 6 Mar 2024 14:40:50 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/11] counter: stm32-timer-cnt: add support for
 overflow events
Message-ID: <ZejGwl9cjNmnIEz9@ishi>
References: <20240227173803.53906-1-fabrice.gasnier@foss.st.com>
 <20240227173803.53906-11-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AHJchM3hVcrGYiEl"
Content-Disposition: inline
In-Reply-To: <20240227173803.53906-11-fabrice.gasnier@foss.st.com>


--AHJchM3hVcrGYiEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 06:38:02PM +0100, Fabrice Gasnier wrote:
> Add support overflow events. Also add the related validation and
> configuration routine. Register and enable interrupts to push events.
> STM32 Timers can have either 1 global interrupt, or 4 dedicated interrupt
> lines. Request only the necessary interrupt, e.g. either global interrupt
> that can report all event types, or update interrupt only for overflow
> event.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Reviewed-by: William Breathitt Gray <william.gray@linaro.org>

--AHJchM3hVcrGYiEl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZejGwgAKCRC1SFbKvhIj
K8/NAQDCuf6KLzSMo+Kw/cpwoHQZKeN+w6n9G+6YESGIsrFwJwEA0oJlwcWAw71G
bVtRni++MRNTj1R0wO9V3GCUC9ShYQw=
=UU4f
-----END PGP SIGNATURE-----

--AHJchM3hVcrGYiEl--

