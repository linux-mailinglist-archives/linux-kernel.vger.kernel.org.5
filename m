Return-Path: <linux-kernel+bounces-92607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBCD8722CD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68FAD28128D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7455D1272CF;
	Tue,  5 Mar 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CItfI8oH"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C12C1272BD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652627; cv=none; b=tPhHqadaG5RIWCuwGy/ebrnH3A9wEl+Y1ePT1KAuOLFBLkvHyWXBlMIAh315boFjy8SP8xI+87RvgLurF4VHwVnNggHNTF3pbSCeQJquTNg3eK4tkH2WIFJ/NbODRVzfgu8CAPI7hXSPr2lnqu0WbPG8LhzryW5rxdbXiWSdLgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652627; c=relaxed/simple;
	bh=h1qWJgukNhb6x74QzK47l9/kz0S0qysx0w18QZaOrio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXqigQkjDFeiFtSiSKHtYGG5Yn+L1UC5DjcHIhbMBoTFAgqqO1EPF0F0lZRhv65HKdzAAxkPfCBRCKWwHn7QeCnafdzmc/E3da1Vx7BAaFg6ZSJWcEobeNuYN6ElMgClx/8AqzMwmctnssMFcDy/BdRLthnc0yz2ziBfLvBxCfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CItfI8oH; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-214def5da12so3497477fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 07:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709652625; x=1710257425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVzMwD4DQOhd2AA1RQ0K70S/0JATIinWz2gy9l7GKtI=;
        b=CItfI8oHdvltTraQej2B5NOEhtO8qTt87GFx0DjUbd8I9r3FWmTSWlkdHw909GPxZO
         8/CJn36ctPOddMXzGV8MvynEK78bQRjMG1KHgx3ob2QItGoMcvpvEmYafqkBVwsMzFmc
         GpCXrWwsgBVjkJA4mRx+WXi1IpMbQlaAfYouVrCWfnwjs/t4/3lwUf3PdMKl0jfj1CCb
         Pryjx1zZdj2/qVCJOKV6rejpyP7iQDv5RMN2io60H5YhUv/VNZrU+Zjujjmy1JMDg++y
         kV35H+ByZ7oLRU/Ef8JfkLXiZ+A7m0sbeyrf1jWBG8ZhTdDTR4scdxynnLwYeDZqtHo3
         Wjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709652625; x=1710257425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVzMwD4DQOhd2AA1RQ0K70S/0JATIinWz2gy9l7GKtI=;
        b=aJeItzDyzx0N1FJ/mvkFdw0dYKv4Uaqlf9ECaaxrw85M80StGXuQHIAwPHqB9E/w8h
         fvBxutkj10s3GisZwF5+16uDlVVBb5bfggUlz2AOH9b1aCigHMhgcS+0PWj53Iwbe07g
         wJxHIff5MOL3S1BAqj+QV4sNbIt1VB4yaY+Fh+Avo4WJURXB66pZEU2HKhI8sCGvsl7Q
         ChU2m37ViiEXoCh04NdoNlZ26We6PalKESAzWenAgsM+bY6jyp25QSs9GMlgmN5ccZcc
         BsMf5x8O7J+NGQOw6kt8Ml3d1TabujNJmYVs7YqBrG1hCVHjvKCoER43gxNoCLSymKwd
         mYjA==
X-Forwarded-Encrypted: i=1; AJvYcCVkqkA47VBMU7d3QaieNLcRMLuavwx0qKi/8xYO1/zcYhBm0Z3D6HCB6M3M9KfFsVEzUWP0bLGAJvBgon2RP+qCx5DNU+SnOaRaTFTJ
X-Gm-Message-State: AOJu0YykoVyJjXgi9IsMRDdMYXB0Myd2AuIvNnRBcvc+hlul9EKDMj2U
	X2S6wdV1JzGii6fW1aKLZz/NcaqRe0KbC6AOKTnDmtYzCS1xqFBCcKy3Tpa5lm+/Fh4yIk6St3V
	kuIk/WOFYGuDiQzQmd0XrkYkv9ZmT2TEApqNY/Q==
X-Google-Smtp-Source: AGHT+IEjODUaB+eucP4bk0Bq1uq04SjlL6UzA/D6TBbBZxsxVa5F9JR/0JPQ8rw/eJIf8hKmgpjV00Ld/ZcusrzIIAQ=
X-Received: by 2002:a05:6870:3123:b0:21e:459a:1fb6 with SMTP id
 v35-20020a056870312300b0021e459a1fb6mr2105805oaa.23.1709652625164; Tue, 05
 Mar 2024 07:30:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227153132.2611499-1-jens.wiklander@linaro.org>
 <20240227153132.2611499-2-jens.wiklander@linaro.org> <CACRpkdZBWBio8kvKuVzj2CknCb4eS=VB2EqUsAK-vf4e328icg@mail.gmail.com>
 <PH7PR11MB7605979F0DC103BFCC617FF2E5222@PH7PR11MB7605.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB7605979F0DC103BFCC617FF2E5222@PH7PR11MB7605.namprd11.prod.outlook.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 5 Mar 2024 16:30:13 +0100
Message-ID: <CAHUa44HWNGmqpvoHssvV3DbsvpRVtQpT_HfYe+SLADk3LsmQqw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 1:55=E2=80=AFPM Winkler, Tomas <tomas.winkler@intel.=
com> wrote:
>
>
> > Hi Jens,
> >
> > thanks for your patch!
> >
> > On Tue, Feb 27, 2024 at 4:31=E2=80=AFPM Jens Wiklander <jens.wiklander@=
linaro.org>
> > wrote:
> >
> > > A number of storage technologies support a specialised hardware
> > > partition designed to be resistant to replay attacks. The underlying
> > > HW protocols differ but the operations are common. The RPMB partition
> > > cannot be accessed via standard block layer, but by a set of specific
> > > RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and
> > PROGRAM_KEY. Such a
> > > partition provides authenticated and replay protected access, hence
> > > suitable as a secure storage.
> > >
> > > The initial aim of this patch is to provide a simple RPMB driver
> > > interface which can be accessed by the optee driver to facilitate
> > > early RPMB access to OP-TEE OS (secure OS) during the boot time.
> > >
> > > A TEE device driver can claim the RPMB interface, for example, via
> > > rpmb_interface_register() or rpmb_dev_find_device(). The RPMB driver
> > > provides a callback to route RPMB frames to the RPMB device accessibl=
e
> > > via rpmb_route_frames().
> > >
> > > The detailed operation of implementing the access is left to the TEE
> > > device driver itself.
> > >
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > > Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> >
> > I would mention in the commit that the subsystem is currently only used=
 with
> > eMMC but is designed to be used also by UFS and NVME. Nevertheless, no
> > big deal so:
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, I'll update the commit for the next version.

> >
> > > +config RPMB
> > > +       tristate "RPMB partition interface"
> > > +       depends on MMC
> >
> > depends on MMC || SCSI_UFSHCD || NVME_CORE ?
> >
> > Or do we want to hold it off until we implement the backends?
>
> I believe I've sent the implementation for all the backends, need to sear=
ch the mailing list.

I would prefer to only add the MMC backend now. I'm afraid that adding
more backends will risk stalling this patch set, besides I don't have
the code for it either. Eventual older patches will need to be rebased
and possibly redesigned to take the previous comments into account.

Thanks,
Jens

