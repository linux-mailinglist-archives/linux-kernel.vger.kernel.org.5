Return-Path: <linux-kernel+bounces-52850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF409849D6A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941651F24396
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04CB2C684;
	Mon,  5 Feb 2024 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9M/b/YL"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4BF2C1A7;
	Mon,  5 Feb 2024 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144789; cv=none; b=piGaQUWa7DbhG1W1cP0rNKutNbU9GZimpwDsdKsILawOR75glrnM8Uybb+6EoxZPi3CbPpTfM9tIfCNZ9iG9E0LLWPyej0YR4fTXxS3aP3fdZjUIGgDY7K9uyOwWwerQKy5x1QS/h69mZ9cM35MGwEHXhIcKf2PAr5v92Btd9mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144789; c=relaxed/simple;
	bh=B32fFpSglPmh6EsegcSjTE9A2vs7Th/PastyE8w3mTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrOzo5aeZa+KVSJdVsScn0L6y7t627LKuWhlkFHzNwm6q0DFVk03C+0Flc+JRqw1rTxLa1+IFMTw1ZRB4+OAPIHbY7kv+eHG8EfobPp2TYXWRgjrmxAwEdRz5Ztd3KLFDBc+VZa2Zat6QqgsEMVDDXgNfnPquwFVBPzC68pwmYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9M/b/YL; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2191dc7079aso1636462fac.0;
        Mon, 05 Feb 2024 06:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707144787; x=1707749587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLHPk+aymp1ecm0O7KZKJBd8OHOUWRsl0TLFYxwyOGQ=;
        b=a9M/b/YLL0syzhXyP7cN36F7bxaZZhtYOZZx+lB7fEzMhD0OUUlO3T7uR/lJaU5aWM
         eFNVbwTqlNRIAr/shtjCLGVD4Tpp6unijlLRJrpWhduDqV38HhDjBKWJ+2nvCq1jorRC
         XfSIJDE80Mahj8HTZU7mDqRg4PMHCfXSvUMTFIoTF9i7J0ulExiWamdjnsKfssemhHfk
         6cObD6pTWZvdricJGWBOEoT0rOoLyTHEDYXuaGiJiBMX3+e2AUijcSQEs73TWnuVajn0
         VjAi2vUMm8s1qAaHIqV7h+cpD9a3ktUWUiwe/voW75Z1lftBJYU48Xbi/ydTxFf91SsA
         c4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707144787; x=1707749587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLHPk+aymp1ecm0O7KZKJBd8OHOUWRsl0TLFYxwyOGQ=;
        b=LuEtqXQQ1klASyJeNGlh087JMnpZgBx+RqLJhWPg5rq0ykNJrigPzA1y7kdxjY2aEs
         NCMifbd2FPDjMjrbdPcvVOcJXS7cGpbXvWIDrUn06ii9qM1G2CIOslkSoV+2C/TvpP05
         8+PwmRO9rmaz/18no0MSOMfz8fnBAWwXCtJ9jIHE0uxNfIku1KD2+DAooW2aYi9UPqvU
         8FgYMOWs4pfh2kutUWyWNq20vvsKYPBQyzXn9w5n8y/mt2D+kHuINxZgi9SMn54PT7wF
         GT3ZmSoDWiKsY53+KZJePCAVgOJzHFCeimdZiYoSDEUhp0zllhwt3wUIe7Om36KmDm2F
         cy0g==
X-Gm-Message-State: AOJu0Yw2+WVA70UBej0++ueuxI+4VKLTAeAlcqwmwYSfw/i+QHMso4Cv
	4gCjiTYWQNFJ54O24eCOU1uo2fFDT+u/m5Mkk66IKtxnWCmvK4B2kkQ21tk16A2ZRa72OOIFZkW
	rvQFY76i2jj0qJXRe+lCR/b6xA40=
X-Google-Smtp-Source: AGHT+IFwuMmjulFcBFt/EQ5igsfyYhU2jRYXgkdSsjAuGeGkusyGrlUrW1JsuUSmLN+2s4EbaOWjBZ7aP9bKqbiME1Y=
X-Received: by 2002:a05:6870:1cd:b0:219:97e7:a99a with SMTP id
 n13-20020a05687001cd00b0021997e7a99amr1501792oad.12.1707144786728; Mon, 05
 Feb 2024 06:53:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205133450.5222-1-ilpo.jarvinen@linux.intel.com> <20240205133450.5222-4-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20240205133450.5222-4-ilpo.jarvinen@linux.intel.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Mon, 5 Feb 2024 15:52:55 +0100
Message-ID: <CAMhs-H9QaQCz70dmBfMWJ4xoSagrYCJLqejA72fqb50uDwZY9A@mail.gmail.com>
Subject: Re: [PATCH 3/4] MIPS: PCI: Return PCIBIOS_* from tx4927_pci_config_read/write()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 5, 2024 at 3:35=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> pci_ops .read/.write must return PCIBIOS_* codes but
> tx4927_pci_config_read/write() return -1 when mkaddr() cannot find
> devfn from the root bus. Return PCIBIOS_DEVICE_NOT_FOUND instead and
> pass that onward in the call chain instead of overwriting the return
> value.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  arch/mips/pci/ops-tx4927.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/arch/mips/pci/ops-tx4927.c b/arch/mips/pci/ops-tx4927.c
> index f7802f100401..4dd8b93985fb 100644
> --- a/arch/mips/pci/ops-tx4927.c
> +++ b/arch/mips/pci/ops-tx4927.c
> @@ -60,7 +60,7 @@ static int mkaddr(struct pci_bus *bus, unsigned int dev=
fn, int where,
>  {
>         if (bus->parent =3D=3D NULL &&
>             devfn >=3D PCI_DEVFN(TX4927_PCIC_MAX_DEVNU, 0))
> -               return -1;
> +               return PCIBIOS_DEVICE_NOT_FOUND;
>         __raw_writel(((bus->number & 0xff) << 0x10)
>                      | ((devfn & 0xff) << 0x08) | (where & 0xfc)
>                      | (bus->parent ? 1 : 0),

Should we also return PCIBIOS_SUCCESSFUL instead of 'return 0' in
'mkaddr' for coherency?

Other than that, changes look good to me.

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos

> @@ -140,10 +140,12 @@ static int tx4927_pci_config_read(struct pci_bus *b=
us, unsigned int devfn,
>                                   int where, int size, u32 *val)
>  {
>         struct tx4927_pcic_reg __iomem *pcicptr =3D pci_bus_to_pcicptr(bu=
s);
> +       int ret;
>
> -       if (mkaddr(bus, devfn, where, pcicptr)) {
> +       ret =3D mkaddr(bus, devfn, where, pcicptr);
> +       if (ret !=3D PCIBIOS_SUCCESSFUL) {
>                 *val =3D 0xffffffff;
> -               return -1;
> +               return ret;
>         }
>         switch (size) {
>         case 1:
> @@ -162,9 +164,11 @@ static int tx4927_pci_config_write(struct pci_bus *b=
us, unsigned int devfn,
>                                    int where, int size, u32 val)
>  {
>         struct tx4927_pcic_reg __iomem *pcicptr =3D pci_bus_to_pcicptr(bu=
s);
> +       int ret;
>
> -       if (mkaddr(bus, devfn, where, pcicptr))
> -               return -1;
> +       ret =3D mkaddr(bus, devfn, where, pcicptr);
> +       if (ret !=3D PCIBIOS_SUCCESSFUL)
> +               return ret;
>         switch (size) {
>         case 1:
>                 icd_writeb(val, where & 3, pcicptr);
> --
> 2.39.2
>
>

