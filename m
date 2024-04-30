Return-Path: <linux-kernel+bounces-163810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FCA8B7179
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE92B1F23BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDA412C462;
	Tue, 30 Apr 2024 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3ASAVSY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2DF12CD9C;
	Tue, 30 Apr 2024 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474610; cv=none; b=nPIMSNDoRkSFnEMSWejIq5/RqEEVHkvZgkW3+O954x+QoO8E/9B35ey0g8uuOxi+lLINgB/JvyHUnTbcFtYOhkTThLb0I4u1pH0b+vEAL37z6khz35o2lGrsuEnJPx0mDsN+6GjcC/cYvEYOhMbS3NZbP2OLo5AC3xMj+PzyK20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474610; c=relaxed/simple;
	bh=XAH33yItVNqMlyo9RZ7ksSTi00wu8F/Jv+D4lOiPKCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVTEWcl8OA/RzQSzjOhtWgS85gSb/Q4SpyjvvOKaUds8ZotsaRLLI1jlsJDiAdxrafmCYZQrt0oc0Jnudt99tG4PBIUr3xuc2NfgHD/BWJR6MRCVBNsQ237hTRlTqgqrlxRqCX82NIYD3xRfdGF0iZCiolVinKBdmSMOQD2wRCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3ASAVSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7320AC4AF19;
	Tue, 30 Apr 2024 10:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714474610;
	bh=XAH33yItVNqMlyo9RZ7ksSTi00wu8F/Jv+D4lOiPKCk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V3ASAVSYicyK5nfyCymotydUKFKGVuUJjCwjICmIY+VpspXrUkr/5M4Nxn1lXT72D
	 8Hlr+DGUxnKNFyWHtEThB6tserhhMxpde0HWSFPr32Mhm9FML7wYlFct8spGHdZ5FH
	 QSXEhvOCY/6Fo/3Y1C1RT66tUWoOWq82Wde/siwNEgc7+diB2inyg1uXnaP6z1lhdb
	 5irBkrAOE1QnPuB6SGB8F4QihsTnLCyqccQxrtLX1vLrgeF8+3tsMUIfX7kmzPXCNN
	 ZEKHa5v4gUCI1Qm7eKObSoYd70IJc52W9Cqi3giC5fUSymb5W/GhGBgwJJF5YLsbuV
	 z2gBSfzbht1ig==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5afbeaa1ea5so70597eaf.1;
        Tue, 30 Apr 2024 03:56:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXd0lWWXcWXjFjO1qlAT4AlGu/9AnHsltZLvEA4zY2yNu/VrNsb+NVqj5KByiHzXkxSSCnu0FfRXiFUkINXC9OsMm8Yg1ZPP7GKBmEG
X-Gm-Message-State: AOJu0YxlFICr9evt9bWvXRP5XbXyVKmYP9e9pphW7okbUStMInNPswA/
	/YfQ4+ItemFtEI9M0DtZEKCel4xuaV63NbVv9paONrznHaAgaS6mDTIAqwjgZ2s397GqCEx2EbW
	oSOloJ4+XvJ/Ypzc8+TmtByHekx0=
X-Google-Smtp-Source: AGHT+IG/ATavJMauk9VS+AAEjHpqla4Ht7foM/WvE7r/lGTMYiYc06vw/2hj12m0FE1ZT+BKyOW1r08qIIsrKFYBYwM=
X-Received: by 2002:a4a:ba07:0:b0:5aa:14ff:4128 with SMTP id
 b7-20020a4aba07000000b005aa14ff4128mr13779046oop.1.1714474609646; Tue, 30 Apr
 2024 03:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425110017.75238-1-joshua.yeong@starfivetech.com> <20240429032146.2d3t7bai7k6cotqt@vireshk-i7>
In-Reply-To: <20240429032146.2d3t7bai7k6cotqt@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Apr 2024 12:56:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iY9CQPRWub_Mk3LyZX_41Y_L4Gjm302X=GjcnhRiu1vw@mail.gmail.com>
Message-ID: <CAJZ5v0iY9CQPRWub_Mk3LyZX_41Y_L4Gjm302X=GjcnhRiu1vw@mail.gmail.com>
Subject: Re: cpufreq: Fix printing large cpu and cpufreq number
To: Viresh Kumar <viresh.kumar@linaro.org>, Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 5:21=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 25-04-24, 19:00, Joshua Yeong wrote:
> > Fix printing negative number when CPU frequency
> > with large number.
> >
> > Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> > ---
> >  drivers/cpufreq/freq_table.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.=
c
> > index c17dc51a5a02..9b9568023f3c 100644
> > --- a/drivers/cpufreq/freq_table.c
> > +++ b/drivers/cpufreq/freq_table.c
> > @@ -194,7 +194,7 @@ int cpufreq_table_index_unsorted(struct cpufreq_pol=
icy *policy,
> >       }
> >       if (optimal.driver_data > i) {
> >               if (suboptimal.driver_data > i) {
> > -                     WARN(1, "Invalid frequency table: %d\n", policy->=
cpu);
> > +                     WARN(1, "Invalid frequency table: %u\n", policy->=
cpu);
> >                       return 0;
> >               }
> >
> > @@ -254,7 +254,7 @@ static ssize_t show_available_freqs(struct cpufreq_=
policy *policy, char *buf,
> >               if (show_boost ^ (pos->flags & CPUFREQ_BOOST_FREQ))
> >                       continue;
> >
> > -             count +=3D sprintf(&buf[count], "%d ", pos->frequency);
> > +             count +=3D sprintf(&buf[count], "%u ", pos->frequency);
> >       }
> >       count +=3D sprintf(&buf[count], "\n");
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> --

Applied as 6.10 material with edited subject and changelog, thanks!

