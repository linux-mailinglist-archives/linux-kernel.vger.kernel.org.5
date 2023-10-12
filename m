Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CA77C774D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442911AbjJLTtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442807AbjJLTtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:49:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FB210A;
        Thu, 12 Oct 2023 12:48:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC89C433C9;
        Thu, 12 Oct 2023 19:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697140137;
        bh=3Byp5b3Zb8b/69+S7rphD/W+vP3c+F3aSXr9d0KNxac=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j0lc9uQuFkJEnhdhbKskXhXiPdyR7L4wIxV9vfe9+TRveg4bp6wESNrLcPyvu4mkX
         8ANQHGY459r846QvjlaB6EkFsIIlFeR4LNXqlH0sk5uNkaW2vwzYkgnYZ2GC7Xji6d
         3NpwNOWXUy/KZ0BpcbGHXpo3GOeZY1aJkSvoD4u26/Lsz9b2uFUHykqYSZ/bk8k2aS
         W/fr2QUaEQNyInaQoujEAL440+/Tt1EIs2Q0JUroSVnccY9Stdto1lXs9kSfEPU11v
         d05j/adkx2A05wDPZeyX5mAOHANCrWKg+iJQMhK8vmgRGNYM0hom2YgKxJJhS6X7wt
         KILrACHM8ELNw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5056ca2b6d1so1536465e87.1;
        Thu, 12 Oct 2023 12:48:57 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy5YoaasPFlM17JvMhV4m9qLTTlZ/oxbJJ/7uxjrUDH3pBtvGrz
        2pD+JulkbaLAOenudkN5ILP+x9mnnzlMc0dHNg==
X-Google-Smtp-Source: AGHT+IE6i/97MyLQA7ZbK47ucq4ZJGOCSR0LJAcGu5uMBt2RpnxvxCFfNmQpF9VC84YVsJh1VJBcl9DS5+FXMUOvPiY=
X-Received: by 2002:a05:6512:a90:b0:500:acae:30c5 with SMTP id
 m16-20020a0565120a9000b00500acae30c5mr15206735lfu.15.1697140135825; Thu, 12
 Oct 2023 12:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231009172923.2457844-22-robh@kernel.org> <20231011084117.jvfl7xmbcgsu7uyl@pengutronix.de>
In-Reply-To: <20231011084117.jvfl7xmbcgsu7uyl@pengutronix.de>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 12 Oct 2023 14:48:43 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq++418hPW=wSGWipbC6vodYvKiDUQNMAm22g5X6k-to-A@mail.gmail.com>
Message-ID: <CAL_Jsq++418hPW=wSGWipbC6vodYvKiDUQNMAm22g5X6k-to-A@mail.gmail.com>
Subject: Re: [PATCH] pwm: pxa: Explicitly include correct DT includes
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 3:41=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Mon, Oct 09, 2023 at 12:29:17PM -0500, Rob Herring wrote:
> > The DT of_device.h and of_platform.h date back to the separate
> > of_platform_bus_type before it as merged into the regular platform bus.
> > As part of that merge prepping Arm DT support 13 years ago, they
> > "temporarily" include each other. They also include platform_device.h
> > and of.h. As a result, there's a pretty much random mix of those includ=
e
> > files used throughout the tree. In order to detangle these headers and
> > replace the implicit includes with struct declarations, users need to
> > explicitly include the correct includes.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/pwm/pwm-pxa.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
> > index 1e475ed10180..78b04e017c49 100644
> > --- a/drivers/pwm/pwm-pxa.c
> > +++ b/drivers/pwm/pwm-pxa.c
> > @@ -24,7 +24,7 @@
> >  #include <linux/clk.h>
> >  #include <linux/io.h>
> >  #include <linux/pwm.h>
> > -#include <linux/of_device.h>
> > +#include <linux/of.h>
>
> Even without both headers the driver compiles fine as linux/pwm.h
> includes of.h.

Yes, that's just one of several:

 include/linux/pm_domain.h  | 4 +++-
 include/linux/remoteproc.h | 3 ++-
 include/linux/thermal.h    | 4 +++-
 include/linux/cpu_cooling.h                | 1 -
 include/linux/fsl/bestcomm/bestcomm_priv.h | 1 -
 include/linux/mailbox_client.h             | 4 ++--
 include/linux/mailbox_controller.h         | 2 +-
 include/linux/phy/phy.h                    | 5 +++--
 include/linux/pwm.h                        | 4 +++-
 include/net/dsa.h                          | 2 +-

>
> I think we should do:
>
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index d2f9f690a9c1..9e35970ca2ab 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -4,8 +4,8 @@
>
>  #include <linux/err.h>
>  #include <linux/mutex.h>
> -#include <linux/of.h>
>
> +struct of_phandle_args;

Also used in the header:

+struct device;
+struct fwnode_handle;

>  struct pwm_chip;
>
>  /**
>
> drivers/pmw/* compiles fine with this change.

Agreed in what I tested so far.

But I'm running out of gas on doing more of this, so once I get
of_device.h and of_platform.h detangled, I'm probably done for a while
at least. IOW, feel free to submit a patch for pwm.h.

>
> Other than that:
>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Thanks!

Rob
