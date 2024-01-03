Return-Path: <linux-kernel+bounces-15467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61472822C65
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC3C3B22BA7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540D918EAF;
	Wed,  3 Jan 2024 11:54:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26A018EA1;
	Wed,  3 Jan 2024 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5e7f0bf46a2so85256447b3.1;
        Wed, 03 Jan 2024 03:54:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704282861; x=1704887661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZdpDg9MgC1yCbq1bYlsWWXIuzgecTcvyQdn+DaFzA4=;
        b=FH+Q8NAdfw5Hr9O3BH/L3hwn4X/D4cF9k0EtVnMoHhVd5wmfQQSlG4aYvoBEUUv92U
         xedHTUFDdpe5wRajzkM1csqI9nkOHe/lK2AZ66+cIg1D3Nu4PEEjRLcKn4zqWA5ezn9S
         a4qeuBINdQzngtB6g6zLCLu+Evuv+Y+KUbkpbtey+Hit7KtBlAxAA8vnJfxDvKtzV8xj
         uGHZTuv5PFDupkycMLrtxZuroBJQ91gKp1XwkWMsb7lbbcmZy64Bt7Ngm6/8edFSpEnS
         rwD09Y2DEO3UfZ6FWbD4ayWfcblK/Rg/W9Ldf4QK9HXkvfld5mJ5SVu2B8kNrVdrbrDP
         fj/g==
X-Gm-Message-State: AOJu0Yx7ZY7ACWRqDV0N1Y3YIO3RTfILNA6NUxZt82npQlJgvER7jWYW
	Au5ufPm1Wm2cQDHWhCYGPcreUMw+NvkRXw==
X-Google-Smtp-Source: AGHT+IE2UwZpftRucAjwmasmsCYQOZPBjSwBKQ4ma4FiPd/ZMQVBVm2wMy1EllTYbq2fDrUEDreicg==
X-Received: by 2002:a05:690c:34c8:b0:5e9:faad:b173 with SMTP id fp8-20020a05690c34c800b005e9faadb173mr8620106ywb.48.1704282860791;
        Wed, 03 Jan 2024 03:54:20 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id i131-20020a815489000000b005d317074440sm12909652ywb.79.2024.01.03.03.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 03:54:19 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5e7c1012a42so85157117b3.3;
        Wed, 03 Jan 2024 03:54:19 -0800 (PST)
X-Received: by 2002:a81:8742:0:b0:5e7:7964:c1ea with SMTP id
 x63-20020a818742000000b005e77964c1eamr12605669ywf.46.1704282859111; Wed, 03
 Jan 2024 03:54:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103015240.1065284-1-pvorel@suse.cz> <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
In-Reply-To: <20240103114957.GD1073466@pevik>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 3 Jan 2024 12:54:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
Message-ID: <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
Subject: Re: [PATCH 00/36] Remove UCLINUX from LTP
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>, Li Wang <liwang@redhat.com>, 
	Andrea Cervesato <andrea.cervesato@suse.com>, Greg Ungerer <gerg@linux-m68k.org>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Christophe Lyon <christophe.lyon@linaro.org>, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Petr,

On Wed, Jan 3, 2024 at 12:50=E2=80=AFPM Petr Vorel <pvorel@suse.cz> wrote:
> > On Wed, Jan 3, 2024 at 2:52=E2=80=AFAM Petr Vorel <pvorel@suse.cz> wrot=
e:
> > > UCLINUX is broken in LTP and nobody really cares. Actually I dare to
> > > say UCLINUX is dead. Therefore I prepared patchset to remove UCLINUX
> > > from LTP. We have been actively removing UCLINUX from LTP during rewr=
ite
> > > tests to new LTP API. This removes the rest from the old tests (which
> > > will be sooner or later rewritten to new API).
>
> > > Because the patchset is quite big, I did not want to send it to maili=
ng
> > > lists (but I can do it if you want).
>
> > > Can you please have look at my fork on gitlab, branch: remove-UCLINUX
> > > https://gitlab.com/pevik/ltp/-/commits/remove-UCLINUX?ref_type=3Dhead=
s
>
> > > Build test:
> > > https://github.com/pevik/ltp/actions/runs/7392470215
>
> > Thanks for your series!
>
> Thank you for your feedback.  May I add your Acked-by: tag to the series =
when we
> agree to merge?

I am not sure I agree with this series.
Removing support for UCLINUX from LTP is almost a guarantee for
not noticing when more breakage is introduced.

How exactly is UCLINUX broken in LTP?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

