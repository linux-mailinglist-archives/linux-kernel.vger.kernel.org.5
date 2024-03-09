Return-Path: <linux-kernel+bounces-97775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91066876F41
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 06:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F521C20B2A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 05:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882A32D604;
	Sat,  9 Mar 2024 05:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWjoNmev"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3941C6AD;
	Sat,  9 Mar 2024 05:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709960908; cv=none; b=PoRGdIZnEjCdfJLf6Dz3SxmMRyBB3VHOAze2h+t6iwzq9Y9WSUZfu1zuwrbP/aIp0TVmBsuuTz4ZpqnY8zrOMdA4Vh7tzEPKFXsMoWK2MA2m1M/r38aHEBy+NcnIW/DHk1nUqrsbf7wgP961ggnjf04aD8VlDYs8YddkTK3P55k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709960908; c=relaxed/simple;
	bh=TyQDeia3/fwrZ+mismUACXsOv3nfAHZTSyRsrbLpCcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfFPnJMm4m3HkvoZxq2UPiDlFBsXM5wlz8AVTiTWoKgCBO1aIMUmF1J7UjJNlSkkON/AUGa+cOj+hEBHfof/YulvdyXdOlY/FbARPnKz7Tw7w6tyfG9vxUr/boDQLWFvZ0il2eO8117tWvj/xiroeoJjiur/NYCN2ZNgRfaDV2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWjoNmev; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7db797c5c93so847498241.0;
        Fri, 08 Mar 2024 21:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709960906; x=1710565706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3Ne36dcKUp5dKO89MEhMA2kgBQTra2ujtbNnpNKHJ4=;
        b=HWjoNmevWcwnuX+13CjJ8e94Lo3/F63U8RhKBy34TS/W/NByX3EZV3lRgqaT2lTaCS
         IanRfQy7Qogu54znoVhLhTqjZYTzoqbGod/Ux7t2EuA30ShiZW1xiF+PO0ymQrpSLFu1
         gHx1o2Ef7nYvMy+PcdHO8j7s1EGi3+9jTdn/toR1pX1eg6BXd5lSmf5+ADSHYQWedmve
         DZr/bKU+UDOmr6j2vNYhLnztC1NYcmi5fEYaeRg6BPFJydpommP9bXENfsEMJNECtqdv
         ELlv2Ew0JQF2O+zPoEYNg/841WMRJ5i6M1yAAzk6yPFfp17E/n222F2IVegZQXOOjTUx
         KqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709960906; x=1710565706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3Ne36dcKUp5dKO89MEhMA2kgBQTra2ujtbNnpNKHJ4=;
        b=BconNgpMBlfZ4cA2SIkLzSFC+6Gc8fXBg3ehBCAWaoBY1d1GRA0NTYVoX0cuygTy61
         Y1YVtKgIkIZbBJlG7w4xft+5fcUUW8PHx2i6jA5bj8VcAUUgmMvk757HCu7krCDFdkS6
         kTq89QNXBCL7l1qBtVdSGRX5aagXwYHD+o+wAzSd/WXV/IfYkl3JJrWhxjkaYzb7YznN
         Attq73rwxjK12YBxK+pgo+aRyxjl/jhUkpVJ37eazuRVYxKKjDNoBmj9YLMI1pl+KHwc
         syWYHBvalMwlVpKcvPzxBJeGjLcFLWvziNCaV4j+qcxBrPnCEE7pWGBID11PBQoE9FzH
         BqTw==
X-Forwarded-Encrypted: i=1; AJvYcCUaKtVYZjWS9ZBZo1X269y5oqMbeq3mmpnDVyClIXlSlHb0JXAjDWWPFz0Yexe+d/U9MiXRxSxwKPUnEETbH1yL6CFQhI5BCzzJKwgbUVZEFyJQXjiCLoQ2WFQA/iMl+hFu24wTC3X2JbrD
X-Gm-Message-State: AOJu0Yy1Sx2BrbmVNxyvd9tLVA1/VQsYREkIRn0npZ9Zihb60ZghBVXt
	tR/kOHiuSHVWTHcwGLiEO6x+YNH82P9YOVeHzd5UVeqgJqHjNvkUHCpHhfK2j1ktegtagAKExvM
	IeGa6El7/kC3zwmPbkR5BBMFjF14=
X-Google-Smtp-Source: AGHT+IG7/pySYCmBlupSm8NrazejiIUUebLfJGUmtfsFXcoXvUFaBM12ciZAsVZJVELPx7TmORBqRHwUVLzXxhjowbY=
X-Received: by 2002:a05:6122:421c:b0:4d3:9a8d:c736 with SMTP id
 cm28-20020a056122421c00b004d39a8dc736mr1045077vkb.8.1709960906120; Fri, 08
 Mar 2024 21:08:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222081135.173040-1-21cnbao@gmail.com> <CAGsJ_4wMGNDcgc3pqSUicYoH7Z_miczkT=uwZU+yhDF0fd57Rg@mail.gmail.com>
 <20240308192334.845b27504a663ec8af4f2aad@linux-foundation.org>
 <CAGsJ_4xSwNZmHN5GvipS-1kELX2NBwHxoGE=aG4sekm1LcYVPw@mail.gmail.com>
 <20240308203641.7fbe7e939b3483bd83b9769d@linux-foundation.org>
 <20240308204251.43d7e518ba95fb4ce22f8d4d@linux-foundation.org> <CAGsJ_4xYUSdEV4N8i3KqNL+dz2kWx3JWgqtMypk0KW539M4SVQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4xYUSdEV4N8i3KqNL+dz2kWx3JWgqtMypk0KW539M4SVQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 9 Mar 2024 13:08:14 +0800
Message-ID: <CAGsJ_4zRM1Epk-OqRmm6ZfB_FA1TyNBtOA=soz_5cZB=_CsrgA@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] zswap: remove the memcpy if acomp is not sleepable
To: Andrew Morton <akpm@linux-foundation.org>
Cc: herbert@gondor.apana.org.au, chriscli@google.com, chrisl@kernel.org, 
	ddstreet@ieee.org, linux-kernel@vger.kernel.org, sjenning@redhat.com, 
	vitaly.wool@konsulko.com, Barry Song <v-songbaohua@oppo.com>, davem@davemloft.net, 
	hannes@cmpxchg.org, linux-crypto@vger.kernel.org, linux-mm@kvack.org, 
	zhouchengming@bytedance.com, nphamcs@gmail.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 12:56=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Sat, Mar 9, 2024 at 12:42=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Fri, 8 Mar 2024 20:36:41 -0800 Andrew Morton <akpm@linux-foundation.=
org> wrote:
> >
> > > > Okay, I understand. Since this patch improves zswap's performance, =
I wanted
> > > > it to be integrated sooner to contribute. However, I'm perfectly wi=
lling to
> > > > respect your concerns and adhere to the community's best practices.
> > > >
> > >
> > > OK.  I very much doubt if anyone is running those drivers on mm.git, =
so
> > > adding it now isn't likely to hurt.
> > >
> > > So I'll merge it now and shall aim to get it upstream very late in th=
e
> > > next merge window.
> >
> > Nope.  mm.git won't build without acomp_is_async().
> >
> > We can merge the zswap patch via the crypto tree.  Acked-by: me.
>
> Herbert Acked the acomp_is_async() patch in v5 instead of picking it up
> into crypto:
> https://lore.kernel.org/linux-mm/ZdWKz43tTz2XY4ca@gondor.apana.org.au/

More details: Herbert acked the acomp_is_async in v5 [1], while he requeste=
d
that patch 3/3 of v5 be split from the series and applied by crypto
[2]. Patch 3/3
of v5 can function independently of 1/3 and 2/3, and it has already
been included
in the crypto tree.

That is why v6 has only two left.

[1] https://lore.kernel.org/linux-mm/ZdWKz43tTz2XY4ca@gondor.apana.org.au/
[2] https://lore.kernel.org/linux-mm/ZdWLim6zYSl%2Fx1Bk@gondor.apana.org.au=
/


>
> >
> > Or please just resend the zswap change after 6.9-rc1 is released.

Thanks
Barry

