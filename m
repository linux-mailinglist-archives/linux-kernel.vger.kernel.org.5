Return-Path: <linux-kernel+bounces-163490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E178B6C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D152827D2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080693F8DE;
	Tue, 30 Apr 2024 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="FomFXODq"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F2E3AC34
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463210; cv=none; b=XqgOdf/XJQbG/zsb3P0eUrWys0leR9NznNTA2+3nXuMQGOB/cIEZnR4QhwJQieJ9QHhuJVpNJoPCo21IniEdUXUYrCzuaqv2aKCAKIihJizpDdSxTZZ95AZOzVbmq32yd7yoPKwkKDUkHUYTL/mr18dIiIdJji8yiml37g1q3Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463210; c=relaxed/simple;
	bh=565eo0JJVBSnfKGo9nqKmNr/P53TQnL5z4f3HoVqPks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/qDtnA4/mNV+SEsQ514o2e6iD0Pu7FJORKCcbxQtiRL905E1RYoiXnfe1q7jJbJQefa2qXXHEnr09toHxoyhaaJWuBs8q2kt2mBBXmBT4YgIhsYhvkuPsNWFq38Q4Pp9PiGwwnuH65D5Pez+qT4ZHqWDPzIfZzIk3yXiiLrXcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=FomFXODq; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso4480797276.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1714463206; x=1715068006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YN1EHjtX0n3WQTySpE1pEi6l4lU+5tkI5lTQVAPI3JY=;
        b=FomFXODqRPnIWhMNBv+WqSBe2pmusGZOhXzq/A8LYSQ5zCnC61yFqGPH7UDUDbL1Wb
         5754OExApe80858AbiDhSG2Qa3G43THaOX1LutyKLjkyaZniK9dvStjJD8YaqpDwZvyi
         Jy2RV1Cy7F0Gz2am9zHLr5II/y1DXsW+S7FAu8X40RhCeXsgPZ1AUOc79H1SrhuC3ci9
         2SZ5lKBX0uX2EFUK5hPHCaBOqMpgji3tLdBXl2BK3S2F7G1twH0PeG0WInAOkVFNHaNS
         eymcNtMJHehbRwLEJrbLym9jvCVRAgZ/MCSe/qdjp01DY0TGH4ZOsf5Wcc43m5FyBAPJ
         eU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714463206; x=1715068006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YN1EHjtX0n3WQTySpE1pEi6l4lU+5tkI5lTQVAPI3JY=;
        b=YQP6cQp+GXgVogoYa37JR2e05tRLmfFdpM3Vn6CUAawKwZ9OMzEkwS3BWNhpq9sCBy
         cmjc1RUK7uIgWeCswhSY2G40vEL/dR/gEEnNYwOGP7Pzk5QLbLOIx3jfYmTmfRaBmtPi
         Cs6HnlN0pAFsYD44ere7hJ1lfVsIQJuBSlMrUk2BJaaZ809Ghbja8sx74OnHkD5mQZq4
         ZWhy8zlFCHAh4It/ghAA1NTiifvGHig/zTR/xVAULZe6+w9f6BFK96+Om2dss5wOa+bw
         EdyiGnQw1vZLSpnfCvxGeLsGDshzVuirDaKV0vW2yBPVFk4gtPCcQEi/nalLX1/cjE2p
         njGg==
X-Forwarded-Encrypted: i=1; AJvYcCVjyoe0srTbtiu1hjqhWvGsUP8SobOs/JquHa7xwfTfq/5DThzCErAZRMyWRb3o3xBnXA8edlOO3na/FIPIAmVD/EMaZU8VBI9M6vk5
X-Gm-Message-State: AOJu0YxspnEGRegTsSDhHnVVw1e1BfY1U08uDdCHUsj9Tj6NRHgd3MUW
	h2b5B9OE66P9ZuOGTOBBpg2CxD1QkVNL1pWW+ddeeTp/lI181Wd+FxVCt9MHmu5R52lS6jcx4H7
	Hd/d7AcJfwpsj1KEURni0S522TwZpEYeQ1pvfcg==
X-Google-Smtp-Source: AGHT+IGjERC0QMXlWvTqWHpKi51PACc9EM8hyYL6ZQm8D9eipNbig9bwqOBIlKODZaArT5ecYmxaBZcJp2gleLwHCxA=
X-Received: by 2002:a25:ac26:0:b0:de5:d292:2311 with SMTP id
 w38-20020a25ac26000000b00de5d2922311mr1390308ybi.18.1714463206040; Tue, 30
 Apr 2024 00:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424110223.21799-2-jhp@endlessos.org> <f111371300624b6f94f0746dbae66bd49f405eea.camel@linux.intel.com>
In-Reply-To: <f111371300624b6f94f0746dbae66bd49f405eea.camel@linux.intel.com>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Tue, 30 Apr 2024 15:46:10 +0800
Message-ID: <CAPpJ_ecOah=gYfYJVX-TypRiK8+oons3rKOVOATb4epm6sGZaw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] PCI/ASPM: Fix L1.2 parameters when enable link state
To: david.e.box@linux.intel.com
Cc: Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David E. Box <david.e.box@linux.intel.com> =E6=96=BC 2024=E5=B9=B44=E6=9C=
=8827=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=888:03=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi Jian-Hong,
>
> On Wed, 2024-04-24 at 19:02 +0800, Jian-Hong Pan wrote:
> > Currently, when enable link's L1.2 features with __pci_enable_link_stat=
e(),
> > it configs the link directly without ensuring related L1.2 parameters, =
such
> > as T_POWER_ON, Common_Mode_Restore_Time, and LTR_L1.2_THRESHOLD have be=
en
> > programmed.
> >
> > This leads the link's L1.2 between PCIe Root Port and child device gets
> > wrong configs when a caller tries to enabled it.
> >
> > Here is a failed example on ASUS B1400CEAE with enabled VMD:
> >
> > 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor PCI=
e
> > Controller (rev 01) (prog-if 00 [Normal decode])
> >     ...
> >     Capabilities: [200 v1] L1 PM Substates
> >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> > L1_PM_Substates+
> >                   PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D5=
0us
> >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >                    T_CommonMode=3D45us LTR1.2_Threshold=3D101376ns
> >         L1SubCtl2: T_PwrOn=3D50us
> >
> > 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue SN55=
0 NVMe
> > SSD (rev 01) (prog-if 02 [NVM Express])
> >     ...
> >     Capabilities: [900 v1] L1 PM Substates
> >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > L1_PM_Substates+
> >                   PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D1=
0us
> >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >                    T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> >         L1SubCtl2: T_PwrOn=3D10us
> >
> > According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on the P=
CIe
> > Root Port and the child NVMe, they should be programmed with the same
> > LTR1.2_Threshold value. However, they have different values in this cas=
e.
> >
> > Invoke aspm_calc_l12_info() to program the L1.2 parameters properly bef=
ore
> > enable L1.2 bits of L1 PM Substates Control Register in
> > __pci_enable_link_state().
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
> > v4:
> > - Focus on fixing L1.2 parameters, instead of re-initializing whole L1S=
S
> >
> > v5:
> > - Fix typo and commit message
> > - Split introducing aspm_get_l1ss_cap() to "PCI/ASPM: Introduce
> >   aspm_get_l1ss_cap()"
> >
> >  drivers/pci/pcie/aspm.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index c55ac11faa73..553327dee991 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1402,6 +1402,8 @@ EXPORT_SYMBOL(pci_disable_link_state);
> >  static int __pci_enable_link_state(struct pci_dev *pdev, int state, bo=
ol
> > locked)
> >  {
> >         struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);
> > +       struct pci_dev *child =3D link->downstream, *parent =3D link->p=
dev;
> > +       u32 parent_l1ss_cap, child_l1ss_cap;
> >
> >         if (!link)
> >                 return -EINVAL;
> > @@ -1433,6 +1435,16 @@ static int __pci_enable_link_state(struct pci_de=
v
> > *pdev, int state, bool locked)
> >                 link->aspm_default |=3D ASPM_STATE_L1_1_PCIPM | ASPM_ST=
ATE_L1;
> >         if (state & PCIE_LINK_STATE_L1_2_PCIPM)
> >                 link->aspm_default |=3D ASPM_STATE_L1_2_PCIPM | ASPM_ST=
ATE_L1;
> > +       /*
> > +        * Ensure L1.2 parameters: Common_Mode_Restore_Times, T_POWER_O=
N and
> > +        * LTR_L1.2_THRESHOLD are programmed properly before enable bit=
s for
> > +        * L1.2, per PCIe r6.0, sec 5.5.4.
> > +        */
> > +       if (state & link->aspm_capable & ASPM_STATE_L1_2_MASK) {
>
> This is still mixing PCIE_LINK_STATE flags with ASPM_STATE flags.

Thanks for your review, but I notice some description in PCIe spec,
5.5.4 L1 PM Substates Configuration:
"Prior to setting either or both of the enable bits for L1.2, the
values for TPOWER_ON, Common_Mode_Restore_Time, and, if the ASPM L1.2
Enable bit is to be Set, the LTR_L1.2_THRESHOLD (both Value and Scale
fields) must be programmed." =3D> I think this includes both "ASPM L1.2
Enable" and "PCI-PM L1.2 Enable" bits.

Jain-Hong Pan

> 'state' should not even matter.
> The timings should always be calculated and programmed as long
> as L1_2 is capable. That way the timings are ready even if L1_2 isn't bei=
ng
> enabled now (in case the user enables it later).
>
> David
>
> > +               parent_l1ss_cap =3D aspm_get_l1ss_cap(parent);
> > +               child_l1ss_cap =3D aspm_get_l1ss_cap(child);
> > +               aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_ca=
p);
> > +       }
> >         pcie_config_aspm_link(link, policy_to_aspm_state(link));
> >
> >         link->clkpm_default =3D (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0=
;
>

