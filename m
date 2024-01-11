Return-Path: <linux-kernel+bounces-24043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A62A82B5EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29151C239F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1019857335;
	Thu, 11 Jan 2024 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ltr8fsN1"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0313D51007
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 20:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-67ff241c2bcso36729876d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705005116; x=1705609916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9v1NFTHcR0PFfn+r4hJa5u54W9vDrXz8u4VmSjEIjg=;
        b=Ltr8fsN1A8aMtkhC30hwNySjQvaUxZH6mZbcS6qv5WYToL5ArvXrVMS1jTWFeKCpVn
         qJN6c+7OMUKG+7yTsVaMD+cnSfLu3q+fEUHOjfVlEYGNlNtHf8+rySMZVAebDwXA5Too
         fv0ceNKEDdG8biIOfCuzIFzt1vKvMRAoPw/AkMxhj7y1QOPhRggkh/miiCK6A7RsXZH4
         Dvwf873cfg9d/dRvnnA5/mgBnHrgM3FX4idInwi5Cp7wEpvO1NUop2YUkT4TbJC2uHIl
         /kdeBCM5g4PbtDozgdMr2HQCaB3f7m6KWaSenhF0YlX+IgrQpS7h788TAqbIHtUvtuG9
         6xeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705005116; x=1705609916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9v1NFTHcR0PFfn+r4hJa5u54W9vDrXz8u4VmSjEIjg=;
        b=XDta1BQ6yHmgRuJVwMCzEWEZnNWZ4PwuQ1vPqnYAYsJesNtcgZBrHvrHL+QDFGBXOq
         wrcumsE/GmCsNkTiWC8yUMsIo5W956qz9GixUfJ5tNsXD9fWIQcZacc8yuNVKGbGWQ4u
         aSzUz6t4D0BzLbQoFnF0v0j5dtvc01FxU6LLkfnInBqJmfO34xDyzzC2cbjuMfguC8ep
         0T5D4p1OHALgEpCdAg4wiE4uoa/XPuxcn0jeoj96Wq01FYo05PtHq9bzHiyT44SLgFUe
         hWfTLbn8a1+KSnJBBTgNX7XBhT0XZKGEzgxpiw/QemXAn8NDhYxqOC4xOmtruqJqOiGM
         b3TA==
X-Gm-Message-State: AOJu0YyU797xd4zJtj60LQvCwfYx0R68KPLeh6X01/NzxAPOxA/vxHPW
	QiH3BAfeyfbjrKXgNWi8lIZX2x1QL2qy1JeX2N9yPBQFbMfW
X-Google-Smtp-Source: AGHT+IEaPigOQUighUf564h+mIju3h1tqlGOCIihT5St5OVdcRsGLhm83w1LHEdQpzWgz1UQ1sDqt1+deiwEBEhxGpA=
X-Received: by 2002:ad4:5dca:0:b0:680:c0ef:a56a with SMTP id
 m10-20020ad45dca000000b00680c0efa56amr243726qvh.122.1705005115736; Thu, 11
 Jan 2024 12:31:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105000632.2484182-1-aahila@google.com> <11317.1704418732@famine>
 <ZZtwKFu4GQLQ5AXM@Laptop-X1> <26173.1704830028@famine>
In-Reply-To: <26173.1704830028@famine>
From: Aahil Awatramani <aahila@google.com>
Date: Thu, 11 Jan 2024 12:31:44 -0800
Message-ID: <CAGfWUPzQuk8cw0BRVSCc1gK+_V_MLxCDhAH-=X0LgTSMF9RWKw@mail.gmail.com>
Subject: Re: [PATCH 1/2 net-next v2] bonding: Extending LACP MUX State Machine
 to include a Collecting State.
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, David Dillow <dave@thedillows.org>, 
	Mahesh Bandewar <maheshb@google.com>, Andy Gospodarek <andy@greyhouse.net>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > >>    Please reference the standard in the description; this is
> > >> implementing the independent control state machine per IEEE 802.1AX-=
2008
> > >> 5.4.15 in addition to the existing coupled control state machine.
> > >
> > >The status of IEEE 802.1AX-2008[1] is "Superseded Standard". Maybe we =
should
> > >use IEEE 802.1AX-2020[2].
> > >
> > >[1] https://standards.ieee.org/ieee/802.1AX/4176/
> > >[2] https://standards.ieee.org/ieee/802.1AX/6768/
> >
> >       I'm fine to still reference the 2008 (or 2014) standard even
> > though it's superseded; the 2020 standard is much more complicated, and
> > I find it harder to follow (particularly for the coupled / independent
> > control sections, the older standard explains them more clearly in my
> > reading).  Bonding does not implement any of the new things added for
> > the 2020 version, so we're not really missing anything.
> >
> >       That said, as long as the citations are for the correct section
> > (the numbering is not consistent between versions) any version is
> > acceptable.

I have gone ahead and referenced 2008 in the documentation.


On Tue, Jan 9, 2024 at 11:53=E2=80=AFAM Jay Vosburgh <jay.vosburgh@canonica=
l.com> wrote:
>
> Hangbin Liu <liuhangbin@gmail.com> wrote:
>
> >On Thu, Jan 04, 2024 at 05:38:52PM -0800, Jay Vosburgh wrote:
> >> >+coupled_control
> >> >+
> >> >+    Specifies whether the LACP state machine's MUX in the 802.3ad mo=
de
> >> >+    should have separate Collecting and Distributing states.
> >> >+
> >> >+    The default value is 1. This setting does not separate the Colle=
cting
> >> >+    and Distributing states, maintaining the bond in coupled control=
.
> >> >+
> >>
> >>      Please reference the standard in the description; this is
> >> implementing the independent control state machine per IEEE 802.1AX-20=
08
> >> 5.4.15 in addition to the existing coupled control state machine.
> >
> >The status of IEEE 802.1AX-2008[1] is "Superseded Standard". Maybe we sh=
ould
> >use IEEE 802.1AX-2020[2].
> >
> >[1] https://standards.ieee.org/ieee/802.1AX/4176/
> >[2] https://standards.ieee.org/ieee/802.1AX/6768/
>
>         I'm fine to still reference the 2008 (or 2014) standard even
> though it's superseded; the 2020 standard is much more complicated, and
> I find it harder to follow (particularly for the coupled / independent
> control sections, the older standard explains them more clearly in my
> reading).  Bonding does not implement any of the new things added for
> the 2020 version, so we're not really missing anything.
>
>         That said, as long as the citations are for the correct section
> (the numbering is not consistent between versions) any version is
> acceptable.
>
>         -J
>
> ---
>         -Jay Vosburgh, jay.vosburgh@canonical.com

