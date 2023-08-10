Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740637770E7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjHJHDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjHJHDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:03:36 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EBC1BCF;
        Thu, 10 Aug 2023 00:03:35 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-94ea38c90ccso15101666b.1;
        Thu, 10 Aug 2023 00:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691651014; x=1692255814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZOoGUy+M48dRvTuWKMo+NT+ma4Ps8H2dN2+7+Y41ec=;
        b=jBxiPDUwFzvy3lK1UWszcHDZyf/+fRtuEfekp2QxAOKGOH7UuDNFsb3A1IN7dgLcE8
         VmJBwAulQVeY6kBgro5SCFZhq8ZPfaOaDQTCTPZk5eVQIehNnqV7H4sxcB22+PXtul78
         U/ySswk0/V0mQ5K3uIKH69De7tYGlcNAyD/llBExcp0J1a0Z44XgKm2rsKJZnh9UMBd/
         2nQYEcOke4A+woa6sSQVeX0y7w7IbE6G1+5wa/Lp/gyPIiCi1SD8biEof6p6ILrfkMBD
         LGNoxeQmV8rKKzRSOGU8mMlKr58Gw4URlsywSH+0h4h0Qfq1Xr2GVhlqdSF7Lm1+yOTK
         Vxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691651014; x=1692255814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZOoGUy+M48dRvTuWKMo+NT+ma4Ps8H2dN2+7+Y41ec=;
        b=Dajl0XzNtuBKSin3fkUtvZRJJ/HX7j69InxVOM/cH6YUE0EHsw+wOb/Iw7T5fwgBGE
         MptnZpN9uCftX51TH6NXH2dmGcAWKDXssNwMvkqTptFcKjuvN+ccwMqA1NuxQibaSR4h
         ODk/fipw9ObonD5ShTbM1cLnj60/sXwuANZFkfqddfeh4iRSjBo4f/VxV4StdHo693gf
         itcUjnnOYihSjIPgLcj2S5yPOeLZItyl5iUvWxW2oV0KgsKt/ybMYrkWUpHV5rhddalK
         pZy+y0qz5YGNtNXHioItfTSpjghPYLSrRQPX5WE2fWY31ikSzMCkCP7bCvEilZ8okSCE
         FSrg==
X-Gm-Message-State: AOJu0YxEWDMhOyLsTx6dYxu/JS13eR1mULUKVlsO3qx1Y7fOxm2m/vLX
        CQ/UZGEYa+D5S8TFk6bBfb3WnUWaBmWv+7bhqz8=
X-Google-Smtp-Source: AGHT+IGY44kQ48crfNMp2RcsiBQGyOQwIkuRiZDemi3AexWGTSJDDtIP0LB3xWehL5/bE46BNZswGnA2Bh7Ix/cMzRY=
X-Received: by 2002:a17:906:209e:b0:993:d90e:3101 with SMTP id
 30-20020a170906209e00b00993d90e3101mr1081927ejq.1.1691651013620; Thu, 10 Aug
 2023 00:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230808033130.2226-1-Wenhua.Lin@unisoc.com> <ZNJBrnKGVGXaFAtc@smile.fi.intel.com>
In-Reply-To: <ZNJBrnKGVGXaFAtc@smile.fi.intel.com>
From:   wenhua lin <wenhua.lin1994@gmail.com>
Date:   Thu, 10 Aug 2023 15:03:21 +0800
Message-ID: <CAB9BWhdYUcnkwqFQz+e8dK-_Vv6on=Poo8QmKrk55c+zrQ4-mw@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: sprd: In the sleep state, the eic dbnc clk must
 be forced open
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 9:23=E2=80=AFPM Andy Shevchenko <andy@kernel.org> wr=
ote:
>
> On Tue, Aug 08, 2023 at 11:31:30AM +0800, Wenhua Lin wrote:
> > In the sleep state, Eic dbnc has no clock and the clk enable
>
> Comma is not needed here.

Hi Andy:
We will make changes in patch v2.

Thanks
Wernhua.Lin

>
> > of dbnc needs to be forced open, so that eic can wake up normally.
>
> ...
>
> > +#define SPRD_EIC_DBNC_FORCE_CLK              0x8000
>
> BIT(15) ?

Hi Andy:
Yes, The bit15 is clock of dbnc forced open

Thanks
Wernhua.Lin

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
