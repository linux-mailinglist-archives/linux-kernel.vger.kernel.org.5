Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FCE7E2224
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjKFMqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjKFMqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:46:04 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB79410F7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 04:45:36 -0800 (PST)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 95EBA40622
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1699274734;
        bh=Kv5qXMtHe1RqB/IAdF3q285FqfuFYmP+L0xdtku424s=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ohC+2P6eIz9UEIwqG6CI5nbi37GUpZWibYGKuK0mqBUXK9lqBp5dMM9a7qEAOh0WC
         bVy4uj2NJkOQ6aapoLUAQ8Y2RP9Eh+r8C39Hx/FHc6lBodK7R+0I9/EO3sccLQ8Z8d
         A6s8N/K5l1JZQb6ZBGDQpoMn3fvGvoZhgHRlKlZPFd8bEE8savuzluty0VK01QCcUx
         iABS0tlFpFUwOSPuPcZ+n+hoMJOCk92KxqdOGQKMgm0n94ojIVHrxaqGG/KWsLA4ty
         //OJNFdsOKy0vUjOfFxB+QBTVXEKChzZdQ+0AbRjUQdFTDl1xF8t81t2Sq96c+WCFJ
         /cZlw4R1v5k+Q==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5b95ee4ae94so2442926a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 04:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699274732; x=1699879532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kv5qXMtHe1RqB/IAdF3q285FqfuFYmP+L0xdtku424s=;
        b=nPP1KTTxxAK7RAbEDWdlr9aAph/ZDVm8G96WxezZMnLVMnbk2/93UxXfZlBSr3OrOr
         FJoX8l54RRUfzHNephqgxVmPaOJuoMkh4B/QbLyDF3ngEHWrirXWAA+0237Md7+ulMIm
         l62380IHmgu8xx9KBlI5wCkVQKIOpd+wj2oR1mAaqTUiHsqR9zxR+yzZnrTLmgyLLuiR
         QkGcRVi6cg7Ib8m+WSsHO/Ax4jOvabqBdJTthuAqBVP1Hw3hPHNVXe+yvuzTb/AZlJk2
         TXdQy8D5XvUWI4tjg5QUl84vZLNfhzchFFiGtM3cLOn+QaaEDg+OV3qSkxRQCm3uAyEr
         8VJw==
X-Gm-Message-State: AOJu0YwYPY1dnzgrtWtmYZu5x6km+P6FqzQhsRhIe/TlW2xvHb5RQUvY
        vWBB+A4bx3n8pC9CS5+tNnCO1W83Pmd9b45YmzFBXL7z6PNqdTHEz9PdJVDFO4Nzgxd+0000wln
        wuwYwpxpvxjN3xPcRArKZ2W3sADGXV6gJ/woonWODiyz8SW6csVYtsjpkurFVPNbzv6fqq/4=
X-Received: by 2002:a17:90a:319:b0:280:c7c:3069 with SMTP id 25-20020a17090a031900b002800c7c3069mr20802005pje.7.1699274732420;
        Mon, 06 Nov 2023 04:45:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEh2XiLPI3ndF2x/X6bn2IJNKH5McXJDdk/jTsZOxEv6ay1/WonhiHxfGBgkouzA8kJ3g5is6gUmNd6KZOSgt4=
X-Received: by 2002:a17:90a:319:b0:280:c7c:3069 with SMTP id
 25-20020a17090a031900b002800c7c3069mr20801988pje.7.1699274732095; Mon, 06 Nov
 2023 04:45:32 -0800 (PST)
MIME-Version: 1.0
References: <20231018103337.34622-1-victorshihgli@gmail.com> <d18a2569-ebc3-484f-927a-5e3682457469@intel.com>
In-Reply-To: <d18a2569-ebc3-484f-927a-5e3682457469@intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 6 Nov 2023 14:45:18 +0200
Message-ID: <CAAd53p5Q5-RVHWytst7=tCNW+A+Sc_swAgUQemQLF27CLbH7+A@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sdhci-pci-gli: GL975[05]: Mask the replay timer
 timeout of AER
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 11:29=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 18/10/23 13:33, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Due to a flaw in the hardware design, the GL975x replay timer frequentl=
y
> > times out when ASPM is enabled. As a result, the warning messages that =
will
> > often appear in the system log when the system accesses the GL975x
> > PCI config. Therefore, the replay timer timeout must be masked.
> >
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

I'll send another patch to address the issue I am seeing.

Kai-Heng

>
> > ---
> >
> > Updates in V2:
> >  - Modify the commit message.
> >
> > ---
> >
> >  drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index d83261e857a5..d8a991b349a8 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -28,6 +28,9 @@
> >  #define PCI_GLI_9750_PM_CTRL 0xFC
> >  #define   PCI_GLI_9750_PM_STATE        GENMASK(1, 0)
> >
> > +#define PCI_GLI_9750_CORRERR_MASK                            0x214
> > +#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT       BIT(12)
> > +
> >  #define SDHCI_GLI_9750_CFG2          0x848
> >  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
> >  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> > @@ -152,6 +155,9 @@
> >  #define PCI_GLI_9755_PM_CTRL     0xFC
> >  #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
> >
> > +#define PCI_GLI_9755_CORRERR_MASK                            0x214
> > +#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT       BIT(12)
> > +
> >  #define SDHCI_GLI_9767_GM_BURST_SIZE                 0x510
> >  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET          BIT(8)
> >
> > @@ -561,6 +567,11 @@ static void gl9750_hw_setting(struct sdhci_host *h=
ost)
> >       value &=3D ~PCI_GLI_9750_PM_STATE;
> >       pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
> >
> > +     /* mask the replay timer timeout of AER */
> > +     pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, &value);
> > +     value |=3D PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> > +     pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, value);
> > +
> >       gl9750_wt_off(host);
> >  }
> >
> > @@ -770,6 +781,11 @@ static void gl9755_hw_setting(struct sdhci_pci_slo=
t *slot)
> >       value &=3D ~PCI_GLI_9755_PM_STATE;
> >       pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
> >
> > +     /* mask the replay timer timeout of AER */
> > +     pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, &value);
> > +     value |=3D PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> > +     pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, value);
> > +
> >       gl9755_wt_off(pdev);
> >  }
> >
>
