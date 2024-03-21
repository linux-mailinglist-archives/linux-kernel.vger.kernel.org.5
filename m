Return-Path: <linux-kernel+bounces-110646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429C78861B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CAF288229
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C721353F9;
	Thu, 21 Mar 2024 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3eqR5Br"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA03134CF8;
	Thu, 21 Mar 2024 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052993; cv=none; b=i/O+OP1xI/BHmlDIfKMuQQG3UlqfDL6g4m0tQu+41yVmpv76ZJxgUqZ02DJE78GmUncWcfv0JmIHGe3QNtjFLxMeqdk/QJ1TCcfhnS0+l4iAAei9P6dlNlHO/bPiOaQVgv0p0hLFS7VUC2r//dcANkZ/2ZPmHVXfTGSzHZfVKUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052993; c=relaxed/simple;
	bh=2wXA6Ael6yWaRfU8iCscuDKtn9ua3SRp6qM1HO4Qv5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzDBxUMMoRO/gXZto+K5SkhKOj7wVM557A66TtWxMyHW17fKVARa8nUbdnFDghkh4hnZR/gUsZYHn7069WopLU5KY0GbOcZiCJlfmE8hqwbQJmzJHWmaNoExxE28ep0S5SVSt9X6QnPVceYdI0Yy1K/pXZPDKLbNpMcDHhMs4QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3eqR5Br; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7e09ba2ac02so703682241.1;
        Thu, 21 Mar 2024 13:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711052991; x=1711657791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvUundGT9VWuWy9NB7xPMf/jJU0G9U18//kTI/zsuts=;
        b=X3eqR5Br4QqLd5fqP4NQjCJrPpM4Dz7mZJRZM3Sowr6Aa0LrZbkOoRLuUXmL5bbvYe
         8y6WNEMAknK0bqv+P0Wp7+KB5x/EV2GPB0hYQZU/iT7n8br5gotV6GNFj1TksmgozCZB
         GhhiHTMEqd9CXlXADrOtFc02Fm67ZEmiLgwN/KWUuSPGrbuYEVkoOsdlDcDq1P2HKx4I
         BAxSItGGhxhQqxmhyCDqiwHtMVR6aPF9ISbqA4+8wquzHLqanXpQCQMoi02MS0bBKiuM
         QyVD7N+zNOfQGpt926RNZUyK4cOevt3D6L8dlmUWfWZrAI5JB+PPC9JjRgm/OKJdsW5I
         u5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711052991; x=1711657791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvUundGT9VWuWy9NB7xPMf/jJU0G9U18//kTI/zsuts=;
        b=mAFV29ihD1sYzO747klMC8eJv2Bcx5L6gqPQKvHgKlOCvNWkypib5yb0u/xRM3N34I
         yFeOx67aDXG1oJlhU1mpUIqpiwkZadQl3KcGaaTc7sg0d1qZXnP0X5cUYHMUyfR8710f
         Oy9hm5Kzajzvug03EbvrfoOO9i9nQ/y8vAtSKUifyQjNz3s5fENWUm7Wwg/gKrCGBe0d
         o97XCP7wjHuBFhHOHh/h39n7MwTOf8Oq8vBDZmm040Ik/OV6B6KIGSI3GDS147KIbnyS
         /XKhAgDSwb7deqRA0iyf+cCzjDWP5VEsZIGutro1j77/f1CKFItVzK3HcqBkIdQz7ULG
         3flw==
X-Forwarded-Encrypted: i=1; AJvYcCWTRy2VFHpWN7an/aaM6RvqpoAgAUCu0ksS2LkNGMPTVF4OB0OdU2nziaVh1Dh/Q2MSr0OTecEEd7ZeSMWE5UofFF3FiWD7wOy628CrZ9xgoEs7+MYklc06rTWLB1KWxoVnszdIYiKmxU/hbFU/d3o88NciWSaB93qymccW/44U9miI
X-Gm-Message-State: AOJu0YwszI1IIYvmrq6FF7i3K2C+TZCGzSm/WeVQLmdlKEoJRfrf6q3K
	6XD//FxZ7Wi0a3rlA0Ik/DKStOkNQkyhh4uPqFrtbl6uIb3kxvdIHVE9mlrBIDv398O3bPawGmf
	nd6XAyqtpC0BOFfIurs7nz3EE53g=
X-Google-Smtp-Source: AGHT+IFxi6JHUIyJzT2arpPtcGKNs+NYm5EYrmCqaoSsqXkLiIcrFBpnt91X3QkQIltUoU3uOAf1GVaoWrpkEKbh5NY=
X-Received: by 2002:a05:6102:dd4:b0:476:b885:4c0 with SMTP id
 e20-20020a0561020dd400b00476b88504c0mr810811vst.23.1711052991024; Thu, 21 Mar
 2024 13:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320001656.10075-1-21cnbao@gmail.com> <20240320124207.0c127947@canb.auug.org.au>
 <CAGsJ_4zpXwVEhsdffoZVBVWiwT4Lw2qEMrW-X92ib=kv=9Yx9g@mail.gmail.com>
 <20240320084919.8e18adb418347feed6bfc8ae@linux-foundation.org>
 <CAGsJ_4y+1HovQ52HPis8NBDqp4-fiGRwehX+NH0New0HoEU5GQ@mail.gmail.com> <fb744859-ba2a-41c9-bcfa-4ea1cb8c036a@sirena.org.uk>
In-Reply-To: <fb744859-ba2a-41c9-bcfa-4ea1cb8c036a@sirena.org.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 22 Mar 2024 09:29:39 +1300
Message-ID: <CAGsJ_4xSj7i-3Y+ALBh8coa=-6CGx19Zh=CPFGJq9hv4MDZZ=Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation: coding-style: ask function-like macros to
 evaluate parameters
To: Mark Brown <broonie@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, corbet@lwn.net, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Chris Zankel <chris@zankel.net>, 
	Huacai Chen <chenhuacai@loongson.cn>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Guenter Roeck <linux@roeck-us.net>, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 12:15=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Thu, Mar 21, 2024 at 07:48:36AM +1300, Barry Song wrote:
> > On Thu, Mar 21, 2024 at 4:49=E2=80=AFAM Andrew Morton <akpm@linux-found=
ation.org> wrote:
>
> > > Stronger than that please.  Just tell people not to use macros in suc=
h
> > > situations.  Always code it in C.
>
> > While I appreciate the consistency of always using "static inline"
> > instead of macros,
> > I've noticed numerous instances of (void) macros throughout the kernel.
>
> ...
>
> > I'm uncertain whether people would find it disconcerting if they comple=
tely
> > deviate from the current approach.
>
> > If you believe it won't pose an issue, I can proceed with v3 to elimina=
te
> > the first option, casting to (void).
>
> It might be worth adding a note somewhere in the file that talks about
> how the coding style document is convering the current state of the art
> but some files might older and not following the current style.  This
> isn't going to be the only thing where there'll be issues like this.


I'm not entirely sure where to add the comment, but at least I can address
this specific case by rewriting it as follows:

diff --git a/Documentation/process/coding-style.rst
b/Documentation/process/coding-style.rst
index 9c7cf7347394..791d333a57fd 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -827,6 +827,22 @@ Macros with multiple statements should be
enclosed in a do - while block:
                                do_this(b, c);          \
                } while (0)

+Function-like macros with unused parameters should be replaced by static
+inline functions to avoid the issue of unused variables:
+
+.. code-block:: c
+
+       static inline void fun(struct foo *foo)
+       {
+       }
+
+For historical reasons, many files still use the cast to (void) to evaluat=
e
+parameters, but this method is not recommended:
+
+.. code-block:: c
+
+       #define macrofun(foo) do { (void) (foo); } while (0)
+
 Things to avoid when using macros:

 1) macros that affect control flow:


Mark, Andrew,
Does it make sense to you?

Thanks
Barry

