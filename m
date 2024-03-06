Return-Path: <linux-kernel+bounces-93940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CC487373E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A2E1C2189A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1191F130AD6;
	Wed,  6 Mar 2024 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7rLAIdH"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD2E126F1C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730241; cv=none; b=g5XP0qu86+STxXmNlKWay9GP1JCGE44h9KPOycmluvUEr0DAcUE2wDOcc0T6i6KkGNrMJKtS53XU2iqwU0cgBCjfjxOjK2JUUhP1GPXS33BS2XLj+5w+WirULmXCiFLazOpKqPl7mvwqb5cQxeIIGpUxU8eEClQuHID0h415jvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730241; c=relaxed/simple;
	bh=0SzVCSc+6IVgdLQjBVikpTpZ5IdNQX3I6EMVPlgDMbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psE/oHcL6iGjfoY/mfNZPFi+Hrfx1/y2ufb5K2J4PhD/boLc3t6SLjhO1ju6Q6F3LtcLPKWA1CXCLMKnz6+zoP/Bq2dS2BMsESjX223/IWF5uicI9Mtw4ZfS4y3KYAdKhWLARzkQfMpwVkdwbxC359mouphjUzhKVXYgYpUEtV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D7rLAIdH; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-608c40666e0so65209797b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 05:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709730239; x=1710335039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBiDejV3EtOMJmuMxDeh773rkjpBFgTE/mtHVi8J4f4=;
        b=D7rLAIdH2G5/jUCqjM1rkWiWQLQ/DgFRDS9MXjPcuiXudanm5mQJErhiDT5dmExSbV
         YujPOOJFWTrri1ZrgDugdTp6kok3Jc7fGS5TcSmbmxxfu+c1TlZS/0fbmjTGG0/NF4uE
         PGLF47GjeV8T6C8YUAwrigc6HoRj4s+Ow31mBHqkPse3AL603YBp9PsJbNZ7fpiWAZSS
         HZ9kiUiEEZhbWoxZI48MgycEXqAItAvM4T4sh/9sccibVTRGhcqVCEqhcaCVXylpHQVr
         R7/4OheYnaRSRi10ygpsaWTl4xwYL8x3FJKYpw1X5bTl4CyE2tQIhszFnZsGzNtByWZv
         dCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709730239; x=1710335039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBiDejV3EtOMJmuMxDeh773rkjpBFgTE/mtHVi8J4f4=;
        b=YrG7lPMW53FykXqcREpN3Ulmub4nkSjyL+8+ik+q2t58cxHS1Fj1vlSjY0XVatr5N1
         z44DzUEzUGPXhJWvTAHFkv6zK7KWTLR4WfufY6U+viD3GBD7C+C0oJVxpHI5aDyBlNsm
         N2xtutOEwBAF6/sQNhFQqgWq8seTNhQeLhuhwFJdXt8qIDuKJYO8+mzTYLnSffBOJ69w
         eGnoQRdCLgROADitPArPO5sai1h2CQR2xMB2SbrrnvS+TKvGZ52pdNUGswGNimhVWzQm
         jwMDLrtjkHuyRmfIrlzIFXzezRkaH25NHX+2zIbB1QwwuIHdZTeqjefRdiNQVfqXnCSn
         8Xag==
X-Forwarded-Encrypted: i=1; AJvYcCV/TzuLgZzqjD+Zp/+PrNKgAzt3JWwvYojFdB+MZ0fd6+ANmFSgMjasjQcnP0qm6LlhTCH3IMSX8ZcLrFR2D50XgObsIPyD3IYj2wU2
X-Gm-Message-State: AOJu0YyKpB46XZAIG9JidvM0ijEu7ld3/BmcsEUEJTnz42i0I9Po8r2x
	D6ife9yhVjZKOQZrA9YVXoUV1uxMSznLH8KP2tdeW3vvDLTT3FEQjZk8nT6aymGoRrBH5nBZd1T
	6SOnYi6dlkg7YckNJQWlSfXkCddozy7wAvpugSg==
X-Google-Smtp-Source: AGHT+IGoznzaO9Xw4qNyGRElOSvHFz7f8QVovTmZFfDUeysoa5V9mZ6cAUmshhXwf2lLcYtw5uLKyTLOhjYMd2NX47k=
X-Received: by 2002:a25:290:0:b0:dcc:2da:e44e with SMTP id 138-20020a250290000000b00dcc02dae44emr10903650ybc.61.1709730238839;
 Wed, 06 Mar 2024 05:03:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org> <Zegx5PCtg6hs8zyp@trax>
In-Reply-To: <Zegx5PCtg6hs8zyp@trax>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Mar 2024 14:03:47 +0100
Message-ID: <CACRpkdYS-5mDjNP2zJ2J=_k_uboyVGK61Z1XWHcUh26HT6WKmQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: part_switch: fixes switch on gp3 partition
To: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc: Dominique Martinet <asmadeus@codewreck.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 10:05=E2=80=AFAM Jorge Ramirez-Ortiz, Foundries
<jorge@foundries.io> wrote:

> That looked strange as there should be support for 4 GP but this code
> kind of convinced me of the opposite.
>
>         if (idata->rpmb) {
>                 /* Support multiple RPMB partitions */
>                 target_part =3D idata->rpmb->part_index;
>                 target_part |=3D EXT_CSD_PART_CONFIG_ACC_RPMB;
>         }
>
> So if we apply the fix that you propose, how are multiple RPMB
> partitions (ie, 4) going to be identified as RPMB? Unless there can't be
> more than 3?

Sorry for writing bad code comments.

This comment means:

"support multiple RPMB partitions [on the same Linux system]"

not:

"support multiple RPMB partitions [on the same eMMC device]"

Yours,
Linus Walleij

