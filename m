Return-Path: <linux-kernel+bounces-121501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513DF88E9FC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFDF7B356E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82444139CE6;
	Wed, 27 Mar 2024 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfl54Krp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8CB137921;
	Wed, 27 Mar 2024 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553033; cv=none; b=vAL/DgkSoZox2d61Nj4SkoGHAAT6XGibNu4nCadLPGXLqwXCyJxIMTR3/TTVmB3J0GPFSKe16C2ivxZ5LbhfsfMvn/m3zyby3UAnlVNhN3YSvbsqigoKnpCM2sEDeMDZ2h2cGoowtWgDl2o1m2B49/ytfGp798rDDo/rdt0CmuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553033; c=relaxed/simple;
	bh=3VMwR39j8weliV+6NBseozQ2vW9EVpKn2q9EWN43Fbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNox+W58Kz7lwobR3wdLDvVaf7WLJdWeJdRpx1vzoYsdKAW5706dN2t4Z42H9IhDydIrBdDbP/vEHx0ZPasCvM7VumEzrzfFX/UIdQP30yVv1GU/pEhRUfXxJ8lEQVoeMRlXLDSTZTh8kGD6VHohYgRQz2qBV2QXDBHEMnxArPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfl54Krp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE13C433B1;
	Wed, 27 Mar 2024 15:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711553033;
	bh=3VMwR39j8weliV+6NBseozQ2vW9EVpKn2q9EWN43Fbg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kfl54KrpGwKEcsKwcQ5MYF3qjPvupQxIMPPXPjQOFzlFAloQVNpWmTS1lU2a/cNfb
	 C/do0a1YEpQOKC1aEokxm2HNnUXgZccLBa17WwS+bjezyaf53gH34EtUKFSzPLlre6
	 LZT4WoozcJB4A6hktm8Wc8S8blz6va6a62Du2FBDuZee+zX9NEU5E0w8eyRG0Yz6Tc
	 MfVTAk04umkvJTfLbroFyLufKUhfgPV9EO++Xok4AnQG3BSUECXhiY2iOGggO87ARr
	 TPKnLOry79euk+t4wbIyEEA3jtrE9ZpsslqbC1i+XtOdBPi9QWthyacm8JPKwA1Hna
	 c+IdCg8ZHlvww==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a4e0859b65so1553414eaf.0;
        Wed, 27 Mar 2024 08:23:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWcf3plSaE0oDIouMa1lTduLm7cV25dDVDTy+gb1gqHizSWwRUomBJYj2S4LeBWSwZhFUAHqqunsEbPxR+Rmhhl4oQTWdZkQe8DJsVwDNJI9YLodSFiloleFrmGmD4dpLZXoEncHHU=
X-Gm-Message-State: AOJu0YzQzzwDl9gx7oleFOny05JVxL4ju3BcpJuHLfAyG12AIdMF2+nD
	dkFFAtgK4NStJEZ28D2h7fEEgIr3Mh2ntQVBBIJgEGSvma46U2DvoajmzPZblWF3WXQbOOXFEpG
	3y2ZHea/Nx492Dlscid3eZBimnjA=
X-Google-Smtp-Source: AGHT+IHnnPd1qt0QJuSVrS8+m3tGMC4EBht4R7Ia3lYi2xIGB8baAo+spJupmQK/R5BKggmU0YjFtvHyMt+CM0fAJec=
X-Received: by 2002:a05:6871:289c:b0:22a:1e0c:8bc6 with SMTP id
 bq28-20020a056871289c00b0022a1e0c8bc6mr11717648oac.2.1711553032614; Wed, 27
 Mar 2024 08:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325220952.1453477-1-helgaas@kernel.org>
In-Reply-To: <20240325220952.1453477-1-helgaas@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Mar 2024 16:23:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j6SaxTG9+Zr1Sk9iN_bvzzOCD+7_s98HEes1CY825epQ@mail.gmail.com>
Message-ID: <CAJZ5v0j6SaxTG9+Zr1Sk9iN_bvzzOCD+7_s98HEes1CY825epQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: PM: Update platform_pci_wakeup_init() reference
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 11:11=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> platform_pci_wakeup_init() was removed by d2e5f0c16ad6 ("ACPI / PCI: Rewo=
rk
> the setup and cleanup of device wakeup") but was still mentioned in the
> documentation.
>
> Update the doc to refer to pci_acpi_setup(), which does the equivalent
> work.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>
> pci_acpi_setup() is a firmware-specific wart in this otherwise generic
> paragraph, so maybe there's some better way to express this?
>
>  Documentation/power/pci.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
> index 12070320307e..e2c1fb8a569a 100644
> --- a/Documentation/power/pci.rst
> +++ b/Documentation/power/pci.rst
> @@ -333,7 +333,7 @@ struct pci_dev.
>  The PCI subsystem's first task related to device power management is to
>  prepare the device for power management and initialize the fields of str=
uct
>  pci_dev used for this purpose.  This happens in two functions defined in
> -drivers/pci/pci.c, pci_pm_init() and platform_pci_wakeup_init().
> +drivers/pci/, pci_pm_init() and pci_acpi_setup().
>
>  The first of these functions checks if the device supports native PCI PM
>  and if that's the case the offset of its power management capability str=
ucture
> --

Applied as 6.10 material, or if you'd rather take it to the PCI tree,
please let me know.

