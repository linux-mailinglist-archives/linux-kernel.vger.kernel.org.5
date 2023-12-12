Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3898480E30C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345918AbjLLDsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345926AbjLLDss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:48:48 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C858BF2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:48:46 -0800 (PST)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9B8CA41828
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1702352925;
        bh=1HUhMLBROFN0g5LMy9mB5yaj+3rDSuc7mR6eTwrGU9Y=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=fROLbcGR1F9ZRqOnT8oPh4wd5dSjYCG8R9luEyUH3nYOK+byt7rvqTq+0iImRCmou
         HT/Itt6gMMNAkloE96TspCnVRFALO4NIFR7/KqIvGYqzg9Osv8F0nYoqwHUA/42nWn
         SZuAdKRhAfaDtdQ2oXhgaEAo/MXne1IwJkaN2HP3jEPA/r0wxVhc2toiX3kHPy4crK
         /1XUZiB8UG0oq7Rs2PyrMynL4rKxjbyRv6qokFM1ejfxdOTYerOrOenmY6HmiFE92R
         NCmRrcMjtgHn81fkQWvpPBzNpVAN0jzttp8F43pAu0ZY0FpV9OkHwk0sm3fEdkzeal
         qQt8AyQMiDlqg==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c680110ea9so4543385a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702352920; x=1702957720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HUhMLBROFN0g5LMy9mB5yaj+3rDSuc7mR6eTwrGU9Y=;
        b=X+73xD7OZ/n03GIGZhSPLXtvV4ZYX+yVP3G2fqgyDVptV8Wf6Yq42tQt045LLf21GQ
         DDGNAiqrAEwlRVRWYYbDMzGXSq4xaJRvkim8y79NaE2kUPztplU+LYRus2Qu+5vvk27l
         3MSTJWcpLd+LpyRfwPuCPU8WyEwm9mH1uVyNynMoXRHqN2lYpkFHiga5VXqLYMMBT+SO
         CreG6xVk3zIm+780/kKdFZ2bhQtBsrIQ8nWmsP8n5DqQfQZ1dq0ADCSDC9u7JykvCwEt
         nuPcMGpTr4ElxprWQr1096rw5XEevCquLonMPeAAaWcYVtkhXiB4CphIjkp8xLMsACOo
         lccg==
X-Gm-Message-State: AOJu0Yy2KYr5D+TnAth5ZmF2NH6/+dMDyMqfMCec18HHhygO5en8QZQC
        DvnnEL0nbSJaGx2imusQD8WCAeUlls8xzdxGTfOaFAbECTdBTCvxoMsoGZOA2wwavWxp8aCqFxp
        /yZtrYyqpSSZLNVviNC63cbQyryAsp8jzvx3mvxKs6e2F1xWfCDo6pEygHg==
X-Received: by 2002:a05:6a20:918b:b0:190:63b6:2064 with SMTP id v11-20020a056a20918b00b0019063b62064mr7360040pzd.92.1702352920643;
        Mon, 11 Dec 2023 19:48:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqJkKjDbObn3XUeRSCrDEKIGU4z0L3FDpaVXD13mjmCeE4ARWwVkG/egsSQz2KqotM9nc+q27fkNfBMfIw3pI=
X-Received: by 2002:a05:6a20:918b:b0:190:63b6:2064 with SMTP id
 v11-20020a056a20918b00b0019063b62064mr7360026pzd.92.1702352920339; Mon, 11
 Dec 2023 19:48:40 -0800 (PST)
MIME-Version: 1.0
References: <20231128081512.19387-2-johan+linaro@kernel.org> <20231207204716.GA764883@bhelgaas>
In-Reply-To: <20231207204716.GA764883@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 12 Dec 2023 11:48:27 +0800
Message-ID: <CAAd53p59q3D7u01ECsgRUgkDkTkchV-Gv+q=TMFcC44_tOs51Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] PCI/ASPM: Add locked helper for enabling link state
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 4:47=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> [+cc Kai-Heng]
>
> On Tue, Nov 28, 2023 at 09:15:07AM +0100, Johan Hovold wrote:
> > Add a helper for enabling link states that can be used in contexts wher=
e
> > a pci_bus_sem read lock is already held (e.g. from pci_walk_bus()).
> >
> > This helper will be used to fix a couple of potential deadlocks where
> > the current helper is called with the lock already held, hence the CC
> > stable tag.
> >
> > Fixes: f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and LT=
R")
> > Cc: stable@vger.kernel.org    # 6.3
> > Cc: Michael Bottini <michael.a.bottini@linux.intel.com>
> > Cc: David E. Box <david.e.box@linux.intel.com>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/pci/pcie/aspm.c | 53 +++++++++++++++++++++++++++++++----------
> >  include/linux/pci.h     |  3 +++
> >  2 files changed, 43 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 50b04ae5c394..5eb462772354 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1109,17 +1109,7 @@ int pci_disable_link_state(struct pci_dev *pdev,=
 int state)
> >  }
> >  EXPORT_SYMBOL(pci_disable_link_state);
> >
> > -/**
> > - * pci_enable_link_state - Clear and set the default device link state=
 so that
> > - * the link may be allowed to enter the specified states. Note that if=
 the
> > - * BIOS didn't grant ASPM control to the OS, this does nothing because=
 we can't
> > - * touch the LNKCTL register. Also note that this does not enable stat=
es
> > - * disabled by pci_disable_link_state(). Return 0 or a negative errno.
> > - *
> > - * @pdev: PCI device
> > - * @state: Mask of ASPM link states to enable
> > - */
> > -int pci_enable_link_state(struct pci_dev *pdev, int state)
> > +static int __pci_enable_link_state(struct pci_dev *pdev, int state, bo=
ol locked)
> >  {
> >       struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);
> >
> > @@ -1136,7 +1126,8 @@ int pci_enable_link_state(struct pci_dev *pdev, i=
nt state)
> >               return -EPERM;
> >       }
> >
> > -     down_read(&pci_bus_sem);
> > +     if (!locked)
> > +             down_read(&pci_bus_sem);
> >       mutex_lock(&aspm_lock);
> >       link->aspm_default =3D 0;
> >       if (state & PCIE_LINK_STATE_L0S)
> > @@ -1157,12 +1148,48 @@ int pci_enable_link_state(struct pci_dev *pdev,=
 int state)
> >       link->clkpm_default =3D (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
> >       pcie_set_clkpm(link, policy_to_clkpm_state(link));
> >       mutex_unlock(&aspm_lock);
> > -     up_read(&pci_bus_sem);
> > +     if (!locked)
> > +             up_read(&pci_bus_sem);
> >
> >       return 0;
> >  }
> > +
> > +/**
> > + * pci_enable_link_state - Clear and set the default device link state=
 so that
> > + * the link may be allowed to enter the specified states. Note that if=
 the
> > + * BIOS didn't grant ASPM control to the OS, this does nothing because=
 we can't
> > + * touch the LNKCTL register. Also note that this does not enable stat=
es
> > + * disabled by pci_disable_link_state(). Return 0 or a negative errno.
> > + *
> > + * @pdev: PCI device
> > + * @state: Mask of ASPM link states to enable
> > + */
> > +int pci_enable_link_state(struct pci_dev *pdev, int state)
> > +{
> > +     return __pci_enable_link_state(pdev, state, false);
> > +}
> >  EXPORT_SYMBOL(pci_enable_link_state);
>
> As far as I can see, we end up with pci_enable_link_state() defined
> but never called and pci_enable_link_state_locked() being called only
> by pcie-qcom.c and vmd.c.
>
> Can we just rename pci_enable_link_state() to
> pci_enable_link_state_locked() and assert that pci_bus_sem is held, so
> we don't end up with a function that's never used?
>
> I hope we can obsolete this whole idea someday.  Using pci_walk_bus()
> in qcom and vmd to enable ASPM is an ugly hack to work around this
> weird idea that "the OS isn't allowed to enable more ASPM states than
> the BIOS did because the BIOS might have left ASPM disabled because it
> knows about hardware issues."  More history at
> https://lore.kernel.org/linux-pci/20230615070421.1704133-1-kai.heng.feng@=
canonical.com/T/#u
>
> I think we need to get to a point where Linux enables all supported
> ASPM features by default.  If we really think x86 BIOS assumes an
> implicit contract that the OS will never enable ASPM more
> aggressively, we might need some kind of arch quirk for that.

The reality is that PC ODM toggles ASPM to workaround hardware
defects, assuming that OS will honor what's set by the BIOS.
If ASPM gets enabled for all devices, many devices will break.

Kai-Heng

>
> If we can get there, the qcom use of pci_enable_link_state() could go
> away, and the vmd use could be replaced by some kind of "if device is
> below VMD, get rid of the legacy x86 ASPM assumption" quirk.
>
> Bjorn
