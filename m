Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE7E7EA8E6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 04:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjKNDCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 22:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjKNDCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 22:02:38 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ACCD6C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 19:02:33 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-daf2eda7efaso3655842276.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 19:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1699930953; x=1700535753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqZzcCxPogZ4weI+Q/ubPKVklfpSz+fQI4/4NWR6BNs=;
        b=MNwIN7+S2922t8Y93v7bHSAurfQzlAo9+LL8EBRlk0b7Rgu1IVmc083EflU3F6ISWb
         DLk4zgKHeUBz5L0C5/BrFZUOEMkEuyCt9o4VkMAjPo1Oy6QnnCNOuUUGWJ8vabxmrgS6
         5Yy71ug34qMBlQtiiqPFqoSHlVEKhyZn2MXlJjrAykszLJMxB51jCNvIIUNcm02u7ZTa
         aQXfNWe3XwMgqje54/2CEpuep9e0q44KAdY1HlBgzc/N4tz0wChuHx4pFFr3hxXt87AX
         7xTcWoX0lUrrG4bl0dzlFVDr6Jm0YMEYAHr7nABMwOxrDyF/b26eBhqqCnheHxTU7/l+
         Ipjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699930953; x=1700535753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqZzcCxPogZ4weI+Q/ubPKVklfpSz+fQI4/4NWR6BNs=;
        b=vvmqFlfRZfFQzf1HGaohCpq1t3GXUk/OIoU1DSuwQerVwAp1WRvqVvIy5RM69lSJSO
         WYrv/uTehStNPHwEK6men596TvvrS63m0cabTxPyzbCxDwl16G81q7A1LbRtXwUlFLpU
         CEaqHsnE1tMKbbtVPb8/w8hGEqiKyorrFkxyt4V+zjzyPoznRKHTcvW1KaHrF8bSLpXM
         T4K1T9QL1bsqtHOsgbPjY09g3GOvy6mqup0mbk/NN/sEmGWvopOVchGPS4IVUCsqEckG
         7GFWNRXpRBWS5i/LV25Dbn79ztvYDvNfRbRg1jNR1s576+DEgpAos1Zb1YRFNfN1gZKQ
         pijQ==
X-Gm-Message-State: AOJu0YzRIQh8jjPBNFUd0fu/ZzyFvfw6m5YijpVaEW3c/Q/Ft1rXKXJM
        +baN4vC0HxJWXy1WmVQlOhAuXB55pNzq8tR35A++vCBPLc8TW5oFZpSmWQ==
X-Google-Smtp-Source: AGHT+IFNwr8wv9JaoJy4GA2VlDpZCYz3yp9rdXiq6e8grWmuklQ6MpUS+TDx59gtLNV45falGTOCSMoZhSnBgFk3RNk=
X-Received: by 2002:a25:3788:0:b0:da0:4f22:4eda with SMTP id
 e130-20020a253788000000b00da04f224edamr8288087yba.36.1699930952918; Mon, 13
 Nov 2023 19:02:32 -0800 (PST)
MIME-Version: 1.0
References: <05390e0b-27fd-4190-971e-e70a498c8221@lwfinger.net>
 <20231113043454.10053-2-jhp@endlessos.org> <2614f3f7a386435ea7d5f989061c7780@realtek.com>
In-Reply-To: <2614f3f7a386435ea7d5f989061c7780@realtek.com>
From:   Jian-Hong Pan <jhp@endlessos.org>
Date:   Tue, 14 Nov 2023 11:01:56 +0800
Message-ID: <CAPpJ_eeNbq5saQFTq0tz72r05Z4ROSWqn_CNBx=bEpLsd6vT7g@mail.gmail.com>
Subject: Re: [PATCH v2] rtlwifi: rtl8723be: Disable ASPM if RTL8723BE connects
 to Intel PCI bridge
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@endlessos.org" <linux@endlessos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> =E6=96=BC 2023=E5=B9=B411=E6=9C=8814=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=889:41=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
>
> > -----Original Message-----
> > From: Jian-Hong Pan <jhp@endlessos.org>
> > Sent: Monday, November 13, 2023 12:35 PM
> > To: Larry Finger <Larry.Finger@lwfinger.net>; Ping-Ke Shih <pkshih@real=
tek.com>
> > Cc: Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org; linu=
x-kernel@vger.kernel.org;
> > linux@endlessos.org; Jian-Hong Pan <jhp@endlessos.org>
> > Subject: [PATCH v2] rtlwifi: rtl8723be: Disable ASPM if RTL8723BE conne=
cts to Intel PCI bridge
> >
> > Disable rtl8723be's ASPM if the Realtek RTL8723BE PCIe Wireless adapter
> > connects to some Intel PCI bridges, such as Skylake and Kabylake.
> > Otherwise, the PCI AER flood hangs system:
> >
> > pcieport 0000:00:1c.5: PCIe Bus Error: severity=3DCorrected, type=3DPhy=
sical Layer, (Receiver ID)
> > pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=3D0000000=
1/00002000
> > pcieport 0000:00:1c.5:    [ 0] RxErr                  (First)
> > pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
> > pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> > pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
> > pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> > pcieport 0000:00:1c.5: AER: Multiple Corrected error received: 0000:00:=
1c.5
> > pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> >
> > Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=3D218127
>
> Seemingly, you can use "Link" or "Closes" tag.
>
> > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>
>
> > ---
> > v2: Add the switch case's default condition with comment:
> >     "The ASPM has already been enabled by initializing
> >     rtl8723be_mod_params' aspm_support as 1."
> >
> >  .../wireless/realtek/rtlwifi/rtl8723be/sw.c   | 24 +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
> > b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
> > index 43b611d5288d..b20c0b9d8393 100644
> > --- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
> > +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
> > @@ -25,10 +25,34 @@ static void rtl8723be_init_aspm_vars(struct ieee802=
11_hw *hw)
> >  {
> >         struct rtl_priv *rtlpriv =3D rtl_priv(hw);
> >         struct rtl_pci *rtlpci =3D rtl_pcidev(rtl_pcipriv(hw));
> > +       struct pci_dev *bridge_pdev;
> >
> >         /*close ASPM for AMD defaultly */
> >         rtlpci->const_amdpci_aspm =3D 0;
> >
> > +       /* Disable ASPM if RTL8723BE connects to some Intel PCI bridges=
, such as
> > +        * Skylake and Kabylake. Otherwise, the PCI AER flood hangs sys=
tem.
> > +        */
> > +       bridge_pdev =3D rtlpci->pdev->bus->self;
> > +       if (bridge_pdev->vendor =3D=3D PCI_VENDOR_ID_INTEL) {
> > +               switch(bridge_pdev->device) {
> > +               case 0x9d15:
> > +               /* PCI bridges on Skylake */
> > +               case 0xa110 ... 0xa11f:
> > +               case 0xa167 ... 0xa16a:
> > +               /* PCI bridges on Kabylake */
> > +               case 0xa290 ... 0xa29f:
> > +               case 0xa2e7 ... 0xa2ee:
>
> Out of curiosity, do you have so many real platforms to test?

We have tested those platforms before, because of the hardware
enablement.  They all have the same error, and the error bothers
people many years.
https://groups.google.com/g/fa.linux.kernel/c/0uz8Nr_NVOI

However, most of them are returned back to the owner now.  By
accident, we keep the ASUS X555UQ equipped with Intel i7-6500U CPU and
Realtek RTL8723BE PCIe Wireless adapter on hands for more test.

Jian-Hong Pan
