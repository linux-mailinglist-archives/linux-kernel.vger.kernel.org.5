Return-Path: <linux-kernel+bounces-133009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B31899D4E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F6C1C222BC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F9116D326;
	Fri,  5 Apr 2024 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeG3YoD7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8426316D315;
	Fri,  5 Apr 2024 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321051; cv=none; b=gjli4zcgUVlN0R9rDwHG/sWRetfd97moeivuFcFYzmtAdp0pXTYDI5a6iDU5dijeyI0xOf+RKoKRjmQuJrZTijyXlqg7fDX/B+sQWOpiYiKNgQyBz8zGxT08Lr5Qhd8Da7t72iJyo9S819sg01Zb86QdUsqnLYM8DAXPUJ3Hehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321051; c=relaxed/simple;
	bh=edcCoszjUKd1ECTp0gcxr9Z0qBWJGarmIR7fLPUnxyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFsTrlUvYacmbQb+M08P6Ro0kefJIjCsAPa0IGQ+PK151KHKOxrqEOsJNV9tW4z3HS8Oejt0gVmgG+tRTQoKgkUheMYDzUn3scbMSKN4IeATRFhLX1JSlmhEzVIA/lS9mPfOzUqc3JmgjvLQ8BPxYaAihQHBmXCI/9i14qFIh5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeG3YoD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28731C433C7;
	Fri,  5 Apr 2024 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712321051;
	bh=edcCoszjUKd1ECTp0gcxr9Z0qBWJGarmIR7fLPUnxyw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MeG3YoD79b6FhpaPuptWdVAahekfXkOLNgdnN0RFS0Os+ZFjaRfYZuo5EBibwz84U
	 HKqEXFulS7WGCeyTCovIP1jvSo8Tyix8hKWnOysIMwy4BRzRzI6jzRxRwkRcHs+TJJ
	 btbjM+2SHqTEfh//9Kd1K207bJfjEVLEsxKD2UBxflKWLeFmhjH/kQ6ZsFHnaFMFDW
	 GsQkvOkJvOssyxrX+umH3hy4OQa+fVDnO7/Ctq9ftD0VBm7/HTe6Ar84bqw3sVBJn9
	 gUbPyHRQULfoNWhe+CtNhoGKlRZuBjhBTcaK6N/5RRcFyNqPEB6lZY2Fz7sA+Rl5eG
	 Oxcyyv9/9GcWw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d0161e13so1966045e87.3;
        Fri, 05 Apr 2024 05:44:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3UTQIghuZR1kMVBruVMa3b9Pw03l+L6YDJaDzVWJX8kobrxYvrz68kkIwjOko6Icziv24JJvAm3a0u23kVWKCYvtsDIZnfA+hBKB0Fh0g2zv9nRDnfIUGmxXSWsGFW1Zlk/kUKC96tA==
X-Gm-Message-State: AOJu0YzqW7TblJV9gEY07xTClyYYu0LcD3mblRokLFLO7BhbCiJvigf8
	mjCNKj87/PHlD2Ei5PKyH8AZjiopNPiiGsrPtjqsyNyHV1z0w5DvkEpEPNETNu9a+CfHkP2K6Vi
	dkwsaAgGN5HujOEECqmDm+FVHRA==
X-Google-Smtp-Source: AGHT+IHskARlN+LkglmZHFmblBjXR67rflSWElcFeL0oj7C4JsN0apkULoKUi9TlCF82MTXawa6KD25EuAuY8YYa54U=
X-Received: by 2002:a05:6512:ac5:b0:515:d3dc:43e with SMTP id
 n5-20020a0565120ac500b00515d3dc043emr1449133lfu.51.1712321049475; Fri, 05 Apr
 2024 05:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404-dt-cleanup-free-v1-0-c60e6cba8da9@kernel.org>
 <20240404-dt-cleanup-free-v1-2-c60e6cba8da9@kernel.org> <CAGETcx_H_vvK9y-51JTcz8F7GDThBwC+t=k2i6r4Nst3H6-TUg@mail.gmail.com>
In-Reply-To: <CAGETcx_H_vvK9y-51JTcz8F7GDThBwC+t=k2i6r4Nst3H6-TUg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 5 Apr 2024 07:43:56 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+eS3uS1rEPSErMnfJhPBoQjh7UyRLa9NZ59WBVcD+JWw@mail.gmail.com>
Message-ID: <CAL_Jsq+eS3uS1rEPSErMnfJhPBoQjh7UyRLa9NZ59WBVcD+JWw@mail.gmail.com>
Subject: Re: [PATCH 2/3] of: Use scope based kfree() cleanups
To: Saravana Kannan <saravanak@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 6:16=E2=80=AFPM Saravana Kannan <saravanak@google.co=
m> wrote:
>
> On Thu, Apr 4, 2024 at 7:15=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
> >
> > Use the relatively new scope based kfree() cleanup to simplify error
> > handling. Doing so reduces the chances of memory leaks and simplifies
> > error paths by avoiding the need for goto statements.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/of/base.c     | 34 ++++++++--------------------------
> >  drivers/of/dynamic.c  | 11 ++++-------
> >  drivers/of/resolver.c | 35 +++++++++++++----------------------
> >  3 files changed, 25 insertions(+), 55 deletions(-)
> >
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index 8856c67c466a..20603d3c9931 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -16,6 +16,7 @@
> >
> >  #define pr_fmt(fmt)    "OF: " fmt
> >
> > +#include <linux/cleanup.h>
> >  #include <linux/console.h>
> >  #include <linux/ctype.h>
> >  #include <linux/cpu.h>
> > @@ -1393,8 +1394,10 @@ int of_parse_phandle_with_args_map(const struct =
device_node *np,
> >                                    const char *stem_name,
> >                                    int index, struct of_phandle_args *o=
ut_args)
> >  {
> > -       char *cells_name, *map_name =3D NULL, *mask_name =3D NULL;
> > -       char *pass_name =3D NULL;
> > +       char *cells_name __free(kfree) =3D kasprintf(GFP_KERNEL, "#%s-c=
ells", stem_name);
> > +       char *map_name __free(kfree) =3D kasprintf(GFP_KERNEL, "%s-map"=
, stem_name);
> > +       char *mask_name __free(kfree) =3D kasprintf(GFP_KERNEL, "%s-map=
-mask", stem_name);
> > +       char *pass_name __free(kfree) =3D kasprintf(GFP_KERNEL, "%s-map=
-pass-thru", stem_name);
>
> With the scoped stuff, do these function calls need to be in the same
> line we are defining these variables? If not, I'd rather that the
> calls remain where they were. It feels like a lote to visually parse
> and take in from a readability perspective.

They don't have to be, but if you don't want to get yelled at by the
chief penguin, then yes, they should be together. See the discussions
on adding the scoped iterators. But with the C99 adoption, we can move
the declaration to where the assignment was original.

Rob

