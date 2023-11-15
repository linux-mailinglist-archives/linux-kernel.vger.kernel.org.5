Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9817EC0D8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbjKOKk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 05:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjKOKk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 05:40:26 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC21C2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 02:40:22 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a87ac9d245so77655637b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 02:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1700044821; x=1700649621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eSJa9f9UX3fbFM9SZUz4WYOfkawjy/uKvGSZgbUdEI=;
        b=PJGjGAk1NKybaq7UGzITw8EpxqkGN0HCyrSiTpYUzCEq+43vsZunpmdDdAODRMF0E1
         Pl6BDxLJAMxnrShD4G3EACcqR3/QjbzfvqB8q1DIn059EVJUKkFvZyUE5uM3EcDsqQdh
         lGxZG2gQ24w1o3j51JCZGC1a7tOdatDScpCngr5AHntRFTRVoBim/FEgWcgHDuM8BMhT
         /izPntYYmD049PvL0zLootC5srkc2e9ZMFP5S5VRU8QBGTcCI03uMYnZo//BJfI5j4A5
         gjr1GvBBMfZuYI9v6c1a1Q0NQGbg79iROsXZuXH91b8upWa5QK8r45QuZEfIG00s7Rl7
         wAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700044821; x=1700649621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eSJa9f9UX3fbFM9SZUz4WYOfkawjy/uKvGSZgbUdEI=;
        b=U3IV8Fplqv5nFx1tY/H6oSZjHMM2GTuI8GzOzGCcfIL+GyelXxPlNT50r5SMZrXop/
         dX+oZ3xypGSfAFoee+a0Fya9yazuRr5yQBpCUauR5dJT2W34nPIppw3PYTbTYceQeJfq
         v4t2gRzwtSrEsD5S/5STBq98VpQraQSXppb8xjsHMv7X9Q24YcEq+u+iBAmykq66mIpY
         DxJ/KdmYvNwoo25omVGyRQhXgVCLfTZBibh/lQJQeHVPuUYmJ4CVSDpKoaTLZ0ON7Otz
         L7XvkTslBql48UJjHwzHYZsLJD0cQPPvzxuVzq571rtzcHPiiR3AFysX/eCVYNh1YBd3
         0gmw==
X-Gm-Message-State: AOJu0YzA/g6Gyr+0fSFqapF7H+sEylxRlOvm4iZzY1eDm/NoojwhRvny
        ZtTVyn8jtJWdulKXPwX9qWdL2s6M4eYdt5F+VjlMiWYnTxI6lvHOlmiqVA==
X-Google-Smtp-Source: AGHT+IFl1L4Rt7UvVJ4D5IFX7VpwEBCpr/A2rEh2l2k/L6g4OKkb9EuCRTGFV2Mszl1jOCwA8Y5NiNNX0Q5UQWqPPEE=
X-Received: by 2002:a0d:d4cd:0:b0:59b:c0a8:2882 with SMTP id
 w196-20020a0dd4cd000000b0059bc0a82882mr12791440ywd.46.1700044821633; Wed, 15
 Nov 2023 02:40:21 -0800 (PST)
MIME-Version: 1.0
References: <05390e0b-27fd-4190-971e-e70a498c8221@lwfinger.net>
 <20231113043454.10053-2-jhp@endlessos.org> <2614f3f7a386435ea7d5f989061c7780@realtek.com>
 <CAPpJ_eeNbq5saQFTq0tz72r05Z4ROSWqn_CNBx=bEpLsd6vT7g@mail.gmail.com> <ea1d2505-7396-92c0-4687-facad575d299@gmail.com>
In-Reply-To: <ea1d2505-7396-92c0-4687-facad575d299@gmail.com>
From:   Jian-Hong Pan <jhp@endlessos.org>
Date:   Wed, 15 Nov 2023 18:39:45 +0800
Message-ID: <CAPpJ_ee=sRimFV1Enj84-RS+rtAssLMk3rnW=oD1mz_TCcrB=w@mail.gmail.com>
Subject: Re: [PATCH v2] rtlwifi: rtl8723be: Disable ASPM if RTL8723BE connects
 to Intel PCI bridge
To:     Jonathan Bither <jonbither@gmail.com>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@endlessos.org" <linux@endlessos.org>, helgaas@kernel.org
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

Jonathan Bither <jonbither@gmail.com> =E6=96=BC 2023=E5=B9=B411=E6=9C=8814=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8811:01=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>
> On 11/13/23 22:01, Jian-Hong Pan wrote:
> > Ping-Ke Shih <pkshih@realtek.com> =E6=96=BC 2023=E5=B9=B411=E6=9C=8814=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=889:41=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >>
> >>
> >>> -----Original Message-----
> >>> From: Jian-Hong Pan <jhp@endlessos.org>
> >>> Sent: Monday, November 13, 2023 12:35 PM
> >>> To: Larry Finger <Larry.Finger@lwfinger.net>; Ping-Ke Shih <pkshih@re=
altek.com>
> >>> Cc: Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org; li=
nux-kernel@vger.kernel.org;
> >>> linux@endlessos.org; Jian-Hong Pan <jhp@endlessos.org>
> >>> Subject: [PATCH v2] rtlwifi: rtl8723be: Disable ASPM if RTL8723BE con=
nects to Intel PCI bridge
> >>>
> >>> Disable rtl8723be's ASPM if the Realtek RTL8723BE PCIe Wireless adapt=
er
> >>> connects to some Intel PCI bridges, such as Skylake and Kabylake.
> >>> Otherwise, the PCI AER flood hangs system:
> >>>
> >>> pcieport 0000:00:1c.5: PCIe Bus Error: severity=3DCorrected, type=3DP=
hysical Layer, (Receiver ID)
> >>> pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=3D00000=
001/00002000
> >>> pcieport 0000:00:1c.5:    [ 0] RxErr                  (First)
> >>> pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
> >>> pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> >>> pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
> >>> pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> >>> pcieport 0000:00:1c.5: AER: Multiple Corrected error received: 0000:0=
0:1c.5
> >>> pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> >>>
> >>> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=3D218127
> >> Seemingly, you can use "Link" or "Closes" tag.
> >>
> >>> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> >> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> >>
> >>
> >>> ---
> >>> v2: Add the switch case's default condition with comment:
> >>>      "The ASPM has already been enabled by initializing
> >>>      rtl8723be_mod_params' aspm_support as 1."
> >>>
> >>>   .../wireless/realtek/rtlwifi/rtl8723be/sw.c   | 24 ++++++++++++++++=
+++
> >>>   1 file changed, 24 insertions(+)
> >>>
> >>> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
> >>> b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
> >>> index 43b611d5288d..b20c0b9d8393 100644
> >>> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
> >>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
> >>> @@ -25,10 +25,34 @@ static void rtl8723be_init_aspm_vars(struct ieee8=
0211_hw *hw)
> >>>   {
> >>>          struct rtl_priv *rtlpriv =3D rtl_priv(hw);
> >>>          struct rtl_pci *rtlpci =3D rtl_pcidev(rtl_pcipriv(hw));
> >>> +       struct pci_dev *bridge_pdev;
> >>>
> >>>          /*close ASPM for AMD defaultly */
> >>>          rtlpci->const_amdpci_aspm =3D 0;
> >>>
> >>> +       /* Disable ASPM if RTL8723BE connects to some Intel PCI bridg=
es, such as
> >>> +        * Skylake and Kabylake. Otherwise, the PCI AER flood hangs s=
ystem.
> >>> +        */
> >>> +       bridge_pdev =3D rtlpci->pdev->bus->self;
> >>> +       if (bridge_pdev->vendor =3D=3D PCI_VENDOR_ID_INTEL) {
> >>> +               switch(bridge_pdev->device) {
> >>> +               case 0x9d15:
> >>> +               /* PCI bridges on Skylake */
> >>> +               case 0xa110 ... 0xa11f:
> >>> +               case 0xa167 ... 0xa16a:
> >>> +               /* PCI bridges on Kabylake */
> >>> +               case 0xa290 ... 0xa29f:
> >>> +               case 0xa2e7 ... 0xa2ee:
> >> Out of curiosity, do you have so many real platforms to test?
> > We have tested those platforms before, because of the hardware
> > enablement.  They all have the same error, and the error bothers
> > people many years.
> > https://groups.google.com/g/fa.linux.kernel/c/0uz8Nr_NVOI
> >
> > However, most of them are returned back to the owner now.  By
> > accident, we keep the ASUS X555UQ equipped with Intel i7-6500U CPU and
> > Realtek RTL8723BE PCIe Wireless adapter on hands for more test.
>
> The device matching that you're doing follows what was also done in
> commit 7184f5b451cf3dc61de79091d235b5d2bba2782d for an ACS quirk on the
> same chipsets.
>
> I'm just curious if the issue is a more universal Intel one and
> can/should be resolved with a pci quirk as opposed to inside an
> individual driver.

Interesting idea.  I did some test like:

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
index 43b611d5288d..edb08247760c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
@@ -26,6 +26,10 @@ static void rtl8723be_init_aspm_vars(struct ieee80211_hw=
 *hw)
        struct rtl_priv *rtlpriv =3D rtl_priv(hw);
        struct rtl_pci *rtlpci =3D rtl_pcidev(rtl_pcipriv(hw));

+       /* Disable ASPM if the link control disables it */
+       if (!pcie_aspm_enabled(rtlpci->pdev))
+               rtlpriv->cfg->mod_params->aspm_support =3D 0;
+
        /*close ASPM for AMD defaultly */
        rtlpci->const_amdpci_aspm =3D 0;

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index eeec1d6f9023..239ae945df00 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3606,6 +3606,37 @@ DECLARE_PCI_FIXUP_FINAL(0x1b7c, 0x0004, /*
Ceton InfiniTV4 */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, 0x8169,
                        quirk_broken_intx_masking);

+
+static void quirk_disable_rtl_aspm(struct pci_dev *dev)
+{
+       struct pci_dev *pdev;
+       u16 val;
+
+       if (dev->bus && dev->bus->self)
+               pdev =3D dev->bus->self;
+       else
+               return;
+
+       if (pdev->vendor =3D=3D PCI_VENDOR_ID_INTEL) {
+               switch (pdev->device) {
+               case 0x9d15:
+               /* PCI bridges on Skylake */
+               case 0xa110 ... 0xa11f:
+               case 0xa167 ... 0xa16a:
+               /* PCI bridges on Kabylake */
+               case 0xa290 ... 0xa29f:
+               case 0xa2e7 ... 0xa2ee:
+                       pci_info(dev, "quirk: disable the device's ASPM\n")=
;
+                       pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &va=
l);
+                       val &=3D ~PCI_EXP_LNKCTL_ASPMC;
+                       pcie_capability_write_word(dev, PCI_EXP_LNKCTL, val=
);
+                       break;
+               }
+       }
+}
+
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_REALTEK, 0xb723, quirk_disable_rtl_a=
spm);
+
 /*
  * Intel i40e (XL710/X710) 10/20/40GbE NICs all have broken INTx masking,
  * DisINTx can be set but the interrupt status bit is non-functional.

Even quirk_disable_rtl_aspm() disables the PCIe's ASPM in Link Control
and Status Register, we still have to clear the aspm_support in
rtl8723be module.  Otherwise, the PCIe's ASPM will be enabled again,
then the AER flood comes again.
If the rtl8723be module should check the PCIe's ASPM feature first
generally, then using the PCI quirk way is feasible.

Ping-Ke Shih, any suggestion?  If this is a better approach, I can
prepare a new version patch.

Jian-Hong Pan
