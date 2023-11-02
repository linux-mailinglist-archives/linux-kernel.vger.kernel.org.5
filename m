Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A957DF838
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377110AbjKBRBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKBRBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:01:09 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BD7128;
        Thu,  2 Nov 2023 10:01:07 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7789923612dso66763185a.0;
        Thu, 02 Nov 2023 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698944466; x=1699549266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTxptEaM8979RB2moFmyeo+7XRZYQ4vxqFOGVqKS7Wg=;
        b=PYE/rkd3yn7vKc76PWoR/J7ya33sc3iFf4q4SYe9u3f29EanewKZyfrXHdvgByN6xK
         1O9z14neGwGupdX3wOATCJNMmbkBAn94rogDq+PkpO+7HF+UnrgrZy7f4QdMxUU9v3Jl
         WFWaKCGQhcf6TTctH+jUSUzlbvnkmPD+Y8qRdRJ2GGA9Ef2z+NGtUxgPF6Eq/sA9bMqI
         dakdvyZ1RHKjEqbqTkcyQuJ5M7yCpa3w251teM1r04SBXG049G5m6U7eh4Eepqv933LR
         S4LXszIWA90yYLyrN2IkORapjfUKZDpC7EBbhKrVrgvA5iplrfUmmZG14Gio9nzi+wP3
         3fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698944466; x=1699549266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTxptEaM8979RB2moFmyeo+7XRZYQ4vxqFOGVqKS7Wg=;
        b=i2ElRz2XNUW1Dawn028DQ0kxKJ1d8knVOlbHbcbTgIECFHDbT/gm7IiQ5vEz+y4kTq
         Yd7ltoyOz5kYx/M4cVIN9zLxmHFZrebX1DrtZ9bn76HMbXKE7Dd+uU55Z6HDl5BN3drT
         SjWdrUiSKPaV7311vM359OG9s4zmx3aCMHlVrI9kFZdsWelmfzTAhAxwb5xioqKIrula
         J/b94VYigChDzI+aMbMJ9yewXAjFFoITevawJPLp94NISQqWIkgUwHHOtlgXeJvJ3GMk
         25MnygVwXiy6LWAL44GqPMU9lz71+VslIqarI7WoRai75+v4A0eUcnovshH9qhrQKJp1
         Wx0g==
X-Gm-Message-State: AOJu0YwcoxM+vNHyHoWiV6au9vVyNtwZpplSnk7G9JfBknkc3nrAyiuR
        T0SbIjCVfLBQ7j+BqmFiw5XzlImJ++UA9y31hq4=
X-Google-Smtp-Source: AGHT+IF3vPxokOJCHMExtd+el+F7/t9JBx6BxPtcEy4IDJhK3K14PaLYpFmDiBxBMGhtLqTfg3sNTuGCo6nNljKy69E=
X-Received: by 2002:ad4:5bcc:0:b0:65d:1270:6846 with SMTP id
 t12-20020ad45bcc000000b0065d12706846mr21317065qvt.29.1698944466383; Thu, 02
 Nov 2023 10:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231102132616.1130960-1-eblanc@baylibre.com> <CAHp75VdvR0H7XVLWGqdZqSgoHprUUPQHGiyWEEaHjTgEbeinqQ@mail.gmail.com>
 <CWOGMAUT9MKY.2IBKELIOR1CF7@burritosblues> <CAHp75VdV5A+WpWj2eY9o_2wwPB7GTi6Eig7YyV8urdv1P3utgQ@mail.gmail.com>
 <2023110216503718884fde@mail.local>
In-Reply-To: <2023110216503718884fde@mail.local>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 2 Nov 2023 19:00:27 +0200
Message-ID: <CAHp75VcfKdeQeJRhyANhnwB2j-AikzNY1t_vr5=Qon1tdR6P2Q@mail.gmail.com>
Subject: Re: [PATCH v8] rtc: tps6594: Add driver for TPS6594 RTC
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Esteban Blanc <eblanc@baylibre.com>, a.zummo@towertech.it,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        jpanis@baylibre.com, jneanne@baylibre.com, u-kumar1@ti.com
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

On Thu, Nov 2, 2023 at 6:50=E2=80=AFPM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 02/11/2023 18:46:05+0200, Andy Shevchenko wrote:
> > On Thu, Nov 2, 2023 at 6:17=E2=80=AFPM Esteban Blanc <eblanc@baylibre.c=
om> wrote:
> > > On Thu Nov 2, 2023 at 5:00 PM CET, Andy Shevchenko wrote:
> > > > On Thu, Nov 2, 2023 at 3:26=E2=80=AFPM Esteban Blanc <eblanc@baylib=
re.com> wrote:
> > > >
> > > > > Notes:
> > > > >     This patch was picked from a series since there is no depende=
ncy between
> > > > >     the two patches.
> > > >
> > > > Not sure if RTC maintainer uses the b4 tool, but as I said in previ=
ous
> > > > email for pinctrl change, there is no need to resend. b4 has an
> > > > ability to select patches from the series to be applied.
> > >
> > > Oh that's good to know, I was not aware of that.
> > > I resent it because there was some minor nits that I fixed on both
> > > patches.
> >
> > Ah, that was not reflected in the changelog...
>
> For the record, I'm using b4 but it was not clear which path the patches
> would take.

You mean in the initial series? You take it by direct message-id with
-P _. Or did I misunderstand the problem?

--=20
With Best Regards,
Andy Shevchenko
