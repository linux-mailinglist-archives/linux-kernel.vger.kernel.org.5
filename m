Return-Path: <linux-kernel+bounces-103125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 044FD87BB54
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C561F22158
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1776EB4E;
	Thu, 14 Mar 2024 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IV1LJ3Gi"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33741347C1;
	Thu, 14 Mar 2024 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412429; cv=none; b=PoJt8cOGpeZPXj6NhieQ9I3El2+m/if4D5puaw8xe5i0HiKup0tTLn48UkQAiLjQjAyCHKs6LTkkoRSbwWAvUru7oR1JwazTlZZRyKDRYovaby/TF0bQGvV15s8vStp9LsRHZUMdjKjpr5xJS5ux0s/o26iTWy9IrNO5O/IZKWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412429; c=relaxed/simple;
	bh=iZDy04kALp0HO9vpw+exKughW0nV83r8fp9t6svxXyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gh/OZlsJRyN8HZdCreaobwsmojDwrlMWSnWwBrZCTvBkv3VaIxLMtN/RKmYxcOGsfBj61JK9PDB+DuPIZA68h/OLXtRaU6m8rVEsNZPc3JDDP2T/6gnILwMEvDn6BFivKnZs+L+u7iPwJPb1wskxxSaGxCpS22ZzGKiekieJ660=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IV1LJ3Gi; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a450bedffdfso84418166b.3;
        Thu, 14 Mar 2024 03:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710412426; x=1711017226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jue9nUfRRiSlNQWu5LcHhmk+uFTWQIyCfZh4ap/Abso=;
        b=IV1LJ3GihvXKYAysjrRNN812n2VHu6P4gAxZCVosMBx3NFbJXxAubv1LB3EZkQkNbQ
         HzZvtwpQAvN5Om5AbS65xCg42qgRTncW2icvdsFwGhwu3q9JxP06GUL0rakASNyu5t5V
         vKlDrMMbmaoTavAUdX6i1PWaAmuiKvco6upFTsyG29UbKFFc2/wpZSp0Ctu3nA35NfB8
         wC+Ss9A+SI5+WWMpFClu4r1Y/G8bk81SBStYMzL8SBerLlqVI13qc0POgrQdSvfbBs/z
         nxtiY5DSYKmwPkBjqwpJm8eJ7pu7LH1NAXcrMppjr+VgcFk+1QUfD/hfpz71rCBikly+
         msDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710412426; x=1711017226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jue9nUfRRiSlNQWu5LcHhmk+uFTWQIyCfZh4ap/Abso=;
        b=YEOiq71JkhlJPSSrh2gvAd6izWic/wT77Idx3rkoM6QrJWGqLGtuA0PbsxpS5/vl8n
         2fR9xEFmcl8hsX4s6H198147VXkHXUmiuy4CpFClswpukH0bE6gac4QBfIdhMkr0KN4E
         +/WQ0+nmU1Ixq9GcomTKMkUCP5BX6TEEnkPdAksb60gnsHXvvarmDV6vSJ471O3rSKR5
         krjtuA9gNcbDJ6HNg+XNE77IFPwpuMidvIRioCDKgIaCZjbEaK8Z7Fd06qdTJP+NhQiV
         B0qsNsCq3YGZ1QoLHAJw20HlKjflqd0kLCTv6Y3mECPVUZeajlWbb1k/KBEAYBpuT9SU
         0l/A==
X-Forwarded-Encrypted: i=1; AJvYcCXYR5gocCfB7479BRJ7OaDxRg5ssZ7Ssu0Kc8YrcxmwVO5gseYOzSFt24Tu3FIsGRnWEIKLmkHe/mikE9VeaI6iclF14DLEagA1wWncP5LJ0ouZcXPphdlHTLEraqUV0WaEDyZtAbDNhA==
X-Gm-Message-State: AOJu0Yy1Yb9aomsCoiz7a9tvmkNbO/KT/BAw6+JcJmILJs9Bk/K6iVZa
	yLSicyF+VLS3e+A73VQEXTC35RQvgpUKhwA9N5zK8oNDF3E3m7jnxTO8gNyYmfTrDoT+134WYw1
	OLtexhr+WrTcyAkLe9VBVPLA65O8=
X-Google-Smtp-Source: AGHT+IH8HWWnhtzc44YalKwroFKYB1nvrYJZ4DjNqdGPigNqIr2X3HYd15E33bbNFvnnosUzFyxAXDmeUagTjt+Dz5g=
X-Received: by 2002:a17:906:3752:b0:a44:8fa9:d36f with SMTP id
 e18-20020a170906375200b00a448fa9d36fmr927863ejc.41.1710412426337; Thu, 14 Mar
 2024 03:33:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314084531.1935545-1-gnstark@salutedevices.com> <20240314084531.1935545-2-gnstark@salutedevices.com>
In-Reply-To: <20240314084531.1935545-2-gnstark@salutedevices.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 14 Mar 2024 12:33:09 +0200
Message-ID: <CAHp75VeHsSvs5eUC2eUTCLJLKNcoPShXoH3fmA0J4GUQTMV1LA@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] locking/mutex: introduce devm_mutex_init
To: George Stark <gnstark@salutedevices.com>
Cc: pavel@ucw.cz, lee@kernel.org, vadimp@nvidia.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, hdegoede@redhat.com, 
	mazziesaccount@gmail.com, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, longman@redhat.com, boqun.feng@gmail.com, 
	nikitos.tr@gmail.com, marek.behun@nic.cz, kabel@kernel.org, 
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kernel@salutedevices.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 10:46=E2=80=AFAM George Stark <gnstark@salutedevice=
s.com> wrote:
>
> Using of devm API leads to a certain order of releasing resources.
> So all dependent resources which are not devm-wrapped should be deleted
> with respect to devm-release order. Mutex is one of such objects that
> often is bound to other resources and has no own devm wrapping.
> Since mutex_destroy() actually does nothing in non-debug builds
> frequently calling mutex_destroy() is just ignored which is safe for now
> but wrong formally and can lead to a problem if mutex_destroy() will be
> extended so introduce devm_mutex_init()

Missing period at the end.

...

> Suggested by-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Needs properly spelled tag.

..

> +static inline int __devm_mutex_init(struct device *dev, struct mutex *lo=
ck)
> +{
> +       /*
> +        * When CONFIG_DEBUG_MUTEXES is off mutex_destroy is just a nop s=
o

mutex_destroy()

> +        * no really need to register it in devm subsystem.

in the devm

> +        */
> +       return 0;
> +}

..

> @@ -19,6 +19,7 @@
>  #include <linux/kallsyms.h>
>  #include <linux/interrupt.h>
>  #include <linux/debug_locks.h>
> +#include <linux/device.h>

Without seeing much context can't say if there is a better (more
ordered) place to squeeze a new header to. Please, check.

..

After addressing the above comments
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko

