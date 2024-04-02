Return-Path: <linux-kernel+bounces-128662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3C4895DDC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F2728B9B9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B02D15DBCE;
	Tue,  2 Apr 2024 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+84mNRH"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BF656B9F;
	Tue,  2 Apr 2024 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712090182; cv=none; b=M1B7Cg+4Ds9281zBV3krGTKQYvi5+14Qhybj0CJFsOLvkoxnM+gER7aMrSziZeKmVtCnVYtL5o/2TcSFnRC8I95z8mTWHcoJxeC/zF/APD4mOA2sL9xgifmswL9I9ejJ86os6lINWcGEzOXMh4Eux7KLwWyO1rfKoExmB5qJ60Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712090182; c=relaxed/simple;
	bh=pu/dtKESlMLWjPNUU+kDrCkePPMwceLQft9I+MF7CBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVjLHZqn0qqQvifdNEdzJXW2jx6gac5IgPp0Mun6vo2LZG1AcdGvN+sJ3vs9GZi4gSL/o/dO0w2/rtGWqmpS3ZY3gQswKW2Dzw5GpUqGLDPPShuvblOaIaiYmW5TIqrLbpIAbyZ0D40KlQyXmm8EUgnlzptpXxxzIwWaY6lWK8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+84mNRH; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e89c87a72eso1888754a34.0;
        Tue, 02 Apr 2024 13:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712090180; x=1712694980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c62HqBKZ9JFuv72U/KX7IUtAQ2RBkr0nXwJORv/Egrw=;
        b=Y+84mNRHks5FEN9SYQfEXE5fji9Mfs/LP9Uhr8cVUkP1udJcd4JBCNuX1MyqFddbHh
         FS1oLt/R/yVnR+RbIwPXCiAxROx9Tp4+DZCNLZNZ9PAMdQiPw8LnJeZXth0C07IFr/2z
         j91yVnbE4EGUDPUVccPMPcxsNDO0vYeegL+OKheR+jOSQPM2tAt55sgleFzt1n7yaB/Q
         fAKMqrAw8P/Yj6zOT9GGt6HIHHUtyhHw+R7HZ4+POmwdbmzFj6r5uljokUe18L4O/Fod
         FYNTLeu3w7DOQqlRIxA0OGn4HyA3uet8M+V9Y30PzANhoqTR+hasBzT95PzhhOr4TV2d
         D8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712090180; x=1712694980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c62HqBKZ9JFuv72U/KX7IUtAQ2RBkr0nXwJORv/Egrw=;
        b=HAsR2uXePSZ6f+k2Ussb8DlGL68KKnAr3rE+zw3cXLNH12xw+Ri21psWEG/B8JOz/w
         dy8K36D9r2oMPzPHy9HjHlOWNN341zR/leORY5pnPJOdON6y+mBF34L3EClyH7UTK575
         6+kU4Z5kK4u9+l0nML1Gkph80tqUmOyDRbk96+JrlG6m4kGL8Irfk8Mrj0a7jHyriuVK
         1SZKQX/pXQnILMONm0QOu1vo4IOPsiRJFtxthJ/ieuqR0skyQ14fyTNJ2B/SX7tfUH2w
         klx2Wj56DzhbqjZW9cpYJ+MCJCgZHkrjO5WOzkE0s0wNcZtxSsOKO7B75EgiW/Y5KvE1
         aHLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiFKr/cjUq0yLH+dZFkY6PGf+zQk9eVH/OHuaaR1iE+WLKUAixTO/t6oZVt7Pa0TFQ50goYNg9Usi2T5TnN8zL6zveq4Yah+omdqmr
X-Gm-Message-State: AOJu0YzGNgRufe2pao2hHqCRsxc73wAizOw8Jb84wZ2HC1CqhyLl9ZTo
	YCU54d2EjFPnnXwmzeilpzvdXBTvOBTZvdrDY3JGpFQAMzRaHlOTLTI0ezWYcf/C7zY4RFEBfx8
	P+QLudtlefNT3K/ZHbIJ88LwoMz3gU7n3
X-Google-Smtp-Source: AGHT+IH/CM92Bu9nZ42Px1Quy/S+88iEki0V1wnAuYDP7sgJL6PMkgTZ/OiwVlavGWTgMTHVQMVeRmN9zvmXPNIfGp0=
X-Received: by 2002:a05:6830:3445:b0:6e6:bd65:d485 with SMTP id
 b5-20020a056830344500b006e6bd65d485mr13293740otu.16.1712090179932; Tue, 02
 Apr 2024 13:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226135243.1393780-1-masahiroy@kernel.org>
 <20231226135243.1393780-6-masahiroy@kernel.org> <CAOCHtYiCcxssYNvPwq5RoSv30+hkWOJD4=uRaGQmatOdJR9n0A@mail.gmail.com>
In-Reply-To: <CAOCHtYiCcxssYNvPwq5RoSv30+hkWOJD4=uRaGQmatOdJR9n0A@mail.gmail.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Tue, 2 Apr 2024 15:35:53 -0500
Message-ID: <CAOCHtYhkenjeC_PUZYBQde5Cb9U+qfGFWNVVGeji7CowbxXS_w@mail.gmail.com>
Subject: Re: [PATCH 6/6] kbuild: deb-pkg: use more debhelper commands in builddeb
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>, 
	Nicolas Schier <n.schier@avm.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +++ b/scripts/package/mkdebian
> > @@ -193,7 +193,7 @@ Section: kernel
> >  Priority: optional
> >  Maintainer: $maintainer
> >  Rules-Requires-Root: no
> > -Build-Depends: debhelper
> > +Build-Depends: debhelper-compat (= 12)
>
> make ARCH=arm  CROSS_COMPILE=  bindeb-pkg
>
> I'm seeing a fun issue with Ubuntu 24.04 (Noble)... 13.14.1ubuntu5:
> https://launchpad.net/ubuntu/+source/debhelper
>
> dpkg-buildpackage --build=binary --no-pre-clean --unsigned-changes
> -R'make -f debian/rules' -j1 -a$(cat debian/arch)
> dpkg-buildpackage: info: source package linux-upstream
> dpkg-buildpackage: info: source version 1noble
> dpkg-buildpackage: info: source distribution noble
> dpkg-buildpackage: info: source changed by rcn-ee <robertcnelson@gmail.com>
>  dpkg-source --before-build .
> dpkg-buildpackage: info: host architecture armhf
> dpkg-checkbuilddeps: error: Unmet build dependencies: debhelper-compat (= 12)
> dpkg-buildpackage: warning: build dependencies/conflicts unsatisfied; aborting
> dpkg-buildpackage: warning: (Use -d flag to override.)

Sorry for the noise, this looks to be a time32 related issue in
Ubuntu's armhf Vs, arm64... As my arm64 Noble schroot just finished
it's version of v6.9.0-rc2 package with no issues..

Regards,

-- 
Robert Nelson
https://rcn-ee.com/

