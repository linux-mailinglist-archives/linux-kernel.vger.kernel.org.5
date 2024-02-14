Return-Path: <linux-kernel+bounces-64984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BF9854631
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795F91C210B3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FE913AD8;
	Wed, 14 Feb 2024 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="k9eS6af2"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB16BE5B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903351; cv=none; b=gbcxH2ZU5SEMzQgJp4zE/HXbB4FWXgxtpHhtvTs2YzH53Bo8CK9OQKHy0I0NGZelCqqD8+O50U0fxVzJxDcK+1xCCRxUUGuTusZ69VSBAkyJuNoxRdgXM3/K3WYRthw01/5RbL5F5fjhCFRGDXyFGFxUv9F4/f3y7bv0Vs3Zry8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903351; c=relaxed/simple;
	bh=FxGJAH83UTrQJFawuwOkZhQNDaql6s20rG59BXEIoT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNh+BBf3PypHo+6hf4XA5deCUi7qaxRl5DcgqCZv1QN9ahltNYtD4IBt2pFyPd2+sxx3+i2kuKfehgOlGxedUp3fdGOxyAYlE3Qgjwcq2cxAYl9yNksgprJjF+b9wZW6TzfLPHlUt2SgiOxwGyJnK5fNn6LfVpWv1BSYREHeCMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=k9eS6af2; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d5bddb0f4cso591319241.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707903349; x=1708508149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxGJAH83UTrQJFawuwOkZhQNDaql6s20rG59BXEIoT0=;
        b=k9eS6af2Le1UDrnWN4cY+JAmQ33DtPRzd55GR+pIeNMrDCv8z7vHyfwaqnTqbIc0Xf
         wO6pDEbGuortCX1plRHEb/tnavCZlIa2wCtfa1zkS731DYHWpSnC/fkcQbsq3vrQoWYI
         zCnh16Nsf7idk0olqb1AVOJ9iTv0imxvD3+no9uByAT7aYqdkMlvfaaCOvOuVLJhSc4x
         YTqhJ0jCz24Ry5SBC0N/LPxtgx4ZrSv/WrSmu48up0CO34tsqavzN7YQPQrbQmlP3If+
         j4QynBK4lm2GY0qXYou6WH/VW0qkUoep9rZXQMOgcQ2jFGz7BkXIiayiTj16wqAnfOyW
         +nsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707903349; x=1708508149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxGJAH83UTrQJFawuwOkZhQNDaql6s20rG59BXEIoT0=;
        b=wK8asQrd9AO5rc9xqzQDEPWaKV5kBU/4rihdLsz0XWc8G5DCAUJvtBwQmcE7lomn3R
         p/dQ2kOa/ipVGLE8up4RN733KNwWpwsWRWsGDbqt1AiZBJOEqUp8vND25cVq1WWdQ9Q8
         Le0evxB98qGsv9XR7GJTFo1llZOwn67D0lqHIvqC617eUggEZO7psSGrWaAKD7OnjI5K
         QkEpA8hcGaV1IK9OmDD4gMA1B0dUnewpgnNuODZxy0TKPsqv91c7Z6K36ZprRGkYQpzM
         oyT2sYckqY3C+Mid06yIikW8puLdY5ePqlMg2mbfScH+vldSoDmkQRn0qIkVRX1yP4bW
         Hjxg==
X-Gm-Message-State: AOJu0Yyi2LxyTHdeisRXiRZs6Rtqva2nuJi3iIaR67ViAuUprmWgiHCm
	85IDbKAiwlQgAdYQ0UKwzUNdL4lQhesEXQIii/OxhZVpz2OCeiqcV6J/ZLtrknfKmkHztJvKXOr
	r3jnI7PfJHk7lnqxEp80iHcHlAO//OMWovxMpCQAWOteqpZNoCec=
X-Google-Smtp-Source: AGHT+IEOxg1ObHX8j5ADuwz4SaSKeY0U/wXSXneGYVCIWIk2eqRKhLL0UkhWDS2Bv0MsNKDNNk02uHpLn4FhpW05EPE=
X-Received: by 2002:a05:6102:2746:b0:46e:d0cd:428d with SMTP id
 p6-20020a056102274600b0046ed0cd428dmr1931571vsu.33.1707903349246; Wed, 14 Feb
 2024 01:35:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213141222.382457-1-warthog618@gmail.com>
In-Reply-To: <20240213141222.382457-1-warthog618@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 14 Feb 2024 10:35:38 +0100
Message-ID: <CAMRc=MdmfHLyy0UrfC21UMxFa8CTySOx8LCEg0Nt+Z9tb8mRSQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: gpio: consistent use of logical line value terminology
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linus.walleij@linaro.org, andy@kernel.org, 
	corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:12=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> Consistently use active/inactive to describe logical line values, rather
> than high/low, which is used for physical values, or asserted/de-asserted
> which is awkward.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---

Applied, thanks!

Bart

