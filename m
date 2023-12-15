Return-Path: <linux-kernel+bounces-1241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7AE814C37
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEF8BB221D6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E6A39FD5;
	Fri, 15 Dec 2023 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYfocM7G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8F836AE0;
	Fri, 15 Dec 2023 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-20335dcec64so541010fac.3;
        Fri, 15 Dec 2023 07:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702655961; x=1703260761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MG9yAVm50lR8ICiHnRNf31I38rZ2htO3wSzdsU8ztZ4=;
        b=bYfocM7GSsVJZf+EwNVkKSYt/oXyb8nGzid2gsTO2283SPe3R37/mMjljASE/+Rb9q
         XvX3xL+W91GJraaTBWTpLe1x8lUgf0OzQOMur+vrCr17d9qRTOighCn7q7XmsTe9M0Wg
         M6Xngw2hBRYjHYDSVZ2QtiBFHBuRghiuQX21on0ZpPh7zRxu/GcQxh/eV/32FeLmaAxq
         AJSP3U/uX9DrMqJNPjPphQhp/y0NTdsYSn2gIQQfPXkmyKpy5XHByF29odBuRSqI7Xqj
         HYzSzCcHx7mnfjiu2Sbb+0P8u1aDopCLsbx2GKaXBjpLB4aQtAQm5ZdDuUMPdM3qzBWY
         s8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702655961; x=1703260761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MG9yAVm50lR8ICiHnRNf31I38rZ2htO3wSzdsU8ztZ4=;
        b=JDefa4x2zHAypvm+VMptdNqEQuq6cJpvx0VoclmhB6TLTugDUNg40Rtg29mD0V99Yl
         n39HtJIueoGdllDM4piGasJ9m/2VHWc1Z+HGivP2sPCi9CU0HgN1wZ9W1+pPJzIabOIk
         X6VIjhUoJCIXE9mqFdb4CwXYY/Bm8J1wJnfR8PPxsJ5QOTB1RgSIkihPh/OicxrzMTsU
         mMIPpE+UTdA6I2FCTuvJlAnr3LDAg9CiCYLqkBmR2aQaIi9ZOpdn83WvY5LiPxyl4JRE
         8gs7XHUzyezoeTw5xafb/zUL2MnDx8E9lG3yvuCs1Ss2bVhoSKINmddTNDjnfAxfqyQI
         hgFQ==
X-Gm-Message-State: AOJu0YwLYKSEom2S2R9Gq1zcEqN11uilEkUc9fdtcGl0geLixr8Y3YzS
	2wb7SgK8s7rBPz1gTfOgD2II7L1mlfyRMUH5wtoV+CI6GW7tzg==
X-Google-Smtp-Source: AGHT+IGLoY1Nw1pfnxSccxTPPQGkI5sLz3dmiL9hVukMxvSLrc6SwWXCmZBocGOvbRO13ErKz7EtuQ8V4zYiAag9VFM=
X-Received: by 2002:a05:6870:9383:b0:1f9:e6cb:7eb5 with SMTP id
 b3-20020a056870938300b001f9e6cb7eb5mr13635905oal.18.1702655961087; Fri, 15
 Dec 2023 07:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214173614.2820929-3-gnstark@salutedevices.com> <c16599b23afa853a44d13b906af5683027959a26.1702621174.git.christophe.leroy@csgroup.eu>
In-Reply-To: <c16599b23afa853a44d13b906af5683027959a26.1702621174.git.christophe.leroy@csgroup.eu>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 15 Dec 2023 17:58:44 +0200
Message-ID: <CAHp75VfBcmTBXXtU6o1x0Ea24wG-_Qb46opkS0EXKQ1Ynh0Mcw@mail.gmail.com>
Subject: Re: [PATCH RFC v4-bis] locking: introduce devm_mutex_init
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: pavel@ucw.cz, lee@kernel.org, vadimp@nvidia.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, hdegoede@redhat.com, mazziesaccount@gmail.com, 
	peterz@infradead.org, mingo@redhat.com, will@kernel.org, longman@redhat.com, 
	boqun.feng@gmail.com, nikitos.tr@gmail.com, 
	George Stark <gnstark@salutedevices.com>, kernel@salutedevices.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 8:23=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> From: George Stark <gnstark@salutedevices.com>
>
> Using of devm API leads to a certain order of releasing resources.
> So all dependent resources which are not devm-wrapped should be deleted
> with respect to devm-release order. Mutex is one of such objects that
> often is bound to other resources and has no own devm wrapping.
> Since mutex_destroy() actually does nothing in non-debug builds
> frequently calling mutex_destroy() is just ignored which is safe for now
> but wrong formally and can lead to a problem if mutex_destroy() will be
> extended so introduce devm_mutex_init()

Missing period.

...

>  } while (0)
>  #endif /* CONFIG_PREEMPT_RT */

^^^ (1)

> +struct device;
> +
> +/*
> + * devm_mutex_init() registers a function that calls mutex_destroy()
> + * when the ressource is released.
> + *
> + * When mutex_destroy() is a not, there is no need to register that
> + * function.
> + */
> +#ifdef CONFIG_DEBUG_MUTEXES

Shouldn't this be

#if defined(CONFIG_DEBUG_MUTEXES) && !defined(CONFIG_PREEMPT_RT)

(see (1) as well)?

> +void mutex_destroy(struct mutex *lock);
> +int devm_mutex_init(struct device *dev, struct mutex *lock);
> +#else
> +static inline void mutex_destroy(struct mutex *lock) {}
> +
> +static inline int devm_mutex_init(struct device *dev, struct mutex *lock=
)
> +{
> +       mutex_init(lock);
> +       return 0;
> +}
> +#endif

--=20
With Best Regards,
Andy Shevchenko

