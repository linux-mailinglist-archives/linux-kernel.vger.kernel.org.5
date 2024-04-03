Return-Path: <linux-kernel+bounces-129372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D05B38969A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8596C1F27235
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795CD6E2BE;
	Wed,  3 Apr 2024 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QK1yOyhq"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C3654F8C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712134456; cv=none; b=SloUTSOMM2/MEMTbJvBEXxslmNOn4kSvbmD6C6a+kejLoVH+d6z6u/kUycppX1W/wjjm/tpJySsm44S7hFDnNRxJkyY1WURnJ/Zrf6QvyzY8jyPIC/QEPB5g9ZXVVQiTogjGy6ZHV8yzU2KKysRqNbd8tsUPSvPUjUD0HHYDs58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712134456; c=relaxed/simple;
	bh=tphQMlxXfj94sQmU9WvMO9Ly9qqZqs3IYO1KFpzl2dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+o6TnNP+OZK5PybSrb1Q9qf/Xrlymk/cyXm1ZZqco8shxNCX41AGR8pMhFAUefnEQNQFqj0136bhApoMhaS7z0fM4Hd0pggQBrRNqhh1l0YydhCX7SCt30siZqs2KEfV+FdkSe1hlNblGqgkRjo/h2AEQd63IuenXX1QN9J3y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QK1yOyhq; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a9c71969f1so145601eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 01:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712134454; x=1712739254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAQoe+KPiy+sOp8T5fmyx200mSrFzvOF6EO15y9FXl8=;
        b=QK1yOyhqXIcazhXN7djuLQA5Yj8vYNo+eOnoNkoJ+EEt0nqdsYTtxwmCYeOHsch8F6
         k2zfoME+exX8r4bWq5wa7RMtsU3Ez9PFYkbo6twf6PPbqZtZyCtLj3CO/AEHG8PvmC71
         6H+0onQMIaW1JMTkNY6ITjXY8ImeSN1UhemPS3UnP865cdLarPdqRTteT4q2OaXAj49v
         8XEy6diKa+I1bwm+34IYNxZ8RbmI+IDvjoj0fNNTjrqEU9ZzEHehaRmfb0qzCh6J8Iq9
         P/er7ZHf4uhnTH7Hr+SyhT2m4vmfNcIrUDZe/Bx+DzoU8hcMp1hUwYx82udX6OnHLU0q
         RyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712134454; x=1712739254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAQoe+KPiy+sOp8T5fmyx200mSrFzvOF6EO15y9FXl8=;
        b=otqD4Sz8/q/dbREyF+AtzY/mzy2A78rpBk5beCF9L5P5deFOr7lGtFJaeUAl/TZAt5
         HilR6pw57kjAdWZ7xbfmNsqu28uKo7SSaoXcGyZGAjGlfrinO6vOpbsXninvOMk9gFVG
         pMabE3akFDF1vYN0qFaLkSH3RjeuxPdS3DjFR50J+rsvNw5IUap3DluMiJe1NZH1FSFJ
         0dpOFXKamezdpSeN5C1/0GXtLix1aPFBq0Nu4ulvlX9N59qhLckrnYWEqS0J5kwQ7Ukg
         kFUyL/AU9mNxizmNcZdXHTayws8eqz4UzG2Y3vhhgm+e8C1lXPBEz4IEvXgJzqeiaIbe
         YUcg==
X-Gm-Message-State: AOJu0YyWzo4EiQt3Dv7bmuxy00b9jMa3FwsTgHZabsewZwWzDBsLj+EH
	TvfqSrSwTHolKZfSROT5iOUFJYnLrtqeqpr7nw3r0+Fv2bdIy4r+R2NJZNHZiPZlPtk50Lub1au
	/MymAGLPYY72FT7LNwZZq4j/QeDJ6dbku8eitbg==
X-Google-Smtp-Source: AGHT+IHkZepq7aTafh0HxBLIxweJZ2fHAPK+jdFkf8SwufI6M0a6JAvbgwUN7+X8k22zqLDhJWsYmWAQpZkuZbn/Dyg=
X-Received: by 2002:a05:6820:217:b0:5a4:77f2:1c9f with SMTP id
 bw23-20020a056820021700b005a477f21c9fmr15203421oob.6.1712134454221; Wed, 03
 Apr 2024 01:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227153132.2611499-1-jens.wiklander@linaro.org>
 <20240227153132.2611499-2-jens.wiklander@linaro.org> <CACRpkdZBWBio8kvKuVzj2CknCb4eS=VB2EqUsAK-vf4e328icg@mail.gmail.com>
In-Reply-To: <CACRpkdZBWBio8kvKuVzj2CknCb4eS=VB2EqUsAK-vf4e328icg@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 3 Apr 2024 10:54:03 +0200
Message-ID: <CAHUa44FWRizv39wRJ8ku2v02pDB8_J6BmSk27NrA_UHv4cqNkw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 1:24=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> Hi Jens,
>
> thanks for your patch!
>
> On Tue, Feb 27, 2024 at 4:31=E2=80=AFPM Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
>
> > A number of storage technologies support a specialised hardware
> > partition designed to be resistant to replay attacks. The underlying
> > HW protocols differ but the operations are common. The RPMB partition
> > cannot be accessed via standard block layer, but by a set of specific
> > RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
> > partition provides authenticated and replay protected access, hence
> > suitable as a secure storage.
> >
> > The initial aim of this patch is to provide a simple RPMB driver
> > interface which can be accessed by the optee driver to facilitate early
> > RPMB access to OP-TEE OS (secure OS) during the boot time.
> >
> > A TEE device driver can claim the RPMB interface, for example, via
> > rpmb_interface_register() or rpmb_dev_find_device(). The RPMB driver
> > provides a callback to route RPMB frames to the RPMB device accessible
> > via rpmb_route_frames().
> >
> > The detailed operation of implementing the access is left to the TEE
> > device driver itself.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> I would mention in the commit that the subsystem is currently
> only used with eMMC but is designed to be used also by UFS
> and NVME. Nevertheless, no big deal so:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> > +config RPMB
> > +       tristate "RPMB partition interface"
> > +       depends on MMC
>
> depends on MMC || SCSI_UFSHCD || NVME_CORE
> ?
>
> Or do we want to hold it off until we implement the backends?

Correct, I think we should hold it off until then.

Thanks,
Jens

>
> Yours,
> Linus Walleij

