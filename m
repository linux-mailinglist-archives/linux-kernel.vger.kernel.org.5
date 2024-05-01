Return-Path: <linux-kernel+bounces-165154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE2E8B88C1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329F6286471
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2564155E6A;
	Wed,  1 May 2024 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKL3uBgL"
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86584F881;
	Wed,  1 May 2024 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714560466; cv=none; b=KoKQW7TC3dOmo7NEgmEPBJpm5BakNKp0aC40M0pXRm0oLc4u4nqEMZIMuw60nwmohy0X5GA/t3z/NpncMJ9Iq+yTkUD3ibSg2ec3Rb7rG0TRQrPu75wWr0t82ywJzF+R5qB4AiHvN3IF4JM/51qbilYhu6/4WnMA8UKGf8qZJTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714560466; c=relaxed/simple;
	bh=qF2S9kRF2bnK8+Mn2EI6KFSaM3JZbWrGmzDAE/FLGmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGc5lVbMRvVPMyRD2jJxh86wlNfioMNIORWvclIynxtaEOoHhl7Dzx5C3O/wV0NfU1RHVIPwFG1ETBovAB7gcJUPjH/jwNkBQ9e3TkNPaWfDcxDPfYg1pe9JryxP9WkqE5r7AYt319EBMXp8lXfPSBVvA4GuV1kSPexHbEJfE4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKL3uBgL; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-41b79450f78so38331125e9.2;
        Wed, 01 May 2024 03:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714560463; x=1715165263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qF2S9kRF2bnK8+Mn2EI6KFSaM3JZbWrGmzDAE/FLGmk=;
        b=HKL3uBgLQhN48CHA7waTLLK9wKjgLp67pOsJ24wK2AqnB27Blmy87OX1Qg+HFyAyTG
         B7BLmOX5BggIGKgVGaJE1gH5pb6zcYF0J6K4IM/mbw62PhlXV6aG2EKZ+87xUSfHr9mS
         2LNUJQv/wKPYitpsPptDN64Ok8vxjQXfE9dcKW2K+0SmbotxEbsugr0iFuVf/yrhlO8r
         ON+ahD7yfwRlvSKnC5QZyjz/jiKR9rYf/9RzazU94WvbJKp/2sBQDEBY/3fBp7c4Ypag
         8wYBp2J/S38tJvoyNgY17iE/pyM6domKV72gwZcHHTJG58zh76tM8Gpjm5Yp9JDoZa/R
         AVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714560463; x=1715165263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qF2S9kRF2bnK8+Mn2EI6KFSaM3JZbWrGmzDAE/FLGmk=;
        b=lzMlYFLK8NNNGKzzMJWqR0Xyy3POcjMliYB8d5pIyQ00MD4zocW7ymaOrW6nwCdQky
         +GCS9EP4XC1ovYD42clGbYUzw4ddwovpQfSJjpYUB7Z14U/TWEk88BbBriqIDCW/XRb5
         Md2S9P6ng0xd9rCYdM7mvho30oO+h8GLv4PdXWk9Z3emhE4zEgj2LpOldCS8K1Ur8Hlc
         V5JQezD4hnurHXDg+IYXf1/61OaP9d89kfgKB8/g8cgWjbRONRlQtajegf+SEQd6aTQY
         sYIiG68OpuaBof2VB4rMPyv/mM6x89Krpa5fxH+i9U2NOy+ZMyov8fuN46lubVh5IV+4
         R6Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVqTc5ssMLMMz394ur+12Zo8VjyxBVrO/eTxF0oybAbM8EBB7FG0KT+fCCjNZfg/HQjHtU0OsF5nqjbrjpJRpnUmT6Hts/wVoi99qSGdU/sFCBIUb2Q/AkcmWlLcUw9J3YX78I9j/CC0n0ZrQZ2rGV3r2HhX2MnsazuYOwp3rDfhSK5fw==
X-Gm-Message-State: AOJu0YwL3XhiDT+cYyp+GpbCc24VzunFg1zWqIih58QhwNmT0KKBN2Up
	/W33Eqou7yVDuj/lqLUbjpep0DBT9G2+cH9D/8cnsKQBwRn4B7zsQQ/kj6eX9Gkp0kuwrjQLhVu
	n3SxFI4dbfrhdD7EHO7gSQQGb/Q/uyyQKzMs=
X-Google-Smtp-Source: AGHT+IGYu7yaltNnrcGlBtdeLcVRMiJYJjlHzWktXSWPpKkB1YOx5qr9AwD+FU57kLNbdTvclS0w1nvMncugKBostG8=
X-Received: by 2002:a5d:4246:0:b0:34d:b265:6401 with SMTP id
 s6-20020a5d4246000000b0034db2656401mr2361598wrr.46.1714560463010; Wed, 01 May
 2024 03:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADFWO8EZWkXeAMcURgGGEmzVjiSxFTVAbKpsb2Qmv66EZiTc+A@mail.gmail.com>
 <ZjEQKqkWA66HtiD4@smile.fi.intel.com> <20240430-booth-spinster-bf59f780f10a@spud>
In-Reply-To: <20240430-booth-spinster-bf59f780f10a@spud>
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Wed, 1 May 2024 12:47:32 +0200
Message-ID: <CADFWO8FzQ8FgD5a2jKECaMRX65_1Nd6vsgh43bXqsSz52xtZKw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add support for Sensirion SDP500
To: Conor Dooley <conor@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-iio@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Angel Iglesias <ang.iglesiasg@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 6:46=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, Apr 30, 2024 at 06:37:14PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 30, 2024 at 05:27:17PM +0200, Petar Stoykov wrote:
> > > From c4437fd0ea296c4c964b1fb924144ae24a2ce443 Mon Sep 17 00:00:00 200=
1
> > > From: Petar Stoykov <pd.pstoykov@gmail.com>
> > > Date: Mon, 29 Apr 2024 16:41:30 +0200
> > > Subject: [PATCH 0/3] Add support for Sensirion SDP500
> > >
> > > This patch series
> >
> > It's not. I mean from the email chaining perspective. Have you forgotte=
n
> > to add --thread to git format-patch?
> >
> > Also, what is that in above?
>
> Looks more like patches pasted into gmail or w/e, rather than sent with
> git send-email.

For stupid reasons I can't use git send-email. I thought I will manage with
using gmail alone. The thing at the start is a mess-up of copy paste indeed=
.

