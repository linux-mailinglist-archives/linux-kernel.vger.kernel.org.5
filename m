Return-Path: <linux-kernel+bounces-154552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524888ADD80
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E618E1F21EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1C523748;
	Tue, 23 Apr 2024 06:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4gkREO3"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CEA288DB;
	Tue, 23 Apr 2024 06:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713853711; cv=none; b=QBUz5r40KIZ/Co1wA10GTxcistgO7dDFmsTzzpXMC7Fgt4U5KnNCS9JtyaqmlPV4G+dkovk5vZ51KhnJBX/pVlrpQb36gJ6bfclh9d90wR9dgPdUNoakDVs9P5LukjrqiXEidCFv+X7nxEhrKCU/z3VPH+RzGt8OuVQXuvgjtJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713853711; c=relaxed/simple;
	bh=RH3seyAGfFPN3Z3rV3vpTCGAc0jmROThGRyFEPOs0fY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfbZl1uV2CuGYYfzJGxBR0KucXTOgyDe+z3Te7jMuq0EslahgnO49IraK2I4jHnYUhegjECSbEnGUxsKMsmMWfubl1aCZJUAvXrsy3bWdLy5RO1fER/yKgYmL2mUhR2wWljMReG7LAOdiOUujHN48Jwl95V9IHhownumVaB+6iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4gkREO3; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6eb86b69e65so3140868a34.3;
        Mon, 22 Apr 2024 23:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713853709; x=1714458509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vf4nYaIAsDBcjabT8ATdtFaulkvwKXK93mDR85Qldw=;
        b=P4gkREO3to1qkuaplsTk+3hYYw3aPzJYKeQo+b//+qnUOL5LT09P0WIQBS5+vD7g5B
         jp3QqiEAfh9y4Um/H46yFDJR2bouOK7a2qXbkzoj4fERL5FZaoEAp/r43k0hFf9zMbrJ
         GY+95qMATgptfdfE5BsTXlOM2mxy2Gw9BEpLqFzwbZaWRkv3/TWFjGeiDM4TrJLyVpKp
         VXn8NT3SCBl6hQGbm5A2hqXsM7e3OdCqnXb/iywnVuTON4nUXKQSTqBx56oDo1102WJo
         gUsglCzAeKAz2c6SSn2niDo5KzzhB5rvbE3VcFQlmHuXgAQBgmMcql8LBffljABreBzR
         +a5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713853709; x=1714458509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vf4nYaIAsDBcjabT8ATdtFaulkvwKXK93mDR85Qldw=;
        b=FAQQd58bzUzb/R4k+CWmpIcPdq/8N8H5d8ee3IPxZBZk3u7XDrsFKbN6Ao2MwHmHjc
         wGyFKw+rAtqs5+OBTjb1k7yXw/Y/TUTcaL/x0SR0rfZS6/AYe44OEYj4Gw6HolSr7515
         fzmRo1dpOBm9+D+tyJt+8fGdcWoN2qpV1hXml02QSf7Xf8pgSlB99iDzI/dPolrbjvE9
         UmmSs2zCz6y83yYhww71H9gF8Hep4RYyTAjnrZ4UHxpy+C8QaujS0SH4tEPjmL82GVSS
         0oY2AFk1UrxdOFHuJio6NUu71Poc6/fWwXmWwBrJDDF1XkNMMfLFDPFxaP2C01VCC0/6
         bwfg==
X-Forwarded-Encrypted: i=1; AJvYcCULKYVuQzvrnBwJxK31q5pnyBINQn8E08pgsvp70Xlqp6GJjoQrCZ0R1kcSJI2dPMwBKtFLABs40r7nXpYWEHm4X1QHUgik1rsCxijKKJutyp7wzn33/FJWtAX/R1s47qotEoY7PXQ=
X-Gm-Message-State: AOJu0Yw0k2RBaBL2kzaTklEDGBHKLJSwURRdu64I2XukEtb/czscnO0C
	2v6yRrxs8wco1xzcK5o4Q76NgA81/0yMEH7b8YwvbaofEkzlkc5TvklNpbifyDIkMbDq86cnycV
	10cXfpqBBs/hoJpKBmTjgdgz6wVs=
X-Google-Smtp-Source: AGHT+IHaoOz81cM8ZgYwCcdxP+mHIRu4dpEwXHfWhSWaZ015706PToTI3XgPgElilbHdEWRXiAb4Nf0V1X5yJDKNKuo=
X-Received: by 2002:a05:6358:5e83:b0:18a:5c27:7032 with SMTP id
 z3-20020a0563585e8300b0018a5c277032mr15515881rwn.13.1713853709291; Mon, 22
 Apr 2024 23:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <285de20a187f3e4baeb28f639b5bf55e914a3821.1713756666.git.viresh.kumar@linaro.org>
 <CAGRGNgWHkVkOP13jh-w1KQYeR_yeq1JgOt9a+R40F8DGYKMtkg@mail.gmail.com> <20240423061253.blyfuqasyiatm5sa@vireshk-i7>
In-Reply-To: <20240423061253.blyfuqasyiatm5sa@vireshk-i7>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 23 Apr 2024 16:28:17 +1000
Message-ID: <CAGRGNgWH7PW4fgMOYtEVohrPq0MVusKFOpF8GXCbMDA5D7BScA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: sun50i: Fix build warning around snprint()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Yangtao Li <tiny.windzz@gmail.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, kernel test robot <lkp@intel.com>, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Tue, Apr 23, 2024 at 4:12=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 23-04-24, 11:38, Julian Calaby wrote:
> > On Mon, Apr 22, 2024 at 1:31=E2=80=AFPM Viresh Kumar <viresh.kumar@lina=
ro.org> wrote:
> > > diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq=
/sun50i-cpufreq-nvmem.c
> > > index 30e5c337611c..cd50cea16a87 100644
> > > --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > > @@ -208,7 +206,7 @@ static int sun50i_cpufreq_get_efuse(void)
> > >  static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
> > >  {
> > >         int *opp_tokens;
> > > -       char name[MAX_NAME_LEN];
> > > +       char name[] =3D "speedXXXXXXXXXXX"; /* Integers can take 11 c=
hars max */
> >
> > Would it make sense to just set a static length for the string here,
> > say 17-20 characters and add a comment explaining the number, say: /*
> > "speed" + 11 chars for the int */
> >
> > The string constant, while it'll probably be optimised away, seems
> > weird and wasteful.
>
> The counting goes wrong (I have done it in the past) sometimes and so
> I like to explicitly reserve space like this, it also makes it look
> cleaner, i.e. how the eventual string will be named.

I completely agree - ultimately it's whatever works and either way
works equally well.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

