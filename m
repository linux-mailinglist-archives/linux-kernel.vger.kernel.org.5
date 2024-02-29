Return-Path: <linux-kernel+bounces-87602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C35686D662
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435C61F22EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6086D51B;
	Thu, 29 Feb 2024 21:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0Vzm2Za"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20AC16FF45;
	Thu, 29 Feb 2024 21:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709243481; cv=none; b=LM10DkgLIrEzdE1z3oE1DQLmLBLAeJoJmlbWhmRXzt2zoNfr7t7DllYxmfvemJxduQaJwpf9ub6UrPa50WRLrTHjS7ndPT4oubJJervFq8qob/cLtSiPlsbcxuUB3qvbJJQanpFtUrbrrleljGScQJMfxOlTiZe93pjxSvrs1a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709243481; c=relaxed/simple;
	bh=/JuCSNceDgZCs4G3fk9bR8SQ0x8xeT/iIC9so5k9Td0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kW3KP1YcWbvSuhtFe1IEIIirYsb/b/2Vyzj1atsZ58GIjnJKtz60meWlhW32P/NhyuBf+W3XzoAAWTzwA1BvHZAbiuK3qBo3DCRQytJqKg0nZQn81EPCRBsBwHfKXa12eb8mlHuVRoTJaTWW+H3u0+hlIkoL9mkwRF3vE4C7a5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0Vzm2Za; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF59C433F1;
	Thu, 29 Feb 2024 21:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709243480;
	bh=/JuCSNceDgZCs4G3fk9bR8SQ0x8xeT/iIC9so5k9Td0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n0Vzm2ZayDGNrqnoFx14bdCqbyH4sYUechEdXzdXHrSOnQ0r2u8w6CSo4AR6kRUGf
	 6AsH1al4/Pgq/c2jOm5tWiJFwCMNMACCin4EjW4uUw2pwr7yWVA3ce2v4DLkyPbTUx
	 vjfsxD8be6GJmtjwLs5xGqIAAkyquAkXr+QuRXh60w4oCEPzcrcwsSsB1WLQHeYLvU
	 mARAwm2hIYC7aE5aaloJ1s2SodYjhfBJjxSF7MBL7lzq2+YA4c242X/kJUzQbOg55L
	 KSv1AlvBkFTQ+ojTpg+qMH96xnUVhHqtc8E9GWS7lB88Jy8KC1W8lhcCNesC+c4YaY
	 Fgdy9QGDAFxrQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513235b5975so1944127e87.2;
        Thu, 29 Feb 2024 13:51:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUcgKAI2BrGlBdUTcCHuQu4o+U4U6kZli5IbX2SxiToeG8EetgRk6q9j+EwfOP9SuSDccU9mcOgHaeXxMAvSagi4C/17KQETnrA31W7Z2pBciMc0YWzkfeHi8fT4vvlf3Uu7lLg/2V/Gg==
X-Gm-Message-State: AOJu0Yxf6seRwdXO9evpchb0IXdqkbr8fGes5fzkhkMskoiM/0QLcOpv
	OnS4XsK63312f4ycczLc9xs2WGotS2Gp7A52PMf6ohoN65C/rV1RuzogwBppWP/SiWrNyPC44U6
	t49s6o9MJBUYLf48VfMFiQhiNfA==
X-Google-Smtp-Source: AGHT+IEgAmEMhJUPUcWkgsCTCfNDwETKwjI/StgnU3JOWxnlp4NxhXCInDofBG9eHBmBiVwMpvurlMPzVz+/EYTnvHg=
X-Received: by 2002:a19:7516:0:b0:512:ec6e:9c67 with SMTP id
 y22-20020a197516000000b00512ec6e9c67mr2362718lfe.34.1709243418660; Thu, 29
 Feb 2024 13:50:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228062138.1275542-1-peng.fan@oss.nxp.com>
 <CAL_JsqJktYv+sSfwtT6ExsES5+HqB2BStnEMMRKVqTO3dFJm2Q@mail.gmail.com> <DU0PR04MB94177FFE211711E9DE4E9E51885F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB94177FFE211711E9DE4E9E51885F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 29 Feb 2024 15:50:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL4cb8NVOV9QF5__PtjyDUQd-MnuhJhbTHmUF3qr3x47w@mail.gmail.com>
Message-ID: <CAL_JsqL4cb8NVOV9QF5__PtjyDUQd-MnuhJhbTHmUF3qr3x47w@mail.gmail.com>
Subject: Re: [PATCH] of: dynamic: notify before revert
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "saravanak@google.com" <saravanak@google.com>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "pali@kernel.org" <pali@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 2:01=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: [PATCH] of: dynamic: notify before revert
> >
> > On Wed, Feb 28, 2024 at 12:13=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.n=
xp.com>
> > wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > When PCI node was created using an overlay and the overlay is
> > > reverted/destroyed, the "linux,pci-domain" property no longer exists,
> > > so of_get_pci_domain_nr will return failure. Then
> > > of_pci_bus_release_domain_nr will actually use the dynamic IDA, even
> > > if the IDA was allocated in static IDA.
> >
> > That usage is broken to begin with unless there is a guarantee that sta=
tic and
> > dynamic domain numbers don't overlap. For example, a dynamic number is
> > assigned and then you load an overlay with the same number defined in i=
t.
>
> I may not describe it clear, the code is here, because overlay property
> removed, of_get_pci_domain_nr will return failure, so the code path
> will goest into free a dynamic ida. But actually there is no such dynamic
> ida, so dump.

I understood the problem.

Your usage of this is broken on applying your overlay. You just got lucky.

> So the problem is overlay was removed, but the notify callback may
> still use the property to do some work.
>
> static void of_pci_bus_release_domain_nr(struct pci_bus *bus, struct devi=
ce *parent)
> {
>         if (bus->domain_nr < 0)
>                 return;
>
>         /* Release domain from IDA where it was allocated. */
>         if (of_get_pci_domain_nr(parent->of_node) =3D=3D bus->domain_nr)
>                 ida_free(&pci_domain_nr_static_ida, bus->domain_nr);
>         else
>                 ida_free(&pci_domain_nr_dynamic_ida, bus->domain_nr);
> }
> >
> > > So move the notify before revert to fix the issue.
> >
> > You can't just change the timing. Something might require notify to be =
after
> > the revert.

Again ^^^

> >
> > > Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
> >
> > I don't see where the notifier is even used.
>
> The stack is as below:
>
>  [  595.150529] CPU: 1 PID: 582 Comm: jailhouse Tainted: G           O   =
    6.5.0-rc4-next-20230804-05021-g3d4cc14b42ef-dirty #355
>  [  595.161998] Hardware name: NXP i.MX93 11X11 EVK board (DT)
>  [  595.167475] Call trace:
>  [  595.169908]  dump_backtrace+0x94/0xec
>  [  595.173573]  show_stack+0x18/0x24
>  [  595.176884]  dump_stack_lvl+0x48/0x60
>  [  595.180541]  dump_stack+0x18/0x24
>  [  595.183843]  pci_bus_release_domain_nr+0x34/0x84
>  [  595.188453]  pci_remove_root_bus+0xa0/0xa4
>  [  595.192544]  pci_host_common_remove+0x28/0x40
>  [  595.196895]  platform_remove+0x54/0x6c
>  [  595.200641]  device_remove+0x4c/0x80
>  [  595.204209]  device_release_driver_internal+0x1d4/0x230
>  [  595.209430]  device_release_driver+0x18/0x24
>  [  595.213691]  bus_remove_device+0xcc/0x10c
>  [  595.217686]  device_del+0x15c/0x41c
>  [  595.221170]  platform_device_del.part.0+0x1c/0x88
>  [  595.225861]  platform_device_unregister+0x24/0x40
>  [  595.230557]  of_platform_device_destroy+0xfc/0x10c
>  [  595.235344]  of_platform_notify+0x13c/0x178
>  [  595.239518]  blocking_notifier_call_chain+0x6c/0xa0
>  [  595.244389]  __of_changeset_entry_notify+0x148/0x16c
>  [  595.249346]  of_changeset_revert+0xa8/0xcc
>  [  595.253437]  jailhouse_pci_virtual_root_devices_remove+0x50/0x74 [jai=
lhouse]

$ git grep jailhouse_pci_virtual_root_devices_remove
(END)

Another out of tree overlay user. I have little interest in worrying
about them. No one wants to step up and solve the problems with
overlays, so I'm not going to worry about them either.

Rob

