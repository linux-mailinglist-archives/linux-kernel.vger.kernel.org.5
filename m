Return-Path: <linux-kernel+bounces-26326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 584DF82DE98
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC17B1F228B1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EFE18049;
	Mon, 15 Jan 2024 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9z2HeYX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF3717C98;
	Mon, 15 Jan 2024 17:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E850DC433C7;
	Mon, 15 Jan 2024 17:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705340623;
	bh=TNNXHlCOpAGGqgmgfpLzL9G4VoowSCtm3Fdz6y9uqF8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K9z2HeYXg8Ri8q/JdndsnZnWUOsgcOP7Mc1/4aLtm0m2gjnxLbig+qTSTIjOg8KEK
	 8op721GbB2BH0EJhV5tWHjK6/i5UqFz2714NB0xtnWP6dYPdAiH8wJjKuNi/u0EQzP
	 RFFYTPYzg8TDNvA6zgH3BdIVGR3/B8k4r6/Xc1XhJv9ifxFPgszGc0DEmE2Aq/tT+i
	 QDy7y8bb31DhKpXgEM8qv6D8fs1bcwp/dn4Fl1GylqrlP8Jnw6pQoeZ4p4TeIl9SQK
	 Nq0We2m3gt4YLjnY4ZDUlepnvwLFJABoFv6mbJXcRbWignsxt0plzu2XKL+hQYRZu0
	 GAN8whVDoam3w==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cd703e9014so79591781fa.1;
        Mon, 15 Jan 2024 09:43:43 -0800 (PST)
X-Gm-Message-State: AOJu0YwjbvV9weYzkJJeuhxwjBEJYvHSOQZCzS/jQtA0kq04ONbDdxtX
	UqbmUhTdHP2dzpxWl/53VtfAtRFUJTRbBxtMRg==
X-Google-Smtp-Source: AGHT+IEdcvEmGLc2vxkMNR7ny/nWk3upQpsAYJ5biMMTm3Rx1zQeTWmjrbuSeSUFWyhnJj8ycbxRcd55ApkN0iho+9k=
X-Received: by 2002:a2e:b0d9:0:b0:2cc:f31b:56ea with SMTP id
 g25-20020a2eb0d9000000b002ccf31b56eamr2992580ljl.92.1705340622164; Mon, 15
 Jan 2024 09:43:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220145537.2163811-1-andre.draszik@linaro.org>
 <170432630603.2042234.10993333941885772911.robh@kernel.org>
 <827695c3-bb33-4a86-8586-2c7323530398@amd.com> <bcd89ef7a43eb7d652f045c029d8e108adf7ba32.camel@linaro.org>
 <20240115-fragment-clean-95ef01dd8b20@spud> <ffd6f60e-fea9-4426-a981-badd3c68cd4d@amd.com>
 <8c5afb4e52e0c5a6dd88f6b7eaa7bc2e97ba31ad.camel@linaro.org>
In-Reply-To: <8c5afb4e52e0c5a6dd88f6b7eaa7bc2e97ba31ad.camel@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 15 Jan 2024 11:43:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL3ELh=i6cA+8EhH0uBw19sw5+vCyLWUODU7D80JS-D8w@mail.gmail.com>
Message-ID: <CAL_JsqL3ELh=i6cA+8EhH0uBw19sw5+vCyLWUODU7D80JS-D8w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ignore paths outside kernel for DT_SCHEMA_FILES
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 10:57=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@=
linaro.org> wrote:
>
> On Mon, 2024-01-15 at 17:37 +0100, Michal Simek wrote:
> >
> >
> > On 1/15/24 17:29, Conor Dooley wrote:
> > > On Mon, Jan 15, 2024 at 09:40:37AM +0000, Andr=C3=A9 Draszik wrote:
> > > > Hi,
> > > >
> > > > On Mon, 2024-01-15 at 10:20 +0100, Michal Simek wrote:
> > > > > This patch is causing issue for me. Look at log below.
> > > > > I am running it directly on the latest linux-next/master.
> > > > >
> > > > > Thanks,
> > > > > Michal
> > > > >
> > > > > $ make DT_SCHEMA_FILES=3D"Documentation/devicetree/bindings/arm/a=
rm,cci-400.yaml"
> > > > > dt_binding_check
> > > >
> > > > It'll work if you drop the 'Documentation/devicetree/bindings' part=
 from the path, as
> > > > it is implied since bindings can only be in that directory anyway:
> > > >
> > > >      make DT_SCHEMA_FILES=3D"arm/arm,cci-400.yaml" dt_binding_check
> > > >      make DT_SCHEMA_FILES=3D"arm,cci-400.yaml" dt_binding_check
> > > >
> > > > both work.
> > >
> > > Requiring that is pretty user unfriendly though I think, passing the
> > > full path from the root directory of the kernel tree would be my
> > > assumption of the "default".
> >
> > I am using full path like this for years.
>
> I just just went by Documentation/devicetree/bindings/writing-schema.rst
> which doesn't suggest adding Documentation/devicetree/bindings/. In an
> attempt to make it more robust for anybody following this doc, I opted
> for the current implementation.

It originally worked only with the full tree path. It's now enhanced
to take any substring for a match. As that is preferred (and shorter)
that's what the documentation has.

> > I can fix my scripts but would be good to consider correct path inside =
the
> > kernel is something what this patch should also allow.
> > Because path above is correct and it is not outside of the kernel that'=
s why at
> > least commit message should be massage a little bit.
>
> I hear you, and I'll make a v2 to not imply the bindings directory.

A follow-up, not a v2 because v1 is already applied.

Rob

