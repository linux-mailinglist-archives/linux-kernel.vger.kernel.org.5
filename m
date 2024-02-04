Return-Path: <linux-kernel+bounces-51864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28274849034
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F7C1C2127A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFA02555D;
	Sun,  4 Feb 2024 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuAUdfeg"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BBC2C691;
	Sun,  4 Feb 2024 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707076605; cv=none; b=lurX59EL7QVQandVJFuPLuzGWjJYKvqLFyqld4omokSaZsnYdY9dcI2GEH7n6kQLEBs4F0T850BLYrgJQXxsIsn54osq7FywZjxJbZHQepJ6FcIntCl+jtIptvQxGo7KFJJpD0deD2JGQOIrPhqZ2MPDO7DrFRPefEU50CJELMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707076605; c=relaxed/simple;
	bh=/+l6/765kG6B9Mu7MXZkESLzo4g1kehbY5deEfe7GWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0jgdJq3I8ywrwiZSncREhwP6z5K/c8cNGfrwiNk7ajv0oCeopCJTvUvQw38cHTOZjV3vogSZRGO19136czflEdeZEU+wLKeNOsSfZWz2PMReBlVQVaBokh20bX4VajCk3cU0ekNxoJ5HmXWpNGwnrBJfO04RcTFb139HbvVLnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuAUdfeg; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a28a6cef709so512062966b.1;
        Sun, 04 Feb 2024 11:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707076602; x=1707681402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+l6/765kG6B9Mu7MXZkESLzo4g1kehbY5deEfe7GWU=;
        b=XuAUdfegGDY+fTgeDSNcgwULAwLNJZalko3Id8eTf5FI4LMEEsHL3ahSMfGvEZ/rI2
         GMBLuip6QpxN0NZgemC8YJjlI0fQsN+HfqEUEw3A0cubwzVht3Tzpuc/17EBvpmboCEp
         blDOwGY+rfnopIbTYsb342EFvFQSwYVgkqywgS7Y+cnzRK11oGWQzdX+d7rS4xjtifHJ
         z7NZ67RoMX50l9ghSlegSsByQh5vQLCIIjeuWSKzT6LQp/KTCKjHhMehyQFmkKlqpo3U
         JI1UoZ2/9NXoxH5ijNJAvCzgOJocdYXoBYFJOtkEK35emgIABHFMp8rvTTkxiUBFzN2V
         MWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707076602; x=1707681402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+l6/765kG6B9Mu7MXZkESLzo4g1kehbY5deEfe7GWU=;
        b=Gg/NFnZwJZk9h2ZDMi+Io9dn41KbeDD9FDBcs9hPO/goDuLnjstcladr8Oq2YEHu1Y
         7CwYHdnJD6AIBdbjunO4h7NaK65Dt83QGyCmN/XapEPpQCyab3XC3m9f+bp88vY2iGyT
         hq1IUzF4sULohCSQ/MnVKzEpPxw1lck0Cr3gwg55jjcIudiqxt9sPtXf2wQ6SeI5o6dP
         55iOZZzgBcGI74krHqqhOtxHwHAfCwZVUOuFQ+FIy8SyQZ8lA6Xh2J7FwARMp45JCW/B
         UdUHkEjtUhj4jE4xzhEQj/KovfYqSgFBmY6oj/Kp199ygdR62U47sAgqHs8WoIBgBt9w
         nc8A==
X-Gm-Message-State: AOJu0YxbDFSGIcv85GyXlUEA0YkmtvPykJEwoluiE/boh7e8B3RxHcmp
	cUrfoeMnEwqMdki99up1SS+Vygj1kTNHWy3/3pIZ4Zlp4Ok/PUyuJRvU8mDpXiCwbfxFVHCRx4+
	/VDuNdCnBkGXKGe4+TDhWG3CM73k=
X-Google-Smtp-Source: AGHT+IES+gSHX3AF2YZCrPXjHBltxja/FIKX5n43RAM4+3Ig5PsU9BFiCcwUWbYwuzb/5JZ6udD3PHRKgZICBIO3oZg=
X-Received: by 2002:a17:906:cc0e:b0:a37:4bce:ca00 with SMTP id
 ml14-20020a170906cc0e00b00a374bceca00mr3048088ejb.59.1707076601871; Sun, 04
 Feb 2024 11:56:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204162106.1179621-1-andy.shevchenko@gmail.com> <20240204182601.kg2hwc7heo4l42si@skbuf>
In-Reply-To: <20240204182601.kg2hwc7heo4l42si@skbuf>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 4 Feb 2024 21:56:05 +0200
Message-ID: <CAHp75VfYRGQ0bZQ3mYXq5PH1YonXyuz3xR0vcPZyonTAd8SXMA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] spi: fsl-dspi: Unify error messaging in dspi_request_dma()
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Minjie Du <duminjie@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 8:26=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com> =
wrote:
>
> On Sun, Feb 04, 2024 at 06:21:06PM +0200, andy.shevchenko@gmail.com wrote=
:
> > Use `ret =3D dev_err_probe(...);` pattern for all messages in dspi_requ=
est_dma()
> > for the sake of uniforming them. While at it, fix indentation issue rep=
orted
> > by Vladimir Oltean.
>
> "making them uniform" sounds better than "uniforming them".

Sure, thanks for the suggestion.

--=20
With Best Regards,
Andy Shevchenko

