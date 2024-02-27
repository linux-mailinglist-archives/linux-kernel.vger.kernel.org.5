Return-Path: <linux-kernel+bounces-83434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EC2869929
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4881C23BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9974A13DBBC;
	Tue, 27 Feb 2024 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeiVk1QB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D698D3D68;
	Tue, 27 Feb 2024 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045666; cv=none; b=UUqje/z7ArW9AiLF6yla0cv9sENEJeK9xoW/pVeMsOGyGQDrKR8Vbtc3lpTbC5LHhZ65Qo9WAx6otBxC329GuQTKd//XJN/rc+BdSkxu9Y7ohzeKl8xwUDhato2jRHmy0dpVy2MNyCG5JjWhwA9FosISAqHNba6g6OuAFMmtvz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045666; c=relaxed/simple;
	bh=hIhNyqJUEiZN+Q1N6J4Q/ktoIRmeCxMfviyFtGZdXVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfBrzrr2baWVWziwOayWh8qukhBWgtJyh/oT6MPLC5WXdTEmt2ZikQA9nwG5IWgagiQ8dgzblwrQcfi2PCoP0gUuZ6QXUWmy1t3BXYvD+AgbzOc5otrq4I+9YVAN0LlHpvicaF6xdxayjnolAUYRUlrYKK4SndCiaLLoVZ63pWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeiVk1QB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B38C43394;
	Tue, 27 Feb 2024 14:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709045665;
	bh=hIhNyqJUEiZN+Q1N6J4Q/ktoIRmeCxMfviyFtGZdXVI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YeiVk1QB7nCsh3iV46eE9q6Rk11a3XXJpj7lFkV4QbwZvPGBx7021K5rbQgtJNVvB
	 PhJNVfFb/dV974/ShA0egPpZ9Gk6VZMhSql79tXM49hk9H+HW8ZNOOoQmHwP7NCHW+
	 FQSoVUyylsHdhVUqjfj/g7/mux/2RBrxxbdqmI5Np+Jc3Q5XXh6+DezzPUR2HKpHng
	 fPGr4csRkFTDqN0sOSVBlfQ7/JtDRW+f6ZkIUEv5A4CQc6eYI2N1nuaznu5S8fajcF
	 4oeC7pQMnttsUwRkkeZIjwtVpdDjxOmFxEn0ROwPSO/72t4JeGtTra7U+OrykENkpL
	 P6VhdNpe5N7jw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512cc3ea7a5so4501246e87.3;
        Tue, 27 Feb 2024 06:54:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGwp21NSPOS6hWUaW//3yws70IZV50f5TqDQwsd+MoiTXOQ3+2P/PpVbnHctmkDwNzS1ZD3o2MMWQEGjUl7qfhsNOVjKFd5nW60RokicTx/8MdvQPpaUVm4EsCwDHnXzQDyPNl3JbnJA==
X-Gm-Message-State: AOJu0YyliS3a4P/ofFafZtvRQ4z446I70803PiXYo9xbrpAqLzrLU8AV
	0dtWwSfvEg1UYREaQHhQAfYgfJNzTyYoOkGj5lsf9k2GePnidcK8EnGoe7iufnGesdBGAv+2MN+
	QLBTjMMbJg7DIulCTNUdkzTg4ag==
X-Google-Smtp-Source: AGHT+IHJzEDBGszspLSh2F/04WXP9nSH45zW0hLtY31ORWuJmFaF1Nxdo+Xa9QfFG6VoTA89OuQkwta26HCPu23LWCE=
X-Received: by 2002:a05:6512:1094:b0:512:bc0f:2400 with SMTP id
 j20-20020a056512109400b00512bc0f2400mr8253176lfg.50.1709045663627; Tue, 27
 Feb 2024 06:54:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130215917.2473250-1-robh@kernel.org>
In-Reply-To: <20240130215917.2473250-1-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 27 Feb 2024 08:54:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJetnzuBcKQMoswuL1X-uwi=meL1EaMOD2LVBg_T_Zn3A@mail.gmail.com>
Message-ID: <CAL_JsqJetnzuBcKQMoswuL1X-uwi=meL1EaMOD2LVBg_T_Zn3A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add TPM DT bindings to TPM maintainers
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 3:59=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> Bindings for a given device class generally go to the respective
> subsystem maintainers. Add the TPM bindings to the TPM
> maintainers entry.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Ping!

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97f51d5ec1cf..e5e3dd672018 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22040,6 +22040,7 @@ S:      Maintained
>  W:     https://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
>  Q:     https://patchwork.kernel.org/project/linux-integrity/list/
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tp=
mdd.git
> +F:     Documentation/devicetree/bindings/tpm/
>  F:     drivers/char/tpm/
>
>  TPS546D24 DRIVER
> --
> 2.43.0
>

