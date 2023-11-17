Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E997EF111
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346034AbjKQKue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345978AbjKQKu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:50:26 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B1CD72;
        Fri, 17 Nov 2023 02:50:18 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7bae0c07086so659386241.1;
        Fri, 17 Nov 2023 02:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700218218; x=1700823018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hRKG1stwhF50tHKySB/1EUg+yzYfiO+/pNDfaNiThs=;
        b=Ny4Y93/9O3SS2HOubCCt9bmDSM+lCjT/oVeIrsOr9w2r/2zvKNS2pIBGjfGUkP54bh
         98j2T+zn6wQgkSFLJlvDPbWy72nOsL+Wmda01BT6OQy6s4zwpYneHMzATFIp/gSxp0mt
         O5/CTkveFLRG0DV9qQ/oin8JbcfKyxLUuEThQLPdBep1CYDQF2wtGa0ywD8JJgvvaL6n
         5YJlzRMgZ4OUVbrwPhVgFCnTYOpkRQceqP0FFtcN1nhBfczfjCAZqHRxfbcTaXQ0/ogi
         Jtr3MOtzhmV6UDxtNgBuJpdiXNGRRlypV3T45+5aYkMI23T5kK92fw8vQZPVdfnZtFNU
         HyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700218218; x=1700823018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hRKG1stwhF50tHKySB/1EUg+yzYfiO+/pNDfaNiThs=;
        b=SfDC4kzNVKNagHYcI7SgGrYA7SOsGV1yYnGUgiHfkpTEkVesCrRQMN4SZj/hFQXZJJ
         fv7nM7A6ZrnZekWgp7rE6LxaeXS1KvZzYJCVKWY2YeJnilcUNNMph+2gnj3ztbayI9cU
         svHO0dptYDwjfRq5cCK7Q4NXbTJtKLeEm43OP1CRdcCJxCbHJr02tXLilTAznUjK0H5G
         YnGuQI9JtNQAiNy68/fdr1iSIogZCAL/MiUILtUkGFgE7/B6d9fSrKZRctQ3vv95wwKh
         AUja69oV24evSpkZpv9WKe8mOZKbuEfkAskOCPXAkHbd7AuqLwHZPcimi4xbAZbHN9ZF
         bmgg==
X-Gm-Message-State: AOJu0Yw1dWL2V8viUHeu5UU3jl9D1p5vVRcbRWh8cPpkW8ZNhHIKihZY
        BihEcySXhkNOPBdZtoouKvnAxr8rqfkeQbgh3cirlJu3/H0=
X-Google-Smtp-Source: AGHT+IHHnAYCn9U+Rm4oB4MvWXl5T2hqYUt+znyFlNVww1ofFZNrGQrVRN0Nj4z69r7omLLlUobcK44jCPxHzwzjnM4=
X-Received: by 2002:a67:c999:0:b0:45f:1d2:30d7 with SMTP id
 y25-20020a67c999000000b0045f01d230d7mr15862686vsk.8.1700218217756; Fri, 17
 Nov 2023 02:50:17 -0800 (PST)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com>
 <20230915094351.11120-16-victorshihgli@gmail.com> <CAPDyKFpt-ZmSGUWBukLvYvY6DexOr6g23FMWdY14d3gBKxzAmA@mail.gmail.com>
In-Reply-To: <CAPDyKFpt-ZmSGUWBukLvYvY6DexOr6g23FMWdY14d3gBKxzAmA@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 17 Nov 2023 18:50:05 +0800
Message-ID: <CAK00qKADX2+nfoPxtKu3dbftQreG5uQVs0OwVrtZ564jPZA93g@mail.gmail.com>
Subject: Re: [PATCH V12 15/23] mmc: sdhci-uhs2: add detect_init() to detect
 the interface
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 7:10=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrot=
e:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Sdhci_uhs2_do_detect_init() is a sdhci version of mmc's uhs2_detect_ini=
t
> > operation. After detected, the host's UHS-II capabilities will be set u=
p
> > here and interrupts will also be enabled.
>
> $subject patch is adding a bunch of static functions, which isn't
> really being used until later. If you compile this patch it will
> trigger warnings about unused function, we don't want that. Each patch
> in the series should build nicely without warning and errors.
>
> To deal with these problems, I suggest that you move the introduction
> of the sdhci_uhs2_control() from patch17 to $subject patch - or
> possibly make that as a standalone patch, preceeding $subject patch.
> Step by step you can then add support for each of the "enum
> sd_uhs2_operation" to sdhci_uhs2_control().
>
> Moreover, please work at the commit message a bit, it's not entirely
> easy to understand by reading what goes on here.
>

Hi, Ulf

I will merge patch#15, patch#16 and patch#17 into one patch(patch#15)
for version 13.

Thanks, Victor Shih

> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >
> > Updates in V8:
> >  - usleep_range() to instead of udelay() in sdhci_uhs2_interface_detect=
().
> >  - read_poll_timeout() to instead of read_poll_timeout_atomic()
> >    in sdhci_uhs2_interface_detect().
> >  - Modify return value in sdhci_uhs2_do_detect_init().
> >
> > Updates in V7:
> >  - Drop using uhs2_reset ops and use sdhci_uhs2_reset()
> >    in sdhci_uhs2_do_detect_init().
> >
> > Updates in V6:
> >  - Remove unnecessary functions.
> >  - Wrap at 100 columns in some functions.
> >
> > ---
> >
> >  drivers/mmc/host/sdhci-uhs2.c | 112 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 112 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index ad791c48f681..4c2a56629ab3 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -335,6 +335,118 @@ static int sdhci_uhs2_set_ios(struct mmc_host *mm=
c, struct mmc_ios *ios)
> >   *                                                                    =
       *
> >  \*********************************************************************=
********/
> >
> > +static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
> > +{
> > +       int timeout =3D 100000; /* 100ms */
>
> Please use define instead.
>

Hi, Ulf

I will update this in version 13.

Thanks, Victor Shih

> > +       u32 val;
> > +
> > +       usleep_range(50, 200); /* wait for 50us - 200us before check */
>
> Why? Comment?
>
> And use defines.
>

Hi, Ulf

I will drop this in version 13.

Thanks, Victor Shih

> > +
> > +       if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IF_DE=
TECT),
> > +                             100, timeout, true, host, SDHCI_PRESENT_S=
TATE)) {
> > +               pr_warn("%s: not detect UHS2 interface in 100ms.\n", mm=
c_hostname(host->mmc));
> > +               sdhci_dumpregs(host);
> > +               return -EIO;
> > +       }
> > +
> > +       /* Enable UHS2 error interrupts */
> > +       sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI_UHS2_=
INT_ERROR_MASK);
> > +
> > +       /* 150ms */
> > +       timeout =3D 150000;
>
> Ditto.
>

Hi, Ulf

I will update this in version 13.

Thanks, Victor Shih

> > +       if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_LANE_=
SYNC),
> > +                             100, timeout, true, host, SDHCI_PRESENT_S=
TATE)) {
> > +               pr_warn("%s: UHS2 Lane sync fail in 150ms.\n", mmc_host=
name(host->mmc));
> > +               sdhci_dumpregs(host);
> > +               return -EIO;
> > +       }
> > +
> > +       DBG("%s: UHS2 Lane synchronized in UHS2 mode, PHY is initialize=
d.\n",
> > +           mmc_hostname(host->mmc));
> > +       return 0;
> > +}
> > +
> > +static int sdhci_uhs2_init(struct sdhci_host *host)
> > +{
> > +       u16 caps_ptr =3D 0;
> > +       u32 caps_gen =3D 0;
> > +       u32 caps_phy =3D 0;
> > +       u32 caps_tran[2] =3D {0, 0};
> > +       struct mmc_host *mmc =3D host->mmc;
> > +
> > +       caps_ptr =3D sdhci_readw(host, SDHCI_UHS2_CAPS_PTR);
> > +       if (caps_ptr < 0x100 || caps_ptr > 0x1FF) {
> > +               pr_err("%s: SDHCI_UHS2_CAPS_PTR(%d) is wrong.\n",
> > +                      mmc_hostname(mmc), caps_ptr);
> > +               return -ENODEV;
> > +       }
> > +       caps_gen =3D sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_OFFSE=
T);
> > +       caps_phy =3D sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_PHY_O=
FFSET);
> > +       caps_tran[0] =3D sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_T=
RAN_OFFSET);
> > +       caps_tran[1] =3D sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_T=
RAN_1_OFFSET);
> > +
> > +       /* General Caps */
> > +       mmc->uhs2_caps.dap =3D caps_gen & SDHCI_UHS2_CAPS_DAP_MASK;
> > +       mmc->uhs2_caps.gap =3D FIELD_GET(SDHCI_UHS2_CAPS_GAP_MASK, caps=
_gen);
> > +       mmc->uhs2_caps.n_lanes =3D FIELD_GET(SDHCI_UHS2_CAPS_LANE_MASK,=
 caps_gen);
> > +       mmc->uhs2_caps.addr64 =3D (caps_gen & SDHCI_UHS2_CAPS_ADDR_64) =
? 1 : 0;
> > +       mmc->uhs2_caps.card_type =3D FIELD_GET(SDHCI_UHS2_CAPS_DEV_TYPE=
_MASK, caps_gen);
> > +
> > +       /* PHY Caps */
> > +       mmc->uhs2_caps.phy_rev =3D caps_phy & SDHCI_UHS2_CAPS_PHY_REV_M=
ASK;
> > +       mmc->uhs2_caps.speed_range =3D FIELD_GET(SDHCI_UHS2_CAPS_PHY_RA=
NGE_MASK, caps_phy);
> > +       mmc->uhs2_caps.n_lss_sync =3D FIELD_GET(SDHCI_UHS2_CAPS_PHY_N_L=
SS_SYN_MASK, caps_phy);
> > +       mmc->uhs2_caps.n_lss_dir =3D FIELD_GET(SDHCI_UHS2_CAPS_PHY_N_LS=
S_DIR_MASK, caps_phy);
> > +       if (mmc->uhs2_caps.n_lss_sync =3D=3D 0)
> > +               mmc->uhs2_caps.n_lss_sync =3D 16 << 2;
> > +       else
> > +               mmc->uhs2_caps.n_lss_sync <<=3D 2;
> > +       if (mmc->uhs2_caps.n_lss_dir =3D=3D 0)
> > +               mmc->uhs2_caps.n_lss_dir =3D 16 << 3;
> > +       else
> > +               mmc->uhs2_caps.n_lss_dir <<=3D 3;
> > +
> > +       /* LINK/TRAN Caps */
> > +       mmc->uhs2_caps.link_rev =3D caps_tran[0] & SDHCI_UHS2_CAPS_TRAN=
_LINK_REV_MASK;
> > +       mmc->uhs2_caps.n_fcu =3D FIELD_GET(SDHCI_UHS2_CAPS_TRAN_N_FCU_M=
ASK, caps_tran[0]);
> > +       if (mmc->uhs2_caps.n_fcu =3D=3D 0)
> > +               mmc->uhs2_caps.n_fcu =3D 256;
> > +       mmc->uhs2_caps.host_type =3D FIELD_GET(SDHCI_UHS2_CAPS_TRAN_HOS=
T_TYPE_MASK, caps_tran[0]);
> > +       mmc->uhs2_caps.maxblk_len =3D FIELD_GET(SDHCI_UHS2_CAPS_TRAN_BL=
K_LEN_MASK, caps_tran[0]);
> > +       mmc->uhs2_caps.n_data_gap =3D caps_tran[1] & SDHCI_UHS2_CAPS_TR=
AN_1_N_DATA_GAP_MASK;
> > +
> > +       return 0;
> > +}
> > +
> > +static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
> > +{
> > +       struct sdhci_host *host =3D mmc_priv(mmc);
> > +
> > +       DBG("Begin do uhs2 detect init.\n");
> > +
> > +       if (sdhci_uhs2_interface_detect(host)) {
> > +               pr_warn("%s: cannot detect UHS2 interface.\n", mmc_host=
name(host->mmc));
>
> Does this really deserve a warning to be printed to the log?
>

Hi, Ulf

I have no special opinion on this part. What do you think?

Thanks, Victor Shih

> > +               return -EIO;
> > +       }
> > +
> > +       if (sdhci_uhs2_init(host)) {
> > +               pr_warn("%s: UHS2 init fail.\n", mmc_hostname(host->mmc=
));
> > +               return -EIO;
> > +       }
> > +
> > +       /* Init complete, do soft reset and enable UHS2 error irqs. */
> > +       sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
> > +       sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI_UHS2_=
INT_ERROR_MASK);
> > +       /*
> > +        * N.B SDHCI_INT_ENABLE and SDHCI_SIGNAL_ENABLE was cleared
> > +        * by SDHCI_UHS2_SW_RESET_SD
> > +        */
> > +       sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> > +       sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> > +
> > +       return 0;
> > +}
> > +
> >  static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> >  {
> >         host->mmc_host_ops.start_signal_voltage_switch =3D
>
> Kind regards
> Uffe
