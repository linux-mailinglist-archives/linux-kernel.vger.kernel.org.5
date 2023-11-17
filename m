Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53CA7EF107
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345985AbjKQKuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbjKQKuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:50:16 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B64D56;
        Fri, 17 Nov 2023 02:50:12 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7c1a4ccd493so334247241.3;
        Fri, 17 Nov 2023 02:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700218211; x=1700823011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlTU/g+CRJexSYilT4CgIv2yxCGOn+qM1MAc7nS/Y2Y=;
        b=P85rTmXQus3fre9NrUDAMC9sA79lptXJ+PDfmEuxh7Hr5cQrpHB6WLusERHpfJ8WVw
         QBqmtKvWF9MkxyngCjhg+RWrOysEOdy/ubLPen4KTzNF9A9X+Di8CIBj+2BxguUC0lCz
         sYOWGLkZM3rIIhfLEUI41FbVtBnK+kz8W6sCu/Kx4jRjCKZJjvLsW7IGr8uF2jYpOoSl
         tbhuuGmSQdniV9J5wp876t7eh7hFwU5slB8P4ECf5TWGP4FeB1pbIrWTlorTdss1fDl5
         D2GhQT36zEouoDivWB1PYVtAjEh7Y5Rw2IZM+DFoYZRUVALcq4eZZm7qfYNmHrLdgsp1
         P8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700218211; x=1700823011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlTU/g+CRJexSYilT4CgIv2yxCGOn+qM1MAc7nS/Y2Y=;
        b=MWIm0sn8XDS8TYvVAuums8j0oxLf4l2Ka7psTAQ1nSmpsADrG6meprdzXNGtVegXgo
         QeIrhuwsf9/OHvcKrKqZOTCXF4+hUCRKk6Uzo9942JORn1K3VTminv3/5jW/A1wOycsw
         uzUYPbABpgNfx2FDxLMXXGyLhszxMph9YbCzHAgHoQq9livolyCNClwGVvcW5c1D47qX
         HngffJngcYNC87OisB9R+7Sz0PTeSL582FpCjbM09R6naTVVY+UBSBucGAEHrWjmzjCe
         aJrzFbKmOsr+TKZDSlJXry4clMvgk7cglFdvqwID2poC6cdSjZtCg4hGF0kIblBfvy+0
         yB5g==
X-Gm-Message-State: AOJu0YzV7Mp5JuVLbd3rANKCWc/+7YC3XyYeWOk2OIV+Grc817ThvzgC
        IjmAw6B2C31nMrT9MYpsfLIFJdNyznqUJ1B0aRU=
X-Google-Smtp-Source: AGHT+IHUsZj5sjyBixWkcXYTs0GR6OKBXW9YGLTJmwVvS+OGRWmPP0VfT0QbhwiK+Q99ilp5s5nbggS/qLmAm2VEd1c=
X-Received: by 2002:a67:ae48:0:b0:462:85fd:d99c with SMTP id
 u8-20020a67ae48000000b0046285fdd99cmr565252vsh.9.1700218211303; Fri, 17 Nov
 2023 02:50:11 -0800 (PST)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com>
 <20230915094351.11120-14-victorshihgli@gmail.com> <CAPDyKFrs1pjo0cxVU8m2ykc0x_t8+tRSNnQVTKNcMzopX8h8EQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrs1pjo0cxVU8m2ykc0x_t8+tRSNnQVTKNcMzopX8h8EQ@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 17 Nov 2023 18:49:59 +0800
Message-ID: <CAK00qKCsFijpK1Sj8edyUfMWByYURrdRKpnhuCxxwj6TAyP5UA@mail.gmail.com>
Subject: Re: [PATCH V12 13/23] mmc: sdhci-uhs2: add set_timeout()
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

On Tue, Oct 3, 2023 at 6:55=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrot=
e:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > This is a UHS-II version of sdhci's set_timeout() operation.
>
> This needs more explanations and justifications.
>
> Other than that, the patch looks good to me!
>
> Kind regards
> Uffe
>

Hi, Ulf

I will try to update this in version 13.

Thanks, Victor Shih

> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >
> > Updates in V8:
> >  - Initialization be combined with declaration and realigned
> >    in sdhci_calc_timeout_uhs2().
> >  - Forward declare struct mmc_command in sdhci_uhs2.h.
> >
> > Updates in V6:
> >  - Use GENMASK() and FIELD_PREP() in some case.
> >  - Use sdhci_uhs2_mode() to simplify code.
> >  - Remove unnecessary functions.
> >
> > ---
> >
> >  drivers/mmc/host/sdhci-uhs2.c | 72 +++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |  2 +
> >  2 files changed, 74 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index 92fb69b7e209..d519e6ce6199 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/module.h>
> >  #include <linux/iopoll.h>
> > +#include <linux/bitfield.h>
> >
> >  #include "sdhci.h"
> >  #include "sdhci-uhs2.h"
> > @@ -142,6 +143,77 @@ static void sdhci_uhs2_set_power(struct sdhci_host=
 *host, unsigned char mode, un
> >         }
> >  }
> >
> > +static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host, u8 *cmd_res=
, u8 *dead_lock)
> > +{
> > +       /* timeout in us */
> > +       unsigned int dead_lock_timeout =3D 1 * 1000 * 1000;
> > +       unsigned int cmd_res_timeout =3D 5 * 1000;
> > +       unsigned int current_timeout;
> > +       u8 count;
> > +
> > +       /*
> > +        * Figure out needed cycles.
> > +        * We do this in steps in order to fit inside a 32 bit int.
> > +        * The first step is the minimum timeout, which will have a
> > +        * minimum resolution of 6 bits:
> > +        * (1) 2^13*1000 > 2^22,
> > +        * (2) host->timeout_clk < 2^16
> > +        *     =3D>
> > +        *     (1) / (2) > 2^6
> > +        */
> > +       count =3D 0;
> > +       current_timeout =3D (1 << 13) * 1000 / host->timeout_clk;
> > +       while (current_timeout < cmd_res_timeout) {
> > +               count++;
> > +               current_timeout <<=3D 1;
> > +               if (count >=3D 0xF)
> > +                       break;
> > +       }
> > +
> > +       if (count >=3D 0xF) {
> > +               DBG("%s: Too large timeout 0x%x requested for CMD_RES!\=
n",
> > +                   mmc_hostname(host->mmc), count);
> > +               count =3D 0xE;
> > +       }
> > +       *cmd_res =3D count;
> > +
> > +       count =3D 0;
> > +       current_timeout =3D (1 << 13) * 1000 / host->timeout_clk;
> > +       while (current_timeout < dead_lock_timeout) {
> > +               count++;
> > +               current_timeout <<=3D 1;
> > +               if (count >=3D 0xF)
> > +                       break;
> > +       }
> > +
> > +       if (count >=3D 0xF) {
> > +               DBG("%s: Too large timeout 0x%x requested for DEADLOCK!=
\n",
> > +                   mmc_hostname(host->mmc), count);
> > +               count =3D 0xE;
> > +       }
> > +       *dead_lock =3D count;
> > +
> > +       return count;
> > +}
> > +
> > +static void __sdhci_uhs2_set_timeout(struct sdhci_host *host)
> > +{
> > +       u8 cmd_res, dead_lock;
> > +
> > +       sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
> > +       cmd_res |=3D FIELD_PREP(SDHCI_UHS2_TIMER_CTRL_DEADLOCK_MASK, de=
ad_lock);
> > +       sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
> > +}
> > +
> > +void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_comman=
d *cmd)
> > +{
> > +       __sdhci_set_timeout(host, cmd);
> > +
> > +       if (sdhci_uhs2_mode(host))
> > +               __sdhci_uhs2_set_timeout(host);
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * MMC callbacks                                                      =
       *
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs=
2.h
> > index 8253d50f7852..ccf4e1834c2d 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -175,9 +175,11 @@
> >  #define SDHCI_UHS2_VENDOR_PTR                  0xE8
> >
> >  struct sdhci_host;
> > +struct mmc_command;
> >
> >  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> >  bool sdhci_uhs2_mode(struct sdhci_host *host);
> >  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> > +void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_comman=
d *cmd);
> >
> >  #endif /* __SDHCI_UHS2_H */
> > --
> > 2.25.1
> >
