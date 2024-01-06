Return-Path: <linux-kernel+bounces-18685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 713358260F9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 19:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC081C20DE9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 18:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA5DCA7A;
	Sat,  6 Jan 2024 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvbCttM3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C7BC8F1;
	Sat,  6 Jan 2024 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dbaf9b1674so376152a34.2;
        Sat, 06 Jan 2024 10:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704564084; x=1705168884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SlF5MKSukDXBsWTKudYrkR+clX5vSSACkqiWizoDMjg=;
        b=fvbCttM36NJtBB4NO8zwDWQcsDvo0fzYvq4+z6X1kdRnrL9gXxxcJsOkX1NMwBcTpG
         KOVDE4XxalScLiDZKJhgwladPPJSA5rkXEHiZ3GrSSrNcSS+Mxu42mI8lQXDapVmfJAX
         B0JbGxmi8HCDm+iaHqHcy6w83qzFTBjHv0JsjRgB2MUH/ocbPpmyV6lX/52ub/oQtXV6
         Ccre7ygaIrceiJabQJXX5RF7OjjMpv/RT8bF9peWcngR5DvoxuQjU4B76RpuTt5y5OeY
         L3jHSyv0Me43Wb/4Gj0xcEWJgDzxyzTgWJZq8uFODw5M/O0zCRJyHWHKgVNahn3+tfd6
         b/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704564084; x=1705168884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SlF5MKSukDXBsWTKudYrkR+clX5vSSACkqiWizoDMjg=;
        b=R90nwurwv9CaykDToZamE0wFHaHXrOuK66C4ryDvKMiALkEnWNe02C1W2tJPkyenmd
         6UCqvztuHwpSM6WC2zl8A5SO7zn1SSoMNcHqy2/BQIJMyv9Jx6YARo18ZtDtW3kZwO+7
         oscg1XVZw8n/8BvI/YPHZ+7YLnmk8Qk4pNq6WPCRpsMiJQoTJd+RHQCUsWypo4oZkBOA
         XXt93yvPAqvrIHsgaR39h0fBIGhT57iC+y4D1CtZ616KYCCSK9UdBH8BouhDqybHPs9D
         mWjzBdgsbcBT+Gknq0422ahQdxYNNa53MRfGuF2d1OGNpFXlbV5LWEQ1QSCczZ22dX0o
         ITkw==
X-Gm-Message-State: AOJu0YyaVrM+/EsyBQ6OYU58nd02XRuIUQwcmUWKZPNNeUHmXBhMBpe/
	CwHkKQaATZgA6SDjrjcT6t2VOu7FbIOdd8HhuZE=
X-Google-Smtp-Source: AGHT+IHFMAuY9wP4JZeMq0AGVSNp/s3w+mHEB0XJgEh9v1FVbyJOrTHPgtffWFKIufHuW/WwSLScpnFmGY/VTT9kHXU=
X-Received: by 2002:a9d:5d06:0:b0:6db:d330:b8ca with SMTP id
 b6-20020a9d5d06000000b006dbd330b8camr685486oti.57.1704564084515; Sat, 06 Jan
 2024 10:01:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206151600.26833-1-quic_pintu@quicinc.com>
 <20231208203128.GA2646347-robh@kernel.org> <CAOuPNLg90T69USVQ8Ti6c8fXb_XrnaR035in_CbJHmNMUYLqOg@mail.gmail.com>
 <CAOuPNLj4_pQiAHoER2VJpW_2NEaq8+zF8p1br+tf0Toe1t1UDg@mail.gmail.com>
In-Reply-To: <CAOuPNLj4_pQiAHoER2VJpW_2NEaq8+zF8p1br+tf0Toe1t1UDg@mail.gmail.com>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Sat, 6 Jan 2024 23:31:12 +0530
Message-ID: <CAOuPNLh+V1-Uu_rnnbdu7p6DGjHOJf0yJnaxnchwpzh_YyP=_Q@mail.gmail.com>
Subject: Re: [PATCH] of: reserved_mem: fix error log for reserved mem init failure
To: Rob Herring <robh@kernel.org>, vichy.kuo@gmail.com
Cc: Pintu Kumar <quic_pintu@quicinc.com>, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, frowand.list@gmail.com, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, 14 Dec 2023 at 22:47, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> On Mon, 11 Dec 2023 at 20:13, Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >
> > Hi,
> >
> > On Sat, 9 Dec 2023 at 02:01, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, Dec 06, 2023 at 08:46:00PM +0530, Pintu Kumar wrote:
> > > > During fdt_init_reserved_mem() when __reserved_mem_init_node()
> > > > fail we are using pr_info to print error.
> > > >
> > > > So, if we change the loglevel to 4 (or below), this error
> > > > message will be missed.
> > > >
> > > > Thus, change the pr_info to pr_err for fail case.
> > > >
> > > > Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
> > > > ---
> > > >  drivers/of/of_reserved_mem.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> > > > index 7ec94cfcbddb..473665e76b6f 100644
> > > > --- a/drivers/of/of_reserved_mem.c
> > > > +++ b/drivers/of/of_reserved_mem.c
> > > > @@ -334,7 +334,7 @@ void __init fdt_init_reserved_mem(void)
> > > >               if (err == 0) {
> > > >                       err = __reserved_mem_init_node(rmem);
> > > >                       if (err != 0 && err != -ENOENT) {
> > > > -                             pr_info("node %s compatible matching fail\n",
> > > > +                             pr_err("node %s compatible matching fail\n",
> > >
> > > Isn't the message just wrong. If compatible match fails, we return
> > > ENOENT. The failure here would be from the init function.
> > >
> > Okay.
> > You mean to say, if __reserved_mem_init_node fails with default err
> > (ENOENT) then it may not hit this condition.
> > Instead it will hit the 'else' case which is wrong ?
> > Also, the "initfn" inside "__reserved_mem_init_node" may fail in which
> > case also it may return default err.
> >
> > Maybe, the initial author's intention was to free the memory only if
> > the failure type is not the default ENOENT type.
> >
> > This seems to be a different issue.
> > Can we address this separately in a different patch ?
> >
> > And how do we fix this ?
> > One option is to add another "if" condition with just ENOENT error check ?
> > if (err == -ENOENT) {
> >     pr_err("node %s compatible matching fail\n", rmem->name);
> >     return;
> > }
> > Then, correct the existing log with a different message:
> > pr_err("node %s matching reserved mem not found.\n", rmem->name);
> > Or, add one more "if else" condition ?
> > Or, fix the calling function itself : __reserved_mem_init_node ?
> >
>
> Any further comments on this ?

Any further comments or suggestions on the above ?
Shall we just fix the log message, or correct the if/else case as well ?

