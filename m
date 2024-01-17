Return-Path: <linux-kernel+bounces-29269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66E1830BE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05EDFB22335
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39922263E;
	Wed, 17 Jan 2024 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlAHJZfN"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFE122618;
	Wed, 17 Jan 2024 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705512346; cv=none; b=ZtkrC5k4KMJlLy7nDyhdSo57SQUMgaN/d0EQV5uQBS75cqC2Jcw+tvkDTIg36/3DCyPbFBqweEDnNcHIX6nYcut1Eq8FqEGdD38xf4h9840sqMqwejlxbV6Bx4gfJqOgQ359NMy2pfYUzOowomBRQ+lPx0FQvKMsWeRBVvip01w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705512346; c=relaxed/simple;
	bh=26W2fi/I3gYEO5TQsqjCR4QzAvNJBWa6WX4V8X+dIgk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=sFwXtHGa6gwQvantABuC3a/Wq38OluAcpzpWeh+Z1iREQJmATMf151GQ629Ky5RTiGUHejus5V4bay+m7cCOrPqBkZWQWmHSM5yrqCNAk8zH2Sokx27chDeruH10HnV2BtrnTkGfUO8aa2uy0tHozoXlVrSeXRk3/zcKW3Mbf8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlAHJZfN; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-467021612acso2656175137.1;
        Wed, 17 Jan 2024 09:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705512343; x=1706117143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BjzH4P7XF/Z7lgo69jkWio9jEYkRlOZwcG6M8wtf1ZM=;
        b=ZlAHJZfN/8Ly8qgur7EhCccEh+HaKwUtBAbANPk0FKyelqbWci0N+p0L3eWecuZ4e9
         gQfbk0UhPrAWcmQ23rpYnHF53rFR+bzif8oVAShYX7ZljFwbKu96omziIWu34pcXK9Bb
         NfdMiWYRN6fOe3IzmlqWaJuzaDUiYMBUdbHUkNx7uFTmp6EoKDW/KqCba0Quhg+Tya4C
         BkMmNwpmJPRRmX+QQiN+GU3a2hkq9g9u3zc1V0ra7Z3eQUQq/taI5tBNejMTctz17VYG
         /D1MebiSP95ux7bQmHuLD9LI+WdPu3cfmnmsJc4ziaHLyUxmC0/V68F3mxvpNkt+30cQ
         +XOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705512343; x=1706117143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjzH4P7XF/Z7lgo69jkWio9jEYkRlOZwcG6M8wtf1ZM=;
        b=IjQfOWiYszUFB0IvaGlRKfHrcLHSq4J6ocVOoOIIkzI3n8Yr+ppykdOp17IBz4NDDR
         PzkH2GG6zEV7T5hqnKaxynikiGCK1hNHvTBdt/n+wiFk5QT0Ptzsx50a73JXKyzpoCt5
         FFlpKRIVutpptgticBeTmsMUM3TZwcF3/Ol1qOCKemme2BQJL5Iot3c9pUXA0Ge3/L6P
         dON7hRwY+2q5InW8a7lemgHPcYa3rk6eMIX70cop8cd0NJpESSXoegaENgeYhEVJtcnz
         A0TgjCh7vl0p6GnECMhOO2yz/k1ZN+1bna9sLbJSxjTXvmCaQJxZxyK7/a+IePmUannh
         4tng==
X-Gm-Message-State: AOJu0YwymkoAW2xdo0mwkIXxXrCxbwavb/h2iZWrZYq8xVoKp2KaL0Cp
	u6gowBvqfSfCCJXO5TogbQu0Ygd0g2RMRj9PQzs=
X-Google-Smtp-Source: AGHT+IHq2zmeg53TSnmQvoQ4CfpCRPj7LsRflcF7R5XS39w1ctG2Sfnn2AAL0JKpj3eArMWXOfHc1CHAO8iBUqCdSU8=
X-Received: by 2002:a67:fc47:0:b0:469:7c82:fcaf with SMTP id
 p7-20020a67fc47000000b004697c82fcafmr1972649vsq.12.1705512342916; Wed, 17 Jan
 2024 09:25:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206151600.26833-1-quic_pintu@quicinc.com>
 <20231208203128.GA2646347-robh@kernel.org> <CAOuPNLg90T69USVQ8Ti6c8fXb_XrnaR035in_CbJHmNMUYLqOg@mail.gmail.com>
 <CAOuPNLj4_pQiAHoER2VJpW_2NEaq8+zF8p1br+tf0Toe1t1UDg@mail.gmail.com>
 <CAOuPNLh+V1-Uu_rnnbdu7p6DGjHOJf0yJnaxnchwpzh_YyP=_Q@mail.gmail.com> <20240116143509.GA3845101-robh@kernel.org>
In-Reply-To: <20240116143509.GA3845101-robh@kernel.org>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Wed, 17 Jan 2024 22:55:31 +0530
Message-ID: <CAOuPNLhc-U8YzkUAE2aDPUKAhzgXtTTWUC8faU=a62na2gdF_g@mail.gmail.com>
Subject: Re: [PATCH] of: reserved_mem: fix error log for reserved mem init failure
To: Rob Herring <robh@kernel.org>
Cc: vichy.kuo@gmail.com, Pintu Kumar <quic_pintu@quicinc.com>, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	frowand.list@gmail.com, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jan 2024 at 20:05, Rob Herring <robh@kernel.org> wrote:
>
> On Sat, Jan 06, 2024 at 11:31:12PM +0530, Pintu Agarwal wrote:
> > Hi,
> >
> > On Thu, 14 Dec 2023 at 22:47, Pintu Agarwal <pintu.ping@gmail.com> wrote:
> > >
> > > On Mon, 11 Dec 2023 at 20:13, Pintu Agarwal <pintu.ping@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Sat, 9 Dec 2023 at 02:01, Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Wed, Dec 06, 2023 at 08:46:00PM +0530, Pintu Kumar wrote:
> > > > > > During fdt_init_reserved_mem() when __reserved_mem_init_node()
> > > > > > fail we are using pr_info to print error.
> > > > > >
> > > > > > So, if we change the loglevel to 4 (or below), this error
> > > > > > message will be missed.
> > > > > >
> > > > > > Thus, change the pr_info to pr_err for fail case.
> > > > > >
> > > > > > Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
> > > > > > ---
> > > > > >  drivers/of/of_reserved_mem.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> > > > > > index 7ec94cfcbddb..473665e76b6f 100644
> > > > > > --- a/drivers/of/of_reserved_mem.c
> > > > > > +++ b/drivers/of/of_reserved_mem.c
> > > > > > @@ -334,7 +334,7 @@ void __init fdt_init_reserved_mem(void)
> > > > > >               if (err == 0) {
> > > > > >                       err = __reserved_mem_init_node(rmem);
> > > > > >                       if (err != 0 && err != -ENOENT) {
> > > > > > -                             pr_info("node %s compatible matching fail\n",
> > > > > > +                             pr_err("node %s compatible matching fail\n",
> > > > >
> > > > > Isn't the message just wrong. If compatible match fails, we return
> > > > > ENOENT. The failure here would be from the init function.
> > > > >
> > > > Okay.
> > > > You mean to say, if __reserved_mem_init_node fails with default err
> > > > (ENOENT) then it may not hit this condition.
> > > > Instead it will hit the 'else' case which is wrong ?
> > > > Also, the "initfn" inside "__reserved_mem_init_node" may fail in which
> > > > case also it may return default err.
> > > >
> > > > Maybe, the initial author's intention was to free the memory only if
> > > > the failure type is not the default ENOENT type.
> > > >
> > > > This seems to be a different issue.
> > > > Can we address this separately in a different patch ?
> > > >
> > > > And how do we fix this ?
> > > > One option is to add another "if" condition with just ENOENT error check ?
> > > > if (err == -ENOENT) {
> > > >     pr_err("node %s compatible matching fail\n", rmem->name);
> > > >     return;
> > > > }
> > > > Then, correct the existing log with a different message:
> > > > pr_err("node %s matching reserved mem not found.\n", rmem->name);
> > > > Or, add one more "if else" condition ?
> > > > Or, fix the calling function itself : __reserved_mem_init_node ?
> > > >
> > >
> > > Any further comments on this ?
> >
> > Any further comments or suggestions on the above ?
> > Shall we just fix the log message, or correct the if/else case as well ?
>
> It looked to me like the original author's intent was this is not an
> error. Either convince me otherwise or wait for me to study this
> further. This code gets a lot of drive-by patches and what is "correct"
> isn't always clear.
>
Thank you so much for looking into this.
Yes, I agree that the author's intention might be to present this as
an info message to the user.
But I think he might have not realised that info msg may not be printed always.
If we change loglevel to 4 (quiet) this info msg may be missed.
Normally, in the final production system we do this.
So, ideally, I think, error msg logging is more suitable in either case.

Sure, I will wait for your further findings.
I will also have a further look and see if I can convince you more
with another set :)

Thanks,
Pintu

