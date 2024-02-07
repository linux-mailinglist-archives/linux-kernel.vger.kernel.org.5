Return-Path: <linux-kernel+bounces-56109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AD784C60D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482B81F252CD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCD3200D6;
	Wed,  7 Feb 2024 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LNiYmZzS"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614D5208BB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707293508; cv=none; b=Tar3suh224/gqpNlFJoVdRUg08FFwFiLlcQDX4buMQf/iUgglViBPyMZgHXWFYYNb1e3QcrTERsDsARn7LauPulN8E4TBG7nulZRoRhoA92ZFXBYBs6z1u1vxSkRDPYZ2YH/q8rSitRe5wT0hB2qVUITr0Za/o44jh88OV6aBsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707293508; c=relaxed/simple;
	bh=yM94QHmw1o0maJkiIwmeav8+O3mxI+fd1LvK6SRqfSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nb9OEQ3HI8C/eaQoLygKKKxwrAle3V7hRbHGZ00YW84YV4z6pDOYFF3GvZ/lWpxb7fOVe4R7cE5A6rqoXCK1cH2jgJKLPsRcG24GN+kAhPId4fOXjKWBEh3erXpw+6FtEOieXJnfr0e032/xDXUOTZwYhW/VvAlqkkt6i6jciIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LNiYmZzS; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59cb1e24e91so113701eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 00:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707293505; x=1707898305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yM94QHmw1o0maJkiIwmeav8+O3mxI+fd1LvK6SRqfSs=;
        b=LNiYmZzS6Ni+zqVUPWsmpsmC3jVVHEjuOMZ5gjF1ocbUviArUTu75cXOcUr2WWkbqa
         zk174+NqXwjWH+wY6e8OFb4zog8vzX2BB0Hw5QhHNrZM2hMn56MlVavhCP/crGuW3Hde
         mQ2/Mci9Nf5KM7EDUkUwDNJLmXlb7dI7s3noONYIKVHHal9F+rBGC5kWIDt7KnB9OW52
         57lIUt4QNUG1hX+32X4f4BF2KLxPjEi5rtvop3UOyfeZdGr/2cySeq3FVCHRfyjxYQ92
         b0Mmn+3PP/xJMEdEfWNnexno3ERYrQcnLNC/PCCXlBf+7hbkJzypdibB6+Bb+K7IzO2o
         vV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707293505; x=1707898305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yM94QHmw1o0maJkiIwmeav8+O3mxI+fd1LvK6SRqfSs=;
        b=AD7kmnJLubZ/gHN9GEsEXTG9hsuxVMZHE2cTRXMgfvNqy4msHLQx89qJjrUYmkLcEH
         a2ZXRBZ7UiEwwiKWAAS4I8A+t4gUjx1d0BYERqbY/w07Zo/KXU7JmefGeNuS/K9lv2DE
         48fAIVr65lX+oxiUOSKtLQGOgK4SZLozD9QhLO4pS/wXs+3xTPfKjN4g6ChxXpQVvWnu
         kHOPXQ7AEM3wX4eoxob5z8EfBZ3VljacBliiARim4FBnIsso04O6IbBXhn11DleWpfNv
         VYHXDu498T3cEOsw0HOy99wwcCmT5e5xPZk/q/I9JCqMyaKkwgdQO413p0uLtBJaJQOc
         EsuA==
X-Gm-Message-State: AOJu0YwhjKlfmZFHC/dMHpy4WGE3OhvlEdXnDFNFBr8q5tFqpkNd5jym
	UNks67hU5sQxs1HT9Qd3EhnTGNblg8+ZSw1plrEQhmnS5L+T32CEXIO/kmTQjO2o09gRNrW0xC0
	MTN6MMDiHX0xjOAx6PDyDccIGB+4sdu4GExARDQ==
X-Google-Smtp-Source: AGHT+IEuemO4RMAs3P1oHJa1czqpTD9ZZBHAnPyIamPveYQRfYNzaybhglwqBHuWsckLtJi99FEj2qDyRPGZkAhDOBE=
X-Received: by 2002:a4a:7650:0:b0:599:7389:967b with SMTP id
 w16-20020a4a7650000000b005997389967bmr5030396ooe.4.1707293505418; Wed, 07 Feb
 2024 00:11:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131174347.510961-1-jens.wiklander@linaro.org>
 <20240131174347.510961-2-jens.wiklander@linaro.org> <CAPDyKFqNhGWKm=+7niNsjXOjEJE3U=o7dRNG=JqpptUSo9G-ug@mail.gmail.com>
 <CAC_iWj+k_Vsz4ot=9pv-Gv7r11=vCunH5TSyOMTK4z-NZ2TeTA@mail.gmail.com>
 <CAFA6WYNQoRg0PWgr1oCzrkMens7e0=m_zkBSXKvp8JVjmn2OZQ@mail.gmail.com>
 <CAHUa44G+7HMNztQyYAWEhLFJvDBHDxPnqm+FRSVavb0NCyoYzg@mail.gmail.com> <CAFA6WYMNyw5GPji8XMMcPNHSkX5zXubsuVhauWHyGvBBQ3Mefw@mail.gmail.com>
In-Reply-To: <CAFA6WYMNyw5GPji8XMMcPNHSkX5zXubsuVhauWHyGvBBQ3Mefw@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 7 Feb 2024 09:11:34 +0100
Message-ID: <CAHUa44EnKCHXoPdmnyn3JSthNH=tnLa_LEwk_u797yBk=mFRAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 8:49=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> w=
rote:
>
> On Wed, 7 Feb 2024 at 12:56, Jens Wiklander <jens.wiklander@linaro.org> w=
rote:
> >
> > H,
> >
> > On Wed, Feb 7, 2024 at 7:11=E2=80=AFAM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> > >
> > > Hi Ilias, Ulf,
> > >
> > > On Tue, 6 Feb 2024 at 20:41, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Ulf,
> > > >
> > > > On Tue, 6 Feb 2024 at 14:34, Ulf Hansson <ulf.hansson@linaro.org> w=
rote:
> > > > >
> > > > > On Wed, 31 Jan 2024 at 18:44, Jens Wiklander <jens.wiklander@lina=
ro.org> wrote:
> > > > > >
> > > > > > A number of storage technologies support a specialised hardware
> > > > > > partition designed to be resistant to replay attacks. The under=
lying
> > > > > > HW protocols differ but the operations are common. The RPMB par=
tition
> > > > > > cannot be accessed via standard block layer, but by a set of sp=
ecific
> > > > > > RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY.=
 Such a
> > > > > > partition provides authenticated and replay protected access, h=
ence
> > > > > > suitable as a secure storage.
> > > > > >
> > > > > > The initial aim of this patch is to provide a simple RPMB Drive=
r which
> > > > > > can be accessed by the optee driver to facilitate early RPMB ac=
cess to
> > > > > > OP-TEE OS (secure OS) during the boot time.
> > > > >
> > > > > How early do we expect OP-TEE to need RPMB access?
> > > >
> > > > It depends on the requested services. I am currently aware of 2
> > > > services that depend on the RPMB
> > > > - FirmwareTPM
> > > > - UEFI variables stored there via optee.
> > > >
> > > > For the FirmwareTPM it depends on when you want to use it. This
> > > > typically happens when the initramfs is loaded or systemd requests
> > > > access to the TPM. I guess this is late enough to not cause problem=
s?
> > >
> > > Actually RPMB access is done as early as during fTPM probe, probably
> > > to cache NVRAM from RPMB during fTPM init. Also, there is a kernel
> > > user being IMA which would require fTPM access too. So we really need
> > > to manage dependencies here.
> > >
> > > >
> > > > For the latter, we won't need the supplicant until a write is
> > > > requested. This will only happen once the userspace is up and runni=
ng.
> > > > The UEFI driver that sits behind OP-TEE has an in-memory cache of t=
he
> > > > variables, so all the reads (the kernel invokes get_next_variable
> > > > during boot) are working without it.
> > > >
> > > > Thanks
> > > > /Ilias
> > > > >
> > > > > The way things work for mmc today, is that the eMMC card gets
> > > > > discovered/probed via a workqueue. The work is punted by the mmc =
host
> > > > > driver (typically a module-platform-driver), when it has probed
> > > > > successfully.
> > >
> > > It would be nice if RPMB is available as early as possible but for th=
e
> > > time being we can try to see if probe deferral suffices for all
> > > use-cases.
> > >
> > > > >
> > > > > The point is, it looks like we need some kind of probe deferral
> > > > > mechanism too. Whether we want the OP-TEE driver to manage this i=
tself
> > > > > or whether we should let rpmb_dev_find_device() deal with it, I d=
on't
> > > > > know.
> > >
> > > I wouldn't like to see the OP-TEE driver probe being deferred due to
> > > this since there are other kernel drivers like OP-TEE RNG (should be
> > > available as early as we can) etc. which don't have any dependency on
> > > RPMB.
> >
> > I agree, the optee driver itself can probe without RPMB.
> >
> > >
> > > How about for the time being we defer fTPM probe until RPMB is availa=
ble?
> >
> > Sounds a bit like what we do with the
> > optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP) call when
> > tee-supplicant has opened the supplicant device. It would perhaps work
> > with a PTA_CMD_GET_DEVICES_RPMB or such.
>
> That sounds much better, it will be like an OP-TEE driver callback
> (optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPMB)) registered with
> the RPMB subsystem. But we should check if all the RPMB partitions are
> registered before we invoke the callbacks such that OP-TEE will have a
> chance to select the right one.

I agree, we should wait until OP-TEE has found an RPMB device
programmed with the expected key as only OP-TEE should know that key.

Thanks,
Jens

>
> -Sumit
>
> >
> > Thanks,
> > Jens

