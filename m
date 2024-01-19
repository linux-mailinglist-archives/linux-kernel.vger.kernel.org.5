Return-Path: <linux-kernel+bounces-31229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6A1832AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF0A28844B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2540652F9B;
	Fri, 19 Jan 2024 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXBlGWOO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C84A51C58;
	Fri, 19 Jan 2024 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705672552; cv=none; b=KGTDZmNcfpzV1l+a9zjNLQBAYKvMlkPzWacSS5/Bqc68VzJVLLiTs0jOpsDjd3M4BLq02qUsUSc7ayRgObXo3l4tBbWq7XwcRrI7slLI7xY7Dvd0DyDj/JmfYmdB8SIeS44BI8MZ0q7GZFGLndB5RABXTyYCweTT2wBKbCMcBqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705672552; c=relaxed/simple;
	bh=jgZ0z2QKaNKrU+JKlKY9qTzQooHXYwJjeK1yGSStXZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrUKjOakvYgk8bV/P9qo2xsGd3mDnLyTPRBP31uRpEW6RX4BNaIJFms7yjw10r+pl04DO6KJpCfGvGlnGHyIJx3d8hc548Z3REvxWf2NcLs7Ryy07t4jLYXSOWJnwQ47Tj6OyzDT74VgUqgEY3Tp23iQ+0NnNTntjxHWmBJ5XD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXBlGWOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE364C433C7;
	Fri, 19 Jan 2024 13:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705672551;
	bh=jgZ0z2QKaNKrU+JKlKY9qTzQooHXYwJjeK1yGSStXZk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cXBlGWOO0305zMrxJguYt57X+vjPv6XtPifLd8RjOlbjBHNF2hBgwJs/rGDUTEcJM
	 CKZlBejGfftDHiwdWOwt8LD941sWtY005ceDVmv3dap9Bn3JeJheIz9gFpIidQOqzF
	 RFRzXv3ZXSJyB19S682x2qbMcu/3/iRqJ7CIshyET0By513P5a55KiDiGcOMdxiimI
	 9DwMLs4mYTRxvSWZ018gGiJljOovSDESLktWpardVFRKbH64vN9YCV68UrH1AfC/by
	 wstoLQNFZLlGiYy+mcE7LmdxDTrCRCXXC3zs1CQFkcSKI4D/xbmIXvjRcV0DYeJgKs
	 9lMi+9dUC5PlA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ccea11b6bbso8232261fa.0;
        Fri, 19 Jan 2024 05:55:51 -0800 (PST)
X-Gm-Message-State: AOJu0YxX/WxwRwToDhYPAAmOtE7WrriFCxS+ylHvK/h5usHRT74QYWvV
	00iT2EPdjDRFT5IeJMzICc3ODqDigZcKTEU09Rzj3BcPxgigM3WhFL+/e/2hmxaKiUqC6l3SU3j
	h4ObflFKslCbkgUmYA96myjiJ2w==
X-Google-Smtp-Source: AGHT+IEVzox0T3UNZ1s/q0bwyluhqytK0MXD5RL8+PG4FTb/u1g+NhvPdEPFxzfRUfz/oFVzAvdiLjJG4UIJRX+yEAw=
X-Received: by 2002:a2e:88cc:0:b0:2cd:fb91:4b1d with SMTP id
 a12-20020a2e88cc000000b002cdfb914b1dmr730918ljk.21.1705672549835; Fri, 19 Jan
 2024 05:55:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116134142.2092483-1-devarsht@ti.com> <20240116134142.2092483-2-devarsht@ti.com>
 <20240117201342.GA3041972-robh@kernel.org> <57805224-f4f9-7773-03e3-4bdff8936c9c@ti.com>
In-Reply-To: <57805224-f4f9-7773-03e3-4bdff8936c9c@ti.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 19 Jan 2024 07:55:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKVMs92DkzVTmOuJzxzcm90SGOmwQXdk=kydBa5S_ySmg@mail.gmail.com>
Message-ID: <CAL_JsqKVMs92DkzVTmOuJzxzcm90SGOmwQXdk=kydBa5S_ySmg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] dt-bindings: display: ti,am65x-dss: Add support
 for display sharing mode
To: Devarsh Thakkar <devarsht@ti.com>
Cc: jyri.sarha@iki.fi, tomi.valkeinen@ideasonboard.com, airlied@gmail.com, 
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, 
	vigneshr@ti.com, kristo@kernel.org, praneeth@ti.com, a-bhatia1@ti.com, 
	j-luthra@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 7:59=E2=80=AFAM Devarsh Thakkar <devarsht@ti.com> w=
rote:
>
> Hi Rob,
>
> Thanks for the quick review.
>
> On 18/01/24 01:43, Rob Herring wrote:
> > On Tue, Jan 16, 2024 at 07:11:40PM +0530, Devarsh Thakkar wrote:
> >> Add support for using TI Keystone DSS hardware present in display
> >> sharing mode.
> >>
> >> TI Keystone DSS hardware supports partitioning of resources between
> >> multiple hosts as it provides separate register space and unique
> >> interrupt line to each host.
> >>
> >> The DSS hardware can be used in shared mode in such a way that one or
> >> more of video planes can be owned by Linux wherease other planes can b=
e
> >> owned by remote cores.
> >>
> >> One or more of the video ports can be dedicated exclusively to a
> >> processing core, wherease some of the video ports can be shared betwee=
n
> >> two hosts too with only one of them having write access.
> >>
> >> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> >> ---
> >>  .../bindings/display/ti/ti,am65x-dss.yaml     | 82 ++++++++++++++++++=
+
> >>  1 file changed, 82 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss=
yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> >> index 55e3e490d0e6..d9bc69fbf1fb 100644
> >> --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> >> +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> >> @@ -112,6 +112,86 @@ properties:
> >>        Input memory (from main memory to dispc) bandwidth limit in
> >>        bytes per second
> >>
> >> +  ti,dss-shared-mode:
> >> +    type: boolean
> >> +    description:
> >> +      TI DSS7 supports sharing of display between multiple hosts
> >> +      as it provides separate register space for display configuratio=
n and
> >> +      unique interrupt line to each host.
> >
> > If you care about line breaks, you need '|'.
> >
>
> Noted.
>
> >> +      One of the host is provided access to the global display
> >> +      configuration labelled as "common" region of DSS allows that ho=
st
> >> +      exclusive access to global registers of DSS while other host ca=
n
> >> +      configure the display for it's usage using a separate register
> >> +      space labelled as "common1".
> >> +      The DSS resources can be partitioned in such a way that one or =
more
> >> +      of the video planes are owned by Linux whereas other video plan=
es
> >
> > Your h/w can only run Linux?
> >
> > What if you want to use this same binding to define the configuration t=
o
> > the 'remote processor'? You can easily s/Linux/the OS/, but it all
> > should be reworded to describe things in terms of the local processor.
> >
>
> It can run both Linux and RTOS or for that matter any other OS too. But y=
es I
> got your point, will reword accordingly.
>
> >> +      can be owned by a remote core.
> >> +      The video port controlling these planes acts as a shared video =
port
> >> +      and it can be configured with write access either by Linux or t=
he
> >> +      remote core in which case Linux only has read-only access to th=
at
> >> +      video port.
> >
> > What is the purpose of this property when all the other properties are
> > required?
> >
>
> The ti,dss-shared-mode and below group of properties are optional. But
> if ti,dss-shared-mode is set then only driver should parse below set of
> properties.

Let me re-phrase. Drop this property. It serves no purpose since all
the properties have to be present anyway.

> >> +  ti,dss-shared-mode-planes:
> >> +    description:
> >> +      The video layer that is owned by processing core running Linux.
> >> +      The display driver running from Linux has exclusive write acces=
s to
> >> +      this video layer.
> >> +    $ref: /schemas/types.yaml#/definitions/string
> >> +    enum: [vidl, vid]
> >> +
> >> +  ti,dss-shared-mode-vp:
> >> +    description:
> >> +      The video port that is being used in context of processing core
> >> +      running Linux with display susbsytem being used in shared mode.
> >> +      This can be owned either by the processing core running Linux i=
n
> >> +      which case Linux has the write access and the responsibility to
> >> +      configure this video port and the associated overlay manager or
> >> +      it can be shared between core running Linux and a remote core
> >> +      with remote core provided with write access to this video port =
and
> >> +      associated overlay managers and remote core configures and driv=
es
> >> +      this video port also feeding data from one or more of the
> >> +      video planes owned by Linux, with Linux only having read-only a=
ccess
> >> +      to this video port and associated overlay managers.
> >> +
> >> +    $ref: /schemas/types.yaml#/definitions/string
> >> +    enum: [vp1, vp2]
> >> +
> >> +  ti,dss-shared-mode-common:
> >> +    description:
> >> +      The DSS register region owned by processing core running Linux.
> >> +    $ref: /schemas/types.yaml#/definitions/string
> >> +    enum: [common, common1]
> >> +
> >> +  ti,dss-shared-mode-vp-owned:
> >> +    description:
> >> +      This tells whether processing core running Linux has write acce=
ss to
> >> +      the video ports enlisted in ti,dss-shared-mode-vps.
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    enum: [0, 1]
> >
> > This can be boolean. Do writes abort or just get ignored? The latter ca=
n
> > be probed and doesn't need a property.
> >
>
> Although we have kept all these properties as enums, but actually in driv=
er we
> are treating them as array of enums and using device_property_read_u32_ar=
ray.
>
> The reason being that for SoCs using am65x-dss bindings they can only hav=
e
> single entry either vp1 or vp2 or 0 or 1 as there are only two video port=
s. So
> for them the device tree overlay would look like :
> &dss0 {
>
>         ti,dss-shared-mode;
>
>         ti,dss-shared-mode-vp =3D "vp1";
>
>         ti,dss-shared-mode-vp-owned =3D <0>;
>
>         ti,dss-shared-mode-common =3D "common1";
>
>         ti,dss-shared-mode-planes =3D "vid";
>
>         ti,dss-shared-mode-plane-zorder =3D <0>;
>
>         interrupts =3D <GIC_SPI 85 IRQ_TYPE_LEVEL_>;
> }
>
> But we also plan to extend these bindings to SoCs using
> Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml where ther=
e are
> multiple video ports. So in that the driver and bindings should support b=
elow
> configuration :

What are you waiting for? In that case, all these properties need to
be in a shared schema file and referenced here. Otherwise you will be
defining their types twice (and different types too if some are
changed to arrays).

> &dss0 {
>
>         ti,dss-shared-mode;
>
>         ti,dss-shared-mode-vp =3D "vp1 vp2";
>
>         ti,dss-shared-mode-vp-owned =3D <0 1>;
>
>         ti,dss-shared-mode-common =3D "common_s1";
>
>         ti,dss-shared-mode-planes =3D "vid1 vidl1";
>
>         ti,dss-shared-mode-plane-zorder =3D <0 1>;
>
>         interrupts =3D <GIC_SPI 85 IRQ_TYPE_LEVEL_>;
> }
>
> As I am using device_property_read_u32_array in driver I thought to keep =
this
> as uint32 in enum for am65x.yaml which works well with the driver.

The type and what accessor functions the kernel uses should match. I
plan to add (debug) checking on this. Debug only because as there's no
type info in the DTB, it all has to be extracted from schemas and put
into the kernel.

> >> +
> >> +  ti,dss-shared-mode-plane-zorder:
> >> +    description:
> >> +      The zorder of the planes owned by Linux.
> >> +      For the scenario where Linux is not having write access to asso=
ciated
> >> +      video port, this field is just for
> >> +      informational purpose to enumerate the zorder configuration
> >> +      being used by remote core.
> >> +
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    enum: [0, 1]
> >
> > I don't understand how 0 or 1 defines Z-order.
> >
>
> As there are only two planes in total so z-order can be either 0 or 1 for=
 the
> shared mode plane as there is only a single entry of plane.
> For e.g. if ti,dss-shared-mode-plane-zorder is 1 then it means the plane =
owned
> by Linux is programmed as topmost plane wherease the plane owned by remot=
e
> core is programmed as the underneath one.

Please reword the description to make all this clear. The index is the
plane number and value is the z-order with 0 being bottom and N being
the top. I guess this should be an array as well.

Rob

