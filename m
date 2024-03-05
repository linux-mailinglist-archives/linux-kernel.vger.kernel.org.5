Return-Path: <linux-kernel+bounces-92357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EB7871F10
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62322B23358
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62A35A4FF;
	Tue,  5 Mar 2024 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQJHsty3"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D4F59B5E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641457; cv=none; b=fcxviiCijrmKK7aZs3WFaPuCxHAw6RgO3z0aHSVMnrb/aLi2bxUjWCTp4Z61RPdHlJ26h6yyC1ov8346QYiD/T8TpUycHmxRu17MMwLy5K6NKtegkci3TkYOsKQZEHF2w5JPVLey923InVWjmtHZ5VkG8Ss3jobXbiXk6Ap852o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641457; c=relaxed/simple;
	bh=CS3p1MBudwYKblcteI/2NOPXI4ddkTXb99n7xdy/Gb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHvno4eZwRVUp9bORdfsi1q6dzitaWSAGSBA2aCMub6flNjHCc7HkcNJdS7/ZfaOoZwI8mlsZoLEQPPIpJPVH8NvZ/2498cri36hRIpp9dapNAOZxk/PK/MMN8Xr5jLBztVx82qWOwDeTuk4+Uz3emPVhWjpqbDA8QhGE/t3PKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XQJHsty3; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60978479651so51357137b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 04:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709641454; x=1710246254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgWnngIT/gJ2CN/6Q6lG/bumlZMowmI03npuEMQCBAM=;
        b=XQJHsty32one0Z/DC+DOsBj888PoIR9MgaSaINszUAU6nMN/yoYHrQZJ0BUbKiJO2+
         hMycc3VXUJsXbYnmIenlWBjNLs7UmNNcP5yOkcu/+4347xOz1bdwiEuJZZqmFdUAAQV3
         A3xE0EPQWIqki7bGqVUlzV65K3RrC7BZAAYvn1Hpk4RhX5Z20Z3RKL5AZcMdU++uuqdF
         GQ1O/ERZnoA2J70Z5231Hvh9GpBgLWFgEXgngK/xbXJ7z7TA1M7OaVOb7vKQKQ+UegeY
         9AJxiHMIa2FRToAF9RZFM6rONYsELFxPUtHehJqEqGLT18+c24vkuI1J1vCnsJnN75eM
         vQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709641454; x=1710246254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgWnngIT/gJ2CN/6Q6lG/bumlZMowmI03npuEMQCBAM=;
        b=JpYSkP2mRqzYcZ8hycIb4nbMtArfaNEy5znQHotNAzvKcv6lh65MRRM6ez422L68rB
         JddoDK5VHvHsnGsesDeMDv7KUtjpQAH7FG7OeEKbCGj9haTcTna64EXT6ADku3hO2ZsZ
         uan98D+/zxg4zhnbEW5klGfXlEs7q95Y2Gc64RDUYHXKRApTMlL1YdkQ4g2ewTNEL/Oa
         WiGnB0CzPN0VWdjauIHx0VeignkwzMn3NZx/VqJlZeeFAyV/teO+uW1gj3Xth5r3rZcs
         7K9qjEpsNJMFShyd50X4QZqsNpxR4rm6g86lu6h6opLNJNV/0u7p37fijN2ZqhYGJmn9
         GPsg==
X-Gm-Message-State: AOJu0Yy5VG75l0dc0ZTtrFQon4JrujDUX7letK5btE1dZjHf+6GcQ3fR
	wqcFTB9ItkSKVD23nZWyz6/+Olg2/9KFct/4u/wy3UXAYcBP3DGXDRv++gEScAedqoQXsns7fbs
	X8EFKj/aS/qsEeKc6ZZb4bFIwZA1iJvsdNUoSBw==
X-Google-Smtp-Source: AGHT+IHUBgwcmPr3wx5OxoHWv1ZUZdP1ZVL1rLQBhjwJNL8fZY5l0lFsxJWNgG2Iv1hIDyeVJFsQ1t3tYOxVyeL6KpA=
X-Received: by 2002:a81:720a:0:b0:609:2104:3cf8 with SMTP id
 n10-20020a81720a000000b0060921043cf8mr12997879ywc.41.1709641454552; Tue, 05
 Mar 2024 04:24:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227153132.2611499-1-jens.wiklander@linaro.org> <20240227153132.2611499-2-jens.wiklander@linaro.org>
In-Reply-To: <20240227153132.2611499-2-jens.wiklander@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Mar 2024 13:24:02 +0100
Message-ID: <CACRpkdZBWBio8kvKuVzj2CknCb4eS=VB2EqUsAK-vf4e328icg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>
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

Hi Jens,

thanks for your patch!

On Tue, Feb 27, 2024 at 4:31=E2=80=AFPM Jens Wiklander
<jens.wiklander@linaro.org> wrote:

> A number of storage technologies support a specialised hardware
> partition designed to be resistant to replay attacks. The underlying
> HW protocols differ but the operations are common. The RPMB partition
> cannot be accessed via standard block layer, but by a set of specific
> RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
> partition provides authenticated and replay protected access, hence
> suitable as a secure storage.
>
> The initial aim of this patch is to provide a simple RPMB driver
> interface which can be accessed by the optee driver to facilitate early
> RPMB access to OP-TEE OS (secure OS) during the boot time.
>
> A TEE device driver can claim the RPMB interface, for example, via
> rpmb_interface_register() or rpmb_dev_find_device(). The RPMB driver
> provides a callback to route RPMB frames to the RPMB device accessible
> via rpmb_route_frames().
>
> The detailed operation of implementing the access is left to the TEE
> device driver itself.
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

I would mention in the commit that the subsystem is currently
only used with eMMC but is designed to be used also by UFS
and NVME. Nevertheless, no big deal so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> +config RPMB
> +       tristate "RPMB partition interface"
> +       depends on MMC

depends on MMC || SCSI_UFSHCD || NVME_CORE
?

Or do we want to hold it off until we implement the backends?

Yours,
Linus Walleij

