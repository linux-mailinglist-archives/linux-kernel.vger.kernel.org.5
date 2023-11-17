Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B215A7EF105
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345816AbjKQKuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345977AbjKQKuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:50:14 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEA5D4F;
        Fri, 17 Nov 2023 02:50:10 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7be55675503so724690241.1;
        Fri, 17 Nov 2023 02:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700218209; x=1700823009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mROOgsQBSA4v7sWhPVDYljNSnT+02Uiataq87rTSwgs=;
        b=F6UX2ZmaaJKraf5q5o9ME106twgcGKFs2xq7W74JrLF3/vM+vWCPZffy0UBAwizxbN
         yWNatetafmrxz5lwR1tEkx11k5xZnEcLixIMTq7VxmWa8gl63T2c/hWkpySGxj0o9rHG
         LtyCNhULIxUYngqOvEXZFc8wE4INdrkGSxoBZG8OJQAHS0ZKoXgQ0tNk85En/Fb1aDUQ
         LG41DoeYlmkWg3isGwkvPLfG+HzISd9z0ayohJaDZUEyMjjdCM/y6FuRvcUTnUnVWXE9
         nSuF5PbEk7pWBwG4itR//7b+1FWBCEGLmgGs9AEXhmJgsvqqeIKfKUKqwWkFTRoyRpE0
         wB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700218209; x=1700823009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mROOgsQBSA4v7sWhPVDYljNSnT+02Uiataq87rTSwgs=;
        b=bIyoMGfPrtMa2j8Jv/KRYF+doRFBCxt2Xd2seIEfllBzf0vqEXKivSYG6Be91rlwDw
         KeXaXIQujnTvm9KZni7OTCFVf3ahG6ev7KBZ/UupJqnFRBHYTmaEOdEqDzpiQHJ//azR
         fEgBoZjhG/HA3efHhPF04gWCj/eeXvA5sQG2KSOGGns8y1UBpIzRXoQNerbQtA6OIljp
         g08AZDjDD6SXK7Kb7b6XdaG6E1p4fW063zYvtO54/yFC/8rKo09Im3oFY5074jttVsGo
         Dic+IrMAFd4Qny8YUKdKwbcGErE7VupdbYKd428a69tSoiQs6HsG13Sc5RBmw4d09RnF
         7laA==
X-Gm-Message-State: AOJu0YwX7Q7HOwPyNnJJRr451Wl7BDS7RqW4h8GNRHZ03Dq/6La9S1jn
        Rpn/wJy1tJKxOm3dzHzsEj1H5lqI+Y4pVXZNY4o=
X-Google-Smtp-Source: AGHT+IHMxA6VBRx9hx7+9DLWzV53dEDuHxuhfSESuZy+afKU3asygTdesZJ7fMxgt+D7nYKiAWgtTkoOGcPGF7KwzjQ=
X-Received: by 2002:ac5:ccc7:0:b0:495:febd:9187 with SMTP id
 j7-20020ac5ccc7000000b00495febd9187mr18891593vkn.0.1700218209412; Fri, 17 Nov
 2023 02:50:09 -0800 (PST)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com>
 <20230915094351.11120-13-victorshihgli@gmail.com> <CAPDyKFpzuds6Ttbhw1cqZwisa+M6167DT3DUihcDqFjYJX95eA@mail.gmail.com>
 <CAK00qKDtXR2aV_h4KhAaWqjUfn8M2-yMsDHeFmz0ztjaF4wB=g@mail.gmail.com> <8c80f712-45c3-4c7a-a694-11efa4591078@intel.com>
In-Reply-To: <8c80f712-45c3-4c7a-a694-11efa4591078@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 17 Nov 2023 18:49:57 +0800
Message-ID: <CAK00qKCAoousoi0Ly84Mvnycv99bizMmpAxRH1abpuGPT7VWEw@mail.gmail.com>
Subject: Re: [PATCH V12 12/23] mmc: sdhci-uhs2: skip signal_voltage_switch()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 6:51=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> On 6/10/23 13:30, Victor Shih wrote:
> > On Tue, Oct 3, 2023 at 5:58=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> >>
> >> On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> w=
rote:
> >>>
> >>> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >>>
> >>> For UHS2, the signal voltage is supplied by vdd2 which is already 1.8=
v,
> >>> so no voltage switch required.
> >>
> >> Can you please elaborate on this? I don't get anything of the above, s=
orry.
> >>
> >>>
> >>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> >>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >>> ---
> >>>
> >>> Updates in V5:
> >>>  - Use sdhci_uhs2_mode() to simplify code in
> >>>    sdhci_uhs2_start_signal_voltage_switch().
> >>>
> >>> ---
> >>>
> >>>  drivers/mmc/host/sdhci-uhs2.c | 24 ++++++++++++++++++++++++
> >>>  1 file changed, 24 insertions(+)
> >>>
> >>> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-u=
hs2.c
> >>> index fc37a34629c2..92fb69b7e209 100644
> >>> --- a/drivers/mmc/host/sdhci-uhs2.c
> >>> +++ b/drivers/mmc/host/sdhci-uhs2.c
> >>> @@ -142,6 +142,27 @@ static void sdhci_uhs2_set_power(struct sdhci_ho=
st *host, unsigned char mode, un
> >>>         }
> >>>  }
> >>>
> >>> +/*******************************************************************=
**********\
> >>> + *                                                                  =
         *
> >>> + * MMC callbacks                                                    =
         *
> >>> + *                                                                  =
         *
> >>> +\*******************************************************************=
**********/
> >>> +
> >>> +static int sdhci_uhs2_start_signal_voltage_switch(struct mmc_host *m=
mc,
> >>> +                                                 struct mmc_ios *ios=
)
> >>> +{
> >>> +       struct sdhci_host *host =3D mmc_priv(mmc);
> >>> +
> >>> +       /*
> >>> +        * For UHS2, the signal voltage is supplied by vdd2 which is
> >>> +        * already 1.8v so no voltage switch required.
> >>> +        */
> >>> +       if (sdhci_uhs2_mode(host))
> >>> +               return 0;
> >>
> >> This is just wrong. If we are initializing a uhs2 card, we certainly
> >> should call ->start_signal_voltage_switch() callback at all. This is
> >> for UHS-I cards, right?
> >>
> >
> > Hi, Ulf
> >
> > UHS-II does not need single_voltage.
> > I will modify the commit message in the next version.
> > sdhci_uhs2_start_signal_voltage_switch() is under
> > mmc_host_ops.start_signal_voltage_switch host ops,
> > therefore, we need to keep the UHS-I path here.
>
> You should be able to leave out the patch entirely
> because ->start_signal_voltage_switch() is not called
> for UHS2 mode
>

Hi, Ulf and Adrian

I will drop this patch in version 13.

Thanks, Victor Shih

> >
> > Thanks, Victor Shih
> >
> >>> +
> >>> +       return sdhci_start_signal_voltage_switch(mmc, ios);
> >>> +}
> >>> +
> >>>  /*******************************************************************=
**********\
> >>>   *                                                                  =
         *
> >>>   * Driver init/exit                                                 =
         *
> >>> @@ -150,6 +171,9 @@ static void sdhci_uhs2_set_power(struct sdhci_hos=
t *host, unsigned char mode, un
> >>>
> >>>  static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> >>>  {
> >>> +       host->mmc_host_ops.start_signal_voltage_switch =3D
> >>> +               sdhci_uhs2_start_signal_voltage_switch;
> >>> +
> >>>         return 0;
> >>>  }
> >>>
> >>
> >> Kind regards
> >> Uffe
>
