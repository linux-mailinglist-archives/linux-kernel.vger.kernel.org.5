Return-Path: <linux-kernel+bounces-3186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 690278168B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080361F22ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3578010977;
	Mon, 18 Dec 2023 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1CQ47HSs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE80E10941
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4b6d2103c66so48543e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 00:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702889480; x=1703494280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKpt8Cq8/8CYoMLLlNbLUZ/tUYkrUXGfZfIGERTWREk=;
        b=1CQ47HSswRPRukgyWabJB2UXpYw00oKS4h6vxAg3CDYHoh0ZlLqgo6LDSnTjRR7yDX
         KP16TjesNJwoiIjTpMmwj24zF3awRlfTngZdImyGL+6KgjIPXH1kteAKKpFbgGG/+jv+
         cA7A5ELX9xBpd3Sn4jFkhDxEzeB6cPpmS2DfNMIFYct/eq4CalrHUqIp+0LTqnQ/yllu
         faRmP2vuaO0OABaaXxgncPufGI+0KvyQZA3yl+c+twNAoXHJo4lWXQfU7YIW1oqp1bd9
         PSsIlcMULKEmQqs5jpaaluGLRE825i9ERaNzcMmlNvjBDZSXfAcrEZmIsTZGBQl/Bey0
         LQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702889480; x=1703494280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKpt8Cq8/8CYoMLLlNbLUZ/tUYkrUXGfZfIGERTWREk=;
        b=PnAiJC8oKVJL9M7fjI+m5J7U7n3A545edA0r1L259NEY6ox8ZC13GKR9p6sdc6MUfF
         hXDIhESpMlqIKuHFLE/CdFlyflMfF+CG4X/oalgkRQJ4dCHcw7itkh/7eHRaIkP429l8
         TuADUkwnJSrURUGmpSd2pz8hLOqNMJwHvgI/fj+C9fs2gyAGBtwGdhKqam1Jpiu5bt/g
         O/e01cxj9LDiqyL8mKSsCcCYo1JF7KXWweqo5yJ4UTGuuHvxqRfxuQLg9iGcVYWz9Z9n
         NF59Rp2XPqCE4I47xWfYv6rjsQxbcLbP5WfnYq0FSARSTubl58+Gsq6PuXnR6Qbyi1ao
         8V4Q==
X-Gm-Message-State: AOJu0YyQG63eaE6j4LJn/zlyaI1xk9v0TQu1+eq33tw4ND6oUrQC6M3C
	lnitEyLxcgDFMeoIGGasvyqb5X0cX+FHRlcnK7Mdag==
X-Google-Smtp-Source: AGHT+IF2/8Yg6PgRIEjihn18nTksKl3RHuLlPtHVt6WC5JxCFQpUCC1xaOCXtJnUs7dnvCv7m4h53joQfpw/JdFMR0M=
X-Received: by 2002:a05:6122:2fa:b0:4b6:b685:a0a9 with SMTP id
 b26-20020a05612202fa00b004b6b685a0a9mr834286vko.33.1702889480614; Mon, 18 Dec
 2023 00:51:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127141600.20929-1-brgl@bgdev.pl> <20231127141600.20929-3-brgl@bgdev.pl>
 <aec86af5-1170-4fc4-9986-879c61fc8633@quicinc.com>
In-Reply-To: <aec86af5-1170-4fc4-9986-879c61fc8633@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 18 Dec 2023 09:51:09 +0100
Message-ID: <CAMRc=MfWtepi6m2xLdg7BhWSLp2=EY7z5KjxkFJFr9LC1Y4ALA@mail.gmail.com>
Subject: Re: [PATCH v6 02/13] firmware: qcom: add a dedicated TrustZone buffer allocator
To: Om Prakash Singh <quic_omprsing@quicinc.com>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Guru Das Srinagesh <quic_gurus@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel@quicinc.com, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 8:00=E2=80=AFPM Om Prakash Singh
<quic_omprsing@quicinc.com> wrote:
>
>
>
> On 11/27/2023 7:45 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > We have several SCM calls that require passing buffers to the TrustZone
> > on top of the SMC core which allocates memory for calls that require
> > more than 4 arguments.
> >
> > Currently every user does their own thing which leads to code
> > duplication. Many users call dma_alloc_coherent() for every call which
> > is terribly unperformant (speed- and size-wise).
> >
> > Provide a set of library functions for creating and managing pool of
> > memory which is suitable for sharing with the TrustZone, that is:
> > page-aligned, contiguous and non-cachable as well as provides a way of
> > mapping of kernel virtual addresses to physical space.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> > Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-think=
pad-x13s
> > ---

[snip]

> > +
> > +#include "qcom_tzmem.h"
> > +
> > +struct qcom_tzmem_pool {
> > +     void *vbase;
> > +     dma_addr_t pbase;
> > +     size_t size;
> > +     struct gen_pool *pool;
> > +     void *priv;
> priv is not being using any where.

It's here for other implementations of the TZMem pools to store
private data under. SHM Bridge uses it in one of the later patches in
this series but it makes more logical sense to put it here.

[snip]

> > diff --git a/include/linux/firmware/qcom/qcom_tzmem.h b/include/linux/f=
irmware/qcom/qcom_tzmem.h
> > new file mode 100644
> > index 000000000000..8e7fddab8cb4
> > --- /dev/null
> > +++ b/include/linux/firmware/qcom/qcom_tzmem.h
> > @@ -0,0 +1,28 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Copyright (C) 2023 Linaro Ltd.
> > + */
> > +
> > +#ifndef __QCOM_TZMEM_H
> > +#define __QCOM_TZMEM_H
> > +
> > +#include <linux/cleanup.h>
> > +#include <linux/gfp.h>
> > +#include <linux/types.h>
> > +
> > +struct device;
> > +struct qcom_tzmem_pool;
> qcom_tzmem_pool stucture definition should be moved to header file.

No, why would you do this?

Bart

[snip]

