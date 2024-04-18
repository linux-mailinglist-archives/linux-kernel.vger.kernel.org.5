Return-Path: <linux-kernel+bounces-149573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17E18A92FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32051C20CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857A06A8A0;
	Thu, 18 Apr 2024 06:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoHVXMFn"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A0657D4;
	Thu, 18 Apr 2024 06:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421355; cv=none; b=ARguYMisFuXakTnyvIY3kQ4NIPBW6G1lAsOyQzlOUFAzCVjvtC3kLVrS6Z/5qmzx4JiSd4qLSMbhAUToU+gMItgFKe022qKVTTd7wmDpIIc8rX3Hrjnd9xOBc2BIPhgmPzwkS9Bnu4j+YKg35KvrsYzMOqXPW5zeR7iPL2SS6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421355; c=relaxed/simple;
	bh=RMxeGlytSzr2yICesp6CIsJyZqfq/CE7BwA5I7Ia270=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAiYc2DzPEx5FQ/Uc3wQIyI36U/DuJpej3kBdIenCK11bQYqdk3/Z/5mzrecDuHVEwz6UVwaindytU59yRJZQVj5C174bYe0Zq9+AiW8pMx25VR52HFI3FGyPI6neIf6LgPUS9Cw2wbUYU3nySiJq9k0hTDr+RddfPZZXh1i1Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoHVXMFn; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78edbed6e86so11859785a.0;
        Wed, 17 Apr 2024 23:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713421353; x=1714026153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FTPzIVtyQWqUeYbXLNcbKqJXloSnrql2UGPViVWAig=;
        b=KoHVXMFnthpiXMM6P5csbVFtpmBemHEGTyCpoJooAGr/W+jN2u57DD1J1Img78XENU
         uK6m4YaSNa3RTQHGjxJP17kDZQPkcFAA7Xzc2tIT1LQKzCA0bMqfIe2uEOtnpM46Om7F
         7z972isepZLWacfWWDvEb9/CZ9nzIIkr910vMdAGoMfvJPuYhWKH6mf7D6H7nuuA71uT
         3LR9ooNtObd+KCJqALCjV9u1pruNe63qBx/eYt3+v6jXSC/ROeBL2TZ0KlPjMO2yO9FM
         /VMi61XmE4bquaJIliQjQ+3upD3b5tpHx9pTEXjaZerGZc8lAh/13A7Jb2myhOeAu9Cx
         DrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713421353; x=1714026153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FTPzIVtyQWqUeYbXLNcbKqJXloSnrql2UGPViVWAig=;
        b=SFYOZbYPcDEA0mLNphBQt1t/863VqtdCNHfVPg+sNa6YK5Bo1Ysa1DwVlHtEGxjBQf
         nlE1qXF0YRXA4gIf6ePq3zmJWGzGcsjA4qOBIRm3Gqf1h9RJXPgW0i1N5r9VMBTl+UVm
         +eYoMxP8lSs+vdy9mkMtStVGkdvLqHKkXiKMh9CBAJMpc4zb1vsOCXUcCCpPXlVKOfXP
         dRpNxvb47q9MJvNedYLWXu5JTj6tXYZn44cIsQSY4zuF9Smd6GzlQV8qxa3HFOu4zkeF
         YR+VRsIO5G/QUmQyzNHlgJGOCByvoROMshMnSrvHe9YtmyITaA+PXZeg6NNI0oe9vC1+
         A92w==
X-Forwarded-Encrypted: i=1; AJvYcCVq3rgGxG092bxLmUFOD6AB/M8dTEVoiDgF28XNZnQK1zMgquectN5Xe6UJ91jQkvdJTxhGDehwW2VVgCc25owtkTJMzHY9O6nF9g8=
X-Gm-Message-State: AOJu0Yye46T0iu/ZlOvwHmNmy9p2dmjOyZBuLJ1TVVl/26XyOqycK6kF
	XEc2k1JdIjfWijZtxyPfnGUD07+iImqAf6TX5mstUQ6PKJKcJRY5Lx1k00aMRSbq5/I0WCftlM9
	4Q+WJQw5ALFro77hid6iVxdWHrI6/9Uh1FTbTNw==
X-Google-Smtp-Source: AGHT+IEuHnFnHDtQ+KH89IzMYUvms+I6LyrcSf+qewCMk2G7Y/fKVhQjaTLu0qwY5IBnfPOvj9Ls2vXkmTWx1rUCcCg=
X-Received: by 2002:a05:6214:e4f:b0:69b:3bd5:240d with SMTP id
 o15-20020a0562140e4f00b0069b3bd5240dmr1987358qvc.2.1713421353367; Wed, 17 Apr
 2024 23:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNmEtrN9DK-XmESaPm_1xpXm8A+juE+44Jf6AK5JE0+TQ@mail.gmail.com>
 <874jcl7e83.wl-tiwai@suse.de> <CABXGCsMmRFW3EYJ3UvNd-LO7ZTOyoNqjc_3OAmaCDSL=LuxJqg@mail.gmail.com>
 <87v851e2di.wl-tiwai@suse.de> <CABXGCsNMBRUaY-V8mhUQKdq+CQW5+eGUWL_YCJWXo0cgh9bGJQ@mail.gmail.com>
 <87h6glt9zc.wl-tiwai@suse.de> <CABXGCsMcazRvmiN4XtiHQCE9=dB=M=VsRqB=v+RPmtuhBL29DA@mail.gmail.com>
 <a6f4e20ea2a68f56a7d2c4d76280bca44d6bf421.camel@gmail.com>
In-Reply-To: <a6f4e20ea2a68f56a7d2c4d76280bca44d6bf421.camel@gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 18 Apr 2024 11:22:22 +0500
Message-ID: <CABXGCsPdqfXeZUw1ocx8O3NdOEb+h4yQ77+zdNpcwP_4JrYXuQ@mail.gmail.com>
Subject: Re: regression/bisected/6.9 commit 587d67fd929ad89801bcc429675bda90d53f6592
 decrease 30% of gaming performance
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 12:29=E2=80=AFAM <mikhail.v.gavrilov@gmail.com> wrot=
e:
>
> On Mon, 2024-04-01 at 21:50 +0500, Mikhail Gavrilov wrote:
> > On Mon, Apr 1, 2024 at 7:48=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wro=
te:
> > >
> > >
> > > Then it shouldn't be dmix/dsnoop.  You'd better try profiling
> > > what's
> > > going on there.  e.g. try to get perf results with and without the
> > > commit.
> >
> >
> > Here is original perf files:
> > [1] perf-with-revert-587d67fd929a.data -
> > https://mega.nz/file/EpZmXbgL#vEnxuODoB__jM6TwV6XbwC_TWMMqvT7qaWkJU22JY=
48
> > [2] perf-with-revert-587d67fd929a-beb45974dd49.data -
> > https://mega.nz/file/0lI31CDA#hKsv6vX7t5u-Sx1_p2E7-Y32-z5VFPlW2Y793oM-J=
RU
> >

Excuse me. Can you have time to look in my perf files?

--=20
Best Regards,
Mike Gavrilov.

