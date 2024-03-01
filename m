Return-Path: <linux-kernel+bounces-89215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E16DE86EC9D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FA228802A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B0C5EE82;
	Fri,  1 Mar 2024 23:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyApand6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DF01F16B;
	Fri,  1 Mar 2024 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709334339; cv=none; b=fZlzKAqswjlCQKwl0Vq1TXfx/QpT8x6GgObYYqCLeWTEVqwfbtAry30HYgdsQysiTSgegXxvhXr9PH+gZCK4RoF1bEC4ffw8XfVIooc6tIgwlZfkNF+vtdDc7D4kCqmfM0s55c0265CYMmlQ1tCh9oSDbJnRs/MqLq51ec4q1j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709334339; c=relaxed/simple;
	bh=1wHBV3+ScYtLUNAXwGGPEnRrUacQTReGxON5TeeDW2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPQJx49LWkKQSD37aFP9AsKbz3NXDuym3XbXv7cH27fxitk7OSl0hE9zqmyjdi35E/2EFK1IsiShDgm7SbUViDYMqbOYL0z6UTjYq0wfiD33YaOSh83tOjRQ8jFbq2DseY09yc9FL9NoNWo1Coz6x94CdU7FBB5CrYfw6TkOfec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyApand6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A50DC43394;
	Fri,  1 Mar 2024 23:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709334339;
	bh=1wHBV3+ScYtLUNAXwGGPEnRrUacQTReGxON5TeeDW2Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dyApand6fpSIYi5mrXLtftnBF8X9eE3ub8/k54U5N69kyLMgKtTr8A6ryykNrJaXP
	 C6BAQy6wyHY/5pRkFx1EbWm35N4EIq/Lm/v51AxIWqZNhWq260tVQqh8QPqlZnjZYT
	 RGoDPnYzSjtZoAKDl3gQZ12iEKBSwJgfVYHh8SOxkjyJvDps7Y9fA9dXO+te3TWn12
	 fFBuSbln1hi9Ce15/VTQYoISYluGhEE2aIQmuVJwGmPIiCaOP5z56YtUXyCskToLxU
	 Efd5s/DG6lAkfeGVoReLEe0s37lw1z71pbNAT1hHbYJd+tAM87LZ9T9nGHCr8Ni4oO
	 5nTR/gA/k4qxg==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so29346171fa.3;
        Fri, 01 Mar 2024 15:05:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFQTQcLV74AyjX2/cnD3HooTwWeMRLoQ4Hgas5drB6jJZy+umot7tBN45IUnKZqOBknujWjcQ4YWwmJWA+tFy4THaPKHwffSaRRKYH4GArh+2X+++B8mMzpqd679P8PhOn5VYokdoiDA==
X-Gm-Message-State: AOJu0Ywt2HF13et/rrZCHubIE8j0lp7ebQTzNdsMmcJ1HnsikavShQQD
	kEWNRURFwsRH2NGWWZbduYlOTsrIKhx+dKJ3S1DvQMRUTmU2H14AO92GebM6p9+JiTyV1VLMyd9
	enllU5OYp1+G/QPf+QTDsTTj1hw==
X-Google-Smtp-Source: AGHT+IFBhd1kNgwLtOZsgKK4s95iFDIpiL/NdG94diCtW5N95uJ0lDfyA+DX53RZRbEe8Dy/osoHthsBMgRoA6//dwY=
X-Received: by 2002:a2e:2c13:0:b0:2d2:2dbb:389e with SMTP id
 s19-20020a2e2c13000000b002d22dbb389emr2078375ljs.23.1709334337256; Fri, 01
 Mar 2024 15:05:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228062138.1275542-1-peng.fan@oss.nxp.com>
 <CAL_JsqJktYv+sSfwtT6ExsES5+HqB2BStnEMMRKVqTO3dFJm2Q@mail.gmail.com>
 <DU0PR04MB94177FFE211711E9DE4E9E51885F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAL_JsqL4cb8NVOV9QF5__PtjyDUQd-MnuhJhbTHmUF3qr3x47w@mail.gmail.com> <DU0PR04MB9417003D9DA15FAD08084894885E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417003D9DA15FAD08084894885E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 1 Mar 2024 17:05:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ6CNRS8H+afD5PeV1a=piomS7yUOWCYrPTKs7zWwAt2Q@mail.gmail.com>
Message-ID: <CAL_JsqJ6CNRS8H+afD5PeV1a=piomS7yUOWCYrPTKs7zWwAt2Q@mail.gmail.com>
Subject: Re: [PATCH] of: dynamic: notify before revert
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "saravanak@google.com" <saravanak@google.com>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "pali@kernel.org" <pali@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 9:04=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: [PATCH] of: dynamic: notify before revert
> >
> > On Thu, Feb 29, 2024 at 2:01=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wro=
te:
> > >
> > > > Subject: Re: [PATCH] of: dynamic: notify before revert
> > > >
> > > > On Wed, Feb 28, 2024 at 12:13=E2=80=AFAM Peng Fan (OSS)
> > > > <peng.fan@oss.nxp.com>
> > > > wrote:
> > > > >
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > When PCI node was created using an overlay and the overlay is
> > > > > reverted/destroyed, the "linux,pci-domain" property no longer
> > > > > exists, so of_get_pci_domain_nr will return failure. Then
> > > > > of_pci_bus_release_domain_nr will actually use the dynamic IDA,
> > > > > even if the IDA was allocated in static IDA.
> > > >
> > > > That usage is broken to begin with unless there is a guarantee that
> > > > static and dynamic domain numbers don't overlap. For example, a
> > > > dynamic number is assigned and then you load an overlay with the sa=
me
> > number defined in it.
> > >
> > > I may not describe it clear, the code is here, because overlay
> > > property removed, of_get_pci_domain_nr will return failure, so the
> > > code path will goest into free a dynamic ida. But actually there is n=
o
> > > such dynamic ida, so dump.
> >
> > I understood the problem.
> >
> > Your usage of this is broken on applying your overlay. You just got luc=
ky.
>
> Would you please point me out where is broken on using overlay?
>
> https://github.com/siemens/jailhouse/blob/master/driver/pci.c#L458

I'm not saying your exact use is broken. Obviously, it worked for you.
In general, it is fragile. What happens with the following
combination?:

base.dts:
{
  pci@0 {
    linux,pci-domain =3D <0>;
  };
  pci@1 {
    /* dynamic domain allocs domain 1 */
  };
};

overlay.dts:
{
  pci@0 {
    linux,pci-domain =3D <1>;
  };
};

The only way this can work is if the overlay linux,pci-domain is
ignored if there's a conflict or you reserve first N ids for static
and dynamic ones start at N where N is "should be more than anyone
needs".


> > > So the problem is overlay was removed, but the notify callback may
> > > still use the property to do some work.
> > >
> > > static void of_pci_bus_release_domain_nr(struct pci_bus *bus, struct
> > > device *parent) {
> > >         if (bus->domain_nr < 0)
> > >                 return;
> > >
> > >         /* Release domain from IDA where it was allocated. */
> > >         if (of_get_pci_domain_nr(parent->of_node) =3D=3D bus->domain_=
nr)
> > >                 ida_free(&pci_domain_nr_static_ida, bus->domain_nr);
> > >         else
> > >                 ida_free(&pci_domain_nr_dynamic_ida, bus->domain_nr);
> > > }
> > > >
> > > > > So move the notify before revert to fix the issue.
> > > >
> > > > You can't just change the timing. Something might require notify to
> > > > be after the revert.
> >
> > Again ^^^
> >
> > > >
> > > > > Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
> > > >
> > > > I don't see where the notifier is even used.
> > >
> > > The stack is as below:
> > >
> > >  [  595.150529] CPU: 1 PID: 582 Comm: jailhouse Tainted: G           =
O
> > 6.5.0-rc4-next-20230804-05021-g3d4cc14b42ef-dirty #355
> > >  [  595.161998] Hardware name: NXP i.MX93 11X11 EVK board (DT)  [
> > > 595.167475] Call trace:
> > >  [  595.169908]  dump_backtrace+0x94/0xec  [  595.173573]
> > > show_stack+0x18/0x24  [  595.176884]  dump_stack_lvl+0x48/0x60  [
> > > 595.180541]  dump_stack+0x18/0x24  [  595.183843]
> > > pci_bus_release_domain_nr+0x34/0x84
> > >  [  595.188453]  pci_remove_root_bus+0xa0/0xa4  [  595.192544]
> > > pci_host_common_remove+0x28/0x40  [  595.196895]
> > > platform_remove+0x54/0x6c  [  595.200641]  device_remove+0x4c/0x80  [
> > > 595.204209]  device_release_driver_internal+0x1d4/0x230
> > >  [  595.209430]  device_release_driver+0x18/0x24  [  595.213691]
> > > bus_remove_device+0xcc/0x10c  [  595.217686]  device_del+0x15c/0x41c
> > > [  595.221170]  platform_device_del.part.0+0x1c/0x88
> > >  [  595.225861]  platform_device_unregister+0x24/0x40
> > >  [  595.230557]  of_platform_device_destroy+0xfc/0x10c
> > >  [  595.235344]  of_platform_notify+0x13c/0x178  [  595.239518]
> > > blocking_notifier_call_chain+0x6c/0xa0
> > >  [  595.244389]  __of_changeset_entry_notify+0x148/0x16c
> > >  [  595.249346]  of_changeset_revert+0xa8/0xcc  [  595.253437]
> > > jailhouse_pci_virtual_root_devices_remove+0x50/0x74 [jailhouse]
> >
> > $ git grep jailhouse_pci_virtual_root_devices_remove
> > (END)
> >
> > Another out of tree overlay user. I have little interest in worrying ab=
out them.
> > No one wants to step up and solve the problems with overlays, so I'm no=
t
> > going to worry about them either.
>
> Ok, but I think this is indeed an issue, if driver accessing property aft=
er
> property removed with overlay revert.

A pre-remove notifier might be useful, but as I said, you can't just
remove the post-remove notifier without some justification why no one
needs it. Notifiers aren't the best construct in the kernel, so adding
to them isn't really desired either. Also, I think there are 2 other
issues with the design here:

Generally, the code should read the DT once upfront and not need the
DT later on. So needing to access the DT on removal is kind of
suspect. That's like needing to read USB device descriptors after a
USB device is unplugged.

It also seems like the driver should hold a reference to the DT
node(s) it needs to prevent removal until it no longer needs them. Not
sure if the node refcount would be enough or we need something more.

Rob

