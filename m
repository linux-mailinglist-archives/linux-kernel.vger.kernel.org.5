Return-Path: <linux-kernel+bounces-85763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4E086BA69
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BD51C22400
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970E91361CF;
	Wed, 28 Feb 2024 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJSdgWg9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE301361C6;
	Wed, 28 Feb 2024 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157682; cv=none; b=I0bum64thWU+H2vCXVeJMdcwva33LD2SIyryrikxhTfbKhzFeeBfY6gIiDEvMlkSO8RZhr8Zbny6YnKqTniaSL6DXlVcckSqVafv3oGCcQGg12d6rkc8X/HQOuWGGOEH86xtM2dPemsT7vUVg+ljqe9BlC2p9PPHkpdR1SYYqFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157682; c=relaxed/simple;
	bh=o6MFrSIb/9TR5ZXqLPiJmvDqR+Z7VlCuMRswirAkRSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFtmluiFPJBersOpCXPHF/nDeR+9hQzj9Dq89uIg4aYAXDu53n9cLnd0OFswRw0QmkjuHiVGdeuEcad3HyhU8ys+NbCHH7woezcWVuoxQO6VDFAUa3wCHI3K+AJDlk//f6kq+nh53kvJ1ju/zTFrrN77yolctKIRX28QIPW9PNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJSdgWg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7AEC433C7;
	Wed, 28 Feb 2024 22:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709157682;
	bh=o6MFrSIb/9TR5ZXqLPiJmvDqR+Z7VlCuMRswirAkRSE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kJSdgWg9TSFk3QMfm6aeJntIdfrB4TNZoBxHCd/RvnVAqZauGl5Ut3K/HmROrXRCV
	 lazBNdizUR5+ZGRE4FuVBoXPHwDvY4iGQ0wTfi9qFefekjOT4cD4VFnk9b6I4fKTFS
	 qvtlgDm6WOShzV+8P+b2oEDye+rZdgqGxy5Z6+FuP4mH/VlcAbX6J6Roh9aCXMFV6j
	 LsO1Oz2cvKjEbGiHITvTikwsy6Rk6pne7z1qXqhrhPpNYqMJU2XhAWVEGOZRXn7Acm
	 HpkDpA5EUj2HLuZVKYLVm02/c9hFfJGiS8pUcSj82e0YvtjlfXabyt51MNpwCYwBeY
	 PtBhO3laVUdJw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d240d8baf6so2760541fa.3;
        Wed, 28 Feb 2024 14:01:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqBdRQjvXG8nHqgB5OMqjDPlSCFAFpUCsKQ8IUIt6e6rvFVqtn8Mi4qOmA9mbQszW2op080Ns0kSKmbjEkVykhNMfA5wRq68MVPpGEOTjdsY536Xch3VhNHs+4HLZngPv86m6drSD1Dw==
X-Gm-Message-State: AOJu0Yyk3xl6GjYeyHOIaKpOjZU3eDzxmLahMNyAJcCNo9eEQXemme/o
	Rc/yBQ1hx9Rk9kTswyCSFzpmspCdcUC+Q/KyNE3HPCDS8oyUFOuQvhZqq80BUxW2QLuNCAlkET+
	utHU5MZVyZnFO5y6c5E37zbbdAw==
X-Google-Smtp-Source: AGHT+IEXnVPLeLSvokP3FFCuUJiG6sgd8fOihS1kxS9XWLz2cM8MT5lYCT7vzDiaLpoDFRMQ4PV0ai3LXdPMw8lPeP4=
X-Received: by 2002:a2e:8416:0:b0:2d2:9906:6db2 with SMTP id
 z22-20020a2e8416000000b002d299066db2mr83302ljg.39.1709157680618; Wed, 28 Feb
 2024 14:01:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207011803.2637531-1-saravanak@google.com>
 <20240207011803.2637531-3-saravanak@google.com> <20240223171849.10f9901d@booty>
In-Reply-To: <20240223171849.10f9901d@booty>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 28 Feb 2024 16:01:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK5iuK0mMsvKkxPp9iSJuTfXrXuL55MgE09=oRnvS5k1Q@mail.gmail.com>
Message-ID: <CAL_JsqK5iuK0mMsvKkxPp9iSJuTfXrXuL55MgE09=oRnvS5k1Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] of: property: Improve finding the supplier of a
 remote-endpoint property
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Saravana Kannan <saravanak@google.com>, Frank Rowand <frowand.list@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 10:18=E2=80=AFAM Luca Ceresoli
<luca.ceresoli@bootlin.com> wrote:
>
> Hello Saravana,
>
> [+cc Herv=C3=A9 Codina]
>
> On Tue,  6 Feb 2024 17:18:01 -0800
> Saravana Kannan <saravanak@google.com> wrote:
>
> > After commit 4a032827daa8 ("of: property: Simplify of_link_to_phandle()=
"),
> > remote-endpoint properties created a fwnode link from the consumer devi=
ce
> > to the supplier endpoint. This is a tiny bit inefficient (not buggy) wh=
en
> > trying to create device links or detecting cycles. So, improve this the
> > same way we improved finding the consumer of a remote-endpoint property=
.
> >
> > Fixes: 4a032827daa8 ("of: property: Simplify of_link_to_phandle()")
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> After rebasing my own branch on v6.8-rc5 from v6.8-rc1 I started
> getting unexpected warnings during device tree overlay removal. After a
> somewhat painful bisection I identified this patch as the one that
> triggers it all.

How are you applying the overlay?

Rob

