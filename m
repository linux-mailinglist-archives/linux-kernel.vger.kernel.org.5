Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91BB764768
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjG0HAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbjG0HAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:00:49 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4CA1FCF;
        Thu, 27 Jul 2023 00:00:48 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7996e265b4dso273835241.2;
        Thu, 27 Jul 2023 00:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690441248; x=1691046048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szurb9/ckUdLu/OotxgRD5ZN7Pu8kYVUepKs+6ZOri4=;
        b=d8k7PgYtk+woepo9EcqydM+gK0Y/MrmqTqOwZWUud7zpBNETpQRZ5er79X6EEAQ6/w
         GhdeCzSUVOqSeUrdT2GHxWcHvi/d7gjjCRFWz31xvHak66sIS6UlZZ9Z9NlGxggiWzkg
         saOChlax74034EIfqM2v46szGwQqJXxmrcO2BkWoCT0vRc8vMOE29o4ohqdPubIgpsxg
         FzAit0d3zJJ0veQRWaQQZRBOC0xsz4+cQICTRbsIrV7y9GRDjCqg0d337q5QqwaVNTcQ
         x++iYJCk/AYW44OTAUEZgCaApIzPSiZwlamrkzNkLp1iEufLjM3aCz7Lg61jvZAANscr
         4NmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690441248; x=1691046048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szurb9/ckUdLu/OotxgRD5ZN7Pu8kYVUepKs+6ZOri4=;
        b=GUemsrcSqLrQ0XoJvBaT4bx+II8hiMzAVtirf/9Ej3cQgvKYBef8Cqzl/3DCnNLr1r
         anuVms5ML9vh6mjbFNKCFr61YgXcts/Fb6uyPgmh+z23OV8KDVhFAIZ7Ugxiw7k5UEFZ
         Y15czAbLDLPqnknjd7Lt4vnyuNjrxMMfPVmYlCO/zWcQiX9rzKat2sFw93dF3hA+kNl+
         hfi3ZDuki9gEGYNvbqF5Bo0bdlB4axw4gZRpaxLxa0SD5l0Fw8mBK2nMP5x2Nsky2m5D
         q/fbpqGcyGVmrZQRGgMICsDO8Mi6ZiZyjDSBtvrvD+LmPTkLfywlzKZnJEmH6+Ip3mly
         jdkg==
X-Gm-Message-State: ABy/qLY/eSUZlPZ8I/CYvPAm5v8s0+HUuQsEInDPGOL//MmQd6AfmdAm
        d3XRnFZ0HJBOoHnIeKbq5PqhegoLCykWX+xcDEI=
X-Google-Smtp-Source: APBJJlGlvpDnzg9zPgWbgtsTGIPKZe3AtVPLr5UyKrAOD5duEbmeJtzRrgjtzpfMHKgMdVPuNq5Nj+/LFRk8hqQNvHI=
X-Received: by 2002:a1f:60d8:0:b0:44f:e6ff:f30e with SMTP id
 u207-20020a1f60d8000000b0044fe6fff30emr660141vkb.10.1690441247706; Thu, 27
 Jul 2023 00:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230721131157.26640-1-aboutphysycs@gmail.com>
 <ZLqu56eHfpc0TnMw@smile.fi.intel.com> <ZL/L1tiKjLDP5bet@smile.fi.intel.com>
In-Reply-To: <ZL/L1tiKjLDP5bet@smile.fi.intel.com>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Thu, 27 Jul 2023 09:00:36 +0200
Message-ID: <CABgxDoL4ftygpXKKuRoAKJ41KRTLQZr-YOiWLC5pM96-qe_=eQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: msc313: remove unnecessary call to platform_set_drvdata()
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, brgl@bgdev.pl,
        linus.walleij@linaro.org, daniel@thingy.jp,
        Alexandru Ardelean <alex@shruggie.ro>
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

Hi,

The private data is "struct msc313_gpio *gpio". This private data is
"binded" to the gpio_chip via devm_gpiochip_add_data, right ?
Then it is retrieved via gpiochip_get_data(chip), right ?

Romain

Le mar. 25 juil. 2023 =C3=A0 15:22, Andy Shevchenko <andy@kernel.org> a =C3=
=A9crit :
>
> On Fri, Jul 21, 2023 at 07:14:31PM +0300, Andy Shevchenko wrote:
> > On Fri, Jul 21, 2023 at 04:11:57PM +0300, Andrei Coardos wrote:
> > > This function call was found to be unnecessary as there is no equival=
ent
> > > platform_get_drvdata() call to access the private data of the driver.
>
> Not true.
>
> > > Also, the private data is defined in this driver, so there is no risk=
 of
> > > it being accessed outside of this driver file.
> >
> > Reviewed-by: Andy Shevchenko <andy@kernel.org>
>
> I have to withdraw this, the patch is wrong.
> NAK.
>
> Sorry for the confusion (I have looked for the wrong pattern).
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
