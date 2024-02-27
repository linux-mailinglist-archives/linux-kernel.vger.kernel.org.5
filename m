Return-Path: <linux-kernel+bounces-83930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BA486A032
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E6F283DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E36F51C3F;
	Tue, 27 Feb 2024 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNQSehSQ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A0EEEDD;
	Tue, 27 Feb 2024 19:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062130; cv=none; b=jX4Ov3sImjh6087NUi017l0sO/JozsOeRVAmPPAnnsN4PjWZMXPOjqVmSqNLfrZuumuuEg4xHIQXs2TbS74z8qAp20G0bcx40rUJvfsuPPtCDpGOKelwikgiLCT+LmF0K2kN1RuekGdHsChccjsoQPlzL8Q6lvNDps2ogTDWuNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062130; c=relaxed/simple;
	bh=pndNK23EIS8yS94mYdax/9ufOaJezvaCo8KDF1SR/fU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e+yXorNmjhM+jh5tS7CclQlfQw5KQUwM9UYWQBnCGios0kiVfiq4xKCHD/z9NZSE7efg/8nEQY2BNCbkVtEAVk7Y/ZxYIYVLHEl0Vz94mR8xLfewuSrkDUS7yUwiGVEg5djtVI6Tbi5FtW1f88fg92GGDafleGtQ9zFWzapGEyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNQSehSQ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512b3b04995so4762720e87.3;
        Tue, 27 Feb 2024 11:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709062127; x=1709666927; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pndNK23EIS8yS94mYdax/9ufOaJezvaCo8KDF1SR/fU=;
        b=fNQSehSQdzd1aWDQe9oEQsAc2xDAp/42DqAAQQJNvogzZiJYYqqoouEPf42De6kbiW
         I+dzistCL20lztTX0eyI+fF6ZXHTL8PT1Prl/fBP0KEBw57TT+G8fb95yeo8iNHIR6uF
         6omsoUZvzroBZx/A7yc6R4/2DAVs5mAM0AHRKG9hWKF7z/W6OyjqQTZ7viWsIEgjmwx9
         QKqstFmvzYDPnKvd+ngslU5olJ6fhNDbnx9UhVYhrE4xLklYAUEOK/7wMb1mVza2V8P6
         UtNFSAiD5XNCxciCOQXtSXZTKPE2cj9AiZCmyyc1yN+Y4GPEt/hiJoaeGsBHyl59r3p+
         +/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709062127; x=1709666927;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pndNK23EIS8yS94mYdax/9ufOaJezvaCo8KDF1SR/fU=;
        b=JmfY/Sb0ge/RmobawYXOjwxPNFoQWn82+2sRSgTcgoCtma6Qj8Oc2Nt1L9NNoUMmP2
         VknlkqZ1+yRmuvIEvRdsD+u3eeygHsi5i4whkpmbCzY+XsYniXman3CO2EeL7m8Xf/GF
         CNWSBjdHOg0aLY1XbLXLZ7RC/z/uMdMjX0/CjiB743dZuZr1nN0qMqVG14FTWFE27r0d
         p5/g6JBeRKCDwMW52IMAKBOFUaFKAFAsPQgwc+tUY5ln8Q/3M+JuWgcGgXp2Y2phuqao
         X7MeTwnjiLRh2FP6pTFOdFAOyequUqeG2khntzvgv7vU282Ann0lvHHk1FsJJqDh6qrD
         M35g==
X-Forwarded-Encrypted: i=1; AJvYcCXy2VILnuCjJQD4UwS90DDBdGokucO+r98KVFalkqbD3S75OceQ/HgkkQLhKwHIj2ZFq/I3gYQ111eCy/PPYfLBpZI97eHstx218c0bkdV7YoeRla42vkNgOaTUvQ5Z0KYg3fMZJO8PZg==
X-Gm-Message-State: AOJu0YyWaSKJNC8WtU+Vueh6dFAn91x/88KfLMWg50rw8rH2U+usWUs7
	3V4um11jok4ysIh5lE4nbRaJoP5/+rkVS+7DFRg9kAdrTirDmuBL
X-Google-Smtp-Source: AGHT+IEypVdWuFnKgfGXEM4Vy3jh3uLaE7FMx24Rrh4joRZdOOF5qJtKP/tr4ZJCuGJRa+3LPs97WA==
X-Received: by 2002:a05:6512:3c8f:b0:513:14a0:c with SMTP id h15-20020a0565123c8f00b0051314a0000cmr1297088lfv.42.1709062126427;
        Tue, 27 Feb 2024 11:28:46 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id t10-20020aa7d70a000000b00566626a355bsm2644edq.27.2024.02.27.11.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 11:28:46 -0800 (PST)
Message-ID: <f3c741dc9d869212dec10049e8b0167ff350c5e0.camel@gmail.com>
Subject: Re: [PATCH 2/2] of: overlay: Synchronize of_overlay_remove() with
 the devlink removals
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>, Saravana Kannan
 <saravanak@google.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Nuno Sa
 <nuno.sa@analog.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob
 Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Lizhi
 Hou <lizhi.hou@amd.com>,  Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>,  Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Android Kernel Team
 <kernel-team@android.com>
Date: Tue, 27 Feb 2024 20:28:45 +0100
In-Reply-To: <CAJZ5v0jE8QfSrs1uqgU7RceGWbT12YymouAOhsb7WxKmMbGeGg@mail.gmail.com>
References: <20231130174126.688486-1-herve.codina@bootlin.com>
	 <20231130174126.688486-3-herve.codina@bootlin.com>
	 <CAGETcx_zB95nyTpi-_kYW_VqnPqMEc8mS9sewSwRNVr0x=7+kA@mail.gmail.com>
	 <20240227162422.76a00f11@bootlin.com>
	 <86f2262d059db84070745e299d96dde3e6078220.camel@gmail.com>
	 <20240227185402.57a3b924@bootlin.com>
	 <9ae28df7a4770bf94358dac36fd5e0942877f147.camel@gmail.com>
	 <CAJZ5v0jE8QfSrs1uqgU7RceGWbT12YymouAOhsb7WxKmMbGeGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-27 at 20:13 +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 27, 2024 at 8:08=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >=20
> > Hi Herve,
> >=20
> > On Tue, 2024-02-27 at 18:54 +0100, Herve Codina wrote:
> > > Hi Nuno,
> > >=20
> > > On Tue, 27 Feb 2024 17:55:07 +0100
> > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > >=20
> > > > On Tue, 2024-02-27 at 16:24 +0100, Herve Codina wrote:
> > > > > Hi Saravana, Luca, Nuno,
> > > > >=20
> > > > > On Tue, 20 Feb 2024 16:37:05 -0800
> > > > > Saravana Kannan <saravanak@google.com> wrote:
> > > > >=20
> > > > > ...
> > > > >=20
> > > > > > >=20
> > > > > > > diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> > > > > > > index a9a292d6d59b..5c5f808b163e 100644
> > > > > > > --- a/drivers/of/overlay.c
> > > > > > > +++ b/drivers/of/overlay.c
> > > > > > > @@ -1202,6 +1202,12 @@ int of_overlay_remove(int *ovcs_id)
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > >=20
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Wait for any on=
going device link removals before removing
> > > > > > > some
> > > > > > > of
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * nodes
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_link_wait_remova=
l();
> > > > > > > +
> > > > > >=20
> > > > > > Nuno in his patch[1] had this "wait" happen inside
> > > > > > __of_changeset_entry_destroy(). Which seems to be necessary to =
not hit
> > > > > > the issue that Luca reported[2] in this patch series. Is there =
any
> > > > > > problem with doing that?
> > > > > >=20
> > > > > > Luca for some reason did a unlock/lock(of_mutex) in his test pa=
tch and
> > > > > > I don't think that's necessary.
> > > > >=20
> > > > > I think the unlock/lock in Luca's case and so in Nuno's case is n=
eeded.
> > > > >=20
> > > > > I do the device_link_wait_removal() wihout having the of_mutex lo=
cked.
> > > > >=20
> > > > > Now, suppose I do the device_link_wait_removal() call with the of=
_mutex
> > > > > locked.
> > > > > The following flow is allowed and a deadlock is present.
> > > > >=20
> > > > > of_overlay_remove()
> > > > > =C2=A0 lock(of_mutex)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 device_link_wait_removal()
> > > > >=20
> > > > > And, from the workqueue jobs execution:
> > > > > =C2=A0 ...
> > > > > =C2=A0=C2=A0=C2=A0 device_put()
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 some_driver->remove()
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of_overlay_remove() <-=
-- The job will never end.
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 It is waiting for of=
_mutex.
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Deadlock
> > > > >=20
> > > >=20
> > > > We may need some input from Saravana (and others) on this. I might =
be missing
> > > > something but can a put_device() lead into a driver remove callback=
? Driver
> > > > code
> > > > is
> > > > not device code and put_device() leads to device_release() which wi=
ll either
> > > > call
> > > > the
> > > > device ->release(), ->type->release() or the class ->dev_release().=
 And, IMO,
> > > > calling
> > > > of_overlay_remove() or something like that (like something that wou=
ld lead to
> > > > unbinding a device from it's driver) in a device release callback w=
ould be at
> > > > the
> > > > very least very questionable. Typically, what you see in there is
> > > > of_node_put()
> > > > and
> > > > things like kfree() of the device itself or any other data.
> > >=20
> > > I think that calling of_overlay_remove() in a device release callback=
 makes
> > > sense. The overlay is used to declare sub-nodes from the device node.=
 It
> > > does not add/remove the device node itself but sub-nodes.
> > >=20
> >=20
> > I think we are speaking about two different things... device release is=
 not the
> > same
> > as the driver remove callback. I admit the pci case seems to be a beast=
 of it's
> > own
> > and I just spent some time (given your links) on it so I can't surely b=
e sure
> > about
> > what I'm about to say... But, AFAICT, I did not saw any overlay or chan=
geset
> > being
> > removed from a kobj_type release callback.
> >=20
> > > The use case is the use of DT overlays to describe PCI devices.
> > > https://lore.kernel.org/all/1692120000-46900-1-git-send-email-lizhi.h=
ou@amd.com/
> > > https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bo=
otlin.com/
> > > --- 8< ---
> > > The lan966x SoCs can be used in two different ways:
> > >=20
> > > =C2=A0- It can run Linux by itself, on ARM64 cores included in the So=
C. This
> > > =C2=A0=C2=A0 use-case of the lan966x is currently being upstreamed, u=
sing a
> > > =C2=A0=C2=A0 traditional Device Tree representation of the lan996x HW=
 blocks [1]
> > > =C2=A0=C2=A0 A number of drivers for the different IPs of the SoC hav=
e already
> > > =C2=A0=C2=A0 been merged in upstream Linux.
> > >=20
> > > =C2=A0- It can be used as a PCIe endpoint, connected to a separate pl=
atform
> > > =C2=A0=C2=A0 that acts as the PCIe root complex. In this case, all th=
e devices
> > > =C2=A0=C2=A0 that are embedded on this SoC are exposed through PCIe B=
ARs and the
> > > =C2=A0=C2=A0 ARM64 cores of the SoC are not used. Since this is a PCI=
e card, it
> > > =C2=A0=C2=A0 can be plugged on any platform, of any architecture supp=
orting PCIe.
> > > --- 8< ---
> > >=20
> > > This quite long story led to DT overlay support for PCI devices and s=
o the
> > > unittest I mentioned:
> > > =C2=A0 https://elixir.bootlin.com/linux/v6.8-rc6/source/drivers/of/un=
ittest.c#L3946
> > >=20
> > >=20
> > > So, I have a PCI driver that bind to the lan966x PCI board.
> > > This driver loads an overlay at probe() and unload it at remove().
> > > Also, this driver can be module. A simple rmmod leads to the remove()=
 call.
> > >=20
> >=20
> > Hmm, and I think that would not be an issue... Note that the code that =
runs in
> > device_link_release_fn() is doing put_device() which ends ups on the ko=
bj_type
> > release callback and so far I could not see any evidence of such a call=
back being
> > responsible of calling device_remove() on another device. That would be=
 weird (I
> > think) since I would expect such a call to happen in a kind of unregist=
er
> > function.
> >=20
> > > This driver is not yet upstream because I haven't yet fixed all the i=
ssues I
> > > encountered that's why of now, I can point only the unittest related =
to overlay
> > > support for PCI.
> > >=20
> > > >=20
> > > > The driver remove callback should be called when unbinding the devi=
ce from
> > > > it's
> > > > drivers and devlinks should also be removed after device_unbind_cle=
anup()
> > > > (i.e,
> > > > after
> > > > the driver remove callback).
> > > >=20
> > > > Having said the above, the driver core has lots of subtleties so, a=
gain, I
> > > > can be
> > > > missing something. But at this point I'm still not seeing any deadl=
ock...
> > > >=20
> > >=20
> > > I gave a wrong example.
> > > Based on Luca's sequence he gave in
> > > =C2=A0 https://lore.kernel.org/all/20231220181627.341e8789@booty/
> >=20
> > Regarding Luca's comments, my first approach was actually to just make =
the
> > devlink
> > removal synchronously... I'm still not sure what would be the issue of =
doing that
> > (other than potentially waiting some time for the srcu synchronization)=
.
>=20
> It would allow forward progress to be made, but it would add potential
> delay for everybody, which is only really needed in the DT overlay
> case.=C2=A0 Sounds like something to avoid to me.

I mean, we could surely detect (or have a way to do it) if the devlink is b=
eing
removed as part of an overlay removal and only call device_link_release_fn(=
)
synchronously in that case. It would minimize the effects I guess.

But yeah, we still need to make sure there's an actual deadlock... I'm stil=
l not
seeing it but Herve may very well be correct about it.

>=20
> > About the unlock, I'm just not sure what could happen if someone else (=
other than
> > us) sneaks in
> > and grabs the of_mutex while we are in the middle of removing an overla=
y...
>=20
> If that is possible at all, I'd call it a bug.

I think, in theory, it could happen as it looks to be a fairly coarse grain=
ed lock
for OF:

https://elixir.bootlin.com/linux/latest/source/drivers/of/of_private.h#L40

- Nuno S=C3=A1=20

