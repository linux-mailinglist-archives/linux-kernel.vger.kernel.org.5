Return-Path: <linux-kernel+bounces-61932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9C785189D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC245B20C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE633D0B5;
	Mon, 12 Feb 2024 16:04:13 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7373CF49;
	Mon, 12 Feb 2024 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753852; cv=none; b=Zp+6QLpynLpCYO1ucv10emY3zXcrjjrzqHfZ6Ab1h7hFVhfW73vqQpRMEjfNcANg/UVM//NLW2DEZLTg8bkzxAI1x4gyM/t7EBN7cnDogA8pkKmBNXX8+sq4BP9UZlS29yezNWMcvYC61CpeJ2ZpNU2js6HMRJhiuq8y6Gsb8wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753852; c=relaxed/simple;
	bh=PNP72Px6S3AEEfMX7LEV922c1w+0cE2o1GDnrSE2VMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lw+8ITj1y9PInDa/FRndc1ruLVQmeHuHPqPAnxHjqWbmAQUg/+R9CGm+N2xdJC5B1IHFvc1FQOIjlRhgbt6J0deIBPQo7TPQIZrAeNpUVkRmT+u32FzyA0w1h9s+gg24W+ebcExcT3W9Pp7p4qwB58zi9BHkTQTkcXKHFKwg8UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e2e48e8588so25443a34.1;
        Mon, 12 Feb 2024 08:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707753850; x=1708358650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4581LG9FrG93qfAY82tZ3PZZpo3QUac35GBmxdsylQ=;
        b=s1F2Bwa3w2eCR/+7z6NvkS2oM1+iapAFCZPh5Pdcg1zbP3yY63AFsA4zVdq6DZ/LT0
         gs9SFFZmbvaB8f2/wFQpG8/W4em9qt92hV8XmFhWG3XXHRlqlPi2j4qH6eQatmqQZl5x
         7WH60vvubKmft/O0dywwtnWJIF7wPvSvrlaREaSsCFsZqyLHh6tMLJW+VWm1imbleWCT
         dVch6SkRdNEX/0SIsBUXTAfr+6PhU1OaiSyvZmV4l9JfxH4evjRteJbS7iIFuDa9wyVi
         ZhK9rtymQpoTigyE5MZxPEUEIUjqj0JmRW+vsdI2WivXVTxn4SC2T2kx8XPngAxI0uVZ
         uF8w==
X-Gm-Message-State: AOJu0Ywz+Box5t7TZKuk+KkzANESFbudA/HJDl/Rgh/O1dUu3t4zgIxu
	AUQBq0R6awtBzq1F/vQQDA2Eb6FQs7NfsKDMUWJpvDceKRXnhtrruIy3oQv8onjqP2/0/7KP6un
	dUE8yznUtTOWKQxmGlT+uigZPZ+yzNWRv
X-Google-Smtp-Source: AGHT+IEwFJdlGU3bgtguTa/hZodZRild+iV5zfGercFm93WqOfQuZFX0obHHFXe5Y1QQXqtFfSZZrkXwWFyQc0J8Bv8=
X-Received: by 2002:a4a:ce94:0:b0:59a:bfb:f556 with SMTP id
 f20-20020a4ace94000000b0059a0bfbf556mr5719864oos.0.1707753850512; Mon, 12 Feb
 2024 08:04:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111135950.17016-1-parshuram.sangle@intel.com> <ZbvmrdBkeOK71KGg@tpad>
In-Reply-To: <ZbvmrdBkeOK71KGg@tpad>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Feb 2024 17:03:59 +0100
Message-ID: <CAJZ5v0jyUSWuj0RZg9o2yASZjkxf+X3_J52jiUwQuzeCKN88_w@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: do not shrink guest poll_limit_ns below grow_start
To: Marcelo Tosatti <mtosatti@redhat.com>, Parshuram Sangle <parshuram.sangle@intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jaishankar.rajendran@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 8:56=E2=80=AFPM Marcelo Tosatti <mtosatti@redhat.com=
> wrote:
>
> On Thu, Jan 11, 2024 at 07:29:50PM +0530, Parshuram Sangle wrote:
> > While adjusting guest halt poll limit, grow block starts at
> > guest_halt_poll_grow_start without taking intermediate values.
> > Similar behavior is expected while shrinking the value. This
> > avoids short interval values which are really not required.
> >
> > VCPU1 trace (guest_halt_poll_shrink equals 2):
> >
> > VCPU1 grow 10000
> > VCPU1 shrink 5000
> > VCPU1 shrink 2500
> > VCPU1 shrink 1250
> > VCPU1 shrink 625
> > VCPU1 shrink 312
> > VCPU1 shrink 156
> > VCPU1 shrink 78
> > VCPU1 shrink 39
> > VCPU1 shrink 19
> > VCPU1 shrink 9
> > VCPU1 shrink 4
> >
> > Similar change is done in KVM halt poll flow with below patch:
> > Link: https://lore.kernel.org/kvm/20211006133021.271905-3-sashal@kernel=
org/
> >
> > Co-developed-by: Rajendran Jaishankar <jaishankar.rajendran@intel.com>
> > Signed-off-by: Rajendran Jaishankar <jaishankar.rajendran@intel.com>
> > Signed-off-by: Parshuram Sangle <parshuram.sangle@intel.com>
> > ---
> >  drivers/cpuidle/governors/haltpoll.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/gov=
ernors/haltpoll.c
> > index 1dff3a52917d..663b7f164d20 100644
> > --- a/drivers/cpuidle/governors/haltpoll.c
> > +++ b/drivers/cpuidle/governors/haltpoll.c
> > @@ -98,10 +98,15 @@ static void adjust_poll_limit(struct cpuidle_device=
 *dev, u64 block_ns)
> >               unsigned int shrink =3D guest_halt_poll_shrink;
> >
> >               val =3D dev->poll_limit_ns;
> > -             if (shrink =3D=3D 0)
> > +             if (shrink =3D=3D 0) {
> >                       val =3D 0;
> > -             else
> > +             } else {
> >                       val /=3D shrink;
> > +                     /* Reset value to 0 if shrunk below grow_start */
> > +                     if (val < guest_halt_poll_grow_start)
> > +                             val =3D 0;
> > +             }
> > +
> >               trace_guest_halt_poll_ns_shrink(val, dev->poll_limit_ns);
> >               dev->poll_limit_ns =3D val;
> >       }
> > --
> > 2.17.1
> >
> >
> >
>
> Looks good.
>
> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>

Applied as 6.9 (with a minor change in the subject), thanks!

