Return-Path: <linux-kernel+bounces-146674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 627C38A6916
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7A028447E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC3412839E;
	Tue, 16 Apr 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLxQCpcW"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB157127E32;
	Tue, 16 Apr 2024 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264813; cv=none; b=k5v4UjQc+dlgJRlQcUP8DsANjKWdwwwVds7fyZ4RX/gde2Pz0IuIntquzW+q3iJ1z5achOef3bx/XfU4p+7GQ8KqZSgEBq+FaGoMPO8o9Q/I8m8u+wFTdFd/vHrYI2RLAYxRuoS82GqhtgewV07vKzn6f3zKl2GZ948GwGmK0PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264813; c=relaxed/simple;
	bh=jtWDtkzCMWJkFCa5MxE8iceW5QpVbO75j7cOqW9Nvgo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u8ZNTBVi5pHzyMjXPPByeXpWtaIDFsmat2cHNIlJf5tJjVFdamJv98BWyWH4E9RZI9liJu1Frrr8tHy9gZjtKUWnLj7IDV9hfkcgNfk8CZMOxNqB9qXYk/wKB7muA2AnuhSZJLibYF70FAP0GFJBJo5pOsJYGXB97VDRjSavdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLxQCpcW; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2dae975d0dcso3052371fa.1;
        Tue, 16 Apr 2024 03:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713264810; x=1713869610; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zm8hUl4A4Cjijs+dM9CjArMkvrH+8PJgQST3vTyO9ro=;
        b=JLxQCpcW9Chi/BVIMzGsELJW9XUbmPNXF6YJyOqXdLpuLuitCfAS0o7PFoLY6+UDud
         dUX2og4YyI8iDvKiHxLsR95K5wdIaFPBJ9kvne6+XS1aRZI6Pa0bH1b6gEtHgRNr+6lF
         +uF6EgaXM+jHXyEIkJzkDOASe0YFvRT87PPtTMndCZNhoi2HXz0398lmc8djIg0f7myd
         DrrzlL7f0XNbC4Ii8EVh63Flc03V0DhyspkIPwt7R2T2FnL/N59PskTndlJh8eDLqM99
         /G0vBTwKVV/oDRlpwS2hCOTRVjwqRKZ1Qa3uku5vo4vHiZG+Mt5SfVoV6y9eEHi+Qt9C
         uBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713264810; x=1713869610;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zm8hUl4A4Cjijs+dM9CjArMkvrH+8PJgQST3vTyO9ro=;
        b=hMVf/UvcsY2qMLF901N6Ma+YlqDg9eNZoXcUoXsriVMEIYDAMnFmKOrorhuL8F8Zsk
         X7tkswdGuV56tYIjEXXcYAyRFB9Dw638ppwM5LdmVPtKoQMgIU13kefukWTHRZqXy6cL
         UwvDlzVhIa4nfBuYmWyUyvEimMAlrVqL92Y3t6+nFQ6S9EHaMDtRHe23KLw/yxPnVThM
         z9U/u7DyHNQZRusFQb4QCWYyI3uEN7rxBsrb1VCpee/ATKXvxcv26PHyobRWIR3GEaci
         uJzisIik1Dvt76DAAcF3+NiQNw8e+KZKJhpm9RXOelqJ7L1OXIFXlAOtPVgOJwuQVFLM
         r7xw==
X-Forwarded-Encrypted: i=1; AJvYcCWTnRR6nwWRRgvjqzVfjI5dNGuOHn3cmEpyFesuUbE3aL/2KnjJcGMMwcew21Lkc333DhvhbO77Lh/y1BeQBppk53tCYDCcqnDzDpK9FBKN3jYNrJlFozfIogHWVvAAt+m8A55+XZVYgO4PyoxRurghyDcdevCet/FQt8KAZbIx0A==
X-Gm-Message-State: AOJu0YyIYVpIxfho5yW05oofpZJFw0ThxSq3tkDmeYna8WX02hAllrCV
	AoDpzVHz3fQciC4OEergLQcALY4PGVOo0Fuh1+KzXMFSiKRYVbUg
X-Google-Smtp-Source: AGHT+IG1iJoGjPDJ4imF8qZcuHLYYvbel182S43/J10hP1dvRLvswmx977CJlc4KOlTyLvqTPU+m9A==
X-Received: by 2002:a2e:9590:0:b0:2da:daa9:8060 with SMTP id w16-20020a2e9590000000b002dadaa98060mr497005ljh.14.1713264809644;
        Tue, 16 Apr 2024 03:53:29 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e622:f700:a0:8eb2:ecf5:17e0? ([2001:8a0:e622:f700:a0:8eb2:ecf5:17e0])
        by smtp.gmail.com with ESMTPSA id e1-20020a2e9301000000b002d70a040f21sm1532062ljh.91.2024.04.16.03.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:53:29 -0700 (PDT)
Message-ID: <564fa534b32f4a6e96da6752f531fc7447ec633d.camel@gmail.com>
Subject: Re: [PATCH v1] arm64: dts: imx8mm: fix missing pgc_vpu_* power
 domain parent
From: Vitor Soares <ivitro@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,  Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 16 Apr 2024 11:53:26 +0100
In-Reply-To: <c76d98a300a9d65d236d334da62916a7d658ef27.camel@gmail.com>
References: <20240409085802.290439-1-ivitro@gmail.com>
	 <9ce35b9bb5a15891f6bd01bd54b7dc84b3ba4021.camel@pengutronix.de>
	 <e1552a3008a30ef7ed9097b4b80cda23ccb9e840.camel@gmail.com>
	 <fcd6acc268b8642371cf289149b2b1c3e90c7f45.camel@pengutronix.de>
	 <bd4d7198e58bd89b46a4c721546f6975b287a5fc.camel@gmail.com>
	 <c76d98a300a9d65d236d334da62916a7d658ef27.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

++ Peng Fan <peng.fan@nxp.com>

Greetings,


On Wed, 2024-04-10 at 12:01 +0100, Vitor Soares wrote:
> Hi Lucas,
>=20
> On Tue, 2024-04-09 at 17:44 +0100, Vitor Soares wrote:
> > On Tue, 2024-04-09 at 16:36 +0200, Lucas Stach wrote:
> > > Am Dienstag, dem 09.04.2024 um 14:22 +0100 schrieb Vitor Soares:
> > > > Hi Lucas,
> > > >=20
> > > > Thanks for your feedback.
> > > >=20
> > > > On Tue, 2024-04-09 at 11:13 +0200, Lucas Stach wrote:
> > > > > Hi Vitor,
> > > > >=20
> > > > > Am Dienstag, dem 09.04.2024 um 09:58 +0100 schrieb Vitor
> > > > > Soares:
> > > > > > From: Vitor Soares <vitor.soares@toradex.com>
> > > > > >=20
> > > > > > The pgc_vpu_* nodes miss the reference to the power domain
> > > > > > parent,
> > > > > > leading the system to hang during the resume.
> > > > > >=20
> > > > > This change is not correct. The vpumix domain is controlled
> > > > > through
> > > > > the
> > > > > imx8mm-vpu-blk-ctrl and must not be directly triggered by the
> > > > > child
> > > > > domains in order to guarantee proper power sequencing.
> > > > >=20
> > > > > If the sequencing is incorrect for resume, it needs to be
> > > > > fixed
> > > > > in
> > > > > the
> > > > > blk-ctrl driver. I'll happily assist if you have any
> > > > > questions
> > > > > about
> > > > > this intricate mix between GPC and blk-ctrl hardware/drivers.
> > > > =C2=A0
> > > > I'm new into the topic, so I tried to follow same approach as
> > > > in
> > > > imx8mp
> > > > DT.
> > > >=20
> > > That's a good hint, the 8MP VPU GPC node additions missed my
> > > radar.
> > > The
> > > direct dependency there between the GPC domains is equally wrong.
> > >=20
> > > > I also checked the imx8mq DT and it only have one domain for
> > > > the
> > > > VPU in the GPC. It seem blk-ctrl also dependes on pgc_vpu_* to
> > > > work
> > > > properly.
> > > >=20
> > > > The blk-ctrl driver hangs on imx8m_blk_ctrl_power_on() when
> > > > access
> > > > the
> > > > ip registers for the soft reset. I tried to power-up the before
> > > > the
> > > > soft reset, but it didn't work.
> > > >=20
> > > The runtime_pm_get_sync() at the start of that function should
> > > ensure
> > > that bus GPC domain aka vpumix is powered up. Can you check if
> > > that
> > > is
> > > happening?
> >=20
> > I checked bc->bus_power_dev->power.runtime_status and it is
> > RPM_ACTIVE.
> >=20
> > Am I looking to on the right thing? It is RPM_ACTIVE event before
> > runtime_pm_get_sync().
>=20
> During the probe I can see that
> bus_power_dev->power.runtime_status =3D RPM_SUSPENDED and then vpumix
> is
> powered up on GPC driver.
>=20
> On resume routine I can't see this flow. bus_power_dev-
> > power.runtime_status =3D RPM_ACTIVE and vpumix end up not being
> > powered-
> up.
>=20
> I checked the suspend flow and the GPC tries to poweroff vpumix.
>=20
>=20

My understanding is that when resuming the 38310000.video-codec, the
vpumix isn't powered up. It happens because runtime_status and
runtime_last_status =3D RPM_ACTIVE.=20

I tried to change blk-ctrl suspend routine to force the runtime_status
=3D RPM_SUSPENDED, but the system ended up hanging on another device.

From the comment in blk-ctrl suspend, we rely on PM_SLEEP code that
iterates over dpm_list for suspend/resume.
I did look at the dpm_list, and it changes the order on every boot.=20

With all the tests, I also found that the system randomly hangs on
dispblk-lcdif suspend. I have confirmed this device is in a different
place in the dpm_list (not sure if it is the root cause).=20
I haven't understood how blk-ctrl ensures the correct order there yet.=20

Taking the following dpm_list excerpt:
idx - device
------------------------------
..                                                                  =20
191 - imx-pgc-domain.7                                               =20
192 - imx-pgc-domain.8                                               =20
193 - imx-pgc-domain.9                                               =20
194 - 38330000.blk-ctrl                                              =20
195 - 38310000.video-codec                                           =20
196 - 38300000.video-codec                                           =20
..
205 - genpd:0:38330000.blk-ctrl
206 - genpd:1:38330000.blk-ctrl
207 - genpd:2:38330000.blk-ctrl
208 - genpd:3:38330000.blk-ctrl
------------------------------

Shouldn't genpd devices be before 38330000.blk-ctrl?
As their power domain is GPC and the blk-ctrl power domain is genpd.

Best regards,
Vitor Soares

>=20
> >=20
> >=20
> > >=20
> > > Regards,
> > > Lucas
> > >=20
> > > > Do you have an idea how we can address this within blk-ctrl?
> > > >=20
> > > > Best regards,
> > > > Vitor
> >=20
>=20


