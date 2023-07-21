Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D7C75CB3A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjGUPPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjGUPPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:15:16 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C2F2733;
        Fri, 21 Jul 2023 08:14:54 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fcd615d7d6so3314354e87.3;
        Fri, 21 Jul 2023 08:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689952489; x=1690557289;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iInWzg4Aa37bAKJaNWT3bREiveHBzs5+RriIq+gc+lc=;
        b=Qc9w+qM2LK7YpY+WDNtPCnIK3VFn/Icb98FXoofzbjUF6GhqHu40VZ/zJ4RmZzjJ24
         SdvCZ7Ig2a+VgOy5tHK5Ms8MndvOacEiSZOqwK2ybvMPHfA5cssapzYFNcqFzKaEucF8
         d+QfSsmnL0r3DlflL6qmQxouoRkvbDI5pQxkdqbRMzsreDGXb+FpYT2T3IuUMwLhOcE2
         /d87AUfmYcw37MsVvV8r4OJm8Y2NCsfIIvY02h7BThXnSCLVb5Qfz/fE2vRdB79JErNb
         zNTncv5nJe/c/b4LbKdbxeriFOXsxanzzm7qoXAL4qVEqbZ13lJ3m3zDpF2EEZ/FIFGT
         WPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689952489; x=1690557289;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iInWzg4Aa37bAKJaNWT3bREiveHBzs5+RriIq+gc+lc=;
        b=NUbt/gk2DC0McqxlYfvUuJOnDS1VsIlBrEz6CjWO6K1dQjPdkaY124T+WafU6Y3zbJ
         UlZvIxfyUF28qYfvt9mTRSdNSECKVgYYaZuAz7D9oC3xq7IirLvjwhlrjEpGzpYRlyR8
         f0VZw+XoGTjlq9Fspwf/m3zTBTM6c/QC5lT51FN+T18W0PE8QZzrOV5EESUG3589jKFG
         uHx+bTnlBa8ptHP+D6+uniiGNgnXHj5Gn4+m6GpZk59m89Cow5Ody/5/7b7qJ2HhgL69
         t2UO4dvIzCzHeeid690V/Yls9wJHru5brYqRSZ63M4bLWIgrXR8KfUWuMskJBCX17p4j
         GyWw==
X-Gm-Message-State: ABy/qLbI74HZYcZA3X4BUxz+IYOyPvtZir2Jn6o7bNc/mig/oupMSFci
        g/rxFuyPLzS7HlE3aZbFQOprZXQYxQ8=
X-Google-Smtp-Source: APBJJlGh0FZwd4kB6nvlAofXkj84MuWqZA0k4+R+PRVca34RmuYNsFTmOB/feQJ1iNWdY1WWAR5r9w==
X-Received: by 2002:a05:6512:3154:b0:4fb:8fe3:9266 with SMTP id s20-20020a056512315400b004fb8fe39266mr1371631lfi.0.1689952489300;
        Fri, 21 Jul 2023 08:14:49 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id d2-20020a50fb02000000b0051e28d315a2sm2240569edq.78.2023.07.21.08.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:14:48 -0700 (PDT)
Date:   Fri, 21 Jul 2023 17:14:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] firmware: Explicitly include correct DT includes
Message-ID: <ZLqg5g5cmx8gX9E1@orome>
References: <20230714174438.4054854-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pZkSdwRWU+4W2YBg"
Content-Disposition: inline
In-Reply-To: <20230714174438.4054854-1-robh@kernel.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pZkSdwRWU+4W2YBg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 11:44:37AM -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/firmware/arm_scmi/driver.c | 4 ++--
>  drivers/firmware/imx/imx-dsp.c     | 1 -
>  drivers/firmware/imx/imx-scu-irq.c | 1 +
>  drivers/firmware/imx/imx-scu.c     | 1 +
>  drivers/firmware/mtk-adsp-ipc.c    | 1 -
>  drivers/firmware/raspberrypi.c     | 1 +
>  drivers/firmware/scpi_pm_domain.c  | 3 ++-
>  drivers/firmware/stratix10-rsu.c   | 1 -
>  drivers/firmware/tegra/bpmp.c      | 3 +--
>  drivers/firmware/xilinx/zynqmp.c   | 1 +
>  10 files changed, 9 insertions(+), 8 deletions(-)

Not sure about the other maintainers, but I usually pick up
firmware/tegra patches up through the Tegra tree and then they
ultimately go through ARM SoC.

Arnd, Olof, does it make sense for you guys to pick this up directly?

Thierry

--pZkSdwRWU+4W2YBg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS6oOYACgkQ3SOs138+
s6G8XRAArwU2xjyoHeBc/G3KsTP4njY3K49dPk0+F+Cvpdb0ZrZHV0g7+S8cvJTA
J0ludetXwP0bhB0TYIoTEzMbJUIk9n7Lz4Y8LKWfKPNxQCp/IxRyac2O/gUaLFLL
8mUdi+yudTE9C7ur0utsrLqYr0XFlVf7MesTILteNiuSwynfaMR9Lf0eWO4iHHwO
dZiqJ8BJafMh9RYS+A1phmVMSg3S8fj9XGP0L/c7UhrH/7eY1qKJKfzbB1eUUDHV
Mb5Yhz909tafjnmxMB32ZgbjfGKczKwJh7aoQqZHeVWkwk3BG7UlhM7WAchsdHNN
NFQwXOBI42fmLQY7TeUN8TIds23X9LcxVH42iyze2xU/Vh/ypqu/6+OTsDSxnGMJ
Pbv7dEYG961lscfL2hUiKi9/2hnJQc8oBtfyQ68GKei4Ahmi7EAm5b16pi0GvEm0
YzCOghyrBkts+jPKPbhw4puYMlXa8S77h3tCM9j5S0i78TS6TSv4KeGjsD0ZJQeJ
qR9enoY89rtP7LPZ8zrORanG1HX3zqBGubiBy+5Ta41cZCNGRu0HUYQPl6tHHDrm
ziwX7+oCzr5BIoJZzLehl1Cs12QRTwoSzDC4M/BC3hWibyq7gi3wI1vLLr7uZkbo
coe6QabcbFkT9/+Ssaz2n0J983DpnISyMeaUp27ADlhEZ0+aYm4=
=hMKr
-----END PGP SIGNATURE-----

--pZkSdwRWU+4W2YBg--
