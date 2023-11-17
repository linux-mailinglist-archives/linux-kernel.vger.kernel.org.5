Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EB87EF117
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345992AbjKQKvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346094AbjKQKup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:50:45 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61065D57;
        Fri, 17 Nov 2023 02:50:33 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-4ac20c41e82so684094e0c.1;
        Fri, 17 Nov 2023 02:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700218232; x=1700823032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOnhfMhQ8ywLqjdb9/65uRtIbUiORGE+C3/Bf4quGCw=;
        b=ldE4EwcqbHvN+uMNqFPhdKRR0HVcsdQbxALMfJkmbG0xWWfym5Ex4he0wZAVm98I2c
         HGXLxoKPQ5FlbV8MFRU6NQ0hf+CxLCsP2U3W9IzMLocoMCArg5CterQ9ZYhmU89GWyk9
         R5aQB9ZdauhkVfIXSQRONlaWKePrqY8WBLTWnBXB5wxkmEt6ubzZESxCndBraSU7QeaD
         xA+Sg0yGWNeaCYtFw/iAHkufj85pxUl8xhFIWTWTWYK7feq7ZDGwLBUU1XhI/wMAQQN/
         L5KA8bpXuXG7snw+eBBLNfVl8uIBm3+TX05lfrbofjLaeS6bAlcOLMY6zoy49lizbGUk
         MOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700218232; x=1700823032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOnhfMhQ8ywLqjdb9/65uRtIbUiORGE+C3/Bf4quGCw=;
        b=dOBfn76UmPlG6tqSDYmJ2jcpE1sbxN1wlUqyImYz3YCPQ9H/TkdIIUVtYKOuRq9Wqv
         9GA67SW2qKSOFZge8QAq1jixBnTHUKUxVQ7z8IMnXvt99clduI2xq32i7ZfaRhbykVm3
         uC3TGN0a97wk9lSz7ElJx0nwUN2Pwq/dH49BPnWiXBuuASGTjlEg33P3V23c0Lj7MjFM
         5s+LYFTtCWNy5oxouJHBoj6mbbMgL9pSa7sgNjCanlZo5w+muRcLmG3zYFHQ4KZUAJqT
         9jTenaJO0F52AeXc1hMLT0Qj5UsQbDNCYLutkmP67tQxOLp9YmAwJzyeY0vPOZNm7P7V
         0ebA==
X-Gm-Message-State: AOJu0YwFe+I6c/XdzNqi2PMWKfjjqiLOwfssxc+bfizWFH9GzD2cg9it
        3TUXSIllPIAUlVGTMRbD3/wMIwbEr3dDkJWNyOYvOC7lSOA=
X-Google-Smtp-Source: AGHT+IEkZSbqoc7UsqoowK5CtgBgKiIpasDAKUE4zz/HcareLUHSCDhMJUn/3iyaudwpj8frX24fVPwtR/BiN6TPPu8=
X-Received: by 2002:a05:6122:3125:b0:4a4:cd2:5ebe with SMTP id
 cg37-20020a056122312500b004a40cd25ebemr20392885vkb.12.1700218231823; Fri, 17
 Nov 2023 02:50:31 -0800 (PST)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com>
 <20230915094351.11120-21-victorshihgli@gmail.com> <CAPDyKFr4C8woRLzzz9FnhDvL0n8RObHNWCTP3WYxvraVYWYWXA@mail.gmail.com>
In-Reply-To: <CAPDyKFr4C8woRLzzz9FnhDvL0n8RObHNWCTP3WYxvraVYWYWXA@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 17 Nov 2023 18:50:19 +0800
Message-ID: <CAK00qKBWv4=gnmULgHg-McOPgwqKp2eTPtW3vD6+dnyF_iAH9Q@mail.gmail.com>
Subject: Re: [PATCH V12 20/23] mmc: sdhci-uhs2: add add_host() and others to
 set up the driver
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

On Thu, Oct 5, 2023 at 7:39=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrot=
e:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > This is a UHS-II version of sdhci's add_host/remove_host operation.
> > Any sdhci drivers which are capable of handling UHS-II cards must
> > call those functions instead of the corresponding sdhci's.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> [...]
>
> Just a few nitpicks, see below.
>
> > +static void __sdhci_uhs2_add_host_v4(struct sdhci_host *host, u32 caps=
1)
> > +{
> > +       struct mmc_host *mmc;
> > +       u32 max_current_caps2;
> > +
> > +       mmc =3D host->mmc;
> > +
> > +       /* Support UHS2 */
> > +       if (caps1 & SDHCI_SUPPORT_UHS2)
> > +               mmc->caps2 |=3D MMC_CAP2_SD_UHS2;
> > +
> > +       max_current_caps2 =3D sdhci_readl(host, SDHCI_MAX_CURRENT_1);
> > +
> > +       if ((caps1 & SDHCI_CAN_VDD2_180) &&
> > +           !max_current_caps2 &&
> > +           !IS_ERR(mmc->supply.vmmc2)) {
> > +               /* UHS2 - VDD2 */
> > +               int curr =3D regulator_get_current_limit(mmc->supply.vm=
mc2);
>
> As I also stated in another reply, please use vqmmc2 instead, which we
> added in patch4.
>

Hi, Ulf

I will update this in version 13.

Thanks, Victor Shih

> > +
> > +               if (curr > 0) {
> > +                       /* convert to SDHCI_MAX_CURRENT format */
> > +                       curr =3D curr / 1000;  /* convert to mA */
> > +                       curr =3D curr / SDHCI_MAX_CURRENT_MULTIPLIER;
> > +                       curr =3D min_t(u32, curr, SDHCI_MAX_CURRENT_LIM=
IT);
> > +                       max_current_caps2 =3D curr;
> > +               }
> > +       }
> > +
> > +       if (!(caps1 & SDHCI_CAN_VDD2_180))
> > +               mmc->caps2 &=3D ~MMC_CAP2_SD_UHS2;
> > +}
> > +
> > +static int sdhci_uhs2_host_ops_init(struct sdhci_host *host);
>
> Please try to re-order the code so this declaration isn't needed.
>

Hi, Ulf

I will update this in version 13.

Thanks, Victor Shih

> > +
> > +static void __sdhci_uhs2_remove_host(struct sdhci_host *host, int dead=
)
> > +{
> > +       if (!sdhci_uhs2_mode(host))
> > +               return;
> > +
> > +       if (!dead)
> > +               sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_FULL);
> > +}
> > +
>
> [...]
>
> Kind regards
> Uffe
