Return-Path: <linux-kernel+bounces-164932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4F58B8526
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE3A1F22CB3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4542D3F8F1;
	Wed,  1 May 2024 04:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvP64AOU"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E13BBCC;
	Wed,  1 May 2024 04:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714539528; cv=none; b=WwK+JD4alIJrmdOs8E656LSOMpbpfx4mYvL3oOvvqGsJ/+wcvuZ7HQQhc1RVZ4L6UQjE29uyN6RpegioH1/mvUZtQ/ax65Us9o4TP90hh91+fZQo3TvSbGZ21sJUA3N2eBT5nRGjJjARQcezmyIAb5KiGbeVu6GhwErQywISdaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714539528; c=relaxed/simple;
	bh=z8BfY5vw4WwDVxzv6VR+IM7TSGzYBOvn+OEqviyCF6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiJ25ARAScxHWbG/y4B3MFFyvAIhfBFIVm70xsP9cTO5Ob+zXmwDe5HnxRThRlDAMQknUtz2j7AEVIoCU/y5LLkpTMebPxI6Rhu1sxDGPruQGyyRi2AiHPT0E8CHfbFcdgC0EPVjBIsvVvIUYsgUoGfR81EvFPvlioS+lFZ8hAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvP64AOU; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2b2b42b5126so971504a91.3;
        Tue, 30 Apr 2024 21:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714539527; x=1715144327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8BfY5vw4WwDVxzv6VR+IM7TSGzYBOvn+OEqviyCF6s=;
        b=LvP64AOUILpdpWFDpFwrZSThZ0RdjDltHfGe95oe2iEhRwYlcJ0XY6+rF2+dB1f+CP
         buUOf56mY6mXJkue1PKVg9PTZ4l7L5Lt8MUqDdptvq9zIUshlRy8Onw9Zy3AgpBMl4In
         0hntF3A2bDYtx+EW50OSedZ0r2qH62aw3YGHaoOqicHqZlZAu6o2EbDxAoYAl24QBXjD
         q8Jw1b0O+lMkCimbgL6bwieV0P75uK96KfzbueVSXBydsFTubuYr+SmVI47QpL/+vL07
         c0tD2GwtyleoS+eiAH2m/UEnyYMxJ4PzYzHyIajnxEjupe6Jjcv5GC/0aoQadZ9i9APw
         cVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714539527; x=1715144327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8BfY5vw4WwDVxzv6VR+IM7TSGzYBOvn+OEqviyCF6s=;
        b=sAXfVE1V50OTUhB3suaE9VpHmZFKW1OcSbFdwJDpnHzA8kLrbPeMb5FG4G4QvXu7tt
         QiEIkisq8kwhAn5UJvl1e0nGhhc2TNdule2mKutcIPW7yymZbO5Mvzij2SqbGyYMJ6Gh
         uqNVVhMypGqfOj4X6l6V9h912sSTScI31NfpC+KvjiHJPQJITsJZ1Nc72zaT93aZRqPL
         trt1ztqSVconDrLhcXHMHRkI/JpwxnVChyFzAgAqnatxyDR0lBt+U5eb3fzX5sVNcnUj
         W/fuaScELt+cWfgRdZPU3b0Nbv2X54rS2eCHKrGmLidkSMK0GYMvrtuEbmQ23Yomu03O
         ewmA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ3nNBzejMggel5OO8a28RXJAyiMEKi+NyTg6V4XFs8xVitCbEZVF4AEJvJ2OTCHMG3Vi7yE8dGwd4KW5JU4aomXf9k6Sr3jNOdyT1NHfDSuA5cj1P3dboaJM2jeQS9n+Aq/VpxTWIvPfIrTttbBQp+UB+rVgWXVMp3u9WigAJtjqACov2cQ==
X-Gm-Message-State: AOJu0YzG9igwjfvH7FYLOYBL+PhcZ251uslBbOl+xoEqeXwaTDPvClrK
	hV6DZNPBgBgYHgDRDtHV2i5SLDp0/SXHSdzPXJRCUSqakwJVRLnndfN94D/hHcTEpvNYoEn0hgz
	toU07p4VfK6TLKk0L26yXCY2AH4c=
X-Google-Smtp-Source: AGHT+IEzz4gLZ9uCpo0NMxIIZ4FsCp6By0fYcSUllRCSYrZJdTP4Ev2JoEzHX1qEt3Bhc9zH3PaGbs16BcdNaklqdr0=
X-Received: by 2002:a17:90b:1192:b0:2b2:56f:52ec with SMTP id
 gk18-20020a17090b119200b002b2056f52ecmr1460870pjb.35.1714539526539; Tue, 30
 Apr 2024 21:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE8VWi+UwYWw+RBMPi5ozg+sQHKtyxp2i2K3u9e3b42Gt8D+qw@mail.gmail.com>
 <2024050119-pediatric-prankish-64b9@gregkh>
In-Reply-To: <2024050119-pediatric-prankish-64b9@gregkh>
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Wed, 1 May 2024 10:28:35 +0530
Message-ID: <CAE8VWiKqrPge_OaeCXXAER6ofFLULLPrPK8StCMV9DPM+WHuHw@mail.gmail.com>
Subject: Re: [PATCH][next] tty: sunsu: Simplify device_node cleanup by using __free
To: Greg KH <gregkh@linuxfoundation.org>
Cc: davem@davemloft.net, jirislaby@kernel.org, linux-serial@vger.kernel.org, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Julia Lawall <julia.lawall@inria.fr>, 
	Shuah Khan <skhan@linuxfoundation.org>, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I don't see anything here, sorry.
I'm sorry but is this patch not visible?
https://lore.kernel.org/all/20240425060303.8045-2-shresthprasad7@gmail.com/

> Also, how was this tested?
I tested it using a qemu x86_64 virtual machine

Regards,
Shresth

On Wed, May 1, 2024 at 10:21=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, May 01, 2024 at 10:01:00AM +0530, Shresth Prasad wrote:
> > Hi,
> >
> > Could I please get some feedback for this patch?
>
> I don't see anything here, sorry.
>
> Also, how was this tested?

