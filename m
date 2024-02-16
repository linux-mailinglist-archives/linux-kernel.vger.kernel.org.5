Return-Path: <linux-kernel+bounces-67987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64488573F3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16FE51F21EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7A8FC02;
	Fri, 16 Feb 2024 03:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="ixUUyNJH"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF28149E0D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 03:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708053274; cv=none; b=PrpYZb13VbtjYtKnVEjmEdcQR3nZHZ28tr8AZvkmgqAbhfWfnchPIAf5/rD5KujSFhvRm7x3o44DPlDxtXxtA7orX4HbO5ro1CJPXgOT4XFe6DHvXjoMLo/qhWXPEZqfKGVMqMMYwTydR+QTwPduWkY0xedo2QQIgE8qN2WEtgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708053274; c=relaxed/simple;
	bh=hk3STr7C7Sk9+wORjcSTxGk/XLqJkgiovyKOpFhJrUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZAur6VpB8D069U3qZbWK3v8wLD5vu0lDCuBX4bmN2MacDgVXg2UzNP5kLw3rXyDbYvNDlBbrjq00U/hXJcpmWOCeL0nCfSv4xyXDddy65NXO0uxyx7dW188Pv9Krhoz2wO9obz6iehuQpGuu5jCyGsnGBftrlyy7jCBYjPbiu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=ixUUyNJH; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-607e364c985so10860587b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1708053270; x=1708658070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRN9SmDVkhI7MAu3bWHmiNzl3O+9LQAPcK5JZYt2520=;
        b=ixUUyNJHSBmSBxFYHzZTfwiM+Gmx/79tLyM6uGOdm3a4Vrn9ec2w9No8wJC3F5LT1y
         9pDgZwP++BSCVuMGA1dkZcTAA3kzaBE6oVb4mSFGgvHrH3IvqKNQR2k0pLBBfmmYQSzo
         ZJM5JIdXoneZAHA14CGgkr2hX7L3VVdekz40McY+zqlFK6LUO512YOWY2P1efz+f++P/
         m0s+ZpotHYuBZ0q578whpkisdJXHMDy8mfA/MYoZL/4+Ln+GcKDkdv9BMZj6uhdgi/fQ
         Kf7JB0wTB4XT8k1q1TS4jvKYRq6An1NF6k02aVOdYC4bMlSgcNwYWIAYDWXrvudBzndr
         wsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708053270; x=1708658070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRN9SmDVkhI7MAu3bWHmiNzl3O+9LQAPcK5JZYt2520=;
        b=bgHuBkvnWq6ulIYAsZFuvs5TRoWvRF1agGrj9MPQ5l61CigdGEigFukzUJxuMDcXd8
         Iq2nK73YI5C904GJXDCrv5iVxRZTSKMAy8Z6vc4ifu1JFDb1uksOxPvXDHiNI84cyQPy
         ay2vzZ/TH37npJX680By/mq3TtKc00ZR0sQ5GxYiZJ0Il/jNDJRrjAATddQ9qxDBZ4CP
         +nfSMoq/AwDWBBx2ddeQ0OkQgUL2la6mBuG2mDjgJcs7id5EmSEkKKDBuMFrzlCUFfUR
         6C5iv9cNGChYuzf5IFctUxS1g/+zPqQCdmaMqDJRhvfwT8dSVb9OyXY3+YhuiA8IPSNT
         sEqg==
X-Forwarded-Encrypted: i=1; AJvYcCXnRM0U12yEwP+YZSX7IXe/BOI++LDtlKNLCr30v/HPFJYmv3L2lopq0JRCC9Yu2sXNcRA1/1+Z5XZqxBTWFpfckTBvVff8heDqJUMn
X-Gm-Message-State: AOJu0YwJ/e6WtlC0QZhnfqC37ziMd6EUTbVl00joWK063vT6NnM6ZZ6P
	yce7uw/bExc45BMuNuVpfe1L3dY7WJphzMWBW0FT+diuNpWNL3aN5yK0Bnn9++dh9CUUDd0/XUC
	4s2vIMWh+cB9fGsfwQ31iMPBjANJMJH38IGc2FQ==
X-Google-Smtp-Source: AGHT+IES1LLzq7c3lBUFH3NSLQEDlTWVp4rYhFtTKHHRrpjtw81gWoMvXC0yI1h0RuRuw16pt5EY/78gXwVURqK7Iss=
X-Received: by 2002:a0d:cbd0:0:b0:607:a98c:81a1 with SMTP id
 n199-20020a0dcbd0000000b00607a98c81a1mr3633313ywd.28.1708053270014; Thu, 15
 Feb 2024 19:14:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207111854.576402-2-jhp@endlessos.org> <0e7944d410664153b506ea584d92cd6bb0a93f6a.camel@linux.intel.com>
In-Reply-To: <0e7944d410664153b506ea584d92cd6bb0a93f6a.camel@linux.intel.com>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Fri, 16 Feb 2024 11:13:54 +0800
Message-ID: <CAPpJ_edMhGY+4ULvhV0r5TLZ_QyLCNRewTVHdQcjCv--Qa4X+w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] PCI/ASPM: Fix L1SS parameters & only enable
 supported features when enable link state
To: david.e.box@linux.intel.com
Cc: Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David E. Box <david.e.box@linux.intel.com> =E6=96=BC 2024=E5=B9=B42=E6=9C=
=888=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:02=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Wed, 2024-02-07 at 19:18 +0800, Jian-Hong Pan wrote:
> > The original __pci_enable_link_state() configs the links directly witho=
ut:
> > * Check the L1 substates features which are supported, or not
> > * Calculate & program related parameters for L1.2, such as T_POWER_ON,
> >   Common_Mode_Restore_Time, and LTR_L1.2_THRESHOLD
> >
> > This leads some supported L1 PM substates of the link between VMD remap=
ped
> > PCIe Root Port and NVMe get wrong configs when a caller tries to enable=
d
> > them.
> >
> > Here is a failed example on ASUS B1400CEAE with enabled VMD:
> >
> > Capabilities: [900 v1] L1 PM Substates
> >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > L1_PM_Substates+
> >                   PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D1=
0us
> >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >                    T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> >         L1SubCtl2: T_PwrOn=3D10us
> >
> > This patch initializes the link's L1 PM substates to get the supported
> > features and programs relating paramters, if some of them are going to =
be
> > enabled in __pci_enable_link_state(). Then, enables the L1 PM substates=
 if
> > the caller intends to enable them and they are supported.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > ---
> > v2:
> > - Prepare the PCIe LTR parameters before enable L1 Substates
> >
> > v3:
> > - Only enable supported features for the L1 Substates part
> >
> >  drivers/pci/pcie/aspm.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index a39d2ee744cb..c866971cae70 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1389,14 +1389,16 @@ static int __pci_enable_link_state(struct pci_d=
ev
> > *pdev, int state, bool locked)
> >                 link->aspm_default |=3D ASPM_STATE_L0S;
> >         if (state & PCIE_LINK_STATE_L1)
> >                 link->aspm_default |=3D ASPM_STATE_L1;
> > -       /* L1 PM substates require L1 */
> > -       if (state & PCIE_LINK_STATE_L1_1)
> > +       if (state & ASPM_STATE_L1_2_MASK)
> > +               aspm_l1ss_init(link);
>
> This mixes ASPM_STATE flags with PCIE_LINK_STATE register mapping. This m=
ay work
> but I don't know if it's intended to. Rather do,
>
>     if (link->default & ASPM_STATE_L1_2_MASK)
>
> after collecting all of the states to be enabled.
>
> I understand that you are calling aspm_l1ss_init() to do the L1.2 calcula=
tions
> but it does more than this that you don't need. Maybe it would be more
> appropriate to call aspm_calc_l12_info() directly through an additional f=
unction
> that finds the parent and determines both ends of the link support L1SS.

After think & check twice, focusing on fixing the L1.2 parameters makes sen=
se.

I am preparing a new patch.  Thanks!

Jian-Hong Pan

> > +       /* L1 PM substates require L1 and should be in supported list *=
/
> > +       if (state & link->aspm_support & PCIE_LINK_STATE_L1_1)
> >                 link->aspm_default |=3D ASPM_STATE_L1_1 | ASPM_STATE_L1=
;
> > -       if (state & PCIE_LINK_STATE_L1_2)
> > +       if (state & link->aspm_support & PCIE_LINK_STATE_L1_2)
> >                 link->aspm_default |=3D ASPM_STATE_L1_2 | ASPM_STATE_L1=
;
> > -       if (state & PCIE_LINK_STATE_L1_1_PCIPM)
> > +       if (state & link->aspm_support & PCIE_LINK_STATE_L1_1_PCIPM)
> >                 link->aspm_default |=3D ASPM_STATE_L1_1_PCIPM | ASPM_ST=
ATE_L1;
> > -       if (state & PCIE_LINK_STATE_L1_2_PCIPM)
> > +       if (state & link->aspm_support & PCIE_LINK_STATE_L1_2_PCIPM)
> >                 link->aspm_default |=3D ASPM_STATE_L1_2_PCIPM | ASPM_ST=
ATE_L1;
> >         pcie_config_aspm_link(link, policy_to_aspm_state(link));
> >
>
> I don't think these changes are necessary. pcie_config_aspm_link() alread=
y
> checks link->aspm_capable which was initialized from link->aspm_support.
>
> David

