Return-Path: <linux-kernel+bounces-67002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED6D8564A4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297BA1F2651E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE1613174D;
	Thu, 15 Feb 2024 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwx+MJZn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7005131731;
	Thu, 15 Feb 2024 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004484; cv=none; b=GIeP26NI84Mfqyb6djj8t8e9MdcSSWMscAYXDhgDmJvAZT5eSCQd65YgP8U9QV557kHM+0HxIOsmw2IjbNEctPkdhi4Xtii7uU2O41ksSHb16GTGteIeBDl4u8eGzFSasLSKMcNkxOQZMcaC6xaG2d1iOis+uVREBzpZ0yeVY58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004484; c=relaxed/simple;
	bh=H0RRjq8hyhzq5G7/H4AWcACfk52o+wWu6HicUSnX2I4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDkR29p1riiMVqcs1SDBEhcs6k6L9GFfMB3t2zjiB+QaXnWkNeuO2XwY2wPXuVC1Kdj+QocT7u2+7ZLnSbZsQSCR5YixO5vjFquSOrldoBnhtlInWFFDQ4gTMSE4+0bdP0v9uBnczuYw9XONPYGn1GhGOXV/Ixd+0hk4CFVpgN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwx+MJZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835C0C433C7;
	Thu, 15 Feb 2024 13:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708004484;
	bh=H0RRjq8hyhzq5G7/H4AWcACfk52o+wWu6HicUSnX2I4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uwx+MJZn5At3nragiOq9siMG1CR+uoolg9EI1ShM7CamoTnbxjurXcuNBTPVr5/8f
	 UF6//v36UECKUthdF1kzbbpXQnPOf3fzWa5bxHnYHE21tNMO09gUky0HPKQ97GqaVB
	 RzZWno4WVsmbgF7m8bJaHCWh19CYUINJKnvTeVbi7XLa1gBpKjc6BZtRNbjgsNnF1Q
	 D1X++1F5VryoVk9kFUcoM22+TgtlUY9Ix5XTspwu6VUYPWleMJAiRIyGOBX1Ix2Yiu
	 X4MM19D9VlZu516qJADt0iTw9TgQnXIPDQ97VwUbP6h2LqoMOi7cgKclXxZei2BjHk
	 +On3bkTbPRDQw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d09cf00214so11561251fa.0;
        Thu, 15 Feb 2024 05:41:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWftHktNQ2jm34MLvCpts8Kn1LcIqzMV39ROcJWCffIAE1l00dmT2cg23EMWRjex79iCQe3SAzQsikmnbH/7KdYMOsz+bcskap08UK6nXSTL+nvV3WVWBelmjl6eijROYjAQvt/4G/EEmglgNjdgi/ZM7DQ/4szfX0aY4jcnE8Fk+RzOXGh
X-Gm-Message-State: AOJu0YzxUwZ1PNH+KXZ3A9NB5c5su2RuUrYg6v9bpVcIovBAAOIeDIQh
	agJWsrEaM6kB8Hmt0aMsEooMWVcCqhQzZ+4Porz7dBE9WazxpPRl29wEP+ix046Iwh6Q210obXt
	V4kwi7k52w6TqeYa4Z2oFefx4+Xk=
X-Google-Smtp-Source: AGHT+IFJi5xkPKZanwc1lVjx5ydelh3r7qoUdYjjZx2jFBVwBAh5n8+2iFh4G23E5hUpFejQKAisEoA1TLUH2ManFOo=
X-Received: by 2002:a2e:9d84:0:b0:2d1:1df7:95db with SMTP id
 c4-20020a2e9d84000000b002d11df795dbmr1412596ljj.13.1708004483103; Thu, 15 Feb
 2024 05:41:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230917192009.254979-1-arnd@kernel.org> <CAK7LNASua5xkkg84s4o4GZ00hFRc10V9BmqyxfWfPi=JVFYC8g@mail.gmail.com>
 <Zc4F3JttXSsBsw-P@bergen.fjasle.eu>
In-Reply-To: <Zc4F3JttXSsBsw-P@bergen.fjasle.eu>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 15 Feb 2024 22:40:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT2DNE3RMLdXhLbSRHz6nfuP825UK39sQHkJW4x+OyfVg@mail.gmail.com>
Message-ID: <CAK7LNAT2DNE3RMLdXhLbSRHz6nfuP825UK39sQHkJW4x+OyfVg@mail.gmail.com>
Subject: Re: [PATCH] [v2] Documentation: kbuild: explain handling optional dependencies
To: Nicolas Schier <nicolas@fjasle.eu>
Cc: Arnd Bergmann <arnd@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>, 
	Javier Martinez Canillas <javierm@redhat.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 9:39=E2=80=AFPM Nicolas Schier <nicolas@fjasle.eu> =
wrote:
>
> On Mon 25 Sep 2023 16:06:41 GMT, Masahiro Yamada wrote:
> > On Mon, Sep 18, 2023 at 4:20=E2=80=AFAM Arnd Bergmann <arnd@kernel.org>
> > wrote:
> > >
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > This problem frequently comes up in randconfig testing, with
> > > drivers failing to link because of a dependency on an optional
> > > feature.
> > >
> > > The Kconfig language for this is very confusing, so try to
> > > document it in "Kconfig hints" section.
> > >
> > > Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> > > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > > v2: fix typos pointed out by Nicolas Schier
> >
> >
> > Applied to linux-kbuild. Thanks.
>
> Hi Masahiro,
>
> this patch seems to got lost, or did you intentionally removed it
> again?
>
> Kind regards,
> Nicolas



Oh?

I can see it in the mainline.




commit 28d49e171676afb7df7f47798391364af9abed7f
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Sun Sep 17 21:19:59 2023 +0200
Commit:     Masahiro Yamada <masahiroy@kernel.org>
CommitDate: Mon Sep 25 16:01:05 2023 +0900

    Documentation: kbuild: explain handling optional dependencies





--=20
Best Regards
Masahiro Yamada

