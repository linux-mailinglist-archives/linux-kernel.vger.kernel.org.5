Return-Path: <linux-kernel+bounces-63487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C153E853046
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC558B2377D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E783FE47;
	Tue, 13 Feb 2024 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6CdSnP1"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1983B3FB06
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826326; cv=none; b=ijODj4ciFpcBdCL7+DsnHsqFAZ2szJRclSyW3j6oqrdWCGu8fKHiC1MKDtQNr/UJAnQfp+Mdlknav1YpkqFlyx+7TBX5A0Px4BVifMz7QXqu7bTlB4voH8jabVPF3Xm0H1eYtydIk6uolx702adb70tZPOHX7Q18kOJY4yEU6J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826326; c=relaxed/simple;
	bh=bRjvQQ59r2pfSvCpuOfK4WkAjhBTBaeJfQZn4iu1nyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJMKS+AUtJu36NtGoJNKBOKJRt1rJFYrPsBzv0mYbIh1nR0oFnqSzC8XrWGlwFmjuvqyfNoUTTnmY7i4wWKb2XK2fz5va4fMQxSW5wgfVuxNdCHdJDdypM+bZ1yQh+gsrf50YYhL2YHdn/ptZzn6xYWOlglDUolcawsHFgFPZL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6CdSnP1; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc7472aa206so3579725276.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 04:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707826324; x=1708431124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRjvQQ59r2pfSvCpuOfK4WkAjhBTBaeJfQZn4iu1nyA=;
        b=F6CdSnP1JDO/J39eniZxBRSFVY33qlf+Toh+BaaYrba7s8U8ggyomVxxvotWerfkSK
         U8UehxJb0880PMoNrr76ArtkFvSV8eoWO1sVUInoU2mQNJkbuf+Ts1KQnlmP2BikRYEP
         MMT6EQ51J+Bv0sPtOMFlZgA2UMgrGsIZXu0IQx4vE3emVO48jfMtlwE/a3gpXUa5AAEp
         Cb8zsz+2nHCdc5SkM8+975Ciy/FmfKCWL8so3V0MEDSxFWuep/tp6uGeMyBjybJNzN9O
         tAy8tF8s3xmhKSfYpn+dWuSPTtcuHFWw4mJhcK8d8PY+ItW2cny830ew4ykIiIsx40y0
         z/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707826324; x=1708431124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRjvQQ59r2pfSvCpuOfK4WkAjhBTBaeJfQZn4iu1nyA=;
        b=SSGZkVp/1Pcgg1lSTjafi7a2kBCekHo+yXtkZ8QGtyPWu7zFTlfb2tqSok6M8ziX/t
         j+78m+4wA0lrzqPTH4VOAD92yakwzE0MybBPFpsZB/5FRGmAcVJd8UVyNQXuUMALCs55
         VgWHrrkoVg6k2fB+KCFaucxTmu73Tx6m1LGKaAtRHawGJpmgg3PpjFDa5MoFbY7tg+6Z
         nzz5wbkpLrcZ/HHK7YRFtIAsvQAxQxRl0APEwdIJ42wfQMBieoE6eEaUtWxghgmLV7el
         jk1c0bZx0cvlFuxiy5qwjYDmtJp0E3xbo/u/H/V0WUKYE+mER+zplvzIcI0VizYqDhyl
         AkLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzB4xFSX1cyVpxBhGbJ5Lx6sEdVsacyF5x5e3aGxUQnYKjq5rkZFj5DOuG3IuTGRwXRWkjJcZabs0rp/A3wbZRLwnJIqVwEWYW67+E
X-Gm-Message-State: AOJu0YylM2fXSuOp2F0JfNy+Ws6yZSSULGB3tFScwDEr9fmVUnH4X8rW
	fcrimYFY8vKa0KWDNAMM/iz1g8Bz0eC3abnyBXqp6V3voRYWKvoVDX8aXEluVYOje32XW+0BemB
	yNrnf4kcbPU7k42p8VBwfP9PfNY0=
X-Google-Smtp-Source: AGHT+IHItGs9GsQLl/Vh5HJFbD/xVmvTeiFf7Ru6uA0BgA11Rh1KAeWoWgVxI6oDQNZpq8xhRWLvEtZltOA26qnO9Ts=
X-Received: by 2002:a05:6902:e12:b0:dc6:b088:e742 with SMTP id
 df18-20020a0569020e1200b00dc6b088e742mr10140114ybb.8.1707826323934; Tue, 13
 Feb 2024 04:12:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
 <20240212132515.2660837-3-andriy.shevchenko@linux.intel.com>
 <9c7df0e5-31a9-4c86-b996-4cba82c4ea2f@suse.de> <ZcpKh_EgNM5IaV-P@smile.fi.intel.com>
 <ZcpKwz8J8OoODMYl@smile.fi.intel.com> <87sf1wkcmv.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87sf1wkcmv.fsf@minerva.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 13 Feb 2024 13:11:52 +0100
Message-ID: <CANiq72=shaF=PQchzztD1R8EJFHeORRhoobBsNAHZwm19JtMRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] auxdisplay: Take over maintainership, but in Odd
 Fixes mode
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 9:10=E2=80=AFAM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> AFAICT Miguel Ojeda is quite responsive and is still doing reviews/acks
> for auxdisplay patches. Can you elaborate why the maintainership change
> has to be made?
>
> You can still be listed as co-maintainer of course, and maybe Miguel is
> on board to drop this but then I think that should be mentioned in your
> commit message (and have an ack from him).

Thanks Javier, I appreciate the kind words.

To clarify, auxdisplay has had just about 16 patches a year (i.e. very
low), and a significant fraction of those came from Andy and Geert. In
addition, they have some of the relevant hardware and have tested
patches in the past (which I really appreciated). By contrast, I have
not had any of the hardware for years now.

So I asked Geert and Andy in private if they wanted to become the
maintainers/reviewers. They do not have much time, but Andy wants to
submit a new driver anyway, so we ended up going with Andy as M and
Geert as R, which I really appreciate.

If somebody else wants to join, I am sure they would be happy to. And
for those that may not be involved with upstream development but have
some kernel development experience, this may be a nice opportunity as
well to try becoming a reviewer/maintainer -- it is a small, fun
subsystem (if you have the hardware), with low traffic, and with a few
experienced maintainers around it like Andy and Geert that may be able
to help test patches etc.

Cheers,
Miguel

