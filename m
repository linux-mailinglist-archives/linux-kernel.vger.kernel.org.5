Return-Path: <linux-kernel+bounces-67473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D7D856C29
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DEF028EFF3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9591E1384B7;
	Thu, 15 Feb 2024 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jX4ysiod"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414291384B3;
	Thu, 15 Feb 2024 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020590; cv=none; b=BaaAuKQNE9ktd2QPpJXzbEQff6iShFrCZA2xFm9A7ZVA71P5xkV/eVkS8n9W/PWAiyjQ/QMgvMSYNNcStPWf2O9w08XQn5/3gvBFOh8MqfMnjcDQli67Zk7LBlpFvFONO/jpymAulngTi39bkoyL7vQYscDJoeDxbFbiyKaky/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020590; c=relaxed/simple;
	bh=DUAAEWcfCMwa7677MxMyGU88cfm9xN0qS3zlnmexBHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itcG9RwbFC0ZfpiUb5qsza27aYP/EeTE7dH+EABZh2Jvu6zvesAEXcDj5kOCWpRIHIpQpXqvE9XLa5eui5uiiRgIkw1vl1Mfb66qEo8dnMcWUiiJfurB1AHld5nSiQ35UOBijqGNtjgu2zYRivPbrvpTEdNUIz1vv2KkB1pjh2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jX4ysiod; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-411f165ef9bso10362875e9.0;
        Thu, 15 Feb 2024 10:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708020587; x=1708625387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUAAEWcfCMwa7677MxMyGU88cfm9xN0qS3zlnmexBHA=;
        b=jX4ysiod6iCTUKFCedlBoup1tFNJtP4NmO+PYqdNJl2QxtJu5EySr4VYBLCvp5w5Kl
         WVmchwdcJnlR5Uf9KKeDRZjnD58w5em78ad84V0zr0c1DTJCYyT2JPAjssqmwJuBhOOH
         ivFmpjQmbgqHi6Vfa/3w3y0M5TMJhhjeEW9eWmC8T+AkF94XhxLUNGPfRyYDNf9EH2v7
         i40InIEu/Uv2B5oOWoIz0Q8a/W2unQBGdPefPVF4DRoOymAejNWFLgckxRyC2W6ySvwD
         8MXoJmXZYn9PH9++oEpSCXF+4g0N6vglneinwdCaXLzKh4XLcPUP9+Qd6gKetiMBYcdG
         MHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708020587; x=1708625387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUAAEWcfCMwa7677MxMyGU88cfm9xN0qS3zlnmexBHA=;
        b=QTyTPb+LZfSTXkhxFqOh+gvA6TLrhzhm7yOcu0Lw3hDMrg77rDRasKyC16GcyevAvd
         WNK0zplr8NMuLY6XfYtGtZmLoRxO3KmYxo4L6OtRBFrr3jMQyPbp9cJuV/NXX3Tqnok8
         k5/FxTnnPrrmLSlPjmV32vSFyg634B3JPE8J/VBfla9UmiUb0fgrYBd45OHKqA80Q1Br
         78JVro7hMWt4wuNI92I4O3/5xsklYh/TiskiyEM2KYWMOr5Q/WHJbpfNBPoLiIjh29Jn
         mwjFUUCQA8DHb0zlIco98dojJ+cRtdulWU6pPFJq56WS6jWc8ttComsfwLCHR75NmmoB
         mT7A==
X-Forwarded-Encrypted: i=1; AJvYcCXejd2WNELqcY7WQvpfQGZkMwnkXpy/JP8KcBacTtqmHS2RiUYj7sX/JffRbkituis0uA8QGfI7e4HS+k7OBcgu3gvHokt8lIDWPkAUw3r2DcCVvlVOPZkgezJoof9fEqlGwzhzctGq4/0=
X-Gm-Message-State: AOJu0Yz6NI/jP3WPnUVodaqXg6MiCF9Vf8bvd/PjT1SRMymJV1dGp89z
	o3xIZ0zF+IG8lyAIzu/f20Wlkseh22vubCG7QGa1SzTJEfTBCwMUxyr1vnjf/GvHCIYkoDWJwY/
	+EiLGyojCeVxaKhPko4ZXVgy/3rg=
X-Google-Smtp-Source: AGHT+IHNmdLroTYzl/DBp2Wh6+k70G8el0qtJommICuaW4NvZujKA590mtel8SBx3qjLVORvRqNlzTNg0PIIBj7aQK0=
X-Received: by 2002:a05:600c:34c1:b0:411:c25d:703b with SMTP id
 d1-20020a05600c34c100b00411c25d703bmr2141905wmq.16.1708020587199; Thu, 15 Feb
 2024 10:09:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210175530.137361-1-clamor95@gmail.com> <20240210175530.137361-2-clamor95@gmail.com>
 <Zc5QANGhS8EPvgEy@google.com>
In-Reply-To: <Zc5QANGhS8EPvgEy@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 15 Feb 2024 20:09:35 +0200
Message-ID: <CAPVz0n3DA6PiJOhkX-0Lk1QXjaKa9NkLkDRkV85Z3S2S5S8Ogg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] input: touchcreen: tsc2007: make interrupt optional
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Benjamin Bara <benjamin.bara@skidata.com>, Richard Leitner <richard.leitner@linux.dev>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 15 =D0=BB=D1=8E=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 19:55 Dmit=
ry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Sat, Feb 10, 2024 at 07:55:30PM +0200, Svyatoslav Ryhel wrote:
> > In case tsc2007 is used as an ADC sensor there will be no interrupt
> > provided at all, so set up an interrupt only if one is present and
> > remove associated warning.
>
> If we want to do this, we should better handle the input device portion
> of the driver. We have 2 options:
>
> - switch the input device into polling mode when interrupt is absent
> - do not create input device
>
> Those do not need to be mutually exclusive (i.e. we could use absence of
> both device tree interrupt property as well as lack of poll-interval
> property to suppress creation of the input device and only leave iio.
>
> Thanks.
>

I do not care about input part and suppressing it is perfectly fine for me.
Which implementation would be accepted?
I suppose I may isolate input device creation into separate function and
add check for interrupt or poll-interval. If both are not present then inpu=
t
device creation will be skipped. Will this be sufficient?

> --
> Dmitry

