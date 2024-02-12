Return-Path: <linux-kernel+bounces-61890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0B48517E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1D5DB22750
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED88C3C489;
	Mon, 12 Feb 2024 15:25:02 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8103C680;
	Mon, 12 Feb 2024 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751502; cv=none; b=ULtOs8app9p1M6xyUsRCUNIiFfdMNgtsyW5qEJxw1g3THfnYdJAr8HVKpI52gxsmuB2lipGRVte4r9+lovMRpvO1pLzfkHWzu//XUwSwmffdqDd4k5KYU8BK0X1PXVAaToe2VmYtl2LTUj1NGyYwR8YHjIZ5qu01ztTMpZxRcUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751502; c=relaxed/simple;
	bh=Lb8UtBzLjzS/qVaqjUTvHviDkXak3KVn2Ly9zFQ1XfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdQJEW8cIYFFiBvp6vBWqfkZ0HMT8Y+f98kbYzgSrgEvlkXFsX2MRNxTLx9BJf/TctFBgkQRLA0ctchc1+iS3BOdUr5VSlPFyCsI2jjYtuJw+MoZx4J25iPSFN7ie+pW+uT5uhB/lUn7FXqMsRIepCExirg9KjIp9YwSvtF548g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6077444cb51so2856397b3.1;
        Mon, 12 Feb 2024 07:25:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707751499; x=1708356299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0Ub5aaYMaWrYTV5JkkJefRsJ6WLWidbgJN2aytfHUI=;
        b=BQHIB5pS1eiYTHbR0aQoPEXce5X7zJ/7GEyf6JJUaEjLqv4aq53WPV5+bZY4ZT1XU1
         wrmr7PHPkJdIS41ygDNxP+BizkcyOu8D+WQKkHjaYPerKgw5Ja0727P3BLcGsD4mEiM2
         VxO30YDxiNy1BUqm9+35zP4bZpwLtTmv6gZrfQjr2gaQTDBJEUpopqbVCTwuJGjkNc6B
         a/viTg8Mc4ZowaGWAy00DuTr5H1sJanjSE02oP+40IPV+6comFGFjnBvMxZgJrzp3Jzw
         KSCbBFUgRoIaSaHP6zerS/KtNeCt/XyVRw4zupIlro8biy8QVbGK4NO4eDUfYk7f79x5
         9mhg==
X-Gm-Message-State: AOJu0YxifBtdK6WsTK0iha7C6J2AWrbtN20POE632Is39Lrnafj4F6Mg
	esE8Ur/h2KSgd+t9p3H3Hpharoi5OXTcz+wJKJ+tObL1rXcf/Q8hJrm4oH4Bp8k=
X-Google-Smtp-Source: AGHT+IEfUhhVsQzOW4aG9JONkGjHwe53LONTJf9X/m0CO34++QLIx867GoswmrL10V9aR9yck/PTQw==
X-Received: by 2002:a05:690c:250d:b0:604:de1c:5406 with SMTP id dt13-20020a05690c250d00b00604de1c5406mr3450125ywb.8.1707751498890;
        Mon, 12 Feb 2024 07:24:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6vohuFeI7y/3x69rpnq1PP+XdpTkgzz8OTZBVdEvE4CZxocF3fQUukxrrLIhDo5Rfx3krGs2w0nW6qVb37bDPCy8hZ6zPBdSres4jE9wxC0VS/B79tBl6Bnd+7rehW8VnwSO9AqYCUA==
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id p1-20020a0de601000000b006043d4f0687sm1203087ywe.105.2024.02.12.07.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 07:24:58 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so3541044276.0;
        Mon, 12 Feb 2024 07:24:58 -0800 (PST)
X-Received: by 2002:a25:ab90:0:b0:dc7:478c:7535 with SMTP id
 v16-20020a25ab90000000b00dc7478c7535mr4514405ybi.26.1707751498457; Mon, 12
 Feb 2024 07:24:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
 <CAMuHMdU-c5_Z2AMNtNH4Cc4JUrn+oKU-1CumEOAP6=5Zomcj_A@mail.gmail.com>
 <2922eece-5486-4eff-af99-f7060cb61d17@linaro.org> <20240212115837.efz73yxinkysdmgh@runtux.com>
 <e2a5b005-7916-4296-b072-c24efd4b3357@linaro.org> <20240212143957.gaxxz3nt7pxhlmqh@runtux.com>
In-Reply-To: <20240212143957.gaxxz3nt7pxhlmqh@runtux.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2024 16:24:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVzQb=0ZkPMWjcXzYrUjPGm_KzbtgfPN7icZzi3whPbiA@mail.gmail.com>
Message-ID: <CAMuHMdVzQb=0ZkPMWjcXzYrUjPGm_KzbtgfPN7icZzi3whPbiA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: auxdisplay: hit, hd44780: drop redundant
 GPIO node
To: Ralf Schlatterbeck <rsc@runtux.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ralf,

On Mon, Feb 12, 2024 at 3:40=E2=80=AFPM Ralf Schlatterbeck <rsc@runtux.com>=
 wrote:
> On Mon, Feb 12, 2024 at 02:38:27PM +0100, Krzysztof Kozlowski wrote:
> > On 12/02/2024 12:58, Ralf Schlatterbeck wrote:
> > GPIO expanders and their usage is nothing specific to this device -
> > other devices also might benefit of them. Or the SoCs which have enough
> > of GPIOs... I really do not understand why do we need expander here and
> > how does it help
>
> Can we then at least link the I/O Expander example to the docs of that
> display?
> I've documented my experience here:
> https://blog.runtux.com/posts/2021/01/06/

Any chance you can update the DT overlays to use sugar syntax instead
of raw fragments, target{,-path} properties, and __overlay__ subnodes?

You can find examples in my DT overlay collection, e.g.
https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/c=
ommit/?h=3Dtopic/renesas-overlays&id=3D3a41e34a2dd902c7bf74d11254a561907872=
52b6

> And at the time there were two out-of-tree implementations.

Only two? ;-)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

