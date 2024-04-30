Return-Path: <linux-kernel+bounces-163917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9328B75D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D684B1F22E36
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417B617167A;
	Tue, 30 Apr 2024 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXp2AlzZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75442171651;
	Tue, 30 Apr 2024 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714480440; cv=none; b=tC8K2p0O3hvhodiwFQAZxm6w/wzANY/w7yuiVrP0Zm2+D5TJHlEP5uvsSTogOdo7gzBryZDmD6gkgdbZVjuJ5yP4byZiUA5/BHcBUh5mgezb/yuhCDGF9qaTAF+OgPWjDOMGUitV0jqEgIvIQPMYjnnBF+gK3Mi8slnR+xmcAYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714480440; c=relaxed/simple;
	bh=Xke9Wt5xdH4CMo48znE40GyJi3Rdh/q4/CRf0XVY7v4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8xMoM/ZAPlmXrGxCTN9aFOw2uWZBPWaIzdEFhIpdEB7hOQwMz84mbqCYfi/nSmnfgy5U8Hw5xyXy+Z2w3wBqy9K7iYHMGv3ty4thUcLptimkME8e2GR/y4pvcn3fvslDQaA8MoOYUKgG4UlePTqKBJRazKAojABcvAR/6uKn9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXp2AlzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED54C4AF1C;
	Tue, 30 Apr 2024 12:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714480440;
	bh=Xke9Wt5xdH4CMo48znE40GyJi3Rdh/q4/CRf0XVY7v4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fXp2AlzZAmzzyRzcNk0Qc2QGH8wJUeRefSipXDQHEOQCn89f+zTCnsGV871blvQap
	 GSgoGPeSp91NLV3TXaD9ZIakz9gJ9jbQixk/3+s5WZZLSiX4nhmxYkgb70r4wwV+rE
	 UEdrMr3uO3N7MNGJnTGJicCTaxhSTqqoZgjv1C1v2q7IR4JNJGvvi7l6peGlkqPX2j
	 9z6V8tSrejQSVE9E2VUjFL66YaG26YMKSJ/sk6ePXpOfHjyamgxmmNpd8b/5M+Zild
	 HzU4k6t8N+SDGwG4XpW4gW94Nb9VMsQrHDS3VM5ZutMIRKDskULVy3vuTUZcK+iJzL
	 GIWV7nkWfI4rw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e0a34b2899so22369561fa.3;
        Tue, 30 Apr 2024 05:33:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5NFFVOowoDVxXyI2qzBhFG/4Ia1irLqyNtjvMf/J39zk4P1Ys//lhOZtW0faXhHGllDH2ACAyE0S9EcImRjf+/ejjkC3nGuDgkmhe+/gBJIaaQEYExKcMDgZBU+lEaJYEHxy8JfDG1PIY66dG4CgVJxhmz/YiQplLxU4FoFEeOpuf0Q==
X-Gm-Message-State: AOJu0YxqXomz1iiTfXeq8P95f9uX5Oxd3CcsyQj2zIIl+abKsavOjG3N
	8qBgkI//9d8N/2fyo3RJt0kNLOoI37bTYIL/QusXUZZxHYzZTEvJfesLsz65U4IbuMg22w47QFR
	AS727O+I+yK5lir2qASJ3sofHSg==
X-Google-Smtp-Source: AGHT+IG3oNca8uS9A87U2+LG/S+8nKcOL/HqwB8fsDHjItlda7aJZYKjnTbfdgzZLkUwElJN2Dt7XyAgvk7V59QJVmY=
X-Received: by 2002:a2e:8196:0:b0:2df:4bad:cb7a with SMTP id
 e22-20020a2e8196000000b002df4badcb7amr9145433ljg.0.1714480438215; Tue, 30 Apr
 2024 05:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425183810.3079069-1-robh@kernel.org> <9e1195f05f4eced0a158c49616deba6a.sboyd@kernel.org>
In-Reply-To: <9e1195f05f4eced0a158c49616deba6a.sboyd@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 30 Apr 2024 07:33:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJUMPMv8YuRgaWL+1it07vrn-U0nLckMkPPVF-QzJOcew@mail.gmail.com>
Message-ID: <CAL_JsqJUMPMv8YuRgaWL+1it07vrn-U0nLckMkPPVF-QzJOcew@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: fixed: Define a preferred node name
To: Stephen Boyd <sboyd@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 7:11=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Rob Herring (Arm) (2024-04-25 11:38:09)
> > diff --git a/Documentation/devicetree/bindings/clock/fixed-clock.yaml b=
/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> > index b0a4fb8256e2..d287bd092054 100644
> > --- a/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> > +++ b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> > @@ -11,6 +11,13 @@ maintainers:
> >    - Stephen Boyd <sboyd@kernel.org>
> >
> >  properties:
> > +  $nodename:
> > +    anyOf:
> > +      - description: Preferred name is 'clock-<freq>'
>
> Is the preferred value of <freq> the clock-frequency property? Should
> say that explicitly somehow so that it's clear.

Yes, will add.

> > +        pattern: "^clock-([0-9]+|[a-z0-9-]+)$"
> > +      - description: Any name allowed
> > +        deprecated: true
> > +
> >    compatible:
> >      const: fixed-clock
> >
> > diff --git a/Documentation/devicetree/bindings/clock/fixed-factor-clock=
yaml b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
> > index 8f71ab300470..962a1fe85416 100644
> > --- a/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
> > +++ b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
> > @@ -11,6 +11,14 @@ maintainers:
> >    - Stephen Boyd <sboyd@kernel.org>
> >
> >  properties:
> > +  $nodename:
> > +    anyOf:
> > +      - description:
> > +          Preferred name is 'clock-<freq>' if the input frequency is f=
ixed
>
> Similar question here. Is <freq> supposed to be the output clock frequenc=
y?

Yes.

>
> > +        pattern: "^clock-([0-9]+|[0-9a-z-]+)$"
> > +      - description: Any name allowed
> > +        deprecated: true
>
> I hope that deprecating this doesn't cause folks to try to clean things
> up and then break code that's depending on the node name to be the name
> of the clk. We don't want that string name to be important but it is
> sometimes.

Right. Leaving things as-is is the intent. We won't be enabling any
"no deprecated" mode by default when it is added.


Rob

