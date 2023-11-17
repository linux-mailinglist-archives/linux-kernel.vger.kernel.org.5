Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F47C7EF112
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346038AbjKQKug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346015AbjKQKu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:50:26 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D2C171A;
        Fri, 17 Nov 2023 02:50:21 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-45d94e7759eso698501137.1;
        Fri, 17 Nov 2023 02:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700218220; x=1700823020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8WmvwzndIJ2FpexH1Q5hm/dVIrzFnnnzQRgY3kslO4=;
        b=FrIjm3Pm/+QsD7LKlmmNDIJ9XOk2ksUFT+Z46EsV5HZpE3lj2ZHOLKK5GVkO8Ytt91
         UjlvgbYJBwkT7Ajadxv9lS5EQtD0ZawOi2HN0yQf8MjXJPHs34I7MWsgKfY9BlFQe1kF
         VIzy+jEA4x0cs3UjYm+xnPkSQ1eMkYobf8MBDwtFRlU7Y4mim7+NbIPFwhmTnfbUoTQS
         OrEZIW9B8SuGBhW3srDQQtXHunqnRdLEASf7snga3Tf1F/pSa9GFoad/7yGQRlrxqZ6W
         nfsiL3H1HBYxR4FClxz4E8oiuaxl73jtcBAsgUc6/xdMLOa08GIGJbyqP5j2LNwKgRVZ
         GuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700218220; x=1700823020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8WmvwzndIJ2FpexH1Q5hm/dVIrzFnnnzQRgY3kslO4=;
        b=JNgyYTcMm+CpQ7AG5PrhTFgodAkmnJSqjQkHkoze3gZM2BxGTaeXtWpayurUtOIB0d
         kTjIbcnASe94aiAnVzMIRXvr8iypn6/fZKdlksJlHSHAKrx6Q9qaOWfGmqy0OV8qSKYM
         7lXOopiVomwVtTUaE9VOLkguyUTJO7ZYLRQOkxx9RIxwWDB+mcifR4wSKhuq+og9Ad5Y
         fkxucoNEOhzPcgdKye5vkBbroZmQR7KwiX3ZFgR1UaaZrgY8D2EG5V432pzDiqTgWS0H
         d7YrE0WFvJluwKpsNq5WBVHnh9hwfC5Xwy4eLC8f1K+3a0OQSjlHHFswyyRTAJqMoRBz
         64YA==
X-Gm-Message-State: AOJu0YzfGQf6Qn2zqfkV192LTRSmVyN5J1uDs1xa2hrpzDrOHqGVJkcq
        02/atPGXYBoIsVuZbJcz7q//djXyTJ9XpNPA7rQ=
X-Google-Smtp-Source: AGHT+IEoTERJfg9M+q5VkePSlaz+Ski71DVnwWS4QP1EnAMHozwLXmGGKG3y9jXgpzgN7FGKhqMoeuHS3CAFnWy7x78=
X-Received: by 2002:a67:c10d:0:b0:457:ddde:ba45 with SMTP id
 d13-20020a67c10d000000b00457dddeba45mr18009149vsj.14.1700218220264; Fri, 17
 Nov 2023 02:50:20 -0800 (PST)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com>
 <20230915094351.11120-17-victorshihgli@gmail.com> <CAPDyKFoeBgoEyCg8GmZB718g1dg8dqi_kdLr-jLqWdEE5q4Oyg@mail.gmail.com>
In-Reply-To: <CAPDyKFoeBgoEyCg8GmZB718g1dg8dqi_kdLr-jLqWdEE5q4Oyg@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 17 Nov 2023 18:50:08 +0800
Message-ID: <CAK00qKBdkn2zqZx6Z-NO4Kx5GV4S94Wt3h1McZSJTqA7KcKhcQ@mail.gmail.com>
Subject: Re: [PATCH V12 16/23] mmc: sdhci-uhs2: add clock operations
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

On Tue, Oct 3, 2023 at 7:13=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrot=
e:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > This is a sdhci version of mmc's uhs2_[enable|disable]_clk operations.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> The similar comments as posted for patch 15 applies to $subject patch
> too. Please have a look at those and fix these for the $subject patch
> too.
>

Hi, Ulf

I will merge patch#15, patch#16 and patch#17 into one patch(patch#15)
for version 13.

Thanks, Victor Shih

> > ---
> >
> > Updates in V8:
> >  - Remove unnecessary include file.
> >  - read_poll_timeout() to instead of read_poll_timeout_atomic()
> >    in sdhci_uhs2_enable_clk().
> >  - Put the comment on the end and put the lines in descending
> >    line length in sdhci_uhs2_enable_clk().
> >  - Modify return value in sdhci_uhs2_enable_clk().
> >
> > Updates in V6:
> >  - Remove unnecessary functions.
> >
> > ---
> >
> >  drivers/mmc/host/sdhci-uhs2.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index 4c2a56629ab3..af1b0c5e48fd 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -329,6 +329,36 @@ static int sdhci_uhs2_set_ios(struct mmc_host *mmc=
, struct mmc_ios *ios)
> >         return 0;
> >  }
> >
> > +static int sdhci_uhs2_disable_clk(struct mmc_host *mmc)
> > +{
> > +       struct sdhci_host *host =3D mmc_priv(mmc);
> > +       u16 clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +
> > +       clk &=3D ~SDHCI_CLOCK_CARD_EN;
> > +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > +
> > +       return 0;
> > +}
> > +
> > +static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
> > +{
> > +       struct sdhci_host *host =3D mmc_priv(mmc);
> > +       u16 clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +       int timeout_us =3D 20000; /* 20ms */
> > +       u32 val;
> > +
> > +       clk |=3D SDHCI_CLOCK_CARD_EN;
> > +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > +
> > +       if (read_poll_timeout(sdhci_readw, val, (val & SDHCI_CLOCK_INT_=
STABLE),
> > +                             10, timeout_us, true, host, SDHCI_CLOCK_C=
ONTROL)) {
> > +               pr_err("%s: Internal clock never stabilised.\n", mmc_ho=
stname(host->mmc));
> > +               sdhci_dumpregs(host);
> > +               return -EIO;
> > +       }
> > +       return 0;
> > +}
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * Driver init/exit                                                   =
       *
>
> Kind regards
> Uffe
