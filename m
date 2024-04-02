Return-Path: <linux-kernel+bounces-127760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E2389508D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12071C218B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD7A4CDF9;
	Tue,  2 Apr 2024 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EB44lL3F"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83115FDA5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054493; cv=none; b=G7HrvrM6dXwAjRsvdGBQqUfkEW951GtIsJ7Fr48J5M6Pek8vR0DWZjZ0zBqRY/LaHOg6fYNLBOhHt6ButNluA+ziMUY1i2InO8apxgr3KQ3qVEWUZTs/8ZELDhcs9DWRpsry7gS8PWecF5Pa3xnvg1EZy9jLEQYOzmiiQE2zK60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054493; c=relaxed/simple;
	bh=ApXaBVn2XS6OYYCjGNp8YjyB5+PeDb/eSjzi35GKmCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSjeM6hoMI8lSz4wtJpQXHp7lsXV40ZI5cpGCv1dgYGR+/xiq88GSTdXyAWmKTLHubnliVT3uSfIPyuFz95tSB2OvhX+/r0Ww6vjAtfUck2ayqTI6xB3AIS3rv2qC2ucUYto+4Z3YUKhcb8AVLZfM7vrLft2t19CUoKESZUEez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EB44lL3F; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcc71031680so4537549276.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 03:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712054491; x=1712659291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApXaBVn2XS6OYYCjGNp8YjyB5+PeDb/eSjzi35GKmCY=;
        b=EB44lL3FpzlGsm9N4cbetETvG6odV5D0g7nZNTNGZFmd6obJ5e/RpnQNWsGdr6O/UI
         KqVoQWpmmpuJz3BpXnr5gMq2kyaBGEyRms/f6OTN3uGQWW/nXK0wtnOIK/2ykg9MPhe7
         Z16MQlJoH94bJYfWFFXCKmksptyr05tPMNEkppIPMzRXSVko1AxBhLV3m1vb0eF0boaa
         q8/Zq9XX7pjsgb23MH7t2xgu8IR087nJ6L8pARjIwhR9HO8tN6CQGx9J4jxhe78hMM+R
         hA2HIBfbqmrHcjG/bJ1iWMV3nA8qdBjS12wYlhwzeLckICX6/Ujb2EMnZFxwGOw5Tbaa
         P8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712054491; x=1712659291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApXaBVn2XS6OYYCjGNp8YjyB5+PeDb/eSjzi35GKmCY=;
        b=hPnyQUwqFtrW2nbfkGTOza2BeERsz+ZxJfJkJmqAl5Duqi4N8ty3t5njvnpGak6a0M
         xDG9A6owwQpoaVHhQZNs0/Pk4gxu07P53LoyBGGZALtBpHSwje6Cu2BAkyrcuJh/NW6k
         H2mEduyWkNJNjydwXx7q8REJ7NkGdDay1z97ZkPkQO+T7aoKmFOcaRKQHq95A0yuccFf
         2s/3/LBzYPflCTCq6cK4UHxEf5hNsww/JiMRU02jLjY+XblhdbAdIgd96A0kebUgxiiV
         jmY7bVB7grJdN5cZ6ZC21rHEzCOP4MXjGdXpYSQE+3Pkfoc30+yUqAhyqI1eW8LaENfi
         SLqw==
X-Forwarded-Encrypted: i=1; AJvYcCWg18j0bQoukKxo8BRvpWQxUVCsxAw9iPkO9HkvZt3ei+KAvLopBdp52zcw5gsntBShLQkpThQc3RylvxO7+Gzsjw9SM/O/FKNCk+pu
X-Gm-Message-State: AOJu0YxNmN736GvZ3/xsqc2lHzGGqg611HTldcxQc9l20qETcH6ZRxk2
	o7FQ2QMauUG8A9YMHvZTnR3BVKalmw1IZtZ1JKgg9qZd3+IM7tCQqWNSLELGqKPutIn5zyNXEP4
	V7n6O2eCKeJgjkIHh4xWftWMVWP4RbKTJSTcVTg==
X-Google-Smtp-Source: AGHT+IHFrOBcRfRRcNHSGMiQ/W4jMX2rXf1tkCXA4ATT8aem9b16esSs4RkJ1Tfl+2WaN6o0ECfwJ0rgttOE6KypifQ=
X-Received: by 2002:a25:16c4:0:b0:dcd:4d96:741f with SMTP id
 187-20020a2516c4000000b00dcd4d96741fmr10305474ybw.10.1712054491019; Tue, 02
 Apr 2024 03:41:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222022741.8223-1-boy.wu@mediatek.com> <6837adc26ed09b9acd6a2239a14014cd3f16c87c.camel@mediatek.com>
 <Zghbkx67hKErqui2@shell.armlinux.org.uk>
In-Reply-To: <Zghbkx67hKErqui2@shell.armlinux.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 2 Apr 2024 12:41:20 +0200
Message-ID: <CACRpkdaNtXDYOMbRbbsXb+frYa18+ErVWP966LFGt-GCXbL9iQ@mail.gmail.com>
Subject: Re: [PATCH] arm: kasan: clear stale stack poison
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: =?UTF-8?B?Qm95IFd1ICjlkLPli4Poqrwp?= <Boy.Wu@mediatek.com>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 7:36=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:

> On Fri, Mar 29, 2024 at 03:17:39AM +0000, Boy Wu (=E5=90=B3=E5=8B=83=E8=
=AA=BC) wrote:
> > Hi Russell:
> >
> > Kingly ping
>
> I'm afraid I know nowt about KASAN. It was added to ARM32 by others.
> I've no idea whether this is correct or not. Can we get someone who
> knows KASAN to review this?

I rewrote the patches from Andrey, Abbot and Ard into the current form
and I tend to keep an eye on it, I can add a MAINTAINERS
entry for arch/arm/mm/kasan_init.c pointing to me and Andrey
so we (hopefully) get CC:ed on these patches. get_maintainer.pl
won't help in cases like this patch though :/

Yours,
Linus Walleij

