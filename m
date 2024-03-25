Return-Path: <linux-kernel+bounces-118086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF2D88B38D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1D71F63AFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64CC745EF;
	Mon, 25 Mar 2024 22:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZalcUGf"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805837441C;
	Mon, 25 Mar 2024 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711404593; cv=none; b=oVC/uJlEqx2VPfbZMEUzlrOgDpMzHBJeWoTc/K6ktXObuRVsdBWSxjBmrG/YmfsGOh3rQdq8plW//Ub0L3/eRWTEvfFN/I4wOUXp2p4X1kMg+ehyQkKyJ8CYAvWAhGxjLSwYai0VwX5Dhcy+/wRolLu2Dv7gbuIJNlMFB/tPcx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711404593; c=relaxed/simple;
	bh=tyNzq8sMRVHXjs1GnDWzeBNhhdt7M1nl7Y20AhpptkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7seTmM+sw0e/5SJOtt7kndZLDXiecTlHtdyf4Jebkb1pYT3H/ESzXgRre/Alz2mbEyCL1T4S1V8cpwa14QCk0+O03u/+CuWUvNsl6LlC7CgdguhNwDxEWI77Ah8I7AZ5wjxwNyu16w9Jq3vzFEh5XDFo4HRPqnQUX6qJLoo4Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZalcUGf; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60a046c5262so46286937b3.2;
        Mon, 25 Mar 2024 15:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711404590; x=1712009390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyNzq8sMRVHXjs1GnDWzeBNhhdt7M1nl7Y20AhpptkI=;
        b=OZalcUGfH52tAvHHFEjw0CI7IkpgycHOXbd09y1AG5K18SAoa7cqkUSyor3FGi7CtC
         pVem2QhsS4lj4KLr76wqm0Wgky1KnnHx+kCcAXYkrFPN8UxQNbukzJBiBSXloEtR/nUK
         32I6rYJTvTQems5k95V3oyWjE8xhDrphJNNrR20QhUfUgeuWP/KODpz06xYSs2xvVX3d
         tssQdb54E78EWwmt9NHXskxjg0BeEoc6q5zK/Mww9jB8oPqw4b6OYb1DIilruNz5Eqim
         CCApgm/FeWZtaZqDSqKaNuupgQnDJyE8CZF2r9+WcNTwCBJqV61KIaxbG9OE18/YzaRo
         vxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711404590; x=1712009390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyNzq8sMRVHXjs1GnDWzeBNhhdt7M1nl7Y20AhpptkI=;
        b=M6YcnW4KItO/2IbfZoxxIDK32zrrhnYHL8nNThW4JxBRsvwqrdtUOujPD9Aa73ug7e
         gOpUAH/mKnBhv8EH26J+iy0AE24JUduWGAZbooSzIMcBUkDWWpD3+cJd9PA0pLZeh/8W
         4CjTIJYwqMciiNuvAcEwghn1/+3vHom14nHjrewH1svTRyq5r3wIaCXC+8j/Qb2Lqea9
         XloGxvK4YrW/2HM3G6mqhks2ERhsAN8eq7fX9B2K5tWAnA1lPn79RGKKAugQLldyMSyf
         nxIbmVo8hlK5M71HIL4xNFbdRWsGzxU+NidEOLyUKBQKuZY1CS7D90SZOfKyPz+tP7M0
         sY7g==
X-Forwarded-Encrypted: i=1; AJvYcCVDpsc8XxLGvDW626qh99YRBgoB/FcKHJZY5i/KEMi3vXPE8CyPZ3YT6RUKVZ/vWotCI8x/s4nn3n+G25bg1FPIBhhv7xG3KX/qzmJXVctsZZ7ICXoxZlcqFeVmFv6nx8h/VHQBfI7fx6uJVCfSDu6uJ+tzPqsYWLkDIk2y8p2PeKLoCw==
X-Gm-Message-State: AOJu0Yz4Sy4NfUYUGc1W6O1OjLjEpLmcSuknC/us4vRc9hHCSc2HGY3K
	ZfIZgMXJ33AGRvtjzjuRBemL9ag+9YacZIsskhH1tksYH8SOmiB9o82bFkMrWQ9Sar89uAq+8+X
	vmVzjk0xGmf7xEvkMFvfctZ4RyLo=
X-Google-Smtp-Source: AGHT+IEUnQ61pYOdy6iBI6EKL8f+BYQGPiPimulDGq52iO7ygQltC+cIgsF+VqiTGHc/9ZtzaODGr88cfFatzs3X4o0=
X-Received: by 2002:a25:8a0f:0:b0:dd0:3a7a:fb70 with SMTP id
 g15-20020a258a0f000000b00dd03a7afb70mr6309495ybl.52.1711404590425; Mon, 25
 Mar 2024 15:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325153356.46112-1-l.rubusch@gmail.com> <20240325153356.46112-5-l.rubusch@gmail.com>
 <f74a01bd-46a3-46cd-a47a-fcfccd7e4dc6@linaro.org> <CAFXKEHbJ_5unY24aZeutvM-xrjevQ=z7ngDcgwJR=NXzXONx5A@mail.gmail.com>
 <334970e7-2edd-43c8-9f18-b7b3ec5f4d17@linaro.org>
In-Reply-To: <334970e7-2edd-43c8-9f18-b7b3ec5f4d17@linaro.org>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 25 Mar 2024 23:09:14 +0100
Message-ID: <CAFXKEHaEVwiAW9co0+=kZ5w5a8eWg3QL0dmg38bvrmLdnBEA7w@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] dt-bindings: iio: accel: adxl345: Add spi-3wire
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:40=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/03/2024 22:05, Lothar Rubusch wrote:
> > On Mon, Mar 25, 2024 at 7:32=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 25/03/2024 16:33, Lothar Rubusch wrote:
> >>> Add spi-3wire because the driver optionally supports spi-3wire.
> >>
> >> This is a friendly reminder during the review process.
> >>
> >> It seems my or other reviewer's previous comments were not fully
> >> addressed. Maybe the feedback got lost between the quotes, maybe you
> >> just forgot to apply it. Please go back to the previous discussion and
> >> either implement all requested changes or keep discussing them.
> >>
> >> Thank you.
> >>
> >
> > You refer yourself to the above mentioned wording. Would replacing
> > "driver" by "device" in the dt-bindings patch comment be sufficient?
> > Did I miss something else?
>
> Yes, the wording, but isn't the device require 3-wire mode? Don't just
> replace one word with another, but write the proper rationale for your
> hardware.
>
It does not require 3-wire SPI. By default the device communicates
regular SPI. It can be configured, though, to communicate 3-wire. The
given patch offers this as option in the DT.

> >
> >>>
> >>> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> >>> ---
> >>
> >> This is a friendly reminder during the review process.
> >>
> >> It looks like you received a tag and forgot to add it.
> >>
> >> If you do not know the process, here is a short explanation:
> >> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> >> versions, under or above your Signed-off-by tag. Tag is "received", wh=
en
> >> provided in a message replied to you on the mailing list. Tools like b=
4
> >> can help here. However, there's no need to repost patches *only* to ad=
d
> >
> > Just for confirmation: when I receive a feedback, requesting a change.
> > And, I accept the change request. This means, I received a tag
> > "Reviewed-by" which I have to mention in the upcoming patch version
> > where this change is implemented and in that particular patch?
>
> Please go through the docs. Yes, you received a tag which should be
> included with the change.
>
> Reviewer's feedback should not be ignored.
>
>
> >
> >> the tags. The upstream maintainer will do that for tags received on th=
e
> >> version they apply.
> >>
> >
> > I'm pretty sure we will still see further iterations. So, I apply the
> > tags in the next version, already scheduled. Ok?
> >
> >> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process=
/submitting-patches.rst#L577
> >>
> >
> > Going over the books I feel it does not make sense to still mention
> > feedback ("Reveiewed-by") for the v1 or v2 of the patch here in a v5,
> > does it? Your link mentiones "However if the patch has changed
>
> I don't understand. When did you receive the tag? v3, right? So what do
> you mean by v1 and v2?
>

V1: The first version of the 3wire patch. I have split the single
patch upon some feedback (yours?!) - V2... So, my current
interpretation is, that every feedback I need to mention as
Reviewed-by tag, no?

>
> Best regards,
> Krzysztof
>

